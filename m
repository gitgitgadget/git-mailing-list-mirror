From: Lars Hjemli <hjemli@gmail.com>
Subject: [PATCH 1/3] Make git-branch honor -v when showing remote branches
Date: Sun, 22 Oct 2006 00:33:22 +0200
Message-ID: <11614700063520-git-send-email-hjemli@gmail.com>
References: <1161470004894-git-send-email-hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Sun Oct 22 00:33:35 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GbPPI-0003AE-HV
	for gcvg-git@gmane.org; Sun, 22 Oct 2006 00:33:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422851AbWJUWd2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Oct 2006 18:33:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422857AbWJUWd2
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Oct 2006 18:33:28 -0400
Received: from mail48.e.nsc.no ([193.213.115.48]:6320 "EHLO mail48.e.nsc.no")
	by vger.kernel.org with ESMTP id S1422851AbWJUWd0 (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 21 Oct 2006 18:33:26 -0400
Received: from localhost.localdomain (ti231210a080-7372.bb.online.no [80.213.28.208])
	by mail48.nsc.no (8.13.8/8.13.5) with ESMTP id k9LMXOmQ026850
	for <git@vger.kernel.org>; Sun, 22 Oct 2006 00:33:25 +0200 (CEST)
To: git@vger.kernel.org
X-Mailer: git-send-email 1.4.3.1
In-Reply-To: <1161470004894-git-send-email-hjemli@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29682>

Signed-off-by: Lars Hjemli <hjemli@gmail.com>
---
 git-branch.sh |   74 ++++++++++++++++++++++++++++++++++++--------------------
 1 files changed, 47 insertions(+), 27 deletions(-)

diff --git a/git-branch.sh b/git-branch.sh
index ab58737..25abd4c 100755
--- a/git-branch.sh
+++ b/git-branch.sh
@@ -1,6 +1,6 @@
 #!/bin/sh
 
-USAGE='[-l] [(-d | -D) <branchname>] | [[-f] <branchname> [<start-point>]] | -r | -v'
+USAGE='[-r] [-v] | (-d | -D) <branchname> | [-l] [-f] <branchname> [<start-point>]'
 LONG_USAGE='If no arguments, show available branches and mark current branch with a star.
 If one argument, create a new branch <branchname> based off of current HEAD.
 If two arguments, create a new branch <branchname> based off of <start-point>.'
@@ -48,15 +48,48 @@ If you are sure you want to delete it, r
     exit 0
 }
 
-ls_remote_branches () {
-    git-rev-parse --symbolic --all |
-    sed -ne 's|^refs/\(remotes/\)|\1|p' |
-    sort
-}
-
 force=
 create_log=
 verbose=
+remotes=
+
+ls_remote_branches () {
+	git-rev-parse --symbolic --all |
+	sed -ne 's|^refs/\(remotes/\)|\1|p' |
+	sort |
+	while read ref
+	do
+		if test "$verbose" = "yes"
+		then
+			log=$(git-log --max-count=1 --pretty=oneline $ref)
+			printf "%-20s %s\n" "$ref" "$log"
+		else
+			echo "$ref"
+		fi
+	done
+}
+
+ls_local_branches() {
+	git-rev-parse --symbolic --branches |
+	sort |
+	while read ref
+	do
+		if test "$headref" = "$ref"
+		then
+			pfx='*'
+		else
+			pfx=' '
+		fi
+		if test "$verbose" = "yes"
+		then
+			log=$(git-log --max-count=1 --pretty=oneline $ref)
+			printf "%s %-20s %s\n" "$pfx" "$ref" "$log"
+		else
+			echo "$pfx $ref"
+		fi
+	done
+}
+
 while case "$#,$1" in 0,*) break ;; *,-*) ;; *) break ;; esac
 do
 	case "$1" in
@@ -65,8 +98,7 @@ do
 		exit
 		;;
 	-r)
-		ls_remote_branches
-		exit
+		remotes="yes"
 		;;
 	-f)
 		force="$1"
@@ -90,24 +122,12 @@ done
 
 case "$#" in
 0)
-	git-rev-parse --symbolic --branches |
-	sort |
-	while read ref
-	do
-		if test "$headref" = "$ref"
-		then
-			pfx='*'
-		else
-			pfx=' '
-		fi
-		if test "$verbose" = "yes"
-		then
-			log=$(git-log --max-count=1 --pretty=oneline $ref)
-			printf "%s %-20s %s\n" "$pfx" "$ref" "$log"
-		else
-			echo "$pfx $ref"
-		fi
-	done
+	if test "$remotes" = "yes"
+	then
+		ls_remote_branches
+	else
+		ls_local_branches
+	fi
 	exit 0 ;;
 1)
 	head=HEAD ;;
-- 
1.4.3.1
