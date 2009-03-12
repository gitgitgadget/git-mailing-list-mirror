From: Catalin Marinas <catalin.marinas@arm.com>
Subject: [StGit PATCH 1/5] Check for local changes with "goto"
Date: Thu, 12 Mar 2009 12:08:56 +0000
Message-ID: <20090312120856.2992.48548.stgit@pc1117.cambridge.arm.com>
References: <20090312120426.2992.35213.stgit@pc1117.cambridge.arm.com>
Reply-To: Catalin Marinas <catalin.marinas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org,
	Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Thu Mar 12 13:11:24 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lhjkp-0003cT-2u
	for gcvg-git-2@gmane.org; Thu, 12 Mar 2009 13:11:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756673AbZCLMJ2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Mar 2009 08:09:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756667AbZCLMJ1
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Mar 2009 08:09:27 -0400
Received: from cam-admin0.cambridge.arm.com ([193.131.176.58]:49918 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756653AbZCLMJZ (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 Mar 2009 08:09:25 -0400
Received: from cam-owa2.Emea.Arm.com (cam-owa2.emea.arm.com [10.1.105.18])
	by cam-admin0.cambridge.arm.com (8.12.6/8.12.6) with ESMTP id n2CC7oZm017551;
	Thu, 12 Mar 2009 12:07:50 GMT
Received: from pc1117.cambridge.arm.com ([10.1.255.212]) by cam-owa2.Emea.Arm.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Thu, 12 Mar 2009 12:09:19 +0000
In-Reply-To: <20090312120426.2992.35213.stgit@pc1117.cambridge.arm.com>
User-Agent: StGit/0.14.3.348.gf982
X-OriginalArrivalTime: 12 Mar 2009 12:09:19.0724 (UTC) FILETIME=[5F65BAC0:01C9A30B]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113053>

This is done by default, unless the --keep option is passed, for
consistency with the "pop" command. The index is checked in the
Transaction.run() function so that other commands could benefit from
this feature (off by default).

This behaviour can be overridden by setting the stgit.autokeep option.

Signed-off-by: Catalin Marinas <catalin.marinas@gmail.com>
---
 examples/gitconfig        |    3 +++
 stgit/argparse.py         |    5 +++++
 stgit/commands/goto.py    |    7 +++++--
 stgit/lib/git.py          |   14 ++++++++++++--
 stgit/lib/transaction.py  |   10 +++++++++-
 t/t2300-refresh-subdir.sh |    2 +-
 t/t2800-goto-subdir.sh    |    4 ++--
 t/t3000-dirty-merge.sh    |    2 +-
 8 files changed, 38 insertions(+), 9 deletions(-)

diff --git a/examples/gitconfig b/examples/gitconfig
index 9efc089..2fc5f52 100644
--- a/examples/gitconfig
+++ b/examples/gitconfig
@@ -103,6 +103,9 @@
 	# -O/--diff-opts). For example, -M turns on rename detection.
 	#diff-opts = -M
 
+	# Behave as if the --keep option is always passed
+	#autokeep = no
+
 [mail "alias"]
 	# E-mail aliases used with the 'mail' command
 	git = git@vger.kernel.org
diff --git a/stgit/argparse.py b/stgit/argparse.py
index 418a506..85ee6e3 100644
--- a/stgit/argparse.py
+++ b/stgit/argparse.py
@@ -220,6 +220,11 @@ def _person_opts(person, short):
 def author_options():
     return _person_opts('author', 'auth')
 
+def keep_option():
+    return [opt('-k', '--keep', action = 'store_true',
+                short = 'Keep the local changes',
+                default = config.get('stgit.autokeep') == 'yes')]
+
 class CompgenBase(object):
     def actions(self, var): return set()
     def words(self, var): return set()
diff --git a/stgit/commands/goto.py b/stgit/commands/goto.py
index 60a917e..0f67314 100644
--- a/stgit/commands/goto.py
+++ b/stgit/commands/goto.py
@@ -18,6 +18,7 @@ Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 USA
 from stgit.commands import common
 from stgit.lib import transaction
 from stgit import argparse
+from stgit.argparse import opt
 
 help = 'Push or pop patches to the given one'
 kind = 'stack'
@@ -27,7 +28,7 @@ Push/pop patches to/from the stack until the one given on the command
 line becomes current."""
 
 args = [argparse.other_applied_patches, argparse.unapplied_patches]
-options = []
+options = argparse.keep_option()
 
 directory = common.DirectoryHasRepositoryLib()
 
@@ -38,7 +39,9 @@ def func(parser, options, args):
 
     stack = directory.repository.current_stack
     iw = stack.repository.default_iw
-    trans = transaction.StackTransaction(stack, 'goto')
+    clean_iw = not options.keep and iw or None
+    trans = transaction.StackTransaction(stack, 'goto',
+                                         check_clean_iw = clean_iw)
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
