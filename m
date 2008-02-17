From: Charles Bailey <charles@hashpling.org>
Subject: [PATCH 1/2] Tidy up git mergetool's backup file behaviour and variable names
Date: Sun, 17 Feb 2008 12:45:29 +0000
Message-ID: <9543203388d64839de78822efb538903fc15bf7f.1203251306.git.charles@hashpling.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 17 13:46:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQiuS-00063C-Nc
	for gcvg-git-2@gmane.org; Sun, 17 Feb 2008 13:46:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755507AbYBQMpp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Feb 2008 07:45:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755448AbYBQMpp
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Feb 2008 07:45:45 -0500
Received: from fhw-relay07.plus.net ([212.159.14.215]:42201 "EHLO
	fhw-relay07.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755211AbYBQMpo (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Feb 2008 07:45:44 -0500
Received: from [212.159.69.125] (helo=hashpling.plus.com)
	 by fhw-relay07.plus.net with esmtp (Exim) id 1JQitj-0005MB-OE; Sun, 17 Feb 2008 12:45:36 +0000
Received: from fermat.hashpling.org (fermat.hashpling.org [127.0.0.1])
	by hashpling.plus.com (8.13.8/8.13.6) with ESMTP id m1HCjUuK029186;
	Sun, 17 Feb 2008 12:45:30 GMT
Received: (from charles@localhost)
	by fermat.hashpling.org (8.13.8/8.13.6/Submit) id m1HCjUig029185;
	Sun, 17 Feb 2008 12:45:30 GMT
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
X-Plusnet-Relay: 1384458624ba5a5f8361b2655f18e562
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74125>

Currently a backup pre-merge file with conflict markers is sometimes
kept with a .orig extenstion and sometimes removed depending on the
particular merge tool used.

This patch makes the handling consistent across all merge tools and
configurable via a new mergetool.keepBackup config variable

Changed the merge file path variable to MERGED for consistency with the
names of the merge temporary filename variables. This done with the
intention of having these variables used by user scripts in a subsequent
custom merge tool patch.

Signed-off-by: Charles Bailey <charles@hashpling.org>
---

Reordered patch series taking into account Junio's latest comments.


 Documentation/config.txt |    5 ++
 git-mergetool.sh         |  134 +++++++++++++++++++++-------------------------
 2 files changed, 67 insertions(+), 72 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index f9bdb16..c145d5b 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -717,6 +717,11 @@ mergetool.<tool>.path::
 	Override the path for the given tool.  This is useful in case
 	your tool is not in the PATH.
 
+mergetool.keepBackup::
+	After performing a merge, the original file with conflict markers
+	can be saved as a file with a `.orig` extension.  If this variable
+	is set to `false` then this file is not preserved.
+
 pack.window::
 	The size of the window used by linkgit:git-pack-objects[1] when no
 	window size is given on the command line. Defaults to 10.
diff --git a/git-mergetool.sh b/git-mergetool.sh
index cbbb707..f556927 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -34,7 +34,7 @@ base_present () {
 
 cleanup_temp_files () {
     if test "$1" = --save-backup ; then
-	mv -- "$BACKUP" "$path.orig"
+	mv -- "$BACKUP" "$MERGED.orig"
 	rm -f -- "$LOCAL" "$REMOTE" "$BASE"
     else
 	rm -f -- "$LOCAL" "$REMOTE" "$BASE" "$BACKUP"
@@ -67,14 +67,14 @@ resolve_symlink_merge () {
 	read ans
 	case "$ans" in
 	    [lL]*)
-		git checkout-index -f --stage=2 -- "$path"
-		git add -- "$path"
+		git checkout-index -f --stage=2 -- "$MERGED"
+		git add -- "$MERGED"
 		cleanup_temp_files --save-backup
 		return
 		;;
 	    [rR]*)
-		git checkout-index -f --stage=3 -- "$path"
-		git add -- "$path"
+		git checkout-index -f --stage=3 -- "$MERGED"
+		git add -- "$MERGED"
 		cleanup_temp_files --save-backup
 		return
 		;;
@@ -95,12 +95,12 @@ resolve_deleted_merge () {
 	read ans
 	case "$ans" in
 	    [mMcC]*)
-		git add -- "$path"
+		git add -- "$MERGED"
 		cleanup_temp_files --save-backup
 		return
 		;;
 	    [dD]*)
-		git rm -- "$path" > /dev/null
+		git rm -- "$MERGED" > /dev/null
 		cleanup_temp_files
 		return
 		;;
@@ -112,11 +112,11 @@ resolve_deleted_merge () {
 }
 
 check_unchanged () {
-    if test "$path" -nt "$BACKUP" ; then
+    if test "$MERGED" -nt "$BACKUP" ; then
 	status=0;
     else
 	while true; do
-	    echo "$path seems unchanged."
+	    echo "$MERGED seems unchanged."
 	    printf "Was the merge successful? [y/n] "
 	    read answer < /dev/tty
 	    case "$answer" in
@@ -127,50 +127,38 @@ check_unchanged () {
     fi
 }
 
-save_backup () {
-    if test "$status" -eq 0; then
-	mv -- "$BACKUP" "$path.orig"
-    fi
-}
-
-remove_backup () {
-    if test "$status" -eq 0; then
-	rm "$BACKUP"
-    fi
-}
-
 merge_file () {
-    path="$1"
+    MERGED="$1"
 
-    f=`git ls-files -u -- "$path"`
+    f=`git ls-files -u -- "$MERGED"`
     if test -z "$f" ; then
-	if test ! -f "$path" ; then
-	    echo "$path: file not found"
+	if test ! -f "$MERGED" ; then
+	    echo "$MERGED: file not found"
 	else
-	    echo "$path: file does not need merging"
+	    echo "$MERGED: file does not need merging"
 	fi
 	exit 1
     fi
 
-    ext="$$$(expr "$path" : '.*\(\.[^/]*\)$')"
-    BACKUP="$path.BACKUP.$ext"
-    LOCAL="$path.LOCAL.$ext"
-    REMOTE="$path.REMOTE.$ext"
-    BASE="$path.BASE.$ext"
+    ext="$$$(expr "$MERGED" : '.*\(\.[^/]*\)$')"
+    BACKUP="$MERGED.BACKUP.$ext"
+    LOCAL="$MERGED.LOCAL.$ext"
+    REMOTE="$MERGED.REMOTE.$ext"
+    BASE="$MERGED.BASE.$ext"
 
-    mv -- "$path" "$BACKUP"
-    cp -- "$BACKUP" "$path"
+    mv -- "$MERGED" "$BACKUP"
+    cp -- "$BACKUP" "$MERGED"
 
-    base_mode=`git ls-files -u -- "$path" | awk '{if ($3==1) print $1;}'`
-    local_mode=`git ls-files -u -- "$path" | awk '{if ($3==2) print $1;}'`
-    remote_mode=`git ls-files -u -- "$path" | awk '{if ($3==3) print $1;}'`
+    base_mode=`git ls-files -u -- "$MERGED" | awk '{if ($3==1) print $1;}'`
+    local_mode=`git ls-files -u -- "$MERGED" | awk '{if ($3==2) print $1;}'`
+    remote_mode=`git ls-files -u -- "$MERGED" | awk '{if ($3==3) print $1;}'`
 
-    base_present   && git cat-file blob ":1:$prefix$path" >"$BASE" 2>/dev/null
-    local_present  && git cat-file blob ":2:$prefix$path" >"$LOCAL" 2>/dev/null
-    remote_present && git cat-file blob ":3:$prefix$path" >"$REMOTE" 2>/dev/null
+    base_present   && git cat-file blob ":1:$prefix$MERGED" >"$BASE" 2>/dev/null
+    local_present  && git cat-file blob ":2:$prefix$MERGED" >"$LOCAL" 2>/dev/null
+    remote_present && git cat-file blob ":3:$prefix$MERGED" >"$REMOTE" 2>/dev/null
 
     if test -z "$local_mode" -o -z "$remote_mode"; then
-	echo "Deleted merge conflict for '$path':"
+	echo "Deleted merge conflict for '$MERGED':"
 	describe_file "$local_mode" "local" "$LOCAL"
 	describe_file "$remote_mode" "remote" "$REMOTE"
 	resolve_deleted_merge
@@ -178,14 +166,14 @@ merge_file () {
     fi
 
     if is_symlink "$local_mode" || is_symlink "$remote_mode"; then
-	echo "Symbolic link merge conflict for '$path':"
+	echo "Symbolic link merge conflict for '$MERGED':"
 	describe_file "$local_mode" "local" "$LOCAL"
 	describe_file "$remote_mode" "remote" "$REMOTE"
 	resolve_symlink_merge
 	return
     fi
 
-    echo "Normal merge conflict for '$path':"
+    echo "Normal merge conflict for '$MERGED':"
     describe_file "$local_mode" "local" "$LOCAL"
     describe_file "$remote_mode" "remote" "$REMOTE"
     printf "Hit return to start merge resolution tool (%s): " "$merge_tool"
@@ -194,36 +182,32 @@ merge_file () {
     case "$merge_tool" in
 	kdiff3)
 	    if base_present ; then
-		("$merge_tool_path" --auto --L1 "$path (Base)" --L2 "$path (Local)" --L3 "$path (Remote)" \
-		    -o "$path" -- "$BASE" "$LOCAL" "$REMOTE" > /dev/null 2>&1)
+		("$merge_tool_path" --auto --L1 "$MERGED (Base)" --L2 "$MERGED (Local)" --L3 "$MERGED (Remote)" \
+		    -o "$MERGED" -- "$BASE" "$LOCAL" "$REMOTE" > /dev/null 2>&1)
 	    else
-		("$merge_tool_path" --auto --L1 "$path (Local)" --L2 "$path (Remote)" \
-		    -o "$path" -- "$LOCAL" "$REMOTE" > /dev/null 2>&1)
+		("$merge_tool_path" --auto --L1 "$MERGED (Local)" --L2 "$MERGED (Remote)" \
+		    -o "$MERGED" -- "$LOCAL" "$REMOTE" > /dev/null 2>&1)
 	    fi
 	    status=$?
-	    remove_backup
 	    ;;
 	tkdiff)
 	    if base_present ; then
-		"$merge_tool_path" -a "$BASE" -o "$path" -- "$LOCAL" "$REMOTE"
+		"$merge_tool_path" -a "$BASE" -o "$MERGED" -- "$LOCAL" "$REMOTE"
 	    else
-		"$merge_tool_path" -o "$path" -- "$LOCAL" "$REMOTE"
+		"$merge_tool_path" -o "$MERGED" -- "$LOCAL" "$REMOTE"
 	    fi
 	    status=$?
-	    save_backup
 	    ;;
 	meld|vimdiff)
 	    touch "$BACKUP"
-	    "$merge_tool_path" -- "$LOCAL" "$path" "$REMOTE"
+	    "$merge_tool_path" -- "$LOCAL" "$MERGED" "$REMOTE"
 	    check_unchanged
-	    save_backup
 	    ;;
 	gvimdiff)
-		touch "$BACKUP"
-		"$merge_tool_path" -f -- "$LOCAL" "$path" "$REMOTE"
-		check_unchanged
-		save_backup
-		;;
+	    touch "$BACKUP"
+	    "$merge_tool_path" -f -- "$LOCAL" "$MERGED" "$REMOTE"
+	    check_unchanged
+	    ;;
 	xxdiff)
 	    touch "$BACKUP"
 	    if base_present ; then
@@ -231,53 +215,57 @@ merge_file () {
 		    -R 'Accel.SaveAsMerged: "Ctrl-S"' \
 		    -R 'Accel.Search: "Ctrl+F"' \
 		    -R 'Accel.SearchForward: "Ctrl-G"' \
-		    --merged-file "$path" -- "$LOCAL" "$BASE" "$REMOTE"
+		    --merged-file "$MERGED" -- "$LOCAL" "$BASE" "$REMOTE"
 	    else
 		"$merge_tool_path" -X --show-merged-pane \
 		    -R 'Accel.SaveAsMerged: "Ctrl-S"' \
 		    -R 'Accel.Search: "Ctrl+F"' \
 		    -R 'Accel.SearchForward: "Ctrl-G"' \
-		    --merged-file "$path" -- "$LOCAL" "$REMOTE"
+		    --merged-file "$MERGED" -- "$LOCAL" "$REMOTE"
 	    fi
 	    check_unchanged
-	    save_backup
 	    ;;
 	opendiff)
 	    touch "$BACKUP"
 	    if base_present; then
-		"$merge_tool_path" "$LOCAL" "$REMOTE" -ancestor "$BASE" -merge "$path" | cat
+		"$merge_tool_path" "$LOCAL" "$REMOTE" -ancestor "$BASE" -merge "$MERGED" | cat
 	    else
-		"$merge_tool_path" "$LOCAL" "$REMOTE" -merge "$path" | cat
+		"$merge_tool_path" "$LOCAL" "$REMOTE" -merge "$MERGED" | cat
 	    fi
 	    check_unchanged
-	    save_backup
 	    ;;
 	ecmerge)
 	    touch "$BACKUP"
 	    if base_present; then
-		"$merge_tool_path" "$BASE" "$LOCAL" "$REMOTE" --mode=merge3 --to="$path"
+		"$merge_tool_path" "$BASE" "$LOCAL" "$REMOTE" --mode=merge3 --to="$MERGED"
 	    else
-		"$merge_tool_path" "$LOCAL" "$REMOTE" --mode=merge2 --to="$path"
+		"$merge_tool_path" "$LOCAL" "$REMOTE" --mode=merge2 --to="$MERGED"
 	    fi
 	    check_unchanged
-	    save_backup
 	    ;;
 	emerge)
 	    if base_present ; then
-		"$merge_tool_path" -f emerge-files-with-ancestor-command "$LOCAL" "$REMOTE" "$BASE" "$(basename "$path")"
+		"$merge_tool_path" -f emerge-files-with-ancestor-command "$LOCAL" "$REMOTE" "$BASE" "$(basename "$MERGED")"
 	    else
-		"$merge_tool_path" -f emerge-files-command "$LOCAL" "$REMOTE" "$(basename "$path")"
+		"$merge_tool_path" -f emerge-files-command "$LOCAL" "$REMOTE" "$(basename "$MERGED")"
 	    fi
 	    status=$?
-	    save_backup
 	    ;;
     esac
+
     if test "$status" -ne 0; then
-	echo "merge of $path failed" 1>&2
-	mv -- "$BACKUP" "$path"
+	echo "merge of $MERGED failed" 1>&2
+	mv -- "$BACKUP" "$MERGED"
 	exit 1
     fi
-    git add -- "$path"
+
+    if test "$merge_keep_backup" = "true"; then
+	mv -- "$BACKUP" "$MERGED.orig"
+    else
+	rm -- "$BACKUP"
+    fi
+
+    git add -- "$MERGED"
     cleanup_temp_files
 }
 
@@ -380,6 +368,8 @@ else
 
     init_merge_tool_path "$merge_tool"
 
+    merge_keep_backup="$(git config --bool merge.keepBackup || echo true)"
+
     if ! type "$merge_tool_path" > /dev/null 2>&1; then
         echo "The merge tool $merge_tool is not available as '$merge_tool_path'"
         exit 1
-- 
1.5.4.1.34.g94bf
