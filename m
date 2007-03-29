From: Theodore Ts'o <tytso@mit.edu>
Subject: [PATCH] mergetool: factor out common code
Date: Thu, 29 Mar 2007 11:44:20 -0400
Message-ID: <11751830654112-git-send-email-tytso@mit.edu>
References: <11751830653554-git-send-email-tytso@mit.edu> <11751830653871-git-send-email-tytso@mit.edu> <11751830651770-git-send-email-tytso@mit.edu> <11751830653157-git-send-email-tytso@mit.edu> <1175183065710-git-send-email-tytso@mit.edu> <11751830651361-git-send-email-tytso@mit.edu>
Cc: git@vger.kernel.org, Theodore Ts'o <tytso@mit.edu>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Thu Mar 29 17:45:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HWwoK-0004BP-SY
	for gcvg-git@gmane.org; Thu, 29 Mar 2007 17:45:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030258AbXC2Pol (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 29 Mar 2007 11:44:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030268AbXC2Pok
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Mar 2007 11:44:40 -0400
Received: from thunk.org ([69.25.196.29]:36600 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030258AbXC2Pob (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Mar 2007 11:44:31 -0400
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1HWwte-0007J1-Uy; Thu, 29 Mar 2007 11:50:43 -0400
Received: from tytso by candygram.thunk.org with local (Exim 4.62)
	(envelope-from <tytso@thunk.org>)
	id 1HWwnZ-0000xh-Gn; Thu, 29 Mar 2007 11:44:25 -0400
X-Mailer: git-send-email 1.5.1.rc2.1.g8afe-dirty
In-Reply-To: <11751830651361-git-send-email-tytso@mit.edu>
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43444>

Create common function check_unchanged(), save_backup() and
remove_backup().

Also fix some minor whitespace issues while we're at it.

Signed-off-by: "Theodore Ts'o" <tytso@mit.edu>
---
 git-mergetool.sh |   80 +++++++++++++++++++++++++-----------------------------
 1 files changed, 37 insertions(+), 43 deletions(-)

diff --git a/git-mergetool.sh b/git-mergetool.sh
index 8a87f5e..aeb32ef 100755
--- a/git-mergetool.sh
+++ b/git-mergetool.sh
@@ -46,7 +46,7 @@ describe_file () {
 
     printf "    "
     if test -z "$mode"; then
-	printf  "'$path' was deleted"
+	printf "'$path' was deleted"
     elif is_symlink "$mode" ; then
 	printf "'$path' is a symlink containing '"
 	cat "$file"
@@ -108,12 +108,40 @@ resolve_deleted_merge () {
 	done
 }
 
+check_unchanged () {
+    if test "$path" -nt "$BACKUP" ; then
+	status=0;
+    else
+	while true; do
+	    echo "$path seems unchanged."
+	    printf "Was the merge successful? [y/n] "
+	    read answer < /dev/tty
+	    case "$answer" in
+		y*|Y*) status=0; break ;;
+		n*|N*) status=1; break ;;
+	    esac
+	done
+    fi
+}
+
+save_backup () {
+    if test "$status" -eq 0; then
+	mv -- "$BACKUP" "$path.orig"
+    fi
+}
+
+remove_backup () {
+    if test "$status" -eq 0; then
+	rm "$BACKUP"
+    fi
+}
+
 merge_file () {
     path="$1"
 
     f=`git-ls-files -u -- "$path"`
     if test -z "$f" ; then
-        if test ! -f "$path" ; then
+	if test ! -f "$path" ; then
 	    echo "$path: file not found"
 	else
 	    echo "$path: file does not need merging"
@@ -169,9 +197,7 @@ merge_file () {
 		    -o "$path" -- "$LOCAL" "$REMOTE" > /dev/null 2>&1)
 	    fi
 	    status=$?
-	    if test "$status" -eq 0; then
-		rm "$BACKUP"
-	    fi
+	    remove_backup
 	    ;;
 	tkdiff)
 	    if base_present ; then
@@ -180,29 +206,13 @@ merge_file () {
 		tkdiff -o "$path" -- "$LOCAL" "$REMOTE"
 	    fi
 	    status=$?
-	    if test "$status" -eq 0; then
-		mv -- "$BACKUP" "$path.orig"
-	    fi
+	    save_backup
 	    ;;
 	meld|vimdiff)
 	    touch "$BACKUP"
 	    $merge_tool -- "$LOCAL" "$path" "$REMOTE"
-	    if test "$path" -nt "$BACKUP" ; then
-		status=0;
-	    else
-		while true; do
-		    echo "$path seems unchanged."
-		    printf "Was the merge successful? [y/n] "
-		    read answer < /dev/tty
-		    case "$answer" in
-			y*|Y*) status=0; break ;;
-			n*|N*) status=1; break ;;
-		    esac
-		done
-	    fi
-	    if test "$status" -eq 0; then
-		mv -- "$BACKUP" "$path.orig"
-	    fi
+	    check_unchanged
+	    save_backup
 	    ;;
 	xxdiff)
 	    touch "$BACKUP"
@@ -219,22 +229,8 @@ merge_file () {
 		    -R 'Accel.SearchForward: "Ctrl-G"' \
 		    --merged-file "$path" -- "$LOCAL" "$REMOTE"
 	    fi
-	    if test "$path" -nt "$BACKUP" ; then
-		status=0;
-	    else
-		while true; do
-		    echo "$path seems unchanged."
-		    printf "Was the merge successful? [y/n] "
-		    read answer < /dev/tty
-		    case "$answer" in
-			y*|Y*) status=0; break ;;
-			n*|N*) status=1; break ;;
-		    esac
-		done
-	    fi
-	    if test "$status" -eq 0; then
-		mv -- "$BACKUP" "$path.orig"
-	    fi
+	    check_unchanged
+	    save_backup
 	    ;;
 	emerge)
 	    if base_present ; then
@@ -243,9 +239,7 @@ merge_file () {
 		emacs -f emerge-files-command "$LOCAL" "$REMOTE" "$path"
 	    fi
 	    status=$?
-	    if test "$status" -eq 0; then
-		mv -- "$BACKUP" "$path.orig"
-	    fi
+	    save_backup
 	    ;;
     esac
     if test "$status" -ne 0; then
-- 
1.5.1.rc2.1.g8afe-dirty
