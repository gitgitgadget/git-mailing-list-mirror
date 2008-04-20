From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH 09/10] Add a --hard flag to stg reset
Date: Mon, 21 Apr 2008 00:11:13 +0200
Message-ID: <20080420221112.5837.73514.stgit@yoghurt>
References: <20080420215625.5837.82896.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 21 00:12:16 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jnhla-000853-7q
	for gcvg-git-2@gmane.org; Mon, 21 Apr 2008 00:12:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752627AbYDTWLS convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 20 Apr 2008 18:11:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752551AbYDTWLR
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Apr 2008 18:11:17 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3203 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752566AbYDTWLP (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Apr 2008 18:11:15 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1Jnhkc-00083T-00; Sun, 20 Apr 2008 23:11:11 +0100
In-Reply-To: <20080420215625.5837.82896.stgit@yoghurt>
User-Agent: StGIT/0.14.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79998>

With this flag, reset will overwrite any local changes. Useful e.g.
when undoing a push that's polluted the index+worktree with a heap of
conflicts.

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

 stgit/commands/reset.py  |   14 +++++++-----
 stgit/lib/git.py         |    4 +++
 stgit/lib/transaction.py |   11 +++++++--
 t/t3101-reset-hard.sh    |   56 ++++++++++++++++++++++++++++++++++++++=
++++++++
 4 files changed, 77 insertions(+), 8 deletions(-)
 create mode 100755 t/t3101-reset-hard.sh


diff --git a/stgit/commands/reset.py b/stgit/commands/reset.py
index e27f440..00226f0 100644
--- a/stgit/commands/reset.py
+++ b/stgit/commands/reset.py
@@ -17,12 +17,13 @@ along with this program; if not, write to the Free =
Software
 Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 US=
A
 """
=20
+from optparse import make_option
 from stgit.commands import common
 from stgit.lib import git, log, transaction
 from stgit.out import out
=20
 help =3D 'reset the patch stack to an earlier state'
-usage =3D """%prog <state> [<patchnames>]
+usage =3D """%prog [options] <state> [<patchnames>]
=20
 Reset the patch stack to an earlier state. The state is specified with
 a commit from a stack log; for a branch foo, StGit stores the stack
@@ -41,9 +42,10 @@ If one or more patch names are given, reset only tho=
se patches, and
 leave the rest alone."""
=20
 directory =3D common.DirectoryHasRepositoryLib()
-options =3D []
+options =3D [make_option('--hard', action =3D 'store_true',
+                       help =3D 'discard changes in your index/worktre=
e')]
=20
-def reset_stack(stack, iw, state, only_patches):
+def reset_stack(stack, iw, state, only_patches, hard):
     only_patches =3D set(only_patches)
     def mask(s):
         if only_patches:
@@ -53,7 +55,8 @@ def reset_stack(stack, iw, state, only_patches):
     patches_to_reset =3D mask(set(state.applied + state.unapplied))
     existing_patches =3D set(stack.patchorder.all)
     to_delete =3D mask(existing_patches - patches_to_reset)
-    trans =3D transaction.StackTransaction(stack, 'stg reset')
+    trans =3D transaction.StackTransaction(stack, 'stg reset',
+                                         discard_changes =3D hard)
=20
     # If we have to change the stack base, we need to pop all patches
     # first.
@@ -111,4 +114,5 @@ def func(parser, options, args):
         state =3D log.Log(stack.repository, ref, stack.repository.rev_=
parse(ref))
     else:
         raise common.CmdException('Wrong number of arguments')
-    return reset_stack(stack, stack.repository.default_iw, state, patc=
hes)
+    return reset_stack(stack, stack.repository.default_iw, state, patc=
hes,
+                       options.hard)
diff --git a/stgit/lib/git.py b/stgit/lib/git.py
index 5bb1c93..c044b46 100644
--- a/stgit/lib/git.py
+++ b/stgit/lib/git.py
@@ -605,6 +605,10 @@ class IndexAndWorktree(RunWithEnvCwd):
     env =3D property(lambda self: utils.add_dict(self.__index.env,
                                                self.__worktree.env))
     cwd =3D property(lambda self: self.__worktree.directory)
+    def checkout_hard(self, tree):
+        assert isinstance(tree, Tree)
+        self.run(['git', 'read-tree', '--reset', '-u', tree.sha1]
+                 ).discard_output()
     def checkout(self, old_tree, new_tree):
         # TODO: Optionally do a 3-way instead of doing nothing when we
         # have a problem. Or maybe we should stash changes in a patch?
diff --git a/stgit/lib/transaction.py b/stgit/lib/transaction.py
index 92bcfd5..a008780 100644
--- a/stgit/lib/transaction.py
+++ b/stgit/lib/transaction.py
@@ -36,7 +36,8 @@ class _TransPatchMap(dict):
             return self.__stack.patches.get(pn).commit
=20
 class StackTransaction(object):
-    def __init__(self, stack, msg, allow_conflicts =3D False):
+    def __init__(self, stack, msg, discard_changes =3D False,
+                 allow_conflicts =3D False):
         self.__stack =3D stack
         self.__msg =3D msg
         self.__patches =3D _TransPatchMap(stack)
@@ -46,6 +47,7 @@ class StackTransaction(object):
         self.__error =3D None
         self.__current_tree =3D self.__stack.head.data.tree
         self.__base =3D self.__stack.base
+        self.__discard_changes =3D discard_changes
         if isinstance(allow_conflicts, bool):
             self.__allow_conflicts =3D lambda trans: allow_conflicts
         else:
@@ -70,7 +72,7 @@ class StackTransaction(object):
                 'This can happen if you modify a branch with git.',
                 '"stg repair --help" explains more about what to do ne=
xt.')
             self.__abort()
-        if self.__current_tree =3D=3D tree:
+        if self.__current_tree =3D=3D tree and not self.__discard_chan=
ges:
             # No tree change, but we still want to make sure that
             # there are no unresolved conflicts. Conflicts
             # conceptually "belong" to the topmost patch, and just
@@ -81,7 +83,10 @@ class StackTransaction(object):
             out.error('Need to resolve conflicts first')
             self.__abort()
         assert iw !=3D None
-        iw.checkout(self.__current_tree, tree)
+        if self.__discard_changes:
+            iw.checkout_hard(tree)
+        else:
+            iw.checkout(self.__current_tree, tree)
         self.__current_tree =3D tree
     @staticmethod
     def __abort():
diff --git a/t/t3101-reset-hard.sh b/t/t3101-reset-hard.sh
new file mode 100755
index 0000000..1e02805
--- /dev/null
+++ b/t/t3101-reset-hard.sh
@@ -0,0 +1,56 @@
+#!/bin/sh
+
+test_description=3D'Simple test cases for "stg reset"'
+
+. ./test-lib.sh
+
+# Ignore our own output files.
+cat > .git/info/exclude <<EOF
+/expected.txt
+/actual.txt
+EOF
+
+test_expect_success 'Initialize StGit stack with three patches' '
+    stg init &&
+    echo 000 >> a &&
+    git add a &&
+    git commit -m a &&
+    echo 111 >> a &&
+    git commit -a -m p1 &&
+    echo 222 >> a &&
+    git commit -a -m p2 &&
+    echo 333 >> a &&
+    git commit -a -m p3 &&
+    stg uncommit -n 3
+'
+
+cat > expected.txt <<EOF
+C a
+EOF
+test_expect_success 'Pop middle patch, creating a conflict' '
+    ! stg pop p2 &&
+    stg status a > actual.txt &&
+    test_cmp expected.txt actual.txt &&
+    test "$(echo $(stg applied))" =3D "p1 p3" &&
+    test "$(echo $(stg unapplied))" =3D "p2"
+'
+
+test_expect_success 'Try to reset without --hard' '
+    ! stg reset master.stgit^~1 &&
+    stg status a > actual.txt &&
+    test_cmp expected.txt actual.txt &&
+    test "$(echo $(stg applied))" =3D "p1 p3" &&
+    test "$(echo $(stg unapplied))" =3D "p2"
+'
+
+cat > expected.txt <<EOF
+EOF
+test_expect_success 'Try to reset with --hard' '
+    stg reset --hard master.stgit^~1 &&
+    stg status a > actual.txt &&
+    test_cmp expected.txt actual.txt &&
+    test "$(echo $(stg applied))" =3D "p1" &&
+    test "$(echo $(stg unapplied))" =3D "p3 p2"
+'
+
+test_done
