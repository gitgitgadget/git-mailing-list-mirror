From: Catalin Marinas <catalin.marinas@gmail.com>
Subject: [StGIT PATCH 4/4] Remove the applied/unapplied commands
Date: Thu, 19 Jun 2008 22:42:33 +0100
Message-ID: <20080619214233.27794.98487.stgit@localhost.localdomain>
References: <20080619214023.27794.97039.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org,
	Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Thu Jun 19 23:44:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K9RvH-0005sU-Dw
	for gcvg-git-2@gmane.org; Thu, 19 Jun 2008 23:44:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754350AbYFSVmo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jun 2008 17:42:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753421AbYFSVmo
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jun 2008 17:42:44 -0400
Received: from mtaout01-winn.ispmail.ntl.com ([81.103.221.47]:20194 "EHLO
	mtaout01-winn.ispmail.ntl.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753468AbYFSVmm (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Jun 2008 17:42:42 -0400
Received: from aamtaout02-winn.ispmail.ntl.com ([81.103.221.35])
          by mtaout01-winn.ispmail.ntl.com with ESMTP
          id <20080619214658.KSDL28496.mtaout01-winn.ispmail.ntl.com@aamtaout02-winn.ispmail.ntl.com>;
          Thu, 19 Jun 2008 22:46:58 +0100
Received: from localhost.localdomain ([86.7.22.36])
          by aamtaout02-winn.ispmail.ntl.com with ESMTP
          id <20080619214545.IRFR29365.aamtaout02-winn.ispmail.ntl.com@localhost.localdomain>;
          Thu, 19 Jun 2008 22:45:45 +0100
In-Reply-To: <20080619214023.27794.97039.stgit@localhost.localdomain>
User-Agent: StGIT/0.14.3.163.g06f9
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/85543>

This patch moves the applied/unapplied functionality to the 'series'
command via the corresponding options.

Signed-off-by: Catalin Marinas <catalin.marinas@gmail.com>
---

 stgit/commands/applied.py   |   51 -------------------------------------------
 stgit/commands/series.py    |   13 +++++++++--
 stgit/commands/unapplied.py |   50 ------------------------------------------
 stgit/main.py               |    4 ---
 t/t1002-branch-clone.sh     |    6 +++--
 t/t1003-new.sh              |    4 ++-
 t/t1200-push-modified.sh    |   12 +++++-----
 t/t1203-pop.sh              |   12 +++++-----
 t/t1204-pop-keep.sh         |   12 +++++-----
 t/t1205-push-subdir.sh      |    4 ++-
 t/t1301-repair.sh           |   12 +++++-----
 t/t1302-repair-interop.sh   |   20 ++++++++---------
 t/t1500-float.sh            |   14 ++++++------
 t/t1600-delete-one.sh       |   28 ++++++++++++------------
 t/t1601-delete-many.sh      |   24 ++++++++++----------
 t/t2000-sync.sh             |   48 ++++++++++++++++++++--------------------
 t/t2200-rebase.sh           |    4 ++-
 t/t2500-clean.sh            |   12 +++++-----
 t/t2600-coalesce.sh         |   12 +++++-----
 t/t3000-dirty-merge.sh      |    8 +++----
 t/t4000-upgrade.sh          |    4 ++-
 21 files changed, 129 insertions(+), 225 deletions(-)
 delete mode 100644 stgit/commands/applied.py
 delete mode 100644 stgit/commands/unapplied.py

diff --git a/stgit/commands/applied.py b/stgit/commands/applied.py
deleted file mode 100644
index e57c796..0000000
--- a/stgit/commands/applied.py
+++ /dev/null
@@ -1,51 +0,0 @@
-
-__copyright__ = """
-Copyright (C) 2005, Catalin Marinas <catalin.marinas@gmail.com>
-
-This program is free software; you can redistribute it and/or modify
-it under the terms of the GNU General Public License version 2 as
-published by the Free Software Foundation.
-
-This program is distributed in the hope that it will be useful,
-but WITHOUT ANY WARRANTY; without even the implied warranty of
-MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-GNU General Public License for more details.
-
-You should have received a copy of the GNU General Public License
-along with this program; if not, write to the Free Software
-Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
-"""
-
-from optparse import make_option
-from stgit.out import *
-from stgit.commands import common
-
-
-help = 'print the applied patches'
-usage = """%prog [options]
-
-List the patches from the series which have already been pushed onto
-the stack. They are listed in the order in which they were pushed, the
-last one being the current (topmost) patch."""
-
-directory = common.DirectoryHasRepositoryLib()
-options = [make_option('-b', '--branch',
-                       help = 'use BRANCH instead of the default branch'),
-           make_option('-c', '--count',
-                       help = 'print the number of applied patches',
-                       action = 'store_true')]
-
-
-def func(parser, options, args):
-    """Show the applied patches
-    """
-    if len(args) != 0:
-        parser.error('incorrect number of arguments')
-
-    s = directory.repository.get_stack(options.branch)
-
-    if options.count:
-        out.stdout(len(s.patchorder.applied))
-    else:
-        for pn in s.patchorder.applied:
-            out.stdout(pn)
diff --git a/stgit/commands/series.py b/stgit/commands/series.py
index c11c74f..24d6ffa 100644
--- a/stgit/commands/series.py
+++ b/stgit/commands/series.py
@@ -37,6 +37,12 @@ options = [make_option('-b', '--branch',
            make_option('-a', '--all',
                        help = 'show all patches, including the hidden ones',
                        action = 'store_true'),
+           make_option('--applied',
+                       help = 'show the applied patches only',
+                       action = 'store_true'),
+           make_option('--unapplied',
+                       help = 'show the unapplied patches only',
+                       action = 'store_true'),
            make_option('--hidden',
                        help = 'show the hidden patches only',
                        action = 'store_true'),
@@ -112,17 +118,20 @@ def func(parser, options, args):
         stack = directory.repository.get_stack(options.missing)
 
     # current series patches
+    applied = unapplied = hidden = ()
     if options.all:
         applied = stack.patchorder.applied
         unapplied = stack.patchorder.unapplied
         hidden = stack.patchorder.hidden
+    elif options.applied:
+        applied = stack.patchorder.applied
+    elif options.unapplied:
+        unapplied = stack.patchorder.unapplied
     elif options.hidden:
-        applied = unapplied = ()
         hidden = stack.patchorder.hidden
     else:
         applied = stack.patchorder.applied
         unapplied = stack.patchorder.unapplied
-        hidden = ()
 
     if options.missing:
         cmp_patches = cmp_stack.patchorder.all
diff --git a/stgit/commands/unapplied.py b/stgit/commands/unapplied.py
deleted file mode 100644
index 7323346..0000000
--- a/stgit/commands/unapplied.py
+++ /dev/null
@@ -1,50 +0,0 @@
-
-__copyright__ = """
-Copyright (C) 2005, Catalin Marinas <catalin.marinas@gmail.com>
-
-This program is free software; you can redistribute it and/or modify
-it under the terms of the GNU General Public License version 2 as
-published by the Free Software Foundation.
-
-This program is distributed in the hope that it will be useful,
-but WITHOUT ANY WARRANTY; without even the implied warranty of
-MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-GNU General Public License for more details.
-
-You should have received a copy of the GNU General Public License
-along with this program; if not, write to the Free Software
-Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
-"""
-
-from optparse import make_option
-from stgit.out import *
-from stgit.commands import common
-
-
-help = 'print the unapplied patches'
-usage = """%prog [options]
-
-List the patches from the series which are not pushed onto the stack.
-They are listed in the reverse order in which they were popped."""
-
-directory = common.DirectoryHasRepositoryLib()
-options = [make_option('-b', '--branch',
-                       help = 'use BRANCH instead of the default branch'),
-           make_option('-c', '--count',
-                       help = 'print the number of unapplied patches',
-                       action = 'store_true')]
-
-
-def func(parser, options, args):
-    """Show the unapplied patches
-    """
-    if len(args) != 0:
-        parser.error('incorrect number of arguments')
-
-    s = directory.repository.get_stack(options.branch)
-
-    if options.count:
-        out.stdout(len(s.patchorder.unapplied))
-    else:
-        for pn in s.patchorder.unapplied:
-            out.stdout(pn)
diff --git a/stgit/main.py b/stgit/main.py
index aa1f8ef..7be8e14 100644
--- a/stgit/main.py
+++ b/stgit/main.py
@@ -59,7 +59,6 @@ class Commands(dict):
         return getattr(stgit.commands, cmd_mod)
 
 commands = Commands({
-    'applied':          'applied',
     'branch':           'branch',
     'delete':           'delete',
     'diff':             'diff',
@@ -96,7 +95,6 @@ commands = Commands({
     'status':           'status',
     'sync':             'sync',
     'top':              'top',
-    'unapplied':        'unapplied',
     'uncommit':         'uncommit',
     'unhide':           'unhide'
     })
@@ -107,7 +105,6 @@ repocommands = (
     'id',
     )
 stackcommands = (
-    'applied',
     'branch',
     'clean',
     'coalesce',
@@ -125,7 +122,6 @@ stackcommands = (
     'series',
     'sink',
     'top',
-    'unapplied',
     'uncommit',
     'unhide',
     )
diff --git a/t/t1002-branch-clone.sh b/t/t1002-branch-clone.sh
index b0087e9..7f3f913 100755
--- a/t/t1002-branch-clone.sh
+++ b/t/t1002-branch-clone.sh
@@ -29,16 +29,16 @@ test_expect_success \
     '
     stg branch --clone foo &&
     stg new p1 -m "p1" &&
-    test $(stg applied -c) -eq 1
+    test $(stg series --applied -c) -eq 1
     '
 
 test_expect_success \
     'Clone the current StGIT branch' \
     '
     stg branch --clone bar &&
-    test $(stg applied -c) -eq 1 &&
+    test $(stg series --applied -c) -eq 1 &&
     stg new p2 -m "p2" &&
-    test $(stg applied -c) -eq 2
+    test $(stg series --applied -c) -eq 2
     '
 
 test_done
diff --git a/t/t1003-new.sh b/t/t1003-new.sh
index 0be5d9b..826e41d 100755
--- a/t/t1003-new.sh
+++ b/t/t1003-new.sh
@@ -17,13 +17,13 @@ test_expect_success \
 test_expect_success \
     'Create a named patch' '
     stg new foo -m foobar &&
-    [ $(stg applied -c) -eq 1 ]
+    [ $(stg series --applied -c) -eq 1 ]
 '
 
 test_expect_success \
     'Create a patch without giving a name' '
     stg new -m yo &&
-    [ $(stg applied -c) -eq 2 ]
+    [ $(stg series --applied -c) -eq 2 ]
 '
 
 test_done
diff --git a/t/t1200-push-modified.sh b/t/t1200-push-modified.sh
index e3c6425..b8ca4cc 100755
--- a/t/t1200-push-modified.sh
+++ b/t/t1200-push-modified.sh
@@ -26,8 +26,8 @@ test_expect_success \
         printf "a\nc\n" > file && git add file && stg refresh &&
         stg new p2 -m p2 &&
         printf "a\nb\nc\n" > file && stg refresh &&
-        [ "$(echo $(stg applied))" = "p1 p2" ] &&
-        [ "$(echo $(stg unapplied))" = "" ]
+        [ "$(echo $(stg series --applied --noprefix))" = "p1 p2" ] &&
+        [ "$(echo $(stg series --unapplied --noprefix))" = "" ]
     )
 '
 
@@ -57,8 +57,8 @@ test_expect_success \
     'Rollback the push' '
     (
         cd bar && stg push --undo &&
-        [ "$(echo $(stg applied))" = "" ] &&
-        [ "$(echo $(stg unapplied))" = "p1 p2" ]
+        [ "$(echo $(stg series --applied --noprefix))" = "" ] &&
+        [ "$(echo $(stg series --unapplied --noprefix))" = "p1 p2" ]
     )
 '
 
@@ -66,8 +66,8 @@ test_expect_success \
     'Push those patches while checking they were merged upstream' '
     (
         cd bar && stg push --merged --all
-        [ "$(echo $(stg applied))" = "p1 p2" ] &&
-        [ "$(echo $(stg unapplied))" = "" ]
+        [ "$(echo $(stg series --applied --noprefix))" = "p1 p2" ] &&
+        [ "$(echo $(stg series --unapplied --noprefix))" = "" ]
     )
 '
 
diff --git a/t/t1203-pop.sh b/t/t1203-pop.sh
index 6e49b4d..e1ed577 100755
--- a/t/t1203-pop.sh
+++ b/t/t1203-pop.sh
@@ -12,22 +12,22 @@ test_expect_success \
     for i in 0 1 2 3 4 5 6 7 8 9; do
         stg new p$i -m p$i;
     done &&
-    [ "$(echo $(stg applied))" = "p0 p1 p2 p3 p4 p5 p6 p7 p8 p9" ] &&
-    [ "$(echo $(stg unapplied))" = "" ]
+    [ "$(echo $(stg series --applied --noprefix))" = "p0 p1 p2 p3 p4 p5 p6 p7 p8 p9" ] &&
+    [ "$(echo $(stg series --unapplied --noprefix))" = "" ]
 '
 
 test_expect_success \
     'Pop half the patches' '
     stg pop -n 5 &&
-    [ "$(echo $(stg applied))" = "p0 p1 p2 p3 p4" ] &&
-    [ "$(echo $(stg unapplied))" = "p5 p6 p7 p8 p9" ]
+    [ "$(echo $(stg series --applied --noprefix))" = "p0 p1 p2 p3 p4" ] &&
+    [ "$(echo $(stg series --unapplied --noprefix))" = "p5 p6 p7 p8 p9" ]
 '
 
 test_expect_success \
     'Pop the remaining patches' '
     stg pop -a &&
-    [ "$(echo $(stg applied))" = "" ] &&
-    [ "$(echo $(stg unapplied))" = "p0 p1 p2 p3 p4 p5 p6 p7 p8 p9" ]
+    [ "$(echo $(stg series --applied --noprefix))" = "" ] &&
+    [ "$(echo $(stg series --unapplied --noprefix))" = "p0 p1 p2 p3 p4 p5 p6 p7 p8 p9" ]
 '
 
 test_done
diff --git a/t/t1204-pop-keep.sh b/t/t1204-pop-keep.sh
index 35f4ec0..db473f2 100755
--- a/t/t1204-pop-keep.sh
+++ b/t/t1204-pop-keep.sh
@@ -11,8 +11,8 @@ test_expect_success 'Create a few patches' '
         git add patch$i.txt &&
         stg refresh
     done &&
-    [ "$(echo $(stg applied))" = "p0 p1 p2" ] &&
-    [ "$(echo $(stg unapplied))" = "" ]
+    [ "$(echo $(stg series --applied --noprefix))" = "p0 p1 p2" ] &&
+    [ "$(echo $(stg series --unapplied --noprefix))" = "" ]
 '
 
 test_expect_success 'Make some non-conflicting local changes' '
@@ -21,8 +21,8 @@ test_expect_success 'Make some non-conflicting local changes' '
 
 test_expect_success 'Pop two patches, keeping local changes' '
     stg pop -n 2 --keep &&
-    [ "$(echo $(stg applied))" = "p0" ] &&
-    [ "$(echo $(stg unapplied))" = "p1 p2" ] &&
+    [ "$(echo $(stg series --applied --noprefix))" = "p0" ] &&
+    [ "$(echo $(stg series --unapplied --noprefix))" = "p1 p2" ] &&
     [ "$(echo $(ls patch?.txt))" = "patch0.txt" ] &&
     [ "$(echo $(cat patch0.txt))" = "patch0 local" ]
 '
@@ -34,8 +34,8 @@ test_expect_success 'Reset and push patches again' '
 
 test_expect_success 'Pop a patch without local changes' '
     stg pop --keep &&
-    [ "$(echo $(stg applied))" = "p0 p1" ] &&
-    [ "$(echo $(stg unapplied))" = "p2" ] &&
+    [ "$(echo $(stg series --applied --noprefix))" = "p0 p1" ] &&
+    [ "$(echo $(stg series --unapplied --noprefix))" = "p2" ] &&
     [ "$(echo $(ls patch?.txt))" = "patch0.txt patch1.txt" ]
 '
 
diff --git a/t/t1205-push-subdir.sh b/t/t1205-push-subdir.sh
index 175d36d..27d93da 100755
--- a/t/t1205-push-subdir.sh
+++ b/t/t1205-push-subdir.sh
@@ -12,8 +12,8 @@ test_expect_success 'Create some patches' '
         git add x.txt foo/y.txt &&
         stg refresh
     done &&
-    [ "$(echo $(stg applied))" = "p0 p1 p2" ] &&
-    [ "$(echo $(stg unapplied))" = "" ]
+    [ "$(echo $(stg series --applied --noprefix))" = "p0 p1 p2" ] &&
+    [ "$(echo $(stg series --unapplied --noprefix))" = "" ]
 '
 
 test_expect_success 'Fast-forward push from a subdir' '
diff --git a/t/t1301-repair.sh b/t/t1301-repair.sh
index b555b93..bf4382e 100755
--- a/t/t1301-repair.sh
+++ b/t/t1301-repair.sh
@@ -37,9 +37,9 @@ test_expect_success \
     '
 
 test_expect_success 'Turn one GIT commit into a patch' '
-    [ $(stg applied | wc -l) -eq 1 ] &&
+    [ $(stg series --applied -c) -eq 1 ] &&
     stg repair &&
-    [ $(stg applied | wc -l) -eq 2 ]
+    [ $(stg series --applied -c) -eq 2 ]
     '
 
 test_expect_success \
@@ -55,9 +55,9 @@ test_expect_success \
     '
 
 test_expect_success 'Turn three GIT commits into patches' '
-    [ $(stg applied | wc -l) -eq 2 ] &&
+    [ $(stg series --applied -c) -eq 2 ] &&
     stg repair &&
-    [ $(stg applied | wc -l) -eq 5 ]
+    [ $(stg series --applied -c) -eq 5 ]
     '
 
 test_expect_success \
@@ -72,9 +72,9 @@ test_expect_success \
     '
 
 test_expect_success 'Repair in the presence of a merge commit' '
-    [ $(stg applied | wc -l) -eq 5 ] &&
+    [ $(stg series --applied -c) -eq 5 ] &&
     stg repair &&
-    [ $(stg applied | wc -l) -eq 0 ]
+    [ $(stg series --applied -c) -eq 0 ]
 '
 
 test_done
diff --git a/t/t1302-repair-interop.sh b/t/t1302-repair-interop.sh
index 82c5ed2..5762111 100755
--- a/t/t1302-repair-interop.sh
+++ b/t/t1302-repair-interop.sh
@@ -21,8 +21,8 @@ test_expect_success 'Create five patches' '
     for i in 0 1 2 3 4; do
         stg new p$i -m p$i;
     done &&
-    [ "$(echo $(stg applied))" = "p0 p1 p2 p3 p4" ] &&
-    [ "$(echo $(stg unapplied))" = "" ]
+    [ "$(echo $(stg series --applied --noprefix))" = "p0 p1 p2 p3 p4" ] &&
+    [ "$(echo $(stg series --unapplied --noprefix))" = "" ]
 '
 
 test_expect_success 'Pop two patches with git-reset' '
@@ -30,14 +30,14 @@ test_expect_success 'Pop two patches with git-reset' '
     ! stg refresh &&
     stg repair &&
     stg refresh &&
-    [ "$(echo $(stg applied))" = "p0 p1 p2" ] &&
-    [ "$(echo $(stg unapplied))" = "p3 p4" ]
+    [ "$(echo $(stg series --applied --noprefix))" = "p0 p1 p2" ] &&
+    [ "$(echo $(stg series --unapplied --noprefix))" = "p3 p4" ]
 '
 
 test_expect_success 'Create a new patch' '
     stg new q0 -m q0 &&
-    [ "$(echo $(stg applied))" = "p0 p1 p2 q0" ] &&
-    [ "$(echo $(stg unapplied))" = "p3 p4" ]
+    [ "$(echo $(stg series --applied --noprefix))" = "p0 p1 p2 q0" ] &&
+    [ "$(echo $(stg series --unapplied --noprefix))" = "p3 p4" ]
 '
 
 test_expect_success 'Go to an unapplied patch with with git-reset' '
@@ -45,15 +45,15 @@ test_expect_success 'Go to an unapplied patch with with git-reset' '
     ! stg refresh &&
     stg repair &&
     stg refresh &&
-    [ "$(echo $(stg applied))" = "p0 p1 p2 p3" ] &&
-    [ "$(echo $(stg unapplied))" = "q0 p4" ]
+    [ "$(echo $(stg series --applied --noprefix))" = "p0 p1 p2 p3" ] &&
+    [ "$(echo $(stg series --unapplied --noprefix))" = "q0 p4" ]
 '
 
 test_expect_success 'Go back to below the stack base with git-reset' '
     git reset --hard foo-tag &&
     stg repair &&
-    [ "$(echo $(stg applied))" = "" ] &&
-    [ "$(echo $(stg unapplied))" = "p0 p1 p2 p3 q0 p4" ]
+    [ "$(echo $(stg series --applied --noprefix))" = "" ] &&
+    [ "$(echo $(stg series --unapplied --noprefix))" = "p0 p1 p2 p3 q0 p4" ]
 '
 
 test_done
diff --git a/t/t1500-float.sh b/t/t1500-float.sh
index 778fde4..e44af3a 100755
--- a/t/t1500-float.sh
+++ b/t/t1500-float.sh
@@ -20,37 +20,37 @@ test_expect_success \
 	 stg new F -m "f" && echo F >f.txt && git add f.txt && stg refresh &&
 	 stg new G -m "g" && echo G >g.txt && git add g.txt && stg refresh &&
 	 stg pop &&
-	 test "$(echo $(stg applied))" = "A B C D E F"
+	 test "$(echo $(stg series --applied --noprefix))" = "A B C D E F"
 	'
 
 test_expect_success \
 	'Float A to top' \
 	'stg float A &&
-	 test "$(echo $(stg applied))" = "B C D E F A"
+	 test "$(echo $(stg series --applied --noprefix))" = "B C D E F A"
 	'
 test_expect_success \
 	'Float A to top (noop)' \
 	'stg float A &&
-	 test "$(echo $(stg applied))" = "B C D E F A"
+	 test "$(echo $(stg series --applied --noprefix))" = "B C D E F A"
 	'
 test_expect_success \
 	'Float B C to top' \
 	'stg float B C &&
-	 test "$(echo $(stg applied))" = "D E F A B C"
+	 test "$(echo $(stg series --applied --noprefix))" = "D E F A B C"
 	'
 test_expect_success \
 	'Float E A to top' \
 	'stg float E A &&
-	 test "$(echo $(stg applied))" = "D F B C E A"
+	 test "$(echo $(stg series --applied --noprefix))" = "D F B C E A"
 	'
 test_expect_success \
 	'Float E to top' \
 	'stg float E &&
-	 test "$(echo $(stg applied))" = "D F B C A E"
+	 test "$(echo $(stg series --applied --noprefix))" = "D F B C A E"
 	'
 test_expect_success \
 	'Float G F to top' \
 	'stg float G F &&
-	 test "$(echo $(stg applied))" = "D B C A E G F"
+	 test "$(echo $(stg series --applied --noprefix))" = "D B C A E G F"
 	'
 test_done
diff --git a/t/t1600-delete-one.sh b/t/t1600-delete-one.sh
index c3451d8..51e4d5b 100755
--- a/t/t1600-delete-one.sh
+++ b/t/t1600-delete-one.sh
@@ -19,27 +19,27 @@ test_expect_success \
 test_expect_success \
     'Try to delete a non-existing patch' \
     '
-    [ $(stg applied | wc -l) -eq 1 ] &&
+    [ $(stg series --applied -c) -eq 1 ] &&
     ! stg delete bar &&
-    [ $(stg applied | wc -l) -eq 1 ]
+    [ $(stg series --applied -c) -eq 1 ]
     '
 
 test_expect_success \
     'Try to delete the topmost patch while dirty' \
     '
     echo dirty >> foo.txt &&
-    [ $(stg applied | wc -l) -eq 1 ] &&
+    [ $(stg series --applied -c) -eq 1 ] &&
     ! stg delete foo &&
-    [ $(stg applied | wc -l) -eq 1 ] &&
+    [ $(stg series --applied -c) -eq 1 ] &&
     git reset --hard
     '
 
 test_expect_success \
     'Delete the topmost patch' \
     '
-    [ $(stg applied | wc -l) -eq 1 ] &&
+    [ $(stg series --applied -c) -eq 1 ] &&
     stg delete foo &&
-    [ $(stg applied | wc -l) -eq 0 ]
+    [ $(stg series --applied -c) -eq 0 ]
     '
 
 test_expect_success \
@@ -55,9 +55,9 @@ test_expect_success \
 test_expect_success \
     'Delete an unapplied patch' \
     '
-    [ $(stg unapplied | wc -l) -eq 1 ] &&
+    [ $(stg series --unapplied -c) -eq 1 ] &&
     stg delete foo &&
-    [ $(stg unapplied | wc -l) -eq 0 ]
+    [ $(stg series --unapplied -c) -eq 0 ]
     '
 
 test_expect_success \
@@ -76,9 +76,9 @@ test_expect_success \
 test_expect_success \
     'Try to delete a non-topmost applied patch' \
     '
-    [ $(stg applied | wc -l) -eq 2 ] &&
+    [ $(stg series --applied -c) -eq 2 ] &&
     stg delete foo &&
-    [ $(stg applied | wc -l) -eq 1 ]
+    [ $(stg series --applied -c) -eq 1 ]
     '
 
 test_expect_success \
@@ -99,11 +99,11 @@ test_expect_success \
 test_expect_success \
     'Delete a patch in another branch' \
     '
-    [ $(stg applied | wc -l) -eq 2 ] &&
-    [ $(stg applied -b br | wc -l) -eq 1 ] &&
+    [ $(stg series --applied -c) -eq 2 ] &&
+    [ $(stg series --applied -b br -c) -eq 1 ] &&
     stg delete -b br baz &&
-    [ $(stg applied | wc -l) -eq 2 ] &&
-    [ $(stg applied -b br | wc -l) -eq 0 ]
+    [ $(stg series --applied -c) -eq 2 ] &&
+    [ $(stg series --applied -b br -c) -eq 0 ]
     '
 
 test_done
diff --git a/t/t1601-delete-many.sh b/t/t1601-delete-many.sh
index 30b0a1d..a254980 100755
--- a/t/t1601-delete-many.sh
+++ b/t/t1601-delete-many.sh
@@ -25,31 +25,31 @@ test_expect_success \
 test_expect_success \
     'Delete some patches' \
     '
-    [ "$(echo $(stg applied))" = "p0 p1 p2 p3 p4" ] &&
-    [ "$(echo $(stg unapplied))" = "p5 p6 p7 p8 p9" ] &&
+    [ "$(echo $(stg series --applied --noprefix))" = "p0 p1 p2 p3 p4" ] &&
+    [ "$(echo $(stg series --unapplied --noprefix))" = "p5 p6 p7 p8 p9" ] &&
     stg delete p7 p6 p3 p4 &&
-    [ "$(echo $(stg applied))" = "p0 p1 p2" ] &&
-    [ "$(echo $(stg unapplied))" = "p5 p8 p9" ]
+    [ "$(echo $(stg series --applied --noprefix))" = "p0 p1 p2" ] &&
+    [ "$(echo $(stg series --unapplied --noprefix))" = "p5 p8 p9" ]
     '
 
 test_expect_success \
     'Delete some more patches, some of which do not exist' \
     '
-    [ "$(echo $(stg applied))" = "p0 p1 p2" ] &&
-    [ "$(echo $(stg unapplied))" = "p5 p8 p9" ] &&
+    [ "$(echo $(stg series --applied --noprefix))" = "p0 p1 p2" ] &&
+    [ "$(echo $(stg series --unapplied --noprefix))" = "p5 p8 p9" ] &&
     ! stg delete p7 p8 p2 p0 &&
-    [ "$(echo $(stg applied))" = "p0 p1 p2" ] &&
-    [ "$(echo $(stg unapplied))" = "p5 p8 p9" ]
+    [ "$(echo $(stg series --applied --noprefix))" = "p0 p1 p2" ] &&
+    [ "$(echo $(stg series --unapplied --noprefix))" = "p5 p8 p9" ]
     '
 
 test_expect_success \
     'Delete a range of patches' \
     '
-    [ "$(echo $(stg applied))" = "p0 p1 p2" ] &&
-    [ "$(echo $(stg unapplied))" = "p5 p8 p9" ] &&
+    [ "$(echo $(stg series --applied --noprefix))" = "p0 p1 p2" ] &&
+    [ "$(echo $(stg series --unapplied --noprefix))" = "p5 p8 p9" ] &&
     stg delete p1..p8 &&
-    [ "$(echo $(stg applied))" = "p0" ] &&
-    [ "$(echo $(stg unapplied))" = "p9" ]
+    [ "$(echo $(stg series --applied --noprefix))" = "p0" ] &&
+    [ "$(echo $(stg series --unapplied --noprefix))" = "p9" ]
     '
 
 test_done
diff --git a/t/t2000-sync.sh b/t/t2000-sync.sh
index 4a00c56..2049c28 100755
--- a/t/t2000-sync.sh
+++ b/t/t2000-sync.sh
@@ -30,8 +30,8 @@ test_expect_success \
     stg refresh &&
     stg export &&
     stg pop &&
-    [ "$(echo $(stg applied))" = "p1 p2" ] &&
-    [ "$(echo $(stg unapplied))" = "p3" ]
+    [ "$(echo $(stg series --applied --noprefix))" = "p1 p2" ] &&
+    [ "$(echo $(stg series --unapplied --noprefix))" = "p3" ]
     '
 
 test_expect_success \
@@ -41,16 +41,16 @@ test_expect_success \
     stg new p1 -m p1 &&
     stg new p2 -m p2 &&
     stg new p3 -m p3 &&
-    [ "$(echo $(stg applied))" = "p1 p2 p3" ] &&
-    [ "$(echo $(stg unapplied))" = "" ]
+    [ "$(echo $(stg series --applied --noprefix))" = "p1 p2 p3" ] &&
+    [ "$(echo $(stg series --unapplied --noprefix))" = "" ]
     '
 
 test_expect_success \
     'Synchronise second patch with the master branch' \
     '
     stg sync -B master p2 &&
-    [ "$(echo $(stg applied))" = "p1 p2 p3" ] &&
-    [ "$(echo $(stg unapplied))" = "" ] &&
+    [ "$(echo $(stg series --applied --noprefix))" = "p1 p2 p3" ] &&
+    [ "$(echo $(stg series --unapplied --noprefix))" = "" ] &&
     test $(cat foo2.txt) = "foo2"
     '
 
@@ -58,8 +58,8 @@ test_expect_success \
     'Synchronise the first two patches with the master branch' \
     '
     stg sync -B master -a &&
-    [ "$(echo $(stg applied))" = "p1 p2 p3" ] &&
-    [ "$(echo $(stg unapplied))" = "" ] &&
+    [ "$(echo $(stg series --applied --noprefix))" = "p1 p2 p3" ] &&
+    [ "$(echo $(stg series --unapplied --noprefix))" = "" ] &&
     test $(cat foo1.txt) = "foo1" &&
     test $(cat foo2.txt) = "foo2"
     '
@@ -68,8 +68,8 @@ test_expect_success \
     'Synchronise all the patches with the exported series' \
     '
     stg sync -s patches-master/series -a &&
-    [ "$(echo $(stg applied))" = "p1 p2 p3" ] &&
-    [ "$(echo $(stg unapplied))" = "" ] &&
+    [ "$(echo $(stg series --applied --noprefix))" = "p1 p2 p3" ] &&
+    [ "$(echo $(stg series --unapplied --noprefix))" = "" ] &&
     test $(cat foo1.txt) = "foo1" &&
     test $(cat foo2.txt) = "foo2" &&
     test $(cat foo3.txt) = "foo3"
@@ -79,8 +79,8 @@ test_expect_success \
     'Modify the master patches' \
     '
     stg branch master &&
-    [ "$(echo $(stg applied))" = "p1 p2" ] &&
-    [ "$(echo $(stg unapplied))" = "p3" ] &&
+    [ "$(echo $(stg series --applied --noprefix))" = "p1 p2" ] &&
+    [ "$(echo $(stg series --unapplied --noprefix))" = "p3" ] &&
     stg goto p1 &&
     echo bar1 >> foo1.txt &&
     stg refresh &&
@@ -91,8 +91,8 @@ test_expect_success \
     stg goto p3 &&
     echo bar3 >> foo3.txt &&
     stg refresh &&
-    [ "$(echo $(stg applied))" = "p1 p2 p3" ] &&
-    [ "$(echo $(stg unapplied))" = "" ] &&
+    [ "$(echo $(stg series --applied --noprefix))" = "p1 p2 p3" ] &&
+    [ "$(echo $(stg series --unapplied --noprefix))" = "" ] &&
     stg export &&
     stg branch foo
     '
@@ -101,8 +101,8 @@ test_expect_success \
     'Synchronise second patch with the master branch' \
     '
     stg sync -B master p2 &&
-    [ "$(echo $(stg applied))" = "p1 p2 p3" ] &&
-    [ "$(echo $(stg unapplied))" = "" ] &&
+    [ "$(echo $(stg series --applied --noprefix))" = "p1 p2 p3" ] &&
+    [ "$(echo $(stg series --unapplied --noprefix))" = "" ] &&
     test $(cat bar2.txt) = "bar2"
     '
 
@@ -115,13 +115,13 @@ test_expect_success \
 test_expect_success \
     'Restore the stack status after the failed sync' \
     '
-    [ "$(echo $(stg applied))" = "p1" ] &&
-    [ "$(echo $(stg unapplied))" = "p2 p3" ] &&
+    [ "$(echo $(stg series --applied --noprefix))" = "p1" ] &&
+    [ "$(echo $(stg series --unapplied --noprefix))" = "p2 p3" ] &&
     stg resolved -a &&
     stg refresh &&
     stg goto p3
-    [ "$(echo $(stg applied))" = "p1 p2 p3" ] &&
-    [ "$(echo $(stg unapplied))" = "" ]
+    [ "$(echo $(stg series --applied --noprefix))" = "p1 p2 p3" ] &&
+    [ "$(echo $(stg series --unapplied --noprefix))" = "" ]
     '
 
 test_expect_success \
@@ -133,12 +133,12 @@ test_expect_success \
 test_expect_success \
     'Restore the stack status after the failed sync' \
     '
-    [ "$(echo $(stg applied))" = "p1 p2 p3" ] &&
-    [ "$(echo $(stg unapplied))" = "" ] &&
+    [ "$(echo $(stg series --applied --noprefix))" = "p1 p2 p3" ] &&
+    [ "$(echo $(stg series --unapplied --noprefix))" = "" ] &&
     stg resolved -a &&
     stg refresh &&
-    [ "$(echo $(stg applied))" = "p1 p2 p3" ] &&
-    [ "$(echo $(stg unapplied))" = "" ]
+    [ "$(echo $(stg series --applied --noprefix))" = "p1 p2 p3" ] &&
+    [ "$(echo $(stg series --unapplied --noprefix))" = "" ]
     '
 
 test_done
diff --git a/t/t2200-rebase.sh b/t/t2200-rebase.sh
index cd43c41..12b4af6 100755
--- a/t/t2200-rebase.sh
+++ b/t/t2200-rebase.sh
@@ -28,7 +28,7 @@ test_expect_success \
 	'
 	stg rebase master~1 &&
 	test `stg id stack:{base}` = `git rev-parse master~1` &&
-	test `stg applied | wc -l` = 1
+	test `stg series --applied -c` = 1
 	'
 
 test_expect_success \
@@ -40,7 +40,7 @@ test_expect_success \
 test_expect_success \
 	'Check patches were re-applied' \
 	'
-	test $(stg applied | wc -l) = 1
+	test $(stg series --applied -c) = 1
 	'
 
 test_done
diff --git a/t/t2500-clean.sh b/t/t2500-clean.sh
index ad8f892..063572b 100755
--- a/t/t2500-clean.sh
+++ b/t/t2500-clean.sh
@@ -17,11 +17,11 @@ test_expect_success 'Initialize StGit stack' '
 '
 
 test_expect_success 'Clean empty patches' '
-    [ "$(echo $(stg applied))" = "e0 p0 e1" ] &&
-    [ "$(echo $(stg unapplied))" = "e2" ] &&
+    [ "$(echo $(stg series --applied --noprefix))" = "e0 p0 e1" ] &&
+    [ "$(echo $(stg series --unapplied --noprefix))" = "e2" ] &&
     stg clean &&
-    [ "$(echo $(stg applied))" = "p0" ] &&
-    [ "$(echo $(stg unapplied))" = "" ]
+    [ "$(echo $(stg series --applied --noprefix))" = "p0" ] &&
+    [ "$(echo $(stg series --unapplied --noprefix))" = "" ]
 '
 
 test_expect_success 'Create a conflict' '
@@ -37,8 +37,8 @@ test_expect_success 'Create a conflict' '
 
 test_expect_success 'Make sure conflicting patches are preserved' '
     stg clean &&
-    [ "$(echo $(stg applied))" = "p0 p2 p1" ] &&
-    [ "$(echo $(stg unapplied))" = "" ]
+    [ "$(echo $(stg series --applied --noprefix))" = "p0 p2 p1" ] &&
+    [ "$(echo $(stg series --unapplied --noprefix))" = "" ]
 '
 
 test_done
diff --git a/t/t2600-coalesce.sh b/t/t2600-coalesce.sh
index f13a309..ef5bf99 100755
--- a/t/t2600-coalesce.sh
+++ b/t/t2600-coalesce.sh
@@ -15,17 +15,17 @@ test_expect_success 'Initialize StGit stack' '
 '
 
 test_expect_success 'Coalesce some patches' '
-    [ "$(echo $(stg applied))" = "p0 p1 p2 p3" ] &&
-    [ "$(echo $(stg unapplied))" = "" ] &&
+    [ "$(echo $(stg series --applied --noprefix))" = "p0 p1 p2 p3" ] &&
+    [ "$(echo $(stg series --unapplied --noprefix))" = "" ] &&
     stg coalesce --name=q0 --message="wee woo" p1 p2 &&
-    [ "$(echo $(stg applied))" = "p0 q0 p3" ] &&
-    [ "$(echo $(stg unapplied))" = "" ]
+    [ "$(echo $(stg series --applied --noprefix))" = "p0 q0 p3" ] &&
+    [ "$(echo $(stg series --unapplied --noprefix))" = "" ]
 '
 
 test_expect_success 'Coalesce at stack top' '
     stg coalesce --name=q1 --message="wee woo wham" q0 p3 &&
-    [ "$(echo $(stg applied))" = "p0 q1" ] &&
-    [ "$(echo $(stg unapplied))" = "" ]
+    [ "$(echo $(stg series --applied --noprefix))" = "p0 q1" ] &&
+    [ "$(echo $(stg series --unapplied --noprefix))" = "" ]
 '
 
 test_done
diff --git a/t/t3000-dirty-merge.sh b/t/t3000-dirty-merge.sh
index d87bba1..a4e228a 100755
--- a/t/t3000-dirty-merge.sh
+++ b/t/t3000-dirty-merge.sh
@@ -24,11 +24,11 @@ test_expect_success 'Pop one patch and update the other' '
 
 test_expect_success 'Push with dirty worktree' '
     echo 4 > a &&
-    [ "$(echo $(stg applied))" = "p1" ] &&
-    [ "$(echo $(stg unapplied))" = "p2" ] &&
+    [ "$(echo $(stg series --applied --noprefix))" = "p1" ] &&
+    [ "$(echo $(stg series --unapplied --noprefix))" = "p2" ] &&
     ! stg goto p2 &&
-    [ "$(echo $(stg applied))" = "p1" ] &&
-    [ "$(echo $(stg unapplied))" = "p2" ] &&
+    [ "$(echo $(stg series --applied --noprefix))" = "p1" ] &&
+    [ "$(echo $(stg series --unapplied --noprefix))" = "p2" ] &&
     [ "$(echo $(cat a))" = "4" ]
 '
 
diff --git a/t/t4000-upgrade.sh b/t/t4000-upgrade.sh
index 8a308fb..01fe248 100755
--- a/t/t4000-upgrade.sh
+++ b/t/t4000-upgrade.sh
@@ -14,8 +14,8 @@ for ver in 0.12 0.8; do
 
     test_expect_success \
         "v$ver: Check the list of applied and unapplied patches" '
-        [ "$(echo $(stg applied))" = "p0 p1 p2" ] &&
-        [ "$(echo $(stg unapplied))" = "p3 p4" ]
+        [ "$(echo $(stg series --applied --noprefix))" = "p0 p1 p2" ] &&
+        [ "$(echo $(stg series --unapplied --noprefix))" = "p3 p4" ]
     '
 
     test_expect_success \
