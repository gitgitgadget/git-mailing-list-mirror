From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 2/3] git-cherry: find commits not merged upstream.
Date: Thu, 23 Jun 2005 16:28:27 -0700
Message-ID: <7vaclgejqc.fsf_-_@assigned-by-dhcp.cox.net>
References: <1119284365.3926.15.camel@localhost.localdomain>
	<7vbr61j631.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0506211452110.2353@ppc970.osdl.org>
	<7v4qbofym7.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jun 24 01:22:42 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dlb1r-0004JU-1y
	for gcvg-git@gmane.org; Fri, 24 Jun 2005 01:22:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262744AbVFWX3A (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 23 Jun 2005 19:29:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262820AbVFWX3A
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Jun 2005 19:29:00 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:15798 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S262744AbVFWX23 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Jun 2005 19:28:29 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050623232827.VETU16890.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 23 Jun 2005 19:28:27 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <7v4qbofym7.fsf_-_@assigned-by-dhcp.cox.net> (Junio C. Hamano's
 message of "Thu, 23 Jun 2005 16:21:36 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This script helps the git-rebase script by finding commits that
have not been merged upstream.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 Makefile   |    2 +
 git-cherry |   90 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 91 insertions(+), 1 deletions(-)
 create mode 100755 git-cherry

diff --git a/Makefile b/Makefile
--- a/Makefile
+++ b/Makefile
@@ -25,7 +25,7 @@ SCRIPTS=git git-apply-patch-script git-m
 	git-deltafy-script git-fetch-script git-status-script git-commit-script \
 	git-log-script git-shortlog git-cvsimport-script git-diff-script \
 	git-reset-script git-add-script git-checkout-script git-clone-script \
-	gitk
+	gitk git-cherry
 
 PROG=   git-update-cache git-diff-files git-init-db git-write-tree \
 	git-read-tree git-commit-tree git-cat-file git-fsck-cache \
diff --git a/git-cherry b/git-cherry
new file mode 100755
--- /dev/null
+++ b/git-cherry
@@ -0,0 +1,90 @@
+#!/bin/sh
+#
+# Copyright (c) 2005 Junio C Hamano.
+#
+
+usage="usage: $0 "'<upstream> [<head>]
+
+             __*__*__*__*__> <upstream>
+            /
+  fork-point
+            \__+__+__+__+__+__+__+__> <head>
+
+Each commit between the fork-point and <head> is examined, and
+compared against the change each commit between the fork-point and
+<upstream> introduces.  If the change does not seem to be in the
+upstream, it is shown on the standard output.
+
+The output is intended to be used as:
+
+    OLD_HEAD=$(git-rev-parse HEAD)
+    git-rev-parse linus >${GIT_DIR-.}/HEAD
+    git-cherry linus OLD_HEAD |
+    while read commit
+    do
+        GIT_EXTERNAL_DIFF=git-apply-patch-script git-diff-tree -p "$commit" &&
+	git-commit-script -m "$commit"
+    done
+'
+
+case "$#" in
+1) linus=`git-rev-parse "$1"` &&
+   junio=`git-rev-parse HEAD` || exit
+   ;;
+2) linus=`git-rev-parse "$1"` &&
+   junio=`git-rev-parse "$2"` || exit
+   ;;
+*) echo >&2 "$usage"; exit 1 ;;
+esac
+
+# Note that these list commits in reverse order;
+# not that the order in inup matters...
+inup=`git-rev-list ^$junio $linus` &&
+ours=`git-rev-list $junio ^$linus` || exit
+
+tmp=.cherry-tmp$$
+patch=$tmp-patch
+diff=$tmp-diff
+mkdir $patch
+trap "rm -rf $tmp-*" 0 1 2 3 15
+
+_x40='[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]'
+_x40="$_x40$_x40$_x40$_x40$_x40$_x40$_x40$_x40"
+
+for c in $inup $ours
+do
+	git-diff-tree -p $c |
+	sed -e "/^$_x40 (from $_x40)\$/d;/^--- /d;/^+++ /d;/^@@ /d" >$patch/$c
+	git-diff-tree -r $c |
+	sed -e "/^$_x40 (from $_x40)\$/d;s/ $_x40 $_x40 / X X /" >$patch/$c.s
+done
+
+LF='
+'
+O=
+for c in $ours
+do
+	found=
+	for d in $inup
+	do
+		cmp $patch/$c.s $patch/$d.s >/dev/null ||
+		continue
+
+		diff --unified=0 $patch/$c $patch/$d >$diff
+		cmp /dev/null $diff >/dev/null && {
+			found=t
+			break
+		}
+	done
+	case "$found,$O" in
+	t,*)	;;
+	,)
+		O="$c" ;;
+	,*)
+		O="$c$LF$O" ;;
+	esac
+done
+case "$O" in
+'') ;;
+*)  echo "$O" ;;
+esac
------------

