From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v6 3/4] reset: add a few tests for "git reset --merge"
Date: Wed, 30 Dec 2009 06:54:46 +0100
Message-ID: <20091230055448.4475.42383.chriscool@tuxfamily.org>
References: <20091230055008.4475.95755.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Paolo Bonzini <bonzini@gnu.org>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Stephen Boyd <bebarino@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Dec 30 06:53:14 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NPrUO-0005vC-II
	for gcvg-git-2@lo.gmane.org; Wed, 30 Dec 2009 06:52:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752174AbZL3Fwu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Dec 2009 00:52:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752053AbZL3Fws
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Dec 2009 00:52:48 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:55892 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752048AbZL3Fwq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Dec 2009 00:52:46 -0500
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 2C0C1818052;
	Wed, 30 Dec 2009 06:52:35 +0100 (CET)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 0BEB5818044;
	Wed, 30 Dec 2009 06:52:33 +0100 (CET)
X-git-sha1: 44531a36a6c7d04785cd023b6156d77e1faec33e 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20091230055008.4475.95755.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135860>

Commit 9e8eceab ("Add 'merge' mode to 'git reset'", 2008-12-01),
added the --merge option to git reset, but there were no test cases
for it.

This was not a big problem because "git reset" was just forking and
execing "git read-tree", but this will change in a following patch.

So let's add a few test cases to make sure that there will be no
regression.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/t7110-reset-merge.sh |  159 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 159 insertions(+), 0 deletions(-)
 create mode 100755 t/t7110-reset-merge.sh

diff --git a/t/t7110-reset-merge.sh b/t/t7110-reset-merge.sh
new file mode 100755
index 0000000..4c46083
--- /dev/null
+++ b/t/t7110-reset-merge.sh
@@ -0,0 +1,159 @@
+#!/bin/sh
+#
+# Copyright (c) 2009 Christian Couder
+#
+
+test_description='Tests for "git reset --merge"'
+
+. ./test-lib.sh
+
+test_expect_success setup '
+    for i in 1 2 3; do echo line $i; done >file1 &&
+    cat file1 >file2 &&
+    git add file1 file2 &&
+    test_tick &&
+    git commit -m "Initial commit" &&
+    git tag initial &&
+    echo line 4 >>file1 &&
+    cat file1 >file2 &&
+    test_tick &&
+    git commit -m "add line 4 to file1" file1 &&
+    git tag second
+'
+
+# The next test will test the following:
+#
+#           working index HEAD target         working index HEAD
+#           ----------------------------------------------------
+# file1:     C       C     C    D     --merge  D       D     D
+# file2:     C       D     D    D     --merge  C       D     D
+test_expect_success 'reset --merge is ok with changes in file it does not touch' '
+    git reset --merge HEAD^ &&
+    ! grep 4 file1 &&
+    grep 4 file2 &&
+    test "$(git rev-parse HEAD)" = "$(git rev-parse initial)" &&
+    test -z "$(git diff --cached)"
+'
+
+test_expect_success 'reset --merge is ok when switching back' '
+    git reset --merge second &&
+    grep 4 file1 &&
+    grep 4 file2 &&
+    test "$(git rev-parse HEAD)" = "$(git rev-parse second)" &&
+    test -z "$(git diff --cached)"
+'
+
+# The next test will test the following:
+#
+#           working index HEAD target         working index HEAD
+#           ----------------------------------------------------
+# file1:     B       B     C    D     --merge  D       D     D
+# file2:     C       D     D    D     --merge  C       D     D
+test_expect_success 'reset --merge discards changes added to index (1)' '
+    git reset --hard second &&
+    cat file1 >file2 &&
+    echo "line 5" >> file1 &&
+    git add file1 &&
+    git reset --merge HEAD^ &&
+    ! grep 4 file1 &&
+    ! grep 5 file1 &&
+    grep 4 file2 &&
+    test "$(git rev-parse HEAD)" = "$(git rev-parse initial)" &&
+    test -z "$(git diff --cached)"
+'
+
+test_expect_success 'reset --merge is ok again when switching back (1)' '
+    git reset --hard initial &&
+    echo "line 5" >> file2 &&
+    git add file2 &&
+    git reset --merge second &&
+    ! grep 4 file2 &&
+    ! grep 5 file1 &&
+    grep 4 file1 &&
+    test "$(git rev-parse HEAD)" = "$(git rev-parse second)" &&
+    test -z "$(git diff --cached)"
+'
+
+# The next test will test the following:
+#
+#           working index HEAD target         working index HEAD
+#           ----------------------------------------------------
+# file1:     C       C     C    D     --merge  D       D     D
+# file2:     C       C     D    D     --merge  D       D     D
+test_expect_success 'reset --merge discards changes added to index (2)' '
+    git reset --hard second &&
+    echo "line 4" >> file2 &&
+    git add file2 &&
+    git reset --merge HEAD^ &&
+    ! grep 4 file2 &&
+    test "$(git rev-parse HEAD)" = "$(git rev-parse initial)" &&
+    test -z "$(git diff)" &&
+    test -z "$(git diff --cached)"
+'
+
+test_expect_success 'reset --merge is ok again when switching back (2)' '
+    git reset --hard initial &&
+    git reset --merge second &&
+    ! grep 4 file2 &&
+    grep 4 file1 &&
+    test "$(git rev-parse HEAD)" = "$(git rev-parse second)" &&
+    test -z "$(git diff --cached)"
+'
+
+# The next test will test the following:
+#
+#           working index HEAD target         working index HEAD
+#           ----------------------------------------------------
+# file1:     A       B     B    C     --merge  (disallowed)
+test_expect_success 'reset --merge fails with changes in file it touches' '
+    git reset --hard second &&
+    echo "line 5" >> file1 &&
+    test_tick &&
+    git commit -m "add line 5" file1 &&
+    sed -e "s/line 1/changed line 1/" <file1 >file3 &&
+    mv file3 file1 &&
+    test_must_fail git reset --merge HEAD^ 2>err.log &&
+    grep file1 err.log | grep "not uptodate"
+'
+
+test_expect_success 'setup 2 different branches' '
+    git reset --hard second &&
+    git branch branch1 &&
+    git branch branch2 &&
+    git checkout branch1 &&
+    echo "line 5 in branch1" >> file1 &&
+    test_tick &&
+    git commit -a -m "change in branch1" &&
+    git checkout branch2 &&
+    echo "line 5 in branch2" >> file1 &&
+    test_tick &&
+    git commit -a -m "change in branch2" &&
+    git tag third
+'
+
+# The next test will test the following:
+#
+#           working index HEAD target         working index HEAD
+#           ----------------------------------------------------
+# file1:     X       U     B    C     --merge  (disallowed)
+test_expect_success '"reset --merge HEAD^" fails with pending merge' '
+    test_must_fail git merge branch1 &&
+    test_must_fail git reset --merge HEAD^ &&
+    test "$(git rev-parse HEAD)" = "$(git rev-parse third)" &&
+    test -n "$(git diff --cached)"
+'
+
+# The next test will test the following:
+#
+#           working index HEAD target         working index HEAD
+#           ----------------------------------------------------
+# file1:     X       U     B    B     --merge  (disallowed)
+test_expect_success '"reset --merge HEAD" fails with pending merge' '
+    git reset --hard third &&
+    test_must_fail git merge branch1 &&
+    test_must_fail git reset --merge HEAD &&
+    test "$(git rev-parse HEAD)" = "$(git rev-parse third)" &&
+    test -n "$(git diff --cached)"
+'
+
+test_done
-- 
1.6.6.rc2.5.g49666
