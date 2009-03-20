From: Catalin Marinas <catalin.marinas@arm.com>
Subject: [StGit PATCH] Add the --merged option to goto
Date: Fri, 20 Mar 2009 16:15:45 +0000
Message-ID: <20090320161233.28989.82497.stgit@pc1117.cambridge.arm.com>
Reply-To: Catalin Marinas <catalin.marinas@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org,
	Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
X-From: git-owner@vger.kernel.org Fri Mar 20 17:18:43 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkhPr-0004Qz-VC
	for gcvg-git-2@gmane.org; Fri, 20 Mar 2009 17:17:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757606AbZCTQQU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Mar 2009 12:16:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757442AbZCTQQT
	(ORCPT <rfc822;git-outgoing>); Fri, 20 Mar 2009 12:16:19 -0400
Received: from cam-admin0.cambridge.arm.com ([193.131.176.58]:33104 "EHLO
	cam-admin0.cambridge.arm.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756515AbZCTQQS (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 20 Mar 2009 12:16:18 -0400
Received: from cam-owa2.Emea.Arm.com (cam-owa2.emea.arm.com [10.1.105.18])
	by cam-admin0.cambridge.arm.com (8.12.6/8.12.6) with ESMTP id n2KGEKZm011862;
	Fri, 20 Mar 2009 16:14:20 GMT
Received: from pc1117.cambridge.arm.com ([10.1.255.212]) by cam-owa2.Emea.Arm.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 20 Mar 2009 16:16:12 +0000
User-Agent: StGit/0.14.3.353.g1ace
X-OriginalArrivalTime: 20 Mar 2009 16:16:12.0988 (UTC) FILETIME=[30186FC0:01C9A977]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113974>

This patch adds support for checking which patches were already merged
upstream. This checking is done by trying to reverse-apply the patches
in the index before pushing them onto the stack. The trivial merge cases
in Index.merge() are ignored when performing this operation otherwise
the results could be wrong (e.g. a patch adding a hunk and a subsequent
patch canceling the previous change would both be considered merged).

Signed-off-by: Catalin Marinas <catalin.marinas@gmail.com>
---

This is in preparation for the updating of the push command where we
have this functionality (I think we had it for goto as well but was lost
with the update to stgit.lib). Test cases with --merged are already done
for the push command, so I haven't added any for goto (but I'll push
this patch only after push is updated).

 stgit/argparse.py        |    4 ++++
 stgit/commands/goto.py   |   12 +++++++++---
 stgit/lib/git.py         |   15 ++++++++-------
 stgit/lib/transaction.py |   42 +++++++++++++++++++++++++++++++++++-------
 4 files changed, 56 insertions(+), 17 deletions(-)

diff --git a/stgit/argparse.py b/stgit/argparse.py
index 85ee6e3..765579c 100644
--- a/stgit/argparse.py
+++ b/stgit/argparse.py
@@ -225,6 +225,10 @@ def keep_option():
                 short = 'Keep the local changes',
                 default = config.get('stgit.autokeep') == 'yes')]
 
+def merged_option():
+    return [opt('-m', '--merged', action = 'store_true',
+                short = 'Check for patches merged upstream')]
+
 class CompgenBase(object):
     def actions(self, var): return set()
     def words(self, var): return set()
diff --git a/stgit/commands/goto.py b/stgit/commands/goto.py
index 66f49df..839b75c 100644
--- a/stgit/commands/goto.py
+++ b/stgit/commands/goto.py
@@ -28,7 +28,7 @@ Push/pop patches to/from the stack until the one given on the command
 line becomes current."""
 
 args = [argparse.other_applied_patches, argparse.unapplied_patches]
-options = argparse.keep_option()
+options = argparse.keep_option() + argparse.merged_option()
 
 directory = common.DirectoryHasRepositoryLib()
 
@@ -47,8 +47,14 @@ def func(parser, options, args):
         assert not trans.pop_patches(lambda pn: pn in to_pop)
     elif patch in trans.unapplied:
         try:
-            for pn in trans.unapplied[:trans.unapplied.index(patch)+1]:
-                trans.push_patch(pn, iw, allow_interactive = True)
+            to_push = trans.unapplied[:trans.unapplied.index(patch)+1]
+            if options.merged:
+                merged = set(trans.check_merged(to_push))
+            else:
+                merged = set()
+            for pn in to_push:
+                trans.push_patch(pn, iw, allow_interactive = True,
+                                 already_merged = pn in merged)
         except transaction.TransactionHalted:
             pass
     elif patch in trans.hidden:
diff --git a/stgit/lib/git.py b/stgit/lib/git.py
index e0a3c96..875e352 100644
--- a/stgit/lib/git.py
+++ b/stgit/lib/git.py
@@ -732,7 +732,7 @@ class Index(RunWithEnv):
         # to use --binary.
         self.apply(self.__repository.diff_tree(tree1, tree2, ['--full-index']),
                    quiet)
-    def merge(self, base, ours, theirs, current = None):
+    def merge(self, base, ours, theirs, current = None, check_trivial = True):
         """Use the index (and only the index) to do a 3-way merge of the
         L{Tree}s C{base}, C{ours} and C{theirs}. The merge will either
         succeed (in which case the first half of the return value is
@@ -752,12 +752,13 @@ class Index(RunWithEnv):
         assert current == None or isinstance(current, Tree)
 
         # Take care of the really trivial cases.
-        if base == ours:
-            return (theirs, current)
-        if base == theirs:
-            return (ours, current)
-        if ours == theirs:
-            return (ours, current)
+        if check_trivial:
+            if base == ours:
+                return (theirs, current)
+            if base == theirs:
+                return (ours, current)
+            if ours == theirs:
+                return (ours, current)
 
         if current == theirs:
             # Swap the trees. It doesn't matter since merging is
diff --git a/stgit/lib/transaction.py b/stgit/lib/transaction.py
index b146648..8cd5e50 100644
--- a/stgit/lib/transaction.py
+++ b/stgit/lib/transaction.py
@@ -297,7 +297,8 @@ class StackTransaction(object):
                     out.info('Deleted %s%s' % (pn, s))
         return popped
 
-    def push_patch(self, pn, iw = None, allow_interactive = False):
+    def push_patch(self, pn, iw = None, allow_interactive = False,
+                   already_merged = False):
         """Attempt to push the named patch. If this results in conflicts,
         halts the transaction. If index+worktree are given, spill any
         conflicts to them."""
@@ -305,11 +306,14 @@ class StackTransaction(object):
         cd = orig_cd.set_committer(None)
         oldparent = cd.parent
         cd = cd.set_parent(self.top)
-        base = oldparent.data.tree
-        ours = cd.parent.data.tree
-        theirs = cd.tree
-        tree, self.temp_index_tree = self.temp_index.merge(
-            base, ours, theirs, self.temp_index_tree)
+        if already_merged:
+            tree = cd.tree
+        else:
+            base = oldparent.data.tree
+            ours = cd.parent.data.tree
+            theirs = cd.tree
+            tree, self.temp_index_tree = self.temp_index.merge(
+                base, ours, theirs, self.temp_index_tree)
         s = ''
         merge_conflict = False
         if not tree:
@@ -341,7 +345,9 @@ class StackTransaction(object):
         else:
             comm = None
             s = ' (unmodified)'
-        if not merge_conflict and cd.is_nochange():
+        if already_merged:
+            s = ' (merged)'
+        elif not merge_conflict and cd.is_nochange():
             s = ' (empty)'
         out.info('Pushed %s%s' % (pn, s))
         def update():
@@ -379,3 +385,25 @@ class StackTransaction(object):
         assert set(self.unapplied + self.hidden) == set(unapplied + hidden)
         self.unapplied = unapplied
         self.hidden = hidden
+
+    def check_merged(self, patches):
+        """Return a subset of patches already merged."""
+        merged = []
+        temp_index = self.__stack.repository.temp_index()
+        temp_index_tree = None
+        ours = self.stack.head.data.tree
+
+        for pn in reversed(patches):
+            # check whether patch changes can be reversed in the current tree
+            cd = self.patches[pn].data
+            base = cd.tree
+            theirs = cd.parent.data.tree
+            tree, temp_index_tree = \
+                    temp_index.merge(base, ours, theirs, temp_index_tree,
+                                     check_trivial = False)
+            if tree:
+                merged.append(pn)
+                ours = tree
+
+        temp_index.delete()
+        return merged
