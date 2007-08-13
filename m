From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGIT PATCH 2/4] Speed up appliedness check during patch creation
Date: Mon, 13 Aug 2007 23:01:30 +0200
Message-ID: <20070813210130.25929.6548.stgit@yoghurt>
References: <20070813205801.25929.34925.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 13 23:03:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IKh4G-0006Rq-5X
	for gcvg-git@gmane.org; Mon, 13 Aug 2007 23:03:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755760AbXHMVCW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 13 Aug 2007 17:02:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758186AbXHMVCT
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Aug 2007 17:02:19 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3336 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S967290AbXHMVBf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Aug 2007 17:01:35 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1IKh2Z-0008Pl-00; Mon, 13 Aug 2007 22:01:31 +0100
In-Reply-To: <20070813205801.25929.34925.stgit@yoghurt>
User-Agent: StGIT/0.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55786>

When we create a new patch commit that isn't next to an existing patch
commit (which occurs e.g. every time we push the first patch onto a
stack), we do a full recalculation of the set of uninteresting
commits. However, if we know that the new patch refers to a new
commit, we only have to see if this new commit can reach any existing
patch, which is a much cheaper operation.

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

 stgit/stack.py |   54 ++++++++++++++++++++++++++++++++++++++++++------=
------
 1 files changed, 42 insertions(+), 12 deletions(-)

diff --git a/stgit/stack.py b/stgit/stack.py
index d3756d0..8f1c0ee 100644
--- a/stgit/stack.py
+++ b/stgit/stack.py
@@ -485,9 +485,13 @@ class UninterestingCache:
=20
         self.__uninteresting =3D uninteresting
         out.done()
-    def create_patch(self, name, top, bottom):
+    def create_patch(self, name, top, bottom, new_commit):
         """The given patch has been created. Update the uninterested
-        state to maintain the invariant."""
+        state to maintain the invariant.
+
+        If new_commit is true, the caller is promising that top is a
+        new commit that isn't reachable from any of the previously
+        existing uninteresting commits."""
         if not self.__cache_file():
             return # not cached
=20
@@ -507,6 +511,28 @@ class UninterestingCache:
         if bottom in bottoms or bottom in tops or top in bottoms:
             return
=20
+        if new_commit:
+            # The caller has promised us that no existing
+            # uninteresting commit reaches the new patch, which means
+            # that they are all still valid. Now all we have to do is
+            # decide whether to add the new patch's bottom to the set
+            # of uninteresting commits.
+            ref2hash =3D read_refs(self.__series.get_name())
+            patches =3D Set([sha1 for ref, sha1 in ref2hash.iteritems(=
) if ref])
+            for commit in git._output_lines('git-rev-list --stdin %s' =
% bottom,
+                                          ['^%s\n' % u for u in
+                                           self.__uninteresting]):
+                if commit in patches:
+                    # The bottom of the new patch reaches another
+                    # patch, and so isn't uninteresting.
+                    return
+
+            # The bottom of the new patch doesn't reach any other
+            # patch, so it must be uninteresting.
+            self.__uninteresting.add(bottom)
+            self.__write_file()
+            return
+
         # The new patch is not adjacent to an existing patch. We'd
         # need to first get rid of any uninteresting commit that
         # reaches this patch, and then mark the patch's bottom
@@ -619,16 +645,17 @@ class AppliedCache:
                 self.__write_patchorder()
                 return
         raise StackException, 'Unknown patch "%s"' % oldname
-    def new(self, name, top, bottom):
+    def new(self, name, top, bottom, new_commit):
         """Create new patch."""
-        self.__uninteresting.create_patch(name, top, bottom)
+        self.__uninteresting.create_patch(name, top, bottom, new_commi=
t)
     def delete(self, name, top, bottom):
         """Delete a patch."""
         self.__uninteresting.delete_patch(name, top, bottom)
-    def change(self, name, old_top, old_bottom, new_top, new_bottom):
+    def change(self, name, old_top, old_bottom, new_top, new_bottom,
+               new_commit):
         """Change a patch."""
         if (new_top, new_bottom) !=3D (old_top, old_bottom):
-            self.new(name, new_top, new_bottom)
+            self.new(name, new_top, new_bottom, new_commit)
             self.delete(name, old_top, old_bottom)
     def __write_patchorder(self):
         self.__order.set_patchorder(self.get_applied() + self.get_unap=
plied())
@@ -1128,7 +1155,7 @@ class Series(PatchSet):
         if patch.restore_old_boundaries():
             self.log_patch(patch, 'undo')
         self.__applied_cache.change(name, curr_top, curr_bottom,
-                                    old_top, old_bottom)
+                                    old_top, old_bottom, new_commit =3D=
 False)
=20
     def new_patch(self, name, message =3D None, can_edit =3D True,
                   unapplied =3D False, show_patch =3D False,
@@ -1163,7 +1190,6 @@ class Series(PatchSet):
=20
         bottom =3D bottom or head
         top =3D top or head
-        self.__applied_cache.new(name, top, bottom)
=20
         patch.set_bottom(bottom)
         patch.set_top(top)
@@ -1197,10 +1223,12 @@ class Series(PatchSet):
                                    committer_name =3D committer_name,
                                    committer_email =3D committer_email=
)
             # set the patch top to the new commit
+            top =3D commit_id
             patch.set_top(commit_id)
=20
         self.log_patch(patch, 'new')
=20
+        self.__applied_cache.new(name, top, bottom, new_commit =3D com=
mit)
         self.__applied_cache.set_patchorder(order)
         return patch
=20
@@ -1291,7 +1319,7 @@ class Series(PatchSet):
=20
                     self.__applied_cache.change(
                         name, old_top =3D old_top, old_bottom =3D bott=
om,
-                        new_top =3D top, new_bottom =3D head)
+                        new_top =3D top, new_bottom =3D head, new_comm=
it =3D True)
                     self.log_patch(patch, 'push(f)')
                 else:
                     top =3D head
@@ -1349,7 +1377,8 @@ class Series(PatchSet):
             # need an empty commit
             patch.set_bottom(head, backup =3D True)
             patch.set_top(head, backup =3D True)
-            self.__applied_cache.change(name, top, bottom, head, head)
+            self.__applied_cache.change(name, top, bottom, head, head,
+                                        new_commit =3D False)
             modified =3D True
         elif head =3D=3D bottom:
             # reset the backup information. No need for logging
@@ -1362,7 +1391,8 @@ class Series(PatchSet):
             # The current patch is empty after merge.
             patch.set_bottom(head, backup =3D True)
             patch.set_top(head, backup =3D True)
-            self.__applied_cache.change(name, top, bottom, head, head)
+            self.__applied_cache.change(name, top, bottom, head, head,
+                                        new_commit =3D False)
=20
             # Try the fast applying first. If this fails, fall back to=
 the
             # three-way merge
@@ -1422,7 +1452,7 @@ class Series(PatchSet):
         self.pop_patch(name)
         ret =3D patch.restore_old_boundaries()
         self.__applied_cache.change(name, curr_top, curr_bottom,
-                                    old_top, old_bottom)
+                                    old_top, old_bottom, new_commit =3D=
 False)
         if ret:
             self.log_patch(patch, 'undo')
=20
