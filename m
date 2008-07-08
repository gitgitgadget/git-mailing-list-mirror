From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH 1/2] Test for specific exit code
Date: Tue, 08 Jul 2008 06:03:11 +0200
Message-ID: <20080708040311.23134.76097.stgit@yoghurt>
References: <20080708035750.23134.75833.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jul 08 06:04:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KG4R2-00030a-J7
	for gcvg-git-2@gmane.org; Tue, 08 Jul 2008 06:04:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750782AbYGHEDR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 8 Jul 2008 00:03:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750748AbYGHEDR
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jul 2008 00:03:17 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4297 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750717AbYGHEDQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jul 2008 00:03:16 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1KG4Q2-0000Xz-00; Tue, 08 Jul 2008 05:03:10 +0100
In-Reply-To: <20080708035750.23134.75833.stgit@yoghurt>
User-Agent: StGIT/0.14.3.185.gb9e85
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87696>

When a command is supposed to fail in a test, test for the exact error
code we're expecting, not just that it's non-zero. This makes sure
e.g. that a command that's supposed to fail doesn't do so with an
unhandled exception.

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

 t/README                    |    6 +++---
 t/t0001-subdir-branches.sh  |   12 ++++++------
 t/t0002-status.sh           |    2 +-
 t/t1000-branch-create.sh    |    8 ++++----
 t/t1001-branch-rename.sh    |    2 +-
 t/t1002-branch-clone.sh     |    2 +-
 t/t1200-push-modified.sh    |    2 +-
 t/t1202-push-undo.sh        |    4 ++--
 t/t1203-push-conflict.sh    |    4 ++--
 t/t1205-push-subdir.sh      |    4 ++--
 t/t1301-repair.sh           |    2 +-
 t/t1302-repair-interop.sh   |    4 ++--
 t/t1400-patch-history.sh    |    2 +-
 t/t1501-sink.sh             |    2 +-
 t/t1600-delete-one.sh       |    4 ++--
 t/t1601-delete-many.sh      |    2 +-
 t/t2000-sync.sh             |    4 ++--
 t/t2101-pull-policy-pull.sh |    2 +-
 t/t2200-rebase.sh           |    2 +-
 t/t2500-clean.sh            |    2 +-
 t/t2900-rename.sh           |    8 ++++----
 t/t3000-dirty-merge.sh      |    2 +-
 t/t4000-upgrade.sh          |    2 +-
 t/test-lib.sh               |   24 ++++++++++++++++++++++++
 24 files changed, 66 insertions(+), 42 deletions(-)


diff --git a/t/README b/t/README
index 77f0b6c..757f810 100644
--- a/t/README
+++ b/t/README
@@ -163,9 +163,9 @@ library for your script to use.
    yields success, test is considered a failure.
=20
    This should _not_ be used for tests that succeed when their
-   commands fail -- use test_expect_success and shell negation (!) for
-   that. test_expect_failure is for cases when a test is known to be
-   broken.
+   commands fail -- use test_expect_success and one of general_error,
+   command_error, and conflict for that. test_expect_failure is for
+   cases when a test is known to be broken.
=20
  - test_debug <script>
=20
diff --git a/t/t0001-subdir-branches.sh b/t/t0001-subdir-branches.sh
index 0eed3a4..69c11a3 100755
--- a/t/t0001-subdir-branches.sh
+++ b/t/t0001-subdir-branches.sh
@@ -39,9 +39,9 @@ test_expect_success 'Try new form of id with slashy b=
ranch' \
    stg id foo@x/y/z//top'
=20
 test_expect_success 'Try old id with slashy branch' '
-   ! stg id foo/ &&
-   ! stg id foo/top &&
-   ! stg id foo@x/y/z/top
+   command_error stg id foo/ &&
+   command_error stg id foo/top &&
+   command_error stg id foo@x/y/z/top
    '
=20
 test_expect_success 'Create patch in slashy branch' \
@@ -51,11 +51,11 @@ test_expect_success 'Create patch in slashy branch'=
 \
=20
 test_expect_success 'Rename branches' \
   'stg branch --rename master goo/gaa &&
-   ! git show-ref --verify --quiet refs/heads/master &&
+   must_fail git show-ref --verify --quiet refs/heads/master &&
    stg branch --rename goo/gaa x1/x2/x3/x4 &&
-   ! git show-ref --verify --quiet refs/heads/goo/gaa &&
+   must_fail git show-ref --verify --quiet refs/heads/goo/gaa &&
    stg branch --rename x1/x2/x3/x4 servant &&
-   ! git show-ref --verify --quiet refs/heads/x1/x2/x3/x4
+   must_fail git show-ref --verify --quiet refs/heads/x1/x2/x3/x4
 '
=20
 test_done
diff --git a/t/t0002-status.sh b/t/t0002-status.sh
index 4364709..d9cb2cc 100755
--- a/t/t0002-status.sh
+++ b/t/t0002-status.sh
@@ -114,7 +114,7 @@ A fie
 C foo/bar
 EOF
 test_expect_success 'Status after conflicting push' '
-    ! stg push &&
+    conflict_old stg push &&
     stg status > output.txt &&
     test_cmp expected.txt output.txt
 '
diff --git a/t/t1000-branch-create.sh b/t/t1000-branch-create.sh
index 5a097a4..3fff3ee 100755
--- a/t/t1000-branch-create.sh
+++ b/t/t1000-branch-create.sh
@@ -26,7 +26,7 @@ test_expect_success \
=20
 test_expect_success \
     'Try to create an stgit branch with a spurious patches/ entry' '
-    ! stg branch -c foo1
+    command_error stg branch -c foo1
 '
=20
 test_expect_success \
@@ -43,7 +43,7 @@ test_expect_success \
=20
 test_expect_success \
     'Try to create an stgit branch with an existing git branch by that=
 name' '
-    ! stg branch -c foo2
+    command_error stg branch -c foo2
 '
=20
 test_expect_success \
@@ -58,7 +58,7 @@ test_expect_success \
 test_expect_success \
     'Create an invalid refs/heads/ entry' '
     touch .git/refs/heads/foo3 &&
-    ! stg branch -c foo3
+    command_error stg branch -c foo3
 '
=20
 test_expect_failure \
@@ -87,7 +87,7 @@ test_expect_success \
=20
 test_expect_success \
     'Create branch down the stack, behind the conflict caused by the g=
enerated file' '
-    ! stg branch --create foo4 master^
+    command_error stg branch --create foo4 master^
 '
=20
 test_expect_success \
diff --git a/t/t1001-branch-rename.sh b/t/t1001-branch-rename.sh
index dd12132..d5d3aef 100755
--- a/t/t1001-branch-rename.sh
+++ b/t/t1001-branch-rename.sh
@@ -19,7 +19,7 @@ test_expect_success \
=20
 test_expect_success \
     'Rename the current stgit branch' \
-    '! stg branch -r foo bar
+    'command_error stg branch -r foo bar
 '
=20
 test_expect_success \
diff --git a/t/t1002-branch-clone.sh b/t/t1002-branch-clone.sh
index b0087e9..19bdc45 100755
--- a/t/t1002-branch-clone.sh
+++ b/t/t1002-branch-clone.sh
@@ -21,7 +21,7 @@ test_expect_success \
 test_expect_success \
     'Try to create a patch in a GIT branch' \
     '
-    ! stg new p0 -m "p0"
+    command_error stg new p0 -m "p0"
     '
=20
 test_expect_success \
diff --git a/t/t1200-push-modified.sh b/t/t1200-push-modified.sh
index ba4f70c..6ebd0a1 100755
--- a/t/t1200-push-modified.sh
+++ b/t/t1200-push-modified.sh
@@ -49,7 +49,7 @@ test_expect_success \
=20
 test_expect_success \
     'Attempt to push the first of those patches without --merged' \
-    "(cd bar && ! stg push
+    "(cd bar && conflict_old stg push
      )
 "
=20
diff --git a/t/t1202-push-undo.sh b/t/t1202-push-undo.sh
index b602643..544fe8d 100755
--- a/t/t1202-push-undo.sh
+++ b/t/t1202-push-undo.sh
@@ -43,7 +43,7 @@ test_expect_success \
 test_expect_success \
 	'Push the second patch with conflict' \
 	'
-	! stg push bar
+	conflict_old stg push bar
 	'
=20
 test_expect_success \
@@ -55,7 +55,7 @@ test_expect_success \
 test_expect_success \
 	'Check the push after undo fails as well' \
 	'
-	! stg push bar
+	conflict_old stg push bar
 	'
=20
 test_expect_success \
diff --git a/t/t1203-push-conflict.sh b/t/t1203-push-conflict.sh
index 72bd49f..96fee15 100755
--- a/t/t1203-push-conflict.sh
+++ b/t/t1203-push-conflict.sh
@@ -38,7 +38,7 @@ test_expect_success \
 test_expect_success \
 	'Push the first patch with conflict' \
 	'
-	! stg push foo
+	conflict_old stg push foo
 	'
=20
 test_expect_success \
@@ -56,7 +56,7 @@ test_expect_success \
 test_expect_success \
 	'Check that pop will fail while there are unmerged conflicts' \
 	'
-	! stg pop
+	command_error stg pop
 	'
=20
 test_expect_success \
diff --git a/t/t1205-push-subdir.sh b/t/t1205-push-subdir.sh
index 175d36d..945eb74 100755
--- a/t/t1205-push-subdir.sh
+++ b/t/t1205-push-subdir.sh
@@ -47,7 +47,7 @@ test_expect_success 'Conflicting push from subdir' '
     [ "$(echo $(cat x.txt))" =3D "x0" ] &&
     [ "$(echo $(cat foo/y.txt))" =3D "y0" ] &&
     cd foo &&
-    ! stg push p2 &&
+    conflict_old stg push p2 &&
     cd .. &&
     [ "$(echo $(stg status --conflict))" =3D "foo/y.txt x.txt" ]
 '
@@ -62,7 +62,7 @@ test_expect_success 'Conflicting add/unknown file in =
subdir' '
     stg pop &&
     mkdir -p d &&
     echo bar > d/test &&
-    ! stg push foo &&
+    command_error stg push foo &&
     [ $(stg top) !=3D "foo" ]
 '
=20
diff --git a/t/t1301-repair.sh b/t/t1301-repair.sh
index b555b93..33f8f6d 100755
--- a/t/t1301-repair.sh
+++ b/t/t1301-repair.sh
@@ -5,7 +5,7 @@ test_description=3D'Test the repair command.'
=20
 test_expect_success \
     'Repair in a non-initialized repository' \
-    '! stg repair'
+    'command_error stg repair'
=20
 test_expect_success \
     'Initialize the StGIT repository' \
diff --git a/t/t1302-repair-interop.sh b/t/t1302-repair-interop.sh
index 82c5ed2..3ea48e7 100755
--- a/t/t1302-repair-interop.sh
+++ b/t/t1302-repair-interop.sh
@@ -27,7 +27,7 @@ test_expect_success 'Create five patches' '
=20
 test_expect_success 'Pop two patches with git-reset' '
     git reset --hard HEAD~2 &&
-    ! stg refresh &&
+    command_error stg refresh &&
     stg repair &&
     stg refresh &&
     [ "$(echo $(stg applied))" =3D "p0 p1 p2" ] &&
@@ -42,7 +42,7 @@ test_expect_success 'Create a new patch' '
=20
 test_expect_success 'Go to an unapplied patch with with git-reset' '
     git reset --hard $(stg id p3) &&
-    ! stg refresh &&
+    command_error stg refresh &&
     stg repair &&
     stg refresh &&
     [ "$(echo $(stg applied))" =3D "p0 p1 p2 p3" ] &&
diff --git a/t/t1400-patch-history.sh b/t/t1400-patch-history.sh
index a693e75..13cd1e3 100755
--- a/t/t1400-patch-history.sh
+++ b/t/t1400-patch-history.sh
@@ -82,7 +82,7 @@ test_expect_success \
 	echo bar > test && stg refresh &&
 	stg pop &&
 	echo foo > test && stg refresh &&
-	! stg push &&
+	conflict_old stg push &&
 	stg log --full | grep -q -e "^push(c) "
 	'
=20
diff --git a/t/t1501-sink.sh b/t/t1501-sink.sh
index 6af45fe..ac9e25d 100755
--- a/t/t1501-sink.sh
+++ b/t/t1501-sink.sh
@@ -17,7 +17,7 @@ test_expect_success 'Initialize StGit stack' '
 '
=20
 test_expect_success 'sink without applied patches' '
-    ! stg sink
+    command_error stg sink
 '
=20
 test_expect_success 'sink a specific patch without applied patches' '
diff --git a/t/t1600-delete-one.sh b/t/t1600-delete-one.sh
index c3451d8..b526a55 100755
--- a/t/t1600-delete-one.sh
+++ b/t/t1600-delete-one.sh
@@ -20,7 +20,7 @@ test_expect_success \
     'Try to delete a non-existing patch' \
     '
     [ $(stg applied | wc -l) -eq 1 ] &&
-    ! stg delete bar &&
+    command_error stg delete bar &&
     [ $(stg applied | wc -l) -eq 1 ]
     '
=20
@@ -29,7 +29,7 @@ test_expect_success \
     '
     echo dirty >> foo.txt &&
     [ $(stg applied | wc -l) -eq 1 ] &&
-    ! stg delete foo &&
+    command_error stg delete foo &&
     [ $(stg applied | wc -l) -eq 1 ] &&
     git reset --hard
     '
diff --git a/t/t1601-delete-many.sh b/t/t1601-delete-many.sh
index 30b0a1d..bc5364f 100755
--- a/t/t1601-delete-many.sh
+++ b/t/t1601-delete-many.sh
@@ -37,7 +37,7 @@ test_expect_success \
     '
     [ "$(echo $(stg applied))" =3D "p0 p1 p2" ] &&
     [ "$(echo $(stg unapplied))" =3D "p5 p8 p9" ] &&
-    ! stg delete p7 p8 p2 p0 &&
+    command_error stg delete p7 p8 p2 p0 &&
     [ "$(echo $(stg applied))" =3D "p0 p1 p2" ] &&
     [ "$(echo $(stg unapplied))" =3D "p5 p8 p9" ]
     '
diff --git a/t/t2000-sync.sh b/t/t2000-sync.sh
index e489603..9852eb8 100755
--- a/t/t2000-sync.sh
+++ b/t/t2000-sync.sh
@@ -109,7 +109,7 @@ test_expect_success \
 test_expect_success \
     'Synchronise the first two patches with the master branch (to fail=
)' \
     '
-    ! stg sync -B master -a
+    conflict_old stg sync -B master -a
     '
=20
 test_expect_success \
@@ -127,7 +127,7 @@ test_expect_success \
 test_expect_success \
     'Synchronise the third patch with the exported series (to fail)' \
     '
-    ! stg sync -s patches-master/series p3
+    conflict_old stg sync -s patches-master/series p3
     '
=20
 test_expect_success \
diff --git a/t/t2101-pull-policy-pull.sh b/t/t2101-pull-policy-pull.sh
index ce4b5c8..777ccb5 100755
--- a/t/t2101-pull-policy-pull.sh
+++ b/t/t2101-pull-policy-pull.sh
@@ -43,7 +43,7 @@ test_expect_success \
     'Rewind/rewrite upstream commit and pull it from clone, without --=
merged' \
     '
     (cd upstream && echo b >> file2 && stg refresh) &&
-    (cd clone && ! stg pull)
+    (cd clone && conflict_old stg pull)
     '
=20
 test_expect_success \
diff --git a/t/t2200-rebase.sh b/t/t2200-rebase.sh
index ec2a104..a6f43bc 100755
--- a/t/t2200-rebase.sh
+++ b/t/t2200-rebase.sh
@@ -34,7 +34,7 @@ test_expect_success \
 test_expect_success \
 	'Attempt rebase to non-existing commit' \
 	'
-	! stg rebase not-a-ref
+	command_error stg rebase not-a-ref
 	'
=20
 test_expect_success \
diff --git a/t/t2500-clean.sh b/t/t2500-clean.sh
index ad8f892..abde9cf 100755
--- a/t/t2500-clean.sh
+++ b/t/t2500-clean.sh
@@ -32,7 +32,7 @@ test_expect_success 'Create a conflict' '
     stg new p2 -m p2
     echo quux > foo.txt &&
     stg refresh &&
-    ! stg push
+    conflict_old stg push
 '
=20
 test_expect_success 'Make sure conflicting patches are preserved' '
diff --git a/t/t2900-rename.sh b/t/t2900-rename.sh
index 5f47f86..0e16d6e 100755
--- a/t/t2900-rename.sh
+++ b/t/t2900-rename.sh
@@ -13,7 +13,7 @@ Tests some parts of the stg rename command.'
 stg init
=20
 test_expect_success 'Rename in empty' '
-   ! stg rename foo
+   command_error stg rename foo
 '
=20
 test_expect_success 'Rename single top-most' '
@@ -23,7 +23,7 @@ test_expect_success 'Rename single top-most' '
 # bar
=20
 test_expect_success 'Rename non-existing' '
-   ! stg rename neithersuchpatch norsuchpatch
+   command_error stg rename neithersuchpatch norsuchpatch
 '
=20
 test_expect_success 'Rename with two arguments' '
@@ -33,11 +33,11 @@ test_expect_success 'Rename with two arguments' '
 # foo,baz
=20
 test_expect_success 'Rename to existing name' '
-   ! stg rename foo baz
+   command_error stg rename foo baz
 '
=20
 test_expect_success 'Rename to same name' '
-   ! stg rename foo foo
+   command_error stg rename foo foo
 '
=20
 test_expect_success 'Rename top-most when others exist' '
diff --git a/t/t3000-dirty-merge.sh b/t/t3000-dirty-merge.sh
index d87bba1..4dd6da3 100755
--- a/t/t3000-dirty-merge.sh
+++ b/t/t3000-dirty-merge.sh
@@ -26,7 +26,7 @@ test_expect_success 'Push with dirty worktree' '
     echo 4 > a &&
     [ "$(echo $(stg applied))" =3D "p1" ] &&
     [ "$(echo $(stg unapplied))" =3D "p2" ] &&
-    ! stg goto p2 &&
+    conflict stg goto p2 &&
     [ "$(echo $(stg applied))" =3D "p1" ] &&
     [ "$(echo $(stg unapplied))" =3D "p2" ] &&
     [ "$(echo $(cat a))" =3D "4" ]
diff --git a/t/t4000-upgrade.sh b/t/t4000-upgrade.sh
index 8a308fb..ea9bf0b 100755
--- a/t/t4000-upgrade.sh
+++ b/t/t4000-upgrade.sh
@@ -31,7 +31,7 @@ for ver in 0.12 0.8; do
=20
     test_expect_success \
         "v$ver: Make sure the base ref is no longer there" '
-        ! git show-ref --verify --quiet refs/bases/master
+        must_fail git show-ref --verify --quiet refs/bases/master
     '
=20
     cd ..
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 95e322e..ad8da68 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -285,6 +285,30 @@ test_expect_code () {
 	echo >&3 ""
 }
=20
+# When running an StGit command that should exit with an error, use
+# these instead of testing for any non-zero exit code with !.
+exit_code () {
+	expected=3D$1
+	shift
+	"$@"
+	test $? -eq $expected
+}
+general_error () { exit_code 1 "$@" ; }
+command_error () { exit_code 2 "$@" ; }
+conflict () { exit_code 3 "$@" ; }
+
+# Old-infrastructure commands don't exit with the proper value on
+# conflicts. But we don't want half the tests to fail because of that,
+# so use this instead of "conflict" for them.
+conflict_old () { command_error "$@" ; }
+
+# Same thing, but for other commands that StGit where we just want to
+# make sure that they fail instead of crashing.
+must_fail () {
+        "$@"
+        test $? -gt 0 -a $? -le 129
+}
+
 # test_cmp is a helper function to compare actual and expected output.
 # You can use it like:
 #
