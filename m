From: Catalin Marinas <catalin.marinas@arm.com>
Subject: [StGit PATCH 2/4] Add automatic git-mergetool invocation to the new
	infrastructure
Date: Tue, 17 Mar 2009 11:08:58 +0000
Message-ID: <20090317110858.27748.21534.stgit@pc1117.cambridge.arm.com>
References: <20090317110721.27748.10295.stgit@pc1117.cambridge.arm.com>
Reply-To: Catalin Marinas <catalin.marinas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org,
	Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Tue Mar 17 12:11:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LjXCl-0004sL-7j
	for gcvg-git-2@gmane.org; Tue, 17 Mar 2009 12:11:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756271AbZCQLJa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 17 Mar 2009 07:09:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756046AbZCQLJa
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Mar 2009 07:09:30 -0400
Received: from cam-admin0.cambridge.arm.com ([193.131.176.58]:47551 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755932AbZCQLJ3 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 17 Mar 2009 07:09:29 -0400
Received: from cam-owa2.Emea.Arm.com (cam-owa2.emea.arm.com [10.1.105.18])
	by cam-admin0.cambridge.arm.com (8.12.6/8.12.6) with ESMTP id n2HB7fZm019813;
	Tue, 17 Mar 2009 11:07:41 GMT
Received: from pc1117.cambridge.arm.com ([10.1.255.212]) by cam-owa2.Emea.Arm.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 17 Mar 2009 11:09:24 +0000
In-Reply-To: <20090317110721.27748.10295.stgit@pc1117.cambridge.arm.com>
User-Agent: StGit/0.14.3.353.gf255
X-OriginalArrivalTime: 17 Mar 2009 11:09:24.0553 (UTC) FILETIME=[D492EB90:01C9A6F0]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113463>

This patch adds the IndexAndWorktree.mergetool() function responsible
for calling 'git mergetool' to interactively solve conflicts. The
function may also be called from IndexAndWorktree.merge() if the
standard 'git merge-recursive' fails and 'interactive == True'. The
'allow_interactive' parameter is passed to Transaction.push_patch() from
the functions allowing interactive merging.

Signed-off-by: Catalin Marinas <catalin.marinas@gmail.com>
---
 stgit/commands/edit.py   |    2 +-
 stgit/commands/goto.py   |    2 +-
 stgit/lib/git.py         |   19 ++++++++++++++++---
 stgit/lib/transaction.py |    7 +++++--
 4 files changed, 23 insertions(+), 7 deletions(-)

diff --git a/stgit/commands/edit.py b/stgit/commands/edit.py
index ed785aa..42eb792 100644
--- a/stgit/commands/edit.py
+++ b/stgit/commands/edit.py
@@ -128,7 +128,7 @@ def func(parser, options, args):
     trans.patches[patchname] = stack.repository.commit(cd)
     try:
         for pn in popped:
-            trans.push_patch(pn, iw)
+            trans.push_patch(pn, iw, allow_interactive = True)
     except transaction.TransactionHalted:
         pass
     try:
diff --git a/stgit/commands/goto.py b/stgit/commands/goto.py
index 480266a..66f49df 100644
--- a/stgit/commands/goto.py
+++ b/stgit/commands/goto.py
@@ -48,7 +48,7 @@ def func(parser, options, args):
     elif patch in trans.unapplied:
         try:
             for pn in trans.unapplied[:trans.unapplied.index(patch)+1]:
-                trans.push_patch(pn, iw)
+                trans.push_patch(pn, iw, allow_interactive = True)
         except transaction.TransactionHalted:
             pass
     elif patch in trans.hidden:
diff --git a/stgit/lib/git.py b/stgit/lib/git.py
index 07079b8..e0a3c96 100644
--- a/stgit/lib/git.py
+++ b/stgit/lib/git.py
@@ -824,7 +824,7 @@ class IndexAndWorktree(RunWithEnvCwd):
                      ).discard_output()
         except run.RunException:
             raise CheckoutException('Index/workdir dirty')
-    def merge(self, base, ours, theirs):
+    def merge(self, base, ours, theirs, interactive = False):
         assert isinstance(base, Tree)
         assert isinstance(ours, Tree)
         assert isinstance(theirs, Tree)
@@ -838,10 +838,23 @@ class IndexAndWorktree(RunWithEnvCwd):
             output = r.output_lines()
             if r.exitcode:
                 # There were conflicts
-                conflicts = [l for l in output if l.startswith('CONFLICT')]
-                raise MergeConflictException(conflicts)
+                if interactive:
+                    self.mergetool()
+                else:
+                    conflicts = [l for l in output if l.startswith('CONFLICT')]
+                    raise MergeConflictException(conflicts)
         except run.RunException, e:
             raise MergeException('Index/worktree dirty')
+    def mergetool(self, files = ()):
+        """Invoke 'git mergetool' on the current IndexAndWorktree to resolve
+        any outstanding conflicts. If 'not files', all the files in an
+        unmerged state will be processed."""
+        run.Run(['git', 'mergetool'] + list(files)).returns([0, 1]).run()
+        # check for unmerged entries (prepend 'CONFLICT ' for consistency with
+        # merge())
+        conflicts = ['CONFLICT ' + f for f in self.index.conflicts()]
+        if conflicts:
+            raise MergeConflictException(conflicts)
     def changed_files(self, tree, pathlimits = []):
         """Return the set of files in the worktree that have changed with
         respect to C{tree}. The listing is optionally restricted to
diff --git a/stgit/lib/transaction.py b/stgit/lib/transaction.py
index a88d289..4b5398a 100644
--- a/stgit/lib/transaction.py
+++ b/stgit/lib/transaction.py
@@ -8,6 +8,7 @@ from stgit import exception, utils
 from stgit.utils import any, all
 from stgit.out import *
 from stgit.lib import git, log
+from stgit.config import config
 
 class TransactionException(exception.StgException):
     """Exception raised when something goes wrong with a
@@ -296,7 +297,7 @@ class StackTransaction(object):
                     out.info('Deleted %s%s' % (pn, s))
         return popped
 
-    def push_patch(self, pn, iw = None):
+    def push_patch(self, pn, iw = None, allow_interactive = False):
         """Attempt to push the named patch. If this results in conflicts,
         halts the transaction. If index+worktree are given, spill any
         conflicts to them."""
@@ -319,7 +320,9 @@ class StackTransaction(object):
             except git.CheckoutException:
                 self.__halt('Index/worktree dirty')
             try:
-                iw.merge(base, ours, theirs)
+                interactive = (allow_interactive and
+                               config.get('stgit.autoimerge') == 'yes')
+                iw.merge(base, ours, theirs, interactive = interactive)
                 tree = iw.index.write_tree()
                 self.__current_tree = tree
                 s = ' (modified)'
