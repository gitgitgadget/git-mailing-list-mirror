From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 3/9] git-cherry: find commits not merged upstream.
Date: Sat, 25 Jun 2005 02:22:59 -0700
Message-ID: <7v3br64wp8.fsf_-_@assigned-by-dhcp.cox.net>
References: <7vaclgfynv.fsf@assigned-by-dhcp.cox.net>
	<7vvf439vdl.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0506241755280.11175@ppc970.osdl.org>
	<7vaclf6tw7.fsf@assigned-by-dhcp.cox.net>
	<7vmzpe4x08.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 25 11:16:48 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dm6mG-0001ez-JT
	for gcvg-git@gmane.org; Sat, 25 Jun 2005 11:16:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263372AbVFYJXO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 25 Jun 2005 05:23:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263373AbVFYJXO
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Jun 2005 05:23:14 -0400
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:37372 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S263372AbVFYJXB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Jun 2005 05:23:01 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050625092300.FHVM17043.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 25 Jun 2005 05:23:00 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <7vmzpe4x08.fsf_-_@assigned-by-dhcp.cox.net> (Junio C. Hamano's
 message of "Sat, 25 Jun 2005 02:16:23 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

The git-cherry command helps the git-rebase script by finding
commits that have not been merged upstream.  Commits already
included in upstream are prefixed with '-' (meaning "drop from
my local pull"), while commits missing from upstream are
prefixed with '+' (meaning "add to the updated upstream").

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 Makefile   |    2 +
 git-cherry |   86 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 87 insertions(+), 1 deletions(-)
 create mode 100755 git-cherry

350e3957925c9b4404977bbd6f65bf68ba28d26f
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
@@ -0,0 +1,86 @@
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
+mkdir $patch
+trap "rm -rf $tmp-*" 0 1 2 3 15
+
+_x40='[0-9a-f][0-9a-f][0-9a-f][0-9a-f][0-9a-f]'
+_x40="$_x40$_x40$_x40$_x40$_x40$_x40$_x40$_x40"
+
+for c in $inup
+do
+	git-diff-tree -p $c
+done | git-patch-id |
+while read id name
+do
+	echo $name >>$patch/$id
+done
+
+LF='
+'
+
+O=
+for c in $ours
+do
+	set x `git-diff-tree -p $c | git-patch-id`
+	if test "$2" != ""
+	then
+		if test -f "$patch/$2"
+		then
+			sign=-
+		else
+			sign=+
+		fi
+		case "$O" in
+		'')	O="$sign $c" ;;
+		*)	O="$sign $c$LF$O" ;;
+		esac
+	fi
+done
+case "$O" in
+'') ;;
+*)  echo "$O" ;;
+esac
------------

