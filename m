From: Jeff King <peff@peff.net>
Subject: [PATCH] git-status: colorize status output
Date: Fri, 4 Aug 2006 23:14:19 -0400
Message-ID: <20060805031418.GA11102@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 05 05:14:58 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G9Ccf-0005vu-Eo
	for gcvg-git@gmane.org; Sat, 05 Aug 2006 05:14:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422722AbWHEDOW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 4 Aug 2006 23:14:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422723AbWHEDOW
	(ORCPT <rfc822;git-outgoing>); Fri, 4 Aug 2006 23:14:22 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:24225 "HELO
	peff.net") by vger.kernel.org with SMTP id S1422722AbWHEDOW (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 4 Aug 2006 23:14:22 -0400
Received: (qmail 16461 invoked from network); 4 Aug 2006 23:13:45 -0400
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by 66-23-211-5.clients.speedfactory.net with SMTP; 4 Aug 2006 23:13:45 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri,  4 Aug 2006 23:14:19 -0400
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24875>

The git-status output can sometimes be very verbose, making it difficult to
quickly see whether your files are updated in the index. This adds 4 levels
of colorizing to the status output:
  - general header (defaults to normal white)
  - updated but not committed (defaults to green)
  - changed but not updated (defaults to red)
  - untracked files (defaults to red)
The idea is that red things indicate a potential mistake on the part of the
user (e.g., forgetting to update a file, forgetting to git-add a file).

This patch also has a few minor output related cleanups. Untracked files are
now displayed using the 'report' function (marked with the character 'O').
The report function now uses a simple hdr_shown variable instead of
flip-flopping the header and trailer, which was somewhat difficult to read.

Color support is controlled by status.color and status.color.*. There is no
command line option, and the status.color variable is a simple boolean (no
checking for tty output).

Signed-off-by: Jeff King <peff@peff.net>
---
 Documentation/config.txt |   12 ++++++
 git-commit.sh            |   99 ++++++++++++++++++++++++++++++----------------
 2 files changed, 77 insertions(+), 34 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index d89916b..83f4627 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -222,6 +222,18 @@ showbranch.default::
 	The default set of branches for gitlink:git-show-branch[1].
 	See gitlink:git-show-branch[1].
 
+status.color::
+	A boolean to enable/disable color in the output of
+	gitlink:git-status[1]. Defaults to false.
+
+status.color.<slot>::
+	Use customized color for status colorization. `<slot>` is
+	one of `header` (the header text of the status message),
+	`updated` (files which are updated but not committed),
+	`changed` (files which are changed but not updated in the index),
+	or `untracked` (files which are not tracked by git). The values of
+	these variables may be specified as in diff.color.<slot>.
+
 tar.umask::
 	By default, gitlink:git-tar-tree[1] sets file and directories modes
 	to 0666 or 0777. While this is both useful and acceptable for projects
diff --git a/git-commit.sh b/git-commit.sh
index 4cf3fab..b7269c2 100755
--- a/git-commit.sh
+++ b/git-commit.sh
@@ -10,15 +10,49 @@ SUBDIRECTORY_OK=Yes
 git-rev-parse --verify HEAD >/dev/null 2>&1 || initial_commit=t
 branch=$(GIT_DIR="$GIT_DIR" git-symbolic-ref HEAD)
 
+color=false
+color_header=normal
+color_updated=green
+color_changed=red
+color_untracked=red
+
 case "$0" in
 *status)
 	status_only=t
-	unmerged_ok_if_status=--unmerged ;;
+	unmerged_ok_if_status=--unmerged
+	color=`git-repo-config --bool --get status.color`
+	eval `git-repo-config --get-regexp status.color. \
+	      | while read k v; do
+	          echo color_${k#status.color.}=$v
+	        done`
+	;;
 *commit)
 	status_only=
 	unmerged_ok_if_status= ;;
 esac
 
+color() {
+	case "$color" in true) ;; *) return ;; esac
+	case `eval "echo \\$color_$1"` in
+	  normal) ;;
+	  bold)    printf '\033[1m' ;;
+	  red)     printf '\033[31m' ;;
+	  green)   printf '\033[32m' ;;
+	  yellow)  printf '\033[33m' ;;
+	  blue)    printf '\033[34m' ;;
+	  magenta) printf '\033[35m' ;;
+	  cyan)    printf '\033[36m' ;;
+	esac
+}
+
+uncolor() {
+	case "$color" in true) ;; *) return ;; esac
+	case "$1" in
+	  normal) ;;
+	  *) printf '\033[m' ;;
+	esac
+}
+
 refuse_partial () {
 	echo >&2 "$1"
 	echo >&2 "You might have meant to say 'git commit -i paths...', perhaps?"
@@ -33,30 +67,32 @@ save_index () {
 }
 
 report () {
-  header="#
-# $1:
-#   ($2)
-#
-"
-  trailer=""
+  hdr_shown=0
   while read status name newname
   do
-    printf '%s' "$header"
-    header=""
-    trailer="#
-"
+    case "$hdr_shown" in
+      0) color header; echo "# $2:"; uncolor header
+         color header; echo "#   ($3)"; uncolor header
+	 color header; echo "#"; uncolor header
+	 hdr_shown=1
+	 ;;
+    esac
+    color header; printf '#\t'; uncolor header
     case "$status" in
-    M ) echo "#	modified: $name";;
-    D*) echo "#	deleted:  $name";;
-    T ) echo "#	typechange: $name";;
-    C*) echo "#	copied: $name -> $newname";;
-    R*) echo "#	renamed: $name -> $newname";;
-    A*) echo "#	new file: $name";;
-    U ) echo "#	unmerged: $name";;
+    M ) color $1; echo "modified: $name"; uncolor $1;;
+    D*) color $1; echo "deleted:  $name"; uncolor $1;;
+    T ) color $1; echo "1change: $name"; uncolor $1;;
+    C*) color $1; echo "copied: $name -> $newname"; uncolor $1;;
+    R*) color $1; echo "renamed: $name -> $newname"; uncolor $1;;
+    A*) color $1; echo "new file: $name"; uncolor $1;;
+    U ) color $1; echo "unmerged: $name"; uncolor $1;;
+    O ) color $1; echo "$name"; uncolor $1;;
     esac
   done
-  printf '%s' "$trailer"
-  [ "$header" ]
+  case "$hdr_shown" in
+    1) color header; echo '#'; uncolor header;;
+  esac
+  test "$hdr_shown" = 0
 }
 
 run_status () {
@@ -109,7 +145,7 @@ run_status () {
 		    s/\\/\\\\/g
 		    s/ /\\ /g
 	    ' |
-	    report "Updated but not checked in" "will commit"
+	    report updated "Updated but not checked in" "will commit"
 	    committable="$?"
 	else
 	    echo '#
@@ -121,7 +157,7 @@ #'
 		    s/ /\\ /g
 		    s/^/A /
 	    ' |
-	    report "Updated but not checked in" "will commit"
+	    report updated "Updated but not checked in" "will commit"
 
 	    committable="$?"
 	fi
@@ -131,14 +167,13 @@ #'
 		s/\\/\\\\/g
 		s/ /\\ /g
 	' |
-	report "Changed but not updated" \
+	report changed "Changed but not updated" \
 	    "use git-update-index to mark for commit"
 
         option=""
         if test -z "$untracked_files"; then
             option="--directory --no-empty-directory"
         fi
-	hdr_shown=
 	if test -f "$GIT_DIR/info/exclude"
 	then
 	    git-ls-files --others $option \
@@ -148,16 +183,12 @@ #'
 	    git-ls-files --others $option \
 		--exclude-per-directory=.gitignore
 	fi |
-	while read line; do
-	    if [ -z "$hdr_shown" ]; then
-		echo '#'
-		echo '# Untracked files:'
-		echo '#   (use "git add" to add to commit)'
-		echo '#'
-		hdr_shown=1
-	    fi
-	    echo "#	$line"
-	done
+	sed -e '
+		s/\\/\\\\/g
+		s/ /\\ /g
+		s/^/O /
+	' |
+	report untracked "Untracked files" "use git add to commit"
 
 	if test -n "$verbose" -a -z "$IS_INITIAL"
 	then
-- 
1.4.2.rc3.g06c3
