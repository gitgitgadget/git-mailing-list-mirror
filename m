From: skimo@liacs.nl
Subject: [PATCH 10/15] git-checkout: pass --submodules option to git-read-tree
Date: Sun, 20 May 2007 20:04:43 +0200
Message-ID: <11796842892738-git-send-email-skimo@liacs.nl>
References: <11796842882917-git-send-email-skimo@liacs.nl>
To: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun May 20 20:05:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hppmr-0007La-S1
	for gcvg-git@gmane.org; Sun, 20 May 2007 20:05:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756920AbXETSFO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 20 May 2007 14:05:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757303AbXETSFO
	(ORCPT <rfc822;git-outgoing>); Sun, 20 May 2007 14:05:14 -0400
Received: from rhodium.liacs.nl ([132.229.131.16]:37215 "EHLO rhodium.liacs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756963AbXETSFE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 May 2007 14:05:04 -0400
Received: from pc117b.liacs.nl (pc117b.liacs.nl [132.229.129.143])
	by rhodium.liacs.nl (8.13.0/8.13.0/LIACS 1.4) with ESMTP id l4KI4rZW007820;
	Sun, 20 May 2007 20:04:58 +0200
Received: by pc117b.liacs.nl (Postfix, from userid 17122)
	id B1FCB7DDA9; Sun, 20 May 2007 20:04:49 +0200 (CEST)
X-Mailer: git-send-email 1.5.0.rc3.1762.g0934
In-Reply-To: <11796842882917-git-send-email-skimo@liacs.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47868>

From: Sven Verdoolaege <skimo@kotnet.org>

Signed-off-by: Sven Verdoolaege <skimo@kotnet.org>
---
 git-checkout.sh |   20 +++++++++++++++-----
 1 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/git-checkout.sh b/git-checkout.sh
index 6b6facf..162cef4 100755
--- a/git-checkout.sh
+++ b/git-checkout.sh
@@ -1,6 +1,6 @@
 #!/bin/sh
 
-USAGE='[-q] [-f] [-b <new_branch>] [-m] [<branch>] [<paths>...]'
+USAGE='[-q] [-f] [--submodules] [--no-submodules] [-b <new_branch>] [-m] [<branch>] [<paths>...]'
 SUBDIRECTORY_OK=Sometimes
 . git-sh-setup
 require_work_tree
@@ -16,6 +16,7 @@ track=
 newbranch=
 newbranch_log=
 merge=
+submodules=
 quiet=
 v=-v
 LF='
@@ -46,6 +47,15 @@ while [ "$#" != "0" ]; do
 	-m)
 		merge=1
 		;;
+	--su|--sub|--subm|--submo|--submod|--submodu|--submodul|\
+	--submodule|--submodules)
+		submodules="--submodules"
+		;;
+	--no-su|--no-sub|--no-subm|--no-submo|--no-submod|\
+	--no-submodu|--no-submodul|\
+	--no-submodule|--no-submodules)
+		submodules="--no-submodules"
+		;;
 	"-q")
 		quiet=1
 		v=
@@ -199,10 +209,10 @@ fi
 
 if [ "$force" ]
 then
-    git-read-tree $v --reset -u $new
+    git-read-tree $v $submodules --reset -u $new
 else
     git-update-index --refresh >/dev/null
-    merge_error=$(git-read-tree -m -u --exclude-per-directory=.gitignore $old $new 2>&1) || (
+    merge_error=$(git-read-tree $submodules -m -u --exclude-per-directory=.gitignore $old $new 2>&1) || (
 	case "$merge" in
 	'')
 		echo >&2 "$merge_error"
@@ -212,7 +222,7 @@ else
 	# Match the index to the working tree, and do a three-way.
     	git diff-files --name-only | git update-index --remove --stdin &&
 	work=`git write-tree` &&
-	git read-tree $v --reset -u $new || exit
+	git read-tree $v $submodules --reset -u $new || exit
 
 	eval GITHEAD_$new='${new_name:-${branch:-$new}}' &&
 	eval GITHEAD_$work=local &&
@@ -223,7 +233,7 @@ else
 	# this is not a real merge before committing, but just carrying
 	# the working tree changes along.
 	unmerged=`git ls-files -u`
-	git read-tree $v --reset $new
+	git read-tree $v $submodules --reset $new
 	case "$unmerged" in
 	'')	;;
 	*)
-- 
1.5.2.rc3.815.g8fc2
