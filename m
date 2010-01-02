From: Christian Couder <chriscool@tuxfamily.org>
Subject: [RFC/PATCH 3/5] reset: add test cases for "--keep" option
Date: Sat, 02 Jan 2010 06:39:31 +0100
Message-ID: <20100102053934.30066.53176.chriscool@tuxfamily.org>
References: <20100102053303.30066.26391.chriscool@tuxfamily.org>
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
X-From: git-owner@vger.kernel.org Sat Jan 02 06:40:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NQwil-00023x-Tx
	for gcvg-git-2@lo.gmane.org; Sat, 02 Jan 2010 06:40:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752341Ab0ABFjy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Jan 2010 00:39:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751685Ab0ABFjx
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Jan 2010 00:39:53 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:53990 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751250Ab0ABFjw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Jan 2010 00:39:52 -0500
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 7E8F5818076;
	Sat,  2 Jan 2010 06:39:41 +0100 (CET)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 2016F818044;
	Sat,  2 Jan 2010 06:39:39 +0100 (CET)
X-git-sha1: afef2321a83e4732440e978a05520684bc6e31ff 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20100102053303.30066.26391.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136019>

This shows that with the "--keep" option, changes that are both in
the work tree and the index are kept in the work tree after the
reset (but discarded in the index). As with the "--merge" option,
changes that are in both the work tree and the index are discarded
after the reset.

In the case of unmerged entries, we can see that "git reset --merge"
resets everything to the target, while with "--keep" it works only
when the target state is the same as HEAD and the work tree is not
reset.

And this shows that otherwise "--merge" and "--keep" have the same
behavior.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/t7110-reset-merge.sh |  105 +++++++++++++++++++++++++++++++++++++++++++++++-
 1 files changed, 104 insertions(+), 1 deletions(-)

diff --git a/t/t7110-reset-merge.sh b/t/t7110-reset-merge.sh
index 249df7c..a9b2fba 100755
--- a/t/t7110-reset-merge.sh
+++ b/t/t7110-reset-merge.sh
@@ -3,7 +3,7 @@
 # Copyright (c) 2009 Christian Couder
 #
 
-test_description='Tests for "git reset --merge"'
+test_description='Tests for "git reset" with "--merge" and "--keep" options'
 
 . ./test-lib.sh
 
@@ -47,6 +47,30 @@ test_expect_success 'reset --merge is ok when switching back' '
 #
 #           working index HEAD target         working index HEAD
 #           ----------------------------------------------------
+# file1:     C       C     C    D     --keep   D       D     D
+# file2:     C       D     D    D     --keep   C       D     D
+test_expect_success 'reset --keep is ok with changes in file it does not touch' '
+    git reset --hard second &&
+    cat file1 >file2 &&
+    git reset --keep HEAD^ &&
+    ! grep 4 file1 &&
+    grep 4 file2 &&
+    test "$(git rev-parse HEAD)" = "$(git rev-parse initial)" &&
+    test -z "$(git diff --cached)"
+'
+
+test_expect_success 'reset --keep is ok when switching back' '
+    git reset --keep second &&
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
 # file1:     B       B     C    D     --merge  D       D     D
 # file2:     C       D     D    D     --merge  C       D     D
 test_expect_success 'reset --merge discards changes added to index (1)' '
@@ -78,6 +102,18 @@ test_expect_success 'reset --merge is ok again when switching back (1)' '
 #
 #           working index HEAD target         working index HEAD
 #           ----------------------------------------------------
+# file1:     B       B     C    D     --keep   (disallowed)
+test_expect_success 'reset --keep fails with changes in index in files it touches' '
+    git reset --hard second &&
+    echo "line 5" >> file1 &&
+    git add file1 &&
+    test_must_fail git reset --keep HEAD^
+'
+
+# The next test will test the following:
+#
+#           working index HEAD target         working index HEAD
+#           ----------------------------------------------------
 # file1:     C       C     C    D     --merge  D       D     D
 # file2:     C       C     D    D     --merge  D       D     D
 test_expect_success 'reset --merge discards changes added to index (2)' '
@@ -104,6 +140,30 @@ test_expect_success 'reset --merge is ok again when switching back (2)' '
 #
 #           working index HEAD target         working index HEAD
 #           ----------------------------------------------------
+# file1:     C       C     C    D     --keep   D       D     D
+# file2:     C       C     D    D     --keep   C       D     D
+test_expect_success 'reset --keep keeps changes it does not touch' '
+    git reset --hard second &&
+    echo "line 4" >> file2 &&
+    git add file2 &&
+    git reset --keep HEAD^ &&
+    grep 4 file2 &&
+    test "$(git rev-parse HEAD)" = "$(git rev-parse initial)" &&
+    test -z "$(git diff --cached)"
+'
+
+test_expect_success 'reset --keep keeps changes when switching back' '
+    git reset --keep second &&
+    grep 4 file2 &&
+    grep 4 file1 &&
+    test "$(git rev-parse HEAD)" = "$(git rev-parse second)" &&
+    test -z "$(git diff --cached)"
+'
+
+# The next test will test the following:
+#
+#           working index HEAD target         working index HEAD
+#           ----------------------------------------------------
 # file1:     A       B     B    C     --merge  (disallowed)
 test_expect_success 'reset --merge fails with changes in file it touches' '
     git reset --hard second &&
@@ -116,6 +176,22 @@ test_expect_success 'reset --merge fails with changes in file it touches' '
     grep file1 err.log | grep "not uptodate"
 '
 
+# The next test will test the following:
+#
+#           working index HEAD target         working index HEAD
+#           ----------------------------------------------------
+# file1:     A       B     B    C     --keep   (disallowed)
+test_expect_success 'reset --keep fails with changes in file it touches' '
+    git reset --hard second &&
+    echo "line 5" >> file1 &&
+    test_tick &&
+    git commit -m "add line 5" file1 &&
+    sed -e "s/line 1/changed line 1/" <file1 >file3 &&
+    mv file3 file1 &&
+    test_must_fail git reset --keep HEAD^ 2>err.log &&
+    grep file1 err.log | grep "not uptodate"
+'
+
 test_expect_success 'setup 2 different branches' '
     git reset --hard second &&
     git branch branch1 &&
@@ -148,6 +224,18 @@ test_expect_success '"reset --merge HEAD^" is ok with pending merge' '
 #
 #           working index HEAD target         working index HEAD
 #           ----------------------------------------------------
+# file1:     X       U     B    C     --keep   (disallowed)
+test_expect_success '"reset --keep HEAD^" fails with pending merge' '
+    git reset --hard third &&
+    test_must_fail git merge branch1 &&
+    test_must_fail git reset --keep HEAD^ 2>err.log &&
+    grep file1 err.log | grep "overwritten by merge"
+'
+
+# The next test will test the following:
+#
+#           working index HEAD target         working index HEAD
+#           ----------------------------------------------------
 # file1:     X       U     B    B     --merge  B       B     B
 test_expect_success '"reset --merge HEAD" is ok with pending merge' '
     git reset --hard third &&
@@ -158,4 +246,19 @@ test_expect_success '"reset --merge HEAD" is ok with pending merge' '
     test -z "$(git diff)"
 '
 
+# The next test will test the following:
+#
+#           working index HEAD target         working index HEAD
+#           ----------------------------------------------------
+# file1:     X       U     B    B     --keep  X       B     B
+test_expect_success '"reset --keep HEAD" is ok with pending merge' '
+    git reset --hard third &&
+    test_must_fail git merge branch1 &&
+    cat file1 >orig_file1 &&
+    git reset --keep HEAD &&
+    test "$(git rev-parse HEAD)" = "$(git rev-parse third)" &&
+    test -z "$(git diff --cached)" &&
+    test_cmp file1 orig_file1
+'
+
 test_done
-- 
1.6.6.rc2.5.g49666
