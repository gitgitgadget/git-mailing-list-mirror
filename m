From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH 2/2] Reuse the same temp index in a transaction
Date: Wed, 02 Jul 2008 08:13:15 +0200
Message-ID: <20080702061314.11361.28297.stgit@yoghurt>
References: <20080702060113.11361.39006.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 02 08:21:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDvie-0003uh-Cf
	for gcvg-git-2@gmane.org; Wed, 02 Jul 2008 08:21:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755449AbYGBGUe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 Jul 2008 02:20:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754822AbYGBGUe
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Jul 2008 02:20:34 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2903 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753263AbYGBGUe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jul 2008 02:20:34 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1KDvb1-00071J-00; Wed, 02 Jul 2008 07:13:39 +0100
In-Reply-To: <20080702060113.11361.39006.stgit@yoghurt>
User-Agent: StGIT/0.14.3.182.gb4dc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87089>

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

 stgit/lib/git.py         |   43 +++++++++++++++++++++++++++++---------=
-----
 stgit/lib/transaction.py |   12 +++++++++++-
 2 files changed, 40 insertions(+), 15 deletions(-)


diff --git a/stgit/lib/git.py b/stgit/lib/git.py
index a38eaa5..c98e919 100644
--- a/stgit/lib/git.py
+++ b/stgit/lib/git.py
@@ -459,31 +459,46 @@ class Repository(RunWithEnv):
     def set_head_ref(self, ref, msg):
         self.run(['git', 'symbolic-ref', '-m', msg, 'HEAD', ref]).no_o=
utput()
     def simple_merge(self, base, ours, theirs):
+        index =3D self.temp_index()
+        try:
+            result, index_tree =3D self.index_merge(base, ours, theirs=
,
+                                                  index, None)
+        finally:
+            index.delete()
+        return result
+    def index_merge(self, base, ours, theirs, index, current):
         """Given three L{Tree}s, tries to do an in-index merge with a
-        temporary index. Returns the result L{Tree}, or None if the
-        merge failed (due to conflicts)."""
+        temporary index. Returns a pair: the result L{Tree}, or None
+        if the merge failed (due to conflicts); and the L{Tree} now
+        stored in the index.
+
+        C{index} is the L{Index} object to use for the merge.
+        C{current} is the L{Tree} object currently stored in the given
+        index. If this is the same as C{ours}, some work is saved.
+        (C{current} may be C{None}, in which case this optimization is
+        disabled.)"""
         assert isinstance(base, Tree)
         assert isinstance(ours, Tree)
         assert isinstance(theirs, Tree)
+        assert isinstance(index, Index)
+        assert current =3D=3D None or isinstance(current, Tree)
=20
         # Take care of the really trivial cases.
         if base =3D=3D ours:
-            return theirs
+            return (theirs, current)
         if base =3D=3D theirs:
-            return ours
+            return (ours, current)
         if ours =3D=3D theirs:
-            return ours
+            return (ours, current)
=20
-        index =3D self.temp_index()
-        index.read_tree(ours)
+        if current !=3D ours:
+            index.read_tree(ours)
         try:
-            try:
-                index.apply_treediff(base, theirs)
-                return index.write_tree()
-            except MergeException:
-                return None
-        finally:
-            index.delete()
+            index.apply_treediff(base, theirs)
+            result =3D index.write_tree()
+            return result, result
+        except MergeException:
+            return None, ours
     def apply(self, tree, patch_text):
         """Given a L{Tree} and a patch, will either return the new L{T=
ree}
         that results when the patch is applied, or None if the patch
diff --git a/stgit/lib/transaction.py b/stgit/lib/transaction.py
index e47997e..b4d4b75 100644
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
+        tree, self.temp_index_tree =3D self.__stack.repository.index_m=
erge(
+            base, ours, theirs, self.temp_index, self.temp_index_tree)
         merge_conflict =3D False
         if not tree:
             if iw =3D=3D None:
