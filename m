From: Charles Bailey <charles@hashpling.org>
Subject: [PATCH 2/4] Changed an internal variable of mergetool to support custom commands
Date: Thu, 21 Feb 2008 23:30:34 +0000
Message-ID: <73391eb9efe812da00fe049b97a13d28a5605777.1203636096.git.charles@hashpling.org>
References: <e6d984bbbb5d4dab54c38caa5c0c71b060d69156.1203636096.git.charles@hashpling.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 22 00:31:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JSKsu-0006wD-Vb
	for gcvg-git-2@gmane.org; Fri, 22 Feb 2008 00:31:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755881AbYBUXar (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Feb 2008 18:30:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755713AbYBUXar
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Feb 2008 18:30:47 -0500
Received: from ptb-relay02.plus.net ([212.159.14.213]:48840 "EHLO
	ptb-relay02.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754806AbYBUXaq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Feb 2008 18:30:46 -0500
Received: from [212.159.69.125] (helo=hashpling.plus.com)
	 by ptb-relay02.plus.net with esmtp (Exim) id 1JSKsH-0006oS-2A; Thu, 21 Feb 2008 23:30:45 +0000
Received: from fermat.hashpling.org (fermat.hashpling.org [127.0.0.1])
	by hashpling.plus.com (8.13.8/8.13.6) with ESMTP id m1LNUYHt011852;
	Thu, 21 Feb 2008 23:30:34 GMT
Received: (from charles@localhost)
	by fermat.hashpling.org (8.13.8/8.13.6/Submit) id m1LNUYIt011851;
	Thu, 21 Feb 2008 23:30:34 GMT
Content-Disposition: inline
In-Reply-To: <e6d984bbbb5d4dab54c38caa5c0c71b060d69156.1203636096.git.charles@hashpling.org>
User-Agent: Mutt/1.4.2.1i
X-Plusnet-Relay: b7908a0cf17b77219bbf3da1323ae7ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74679>

The variable $path changes to $MERGED so that it is more consistent
with $BASE, $LOCAL and $REMOTE for future custom command lines.

Signed-off-by: Charles Bailey <charles@hashpling.org>
---
 git-mergetool.sh |  102 +++++++++++++++++++++++++++---------------------------
 1 files changed, 51 insertions(+), 51 deletions(-)

diff --git a/git-mergetool.sh b/git-mergetool.sh
index e27bb7b..d3dd7f8 100755
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
@@ -129,7 +129,7 @@ check_unchanged () {
 
 save_backup () {
     if test "$status" -eq 0; then
-	mv -- "$BACKUP" "$path.orig"
+	mv -- "$BACKUP" "$MERGED.orig"
     fi
 }
 
@@ -140,37 +140,37 @@ remove_backup () {
 }
 
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
@@ -178,14 +178,14 @@ merge_file () {
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
@@ -194,30 +194,30 @@ merge_file () {
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
 	    ;;
 	meld|vimdiff)
 	    touch "$BACKUP"
-	    "$merge_tool_path" -- "$LOCAL" "$path" "$REMOTE"
+	    "$merge_tool_path" -- "$LOCAL" "$MERGED" "$REMOTE"
 	    check_unchanged
 	    ;;
 	gvimdiff)
 	    touch "$BACKUP"
-	    "$merge_tool_path" -f -- "$LOCAL" "$path" "$REMOTE"
+	    "$merge_tool_path" -f -- "$LOCAL" "$MERGED" "$REMOTE"
 	    check_unchanged
 	    ;;
 	xxdiff)
@@ -227,56 +227,56 @@ merge_file () {
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
 	    ;;
     esac
     if test "$status" -ne 0; then
-	echo "merge of $path failed" 1>&2
-	mv -- "$BACKUP" "$path"
+	echo "merge of $MERGED failed" 1>&2
+	mv -- "$BACKUP" "$MERGED"
 	exit 1
     fi
 
     if test "$merge_keep_backup" = "true"; then
-	mv -- "$BACKUP" "$path.orig"
+	mv -- "$BACKUP" "$MERGED.orig"
     else
 	rm -- "$BACKUP"
     fi
 
-    git add -- "$path"
+    git add -- "$MERGED"
     cleanup_temp_files
 }
 
-- 
1.5.4.2.133.g3d51e


-- 
Charles Bailey
http://ccgi.hashpling.plus.com/blog/
