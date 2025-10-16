for f in "Part 1 2025-08.pdf" "Part 2 2025-08.pdf"; do
  pid=$(smbstatus --locks | awk -v f="$f" 'BEGIN{IGNORECASE=1} index($0,f){print $1; exit}')
  if [ -n "$pid" ]; then
    echo "$f"
    smbstatus --processes | awk -v p="$pid" '$1==p{print "  PID: "$1"\n  User: "$2"\n  Client: "$4}'
    echo
  else
    echo "$f  (no active lock found)"
  fi
done
