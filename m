From: Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v2 2/5] reset: add test cases for "--keep" option
Date: Tue, 19 Jan 2010 05:25:58 +0100
Message-ID: <20100119042602.4510.5880.chriscool@tuxfamily.org>
References: <20100119042404.4510.48855.chriscool@tuxfamily.org>
Cc: git@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Paolo Bonzini <bonzini@gnu.org>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Stephen Boyd <bebarino@gmail.com>,
	Andreas Schwab <schwab@linux-m68k.org>,
	Daniel Convissor <danielc@analysisandsolutions.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jan 19 05:24:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NX5dj-0006y9-Po
	for gcvg-git-2@lo.gmane.org; Tue, 19 Jan 2010 05:24:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754886Ab0ASEYV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Jan 2010 23:24:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752822Ab0ASEYV
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Jan 2010 23:24:21 -0500
Received: from smtp3-g21.free.fr ([212.27.42.3]:53640 "EHLO smtp3-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754567Ab0ASEYP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Jan 2010 23:24:15 -0500
Received: from smtp3-g21.free.fr (localhost [127.0.0.1])
	by smtp3-g21.free.fr (Postfix) with ESMTP id C51E3818075;
	Tue, 19 Jan 2010 05:23:59 +0100 (CET)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp3-g21.free.fr (Postfix) with ESMTP id 5977F818057;
	Tue, 19 Jan 2010 05:23:56 +0100 (CET)
X-git-sha1: 2ad58cd7be98083c397bf3421aff55e6c6eb1c76 
X-Mailer: git-mail-commits v0.5.2
In-Reply-To: <20100119042404.4510.48855.chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137417>

This shows that with the "--keep" option, changes that are both in
the work tree and the index are kept in the work tree after the
reset (but discarded in the index).

In the case of unmerged entries, we can see that "git reset --keep"
works only when the target state is the same as HEAD. And then the
work tree is not reset.

Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/t7110-reset-merge.sh |  119 +++++++++++++++++++++++++++++++++++++++++++++++-
 t/t7111-reset-table.sh |    8 +++
 2 files changed, 126 insertions(+), 1 deletions(-)

diff --git a/t/t7110-reset-merge.sh b/t/t7110-reset-merge.sh
index 8704d00..1a9c1c7 100755
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
 test_expect_success 'setup 3 different branches' '
     git reset --hard second &&
     git branch branch1 &&
@@ -156,6 +232,18 @@ test_expect_success '"reset --merge HEAD^" is ok with pending merge' '
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
@@ -166,6 +254,21 @@ test_expect_success '"reset --merge HEAD" is ok with pending merge' '
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
 test_expect_success '--merge with added/deleted' '
     git reset --hard third &&
     rm -f file2 &&
@@ -180,4 +283,18 @@ test_expect_success '--merge with added/deleted' '
     git diff --exit-code --cached
 '
 
+test_expect_success '--keep with added/deleted' '
+    git reset --hard third &&
+    rm -f file2 &&
+    test_must_fail git merge branch3 &&
+    ! test -f file2 &&
+    test -f file3 &&
+    git diff --exit-code file3 &&
+    git diff --exit-code branch3 file3 &&
+    git reset --keep HEAD &&
+    test -f file3 &&
+    ! test -f file2 &&
+    git diff --exit-code --cached
+'
+
 test_done
diff --git a/t/t7111-reset-table.sh b/t/t7111-reset-table.sh
index de896c9..2ebda97 100755
--- a/t/t7111-reset-table.sh
+++ b/t/t7111-reset-table.sh
@@ -44,26 +44,32 @@ A B C D soft   A B D
 A B C D mixed  A D D
 A B C D hard   D D D
 A B C D merge  XXXXX
+A B C D keep   XXXXX
 A B C C soft   A B C
 A B C C mixed  A C C
 A B C C hard   C C C
 A B C C merge  XXXXX
+A B C C keep   A C C
 B B C D soft   B B D
 B B C D mixed  B D D
 B B C D hard   D D D
 B B C D merge  D D D
+B B C D keep   XXXXX
 B B C C soft   B B C
 B B C C mixed  B C C
 B B C C hard   C C C
 B B C C merge  C C C
+B B C C keep   B C C
 B C C D soft   B C D
 B C C D mixed  B D D
 B C C D hard   D D D
 B C C D merge  XXXXX
+B C C D keep   XXXXX
 B C C C soft   B C C
 B C C C mixed  B C C
 B C C C hard   C C C
 B C C C merge  B C C
+B C C C keep   B C C
 EOF
 
 test_expect_success 'setting up branches to test with unmerged entries' '
@@ -104,10 +110,12 @@ X U B C soft   XXXXX
 X U B C mixed  X C C
 X U B C hard   C C C
 X U B C merge  C C C
+X U B C keep   XXXXX
 X U B B soft   XXXXX
 X U B B mixed  X B B
 X U B B hard   B B B
 X U B B merge  B B B
+X U B B keep   X B B
 EOF
 
 test_done
-- 
1.6.6.271.gc8799
