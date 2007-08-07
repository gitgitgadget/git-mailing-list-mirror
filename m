From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGIT PATCH 5/5] Speed up the appliedness test
Date: Tue, 07 Aug 2007 04:48:08 +0200
Message-ID: <20070807024807.11373.24802.stgit@yoghurt>
References: <20070807024508.11373.62875.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 07 04:48:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IIF7L-0005Lh-Bu
	for gcvg-git@gmane.org; Tue, 07 Aug 2007 04:48:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932626AbXHGCsO convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 6 Aug 2007 22:48:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1766008AbXHGCsN
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Aug 2007 22:48:13 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2249 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765984AbXHGCsK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Aug 2007 22:48:10 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1IIF7A-0002V0-00; Tue, 07 Aug 2007 03:48:08 +0100
In-Reply-To: <20070807024508.11373.62875.stgit@yoghurt>
User-Agent: StGIT/0.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55210>

The appliedness test was too slow if at least one patch, applied or
unapplied, was too far away from HEAD, since we had to visit the whole
intervening part of the commit DAG.

This patch fixes that problem by maintaining a cache of uninteresting
commits that are known to not reach any patches in the commit DAG.
(Specifically, this is at all times the set of commits that are
parents to patch commits and do not have a patch commit as their
ancestor.) By exlcuding these commits when walking the graph, we only
have to visit the interesting places.

As a nice side effect, the cache of uninteresting commits makes it
possible to use just one git-rev-list call instead of two, since we
can list the applied patches without first computing the unapplied
patches; the unapplied patches are then simply all patches except
those that are applied.

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

 stgit/stack.py |  272 ++++++++++++++++++++++++++++++++++++++++++++++--=
--------
 1 files changed, 221 insertions(+), 51 deletions(-)

diff --git a/stgit/stack.py b/stgit/stack.py
index 4186ba9..5a51329 100644
--- a/stgit/stack.py
+++ b/stgit/stack.py
@@ -155,7 +155,7 @@ class Patch(StgitObject):
         os.mkdir(self._dir())
         self.create_empty_field('bottom')
         self.create_empty_field('top')
-
+=20
     def delete(self):
         for f in os.listdir(self._dir()):
             os.remove(os.path.join(self._dir(), f))
@@ -351,7 +351,11 @@ class PatchorderCache:
     saved in its patchorder file."""
     def __init__(self, series):
         self.__series =3D series
+        self.__file =3D os.path.join(self.__series._dir(), 'patchorder=
')
         self.__invalidate()
+    def delete_file(self):
+        if os.path.isfile(self.__file):
+            os.remove(self.__file)
     def __invalidate(self):
         self.__patchnames =3D None
         self.__position =3D None
@@ -361,9 +365,8 @@ class PatchorderCache:
=20
         self.__patchnames =3D []
         self.__position =3D {}
-        pof =3D os.path.join(self.__series._dir(), 'patchorder')
-        if os.path.isfile(pof):
-            for line in file(pof):
+        if os.path.isfile(self.__file):
+            for line in file(self.__file):
                 name =3D line.strip()
                 assert not name in self.__position
                 self.__position[name] =3D len(self.__patchnames)
@@ -386,60 +389,200 @@ class PatchorderCache:
         pos2 =3D self.__position.get(name2, largepos)
         return cmp((pos1, name1), (pos2, name2))
=20
+class UninterestingCache:
+    """Keeps track of a set of commits that do not reach any patches.
+    These are used to speed up the detection of unapplied patches.
+
+    Specifically, this is at all times the set of commits c that
+    fulfill the following two criteria:
+
+      * c does not reach any patch
+
+      * c is the parent of a patch
+
+    """
+    def __init__(self, series):
+        self.__series =3D series
+        self.__uninteresting =3D None
+        self.__filename =3D os.path.join(self.__series._dir(), 'uninte=
resting')
+    def __invalidate(self):
+        self.__uninteresting =3D None
+        self.delete_file()
+    def delete_file(self):
+        if os.path.isfile(self.__filename):
+            os.remove(self.__filename)
+    def __other_patches(self, patchname):
+        """All patches except the named one."""
+        ref2hash =3D read_refs(self.__series.get_name())
+        return [self.__series.get_patch(ref)
+                for ref in ref2hash.iterkeys()
+                if ref and ref !=3D patchname]
+    def __write_file(self):
+        """Write the uninteresting commits to file."""
+        try:
+            f =3D file(self.__filename, 'w')
+            for u in self.__uninteresting:
+                f.write('%s\n' % u)
+            f.close()
+        except IOError:
+            pass # this isn't fatal -- the directory is probably missi=
ng
+    def __read_file(self):
+        """Read the uninteresting commits from file. Return true on
+        success, false on failure."""
+        if not os.path.isfile(self.__filename):
+            return False
+        self.__uninteresting =3D Set()
+        for line in file(self.__filename):
+            self.__uninteresting.add(line.strip())
+        return True
+    def __cache_file(self):
+        """Try to cache the uninteresting commits using only the cache
+        file. Return true on success, false on failure."""
+        if self.__uninteresting !=3D None:
+            return True # already cached
+        return self.__read_file()
+    def __cache(self):
+        """Cache the uninteresting commits, recomputing them if
+        necessary."""
+        if self.__cache_file():
+            return
+        self.__compute_uninteresting()
+        self.__write_file()
+    def __compute_uninteresting(self):
+        """Compute a reasonable set of uninteresting commits from
+        scratch. This is expensive."""
+        out.start('Finding uninteresting commits')
+        ref2hash =3D read_refs(self.__series.get_name())
+        patches =3D Set([sha1 for ref, sha1 in ref2hash.iteritems() if=
 ref])
+        interesting, uninteresting =3D Set(), Set()
+
+        # Iterate over all commits. We are guaranteed to see each
+        # commit before any of its children.
+        for line in git._output_lines(
+            'git-rev-list --topo-order --reverse --parents --all'):
+            commits =3D line.split()
+            commit, parents =3D commits[0], Set(commits[1:])
+
+            # Patches are interesting.
+            if commit in patches:
+                interesting.add(commit)
+
+                # The parents of a patch are uninteresting unless they
+                # are interesting.
+                for p in parents:
+                    if not p in interesting:
+                        uninteresting.add(p)
+                continue
+
+            # Commits with interesting parents are interesting.
+            if interesting.intersection(parents):
+                interesting.add(commit)
+        self.__uninteresting =3D uninteresting
+        out.done()
+    def create_patch(self, name, top, bottom):
+        """The given patch has been created. Update the uninterested
+        state to maintain the invariant."""
+        if not self.__cache_file():
+            return # not cached
+
+        # New patch inserted just below an existing bottommost patch:
+        # need to move the uninteresting commit down one step.
+        if top in self.__uninteresting:
+            self.__uninteresting.remove(top)
+            self.__uninteresting.add(bottom)
+            self.__write_file()
+            return
+
+        # New patch inserted next to an existing non-bottommost patch:
+        # don't need to do anything.
+        existing_patches =3D self.__other_patches(name)
+        tops =3D Set([p.get_top() for p in existing_patches])
+        bottoms =3D Set([p.get_bottom() for p in existing_patches])
+        if bottom in bottoms or bottom in tops or top in bottoms:
+            return
+
+        # The new patch is not adjacent to an existing patch. We'd
+        # need to first get rid of any uninteresting commit that
+        # reaches this patch, and then mark the patch's bottom
+        # uninteresting if it doesn't reach any other patch. This is a
+        # lot of work, so we chicken out and blow the whole cache
+        # instead.
+        self.__invalidate()
+    def delete_patch(self, name, top, bottom):
+        """The given patch has been deleted. Update the uninterested
+        state to maintain the invariant."""
+        if not self.__cache_file():
+            return # not cached
+
+        # If this patch reaches another patch, there's nothing to do.
+        if not bottom in self.__uninteresting:
+            return
+
+        # If another patch has the same bottom, it's still
+        # uninteresting and there's nothing more to do.
+        other_patches =3D self.__other_patches(name)
+        for p in other_patches:
+            if p.get_bottom() =3D=3D bottom:
+                return
+
+        # If there are other patches on top of this one, their bottoms
+        # (this patch's top) become uninteresting in place of this
+        # patch's bottom.
+        for p in other_patches:
+            if p.get_bottom() =3D=3D top:
+                self.__uninteresting.remove(bottom)
+                self.__uninteresting.add(top)
+                self.__write_file()
+                return
+
+        # The bottom of this patch is no longer uninteresting. But
+        # there might be other patches that reach it, whose bottoms
+        # would need to be marked uninteresting. That would require an
+        # expensive reachability analysis.
+        self.__invalidate()
+    def get(self):
+        self.__cache()
+        return self.__uninteresting
+
 def read_refs(branch):
     """Return a mapping from patches and branch head to hashes for a
     given branch. The patches are listed by name; the branch head is
     None."""
     refs =3D {}
     patchpat =3D re.compile(r'^refs/patches/%s/([^\.]+)$' % branch)
+    head =3D 'refs/heads/%s' % branch
     for line in git._output_lines('git-show-ref'):
         sha1, ref =3D line.split()
         m =3D re.match(patchpat, ref)
         if m:
             refs[m.group(1)] =3D sha1
-        elif ref =3D=3D 'refs/heads/%s' % branch:
+        elif ref =3D=3D head:
             refs[None] =3D sha1
+    if not None in refs:
+        raise StackException, 'Could not find %s' % head
     return refs
=20
-def unapplied_patches(ref2hash):
+def get_patches(ref2hash, uninteresting):
     """Given a map of patch names (and the branch head, keyed by None)
-    to hashes, return the set of unapplied patches."""
-    hash2refs =3D {}
-    for r, h in ref2hash.iteritems():
-        hash2refs.setdefault(h, Set()).add(r)
-
+    to hashes, return the list of applied patches and the set of
+    unapplied patches. The second parameter is a set of commit objects
+    that do not reach any patch."""
+    applied =3D []
     unapplied =3D Set()
-    for line in git._output_lines(
-        'git-rev-list --stdin',
-        ('%s%s\n' % (['', '^'][ref =3D=3D None], sha1)
-         for ref, sha1 in ref2hash.iteritems())):
-        for ref in hash2refs.get(line.strip(), []):
-            unapplied.add(ref)
-    return unapplied
-
-def sort_applied_patches(ref2hash):
-    """Given a map of patch names (and the branch head, keyed by None)
-    to hashes, return a list with the applied patches in stack order.
-    All patches in the map must be applied."""
-    hash2refs =3D {}
+    hash2patches =3D {}
     for r, h in ref2hash.iteritems():
-        if r !=3D None:
-            hash2refs.setdefault(h, Set()).add(r)
+        if r:
+            hash2patches.setdefault(h, Set()).add(r)
+            unapplied.add(r)
=20
-    missing =3D Set(ref for ref in ref2hash.iterkeys() if ref !=3D Non=
e)
-    if not missing:
-        return []
-    applied =3D []
-    grl =3D popen2.Popen3('git-rev-list %s' % ref2hash[None], True)
-    for line in grl.fromchild:
-        for ref in hash2refs.get(line.strip(), []):
+    for line in git._output_lines(
+        'git-rev-list --topo-order --stdin', ['%s\n' % ref2hash[None]]
+        + ['^%s\n' % u for u in uninteresting]):
+        for ref in hash2patches.get(line.strip(), []):
             applied.append(ref)
-            missing.remove(ref)
-        if not missing:
-            applied.reverse()
-            return applied
-
-    raise StackException, 'Could not find patches: %s' % ', '.join(mis=
sing)
+            unapplied.remove(ref)
+    applied.reverse()
+    return applied, unapplied
=20
 class AppliedCache:
     """An object that keeps track of the appliedness and order of the
@@ -447,7 +590,11 @@ class AppliedCache:
     def __init__(self, series):
         self.__series =3D series
         self.__order =3D PatchorderCache(series)
+        self.__uninteresting =3D UninterestingCache(series)
         self.__invalidate()
+    def delete_files(self):
+        for sub in [self.__uninteresting, self.__order]:
+            sub.delete_file()
     def get_applied(self):
         self.__cache()
         return self.__applied
@@ -466,6 +613,17 @@ class AppliedCache:
                 self.__write_patchorder()
                 return
         raise StackException, 'Unknown patch "%s"' % oldname
+    def new(self, name, top, bottom):
+        """Create new patch."""
+        self.__uninteresting.create_patch(name, top, bottom)
+    def delete(self, name, top, bottom):
+        """Delete a patch."""
+        self.__uninteresting.delete_patch(name, top, bottom)
+    def change(self, name, old_top, old_bottom, new_top, new_bottom):
+        """Change a patch."""
+        if (new_top, new_bottom) !=3D (old_top, old_bottom):
+            self.new(name, new_top, new_bottom)
+            self.delete(name, old_top, old_bottom)
     def __write_patchorder(self):
         self.__order.set_patchorder(self.get_applied() + self.get_unap=
plied())
     def set_patchorder(self, new_order):
@@ -484,11 +642,8 @@ class AppliedCache:
     def __cache(self):
         if self.__cached():
             return
-        patches =3D read_refs(self.__series.get_name())
-        unapplied =3D unapplied_patches(patches)
-        for patch in unapplied:
-            del patches[patch]
-        self.__applied =3D sort_applied_patches(patches)
+        self.__applied, unapplied =3D get_patches(
+            read_refs(self.__series.get_name()), self.__uninteresting.=
get())
         self.__unapplied =3D list(unapplied)
         self.__unapplied.sort(self.__order.cmp)
=20
@@ -849,6 +1004,7 @@ class Series(PatchSet):
                 os.remove(self.__hidden_file)
             if os.path.exists(self._dir()+'/orig-base'):
                 os.remove(self._dir()+'/orig-base')
+            self.__applied_cache.delete_files()
=20
             if not os.listdir(self.__patch_dir):
                 os.rmdir(self.__patch_dir)
@@ -953,16 +1109,20 @@ class Series(PatchSet):
         patch =3D self.get_patch(name)
         old_bottom =3D patch.get_old_bottom()
         old_top =3D patch.get_old_top()
+        curr_bottom =3D patch.get_bottom()
+        curr_top =3D patch.get_top()
=20
         # the bottom of the patch is not changed by refresh. If the
         # old_bottom is different, there wasn't any previous 'refresh'
         # command (probably only a 'push')
-        if old_bottom !=3D patch.get_bottom() or old_top =3D=3D patch.=
get_top():
+        if old_bottom !=3D curr_bottom or old_top =3D=3D curr_top:
             raise StackException, 'No undo information available'
=20
         git.reset(tree_id =3D old_top, check_out =3D False)
         if patch.restore_old_boundaries():
             self.log_patch(patch, 'undo')
+        self.__applied_cache.change(name, curr_top, curr_bottom,
+                                    old_top, old_bottom)
=20
     def new_patch(self, name, message =3D None, can_edit =3D True,
                   unapplied =3D False, show_patch =3D False,
@@ -995,10 +1155,9 @@ class Series(PatchSet):
         patch =3D self.get_patch(name)
         patch.create()
=20
-        if not bottom:
-            bottom =3D head
-        if not top:
-            top =3D head
+        bottom =3D bottom or head
+        top =3D top or head
+        self.__applied_cache.new(name, top, bottom)
=20
         patch.set_bottom(bottom)
         patch.set_top(top)
@@ -1042,15 +1201,16 @@ class Series(PatchSet):
     def delete_patch_data(self, name):
         """Deletes the stgit data for a patch."""
         patch =3D Patch(name, self.__patch_dir, self.__refs_dir)
+        top, bottom =3D patch.get_top(), patch.get_bottom()
=20
         # save the commit id to a trash file
-        write_string(os.path.join(self.__trash_dir, name), patch.get_t=
op())
+        write_string(os.path.join(self.__trash_dir, name), top)
=20
         patch.delete()
         if self.patch_hidden(name):
             self.unhide_patch(name)
=20
-        return patch
+        self.__applied_cache.delete(name, top, bottom)
=20
     def delete_patch(self, name):
         """Deletes a patch
@@ -1109,6 +1269,7 @@ class Series(PatchSet):
=20
                     top_tree =3D git.get_commit(top).get_tree()
=20
+                    old_top =3D top
                     top =3D git.commit(message =3D descr, parents =3D =
[head],
                                      cache_update =3D False,
                                      tree_id =3D top_tree,
@@ -1122,6 +1283,9 @@ class Series(PatchSet):
                     patch.set_bottom(head, backup =3D True)
                     patch.set_top(top, backup =3D True)
=20
+                    self.__applied_cache.change(
+                        name, old_top =3D old_top, old_bottom =3D bott=
om,
+                        new_top =3D top, new_bottom =3D head)
                     self.log_patch(patch, 'push(f)')
                 else:
                     top =3D head
@@ -1179,6 +1343,7 @@ class Series(PatchSet):
             # need an empty commit
             patch.set_bottom(head, backup =3D True)
             patch.set_top(head, backup =3D True)
+            self.__applied_cache.change(name, top, bottom, head, head)
             modified =3D True
         elif head =3D=3D bottom:
             # reset the backup information. No need for logging
@@ -1191,6 +1356,7 @@ class Series(PatchSet):
             # The current patch is empty after merge.
             patch.set_bottom(head, backup =3D True)
             patch.set_top(head, backup =3D True)
+            self.__applied_cache.change(name, top, bottom, head, head)
=20
             # Try the fast applying first. If this fails, fall back to=
 the
             # three-way merge
@@ -1236,6 +1402,8 @@ class Series(PatchSet):
         patch =3D self.get_patch(name)
         old_bottom =3D patch.get_old_bottom()
         old_top =3D patch.get_old_top()
+        curr_bottom =3D patch.get_bottom()
+        curr_top =3D patch.get_top()
=20
         # the top of the patch is changed by a push operation only
         # together with the bottom (otherwise the top was probably
@@ -1247,6 +1415,8 @@ class Series(PatchSet):
         git.reset()
         self.pop_patch(name)
         ret =3D patch.restore_old_boundaries()
+        self.__applied_cache.change(name, curr_top, curr_bottom,
+                                    old_top, old_bottom)
         if ret:
             self.log_patch(patch, 'undo')
=20
