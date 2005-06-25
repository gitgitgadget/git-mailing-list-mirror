From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH 4/9] git-rebase-script: rebase local commits to new upstream
 head.
Date: Sat, 25 Jun 2005 02:23:43 -0700
Message-ID: <7vwtoi3i3k.fsf_-_@assigned-by-dhcp.cox.net>
References: <7vaclgfynv.fsf@assigned-by-dhcp.cox.net>
	<7vvf439vdl.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0506241755280.11175@ppc970.osdl.org>
	<7vaclf6tw7.fsf@assigned-by-dhcp.cox.net>
	<7vmzpe4x08.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 25 11:17:15 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dm6mn-0001ke-Aj
	for gcvg-git@gmane.org; Sat, 25 Jun 2005 11:17:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263373AbVFYJXu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 25 Jun 2005 05:23:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263376AbVFYJXu
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Jun 2005 05:23:50 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:2190 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S263373AbVFYJXp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Jun 2005 05:23:45 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050625092344.MNFF12158.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 25 Jun 2005 05:23:44 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <7vmzpe4x08.fsf_-_@assigned-by-dhcp.cox.net> (Junio C. Hamano's
 message of "Sat, 25 Jun 2005 02:16:23 -0700")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Using git-cherry, forward port local commits missing from the
new upstream head.  This also depends on "-m" flag support in
git-commit-script.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 Makefile          |    2 +-
 git-rebase-script |   49 +++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 50 insertions(+), 1 deletions(-)
 create mode 100755 git-rebase-script

39830aca0319e04ed6c45203614543418974f877
diff --git a/Makefile b/Makefile
--- a/Makefile
+++ b/Makefile
@@ -25,7 +25,7 @@ SCRIPTS=git git-apply-patch-script git-m
 	git-deltafy-script git-fetch-script git-status-script git-commit-script \
 	git-log-script git-shortlog git-cvsimport-script git-diff-script \
 	git-reset-script git-add-script git-checkout-script git-clone-script \
-	gitk git-cherry
+	gitk git-cherry git-rebase-script
 
 PROG=   git-update-cache git-diff-files git-init-db git-write-tree \
 	git-read-tree git-commit-tree git-cat-file git-fsck-cache \
diff --git a/git-rebase-script b/git-rebase-script
new file mode 100755
--- /dev/null
+++ b/git-rebase-script
@@ -0,0 +1,49 @@
+#!/bin/sh
+#
+# Copyright (c) 2005 Junio C Hamano.
+#
+
+usage="usage: $0 "'<upstream> [<head>]
+
+Uses output from git-cherry to rebase local commits to the new head of
+upstream tree.'
+
+: ${GIT_DIR=.git}
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
+git-read-tree -m -u $junio $linus &&
+echo "$linus" >"$GIT_DIR/HEAD" || exit
+
+tmp=.rebase-tmp$$
+fail=$tmp-fail
+trap "rm -rf $tmp-*" 0 1 2 3 15
+
+>$fail
+
+git-cherry $linus $junio |
+while read sign commit
+do
+	case "$sign" in
+	-) continue ;;
+	esac
+	S=`cat "$GIT_DIR/HEAD"` &&
+        GIT_EXTERNAL_DIFF=git-apply-patch-script git-diff-tree -p $commit &&
+	git-commit-script -m "$commit" || {
+		echo $commit >>$fail
+		git-read-tree --reset -u $S
+	}
+done
+if test -s $fail
+then
+	echo Some commits could not be rebased, check by hand:
+	cat $fail
+fi
------------

