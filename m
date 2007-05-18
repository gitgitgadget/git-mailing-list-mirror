From: skimo@liacs.nl
Subject: [PATCH 10/16] git-checkout: pass --submodules option to git-read-tree
Date: Fri, 18 May 2007 21:24:59 +0200
Message-ID: <11795163073176-git-send-email-skimo@liacs.nl>
References: <11795163053812-git-send-email-skimo@liacs.nl>
To: git@vger.kernel.org, Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri May 18 21:25:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hp852-0002MY-4S
	for gcvg-git@gmane.org; Fri, 18 May 2007 21:25:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756834AbXERTZ1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 May 2007 15:25:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757894AbXERTZ0
	(ORCPT <rfc822;git-outgoing>); Fri, 18 May 2007 15:25:26 -0400
Received: from rhodium.liacs.nl ([132.229.131.16]:55756 "EHLO rhodium.liacs.nl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757491AbXERTZW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 May 2007 15:25:22 -0400
Received: from pc117b.liacs.nl (pc117b.liacs.nl [132.229.129.143])
	by rhodium.liacs.nl (8.13.0/8.13.0/LIACS 1.4) with ESMTP id l4IJPDqs005204;
	Fri, 18 May 2007 21:25:18 +0200
Received: by pc117b.liacs.nl (Postfix, from userid 17122)
	id 330CC7DDA9; Fri, 18 May 2007 21:25:07 +0200 (CEST)
X-Mailer: git-send-email 1.5.0.rc3.1762.g0934
In-Reply-To: <11795163053812-git-send-email-skimo@liacs.nl>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47639>

From: Sven Verdoolaege <skimo@kotnet.org>

Signed-off-by: Sven Verdoolaege <skimo@kotnet.org>
---
 git-checkout.sh |   20 +++++++++++++++-----
 1 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/git-checkout.sh b/git-checkout.sh
index 6b6facf..cbb1f00 100755
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
+	*,--su|*,--sub|*,--subm|*,--submo|*,--submod|*,--submodu|*,--submodul|\
+	*,--submodule|*,--submodules)
+		submodules="--submodules"
+		;;
+	*,--no-su|*,--no-sub|*,--no-subm|*,--no-submo|*,--no-submod|\
+	*,--no-submodu|*,--no-submodul|\
+	*,--no-submodule|*,--no-submodules)
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
1.5.2.rc3.783.gc7476-dirty
