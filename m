From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH 1/2] Convert "stg refresh" to the new infrastructure
Date: Wed, 25 Jun 2008 06:30:15 +0200
Message-ID: <20080625042337.6044.53357.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 25 06:31:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBMfF-0000DB-I9
	for gcvg-git-2@gmane.org; Wed, 25 Jun 2008 06:31:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752012AbYFYEa2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 Jun 2008 00:30:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751893AbYFYEa2
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Jun 2008 00:30:28 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3568 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751250AbYFYEa0 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jun 2008 00:30:26 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1KBMeB-0006Jx-00; Wed, 25 Jun 2008 05:30:19 +0100
User-Agent: StGIT/0.14.2.171.g5c0d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86219>

And in the process, make it more powerful: it will now first create a
temp patch containing the updates, and then try to merge it into the
patch to be updated. If that patch is applied, this is done by
popping, pushing, and coalescing; if it is unapplied, it is done with
an in-index merge.

The temp patch creation and merging is logged in two separate stages,
so that the user can undo them separately.

Also, whenever path limiting is used, we will now use a temporary
index in order to avoid including all staged updates (since they may
touch stuff outside the path limiters).

Support for the --force, --undo, and --annotate flags were dropped.

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

I've been working on this for some time -- it turned out to be bigger
than I'd thought. What do you think (especially about the double
logging that enables undoing)?

This was the last step before I was planning to remove the --undo
flags from everywhere. But I think I'll look over the log format first
(unless you want to do it -- in case we should get all this stuff
committed to a public non-rebasing development branch, since rebasing
gets really confusing when more than one person is working on things).

 stgit/commands/refresh.py |  316 +++++++++++++++++++++++++++++--------=
--------
 stgit/lib/git.py          |   62 ++++++++-
 stgit/lib/stack.py        |    9 +
 stgit/lib/transaction.py  |   11 +-
 t/t3100-reset.sh          |    2=20
 5 files changed, 275 insertions(+), 125 deletions(-)


diff --git a/stgit/commands/refresh.py b/stgit/commands/refresh.py
index 4695c62..7afc55e 100644
--- a/stgit/commands/refresh.py
+++ b/stgit/commands/refresh.py
@@ -1,6 +1,8 @@
+# -*- coding: utf-8 -*-
=20
 __copyright__ =3D """
 Copyright (C) 2005, Catalin Marinas <catalin.marinas@gmail.com>
+Copyright (C) 2008, Karl Hasselstr=C3=B6m <kha@treskal.com>
=20
 This program is free software; you can redistribute it and/or modify
 it under the terms of the GNU General Public License version 2 as
@@ -16,125 +18,209 @@ along with this program; if not, write to the Fre=
e Software
 Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 US=
A
 """
=20
-import sys, os
-from optparse import OptionParser, make_option
-
-from stgit.commands.common import *
-from stgit.utils import *
-from stgit.out import *
-from stgit import stack, git
-from stgit.config import config
-
+from optparse import make_option
+from stgit.commands import common
+from stgit.lib import git, transaction
+from stgit import utils
=20
 help =3D 'generate a new commit for the current patch'
 usage =3D """%prog [options] [<files or dirs>]
=20
-Include the latest tree changes in the current patch. This command
-generates a new GIT commit object with the patch details, the previous
-one no longer being visible. The '--force' option is useful
-when a commit object was created with a different tool
-but the changes need to be included in the current patch."""
-
-directory =3D DirectoryHasRepository()
-options =3D [make_option('-f', '--force',
-                       help =3D 'force the refresh even if HEAD and '\
-                       'top differ',
-                       action =3D 'store_true'),
-           make_option('--update',
-                       help =3D 'only update the current patch files',
-                       action =3D 'store_true'),
-           make_option('--index',
-                       help =3D 'use the current contents of the index=
 instead of looking at the working directory',
-                       action =3D 'store_true'),
-           make_option('--undo',
-                       help =3D 'revert the commit generated by the la=
st refresh',
-                       action =3D 'store_true'),
-           make_option('-a', '--annotate', metavar =3D 'NOTE',
-                       help =3D 'annotate the patch log entry'),
+Include the latest work tree and index changes in the current patch.
+This command generates a new git commit object for the patch; the old
+commit is no longer visible.
+
+You may optionally list one or more files or directories relative to
+the current working directory; if you do, only matching files will be
+updated.
+
+Behind the scenes, stg refresh first creates a new temporary patch
+with your updates, and then merges that patch into the patch you asked
+to have refreshed. If you asked to refresh a patch other than the
+topmost patch, there can be conflicts; in that case, the temporary
+patch will be left for you to take care of, for example with stg
+coalesce.
+
+The creation of the temporary patch is recorded in a separate entry in
+the patch stack log; this means that one undo step will undo the merge
+between the other patch and the temp patch, and two undo steps will
+additionally get rid of the temp patch."""
+
+directory =3D common.DirectoryHasRepositoryLib()
+options =3D [make_option('-u', '--update', action =3D 'store_true',
+                       help =3D 'only update the current patch files')=
,
+           make_option('-i', '--index', action =3D 'store_true',
+                       help =3D ('only include changes from the index,=
 not'
+                               ' from the work tree')),
            make_option('-p', '--patch',
-                       help =3D 'refresh (applied) PATCH instead of th=
e top one')
-           ]
-
-def func(parser, options, args):
-    """Generate a new commit for the current or given patch.
-    """
-    args =3D git.ls_files(args)
-    directory.cd_to_topdir()
-
-    autoresolved =3D config.get('stgit.autoresolved')
-    if autoresolved !=3D 'yes':
-        check_conflicts()
-
-    if options.patch:
-        if args or options.update:
-            raise CmdException, \
-                  'Only full refresh is available with the --patch opt=
ion'
-        patch =3D options.patch
-        if not crt_series.patch_applied(patch):
-            raise CmdException, 'Patches "%s" not applied' % patch
+                       help =3D 'refresh PATCH instead of the topmost =
patch')]
+
+def get_patch(stack, given_patch):
+    """Get the name of the patch we are to refresh."""
+    if given_patch:
+        patch_name =3D given_patch
+        if not stack.patches.exists(patch_name):
+            raise common.CmdException('%s: no such patch' % patch_name=
)
+        return patch_name
     else:
-        patch =3D crt_series.get_current()
-        if not patch:
-            raise CmdException, 'No patches applied'
-
-    if options.index:
-        if args or options.update:
-            raise CmdException, \
-                  'Only full refresh is available with the --index opt=
ion'
-        if options.patch:
-            raise CmdException, \
-                  '--patch is not compatible with the --index option'
-
-    if not options.force:
-        check_head_top_equal(crt_series)
-
-    if options.undo:
-        out.start('Undoing the refresh of "%s"' % patch)
-        crt_series.undo_refresh()
-        out.done()
-        return
-
-    if not options.index:
-        files =3D [path for (stat, path) in git.tree_status(files =3D =
args, verbose =3D True)]
-
-    if options.index or files or not crt_series.head_top_equal():
-        if options.patch:
-            applied =3D crt_series.get_applied()
-            between =3D applied[:applied.index(patch):-1]
-            pop_patches(crt_series, between, keep =3D True)
-        elif options.update:
-            rev1 =3D git_id(crt_series, '//bottom')
-            rev2 =3D git_id(crt_series, '//top')
-            patch_files =3D git.barefiles(rev1, rev2).split('\n')
-            files =3D [f for f in files if f in patch_files]
-            if not files:
-                out.info('No modified files for updating patch "%s"' %=
 patch)
-                return
-
-        out.start('Refreshing patch "%s"' % patch)
-
-        if autoresolved =3D=3D 'yes':
-            resolved_all()
-
-        if options.index:
-            crt_series.refresh_patch(cache_update =3D False,
-                                     backup =3D True, notes =3D option=
s.annotate)
-        else:
-            crt_series.refresh_patch(files =3D files,
-                                     backup =3D True, notes =3D option=
s.annotate)
-
-        if crt_series.empty_patch(patch):
-            out.done('empty patch')
-        else:
-            out.done()
-
-        if options.patch:
-            between.reverse()
-            push_patches(crt_series, between)
-    elif options.annotate:
-        # only annotate the top log entry as there is no need to
-        # refresh the patch and generate a full commit
-        crt_series.log_patch(crt_series.get_patch(patch), None,
-                             notes =3D options.annotate)
+        if not stack.patchorder.applied:
+            raise common.CmdException(
+                'Cannot refresh top patch, because no patches are appl=
ied')
+        return stack.patchorder.applied[-1]
+
+def list_files(stack, patch_name, args, index, update):
+    """Figure out which files to update."""
+    if index:
+        # --index: Don't update the index.
+        return set()
+    paths =3D stack.repository.default_iw.changed_files(
+        stack.head.data.tree, args or [])
+    if update:
+        # --update: Restrict update to the paths that were already
+        # part of the patch.
+        paths &=3D stack.patches.get(patch_name).files()
+    return paths
+
+def write_tree(stack, paths, temp_index):
+    """Possibly update the index, and then write its tree.
+    @return: The written tree.
+    @rtype: L{Tree<stgit.git.Tree>}"""
+    def go(index):
+        if paths:
+            iw =3D git.IndexAndWorktree(index, stack.repository.defaul=
t_worktree)
+            iw.update_index(paths)
+        return index.write_tree()
+    if temp_index:
+        index =3D stack.repository.temp_index()
+        try:
+            index.read_tree(stack.head)
+            return go(index)
+        finally:
+            index.delete()
+            stack.repository.default_iw.update_index(paths)
     else:
-        out.info('Patch "%s" is already up to date' % patch)
+        return go(stack.repository.default_index)
+
+def make_temp_patch(stack, patch_name, paths, temp_index):
+    """Commit index to temp patch, in a complete transaction. If any p=
ath
+    limiting is in effect, use a temp index."""
+    tree =3D write_tree(stack, paths, temp_index)
+    commit =3D stack.repository.commit(git.CommitData(
+            tree =3D tree, parents =3D [stack.head],
+            message =3D 'Refresh of %s' % patch_name))
+    temp_name =3D utils.make_patch_name('refresh-temp', stack.patches.=
exists)
+    trans =3D transaction.StackTransaction(stack,
+                                         'refresh (create temporary pa=
tch)')
+    trans.patches[temp_name] =3D commit
+    trans.applied.append(temp_name)
+    return trans.run(stack.repository.default_iw,
+                     print_current_patch =3D False), temp_name
+
+def absorb_applied(trans, iw, patch_name, temp_name):
+    """Absorb the temp patch (C{temp_name}) into the given patch
+    (C{patch_name}), which must be applied.
+
+    @return: C{True} if we managed to absorb the temp patch, C{False}
+             if we had to leave it for the user to deal with."""
+    temp_absorbed =3D False
+    try:
+        # Pop any patch on top of the patch we're refreshing.
+        to_pop =3D trans.applied[trans.applied.index(patch_name)+1:]
+        if len(to_pop) > 1:
+            popped =3D trans.pop_patches(lambda pn: pn in to_pop)
+            assert not popped # no other patches were popped
+            trans.push_patch(temp_name, iw)
+        assert to_pop.pop() =3D=3D temp_name
+
+        # Absorb the temp patch.
+        temp_cd =3D trans.patches[temp_name].data
+        assert trans.patches[patch_name] =3D=3D temp_cd.parent
+        trans.patches[patch_name] =3D trans.stack.repository.commit(
+            trans.patches[patch_name].data.set_tree(temp_cd.tree))
+        popped =3D trans.delete_patches(lambda pn: pn =3D=3D temp_name=
, quiet =3D True)
+        assert not popped # the temp patch was topmost
+        temp_absorbed =3D True
+
+        # Push back any patch we were forced to pop earlier.
+        for pn in to_pop:
+            trans.push_patch(pn, iw)
+    except transaction.TransactionHalted:
+        pass
+    return temp_absorbed
+
+def absorb_unapplied(trans, iw, patch_name, temp_name):
+    """Absorb the temp patch (C{temp_name}) into the given patch
+    (C{patch_name}), which must be unapplied.
+
+    @param iw: Not used.
+    @return: C{True} if we managed to absorb the temp patch, C{False}
+             if we had to leave it for the user to deal with."""
+
+    # Pop the temp patch.
+    popped =3D trans.pop_patches(lambda pn: pn =3D=3D temp_name)
+    assert not popped # the temp patch was topmost
+
+    # Try to create the new tree of the refreshed patch. (This is the
+    # same operation as pushing the temp patch onto the patch we're
+    # trying to refresh -- but we don't have a worktree to spill
+    # conflicts to, so if the simple merge doesn't succeed, we have to
+    # give up.)
+    patch_cd =3D trans.patches[patch_name].data
+    temp_cd =3D trans.patches[temp_name].data
+    new_tree =3D trans.stack.repository.simple_merge(
+        base =3D temp_cd.parent.data.tree,
+        ours =3D patch_cd.tree, theirs =3D temp_cd.tree)
+    if new_tree:
+        # It worked. Refresh the patch with the new tree, and delete
+        # the temp patch.
+        trans.patches[patch_name] =3D trans.stack.repository.commit(
+            patch_cd.set_tree(new_tree))
+        popped =3D trans.delete_patches(lambda pn: pn =3D=3D temp_name=
, quiet =3D True)
+        assert not popped # the temp patch was not applied
+        return True
+    else:
+        # Nope, we couldn't create the new tree, so we'll just have to
+        # leave the temp patch for the user.
+        return False
+
+def absorb(stack, patch_name, temp_name):
+    """Absorb the temp patch into the target patch."""
+    trans =3D transaction.StackTransaction(stack, 'refresh')
+    iw =3D stack.repository.default_iw
+    f =3D { True: absorb_applied, False: absorb_unapplied
+          }[patch_name in trans.applied]
+    if f(trans, iw, patch_name, temp_name):
+        def info_msg(): pass
+    else:
+        def info_msg():
+            out.warn('The new changes did not apply cleanly to %s.'
+                     % patch_name, 'They were saved in %s.' % temp_nam=
e)
+    r =3D trans.run(iw)
+    info_msg()
+    return r
+
+def func(parser, options, args):
+    """Generate a new commit for the current or given patch."""
+
+    # Catch illegal argument combinations.
+    path_limiting =3D bool(args or options.update)
+    if options.index and path_limiting:
+        raise common.CmdException(
+            'Only full refresh is available with the --index option')
+
+    stack =3D directory.repository.current_stack
+    patch_name =3D get_patch(stack, options.patch)
+    paths =3D list_files(stack, patch_name, args, options.index, optio=
ns.update)
+
+    # Make sure there are no conflicts in the files we want to
+    # refresh.
+    if stack.repository.default_index.conflicts() & paths:
+        raise common.CmdException(
+            'Cannot refresh -- resolve conflicts first')
+
+    # Commit index to temp patch, and absorb it into the target patch.
+    retval, temp_name =3D make_temp_patch(
+        stack, patch_name, paths, temp_index =3D path_limiting)
+    if retval !=3D utils.STGIT_SUCCESS:
+        return retval
+    return absorb(stack, patch_name, temp_name)
diff --git a/stgit/lib/git.py b/stgit/lib/git.py
index 4c2605b..2aecf10 100644
--- a/stgit/lib/git.py
+++ b/stgit/lib/git.py
@@ -511,6 +511,14 @@ class RunWithEnvCwd(RunWithEnv):
         @type env: dict
         @param env: Extra environment"""
         return RunWithEnv.run(self, args, env).cwd(self.cwd)
+    def run_in_cwd(self, args):
+        """Run the given command with an environment given by self.env=
 and
+        self.env_in_cwd, without changing the current working
+        directory.
+
+        @type args: list of strings
+        @param args: Command and argument vector"""
+        return RunWithEnv.run(self, args, self.env_in_cwd)
=20
 class Repository(RunWithEnv):
     """Represents a git repository."""
@@ -655,6 +663,32 @@ class Repository(RunWithEnv):
         assert isinstance(t2, Tree)
         return self.run(['git', 'diff-tree', '-p'] + list(diff_opts)
                         + [t1.sha1, t2.sha1]).raw_output()
+    def diff_tree_files(self, t1, t2):
+        """Given two L{Tree}s C{t1} and C{t2}, iterate over all files =
for
+        which they differ. For each file, yield a tuple with the old
+        file mode, the new file mode, the old blob, the new blob, the
+        status, the old filename, and the new filename. Except in case
+        of a copy or a rename, the old and new filenames are
+        identical."""
+        assert isinstance(t1, Tree)
+        assert isinstance(t2, Tree)
+        i =3D iter(self.run(['git', 'diff-tree', '-r', '-z'] + [t1.sha=
1, t2.sha1]
+                          ).raw_output().split('\0'))
+        try:
+            while True:
+                x =3D i.next()
+                if not x:
+                    continue
+                omode, nmode, osha1, nsha1, status =3D x[1:].split(' '=
)
+                fn1 =3D i.next()
+                if status[0] in ['C', 'R']:
+                    fn2 =3D i.next()
+                else:
+                    fn2 =3D fn1
+                yield (omode, nmode, self.get_blob(osha1),
+                       self.get_blob(nsha1), status, fn1, fn2)
+        except StopIteration:
+            pass
=20
 class MergeException(exception.StgException):
     """Exception raised when a merge fails for some reason."""
@@ -678,6 +712,9 @@ class Index(RunWithEnv):
     def read_tree(self, tree):
         self.run(['git', 'read-tree', tree.sha1]).no_output()
     def write_tree(self):
+        """Write the index contents to the repository.
+        @return: The resulting L{Tree}
+        @rtype: L{Tree}"""
         try:
             return self.__repository.get_tree(
                 self.run(['git', 'write-tree']).discard_stderr(
@@ -719,6 +756,7 @@ class Worktree(object):
     def __init__(self, directory):
         self.__directory =3D directory
     env =3D property(lambda self: { 'GIT_WORK_TREE': '.' })
+    env_in_cwd =3D property(lambda self: { 'GIT_WORK_TREE': self.direc=
tory })
     directory =3D property(lambda self: self.__directory)
=20
 class CheckoutException(exception.StgException):
@@ -735,6 +773,7 @@ class IndexAndWorktree(RunWithEnvCwd):
     index =3D property(lambda self: self.__index)
     env =3D property(lambda self: utils.add_dict(self.__index.env,
                                                self.__worktree.env))
+    env_in_cwd =3D property(lambda self: self.__worktree.env_in_cwd)
     cwd =3D property(lambda self: self.__worktree.directory)
     def checkout_hard(self, tree):
         assert isinstance(tree, Tree)
@@ -768,11 +807,24 @@ class IndexAndWorktree(RunWithEnvCwd):
                 raise MergeConflictException()
             else:
                 raise MergeException('Index/worktree dirty')
-    def changed_files(self):
-        return self.run(['git', 'diff-files', '--name-only']).output_l=
ines()
-    def update_index(self, files):
-        self.run(['git', 'update-index', '--remove', '-z', '--stdin']
-                 ).input_nulterm(files).discard_output()
+    def changed_files(self, tree, pathlimits =3D []):
+        """Return the set of files in the worktree that have changed w=
ith
+        respect to C{tree}. The listing is optionally restricted to
+        those files that match any of the path limiters given.
+
+        The path limiters are relative to the current working
+        directory; the returned file names are relative to the
+        repository root."""
+        assert isinstance(tree, Tree)
+        return set(self.run_in_cwd(
+                ['git', 'diff-index', tree.sha1, '--name-only', '-z', =
'--']
+                + list(pathlimits)).raw_output().split('\0')[:-1])
+    def update_index(self, paths):
+        """Update the index with files from the worktree. C{paths} is =
an
+        iterable of paths relative to the root of the repository."""
+        cmd =3D ['git', 'update-index', '--remove']
+        self.run(cmd + ['-z', '--stdin']
+                 ).input_nulterm(paths).discard_output()
=20
 class Branch(object):
     """Represents a Git branch."""
diff --git a/stgit/lib/stack.py b/stgit/lib/stack.py
index 2d686e6..3cf66e7 100644
--- a/stgit/lib/stack.py
+++ b/stgit/lib/stack.py
@@ -86,6 +86,15 @@ class Patch(object):
         return self.name in self.__stack.patchorder.applied
     def is_empty(self):
         return self.commit.data.is_nochange()
+    def files(self):
+        """Return the set of files this patch touches."""
+        fs =3D set()
+        for (_, _, _, _, _, oldname, newname
+             ) in self.__stack.repository.diff_tree_files(
+            self.commit.data.tree, self.commit.data.parent.data.tree):
+            fs.add(oldname)
+            fs.add(newname)
+        return fs
=20
 class PatchOrder(object):
     """Keeps track of patch order, and which patches are applied.
diff --git a/stgit/lib/transaction.py b/stgit/lib/transaction.py
index 0c8d9a5..ac0594d 100644
--- a/stgit/lib/transaction.py
+++ b/stgit/lib/transaction.py
@@ -163,7 +163,8 @@ class StackTransaction(object):
         if iw:
             self.__checkout(self.__stack.head.data.tree, iw,
                             allow_bad_head =3D True)
-    def run(self, iw =3D None, allow_bad_head =3D False):
+    def run(self, iw =3D None, allow_bad_head =3D False,
+            print_current_patch =3D True):
         """Execute the transaction. Will either succeed, or fail (with=
 an
         exception) and do nothing."""
         self.__check_consistency()
@@ -203,7 +204,8 @@ class StackTransaction(object):
             self.__patches =3D _TransPatchMap(self.__stack)
             self.__conflicting_push()
             write(self.__msg + ' (CONFLICT)')
-        _print_current_patch(old_applied, self.__applied)
+        if print_current_patch:
+            _print_current_patch(old_applied, self.__applied)
=20
         if self.__error:
             return utils.STGIT_CONFLICT
@@ -239,7 +241,7 @@ class StackTransaction(object):
         self.__print_popped(popped)
         return popped1
=20
-    def delete_patches(self, p):
+    def delete_patches(self, p, quiet =3D False):
         """Delete all patches pn for which p(pn) is true. Return the l=
ist of
         other patches that had to be popped to accomplish this. Always
         succeeds."""
@@ -257,7 +259,8 @@ class StackTransaction(object):
             if p(pn):
                 s =3D ['', ' (empty)'][self.patches[pn].data.is_nochan=
ge()]
                 self.patches[pn] =3D None
-                out.info('Deleted %s%s' % (pn, s))
+                if not quiet:
+                    out.info('Deleted %s%s' % (pn, s))
         return popped
=20
     def push_patch(self, pn, iw =3D None):
diff --git a/t/t3100-reset.sh b/t/t3100-reset.sh
index 1805091..a721d6d 100755
--- a/t/t3100-reset.sh
+++ b/t/t3100-reset.sh
@@ -142,7 +142,7 @@ cat > expected.txt <<EOF
 222
 EOF
 test_expect_success '... and undo the refresh' '
-    stg reset master.stgit^~1 &&
+    stg reset master.stgit^~2 &&
     test "$(echo $(stg applied))" =3D "p1 p2" &&
     test "$(echo $(stg unapplied))" =3D "" &&
     test_cmp expected.txt a
