From: Catalin Marinas <catalin.marinas@arm.com>
Subject: [StGit PATCH] Check for local changes with "goto"
Date: Tue, 10 Feb 2009 14:11:51 +0000
Message-ID: <20090210141039.28782.50452.stgit@pc1117.cambridge.arm.com>
Reply-To: Catalin Marinas <catalin.marinas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org,
	Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Tue Feb 10 15:13:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LWtMi-0003dl-J7
	for gcvg-git-2@gmane.org; Tue, 10 Feb 2009 15:13:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754724AbZBJOMG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Feb 2009 09:12:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754718AbZBJOMF
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Feb 2009 09:12:05 -0500
Received: from cam-admin0.cambridge.arm.com ([193.131.176.58]:47200 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754722AbZBJOMC (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Feb 2009 09:12:02 -0500
Received: from cam-owa2.Emea.Arm.com (cam-owa2.emea.arm.com [10.1.105.18])
	by cam-admin0.cambridge.arm.com (8.12.6/8.12.6) with ESMTP id n1AEAGZm016769;
	Tue, 10 Feb 2009 14:10:16 GMT
Received: from pc1117.cambridge.arm.com ([10.1.255.212]) by cam-owa2.Emea.Arm.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 10 Feb 2009 14:11:56 +0000
User-Agent: StGit/0.14.3.346.g5c97
X-OriginalArrivalTime: 10 Feb 2009 14:11:56.0710 (UTC) FILETIME=[881C3460:01C98B89]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109241>

This is done by default, unless the --keep option is passed, for
consistency with the "pop" command. The index is checked in the
Transaction.run() function so that other commands could benefit from
this feature (off by default).

Signed-off-by: Catalin Marinas <catalin.marinas@gmail.com>
---

This is hopefully the final variant of what was discussed in a previous
thread. The next step is to have the --keep behaviour configurable via
.gitconfig.

 stgit/commands/goto.py    |   13 +++++++++++--
 stgit/lib/git.py          |   14 ++++++++++++--
 stgit/lib/transaction.py  |   10 +++++++++-
 t/t2300-refresh-subdir.sh |    2 +-
 t/t2800-goto-subdir.sh    |    4 ++--
 t/t3000-dirty-merge.sh    |    2 +-
 6 files changed, 36 insertions(+), 9 deletions(-)

diff --git a/stgit/commands/goto.py b/stgit/commands/goto.py
index 60a917e..4f6274f 100644
--- a/stgit/commands/goto.py
+++ b/stgit/commands/goto.py
@@ -18,6 +18,7 @@ Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
 from stgit.commands import common
 from stgit.lib import transaction
 from stgit import argparse
+from stgit.argparse import opt
 
 help = 'Push or pop patches to the given one'
 kind = 'stack'
@@ -27,7 +28,10 @@ Push/pop patches to/from the stack until the one given on the command
 line becomes current."""
 
 args = [argparse.other_applied_patches, argparse.unapplied_patches]
-options = []
+options = [
+    opt('-k', '--keep', action = 'store_true',
+        short = 'Keep the local changes')
+]
 
 directory = common.DirectoryHasRepositoryLib()
 
@@ -38,7 +42,12 @@ def func(parser, options, args):
 
     stack = directory.repository.current_stack
     iw = stack.repository.default_iw
-    trans = transaction.StackTransaction(stack, 'goto')
+    if not options.keep:
+        check_clean_iw = iw
+    else:
+        check_clean_iw = None
+    trans = transaction.StackTransaction(stack, 'goto',
+                                         check_clean_iw = check_clean_iw)
     if patch in trans.applied:
         to_pop = set(trans.applied[trans.applied.index(patch)+1:])
         assert not trans.pop_patches(lambda pn: pn in to_pop)
diff --git a/stgit/lib/git.py b/stgit/lib/git.py
index e2b4266..07079b8 100644
--- a/stgit/lib/git.py
+++ b/stgit/lib/git.py
@@ -706,9 +706,11 @@ class Index(RunWithEnv):
                     ).output_one_line())
         except run.RunException:
             raise MergeException('Conflicting merge')
-    def is_clean(self):
+    def is_clean(self, tree):
+        """Check whether the index is clean relative to the given treeish."""
         try:
-            self.run(['git', 'update-index', '--refresh']).discard_output()
+            self.run(['git', 'diff-index', '--quiet', '--cached', tree.sha1]
+                    ).discard_output()
         except run.RunException:
             return False
         else:
@@ -858,6 +860,14 @@ class IndexAndWorktree(RunWithEnvCwd):
         cmd = ['git', 'update-index', '--remove']
         self.run(cmd + ['-z', '--stdin']
                  ).input_nulterm(paths).discard_output()
+    def worktree_clean(self):
+        """Check whether the worktree is clean relative to index."""
+        try:
+            self.run(['git', 'update-index', '--refresh']).discard_output()
+        except run.RunException:
+            return False
+        else:
+            return True
 
 class Branch(object):
     """Represents a Git branch."""
diff --git a/stgit/lib/transaction.py b/stgit/lib/transaction.py
index 54de127..5a81f9d 100644
--- a/stgit/lib/transaction.py
+++ b/stgit/lib/transaction.py
@@ -75,7 +75,8 @@ class StackTransaction(object):
       your refs and index+worktree, or fail without having done
       anything."""
     def __init__(self, stack, msg, discard_changes = False,
-                 allow_conflicts = False, allow_bad_head = False):
+                 allow_conflicts = False, allow_bad_head = False,
+                 check_clean_iw = None):
         """Create a new L{StackTransaction}.
 
         @param discard_changes: Discard any changes in index+worktree
@@ -102,6 +103,8 @@ class StackTransaction(object):
         self.__temp_index = self.temp_index_tree = None
         if not allow_bad_head:
             self.__assert_head_top_equal()
+        if check_clean_iw:
+            self.__assert_index_worktree_clean(check_clean_iw)
     stack = property(lambda self: self.__stack)
     patches = property(lambda self: self.__patches)
     def __set_applied(self, val):
@@ -147,6 +150,11 @@ class StackTransaction(object):
                 'This can happen if you modify a branch with git.',
                 '"stg repair --help" explains more about what to do next.')
             self.__abort()
+    def __assert_index_worktree_clean(self, iw):
+        if not iw.worktree_clean() or \
+           not iw.index.is_clean(self.stack.head):
+            self.__halt('Repository not clean. Use "refresh" or '
+                        '"status --reset"')
     def __checkout(self, tree, iw, allow_bad_head):
         if not allow_bad_head:
             self.__assert_head_top_equal()
diff --git a/t/t2300-refresh-subdir.sh b/t/t2300-refresh-subdir.sh
index d731a11..89c95db 100755
--- a/t/t2300-refresh-subdir.sh
+++ b/t/t2300-refresh-subdir.sh
@@ -65,7 +65,7 @@ test_expect_success 'refresh -u -p <subdir>' '
 
 test_expect_success 'refresh an unapplied patch' '
     stg refresh -u &&
-    stg goto p0 &&
+    stg goto --keep p0 &&
     test "$(stg status)" = "M foo.txt" &&
     stg refresh -p p1 &&
     test "$(stg status)" = "" &&
diff --git a/t/t2800-goto-subdir.sh b/t/t2800-goto-subdir.sh
index 28b8292..855972b 100755
--- a/t/t2800-goto-subdir.sh
+++ b/t/t2800-goto-subdir.sh
@@ -25,7 +25,7 @@ cat > expected2.txt <<EOF
 bar
 EOF
 test_expect_success 'Goto in subdirectory (just pop)' '
-    (cd foo && stg goto p1) &&
+    (cd foo && stg goto --keep p1) &&
     cat foo/bar > actual.txt &&
     test_cmp expected1.txt actual.txt &&
     ls foo > actual.txt &&
@@ -48,7 +48,7 @@ cat > expected2.txt <<EOF
 bar
 EOF
 test_expect_success 'Goto in subdirectory (conflicting push)' '
-    (cd foo && stg goto p3) ;
+    (cd foo && stg goto --keep p3) ;
     [ $? -eq 3 ] &&
     cat foo/bar > actual.txt &&
     test_cmp expected1.txt actual.txt &&
diff --git a/t/t3000-dirty-merge.sh b/t/t3000-dirty-merge.sh
index f0f79d5..419d86e 100755
--- a/t/t3000-dirty-merge.sh
+++ b/t/t3000-dirty-merge.sh
@@ -26,7 +26,7 @@ test_expect_success 'Push with dirty worktree' '
     echo 4 > a &&
     [ "$(echo $(stg series --applied --noprefix))" = "p1" ] &&
     [ "$(echo $(stg series --unapplied --noprefix))" = "p2" ] &&
-    conflict stg goto p2 &&
+    conflict stg goto --keep p2 &&
     [ "$(echo $(stg series --applied --noprefix))" = "p1" ] &&
     [ "$(echo $(stg series --unapplied --noprefix))" = "p2" ] &&
     [ "$(echo $(cat a))" = "4" ]
