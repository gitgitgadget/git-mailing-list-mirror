From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH 07/10] Teach the new infrastructure about the index and
	worktree
Date: Sun, 25 Nov 2007 21:51:40 +0100
Message-ID: <20071125205140.7823.46991.stgit@yoghurt>
References: <20071125203717.7823.70046.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	David =?utf-8?q?K=C3=A5gedal?= <davidk@lysator.liu.se>
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sun Nov 25 21:52:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IwOSv-0003t1-HQ
	for gcvg-git-2@gmane.org; Sun, 25 Nov 2007 21:52:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756673AbXKYUvr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 25 Nov 2007 15:51:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756645AbXKYUvr
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Nov 2007 15:51:47 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3576 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756656AbXKYUvp (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Nov 2007 15:51:45 -0500
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1IwOS4-0007b2-00; Sun, 25 Nov 2007 20:51:40 +0000
In-Reply-To: <20071125203717.7823.70046.stgit@yoghurt>
User-Agent: StGIT/0.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66001>

And use the new powers to make "stg coalesce" able to handle arbitrary
patches, not just consecutive applied patches.

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

 stgit/commands/clean.py    |    4 +
 stgit/commands/coalesce.py |   93 ++++++++++++++++---------
 stgit/lib/git.py           |  123 ++++++++++++++++++++++++++++++++++
 stgit/lib/stack.py         |    7 +-
 stgit/lib/transaction.py   |  161 ++++++++++++++++++++++++++++++++++++=
++------
 5 files changed, 326 insertions(+), 62 deletions(-)


diff --git a/stgit/commands/clean.py b/stgit/commands/clean.py
index bbea253..e2d1678 100644
--- a/stgit/commands/clean.py
+++ b/stgit/commands/clean.py
@@ -44,7 +44,7 @@ def _clean(stack, clean_applied, clean_unapplied):
         trans.unapplied =3D []
         for pn in stack.patchorder.unapplied:
             p =3D stack.patches.get(pn)
-            if p.is_empty():
+            if p.commit.data.is_empty():
                 trans.patches[pn] =3D None
                 deleting(pn)
             else:
@@ -54,7 +54,7 @@ def _clean(stack, clean_applied, clean_unapplied):
         parent =3D stack.base
         for pn in stack.patchorder.applied:
             p =3D stack.patches.get(pn)
-            if p.is_empty():
+            if p.commit.data.is_empty():
                 trans.patches[pn] =3D None
                 deleting(pn)
             else:
diff --git a/stgit/commands/coalesce.py b/stgit/commands/coalesce.py
index c4c1cf8..2b121a9 100644
--- a/stgit/commands/coalesce.py
+++ b/stgit/commands/coalesce.py
@@ -35,50 +35,75 @@ options =3D [make_option('-n', '--name', help =3D '=
name of coalesced patch'),
            make_option('-m', '--message',
                        help =3D 'commit message of coalesced patch')]
=20
-def _coalesce(stack, name, msg, patches):
-    applied =3D stack.patchorder.applied
+def _coalesce_patches(trans, patches, msg):
+    cd =3D trans.patches[patches[0]].data
+    cd =3D git.Commitdata(tree =3D cd.tree, parents =3D cd.parents)
+    for pn in patches[1:]:
+        c =3D trans.patches[pn]
+        tree =3D trans.stack.repository.simple_merge(
+            base =3D c.data.parent.data.tree,
+            ours =3D cd.tree, theirs =3D c.data.tree)
+        if not tree:
+            return None
+        cd =3D cd.set_tree(tree)
+    if msg =3D=3D None:
+        msg =3D '\n\n'.join('%s\n\n%s' % (pn.ljust(70, '-'),
+                                        trans.patches[pn].data.message=
)
+                          for pn in patches)
+        msg =3D utils.edit_string(msg, '.stgit-coalesce.txt').strip()
+    cd =3D cd.set_message(msg)
=20
-    # Make sure the patches are consecutive.
-    applied_ix =3D dict((applied[i], i) for i in xrange(len(applied)))
-    ixes =3D list(sorted(applied_ix[p] for p in patches))
-    i0, i1 =3D ixes[0], ixes[-1]
-    if i1 - i0 + 1 !=3D len(patches):
-        raise common.CmdException('The patches must be consecutive')
+    return cd
=20
-    # Make a commit for the coalesced patch.
+def _coalesce(stack, iw, name, msg, patches):
+
+    # If a name was supplied on the command line, make sure it's OK.
     def bad_name(pn):
         return pn not in patches and stack.patches.exists(pn)
+    def get_name(cd):
+        return name or utils.make_patch_name(cd.message, bad_name)
     if name and bad_name(name):
         raise common.CmdException('Patch name "%s" already taken')
-    ps =3D [stack.patches.get(pn) for pn in applied[i0:i1+1]]
-    if msg =3D=3D None:
-        msg =3D '\n\n'.join('%s\n\n%s' % (p.name.ljust(70, '-'),
-                                        p.commit.data.message)
-                          for p in ps)
-        msg =3D utils.edit_string(msg, '.stgit-coalesce.txt').strip()
-    if not name:
-        name =3D utils.make_patch_name(msg, bad_name)
-    cd =3D git.Commitdata(tree =3D ps[-1].commit.data.tree,
-                        parents =3D ps[0].commit.data.parents, message=
 =3D msg)
=20
-    # Rewrite refs.
+    def make_coalesced_patch(trans, new_commit_data):
+        name =3D get_name(new_commit_data)
+        trans.patches[name] =3D stack.repository.commit(new_commit_dat=
a)
+        trans.unapplied.insert(0, name)
+
     trans =3D transaction.StackTransaction(stack, 'stg coalesce')
-    for pn in applied[i0:i1+1]:
-        trans.patches[pn] =3D None
-    parent =3D trans.patches[name] =3D stack.repository.commit(cd)
-    trans.applied =3D applied[:i0]
-    trans.applied.append(name)
-    for pn in applied[i1+1:]:
-        p =3D stack.patches.get(pn)
-        parent =3D trans.patches[pn] =3D stack.repository.commit(
-            p.commit.data.set_parent(parent))
-        trans.applied.append(pn)
-    trans.run()
+    push_new_patch =3D bool(set(patches) & set(trans.applied))
+    new_commit_data =3D _coalesce_patches(trans, patches, msg)
+    try:
+        if new_commit_data:
+            # We were able to construct the coalesced commit
+            # automatically. So just delete its constituent patches.
+            to_push =3D trans.delete_patches(lambda pn: pn in patches)
+            make_coalesced_patch(trans, new_commit_data)
+        else:
+            # Automatic construction failed. So push the patches
+            # consecutively, so that a second construction attempt is
+            # guaranteed to work.
+            to_push =3D trans.pop_patches(lambda pn: pn in patches)
+            for pn in patches:
+                trans.push_patch(pn, iw)
+            new_commit_data =3D _coalesce_patches(trans, patches, msg)
+            make_coalesced_patch(trans, new_commit_data)
+            assert not trans.delete_patches(lambda pn: pn in patches)
+
+        # Push the new patch if necessary, and any unrelated patches w=
e've
+        # had to pop out of the way.
+        if push_new_patch:
+            trans.push_patch(get_name(new_commit_data), iw)
+        for pn in to_push:
+            trans.push_patch(pn, iw)
+    except transaction.TransactionHalted:
+        pass
+    trans.run(iw)
=20
 def func(parser, options, args):
     stack =3D directory.repository.current_stack
-    applied =3D set(stack.patchorder.applied)
-    patches =3D set(common.parse_patches(args, list(stack.patchorder.a=
pplied)))
+    patches =3D common.parse_patches(args, list(stack.patchorder.appli=
ed))
     if len(patches) < 2:
         raise common.CmdException('Need at least two patches')
-    _coalesce(stack, options.name, options.message, patches)
+    _coalesce(stack, stack.repository.default_iw(),
+              options.name, options.message, patches)
diff --git a/stgit/lib/git.py b/stgit/lib/git.py
index c4011f9..ab4a376 100644
--- a/stgit/lib/git.py
+++ b/stgit/lib/git.py
@@ -95,6 +95,8 @@ class Commitdata(Repr):
         return type(self)(committer =3D committer, defaults =3D self)
     def set_message(self, message):
         return type(self)(message =3D message, defaults =3D self)
+    def is_empty(self):
+        return self.tree =3D=3D self.parent.data.tree
     def __str__(self):
         if self.tree =3D=3D None:
             tree =3D None
@@ -218,6 +220,21 @@ class Repository(RunWithEnv):
                                ).output_one_line())
         except run.RunException:
             raise RepositoryException('Cannot find git repository')
+    def default_index(self):
+        return Index(self, (os.environ.get('GIT_INDEX_FILE', None)
+                            or os.path.join(self.__git_dir, 'index')))
+    def temp_index(self):
+        return Index(self, self.__git_dir)
+    def default_worktree(self):
+        path =3D os.environ.get('GIT_WORK_TREE', None)
+        if not path:
+            o =3D run.Run('git', 'rev-parse', '--show-cdup').output_li=
nes()
+            o =3D o or ['.']
+            assert len(o) =3D=3D 1
+            path =3D o[0]
+        return Worktree(path)
+    def default_iw(self):
+        return IndexAndWorktree(self.default_index(), self.default_wor=
ktree())
     directory =3D property(lambda self: self.__git_dir)
     refs =3D property(lambda self: self.__refs)
     def cat_object(self, sha1):
@@ -258,3 +275,109 @@ class Repository(RunWithEnv):
             raise DetachedHeadException()
     def set_head(self, ref, msg):
         self.run(['git', 'symbolic-ref', '-m', msg, 'HEAD', ref]).no_o=
utput()
+    def simple_merge(self, base, ours, theirs):
+        """Given three trees, tries to do an in-index merge in a tempo=
rary
+        index with a temporary index. Returns the result tree, or None=
 if
+        the merge failed (due to conflicts)."""
+        assert isinstance(base, Tree)
+        assert isinstance(ours, Tree)
+        assert isinstance(theirs, Tree)
+
+        # Take care of the really trivial cases.
+        if base =3D=3D ours:
+            return theirs
+        if base =3D=3D theirs:
+            return ours
+        if ours =3D=3D theirs:
+            return ours
+
+        index =3D self.temp_index()
+        try:
+            index.merge(base, ours, theirs)
+            try:
+                return index.write_tree()
+            except MergeException:
+                return None
+        finally:
+            index.delete()
+
+class MergeException(exception.StgException):
+    pass
+
+class Index(RunWithEnv):
+    def __init__(self, repository, filename):
+        self.__repository =3D repository
+        if os.path.isdir(filename):
+            # Create a temp index in the given directory.
+            self.__filename =3D os.path.join(
+                filename, 'index.temp-%d-%x' % (os.getpid(), id(self))=
)
+            self.delete()
+        else:
+            self.__filename =3D filename
+    env =3D property(lambda self: utils.add_dict(
+            self.__repository.env, { 'GIT_INDEX_FILE': self.__filename=
 }))
+    def read_tree(self, tree):
+        self.run(['git', 'read-tree', tree.sha1]).no_output()
+    def write_tree(self):
+        try:
+            return self.__repository.get_tree(
+                self.run(['git', 'write-tree']).discard_stderr(
+                    ).output_one_line())
+        except run.RunException:
+            raise MergeException('Conflicting merge')
+    def is_clean(self):
+        try:
+            self.run(['git', 'update-index', '--refresh']).discard_out=
put()
+        except run.RunException:
+            return False
+        else:
+            return True
+    def merge(self, base, ours, theirs):
+        """In-index merge, no worktree involved."""
+        self.run(['git', 'read-tree', '-m', '-i', '--aggressive',
+                  base.sha1, ours.sha1, theirs.sha1]).no_output()
+    def delete(self):
+        if os.path.isfile(self.__filename):
+            os.remove(self.__filename)
+
+class Worktree(object):
+    def __init__(self, directory):
+        self.__directory =3D directory
+    env =3D property(lambda self: { 'GIT_WORK_TREE': self.__directory =
})
+
+class CheckoutException(exception.StgException):
+    pass
+
+class IndexAndWorktree(RunWithEnv):
+    def __init__(self, index, worktree):
+        self.__index =3D index
+        self.__worktree =3D worktree
+    index =3D property(lambda self: self.__index)
+    env =3D property(lambda self: utils.add_dict(self.__index.env,
+                                               self.__worktree.env))
+    def checkout(self, old_tree, new_tree):
+        # TODO: Optionally do a 3-way instead of doing nothing when we
+        # have a problem. Or maybe we should stash changes in a patch?
+        assert isinstance(old_tree, Tree)
+        assert isinstance(new_tree, Tree)
+        try:
+            self.run(['git', 'read-tree', '-u', '-m',
+                      '--exclude-per-directory=3D.gitignore',
+                      old_tree.sha1, new_tree.sha1]
+                     ).discard_output()
+        except run.RunException:
+            raise CheckoutException('Index/workdir dirty')
+    def merge(self, base, ours, theirs):
+        assert isinstance(base, Tree)
+        assert isinstance(ours, Tree)
+        assert isinstance(theirs, Tree)
+        try:
+            self.run(['git', 'merge-recursive', base.sha1, '--', ours.=
sha1,
+                      theirs.sha1]).discard_output()
+        except run.RunException, e:
+            raise MergeException('Index/worktree dirty')
+    def changed_files(self):
+        return self.run(['git', 'diff-files', '--name-only']).output_l=
ines()
+    def update_index(self, files):
+        self.run(['git', 'update-index', '--remove', '-z', '--stdin']
+                 ).input_nulterm(files).discard_output()
diff --git a/stgit/lib/stack.py b/stgit/lib/stack.py
index 8fc8b08..b4512b1 100644
--- a/stgit/lib/stack.py
+++ b/stgit/lib/stack.py
@@ -64,9 +64,6 @@ class Patch(object):
         self.__stack.repository.refs.delete(self.__ref)
     def is_applied(self):
         return self.name in self.__stack.patchorder.applied
-    def is_empty(self):
-        c =3D self.commit
-        return c.data.tree =3D=3D c.data.parent.data.tree
=20
 class PatchOrder(object):
     """Keeps track of patch order, and which patches are applied.
@@ -150,6 +147,10 @@ class Stack(object):
                                     ).commit.data.parent
         else:
             return self.head
+    def head_top_equal(self):
+        if not self.patchorder.applied:
+            return True
+        return self.head =3D=3D self.patches.get(self.patchorder.appli=
ed[-1]).commit
=20
 class Repository(git.Repository):
     def __init__(self, *args, **kwargs):
diff --git a/stgit/lib/transaction.py b/stgit/lib/transaction.py
index 991e64e..c9d355d 100644
--- a/stgit/lib/transaction.py
+++ b/stgit/lib/transaction.py
@@ -1,10 +1,14 @@
 from stgit import exception
 from stgit.out import *
+from stgit.lib import git
=20
 class TransactionException(exception.StgException):
     pass
=20
-def print_current_patch(old_applied, new_applied):
+class TransactionHalted(TransactionException):
+    pass
+
+def _print_current_patch(old_applied, new_applied):
     def now_at(pn):
         out.info('Now at patch "%s"' % pn)
     if not old_applied and not new_applied:
@@ -18,22 +22,47 @@ def print_current_patch(old_applied, new_applied):
     else:
         now_at(new_applied[-1])
=20
+class _TransPatchMap(dict):
+    def __init__(self, stack):
+        dict.__init__(self)
+        self.__stack =3D stack
+    def __getitem__(self, pn):
+        try:
+            return dict.__getitem__(self, pn)
+        except KeyError:
+            return self.__stack.patches.get(pn).commit
+
 class StackTransaction(object):
     def __init__(self, stack, msg):
         self.__stack =3D stack
         self.__msg =3D msg
-        self.__patches =3D {}
+        self.__patches =3D _TransPatchMap(stack)
         self.__applied =3D list(self.__stack.patchorder.applied)
         self.__unapplied =3D list(self.__stack.patchorder.unapplied)
-    def __set_patches(self, val):
-        self.__patches =3D dict(val)
-    patches =3D property(lambda self: self.__patches, __set_patches)
+        self.__error =3D None
+        self.__current_tree =3D self.__stack.head.data.tree
+    stack =3D property(lambda self: self.__stack)
+    patches =3D property(lambda self: self.__patches)
     def __set_applied(self, val):
         self.__applied =3D list(val)
     applied =3D property(lambda self: self.__applied, __set_applied)
     def __set_unapplied(self, val):
         self.__unapplied =3D list(val)
     unapplied =3D property(lambda self: self.__unapplied, __set_unappl=
ied)
+    def __checkout(self, tree, iw):
+        if not self.__stack.head_top_equal():
+            out.error('HEAD and top are not the same.',
+                      'This can happen if you modify a branch with git=
=2E',
+                      'The "repair" command can fix this situation.')
+            self.__abort()
+        if self.__current_tree !=3D tree:
+            assert iw !=3D None
+            iw.checkout(self.__current_tree, tree)
+            self.__current_tree =3D tree
+    @staticmethod
+    def __abort():
+        raise TransactionException(
+            'Command aborted (all changes rolled back)')
     def __check_consistency(self):
         remaining =3D set(self.__applied + self.__unapplied)
         for pn, commit in self.__patches.iteritems():
@@ -41,29 +70,29 @@ class StackTransaction(object):
                 assert self.__stack.patches.exists(pn)
             else:
                 assert pn in remaining
-    def run(self):
-        self.__check_consistency()
-
-        # Get new head commit.
+    @property
+    def __head(self):
         if self.__applied:
-            top_patch =3D self.__applied[-1]
-            try:
-                new_head =3D self.__patches[top_patch]
-            except KeyError:
-                new_head =3D self.__stack.patches.get(top_patch).commi=
t
+            return self.__patches[self.__applied[-1]]
         else:
-            new_head =3D self.__stack.base
+            return self.__stack.base
+    def run(self, iw =3D None):
+        self.__check_consistency()
+        new_head =3D self.__head
=20
         # Set branch head.
-        if new_head =3D=3D self.__stack.head:
-            pass # same commit: OK
-        elif new_head.data.tree =3D=3D self.__stack.head.data.tree:
-            pass # same tree: OK
-        else:
-            # We can't handle this case yet.
-            raise TransactionException('Error: HEAD tree changed')
+        try:
+            self.__checkout(new_head.data.tree, iw)
+        except git.CheckoutException:
+            # We have to abort the transaction. The only state we need
+            # to restore is index+worktree.
+            self.__checkout(self.__stack.head.data.tree, iw)
+            self.__abort()
         self.__stack.set_head(new_head, self.__msg)
=20
+        if self.__error:
+            out.error(self.__error)
+
         # Write patches.
         for pn, commit in self.__patches.iteritems():
             if self.__stack.patches.exists(pn):
@@ -74,6 +103,92 @@ class StackTransaction(object):
                     p.set_commit(commit, self.__msg)
             else:
                 self.__stack.patches.new(pn, commit, self.__msg)
-        print_current_patch(self.__stack.patchorder.applied, self.__ap=
plied)
+        _print_current_patch(self.__stack.patchorder.applied, self.__a=
pplied)
         self.__stack.patchorder.applied =3D self.__applied
         self.__stack.patchorder.unapplied =3D self.__unapplied
+
+    def __halt(self, msg):
+        self.__error =3D msg
+        raise TransactionHalted(msg)
+
+    @staticmethod
+    def __print_popped(popped):
+        if len(popped) =3D=3D 0:
+            pass
+        elif len(popped) =3D=3D 1:
+            out.info('Popped %s' % popped[0])
+        else:
+            out.info('Popped %s -- %s' % (popped[-1], popped[0]))
+
+    def pop_patches(self, p):
+        """Pop all patches pn for which p(pn) is true. Return the list=
 of
+        other patches that had to be popped to accomplish this."""
+        popped =3D []
+        for i in xrange(len(self.applied)):
+            if p(self.applied[i]):
+                popped =3D self.applied[i:]
+                del self.applied[i:]
+                break
+        popped1 =3D [pn for pn in popped if not p(pn)]
+        popped2 =3D [pn for pn in popped if p(pn)]
+        self.unapplied =3D popped1 + popped2 + self.unapplied
+        self.__print_popped(popped)
+        return popped1
+
+    def delete_patches(self, p):
+        """Delete all patches pn for which p(pn) is true. Return the l=
ist of
+        other patches that had to be popped to accomplish this."""
+        popped =3D []
+        all_patches =3D self.applied + self.unapplied
+        for i in xrange(len(self.applied)):
+            if p(self.applied[i]):
+                popped =3D self.applied[i:]
+                del self.applied[i:]
+                break
+        popped =3D [pn for pn in popped if not p(pn)]
+        self.unapplied =3D popped + [pn for pn in self.unapplied if no=
t p(pn)]
+        self.__print_popped(popped)
+        for pn in all_patches:
+            if p(pn):
+                s =3D ['', ' (empty)'][self.patches[pn].data.is_empty(=
)]
+                self.patches[pn] =3D None
+                out.info('Deleted %s%s' % (pn, s))
+        return popped
+
+    def push_patch(self, pn, iw =3D None):
+        """Attempt to push the named patch. If this results in conflic=
ts,
+        halts the transaction. If index+worktree are given, spill any
+        conflicts to them."""
+        i =3D self.unapplied.index(pn)
+        cd =3D self.patches[pn].data
+        s =3D ['', ' (empty)'][cd.is_empty()]
+        oldparent =3D cd.parent
+        cd =3D cd.set_parent(self.__head)
+        base =3D oldparent.data.tree
+        ours =3D cd.parent.data.tree
+        theirs =3D cd.tree
+        tree =3D self.__stack.repository.simple_merge(base, ours, thei=
rs)
+        merge_conflict =3D False
+        if not tree:
+            if iw =3D=3D None:
+                self.__halt('%s does not apply cleanly' % pn)
+            try:
+                self.__checkout(ours, iw)
+            except git.CheckoutException:
+                self.__halt('Index/worktree dirty')
+            try:
+                iw.merge(base, ours, theirs)
+                tree =3D iw.index.write_tree()
+                self.__current_tree =3D tree
+                s =3D ' (modified)'
+            except git.MergeException:
+                tree =3D ours
+                merge_conflict =3D True
+                s =3D ' (conflict)'
+        cd =3D cd.set_tree(tree)
+        self.patches[pn] =3D self.__stack.repository.commit(cd)
+        del self.unapplied[i]
+        self.applied.append(pn)
+        out.info('Pushed %s%s' % (pn, s))
+        if merge_conflict:
+            self.__halt('Merge conflict')
