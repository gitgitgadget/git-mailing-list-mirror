From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH v2] Reuse the same temp index in a transaction
Date: Thu, 03 Jul 2008 23:38:25 +0200
Message-ID: <20080703213712.30489.51872.stgit@yoghurt>
References: <20080702061314.11361.28297.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 03 23:46:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KEWd0-0003cI-6X
	for gcvg-git-2@gmane.org; Thu, 03 Jul 2008 23:46:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757004AbYGCVjL convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 3 Jul 2008 17:39:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756977AbYGCVjK
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Jul 2008 17:39:10 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4111 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758087AbYGCVjI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jul 2008 17:39:08 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1KEWVX-0007D0-00; Thu, 03 Jul 2008 22:38:27 +0100
In-Reply-To: <20080702061314.11361.28297.stgit@yoghurt>
User-Agent: StGIT/0.14.3.185.gb9e85
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87324>

Instead of making a new temp index every time we need one, just keep
reusing the same one. And keep track of which tree is currently stored
in it -- if we do several consecutive successful pushes, it's always
going to be the "right" tree so that we don't have to call read-tree
before each patch application.

The motivation behind this change is of course that it makes things
faster.

(The same simple test as in the previous patch -- pushing 250 patches
in a 32k-file repository, with one file-level merge necessary per push
-- went from 0.36 to 0.19 seconds per patch with this patch applied.)

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

Here's the same patch, but with Repository.index_merge() instead
called Index.merge(). A much better fit, I think.

Also some doc changes compared to v1.

 stgit/lib/git.py         |   63 +++++++++++++++++++++++++++++++-------=
--------
 stgit/lib/transaction.py |   12 ++++++++-
 2 files changed, 53 insertions(+), 22 deletions(-)


diff --git a/stgit/lib/git.py b/stgit/lib/git.py
index 9402606..8fb8bd2 100644
--- a/stgit/lib/git.py
+++ b/stgit/lib/git.py
@@ -459,31 +459,12 @@ class Repository(RunWithEnv):
     def set_head_ref(self, ref, msg):
         self.run(['git', 'symbolic-ref', '-m', msg, 'HEAD', ref]).no_o=
utput()
     def simple_merge(self, base, ours, theirs):
-        """Given three L{Tree}s, tries to do an in-index merge with a
-        temporary index. Returns the result L{Tree}, or None if the
-        merge failed (due to conflicts)."""
-        assert isinstance(base, Tree)
-        assert isinstance(ours, Tree)
-        assert isinstance(theirs, Tree)
-
-        # Take care of the really trivial cases.
-        if base =3D=3D ours:
-            return theirs
-        if base =3D=3D theirs:
-            return ours
-        if ours =3D=3D theirs:
-            return ours
-
         index =3D self.temp_index()
-        index.read_tree(ours)
         try:
-            try:
-                index.apply_treediff(base, theirs)
-                return index.write_tree()
-            except MergeException:
-                return None
+            result, index_tree =3D index.merge(base, ours, theirs)
         finally:
             index.delete()
+        return result
     def apply(self, tree, patch_text):
         """Given a L{Tree} and a patch, will either return the new L{T=
ree}
         that results when the patch is applied, or None if the patch
@@ -563,6 +544,46 @@ class Index(RunWithEnv):
         # contains all involved objects; in other words, we don't have
         # to use --binary.
         self.apply(self.__repository.diff_tree(tree1, tree2, ['--full-=
index']))
+    def merge(self, base, ours, theirs, current =3D None):
+        """Use the index (and only the index) to do a 3-way merge of t=
he
+        L{Tree}s C{base}, C{ours} and C{theirs}. The merge will either
+        succeed (in which case the first half of the return value is
+        the resulting tree) or fail cleanly (in which case the first
+        half of the return value is C{None}).
+
+        If C{current} is given (and not C{None}), it is assumed to be
+        the L{Tree} currently stored in the index; this information is
+        used to avoid having to read the right tree (either of C{ours}
+        and C{theirs}) into the index if it's already there. The
+        second half of the return value is the tree now stored in the
+        index, or C{None} if unknown. If the merge succeeded, this is
+        often the merge result."""
+        assert isinstance(base, Tree)
+        assert isinstance(ours, Tree)
+        assert isinstance(theirs, Tree)
+        assert current =3D=3D None or isinstance(current, Tree)
+
+        # Take care of the really trivial cases.
+        if base =3D=3D ours:
+            return (theirs, current)
+        if base =3D=3D theirs:
+            return (ours, current)
+        if ours =3D=3D theirs:
+            return (ours, current)
+
+        if current =3D=3D theirs:
+            # Swap the trees. It doesn't matter since merging is
+            # symmetric, and will allow us to avoid the read_tree()
+            # call below.
+            ours, theirs =3D theirs, ours
+        if current !=3D ours:
+            self.read_tree(ours)
+        try:
+            self.apply_treediff(base, theirs)
+            result =3D self.write_tree()
+            return (result, result)
+        except MergeException:
+            return (None, ours)
     def delete(self):
         if os.path.isfile(self.__filename):
             os.remove(self.__filename)
diff --git a/stgit/lib/transaction.py b/stgit/lib/transaction.py
index e47997e..74bc74d 100644
--- a/stgit/lib/transaction.py
+++ b/stgit/lib/transaction.py
@@ -1,6 +1,8 @@
 """The L{StackTransaction} class makes it possible to make complex
 updates to an StGit stack in a safe and convenient way."""
=20
+import atexit
+
 from stgit import exception, utils
 from stgit.utils import any, all
 from stgit.out import *
@@ -84,6 +86,7 @@ class StackTransaction(object):
             self.__allow_conflicts =3D lambda trans: allow_conflicts
         else:
             self.__allow_conflicts =3D allow_conflicts
+        self.__temp_index =3D self.temp_index_tree =3D None
     stack =3D property(lambda self: self.__stack)
     patches =3D property(lambda self: self.__patches)
     def __set_applied(self, val):
@@ -97,6 +100,12 @@ class StackTransaction(object):
                 or self.patches[self.applied[0]].data.parent =3D=3D va=
l)
         self.__base =3D val
     base =3D property(lambda self: self.__base, __set_base)
+    @property
+    def temp_index(self):
+        if not self.__temp_index:
+            self.__temp_index =3D self.__stack.repository.temp_index()
+            atexit.register(self.__temp_index.delete)
+        return self.__temp_index
     def __checkout(self, tree, iw):
         if not self.__stack.head_top_equal():
             out.error(
@@ -238,7 +247,8 @@ class StackTransaction(object):
         base =3D oldparent.data.tree
         ours =3D cd.parent.data.tree
         theirs =3D cd.tree
-        tree =3D self.__stack.repository.simple_merge(base, ours, thei=
rs)
+        tree, self.temp_index_tree =3D self.temp_index.merge(
+            base, ours, theirs, self.temp_index_tree)
         merge_conflict =3D False
         if not tree:
             if iw =3D=3D None:
