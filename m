From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH] New policy: Only use test_expect_failure for broken
	tests
Date: Mon, 24 Sep 2007 01:55:33 +0200
Message-ID: <20070923235239.26457.939.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 24 01:55:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IZbIe-0006l8-5x
	for gcvg-git-2@gmane.org; Mon, 24 Sep 2007 01:55:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755162AbXIWXzi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 23 Sep 2007 19:55:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755052AbXIWXzi
	(ORCPT <rfc822;git-outgoing>); Sun, 23 Sep 2007 19:55:38 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1908 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754787AbXIWXzh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 23 Sep 2007 19:55:37 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1IZbIT-0006Jw-00; Mon, 24 Sep 2007 00:55:33 +0100
User-Agent: StGIT/0.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59005>

New policy for tests:

  * For subtests whose commands fail when the test succeeds, use
    test_expect_success and shell negation (!). test_expect_failure is
    to be used only for subtests that are known to be broken.

  * Patches that introduce a subtest failure must change that subtest
    to use test_expect_failure.

The reason for this change is to ensure that the test suite passes at
all times, even in the middle of disruptive rewrites spread over
several commits.

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

While rebasing David's conflict series on top of his new top/bottom
removal series, I found it very irritating and time-consuming to deal
with patches that intentionally broke the test suite. That won't
happen again with this policy in place.

 t/README                      |    9 ++++-----
 t/t0001-subdir-branches.sh    |    9 +++++----
 t/t1000-branch-create.sh      |    8 ++++----
 t/t1001-branch-rename.sh      |    4 ++--
 t/t1002-branch-clone.sh       |    4 ++--
 t/t1200-push-modified.sh      |    4 ++--
 t/t1202-push-undo.sh          |    4 ++--
 t/t2000-sync.sh               |    8 ++++----
 t/t2100-pull-policy-fetch.sh  |    4 ++--
 t/t2102-pull-policy-rebase.sh |   12 ++++++------
 t/t2200-rebase.sh             |    4 ++--
 11 files changed, 35 insertions(+), 35 deletions(-)


diff --git a/t/README b/t/README
index d88bad2..77f0b6c 100644
--- a/t/README
+++ b/t/README
@@ -162,11 +162,10 @@ library for your script to use.
    This is the opposite of test_expect_success.  If <script>
    yields success, test is considered a failure.
=20
-   Example:
-
-	test_expect_failure \
-	    'git-update-index without --add should fail adding.' \
-	    'git-update-index should-be-empty'
+   This should _not_ be used for tests that succeed when their
+   commands fail -- use test_expect_success and shell negation (!) for
+   that. test_expect_failure is for cases when a test is known to be
+   broken.
=20
  - test_debug <script>
=20
diff --git a/t/t0001-subdir-branches.sh b/t/t0001-subdir-branches.sh
index 1685233..0eed3a4 100755
--- a/t/t0001-subdir-branches.sh
+++ b/t/t0001-subdir-branches.sh
@@ -38,10 +38,11 @@ test_expect_success 'Try new form of id with slashy=
 branch' \
    stg id foo@x/y/z &&
    stg id foo@x/y/z//top'
=20
-test_expect_failure 'Try old id with slashy branch' \
-  'stg id foo/ ||
-   stg id foo/top ||
-   stg id foo@x/y/z/top'
+test_expect_success 'Try old id with slashy branch' '
+   ! stg id foo/ &&
+   ! stg id foo/top &&
+   ! stg id foo@x/y/z/top
+   '
=20
 test_expect_success 'Create patch in slashy branch' \
   'echo "bar" >> foo.txt &&
diff --git a/t/t1000-branch-create.sh b/t/t1000-branch-create.sh
index e920e93..848686c 100755
--- a/t/t1000-branch-create.sh
+++ b/t/t1000-branch-create.sh
@@ -18,9 +18,9 @@ test_expect_success \
     mkdir -p .git/patches && touch .git/patches/foo
 '
=20
-test_expect_failure \
+test_expect_success \
     'Try to create an stgit branch with a spurious patches/ entry' '
-    stg branch -c foo
+    ! stg branch -c foo
 '
=20
 test_expect_success \
@@ -35,9 +35,9 @@ test_expect_success \
     cp .git/refs/heads/master .git/refs/heads/foo
 '
=20
-test_expect_failure \
+test_expect_success \
     'Try to create an stgit branch with an existing git branch by that=
 name' '
-    stg branch -c foo
+    ! stg branch -c foo
 '
=20
 test_expect_success \
diff --git a/t/t1001-branch-rename.sh b/t/t1001-branch-rename.sh
index 285440f..dd12132 100755
--- a/t/t1001-branch-rename.sh
+++ b/t/t1001-branch-rename.sh
@@ -17,9 +17,9 @@ test_expect_success \
      stg new p1 -m "p1"
 '
=20
-test_expect_failure \
+test_expect_success \
     'Rename the current stgit branch' \
-    'stg branch -r foo bar
+    '! stg branch -r foo bar
 '
=20
 test_expect_success \
diff --git a/t/t1002-branch-clone.sh b/t/t1002-branch-clone.sh
index 1d7fc39..b0087e9 100755
--- a/t/t1002-branch-clone.sh
+++ b/t/t1002-branch-clone.sh
@@ -18,10 +18,10 @@ test_expect_success \
     git commit -a -m bar
     '
=20
-test_expect_failure \
+test_expect_success \
     'Try to create a patch in a GIT branch' \
     '
-    stg new p0 -m "p0"
+    ! stg new p0 -m "p0"
     '
=20
 test_expect_success \
diff --git a/t/t1200-push-modified.sh b/t/t1200-push-modified.sh
index 0e408d0..cfec696 100755
--- a/t/t1200-push-modified.sh
+++ b/t/t1200-push-modified.sh
@@ -47,9 +47,9 @@ test_expect_success \
      )
 "
=20
-test_expect_failure \
+test_expect_success \
     'Attempt to push the first of those patches without --merged' \
-    "(cd bar && stg push
+    "(cd bar && ! stg push
      )
 "
=20
diff --git a/t/t1202-push-undo.sh b/t/t1202-push-undo.sh
index 335b554..039103a 100755
--- a/t/t1202-push-undo.sh
+++ b/t/t1202-push-undo.sh
@@ -40,10 +40,10 @@ test_expect_success \
 	stg pop --all
 	'
=20
-test_expect_failure \
+test_expect_success \
 	'Push the second patch with conflict' \
 	'
-	stg push bar
+	! stg push bar
 	'
=20
 test_expect_success \
diff --git a/t/t2000-sync.sh b/t/t2000-sync.sh
index f831df7..484dbab 100755
--- a/t/t2000-sync.sh
+++ b/t/t2000-sync.sh
@@ -106,10 +106,10 @@ test_expect_success \
     test $(cat bar2.txt) =3D "bar2"
     '
=20
-test_expect_failure \
+test_expect_success \
     'Synchronise the first two patches with the master branch (to fail=
)' \
     '
-    stg sync -B master -a
+    ! stg sync -B master -a
     '
=20
 test_expect_success \
@@ -124,10 +124,10 @@ test_expect_success \
     [ "$(echo $(stg unapplied))" =3D "" ]
     '
=20
-test_expect_failure \
+test_expect_success \
     'Synchronise the third patch with the exported series (to fail)' \
     '
-    stg sync -s patches-master/series p3
+    ! stg sync -s patches-master/series p3
     '
=20
 test_expect_success \
diff --git a/t/t2100-pull-policy-fetch.sh b/t/t2100-pull-policy-fetch.s=
h
index e1398a3..1f50069 100755
--- a/t/t2100-pull-policy-fetch.sh
+++ b/t/t2100-pull-policy-fetch.sh
@@ -65,8 +65,8 @@ test_expect_success \
     (cd clone && stg commit && stg new c2 -m c2 &&
      echo a >> file && stg refresh)
     '
-test_expect_failure \
+test_expect_success \
     'Try to  and commit a patch in clone' \
-    '(cd clone && stg pull)'
+    '(cd clone && ! stg pull)'
=20
 test_done
diff --git a/t/t2102-pull-policy-rebase.sh b/t/t2102-pull-policy-rebase=
=2Esh
index 670673d..b2fbfcf 100755
--- a/t/t2102-pull-policy-rebase.sh
+++ b/t/t2102-pull-policy-rebase.sh
@@ -46,18 +46,18 @@ test_expect_success \
     stg branch stack && stg commit && stg new c2 -m c2 &&
      echo a >> file && stg refresh
     '
-test_expect_failure \
+test_expect_success \
     'Try to pull/rebase now that stack base has moved' \
-    'stg pull'
+    '! stg pull'
=20
 test_expect_success \
     'Force the pull/rebase, but do not push yet' \
     'stg pull --force --nopush'
-test_expect_failure \
+test_expect_success \
     '...check we lost the committed patch' \
-    'test -e file'
-test_expect_failure \
+    '! test -e file'
+test_expect_success \
     '...and check we get a conflict while pushing' \
-    'stg push'
+    '! stg push'
=20
 test_done
diff --git a/t/t2200-rebase.sh b/t/t2200-rebase.sh
index c142e08..ec2a104 100755
--- a/t/t2200-rebase.sh
+++ b/t/t2200-rebase.sh
@@ -31,10 +31,10 @@ test_expect_success \
 	test `stg applied | wc -l` =3D 1
 	'
=20
-test_expect_failure \
+test_expect_success \
 	'Attempt rebase to non-existing commit' \
 	'
-	stg rebase not-a-ref
+	! stg rebase not-a-ref
 	'
=20
 test_expect_success \
