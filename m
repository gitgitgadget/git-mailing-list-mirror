From: Steffen Prohaska <prohaska@zib.de>
Subject: [PATCH] mergetool: support absolute paths to tools by git config merge.<tool>path
Date: Mon,  8 Oct 2007 23:22:40 +0200
Message-ID: <11918785613855-git-send-email-prohaska@zib.de>
Cc: git@vger.kernel.org, Steffen Prohaska <prohaska@zib.de>
To: "Theodore Ts'o" <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Mon Oct 08 23:23:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1If041-0005KN-9y
	for gcvg-git-2@gmane.org; Mon, 08 Oct 2007 23:22:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752654AbXJHVWr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Oct 2007 17:22:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752823AbXJHVWr
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Oct 2007 17:22:47 -0400
Received: from mailer.zib.de ([130.73.108.11]:65369 "EHLO mailer.zib.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752607AbXJHVWp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Oct 2007 17:22:45 -0400
Received: from mailsrv2.zib.de (sc2.zib.de [130.73.108.31])
	by mailer.zib.de (8.13.7+Sun/8.13.7) with ESMTP id l98LMgS8023240;
	Mon, 8 Oct 2007 23:22:42 +0200 (CEST)
Received: from localhost.localdomain (vss6.zib.de [130.73.69.7])
	by mailsrv2.zib.de (8.13.4/8.13.4) with ESMTP id l98LMf9A005225;
	Mon, 8 Oct 2007 23:22:41 +0200 (MEST)
X-Mailer: git-send-email 1.5.2.4
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60341>

This commit adds a mechanism to provide absolute paths to the
commands called by 'git mergetool'. A path can be specified
in the configuation variable merge.<toolname>path.

This mechanism is especially useful on Windows, where external
programs are unlikely to be in the path.

Signed-off-by: Steffen Prohaska <prohaska@zib.de>
---
 Documentation/git-mergetool.txt |    5 ++
 git-mergetool.sh                |   81 ++++++++++++++++++++++-----------------
 2 files changed, 51 insertions(+), 35 deletions(-)

diff --git a/Documentation/git-mergetool.txt b/Documentation/git-mergetool.txt
index 6c32c6d..6b97aaa 100644
--- a/Documentation/git-mergetool.txt
+++ b/Documentation/git-mergetool.txt
@@ -31,6 +31,11 @@ If a merge resolution program is not specified, 'git mergetool'
 will use the configuration variable merge.tool.  If the
 configuration variable merge.tool is not set, 'git mergetool'
 will pick a suitable default.
++
+You can explicitly provide a full path to the tool by setting the
+configuration variable merge.<tool>path. For example, you
+can configure the absolute path to kdiff3 by setting merge.kdiff3path.
+Otherise, 'git mergetool' assumes the tool is available in PATH.
 
 Author
 ------
diff --git a/git-mergetool.sh b/git-mergetool.sh
index 9f4f313..7f6c16f 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -192,10 +192,10 @@ merge_file () {
     case "$merge_tool" in
 	kdiff3)
 	    if base_present ; then
-		(kdiff3 --auto --L1 "$path (Base)" --L2 "$path (Local)" --L3 "$path (Remote)" \
+		("$merge_tool_path" --auto --L1 "$path (Base)" --L2 "$path (Local)" --L3 "$path (Remote)" \
 		    -o "$path" -- "$BASE" "$LOCAL" "$REMOTE" > /dev/null 2>&1)
 	    else
-		(kdiff3 --auto --L1 "$path (Local)" --L2 "$path (Remote)" \
+		("$merge_tool_path" --auto --L1 "$path (Local)" --L2 "$path (Remote)" \
 		    -o "$path" -- "$LOCAL" "$REMOTE" > /dev/null 2>&1)
 	    fi
 	    status=$?
@@ -203,35 +203,35 @@ merge_file () {
 	    ;;
 	tkdiff)
 	    if base_present ; then
-		tkdiff -a "$BASE" -o "$path" -- "$LOCAL" "$REMOTE"
+		"$merge_tool_path" -a "$BASE" -o "$path" -- "$LOCAL" "$REMOTE"
 	    else
-		tkdiff -o "$path" -- "$LOCAL" "$REMOTE"
+		"$merge_tool_path" -o "$path" -- "$LOCAL" "$REMOTE"
 	    fi
 	    status=$?
 	    save_backup
 	    ;;
 	meld|vimdiff)
 	    touch "$BACKUP"
-	    $merge_tool -- "$LOCAL" "$path" "$REMOTE"
+	    "$merge_tool_path" -- "$LOCAL" "$path" "$REMOTE"
 	    check_unchanged
 	    save_backup
 	    ;;
 	gvimdiff)
 		touch "$BACKUP"
-		gvimdiff -f -- "$LOCAL" "$path" "$REMOTE"
+		"$merge_tool_path" -f -- "$LOCAL" "$path" "$REMOTE"
 		check_unchanged
 		save_backup
 		;;
 	xxdiff)
 	    touch "$BACKUP"
 	    if base_present ; then
-		xxdiff -X --show-merged-pane \
+		"$merge_tool_path" -X --show-merged-pane \
 		    -R 'Accel.SaveAsMerged: "Ctrl-S"' \
 		    -R 'Accel.Search: "Ctrl+F"' \
 		    -R 'Accel.SearchForward: "Ctrl-G"' \
 		    --merged-file "$path" -- "$LOCAL" "$BASE" "$REMOTE"
 	    else
-		xxdiff -X --show-merged-pane \
+		"$merge_tool_path" -X --show-merged-pane \
 		    -R 'Accel.SaveAsMerged: "Ctrl-S"' \
 		    -R 'Accel.Search: "Ctrl+F"' \
 		    -R 'Accel.SearchForward: "Ctrl-G"' \
@@ -243,18 +243,18 @@ merge_file () {
 	opendiff)
 	    touch "$BACKUP"
 	    if base_present; then
-		opendiff "$LOCAL" "$REMOTE" -ancestor "$BASE" -merge "$path" | cat
+		"$merge_tool_path" "$LOCAL" "$REMOTE" -ancestor "$BASE" -merge "$path" | cat
 	    else
-		opendiff "$LOCAL" "$REMOTE" -merge "$path" | cat
+		"$merge_tool_path" "$LOCAL" "$REMOTE" -merge "$path" | cat
 	    fi
 	    check_unchanged
 	    save_backup
 	    ;;
 	emerge)
 	    if base_present ; then
-		emacs -f emerge-files-with-ancestor-command "$LOCAL" "$REMOTE" "$BASE" "$(basename "$path")"
+		"$merge_tool_path" -f emerge-files-with-ancestor-command "$LOCAL" "$REMOTE" "$BASE" "$(basename "$path")"
 	    else
-		emacs -f emerge-files-command "$LOCAL" "$REMOTE" "$(basename "$path")"
+		"$merge_tool_path" -f emerge-files-command "$LOCAL" "$REMOTE" "$(basename "$path")"
 	    fi
 	    status=$?
 	    save_backup
@@ -297,17 +297,23 @@ do
     shift
 done
 
+valid_tool() {
+	case "$1" in
+		kdiff3 | tkdiff | xxdiff | meld | opendiff | emerge | vimdiff | gvimdiff)
+			;; # happy
+		*)
+			return 1
+			;;
+	esac
+}
+
 if test -z "$merge_tool"; then
     merge_tool=`git config merge.tool`
-    case "$merge_tool" in
-	kdiff3 | tkdiff | xxdiff | meld | opendiff | emerge | vimdiff | gvimdiff | "")
-	    ;; # happy
-	*)
+    test -n "$merge_tool" || valid_tool "$merge_tool" || {
 	    echo >&2 "git config option merge.tool set to unknown tool: $merge_tool"
 	    echo >&2 "Resetting to default..."
 	    unset merge_tool
-	    ;;
-    esac
+    }
 fi
 
 if test -z "$merge_tool" ; then
@@ -345,24 +351,29 @@ if test -z "$merge_tool" ; then
     fi
 fi
 
-case "$merge_tool" in
-    kdiff3|tkdiff|meld|xxdiff|vimdiff|gvimdiff|opendiff)
-	if ! type "$merge_tool" > /dev/null 2>&1; then
-	    echo "The merge tool $merge_tool is not available"
-	    exit 1
-	fi
-	;;
-    emerge)
-	if ! type "emacs" > /dev/null 2>&1; then
-	    echo "Emacs is not available"
-	    exit 1
-	fi
-	;;
-    *)
-	echo "Unknown merge tool: $merge_tool"
+valid_tool "$merge_tool" || {
+	echo >&2 "Unknown merge_tool $merge_tool"
 	exit 1
-	;;
-esac
+}
+
+if test -z "$merge_tool_path" ; then
+	merge_tool_path=`git config merge.${merge_tool}path`
+	if test -z "$merge_tool_path" ; then
+		case "$merge_tool" in
+			emerge)
+				merge_tool_path=emacs
+				;;
+			*)
+				merge_tool_path=$merge_tool
+				;;
+		esac
+	fi
+fi
+
+if ! type "$merge_tool_path" > /dev/null 2>&1; then
+    echo "The merge tool $merge_tool is not available as '$merge_tool_path'"
+    exit 1
+fi
 
 if test $# -eq 0 ; then
 	files=`git ls-files -u | sed -e 's/^[^	]*	//' | sort -u`
-- 
1.5.3.3.127.g40d17
