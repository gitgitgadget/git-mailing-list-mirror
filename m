From: Junio C Hamano <junkio@cox.net>
Subject: [PATCH] Infamous 'octopus merge'
Date: Thu, 18 Aug 2005 18:05:05 -0700
Message-ID: <7v4q9meny6.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Aug 19 03:06:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E5vJp-0002n7-Dx
	for gcvg-git@gmane.org; Fri, 19 Aug 2005 03:05:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964781AbVHSBFI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 18 Aug 2005 21:05:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964785AbVHSBFI
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Aug 2005 21:05:08 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:15838 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S964781AbVHSBFG (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Aug 2005 21:05:06 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050819010505.YCGM16890.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 18 Aug 2005 21:05:05 -0400
To: git@vger.kernel.org
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

This script uses the list of heads and their origin multi-head "git
fetch" left in the $GIT_DIR/FETCH_HEAD file, and makes an octopus
merge on top of the current HEAD using them.

The implementation tries to be strict for the sake of safety.  It
insists that your working tree is clean (no local changes) and matches
the HEAD, and when any of the merged heads does not automerge, the
whole process is aborted and tries to rewind your working tree is to
the original state.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---

 Makefile           |    1 +
 git-octopus-script |   64 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 65 insertions(+), 0 deletions(-)
 create mode 100755 git-octopus-script

bad69944391b17bf5d4060b19e24013807409b28
diff --git a/Makefile b/Makefile
--- a/Makefile
+++ b/Makefile
@@ -72,6 +72,7 @@ SCRIPTS += git-count-objects-script
 # SCRIPTS += git-send-email-script
 SCRIPTS += git-revert-script
 SCRIPTS += git-show-branches-script
+SCRIPTS += git-octopus-script
 
 PROG=   git-update-cache git-diff-files git-init-db git-write-tree \
 	git-read-tree git-commit-tree git-cat-file git-fsck-cache \
diff --git a/git-octopus-script b/git-octopus-script
new file mode 100755
--- /dev/null
+++ b/git-octopus-script
@@ -0,0 +1,64 @@
+#!/bin/sh
+#
+# Copyright (c) 2005 Junio C Hamano
+#
+# Resolve two or more trees recorded in $GIT_DIR/FETCH_HEAD.
+#
+. git-sh-setup-script || die "Not a git archive"
+
+usage () {
+    die "usage: git octopus"
+}
+
+# Sanity check the heads early.
+while read SHA1 REPO
+do
+	test $(git-cat-file -t $SHA1) = "commit" ||
+		die "$REPO given to octopus is not a commit"
+done <"$GIT_DIR/FETCH_HEAD"
+
+head=$(git-rev-parse --verify HEAD) || exit
+
+git-update-cache --refresh ||
+	die "Your working tree is dirty."
+test "$(git-diff-cache --cached "$head")" = "" ||
+	die "Your working tree does not match HEAD."
+
+# MRC is the current "merge reference commit"
+# MRT is the current "merge result tree"
+
+MRC=$head MRT=$head MSG='Octopus merge of the following: ' PARENT="-p $head"
+while read SHA1 REPO
+do
+	common=$(git-merge-base $MRC $SHA1) ||
+		die "Unable to find common commit between $SHA1 and $MRC"
+
+	git-read-tree -u -m $common $MRT $SHA1 || exit
+	next=$(git-write-tree 2>/dev/null)
+	if test $? -ne 0
+	then
+		git-merge-cache -o git-merge-one-file-script -a || {
+		git-read-tree --reset "$head"
+		git-checkout-tree -f -q -u -a
+		die "Automatic merge failed; should not be doing Octopus"
+		}
+		next=$(git-write-tree 2>/dev/null)
+	fi
+	PARENT="$PARENT -p $SHA1"
+	MRC=$common
+	MRT=$next
+	MSG="$MSG
+	$REPO"
+done <"$GIT_DIR/FETCH_HEAD"
+
+# Just to be careful in case the user feeds nonsense to us.
+if test "$MRT" = "$head"
+then
+	echo "No changes."
+	exit 0
+fi
+
+result_commit=$(echo "$MSG" | git-commit-tree $MRT $PARENT)
+echo "Committed octopus merge $result_commit"
+echo $result_commit >"$GIT_DIR"/HEAD
+git-diff-tree -p $head $result_commit | git-apply --stat
