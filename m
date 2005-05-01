From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Really fix git-merge-one-file-script this time.
Date: Sun, 01 May 2005 02:29:49 -0700
Message-ID: <7vd5sbz436.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun May 01 11:24:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DSAga-0001IN-DJ
	for gcvg-git@gmane.org; Sun, 01 May 2005 11:24:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261572AbVEAJaC (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 1 May 2005 05:30:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261574AbVEAJaC
	(ORCPT <rfc822;git-outgoing>); Sun, 1 May 2005 05:30:02 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:765 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S261572AbVEAJ3y (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 May 2005 05:29:54 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050501092950.LQRH23392.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 1 May 2005 05:29:50 -0400
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

The merge-cache program was updated to pass executable bits when
calling git-merge-one-file-script, but the called script
supplied as an example were not using them carefully.

This patch fixes the following problems in the script:

 * When a new file is created in a directory, which is a file in
   the work tree, it tried to create leading directory but did
   not check for failure from the "mkdir -p" command.

 * The script did not check the exit status from the
   git-update-cache command at all.

 * The parameter "$4" to the script is a file name that can
   contain almost any characters, so it must be quoted with
   double quotes and also needs to be preceded with -- to mark
   it as a non-option when passed to certain commands.

 * The chmod command was used with parameter "$6" or "$7" to set
   the mode bits.  This contradicts with the strategy taken by
   checkout-cache, where we honor user's umask and force only
   the executable bits.  With this patch, it creates a new file
   by redirecting into it (thus honoring user's default umask),
   and then uses "chmod +x" if we want the resulting file
   executable.  Without this fix, the merge result becomes 0644
   or 0755 for users whose umask is 002 for whom it should
   become 0664 or 0775.

 * When "$1 -> $2 -> $3" case was not handled, the script did
   not say which path it was working on, which was not so useful
   when used with the -a option of git-merge-cache.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

git-merge-one-file-script |   41 ++++++++++++++++++-----------------------
1 files changed, 18 insertions(+), 23 deletions(-)

# - [PATCH] Resurrect diff-tree-helper -R
# + [PATCH] Really fix git-merge-one-file-script this time.
--- k/git-merge-one-file-script
+++ l/git-merge-one-file-script
@@ -16,7 +16,7 @@
 # if the directory is newly added in a branch, it might not exist
 # in the current tree
 dir=$(dirname "$4")
-mkdir -p "$dir"
+mkdir -p "$dir" || exit
 
 case "${1:-.}${2:-.}${3:-.}" in
 #
@@ -30,22 +30,18 @@ case "${1:-.}${2:-.}${3:-.}" in
 # deleted in one and unchanged in the other
 #
 "$1.." | "$1.$1" | "$1$1.")
-	rm -f -- "$4"
 	echo "Removing $4"
-	git-update-cache --remove -- "$4"
-	exit 0
-	;;
-
+	rm -f -- "$4" && exec git-update-cache --remove -- "$4" ;;
 #
 # added in one
 #
 ".$2." | "..$3" )
-	echo "Adding $4 with perm $6$7"
-	mv $(git-unpack-file "$2$3") $4
-	chmod "$6$7" $4
-	git-update-cache --add -- $4
-	exit 0
-	;;
+	case "$6$7" in *7??) mode=+x;; *) mode=-x;; esac
+	echo "Adding $4 with perm $mode"
+	rm -f -- "$4" &&
+	git-cat-file blob "$2$3" >"$4" &&
+	chmod "$mode" -- "$4" &&
+	exec git-update-cache --add -- "$4" ;;
 #
 # Added in both (check for same permissions)
 #
@@ -54,11 +50,12 @@ case "${1:-.}${2:-.}${3:-.}" in
 		echo "ERROR: File $4 added in both branches, permissions conflict $6->$7"
 		exit 1
 	fi
-	echo "Adding $4 with perm $6"
-	mv $(git-unpack-file "$2") $4
-	chmod "$6" $4
-	git-update-cache --add -- $4
-	exit 0;;
+	case "$6" in *7??) mode=+x;; *) mode=-x;; esac
+	echo "Adding $4 with perm $mode"
+	rm -f -- "$4" &&
+	git-cat-file blob "$2" >"$4" &&
+	chmod "$mode" -- "$4" &&
+	exec git-update-cache --add -- "$4" ;;
 #
 # Modified in both, but differently ;(
 #
@@ -76,16 +73,14 @@ case "${1:-.}${2:-.}${3:-.}" in
 		fi
 		exit 1
 	fi
-	chmod -- "$6" "$src2"
 	if [ $ret -ne 0 ]; then
 		echo "ERROR: Leaving conflict merge in $src2"
 		exit 1
 	fi
-	cp -- "$src2" "$4" && chmod -- "$6" "$4" &&  git-update-cache --add -- "$4" && exit 0
-	;;
-
+	case "$6" in *7??) mode=+x;; *) mode=-x;; esac
+	rm -f -- "$4" && cat "$src2" >"$4" && chmod "$mode" -- "$4" &&
+	exec git-update-cache --add -- "$4" ;;
 *)
-	echo "Not handling case $1 -> $2 -> $3"
-	;;
+	echo "Not handling case $4: $1 -> $2 -> $3" ;;
 esac
 exit 1

