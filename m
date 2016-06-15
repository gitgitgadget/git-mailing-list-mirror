From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGIT PATCH 3/6] Compute patch appliedness from commit DAG
Date: Sun, 10 Jun 2007 02:55:09 -0700
Message-ID: <20070610095509.12000.48275.stgit@bill>
References: <20070610094322.12000.56284.stgit@bill>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 10 11:55:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxK8l-0006dA-Dp
	for gcvg-git@gmane.org; Sun, 10 Jun 2007 11:55:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752836AbXFJJzR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 10 Jun 2007 05:55:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752820AbXFJJzQ
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jun 2007 05:55:16 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1830 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752648AbXFJJzN (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jun 2007 05:55:13 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1HxK8c-0008Rf-00; Sun, 10 Jun 2007 10:55:11 +0100
In-Reply-To: <20070610094322.12000.56284.stgit@bill>
User-Agent: StGIT/0.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49702>

Don't rely on cached metadata in the "applied" and "unapplied" files
to tell which patches are applied. Instead, consider the patches
reachable from the branch head to be applied, and the rest unapplied.

The order of the applied patches is also taken from the DAG, but we
can't do that for the unapplied patches. So the patch order is saved
to a file whenever it changes, and that file is consulted whenever we
need to compute the order of the unapplied patches.

The point of this excercise is to let users do things such as "git
reset" without confusing stgit. This gives incrased flexibility to
power users, and increased safety to other users. The advantages come
from the removal of redundant metadata: it is no longer possible for
StGIT's appliedness status to get out of sync with the underlying git
commit DAG.

This is how the appliedness and order is computed:

  * First, a single call to git-show-ref gives the hashes of all
    patches and the branch head.

  * Then, "git-rev-list patch1 patch2 patch3 ^branch" lists a small
    set of hashes that contains all the unapplied patches and none of
    the applied patches.

  * Last, "git-rev-list head" lists all commits in the branch. The
    applied patches are listed in the correct order.

This is efficient because none of the two rev-list calls need to look
at more than a small part of the DAG. The first call returns a small
set of commits, and the last call is abandoned before it has time to
look far back in the DAG.

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>
---

 stgit/commands/commit.py  |    8 -
 stgit/commands/float.py   |    2=20
 stgit/commands/imprt.py   |    2=20
 stgit/commands/refresh.py |    2=20
 stgit/commands/sync.py    |    2=20
 stgit/git.py              |    5 +
 stgit/stack.py            |  333 +++++++++++++++++++++++++++++--------=
--------
 t/t4000-upgrade.sh        |    6 +
 8 files changed, 227 insertions(+), 133 deletions(-)

diff --git a/stgit/commands/commit.py b/stgit/commands/commit.py
index 2b8d7ce..5450112 100644
--- a/stgit/commands/commit.py
+++ b/stgit/commands/commit.py
@@ -52,14 +52,8 @@ def func(parser, options, args):
     if crt_series.get_protected():
         raise CmdException, 'This branch is protected.  Commit is not =
permitted'
=20
-    crt_head =3D git.get_head()
-
     out.start('Committing %d patches' % len(applied))
-
-    crt_series.pop_patch(applied[0])
-    git.switch(crt_head)
-
     for patch in applied:
-        crt_series.delete_patch(patch)
+        crt_series.delete_patch_data(patch)
=20
     out.done()
diff --git a/stgit/commands/float.py b/stgit/commands/float.py
index 0e32f6b..8ba76d5 100644
--- a/stgit/commands/float.py
+++ b/stgit/commands/float.py
@@ -48,7 +48,7 @@ def func(parser, options, args):
     check_head_top_equal()
=20
     unapplied =3D crt_series.get_unapplied()
-    applied =3D crt_series.get_applied()
+    applied =3D list(crt_series.get_applied()) # a copy, since we'll m=
odify it
     all =3D unapplied + applied
=20
     if options.series:
diff --git a/stgit/commands/imprt.py b/stgit/commands/imprt.py
index 0089a8b..b7a34fa 100644
--- a/stgit/commands/imprt.py
+++ b/stgit/commands/imprt.py
@@ -294,7 +294,7 @@ def __create_patch(filename, message, author_name, =
author_email,
         git.apply_patch(diff =3D diff, base =3D git_id(options.base))
     else:
         git.apply_patch(diff =3D diff)
-    crt_series.refresh_patch(edit =3D options.edit,
+    crt_series.refresh_patch(patch, edit =3D options.edit,
                              show_patch =3D options.showpatch)
     out.done()
=20
diff --git a/stgit/commands/refresh.py b/stgit/commands/refresh.py
index 77dcbda..d560951 100644
--- a/stgit/commands/refresh.py
+++ b/stgit/commands/refresh.py
@@ -131,7 +131,7 @@ def func(parser, options, args):
=20
         if autoresolved =3D=3D 'yes':
             resolved_all()
-        crt_series.refresh_patch(files =3D args,
+        crt_series.refresh_patch(patch, files =3D args,
                                  message =3D options.message,
                                  edit =3D options.edit,
                                  show_patch =3D options.showpatch,
diff --git a/stgit/commands/sync.py b/stgit/commands/sync.py
index 8359061..a42eeac 100644
--- a/stgit/commands/sync.py
+++ b/stgit/commands/sync.py
@@ -161,7 +161,7 @@ def func(parser, options, args):
         if git.local_changes(verbose =3D False):
             # index (cache) already updated by the git merge. The
             # backup information was already reset above
-            crt_series.refresh_patch(cache_update =3D False, backup =3D=
 False,
+            crt_series.refresh_patch(p, cache_update =3D False, backup=
 =3D False,
                                      log =3D 'sync')
             out.done('updated')
         else:
diff --git a/stgit/git.py b/stgit/git.py
index 845c712..703425b 100644
--- a/stgit/git.py
+++ b/stgit/git.py
@@ -189,8 +189,11 @@ def _output_one_line(cmd, file_desc =3D None):
                                                 p.childerr.read().stri=
p())
     return output
=20
-def _output_lines(cmd):
+def _output_lines(cmd, input =3D []):
     p=3Dpopen2.Popen3(cmd, True)
+    for line in input:
+        p.tochild.write(line)
+    p.tochild.close()
     lines =3D p.fromchild.readlines()
     if p.wait():
         raise GitException, '%s failed (%s)' % (str(cmd),
diff --git a/stgit/stack.py b/stgit/stack.py
index 0a486bd..e622f68 100644
--- a/stgit/stack.py
+++ b/stgit/stack.py
@@ -18,12 +18,13 @@ along with this program; if not, write to the Free =
Software
 Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 US=
A
 """
=20
-import sys, os, re
+import sys, os, popen2, re
=20
 from stgit.utils import *
 from stgit import git, basedir, templates
 from stgit.config import config
 from shutil import copyfile
+from sets import Set
=20
=20
 # stack exception class
@@ -274,7 +275,7 @@ class Patch(StgitObject):
         self.__update_log_ref(value)
=20
 # The current StGIT metadata format version.
-FORMAT_VERSION =3D 2
+FORMAT_VERSION =3D 3
=20
 def format_version_key(branch):
     return 'branch.%s.stgitformatversion' % branch
@@ -343,11 +344,173 @@ def update_to_current_format_version(branch, git=
_dir):
         rm(os.path.join(git_dir, 'refs', 'bases', branch))
         set_format_version(2)
=20
+    # Update 2 -> 3.
+    if get_format_version() =3D=3D 2:
+        patchorder =3D file(os.path.join(branch_dir, 'patchorder'), 'w=
')
+        for pf in ['applied', 'unapplied']:
+            pfn =3D os.path.join(branch_dir, pf)
+            if not os.path.isfile(pfn):
+                continue
+            for line in file(pfn):
+                line =3D line.strip()
+                if line:
+                    patchorder.write(line + '\n')
+            rm(pfn)
+        patchorder.close()
+        set_format_version(3)
+
     # Make sure we're at the latest version.
     if not get_format_version() in [None, FORMAT_VERSION]:
         raise StackException('Branch %s is at format version %d, expec=
ted %d'
                              % (branch, get_format_version(), FORMAT_V=
ERSION))
=20
+class PatchorderCache:
+    """An object that keeps track of the patch order for a series, as
+    saved in its patchorder file."""
+    def __init__(self, series):
+        self.__series =3D series
+        self.__invalidate()
+    def __invalidate(self):
+        self.__patchnames =3D None
+        self.__position =3D None
+    def __cache(self):
+        if self.__patchnames !=3D None:
+            return # already cached
+
+        self.__patchnames =3D []
+        self.__position =3D {}
+        pof =3D os.path.join(self.__series._dir(), 'patchorder')
+        if os.path.isfile(pof):
+            for line in file(pof):
+                name =3D line.strip()
+                assert not name in self.__position
+                self.__position[name] =3D len(self.__patchnames)
+                self.__patchnames.append(name)
+    def set_patchorder(self, new_order):
+        self.__invalidate()
+        f =3D file(os.path.join(self.__series._dir(), 'patchorder'), '=
w')
+        for name in new_order:
+            f.write('%s\n' % name)
+        f.close()
+    def cmp(self, name1, name2):
+        """Compare two patch names to see which patch comes first. If
+        both patches are listed in the patchorder file, sort them by
+        the order they appear there; if one is listed and the other
+        not, the listed patch goes first; and if neither is listed,
+        sort them by their names."""
+        self.__cache()
+        largepos =3D len(self.__patchnames)
+        pos1 =3D self.__position.get(name1, largepos)
+        pos2 =3D self.__position.get(name2, largepos)
+        return cmp((pos1, name1), (pos2, name2))
+
+def read_refs(branch):
+    """Return a mapping from patches and branch head to hashes for a
+    given branch. The patches are listed by name; the branch head is
+    None."""
+    refs =3D {}
+    patchpat =3D re.compile(r'^refs/patches/%s/([^\.]+)$' % branch)
+    for line in git._output_lines('git-show-ref'):
+        sha1, ref =3D line.split()
+        m =3D re.match(patchpat, ref)
+        if m:
+            refs[m.group(1)] =3D sha1
+        elif ref =3D=3D 'refs/heads/%s' % branch:
+            refs[None] =3D sha1
+    return refs
+
+def unapplied_patches(ref2hash):
+    """Given a map of patch names (and the branch head, keyed by None)
+    to hashes, return the set of unapplied patches."""
+    hash2refs =3D {}
+    for r, h in ref2hash.iteritems():
+        hash2refs.setdefault(h, Set()).add(r)
+
+    unapplied =3D Set()
+    for line in git._output_lines(
+        'git-rev-list --stdin',
+        ('%s%s\n' % (['', '^'][ref =3D=3D None], sha1)
+         for ref, sha1 in ref2hash.iteritems())):
+        for ref in hash2refs.get(line.strip(), []):
+            unapplied.add(ref)
+    return unapplied
+
+def sort_applied_patches(ref2hash):
+    """Given a map of patch names (and the branch head, keyed by None)
+    to hashes, return a list with the applied patches in stack order.
+    All patches in the map must be applied."""
+    hash2refs =3D {}
+    for r, h in ref2hash.iteritems():
+        if r !=3D None:
+            hash2refs.setdefault(h, Set()).add(r)
+
+    missing =3D Set(ref for ref in ref2hash.iterkeys() if ref !=3D Non=
e)
+    if not missing:
+        return []
+    applied =3D []
+    grl =3D popen2.Popen3('git-rev-list %s' % ref2hash[None], True)
+    for line in grl.fromchild:
+        for ref in hash2refs.get(line.strip(), []):
+            applied.append(ref)
+            missing.remove(ref)
+        if not missing:
+            applied.reverse()
+            return applied
+
+    raise StackException, 'Could not find patches: %s' % ', '.join(mis=
sing)
+
+class AppliedCache:
+    """An object that keeps track of the appliedness and order of the
+    patches in a patch series."""
+    def __init__(self, series):
+        self.__series =3D series
+        self.__order =3D PatchorderCache(series)
+        self.__invalidate()
+    def get_applied(self):
+        self.__cache()
+        return self.__applied
+    def get_unapplied(self):
+        self.__cache()
+        return self.__unapplied
+    def rename(self, oldname, newname):
+        """Rename a patch."""
+        self.__cache()
+        for lst in (self.__applied, self.__unapplied):
+            try:
+                lst[lst.index(oldname)] =3D newname
+            except ValueError:
+                pass # lst.index() couldn't find the index
+            else:
+                self.__write_patchorder()
+                return
+        raise StackException, 'Unknown patch "%s"' % oldname
+    def __write_patchorder(self):
+        self.__order.set_patchorder(self.get_applied() + self.get_unap=
plied())
+    def set_patchorder(self, new_order):
+        self.__order.set_patchorder(new_order)
+        self.refresh()
+    def refresh(self):
+        """Re-read patch appliedness info, and write patch order to
+        disk."""
+        self.__invalidate()
+        self.__write_patchorder()
+    def __invalidate(self):
+        self.__applied =3D None
+        self.__unapplied =3D None
+    def __cached(self):
+        return (self.__applied !=3D None)
+    def __cache(self):
+        if self.__cached():
+            return
+        patches =3D read_refs(self.__series.get_branch())
+        unapplied =3D unapplied_patches(patches)
+        for patch in unapplied:
+            del patches[patch]
+        self.__applied =3D sort_applied_patches(patches)
+        self.__unapplied =3D list(unapplied)
+        self.__unapplied.sort(self.__order.cmp)
+
+
 class Series(StgitObject):
     """Class including the operations on series
     """
@@ -372,8 +535,6 @@ class Series(StgitObject):
         self.__refs_dir =3D os.path.join(self.__base_dir, 'refs', 'pat=
ches',
                                        self.__name)
=20
-        self.__applied_file =3D os.path.join(self._dir(), 'applied')
-        self.__unapplied_file =3D os.path.join(self._dir(), 'unapplied=
')
         self.__hidden_file =3D os.path.join(self._dir(), 'hidden')
=20
         # where this series keeps its patches
@@ -382,6 +543,8 @@ class Series(StgitObject):
         # trash directory
         self.__trash_dir =3D os.path.join(self._dir(), 'trash')
=20
+        self.__applied_cache =3D AppliedCache(self)
+
     def __patch_name_valid(self, name):
         """Raise an exception if the patch name is not valid.
         """
@@ -409,11 +572,7 @@ class Series(StgitObject):
     def get_current(self):
         """Return the name of the topmost patch, or None if there is
         no such patch."""
-        try:
-            applied =3D self.get_applied()
-        except StackException:
-            # No "applied" file: branch is not initialized.
-            return None
+        applied =3D self.get_applied()
         try:
             return applied[-1]
         except IndexError:
@@ -421,20 +580,10 @@ class Series(StgitObject):
             return None
=20
     def get_applied(self):
-        if not os.path.isfile(self.__applied_file):
-            raise StackException, 'Branch "%s" not initialised' % self=
=2E__name
-        f =3D file(self.__applied_file)
-        names =3D [line.strip() for line in f.readlines()]
-        f.close()
-        return names
+        return self.__applied_cache.get_applied()
=20
     def get_unapplied(self):
-        if not os.path.isfile(self.__unapplied_file):
-            raise StackException, 'Branch "%s" not initialised' % self=
=2E__name
-        f =3D file(self.__unapplied_file)
-        names =3D [line.strip() for line in f.readlines()]
-        f.close()
-        return names
+        return self.__applied_cache.get_unapplied()
=20
     def get_hidden(self):
         if not os.path.isfile(self.__hidden_file):
@@ -446,12 +595,12 @@ class Series(StgitObject):
=20
     def get_base(self):
         # Return the parent of the bottommost patch, if there is one.
-        if os.path.isfile(self.__applied_file):
-            bottommost =3D file(self.__applied_file).readline().strip(=
)
-            if bottommost:
-                return self.get_patch(bottommost).get_bottom()
-        # No bottommost patch, so just return HEAD
-        return git.get_head()
+        applied =3D self.get_applied()
+        if applied:
+            return self.get_patch(applied[0]).get_bottom()
+        else:
+            # No bottommost patch, so just return HEAD
+            return git.get_head()
=20
     def get_head(self):
         """Return the head of the branch
@@ -585,8 +734,6 @@ class Series(StgitObject):
=20
         self.set_parent(parent_remote, parent_branch)
=20
-        self.create_empty_field('applied')
-        self.create_empty_field('unapplied')
         os.makedirs(self.__refs_dir)
         self._set_field('orig-base', git.get_head())
=20
@@ -687,10 +834,6 @@ class Series(StgitObject):
=20
             # FIXME: find a way to get rid of those manual removals
             # (move functionality to StgitObject ?)
-            if os.path.exists(self.__applied_file):
-                os.remove(self.__applied_file)
-            if os.path.exists(self.__unapplied_file):
-                os.remove(self.__unapplied_file)
             if os.path.exists(self.__hidden_file):
                 os.remove(self.__hidden_file)
             if os.path.exists(self._dir()+'/orig-base'):
@@ -719,7 +862,7 @@ class Series(StgitObject):
         config.unset('branch.%s.merge' % self.__name)
         config.unset('branch.%s.stgit.parentbranch' % self.__name)
=20
-    def refresh_patch(self, files =3D None, message =3D None, edit =3D=
 False,
+    def refresh_patch(self, name, files =3D None, message =3D None, ed=
it =3D False,
                       show_patch =3D False,
                       cache_update =3D True,
                       author_name =3D None, author_email =3D None,
@@ -728,10 +871,6 @@ class Series(StgitObject):
                       backup =3D False, sign_str =3D None, log =3D 're=
fresh'):
         """Generates a new commit for the given patch
         """
-        name =3D self.get_current()
-        if not name:
-            raise StackException, 'No patches applied'
-
         patch =3D self.get_patch(name)
=20
         descr =3D patch.get_description()
@@ -821,9 +960,10 @@ class Series(StgitObject):
         """Creates a new patch
         """
=20
+        appl, unappl =3D self.get_applied(), self.get_unapplied()
         if name !=3D None:
             self.__patch_name_valid(name)
-            if self.patch_applied(name) or self.patch_unapplied(name):
+            if name in appl or name in unappl:
                 raise StackException, 'Patch "%s" already exists' % na=
me
=20
         if not message and can_edit:
@@ -860,20 +1000,29 @@ class Series(StgitObject):
=20
         if unapplied:
             self.log_patch(patch, 'new')
-
-            patches =3D [patch.get_name()] + self.get_unapplied()
-
-            f =3D file(self.__unapplied_file, 'w+')
-            f.writelines([line + '\n' for line in patches])
-            f.close()
+            order =3D appl + [patch.get_name()] + unappl
         elif before_existing:
             self.log_patch(patch, 'new')
-
-            insert_string(self.__applied_file, patch.get_name())
+            order =3D [patch.get_name()] + appl + unappl
         else:
-            append_string(self.__applied_file, patch.get_name())
+            order =3D appl + [patch.get_name()] + unappl
             if refresh:
-                self.refresh_patch(cache_update =3D False, log =3D 'ne=
w')
+                self.refresh_patch(name, cache_update =3D False, log =3D=
 'new')
+        self.__applied_cache.set_patchorder(order)
+
+        return patch
+
+
+    def delete_patch_data(self, name):
+        """Deletes the stgit data for a patch."""
+        patch =3D Patch(name, self.__patch_dir, self.__refs_dir)
+
+        # save the commit id to a trash file
+        write_string(os.path.join(self.__trash_dir, name), patch.get_t=
op())
+
+        patch.delete()
+        if self.patch_hidden(name):
+            self.unhide_patch(name)
=20
         return patch
=20
@@ -881,9 +1030,8 @@ class Series(StgitObject):
         """Deletes a patch
         """
         self.__patch_name_valid(name)
-        patch =3D Patch(name, self.__patch_dir, self.__refs_dir)
=20
-        if self.__patch_is_current(patch):
+        if self.get_current() =3D=3D name:
             self.pop_patch(name)
         elif self.patch_applied(name):
             raise StackException, 'Cannot remove an applied patch, "%s=
", ' \
@@ -891,19 +1039,8 @@ class Series(StgitObject):
         elif not name in self.get_unapplied():
             raise StackException, 'Unknown patch "%s"' % name
=20
-        # save the commit id to a trash file
-        write_string(os.path.join(self.__trash_dir, name), patch.get_t=
op())
-
-        patch.delete()
-
-        unapplied =3D self.get_unapplied()
-        unapplied.remove(name)
-        f =3D file(self.__unapplied_file, 'w+')
-        f.writelines([line + '\n' for line in unapplied])
-        f.close()
-
-        if self.patch_hidden(name):
-            self.unhide_patch(name)
+        self.delete_patch_data(name)
+        self.__applied_cache.refresh()
=20
     def forward_patches(self, names):
         """Try to fast-forward an array of patches.
@@ -967,19 +1104,12 @@ class Series(StgitObject):
                     break
=20
             forwarded+=3D1
-            unapplied.remove(name)
=20
         if forwarded =3D=3D 0:
             return 0
=20
         git.switch(top)
-
-        append_strings(self.__applied_file, names[0:forwarded])
-
-        f =3D file(self.__unapplied_file, 'w+')
-        f.writelines([line + '\n' for line in unapplied])
-        f.close()
-
+        self.__applied_cache.refresh()
         return forwarded
=20
     def merged_patches(self, names):
@@ -1052,13 +1182,6 @@ class Series(StgitObject):
                               'Use "refresh" after fixing the conflict=
s or'
                               ' revert the operation with "push --undo=
".')
=20
-        append_string(self.__applied_file, name)
-
-        unapplied.remove(name)
-        f =3D file(self.__unapplied_file, 'w+')
-        f.writelines([line + '\n' for line in unapplied])
-        f.close()
-
         # head =3D=3D bottom case doesn't need to refresh the patch
         if empty or head !=3D bottom:
             if not ex:
@@ -1068,15 +1191,17 @@ class Series(StgitObject):
                     log =3D 'push(m)'
                 else:
                     log =3D 'push'
-                self.refresh_patch(cache_update =3D False, log =3D log=
)
+                self.refresh_patch(name, cache_update =3D False, log =3D=
 log)
             else:
                 # we store the correctly merged files only for
                 # tracking the conflict history. Note that the
                 # git.merge() operations should always leave the index
                 # in a valid state (i.e. only stage 0 files)
-                self.refresh_patch(cache_update =3D False, log =3D 'pu=
sh(c)')
+                self.refresh_patch(name, cache_update =3D False, log =3D=
 'push(c)')
                 raise StackException, str(ex)
=20
+        self.__applied_cache.refresh()
+
         return modified
=20
     def undo_push(self):
@@ -1105,10 +1230,7 @@ class Series(StgitObject):
     def pop_patch(self, name, keep =3D False):
         """Pops the top patch from the stack
         """
-        applied =3D self.get_applied()
-        applied.reverse()
-        assert(name in applied)
-
+        assert(name in self.get_applied())
         patch =3D self.get_patch(name)
=20
         if git.get_head_file() =3D=3D self.get_branch():
@@ -1118,24 +1240,7 @@ class Series(StgitObject):
             git.switch(patch.get_bottom(), keep)
         else:
             git.set_branch(self.get_branch(), patch.get_bottom())
-
-        # save the new applied list
-        idx =3D applied.index(name) + 1
-
-        popped =3D applied[:idx]
-        popped.reverse()
-        unapplied =3D popped + self.get_unapplied()
-
-        f =3D file(self.__unapplied_file, 'w+')
-        f.writelines([line + '\n' for line in unapplied])
-        f.close()
-
-        del applied[:idx]
-        applied.reverse()
-
-        f =3D file(self.__applied_file, 'w+')
-        f.writelines([line + '\n' for line in applied])
-        f.close()
+        self.__applied_cache.refresh()
=20
     def empty_patch(self, name):
         """Returns True if the patch is empty
@@ -1161,7 +1266,8 @@ class Series(StgitObject):
=20
         if oldname =3D=3D newname:
             raise StackException, '"To" name and "from" name are the s=
ame'
-
+        if oldname in applied or oldname in unapplied:
+            raise StackException, 'Unknown patch "%s"' % oldname
         if newname in applied or newname in unapplied:
             raise StackException, 'Patch "%s" already exists' % newnam=
e
=20
@@ -1169,23 +1275,8 @@ class Series(StgitObject):
             self.unhide_patch(oldname)
             self.hide_patch(newname)
=20
-        if oldname in unapplied:
-            self.get_patch(oldname).rename(newname)
-            unapplied[unapplied.index(oldname)] =3D newname
-
-            f =3D file(self.__unapplied_file, 'w+')
-            f.writelines([line + '\n' for line in unapplied])
-            f.close()
-        elif oldname in applied:
-            self.get_patch(oldname).rename(newname)
-
-            applied[applied.index(oldname)] =3D newname
-
-            f =3D file(self.__applied_file, 'w+')
-            f.writelines([line + '\n' for line in applied])
-            f.close()
-        else:
-            raise StackException, 'Unknown patch "%s"' % oldname
+        self.get_patch(oldname).rename(newname)
+        self.__applied_cache.rename(oldname, newname)
=20
     def log_patch(self, patch, message):
         """Generate a log commit for a patch
diff --git a/t/t4000-upgrade.sh b/t/t4000-upgrade.sh
index 8a308fb..01be50d 100755
--- a/t/t4000-upgrade.sh
+++ b/t/t4000-upgrade.sh
@@ -34,6 +34,12 @@ for ver in 0.12 0.8; do
         ! git show-ref --verify --quiet refs/bases/master
     '
=20
+    test_expect_success \
+        "v$ver: Make sure the applied and unapplied files are gone" '
+        [ ! -e .git/patches/master/applied ] &&
+        [ ! -e .git/patches/master/unapplied ]
+'
+
     cd ..
 done
=20
