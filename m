From: Petr Baudis <pasky@ucw.cz>
Subject: [PATCH] git-merge-one-file-script cleanups from Cogito
Date: Thu, 9 Jun 2005 01:38:20 +0200
Message-ID: <20050608233820.GB9782@pasky.ji.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 09 01:36:28 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DgA5K-0005lC-48
	for gcvg-git@gmane.org; Thu, 09 Jun 2005 01:35:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261540AbVFHXiv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Jun 2005 19:38:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261541AbVFHXiv
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Jun 2005 19:38:51 -0400
Received: from w241.dkm.cz ([62.24.88.241]:55268 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261540AbVFHXiW (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Jun 2005 19:38:22 -0400
Received: (qmail 13858 invoked by uid 2001); 8 Jun 2005 23:38:20 -0000
To: torvalds@osdl.org
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Chain the resolving sequences (e.g. git-cat-file - chmod -
git-update-cache) through &&s so we stop right away in case one of the
command fails, and report the error code to the script caller.

Also add a copyright notice, some blank lines, ;; on a separate line,
and nicer error messages.

Signed-off-by: Petr Baudis <pasky@ucw.cz>

---
commit 99169278864b1adba5494d34f86c00d08ec0aff2
tree 5b9129ffe38c4286f65a6ddf97a0674bfc8942e3
parent c7773b6b3ab4f03a4e64084c0dc67045b283bc34
author Petr Baudis <pasky@ucw.cz> Thu, 09 Jun 2005 01:03:14 +0200
committer Petr Baudis <xpasky@machine.sinus.cz> Thu, 09 Jun 2005 01:03:14 +0200

 git-merge-one-file-script |   44 +++++++++++++++++++++++++++++---------------
 1 files changed, 29 insertions(+), 15 deletions(-)

diff --git a/git-merge-one-file-script b/git-merge-one-file-script
--- a/git-merge-one-file-script
+++ b/git-merge-one-file-script
@@ -1,6 +1,8 @@
 #!/bin/sh
 #
-# This is the git merge script, called with
+# Copyright (c) Linus Torvalds, 2005
+#
+# This is the git per-file merge script, called with
 #
 #   $1 - original file SHA1 (or empty)
 #   $2 - file in branch1 SHA1 (or empty)
@@ -12,7 +14,7 @@
 #
 # Handle some trivial cases.. The _really_ trivial cases have
 # been handled already by git-read-tree, but that one doesn't
-# do any merges that migth change the tree layout.
+# do any merges that might change the tree layout.
 
 case "${1:-.}${2:-.}${3:-.}" in
 #
@@ -21,23 +23,29 @@ case "${1:-.}${2:-.}${3:-.}" in
 "$1..")
 	echo "WARNING: $4 is removed in both branches."
 	echo "WARNING: This is a potential rename conflict."
-	exec git-update-cache --remove -- "$4" ;;
+	exec git-update-cache --remove -- "$4"
+	;;
+
 #
 # Deleted in one and unchanged in the other.
 #
-"$1.." | "$1.$1" | "$1$1.")
+"$1.$1" | "$1$1.")
 	echo "Removing $4"
-	rm -f -- "$4"
-	exec git-update-cache --remove -- "$4" ;;
+	exec rm -f -- "$4" &&
+		git-update-cache --remove -- "$4"
+	;;
+
 #
 # Added in one.
 #
 ".$2." | "..$3" )
 	case "$6$7" in *7??) mode=+x;; *) mode=-x;; esac
 	echo "Adding $4 with perm $mode."
-	git-cat-file blob "$2$3" > "$4"
-	chmod $mode -- "$4"
-	exec git-update-cache --add -- "$4" ;;
+	exec git-cat-file blob "$2$3" >"$4" &&
+		chmod $mode -- "$4" &&
+		git-update-cache --add -- "$4"
+	;;
+
 #
 # Added in both (check for same permissions).
 #
@@ -49,9 +57,11 @@ case "${1:-.}${2:-.}${3:-.}" in
 	fi
 	case "$6" in *7??) mode=+x;; *) mode=-x;; esac
 	echo "Adding $4 with perm $mode"
-	git-cat-file blob "$2" > "$4"
-	chmod $mode -- "$4"
-	exec git-update-cache --add -- "$4" ;;
+	exec git-cat-file blob "$2" >"$4" &&
+		chmod $mode -- "$4" &&
+		git-update-cache --add -- "$4"
+	;;
+
 #
 # Modified in both, but differently.
 #
@@ -60,12 +70,13 @@ case "${1:-.}${2:-.}${3:-.}" in
 	orig=`git-unpack-file $1`
 	src1=`git-unpack-file $2`
 	src2=`git-unpack-file $3`
+
 	merge -p "$src1" "$orig" "$src2" > "$4"
 	ret=$?
 	rm -f -- "$orig" "$src1" "$src2"
 
 	if [ "$6" != "$7" ]; then
-		echo "ERROR: Permissions $5->$6->$7 don't match."
+		echo "ERROR: Permissions conflict: $5->$6,$7."
 		ret=1
 	fi
 	case "$6" in *7??) mode=+x;; *) mode=-x;; esac
@@ -78,8 +89,11 @@ case "${1:-.}${2:-.}${3:-.}" in
 		echo "ERROR: Merge conflict in $4."
 		exit 1
 	fi
-	exec git-update-cache --add -- "$4" ;;
+	exec git-update-cache --add -- "$4"
+	;;
+
 *)
-	echo "ERROR: Not handling case $4: $1 -> $2 -> $3" ;;
+	echo "ERROR: $4: Not handling case $1 -> $2 -> $3"
+	;;
 esac
 exit 1

|
-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
<Espy> be careful, some twit might quote you out of context..
