From: Lars Hjemli <hjemli@gmail.com>
Subject: [PATCH 3/3] Teach git-branch -v and -w options
Date: Sun, 22 Oct 2006 13:30:26 +0200
Message-ID: <11615166273819-git-send-email-hjemli@gmail.com>
References: <1161516626749-git-send-email-hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 22 13:30:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GbbXG-0005Lw-FW
	for gcvg-git@gmane.org; Sun, 22 Oct 2006 13:30:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932391AbWJVLab (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Oct 2006 07:30:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964839AbWJVLab
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Oct 2006 07:30:31 -0400
Received: from mail47.e.nsc.no ([193.213.115.47]:40437 "EHLO mail47.e.nsc.no")
	by vger.kernel.org with ESMTP id S932393AbWJVLa1 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 22 Oct 2006 07:30:27 -0400
Received: from localhost.localdomain (ti231210a080-7372.bb.online.no [80.213.28.208])
	by mail47.nsc.no (8.13.8/8.13.5) with ESMTP id k9MBUPPp003655
	for <git@vger.kernel.org>; Sun, 22 Oct 2006 13:30:26 +0200 (CEST)
To: git@vger.kernel.org
X-Mailer: git-send-email 1.4.3.1.g1688
In-Reply-To: <1161516626749-git-send-email-hjemli@gmail.com>
Message-Id: <18d62bea290e360a4b5b44df9f23265c5e77964e.1161516129.git.hjemli@gmail.com>
In-Reply-To: <5245bfe3982f5c23841229af9f548f982b9c60c3.1161516129.git.hjemli@gmail.com>
References: <5245bfe3982f5c23841229af9f548f982b9c60c3.1161516129.git.hjemli@gmail.com>
Date: Sun, 22 Oct 2006 13:20:34 +0200
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This makes git-branch display sha1 and first line of commit
message for each branch.

Additionaly, the -w option may be used to specify columnwidth
for branchname (default is 20 characters)

Signed-off-by: Lars Hjemli <hjemli@gmail.com>
---
 Documentation/git-branch.txt |    8 ++++++-
 git-branch.sh                |   47 ++++++++++++++++++++++++++++++++++++-----
 2 files changed, 48 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
index d43ef1d..efbab61 100644
--- a/Documentation/git-branch.txt
+++ b/Documentation/git-branch.txt
@@ -8,7 +8,7 @@ git-branch - List, create, or delete bra
 SYNOPSIS
 --------
 [verse]
-'git-branch' [-r]
+'git-branch' [-r] [-v [-w width]]
 'git-branch' [-l] [-f] <branchname> [<start-point>]
 'git-branch' (-d | -D) <branchname>...
 
@@ -47,6 +47,12 @@ OPTIONS
 -r::
 	List only the "remote" branches.
 
+-v::
+	Show sha1 and first line of commit message for each branch
+
+-w <width>::
+	Set columnwidth for branchname display
+
 <branchname>::
 	The name of the branch to create or delete.
 	The new branch name must pass all checks defined by
diff --git a/git-branch.sh b/git-branch.sh
index 1f628a4..73839b4 100755
--- a/git-branch.sh
+++ b/git-branch.sh
@@ -1,6 +1,6 @@
 #!/bin/sh
 
-USAGE=' [-l] [-f] <branchname> [<start-point>] | (-d | -D) <branchname> | [-r]'
+USAGE=' [-l] [-f] <branchname> [<start-point>] | (-d | -D) <branchname> | [-r] [-v [-w width]]'
 LONG_USAGE='If no arguments, show available branches and mark current branch with a star.
 If one argument, create a new branch <branchname> based off of current HEAD.
 If two arguments, create a new branch <branchname> based off of <start-point>.'
@@ -49,12 +49,26 @@ If you are sure you want to delete it, r
 }
 
 ls_remote_branches () {
+	verbose="$1"
+	width="$2"
     git-rev-parse --symbolic --all |
     sed -ne 's|^refs/\(remotes/\)|\1|p' |
-    sort
+    sort |
+    while read ref
+    do
+		if test "$verbose" = "yes"
+		then
+			log=$(git-log --pretty=oneline --max-count=1 "$ref")
+			printf "%-*s %s\n" "$width" "$ref" "$log"
+		else
+			echo "$ref"
+		fi
+	done
 }
 
 ls_local_branches () {
+	verbose="$1"
+	width="$2"
 	git-rev-parse --symbolic --branches |
 	sort |
 	while read ref
@@ -65,12 +79,22 @@ ls_local_branches () {
 		else
 			pfx=' '
 		fi
-		echo "$pfx $ref"
+		if test "$verbose" = "yes"
+		then
+			log=$(git-log --pretty=oneline --max-count=1 "$ref")
+			printf "%s %-*s %s\n" "$pfx" "$width" "$ref" "$log"
+		else
+			echo "$pfx $ref"
+		fi
 	done
 }
 
 force=
 create_log=
+remotes=
+verbose=
+width=20
+
 while case "$#,$1" in 0,*) break ;; *,-*) ;; *) break ;; esac
 do
 	case "$1" in
@@ -79,8 +103,14 @@ do
 		exit
 		;;
 	-r)
-		ls_remote_branches
-		exit
+		remotes="yes"
+		;;
+	-v)
+		verbose="yes"
+		;;
+	-w)
+		shift
+		width="$1"
 		;;
 	-f)
 		force="$1"
@@ -101,7 +131,12 @@ done
 
 case "$#" in
 0)
-	ls_local_branches
+	if test "$remotes" = "yes"
+	then
+		ls_remote_branches "$verbose" "$width"
+	else
+		ls_local_branches "$verbose" "$width"
+	fi
 	exit 0 ;;
 1)
 	head=HEAD ;;
-- 
1.4.3.1.g1688
