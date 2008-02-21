From: Jay Soffian <jaysoffian@gmail.com>
Subject: [RFC/PATCH] mergetool: clarify local/remote terminology
Date: Thu, 21 Feb 2008 00:12:56 -0500
Message-ID: <1203570776-62019-1-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Jay Soffian <jaysoffian@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Feb 21 06:13:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JS3kc-0002Ms-5L
	for gcvg-git-2@gmane.org; Thu, 21 Feb 2008 06:13:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751081AbYBUFNH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 21 Feb 2008 00:13:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751111AbYBUFNG
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Feb 2008 00:13:06 -0500
Received: from an-out-0708.google.com ([209.85.132.241]:45105 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751061AbYBUFNB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Feb 2008 00:13:01 -0500
Received: by an-out-0708.google.com with SMTP id d31so708411and.103
        for <git@vger.kernel.org>; Wed, 20 Feb 2008 21:13:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date:message-id:x-mailer:mime-version:content-type:content-transfer-encoding;
        bh=zkt1SX3iBqdydAN6ODmErW+RTal2UbJpbYDgX81T2HQ=;
        b=XLW7JR48vPmhSvI+OPldq/Fc+s3qxdBykfNqgTBD9UA70fp6eF4A6TRLYugnSq8GXX80xJXTEjlkrOF6Sz6Tm9ivOAuAQBunj8cg3VZ3s9V1rZo0eQyG58y8KCJ0JUkbd/HjcLkLEJjYKMQlLpLvM1JmkW7GBR1kmeSb2ObvdWg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version:content-type:content-transfer-encoding;
        b=AM6wCilEbMA/zkYjoxH1UjbKVPSjzAwLqCiFPRihptbBA9UG3AgYqgxJEegpVkIu3R1ZwxMUiZj/YXTWTGL7TEGdjEY7/9blMPw1VmKEK9SIfImF1uDSxXM/u59mMQHRsldc+a10zAyHoRYOjCyFZpUF6AVcpyeSZQ2rlk2OjMQ=
Received: by 10.100.93.19 with SMTP id q19mr18968116anb.115.1203570780655;
        Wed, 20 Feb 2008 21:13:00 -0800 (PST)
Received: from localhost ( [75.189.159.45])
        by mx.google.com with ESMTPS id c37sm789925ana.9.2008.02.20.21.12.57
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 20 Feb 2008 21:12:59 -0800 (PST)
X-Mailer: git-send-email 1.5.4.2.236.g77b4.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74595>

Always calling the thing on the left-side of a merge "local" and on the
right side "remote" isn't correct. You could be rebasing, in which case
the left side is the new base/upstream and the right side is the saved
commits which are being re-applied. So,

- Use left/right instead of local/remote internally to make the code
  clearer.

- Add --left and --right options to allow the user to specify their own
  preferred names for the left/right sides of the merge. Use these when
  constructing the filenames that are passed to the external mergetool.

- By default call left "local" and right "upstream", unless a rebase
  is in progress in which case left=upstream and right=local.

Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
---
I think this makes things clearer. In particular I found it confusing when I ran
mergetool during a rebase and the file tagged LOCAL was the new base, not my
local changes, and REMOTE was actually my saved off commits. Fixing just that
problem is a simpler change, but I don't really think using local/remote is
right anyway.

I played around with trying to use the branch name for left side default name,
but again, this became confusing during a rebase, so I think local/upstream make
the most sense in general.

Thoughts?

 git-mergetool.sh |  118 ++++++++++++++++++++++++++++++++++++------------------
 1 files changed, 79 insertions(+), 39 deletions(-)

diff --git a/git-mergetool.sh b/git-mergetool.sh
index cbbb707..a12b0a2 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -8,7 +8,7 @@
 # at the discretion of Junio C Hamano.
 #
 
-USAGE='[--tool=tool] [file to merge] ...'
+USAGE='[--tool=tool] [--left=name] [--right=name] [file to merge] ...'
 SUBDIRECTORY_OK=Yes
 OPTIONS_SPEC=
 . git-sh-setup
@@ -20,12 +20,12 @@ is_symlink () {
     test "$1" = 120000
 }
 
-local_present () {
-    test -n "$local_mode"
+left_present () {
+    test -n "$left_mode"
 }
 
-remote_present () {
-    test -n "$remote_mode"
+right_present () {
+    test -n "$right_mode"
 }
 
 base_present () {
@@ -35,9 +35,9 @@ base_present () {
 cleanup_temp_files () {
     if test "$1" = --save-backup ; then
 	mv -- "$BACKUP" "$path.orig"
-	rm -f -- "$LOCAL" "$REMOTE" "$BASE"
+	rm -f -- "$LEFT" "$RIGHT" "$BASE"
     else
-	rm -f -- "$LOCAL" "$REMOTE" "$BASE" "$BACKUP"
+	rm -f -- "$LEFT" "$RIGHT" "$BASE" "$BACKUP"
     fi
 }
 
@@ -63,7 +63,8 @@ describe_file () {
 
 resolve_symlink_merge () {
     while true; do
-	printf "Use (l)ocal or (r)emote, or (a)bort? "
+	printf "Use (l)eft {%s} or (r)ight {%s}, or (a)bort? " \
+		"$left_desc" "$right_desc"
 	read ans
 	case "$ans" in
 	    [lL]*)
@@ -154,73 +155,79 @@ merge_file () {
 
     ext="$$$(expr "$path" : '.*\(\.[^/]*\)$')"
     BACKUP="$path.BACKUP.$ext"
-    LOCAL="$path.LOCAL.$ext"
-    REMOTE="$path.REMOTE.$ext"
+    LEFT_DESC=`echo "$left_desc" | tr "[:lower:]" "[:upper:]" | tr -c '[:alnum:]\n' _`
+    RIGHT_DESC=`echo "$right_desc" | tr "[:lower:]" "[:upper:]" | tr -c '[:alnum:]\n' _`
+    LEFT="$path.$LEFT_DESC.$ext"
+    RIGHT="$path.$RIGHT_DESC.$ext"
     BASE="$path.BASE.$ext"
 
     mv -- "$path" "$BACKUP"
     cp -- "$BACKUP" "$path"
 
     base_mode=`git ls-files -u -- "$path" | awk '{if ($3==1) print $1;}'`
-    local_mode=`git ls-files -u -- "$path" | awk '{if ($3==2) print $1;}'`
-    remote_mode=`git ls-files -u -- "$path" | awk '{if ($3==3) print $1;}'`
+    left_mode=`git ls-files -u -- "$path" | awk '{if ($3==2) print $1;}'`
+    right_mode=`git ls-files -u -- "$path" | awk '{if ($3==3) print $1;}'`
 
-    base_present   && git cat-file blob ":1:$prefix$path" >"$BASE" 2>/dev/null
-    local_present  && git cat-file blob ":2:$prefix$path" >"$LOCAL" 2>/dev/null
-    remote_present && git cat-file blob ":3:$prefix$path" >"$REMOTE" 2>/dev/null
+    base_present  && git cat-file blob ":1:$prefix$path" >"$BASE" 2>/dev/null
+    left_present  && git cat-file blob ":2:$prefix$path" >"$LEFT" 2>/dev/null
+    right_present && git cat-file blob ":3:$prefix$path" >"$RIGHT" 2>/dev/null
 
-    if test -z "$local_mode" -o -z "$remote_mode"; then
+    if test -z "$left_mode" -o -z "$right_mode"; then
 	echo "Deleted merge conflict for '$path':"
-	describe_file "$local_mode" "local" "$LOCAL"
-	describe_file "$remote_mode" "remote" "$REMOTE"
+	describe_file "$left_mode" "$left_desc" "$LEFT"
+	describe_file "$right_mode" "$right_desc" "$RIGHT"
 	resolve_deleted_merge
 	return
     fi
 
-    if is_symlink "$local_mode" || is_symlink "$remote_mode"; then
+    if is_symlink "$left_mode" || is_symlink "$right_mode"; then
 	echo "Symbolic link merge conflict for '$path':"
-	describe_file "$local_mode" "local" "$LOCAL"
-	describe_file "$remote_mode" "remote" "$REMOTE"
+	describe_file "$left_mode" "$left_desc" "$LEFT"
+	describe_file "$right_mode" "$right_desc" "$RIGHT"
 	resolve_symlink_merge
 	return
     fi
 
     echo "Normal merge conflict for '$path':"
-    describe_file "$local_mode" "local" "$LOCAL"
-    describe_file "$remote_mode" "remote" "$REMOTE"
+    describe_file "$left_mode" "$left_desc" "$LEFT"
+    describe_file "$right_mode" "$right_desc" "$RIGHT"
     printf "Hit return to start merge resolution tool (%s): " "$merge_tool"
     read ans
 
     case "$merge_tool" in
 	kdiff3)
+	    Left=$(echo "$left_desc" | \
+	           awk '{printf("%s%s",toupper(substr($0,1,1)),substr($0,2))}')
+	    Right=$(echo "$right_desc" | \
+	            awk '{printf("%s%s",toupper(substr($0,1,1)),substr($0,2))}')
 	    if base_present ; then
-		("$merge_tool_path" --auto --L1 "$path (Base)" --L2 "$path (Local)" --L3 "$path (Remote)" \
-		    -o "$path" -- "$BASE" "$LOCAL" "$REMOTE" > /dev/null 2>&1)
+		("$merge_tool_path" --auto --L1 "$path (Base)" --L2 "$path ($Left)" --L3 "$path ($Right)" \
+		    -o "$path" -- "$BASE" "$LEFT" "$RIGHT" > /dev/null 2>&1)
 	    else
-		("$merge_tool_path" --auto --L1 "$path (Local)" --L2 "$path (Remote)" \
-		    -o "$path" -- "$LOCAL" "$REMOTE" > /dev/null 2>&1)
+		("$merge_tool_path" --auto --L1 "$path ($Left)" --L2 "$path ($Right)" \
+		    -o "$path" -- "$LEFT" "$RIGHT" > /dev/null 2>&1)
 	    fi
 	    status=$?
 	    remove_backup
 	    ;;
 	tkdiff)
 	    if base_present ; then
-		"$merge_tool_path" -a "$BASE" -o "$path" -- "$LOCAL" "$REMOTE"
+		"$merge_tool_path" -a "$BASE" -o "$path" -- "$LEFT" "$RIGHT"
 	    else
-		"$merge_tool_path" -o "$path" -- "$LOCAL" "$REMOTE"
+		"$merge_tool_path" -o "$path" -- "$LEFT" "$RIGHT"
 	    fi
 	    status=$?
 	    save_backup
 	    ;;
 	meld|vimdiff)
 	    touch "$BACKUP"
-	    "$merge_tool_path" -- "$LOCAL" "$path" "$REMOTE"
+	    "$merge_tool_path" -- "$LEFT" "$path" "$RIGHT"
 	    check_unchanged
 	    save_backup
 	    ;;
 	gvimdiff)
 		touch "$BACKUP"
-		"$merge_tool_path" -f -- "$LOCAL" "$path" "$REMOTE"
+		"$merge_tool_path" -f -- "$LEFT" "$path" "$RIGHT"
 		check_unchanged
 		save_backup
 		;;
@@ -231,13 +238,13 @@ merge_file () {
 		    -R 'Accel.SaveAsMerged: "Ctrl-S"' \
 		    -R 'Accel.Search: "Ctrl+F"' \
 		    -R 'Accel.SearchForward: "Ctrl-G"' \
-		    --merged-file "$path" -- "$LOCAL" "$BASE" "$REMOTE"
+		    --merged-file "$path" -- "$LEFT" "$BASE" "$RIGHT"
 	    else
 		"$merge_tool_path" -X --show-merged-pane \
 		    -R 'Accel.SaveAsMerged: "Ctrl-S"' \
 		    -R 'Accel.Search: "Ctrl+F"' \
 		    -R 'Accel.SearchForward: "Ctrl-G"' \
-		    --merged-file "$path" -- "$LOCAL" "$REMOTE"
+		    --merged-file "$path" -- "$LEFT" "$RIGHT"
 	    fi
 	    check_unchanged
 	    save_backup
@@ -245,9 +252,9 @@ merge_file () {
 	opendiff)
 	    touch "$BACKUP"
 	    if base_present; then
-		"$merge_tool_path" "$LOCAL" "$REMOTE" -ancestor "$BASE" -merge "$path" | cat
+		"$merge_tool_path" "$LEFT" "$RIGHT" -ancestor "$BASE" -merge "$path" | cat
 	    else
-		"$merge_tool_path" "$LOCAL" "$REMOTE" -merge "$path" | cat
+		"$merge_tool_path" "$LEFT" "$RIGHT" -merge "$path" | cat
 	    fi
 	    check_unchanged
 	    save_backup
@@ -255,18 +262,18 @@ merge_file () {
 	ecmerge)
 	    touch "$BACKUP"
 	    if base_present; then
-		"$merge_tool_path" "$BASE" "$LOCAL" "$REMOTE" --mode=merge3 --to="$path"
+		"$merge_tool_path" "$BASE" "$LEFT" "$RIGHT" --mode=merge3 --to="$path"
 	    else
-		"$merge_tool_path" "$LOCAL" "$REMOTE" --mode=merge2 --to="$path"
+		"$merge_tool_path" "$LEFT" "$RIGHT" --mode=merge2 --to="$path"
 	    fi
 	    check_unchanged
 	    save_backup
 	    ;;
 	emerge)
 	    if base_present ; then
-		"$merge_tool_path" -f emerge-files-with-ancestor-command "$LOCAL" "$REMOTE" "$BASE" "$(basename "$path")"
+		"$merge_tool_path" -f emerge-files-with-ancestor-command "$LEFT" "$RIGHT" "$BASE" "$(basename "$path")"
 	    else
-		"$merge_tool_path" -f emerge-files-command "$LOCAL" "$REMOTE" "$(basename "$path")"
+		"$merge_tool_path" -f emerge-files-command "$LEFT" "$RIGHT" "$(basename "$path")"
 	    fi
 	    status=$?
 	    save_backup
@@ -296,6 +303,30 @@ do
 		    shift ;;
 	    esac
 	    ;;
+	-l|--left*)
+	    case "$#,$1" in
+		*,*=*)
+		    left_desc=`expr "z$1" : 'z-[^=]*=\(.*\)'`
+		    ;;
+		1,*)
+		    usage ;;
+		*)
+		    left_desc="$2"
+		    shift ;;
+	    esac
+	    ;;
+	-r|--right*)
+	    case "$#,$1" in
+		*,*=*)
+		    right_desc=`expr "z$1" : 'z-[^=]*=\(.*\)'`
+		    ;;
+		1,*)
+		    usage ;;
+		*)
+		    right_desc="$2"
+		    shift ;;
+	    esac
+	    ;;
 	--)
 	    break
 	    ;;
@@ -386,6 +417,15 @@ else
     fi
 fi
 
+if test -z "$left_desc" || test -z "$right_desc"; then
+    if test -d "$GIT_DIR/../.dotest" || test -f "$GIT_DIR/.dotest-merge/head-name"; then
+	left_desc="${left_desc:-upstream}"
+	right_desc="${right_desc:-local}"
+    else
+	left_desc="${left_desc:-local}"
+	right_desc="${right_desc:-upstream}"
+    fi
+fi
 
 if test $# -eq 0 ; then
 	files=`git ls-files -u | sed -e 's/^[^	]*	//' | sort -u`
-- 
1.5.4.2.236.g77b4.dirty
