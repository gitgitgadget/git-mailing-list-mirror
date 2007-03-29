From: Theodore Ts'o <tytso@mit.edu>
Subject: [PATCH] mergetool: Clean up description of files and prompts for merge resolutions
Date: Thu, 29 Mar 2007 11:44:25 -0400
Message-ID: <11751830652230-git-send-email-tytso@mit.edu>
References: <11751830653554-git-send-email-tytso@mit.edu> <11751830653871-git-send-email-tytso@mit.edu> <11751830651770-git-send-email-tytso@mit.edu> <11751830653157-git-send-email-tytso@mit.edu> <1175183065710-git-send-email-tytso@mit.edu> <11751830651361-git-send-email-tytso@mit.edu> <11751830654112-git-send-email-tytso@mit.edu> <11751830652803-git-send-email-tytso@mit.edu> <11751830653835-git-send-email-tytso@mit.edu> <11751830651076-git-send-email-tytso@mit.edu> <11751830652512-git-send-email-tytso@mit.edu>
Cc: git@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Mar 29 17:45:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HWwoM-0004BP-G3
	for gcvg-git@gmane.org; Thu, 29 Mar 2007 17:45:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030263AbXC2Pop (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Mar 2007 11:44:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030279AbXC2Pop
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Mar 2007 11:44:45 -0400
Received: from thunk.org ([69.25.196.29]:36605 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030263AbXC2Pob (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Mar 2007 11:44:31 -0400
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1HWwtf-0007Iy-Nu; Thu, 29 Mar 2007 11:50:44 -0400
Received: from tytso by candygram.thunk.org with local (Exim 4.62)
	(envelope-from <tytso@thunk.org>)
	id 1HWwnZ-0000y8-LD; Thu, 29 Mar 2007 11:44:25 -0400
X-Mailer: git-send-email 1.5.1.rc2.1.g8afe-dirty
In-Reply-To: <11751830652512-git-send-email-tytso@mit.edu>
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43446>

This fixes complaints from Junio for how messages and prompts are
printed when resolving symlink and deleted file merges.

Signed-off-by: "Theodore Ts'o" <tytso@mit.edu>
---
 git-mergetool.sh |   29 +++++++++++++++--------------
 1 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/git-mergetool.sh b/git-mergetool.sh
index b9d81f5..9b824ac 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -44,27 +44,24 @@ describe_file () {
     branch="$2"
     file="$3"
 
-    printf "    "
+    printf "  {$branch}: "
     if test -z "$mode"; then
-	printf "'$path' was deleted"
+	echo "deleted"
     elif is_symlink "$mode" ; then
-	printf "'$path' is a symlink containing '"
-	cat "$file"
-	printf "'"
+	echo "a symbolic link -> '$(cat "$file")'"
     else
 	if base_present; then
-	    printf "'%s' was created" "$path"
+	    echo "modified"
 	else
-	    printf "'%s' was modified" "$path"
+	    echo "created"
 	fi
     fi
-    echo " in the $branch branch"
 }
 
 
 resolve_symlink_merge () {
     while true; do
-	printf "Use (r)emote or (l)ocal, or (a)bort? "
+	printf "Use (l)ocal or (r)emote, or (a)bort? "
 	read ans
 	case "$ans" in
 	    [lL]*)
@@ -88,10 +85,14 @@ resolve_symlink_merge () {
 
 resolve_deleted_merge () {
     while true; do
-	printf "Use (m)odified or (d)eleted file, or (a)bort? "
+	if base_present; then
+	    printf "Use (m)odified or (d)eleted file, or (a)bort? "
+	else
+	    printf "Use (c)reated or (d)eleted file, or (a)bort? "
+	fi
 	read ans
 	case "$ans" in
-	    [mM]*)
+	    [mMcC]*)
 		git-add -- "$path"
 		cleanup_temp_files --save-backup
 		return
@@ -166,7 +167,7 @@ merge_file () {
     remote_present && git cat-file blob ":3:$path" > "$REMOTE" 2>/dev/null
 
     if test -z "$local_mode" -o -z "$remote_mode"; then
-	echo "Deleted merge conflict for $path:"
+	echo "Deleted merge conflict for '$path':"
 	describe_file "$local_mode" "local" "$LOCAL"
 	describe_file "$remote_mode" "remote" "$REMOTE"
 	resolve_deleted_merge
@@ -174,14 +175,14 @@ merge_file () {
     fi
 
     if is_symlink "$local_mode" || is_symlink "$remote_mode"; then
-	echo "Symlink merge conflict for $path:"
+	echo "Symbolic link merge conflict for '$path':"
 	describe_file "$local_mode" "local" "$LOCAL"
 	describe_file "$remote_mode" "remote" "$REMOTE"
 	resolve_symlink_merge
 	return
     fi
 
-    echo "Normal merge conflict for $path:"
+    echo "Normal merge conflict for '$path':"
     describe_file "$local_mode" "local" "$LOCAL"
     describe_file "$remote_mode" "remote" "$REMOTE"
     printf "Hit return to start merge resolution tool ($merge_tool): "
-- 
1.5.1.rc2.1.g8afe-dirty
