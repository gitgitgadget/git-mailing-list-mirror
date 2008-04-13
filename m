From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH] Fix problems in t1000-branch-create
Date: Sun, 13 Apr 2008 15:43:53 +0200
Message-ID: <20080413134104.15175.84334.stgit@yoghurt>
References: <20080413060223.GA27382@diana.vm.bytemark.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 13 15:45:19 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jl2W4-0007im-7P
	for gcvg-git-2@gmane.org; Sun, 13 Apr 2008 15:45:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756184AbYDMNoY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 13 Apr 2008 09:44:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757015AbYDMNoY
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Apr 2008 09:44:24 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1404 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756986AbYDMNoX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Apr 2008 09:44:23 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1Jl2V3-00089V-00; Sun, 13 Apr 2008 14:44:05 +0100
In-Reply-To: <20080413060223.GA27382@diana.vm.bytemark.co.uk>
User-Agent: StGIT/0.14.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79408>

There were a number of problems with t1000-branch-create:

  * It assumed that refs were not packed. I added calls to show-ref to
    spot any packed refs.

  * It reused the same name for several consecutive branch creation
    tests. This causes a domino effect if one of the subtests fail. I
    made the subtests use different names.

  * It tried to make sure that we couldn't create a branch if there
    was a broken ref by the same name. Unfortunately that test fails
    -- we don't create the branch, but we point HEAD to it. This
    causes many subsequent operations to fail. I marked this test as a
    known failure, and added some reset code so that subsequent
    subtests don't die because of this.

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

Thanks to Junio for suggesting that the test should be repaired rather
than deleted. It finds a real bug! (A rather harmless one, but still.)

 t/t1000-branch-create.sh |   56 ++++++++++++++++++++++++++++++--------=
--------
 1 files changed, 36 insertions(+), 20 deletions(-)


diff --git a/t/t1000-branch-create.sh b/t/t1000-branch-create.sh
index d6cf34a..5a097a4 100755
--- a/t/t1000-branch-create.sh
+++ b/t/t1000-branch-create.sh
@@ -21,65 +21,81 @@ test_expect_success \
     'Create a spurious patches/ entry' '
     stg branch master &&
     stg init &&
-    find .git -name foo | xargs rm -rf &&
-    mkdir -p .git/patches && touch .git/patches/foo
+    mkdir -p .git/patches && touch .git/patches/foo1
 '
=20
 test_expect_success \
     'Try to create an stgit branch with a spurious patches/ entry' '
-    ! stg branch -c foo
+    ! stg branch -c foo1
 '
=20
 test_expect_success \
     'Check that no part of the branch was created' '
-    test "`find .git -name foo | tee /dev/stderr`" =3D ".git/patches/f=
oo" &&
-    ( grep foo .git/HEAD; test $? =3D 1 )
+    test "$(find .git -name foo1 | tee /dev/stderr)" =3D ".git/patches=
/foo1" &&
+    test "$(git show-ref | grep foo1 | wc -l)" =3D 0 &&
+    test "$(git symbolic-ref HEAD)" =3D "refs/heads/master"
 '
=20
 test_expect_success \
     'Create a git branch' '
-    find .git -name foo | xargs rm -rf &&
-    cp .git/refs/heads/master .git/refs/heads/foo
+    git update-ref refs/heads/foo2 refs/heads/master
 '
=20
 test_expect_success \
     'Try to create an stgit branch with an existing git branch by that=
 name' '
-    ! stg branch -c foo
+    ! stg branch -c foo2
 '
=20
 test_expect_success \
     'Check that no part of the branch was created' '
-    test "`find .git -name foo | tee /dev/stderr`" =3D ".git/refs/head=
s/foo" &&
-    ( grep foo .git/HEAD; test $? =3D 1 )
+    test "$(find .git -name foo2 | tee /dev/stderr \
+        | grep -v ^\\.git/refs/heads/foo2$ \
+        | grep -v ^\\.git/logs/refs/heads/foo2$ | wc -l)" =3D 0 &&
+    test "$(git show-ref | grep foo2 | wc -l)" =3D 1 &&
+    test "$(git symbolic-ref HEAD)" =3D "refs/heads/master"
 '
=20
 test_expect_success \
     'Create an invalid refs/heads/ entry' '
-    find .git -name foo | xargs rm -rf &&
-    touch .git/refs/heads/foo &&
-    ! stg branch -c foo
+    touch .git/refs/heads/foo3 &&
+    ! stg branch -c foo3
 '
=20
+test_expect_failure \
+    'Check that no part of the branch was created' '
+    test "$(find .git -name foo3 | tee /dev/stderr \
+        | grep -v ^\\.git/refs/heads/foo3$ | wc -l)" =3D 0 &&
+    test "$(git show-ref | grep foo3 | wc -l)" =3D 0 &&
+    test "$(git symbolic-ref HEAD)" =3D "refs/heads/master"
+'
+
+# Workaround for the test failure to make the rest of the subtests
+# succeed. (HEAD was erroneously overwritten with the bad foo3 ref, so
+# we need to reset it.)
+git symbolic-ref HEAD refs/heads/master
+
 test_expect_success \
     'Setup two commits including removal of generated files' '
     git init &&
-    touch a.c a.o &&
-    git add a.c a.o &&
+    touch file1 file2 &&
+    git add file1 file2 &&
     git commit -m 1 &&
-    git rm a.c a.o &&
+    git rm file1 file2 &&
     git commit -m 2 &&
-    touch a.o
+    touch file2
 '
=20
 test_expect_success \
     'Create branch down the stack, behind the conflict caused by the g=
enerated file' '
-    ! stg branch --create bar master^
+    ! stg branch --create foo4 master^
 '
=20
 test_expect_success \
     'Check the branch was not created' '
-    test ! -r .git/refs/heads/bar &&
-    test ! -r a.c
+    test ! -e file1 &&
+    test "$(find .git -name foo4 | tee /dev/stderr | wc -l)" =3D 0 &&
+    test "$(git show-ref | grep foo4 | wc -l)" =3D 0 &&
+    test "$(git symbolic-ref HEAD)" =3D "refs/heads/master"
 '
=20
 test_done
