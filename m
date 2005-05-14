From: Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH cogito] "cg-whatsnew" command
Date: Sat, 14 May 2005 11:58:04 +0100
Message-ID: <tnx64xm5b2b.fsf@arm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
X-From: git-owner@vger.kernel.org Sat May 14 12:59:10 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DWuM4-0000my-Fn
	for gcvg-git@gmane.org; Sat, 14 May 2005 12:58:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262730AbVENK6o (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 14 May 2005 06:58:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262735AbVENK6o
	(ORCPT <rfc822;git-outgoing>); Sat, 14 May 2005 06:58:44 -0400
Received: from cam-admin0.cambridge.arm.com ([193.131.176.58]:19620 "EHLO
	cam-admin0.cambridge.arm.com") by vger.kernel.org with ESMTP
	id S262730AbVENK6Q (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 May 2005 06:58:16 -0400
Received: from cam-mail2.cambridge.arm.com (cam-mail2.cambridge.arm.com [10.1.127.39])
	by cam-admin0.cambridge.arm.com (8.12.10/8.12.10) with ESMTP id j4EAwAfj019701
	for <git@vger.kernel.org>; Sat, 14 May 2005 11:58:10 +0100 (BST)
Received: from localhost.localdomain (cmarinas@pc1117.cambridge.arm.com [10.1.69.144])
	by cam-mail2.cambridge.arm.com (8.9.3/8.9.3) with ESMTP id LAA22577
	for <git@vger.kernel.org>; Sat, 14 May 2005 11:58:14 +0100 (BST)
To: git@vger.kernel.org
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

--=-=-=

This patch adds a simple command that shows the unmerged changes on a
branch. I find it quite useful to be able to see the diff or the log
before merging (gnuarch has something similar with "missing").

Catalin


--=-=-=
Content-Type: text/x-patch
Content-Disposition: inline; filename=patch-cg-whatsnew

Added the "cg-whatsnew" command

The command shows the unmerged changes on a branch (defaulting to 
"origin") as either a diff, log or patch.

Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>

---
commit e396c64c7f84c45a1360d34bcb6092b62183df7d
tree c143a31ed694000b705c5019bb10ec3b3f911344
parent fa6e9eb368e949e78c4e66217461cf624b52b0a2
author Catalin Marinas <cmarinas@pc1117.cambridge.arm.com> Sat, 14 May 2005 11:47:52 +0100
committer Catalin Marinas <cmarinas@pc1117.cambridge.arm.com> Sat, 14 May 2005 11:47:52 +0100

 Makefile    |    3 +-
 cg-help     |    1 
 cg-whatsnew |   63 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 66 insertions(+), 1 deletion(-)

Index: Makefile
===================================================================
--- de641904363cd3759f132ee7c0dfaf8a2ee58388/Makefile  (mode:100644)
+++ c143a31ed694000b705c5019bb10ec3b3f911344/Makefile  (mode:100644)
@@ -49,7 +49,8 @@
 SCRIPT=	commit-id tree-id parent-id cg-add cg-admin-lsobj cg-admin-uncommit \
 	cg-branch-add cg-branch-ls cg-cancel cg-clone cg-commit cg-diff \
 	cg-export cg-help cg-init cg-log cg-ls cg-merge cg-mkpatch cg-patch \
-	cg-pull cg-restore cg-rm cg-seek cg-status cg-tag cg-tag-ls cg-update
+	cg-pull cg-restore cg-rm cg-seek cg-status cg-tag cg-tag-ls cg-update \
+	cg-whatsnew
 
 LIB_SCRIPT=cg-Xlib cg-Xdiffdo cg-Xmergefile
 
Index: cg-help
===================================================================
--- de641904363cd3759f132ee7c0dfaf8a2ee58388/cg-help  (mode:100755)
+++ c143a31ed694000b705c5019bb10ec3b3f911344/cg-help  (mode:100755)
@@ -44,6 +44,7 @@
 	cg-tag-ls
 	cg-update	[BNAME]
 	cg-version
+	cg-whatsnew	[-n] [-l | -m] [BNAME]
 
 Advanced (low-level or dangerous) commands:
 	cg-admin-lsobj	[OBJTYPE]
Index: cg-whatsnew
===================================================================
--- /dev/null  (tree:de641904363cd3759f132ee7c0dfaf8a2ee58388)
+++ c143a31ed694000b705c5019bb10ec3b3f911344/cg-whatsnew  (mode:100755)
@@ -0,0 +1,63 @@
+#!/usr/bin/env bash
+#
+# Shows the unmerged changes on a branch
+# Copyright (c) Catalin Marinas, 2005
+#
+# Takes a parameter identifying the branch (defaulting to "origin").
+# Optional "-n" parameter specifies not to pull the changes from the branch.
+#
+# By default, shows the unmerged diff of the branch.
+# Optional "-l" parameter specifies to show the log instead of the diff
+# Optional "-m" parameter specifies to show the mkpatch instead of the diff
+
+. ${COGITO_LIB:-/home/cmarinas/lib/cogito/}cg-Xlib
+
+head=$(commit-id)
+show_cmd=cg-diff
+
+do_not_pull=
+if [ "$1" = "-n" ]; then
+	shift
+	do_not_pull=1
+fi
+
+while [ "$1" ]; do
+	case "$1" in
+	-n)
+		do_not_pull=1
+		shift
+		;;
+	-l)
+		show_cmd=cg-log
+		shift
+		;;
+	-m)
+		show_cmd=cg-mkpatch
+		shift
+		;;
+	-*)
+		die "Unknown option: $1"
+		;;
+	*)
+		break
+		;;
+	esac
+done
+
+if [ "$1" ]; then
+	branchname="$1"
+else
+	branchname=origin
+fi
+
+[ "$do_not_pull" ] || cg-pull $branchname
+
+branch=$(commit-id "$branchname") || exit 1
+base=$(git-merge-base "$head" "$branch")
+[ "$base" ] || die "Unable to determine the merge base"
+
+if [ "$base" = "$branch" ]; then
+	echo "Branch already fully merged" >&2
+else
+	$show_cmd -r $base:$branch
+fi

--=-=-=--

