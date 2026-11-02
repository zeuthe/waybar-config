#!/usr/bin/env bash
# Install waybar-config into ~/.config/waybar (with a backup of the old one).
set -euo pipefail

SRC="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DEST="${XDG_CONFIG_HOME:-$HOME/.config}/waybar"
STAMP="$(date +%Y%m%d-%H%M%S)"

echo "==> Installing waybar config to $DEST"

if [ -e "$DEST" ] || [ -L "$DEST" ]; then
  BACKUP="$DEST.bak.$STAMP"
  mv "$DEST" "$BACKUP"
  echo "==> Backed up existing config to $BACKUP"
fi

mkdir -p "$DEST/scripts"
cp "$SRC/config" "$SRC/style.css" "$SRC/macchiato.css" "$DEST/"
cp "$SRC/scripts/uptime.sh" "$DEST/scripts/"
chmod +x "$DEST/scripts/uptime.sh"

echo "==> Done. Restart the bar with:  killall waybar && waybar &"
