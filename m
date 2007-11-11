From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH 4/5] Rename "stg assimilate" to "stg repair"
Date: Sun, 11 Nov 2007 20:43:57 +0100
Message-ID: <20071111194356.18868.75466.stgit@yoghurt>
References: <20071111193545.18868.62490.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	David =?utf-8?q?K=C3=A5gedal?= <davidk@lysator.liu.se>
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 11 20:44:26 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IrIjH-0001Wh-3w
	for gcvg-git-2@gmane.org; Sun, 11 Nov 2007 20:44:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756830AbXKKToH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 11 Nov 2007 14:44:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756832AbXKKToG
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Nov 2007 14:44:06 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3892 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756815AbXKKToE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Nov 2007 14:44:04 -0500
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1IrIis-0004cE-00; Sun, 11 Nov 2007 19:43:58 +0000
In-Reply-To: <20071111193545.18868.62490.stgit@yoghurt>
User-Agent: StGIT/0.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/64503>

With the capabilities it's gained lately, this is a better name.

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

 Documentation/stg.txt         |    4 -
 contrib/stgit-completion.bash |    2=20
 stgit/commands/assimilate.py  |  198 ---------------------------------=
--------
 stgit/commands/common.py      |    2=20
 stgit/commands/repair.py      |  197 +++++++++++++++++++++++++++++++++=
++++++++
 stgit/main.py                 |    4 -
 t/t1301-assimilate.sh         |   84 -----------------
 t/t1301-repair.sh             |   80 +++++++++++++++++
 t/t1302-assimilate-interop.sh |   59 ------------
 t/t1302-repair-interop.sh     |   59 ++++++++++++
 10 files changed, 342 insertions(+), 347 deletions(-)
 delete mode 100644 stgit/commands/assimilate.py
 create mode 100644 stgit/commands/repair.py
 delete mode 100755 t/t1301-assimilate.sh
 create mode 100755 t/t1301-repair.sh
 delete mode 100755 t/t1302-assimilate-interop.sh
 create mode 100755 t/t1302-repair-interop.sh


diff --git a/Documentation/stg.txt b/Documentation/stg.txt
index 4f9d18e..f6cd815 100644
--- a/Documentation/stg.txt
+++ b/Documentation/stg.txt
@@ -146,8 +146,8 @@ stglink:commit[]::
 	stgdesc:commit[]
 stglink:uncommit[]::
 	stgdesc:uncommit[]
-stglink:assimilate[]::
-	stgdesc:assimilate[]
+stglink:repair[]::
+	stgdesc:repair[]
=20
 Controlling what patches are applied
 ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
diff --git a/contrib/stgit-completion.bash b/contrib/stgit-completion.b=
ash
index b1d2730..b3b23d4 100644
--- a/contrib/stgit-completion.bash
+++ b/contrib/stgit-completion.bash
@@ -13,7 +13,6 @@
 _stg_commands=3D"
     add
     applied
-    assimilate
     branch
     delete
     diff
@@ -42,6 +41,7 @@ _stg_commands=3D"
     rebase
     refresh
     rename
+    repair
     resolved
     rm
     series
diff --git a/stgit/commands/common.py b/stgit/commands/common.py
index 2a80e8c..2672dcf 100644
--- a/stgit/commands/common.py
+++ b/stgit/commands/common.py
@@ -114,7 +114,7 @@ def check_head_top_equal(crt_series):
     if not crt_series.head_top_equal():
         raise CmdException(
 """HEAD and top are not the same. This can happen if you
-   modify a branch with git. The "assimilate" command can
+   modify a branch with git. The "repair" command can
    fix this situation.""")
=20
 def check_conflicts():
diff --git a/stgit/commands/assimilate.py b/stgit/commands/repair.py
similarity index 90%
rename from stgit/commands/assimilate.py
rename to stgit/commands/repair.py
index be992aa..f8fe624 100644
--- a/stgit/commands/assimilate.py
+++ b/stgit/commands/repair.py
@@ -29,28 +29,28 @@ from stgit import stack, git
 help =3D 'StGit-ify any git commits made on top of your StGit stack'
 usage =3D """%prog [options]
=20
-"assimilate" will repair three kinds of inconsistencies in your StGit
+"repair" will repair three kinds of inconsistencies in your StGit
 stack, all of them caused by using plain git commands on the branch:
=20
   1. If you have made regular git commits on top of your stack of
-     StGit patches, "assimilate" converts them to StGit patches,
+     StGit patches, "repair" converts them to StGit patches,
      preserving their contents.
=20
   2. Merge commits cannot become patches; if you have committed a
-     merge on top of your stack, "assimilate" will simply mark all
+     merge on top of your stack, "repair" will simply mark all
      patches below the merge unapplied, since they are no longer
      reachable. If this is not what you want, use "git reset" to get
-     rid of the merge and run "assimilate" again.
+     rid of the merge and run "repair" again.
=20
   3. The applied patches are supposed to be precisely those that are
      reachable from the branch head. If you have used e.g. "git reset"
      to move the head, some applied patches may no longer be
      reachable, and some unapplied patches may have become reachable.
-     "assimilate" will correct the appliedness of such patches.
+     "repair" will correct the appliedness of such patches.
=20
 Note that these are "inconsistencies", not "errors"; furthermore,
-"assimilate" will repair them reliably. As long as you are satisfied
-with the way "assimilate" handles them, you have no reason to avoid
+"repair" will repair them reliably. As long as you are satisfied
+with the way "repair" handles them, you have no reason to avoid
 causing them in the first place if that is convenient for you."""
=20
 directory =3D DirectoryGotoToplevel()
@@ -99,11 +99,10 @@ def read_commit_dag(branch):
     return commits, patches
=20
 def func(parser, options, args):
-    """Assimilate a number of patches.
-    """
+    """Repair inconsistencies in StGit metadata."""
=20
     def nothing_to_do():
-        out.info('No commits to assimilate')
+        out.info('Nothing to repair')
=20
     orig_applied =3D crt_series.get_applied()
     orig_unapplied =3D crt_series.get_unapplied()
@@ -118,7 +117,7 @@ def func(parser, options, args):
         raise CmdException(
             'This branch is protected. Modification is not permitted.'=
)
=20
-    # Find commits to assimilate, and applied patches.
+    # Find commits that aren't patches, and applied patches.
     commits, patches =3D read_commit_dag(crt_series.get_name())
     c =3D commits[head]
     patchify =3D []
@@ -149,7 +148,7 @@ def func(parser, options, args):
                   % (len(hidden), ['es', ''][len(hidden) =3D=3D 1])),
                  '%s,' % merge.id, 'and will be considered unapplied.'=
)
=20
-    # Assimilate any linear sequence of commits on top of a patch.
+    # Make patches of any linear sequence of commits on top of a patch=
=2E
     names =3D set(p.patch for p in patches)
     def name_taken(name):
         return name in names
diff --git a/stgit/main.py b/stgit/main.py
index e8242c2..a03447f 100644
--- a/stgit/main.py
+++ b/stgit/main.py
@@ -60,7 +60,6 @@ class Commands(dict):
 commands =3D Commands({
     'add':              'add',
     'applied':          'applied',
-    'assimilate':       'assimilate',
     'branch':           'branch',
     'delete':           'delete',
     'diff':             'diff',
@@ -89,6 +88,7 @@ commands =3D Commands({
     'rebase':           'rebase',
     'refresh':          'refresh',
     'rename':           'rename',
+    'repair':           'repair',
     'resolved':         'resolved',
     'rm':               'rm',
     'series':           'series',
@@ -109,7 +109,6 @@ repocommands =3D (
     )
 stackcommands =3D (
     'applied',
-    'assimilate',
     'branch',
     'clean',
     'commit',
@@ -122,6 +121,7 @@ stackcommands =3D (
     'pull',
     'push',
     'rebase',
+    'repair',
     'series',
     'sink',
     'top',
diff --git a/t/t1301-assimilate.sh b/t/t1301-repair.sh
similarity index 70%
rename from t/t1301-assimilate.sh
rename to t/t1301-repair.sh
index 7f47c31..5d9bdbd 100755
--- a/t/t1301-assimilate.sh
+++ b/t/t1301-repair.sh
@@ -1,19 +1,19 @@
 #!/bin/sh
 # Copyright (c) 2006 Karl Hasselstr=C3=B6m
-test_description=3D'Test the assimilate command.'
+test_description=3D'Test the repair command.'
 . ./test-lib.sh
=20
 test_expect_success \
-    'Assimilate in a non-initialized repository' \
-    '! stg assimilate'
+    'Repair in a non-initialized repository' \
+    '! stg repair'
=20
 test_expect_success \
     'Initialize the StGIT repository' \
     'stg init'
=20
 test_expect_success \
-    'Assimilate in a repository without patches' \
-    'stg assimilate'
+    'Repair in a repository without patches' \
+    'stg repair'
=20
 test_expect_success \
     'Create a patch' \
@@ -25,8 +25,8 @@ test_expect_success \
     '
=20
 test_expect_success \
-    'Assimilate when there is nothing to do' \
-    'stg assimilate'
+    'Repair when there is nothing to do' \
+    'stg repair'
=20
 test_expect_success \
     'Create a GIT commit' \
@@ -36,11 +36,9 @@ test_expect_success \
     git commit -a -m bar
     '
=20
-test_expect_success \
-    'Assimilate one GIT commit' \
-    '
+test_expect_success 'Turn one GIT commit into a patch' '
     [ $(stg applied | wc -l) -eq 1 ] &&
-    stg assimilate &&
+    stg repair &&
     [ $(stg applied | wc -l) -eq 2 ]
     '
=20
@@ -56,11 +54,9 @@ test_expect_success \
     git commit -a -m three
     '
=20
-test_expect_success \
-    'Assimilate three GIT commits' \
-    '
+test_expect_success 'Turn three GIT commits into patches' '
     [ $(stg applied | wc -l) -eq 2 ] &&
-    stg assimilate &&
+    stg repair &&
     [ $(stg applied | wc -l) -eq 5 ]
     '
=20
@@ -75,9 +71,9 @@ test_expect_success \
     git pull . br
     '
=20
-test_expect_success 'Assimilate in the presence of a merge commit' '
+test_expect_success 'Repair in the presence of a merge commit' '
     [ $(stg applied | wc -l) -eq 5 ] &&
-    stg assimilate &&
+    stg repair &&
     [ $(stg applied | wc -l) -eq 0 ]
 '
=20
diff --git a/t/t1302-assimilate-interop.sh b/t/t1302-repair-interop.sh
similarity index 91%
rename from t/t1302-assimilate-interop.sh
rename to t/t1302-repair-interop.sh
index 31f8b78..82c5ed2 100755
--- a/t/t1302-assimilate-interop.sh
+++ b/t/t1302-repair-interop.sh
@@ -1,5 +1,5 @@
 #!/bin/sh
-test_description=3D'Test git/StGit interoperability with "stg assimila=
te"'
+test_description=3D'Test git/StGit interoperability with "stg repair"'
 . ./test-lib.sh
=20
 test_expect_success 'Create some git-only history' '
@@ -28,7 +28,7 @@ test_expect_success 'Create five patches' '
 test_expect_success 'Pop two patches with git-reset' '
     git reset --hard HEAD~2 &&
     ! stg refresh &&
-    stg assimilate &&
+    stg repair &&
     stg refresh &&
     [ "$(echo $(stg applied))" =3D "p0 p1 p2" ] &&
     [ "$(echo $(stg unapplied))" =3D "p3 p4" ]
@@ -43,7 +43,7 @@ test_expect_success 'Create a new patch' '
 test_expect_success 'Go to an unapplied patch with with git-reset' '
     git reset --hard $(stg id p3) &&
     ! stg refresh &&
-    stg assimilate &&
+    stg repair &&
     stg refresh &&
     [ "$(echo $(stg applied))" =3D "p0 p1 p2 p3" ] &&
     [ "$(echo $(stg unapplied))" =3D "q0 p4" ]
@@ -51,7 +51,7 @@ test_expect_success 'Go to an unapplied patch with wi=
th git-reset' '
=20
 test_expect_success 'Go back to below the stack base with git-reset' '
     git reset --hard foo-tag &&
-    stg assimilate &&
+    stg repair &&
     [ "$(echo $(stg applied))" =3D "" ] &&
     [ "$(echo $(stg unapplied))" =3D "p0 p1 p2 p3 q0 p4" ]
 '
