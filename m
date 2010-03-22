From: Marc Branchaud <marcnarc@xiplink.com>
Subject: [PATCH] Test that the 'rebase -i' "reword" command always cherry-picks a commit.
Date: Mon, 22 Mar 2010 15:25:42 -0400
Message-ID: <1269285942-17496-1-git-send-email-marcnarc@xiplink.com>
References: <4BA11B23.4090801@xiplink.com>
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Marc Branchaud <marcnarc@xiplink.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Mar 22 20:24:03 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NtnEI-0005RV-4Z
	for gcvg-git-2@lo.gmane.org; Mon, 22 Mar 2010 20:24:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753168Ab0CVTX4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Mar 2010 15:23:56 -0400
Received: from 208-85-112-101.zerofail.com ([208.85.112.101]:45980 "EHLO
	farnsworth.xiplink.com" rhost-flags-OK-FAIL-OK-FAIL)
	by vger.kernel.org with ESMTP id S1752597Ab0CVTXy (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 Mar 2010 15:23:54 -0400
Received: from rincewind (rincewind.xiplink.com [192.168.1.136])
	by farnsworth.xiplink.com (8.14.2/8.14.2/Debian-2build1) with ESMTP id o2MJNpvA020624;
	Mon, 22 Mar 2010 15:23:51 -0400
Received: by rincewind (Postfix, from userid 1000)
	id A06DD336619; Mon, 22 Mar 2010 15:26:17 -0400 (EDT)
X-Mailer: git-send-email 1.7.0.3
In-Reply-To: <4BA11B23.4090801@xiplink.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142957>

In particular, "reword" should cherry-pick a reworded commit even if the
commit's message is unchanged.

This behaviour provides a way to deal with a situation that can arise when
a merge had to be reverted.  Added an addendum to revert-a-faulty-merge.txt
describing the situation and how to use "reword" to handle it.
---

Is this more acceptable than adding --no-ff to rebase--interactive?

I wasn't sure how to integrate the new text into revert-a-faulty-merge.txt.
I went with an addendum, but I'm open to other approaches.

		M.

 Documentation/howto/revert-a-faulty-merge.txt |   64 +++++++++++++++++++++++++
 t/t3417-rebase-reword-forces-cherry-pick.sh   |   59 +++++++++++++++++++++++
 2 files changed, 123 insertions(+), 0 deletions(-)
 create mode 100755 t/t3417-rebase-reword-forces-cherry-pick.sh

diff --git a/Documentation/howto/revert-a-faulty-merge.txt b/Documentation/howto/revert-a-faulty-merge.txt
index 3b4a390..892433d 100644
--- a/Documentation/howto/revert-a-faulty-merge.txt
+++ b/Documentation/howto/revert-a-faulty-merge.txt
@@ -142,6 +142,8 @@ different resolution strategies:
    revert of a merge was rebuilt from scratch (i.e. rebasing and fixing,
    as you seem to have interpreted), then re-merging the result without
    doing anything else fancy would be the right thing to do.
+   (See the ADDENDUM below for how to rebuild a branch from scratch
+   without changing its original branching-off point.)
 
 However, there are things to keep in mind when reverting a merge (and
 reverting such a revert).
@@ -177,3 +179,65 @@ the answer is: "oops, I really shouldn't have merged it, because it wasn't
 ready yet, and I really need to undo _all_ of the merge"). So then you
 really should revert the merge, but when you want to re-do the merge, you
 now need to do it by reverting the revert.
+
+ADDENDUM
+
+Sometimes you're in a situation like this
+
+ P---o---o---M---x---x---W---x
+  \         /
+   A---B---C
+
+where you:
+
+ - Need to rewrite one of the commits on the A-B-C branch; and
+
+ - Want the rewritten A-B-C branch to still start at commit P (perhaps P
+   is a branching-off point for yet another branch, and you want be able to
+   merge A-B-C into both branches).
+
+The natural thing to do in this case is to checkout the A-B-C branch and use
+"rebase -i A" to change commit B.  However, this does not rewrite commit A,
+and you end up with this:
+
+ P---o---o---M---x---x---W---x
+  \         /
+   A---B---C   <-- old branch
+   \
+    B'---C'    <-- rewritten branch
+
+To merge A-B'-C' into the mainline branch you would still have to first revert
+commit W in order to pick up the changes in A, but then it's likely that the
+changes in B' will conflict with the original B changes re-introduced by the
+reversion of W.
+
+However, you could avoid these problems if you recreated the entire branch,
+including commit A:
+
+ P---o---o---M---x---x---W---x
+ |\         /
+ | A---B---C   <-- old branch
+ \
+  A'---B'---C' <-- entirely recreated branch
+
+Now you can merge A'-B'-C' into the mainline branch without worrying about
+first reverting W.
+
+But if you don't actually need to change commit A, then you need some way to
+recreate it as a new commit with the same changes in it.  One way to do this
+is to use the "reword" command in "rebase -i".  If you:
+
+ - Checkout the A-B-C branch
+
+ - Run "rebase -i P" to rebase the entire branch
+
+ - "reword" commit A (the first commit in the rebase script)
+
+ - Make NO changes to commit A's message
+
+then you'll end up with a new branch A'-B'-C' with all-new commits (all the
+SHA IDs will be different) but that has the same changes that were in the
+original A-B-C branch.
+
+You can then modify commit B' as you like and merge the new A'-B''-C' branch
+into the mainline branch without first reverting commit W.
diff --git a/t/t3417-rebase-reword-forces-cherry-pick.sh b/t/t3417-rebase-reword-forces-cherry-pick.sh
new file mode 100755
index 0000000..3e29f0f
--- /dev/null
+++ b/t/t3417-rebase-reword-forces-cherry-pick.sh
@@ -0,0 +1,59 @@
+#!/bin/sh
+#
+# Copyright (c) 2010 Marc Branchaud
+#
+
+test_description='git rebase interactive "reword" always forces cherry-pick
+
+This test ensures that the "reword" command of "git rebase -i" cherry-picks
+a reworded commit even if no changes are made to the commit message.
+
+This behaviour provides a way to deal with a situation that can arise when a
+merge had to be reverted.  For details, see the ADDENDUM in
+Documentation/howto/revert-a-faulty-merge.txt.
+'
+
+. ./test-lib.sh
+
+. "$TEST_DIRECTORY"/lib-rebase.sh
+
+set_fake_editor
+
+# A simple linear history.
+test_expect_success 'setup' '
+	test_commit A file1 &&
+	test_commit B file1 &&
+	test_commit C file1 &&
+	test_commit D file1 &&
+	git branch old-master HEAD
+'
+
+# Ensure that the rebased commits get a different timestamp.
+test_tick
+
+# Reword the first commit, but don't actually change the message
+test_expect_success 'reword' '
+	FAKE_LINES="reword 1 2 3" git rebase -i A
+'
+
+# There should be no textual differences between the old and new branches.
+# However:
+#  - Commit A should be completely unchanged.
+#  - Commits B, C and D should have different SHA IDs.
+test_expect_success 'verify' '
+	touch empty &&
+	test ! $(git rev-parse ) = $(git rev-parse master) &&
+	git diff old-master master > out &&
+	test_cmp empty out &&
+	test ! $(git rev-parse C) = $(git rev-parse master^) &&
+	git diff old-master^ master^ > out &&
+	test_cmp empty out &&
+	test ! $(git rev-parse B) = $(git rev-parse master^^) &&
+	git diff old-master^^ master^^ > out &&
+	test_cmp empty out &&
+	test $(git rev-parse A) = $(git rev-parse master^^^) &&
+	git diff old-master^^^ master^^^ > out &&
+	test_cmp empty out
+'
+
+test_done
-- 
1.7.0.3
