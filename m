From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH 13/14] Log and undo external modifications
Date: Thu, 12 Jun 2008 07:35:25 +0200
Message-ID: <20080612053525.23549.49690.stgit@yoghurt>
References: <20080612052913.23549.69687.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 12 07:36:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6fU2-000594-9G
	for gcvg-git-2@gmane.org; Thu, 12 Jun 2008 07:36:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752700AbYFLFfe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Jun 2008 01:35:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752739AbYFLFfd
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jun 2008 01:35:33 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2188 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752700AbYFLFfb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jun 2008 01:35:31 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1K6fT3-00016r-00; Thu, 12 Jun 2008 06:35:26 +0100
In-Reply-To: <20080612052913.23549.69687.stgit@yoghurt>
User-Agent: StGIT/0.14.2.171.g5c0d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84711>

At the beginning of every StGit command, quickly check if the branch
head recorded in the log is the same as the actual branch head; if
it's not, conclude that some non-StGit tool has modified the stack,
and record a log entry that says so. (Additionally, if the log doesn't
exist yet, create it.)

This introduces the possibility that a log entry specifies a head and
a top that aren't equal. So teach undo, redo, and reset to deal with
that case.

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

 stgit/commands/common.py     |    1=20
 stgit/commands/redo.py       |    4 +-
 stgit/commands/reset.py      |    8 +++-
 stgit/commands/undo.py       |    4 +-
 stgit/lib/log.py             |   88 ++++++++++++++++++++++++++++------=
--------
 stgit/lib/transaction.py     |   39 ++++++++++++-------
 t/t3105-undo-external-mod.sh |   68 ++++++++++++++++++++++++++++++++
 7 files changed, 162 insertions(+), 50 deletions(-)
 create mode 100755 t/t3105-undo-external-mod.sh


diff --git a/stgit/commands/common.py b/stgit/commands/common.py
index fd02398..2689a42 100644
--- a/stgit/commands/common.py
+++ b/stgit/commands/common.py
@@ -525,6 +525,7 @@ class DirectoryAnywhere(_Directory):
 class DirectoryHasRepository(_Directory):
     def setup(self):
         self.git_dir # might throw an exception
+        log.compat_log_external_mods()
=20
 class DirectoryInWorktree(DirectoryHasRepository):
     def setup(self):
diff --git a/stgit/commands/redo.py b/stgit/commands/redo.py
index 47221a5..a1075ec 100644
--- a/stgit/commands/redo.py
+++ b/stgit/commands/redo.py
@@ -46,7 +46,7 @@ def func(parser, options, args):
     trans =3D transaction.StackTransaction(stack, 'redo %d' % options.=
number,
                                          discard_changes =3D options.h=
ard)
     try:
-        log.reset_stack(trans, stack.repository.default_iw, state, [])
+        log.reset_stack(trans, stack.repository.default_iw, state)
     except transaction.TransactionHalted:
         pass
-    return trans.run(stack.repository.default_iw)
+    return trans.run(stack.repository.default_iw, allow_bad_head =3D T=
rue)
diff --git a/stgit/commands/reset.py b/stgit/commands/reset.py
index 5ad9914..22d7731 100644
--- a/stgit/commands/reset.py
+++ b/stgit/commands/reset.py
@@ -57,7 +57,11 @@ def func(parser, options, args):
     trans =3D transaction.StackTransaction(stack, 'reset',
                                          discard_changes =3D options.h=
ard)
     try:
-        log.reset_stack(trans, stack.repository.default_iw, state, pat=
ches)
+        if patches:
+            log.reset_stack_partially(trans, stack.repository.default_=
iw,
+                                      state, patches)
+        else:
+            log.reset_stack(trans, stack.repository.default_iw, state)
     except transaction.TransactionHalted:
         pass
-    return trans.run(stack.repository.default_iw)
+    return trans.run(stack.repository.default_iw, allow_bad_head =3D n=
ot patches)
diff --git a/stgit/commands/undo.py b/stgit/commands/undo.py
index b1d7de9..58f1da6 100644
--- a/stgit/commands/undo.py
+++ b/stgit/commands/undo.py
@@ -43,7 +43,7 @@ def func(parser, options, args):
     trans =3D transaction.StackTransaction(stack, 'undo %d' % options.=
number,
                                          discard_changes =3D options.h=
ard)
     try:
-        log.reset_stack(trans, stack.repository.default_iw, state, [])
+        log.reset_stack(trans, stack.repository.default_iw, state)
     except transaction.TransactionHalted:
         pass
-    return trans.run(stack.repository.default_iw)
+    return trans.run(stack.repository.default_iw, allow_bad_head =3D T=
rue)
diff --git a/stgit/lib/log.py b/stgit/lib/log.py
index a8de06b..8c0516b 100644
--- a/stgit/lib/log.py
+++ b/stgit/lib/log.py
@@ -259,6 +259,7 @@ class Log(object):
             self.base =3D self.patches[self.applied[0]].data.parent
         else:
             self.base =3D self.head
+    all_patches =3D property(lambda self: self.applied + self.unapplie=
d)
     @property
     def top(self):
         if self.applied:
@@ -297,34 +298,33 @@ def copy_log(repo, src_branch, dst_branch, msg):
 def default_repo():
     return stack.Repository.default()
=20
-def reset_stack(trans, iw, state, only_patches):
-    """Reset the stack to a given previous state. If C{only_patches} i=
s
-    not empty, touch only patches whose names appear in it.
+def reset_stack(trans, iw, state):
+    """Reset the stack to a given previous state."""
+    for pn in trans.all_patches:
+        trans.patches[pn] =3D None
+    for pn in state.all_patches:
+        trans.patches[pn] =3D state.patches[pn]
+    trans.applied =3D state.applied
+    trans.unapplied =3D state.unapplied
+    trans.base =3D state.base
+    trans.head =3D state.head
+
+def reset_stack_partially(trans, iw, state, only_patches):
+    """Reset the stack to a given previous state -- but only the given
+    patches, not anything else.
=20
-    @param only_patches: Reset only these patches
+    @param only_patches: Touch only these patches
     @type only_patches: iterable"""
     only_patches =3D set(only_patches)
-    def mask(s):
-        if only_patches:
-            return s & only_patches
-        else:
-            return s
-    patches_to_reset =3D mask(set(state.applied + state.unapplied))
+    patches_to_reset =3D set(state.applied + state.unapplied) & only_p=
atches
     existing_patches =3D set(trans.all_patches)
     original_applied_order =3D list(trans.applied)
-    to_delete =3D mask(existing_patches - patches_to_reset)
-
-    # If we have to change the stack base, we need to pop all patches
-    # first.
-    if not only_patches and trans.base !=3D state.base:
-        trans.pop_patches(lambda pn: True)
-        out.info('Setting stack base to %s' % state.base.sha1)
-        trans.base =3D state.base
+    to_delete =3D (existing_patches - patches_to_reset) & only_patches
=20
     # In one go, do all the popping we have to in order to pop the
     # patches we're going to delete or modify.
     def mod(pn):
-        if only_patches and not pn in only_patches:
+        if not pn in only_patches:
             return False
         if pn in to_delete:
             return True
@@ -347,17 +347,12 @@ def reset_stack(trans, iw, state, only_patches):
             out.info('Resurrecting %s' % pn)
         trans.patches[pn] =3D state.patches[pn]
=20
-    # Push/pop patches as necessary.
-    if only_patches:
-        # Push all the patches that we've popped, if they still
-        # exist.
-        pushable =3D set(trans.unapplied)
-        for pn in original_applied_order:
-            if pn in pushable:
-                trans.push_patch(pn, iw)
-    else:
-        # Recreate the exact order specified by the goal state.
-        trans.reorder_patches(state.applied, state.unapplied, iw)
+    # Push all the patches that we've popped, if they still
+    # exist.
+    pushable =3D set(trans.unapplied)
+    for pn in original_applied_order:
+        if pn in pushable:
+            trans.push_patch(pn, iw)
=20
 def undo_state(stack, undo_steps):
     """Find the log entry C{undo_steps} steps in the past. (Successive
@@ -396,3 +391,36 @@ def undo_state(stack, undo_steps):
             raise LogException('Not enough undo information available'=
)
         log =3D Log(stack.repository, log.parents[0].sha1, log.parents=
[0])
     return log
+
+def log_external_mods(stack):
+    ref =3D log_ref(stack.name)
+    try:
+        log_commit =3D stack.repository.refs.get(ref)
+    except KeyError:
+        # No log exists yet.
+        log_entry(stack, 'start of log')
+        return
+    try:
+        log =3D Log(stack.repository, ref, log_commit)
+    except LogException:
+        # Something's wrong with the log, so don't bother.
+        return
+    if log.head =3D=3D stack.head:
+        # No external modifications.
+        return
+    log_entry(stack, '\n'.join([
+                'external modifications', '',
+                'Modifications by tools other than StGit (e.g. git).']=
))
+
+def compat_log_external_mods():
+    try:
+        repo =3D default_repo()
+    except git.RepositoryException:
+        # No repository, so we couldn't log even if we wanted to.
+        return
+    try:
+        stack =3D repo.get_stack(repo.current_branch_name)
+    except exception.StgException:
+        # Stack doesn't exist, so we can't log.
+        return
+    log_external_mods(stack)
diff --git a/stgit/lib/transaction.py b/stgit/lib/transaction.py
index 2003105..0c8d9a5 100644
--- a/stgit/lib/transaction.py
+++ b/stgit/lib/transaction.py
@@ -91,6 +91,7 @@ class StackTransaction(object):
         self.__current_tree =3D self.__stack.head.data.tree
         self.__base =3D self.__stack.base
         self.__discard_changes =3D discard_changes
+        self.__bad_head =3D None
         if isinstance(allow_conflicts, bool):
             self.__allow_conflicts =3D lambda trans: allow_conflicts
         else:
@@ -109,8 +110,22 @@ class StackTransaction(object):
                 or self.patches[self.applied[0]].data.parent =3D=3D va=
l)
         self.__base =3D val
     base =3D property(lambda self: self.__base, __set_base)
-    def __checkout(self, tree, iw):
-        if not self.__stack.head_top_equal():
+    @property
+    def top(self):
+        if self.__applied:
+            return self.__patches[self.__applied[-1]]
+        else:
+            return self.__base
+    def __get_head(self):
+        if self.__bad_head:
+            return self.__bad_head
+        else:
+            return self.top
+    def __set_head(self, val):
+        self.__bad_head =3D val
+    head =3D property(__get_head, __set_head)
+    def __checkout(self, tree, iw, allow_bad_head):
+        if not (allow_bad_head or self.__stack.head_top_equal()):
             out.error(
                 'HEAD and top are not the same.',
                 'This can happen if you modify a branch with git.',
@@ -143,26 +158,22 @@ class StackTransaction(object):
                 assert self.__stack.patches.exists(pn)
             else:
                 assert pn in remaining
-    @property
-    def __head(self):
-        if self.__applied:
-            return self.__patches[self.__applied[-1]]
-        else:
-            return self.__base
     def abort(self, iw =3D None):
         # The only state we need to restore is index+worktree.
         if iw:
-            self.__checkout(self.__stack.head.data.tree, iw)
-    def run(self, iw =3D None):
+            self.__checkout(self.__stack.head.data.tree, iw,
+                            allow_bad_head =3D True)
+    def run(self, iw =3D None, allow_bad_head =3D False):
         """Execute the transaction. Will either succeed, or fail (with=
 an
         exception) and do nothing."""
         self.__check_consistency()
-        new_head =3D self.__head
+        log.log_external_mods(self.__stack)
+        new_head =3D self.head
=20
         # Set branch head.
         if iw:
             try:
-                self.__checkout(new_head.data.tree, iw)
+                self.__checkout(new_head.data.tree, iw, allow_bad_head=
)
             except git.CheckoutException:
                 # We have to abort the transaction.
                 self.abort(iw)
@@ -257,7 +268,7 @@ class StackTransaction(object):
         cd =3D orig_cd.set_committer(None)
         s =3D ['', ' (empty)'][cd.is_nochange()]
         oldparent =3D cd.parent
-        cd =3D cd.set_parent(self.__head)
+        cd =3D cd.set_parent(self.top)
         base =3D oldparent.data.tree
         ours =3D cd.parent.data.tree
         theirs =3D cd.tree
@@ -267,7 +278,7 @@ class StackTransaction(object):
             if iw =3D=3D None:
                 self.__halt('%s does not apply cleanly' % pn)
             try:
-                self.__checkout(ours, iw)
+                self.__checkout(ours, iw, allow_bad_head =3D False)
             except git.CheckoutException:
                 self.__halt('Index/worktree dirty')
             try:
diff --git a/t/t3105-undo-external-mod.sh b/t/t3105-undo-external-mod.s=
h
new file mode 100755
index 0000000..289a42a
--- /dev/null
+++ b/t/t3105-undo-external-mod.sh
@@ -0,0 +1,68 @@
+#!/bin/sh
+
+test_description=3D'Undo external modifications of the stack'
+
+. ./test-lib.sh
+
+# Ignore our own output files.
+cat > .git/info/exclude <<EOF
+/expected.txt
+/head?.txt
+EOF
+
+test_expect_success 'Initialize StGit stack' '
+    stg init &&
+    echo 000 >> a &&
+    git add a &&
+    git commit -m p0 &&
+    echo 111 >> a &&
+    git add a &&
+    git commit -m p1 &&
+    stg uncommit -n 1
+'
+
+cat > expected.txt <<EOF
+000
+111
+222
+EOF
+test_expect_success 'Make a git commit and turn it into a patch' '
+    git rev-parse HEAD > head0.txt &&
+    echo 222 >> a &&
+    git add a &&
+    git commit -m p2 &&
+    git rev-parse HEAD > head1.txt &&
+    stg repair &&
+    test "$(echo $(stg applied))" =3D "p1 p2" &&
+    test "$(echo $(stg unapplied))" =3D "" &&
+    test_cmp expected.txt a
+'
+
+cat > expected.txt <<EOF
+000
+111
+222
+EOF
+test_expect_success 'Undo the patchification' '
+    stg undo &&
+    git rev-parse HEAD > head2.txt &&
+    test_cmp head1.txt head2.txt &&
+    test "$(echo $(stg applied))" =3D "p1" &&
+    test "$(echo $(stg unapplied))" =3D "" &&
+    test_cmp expected.txt a
+'
+
+cat > expected.txt <<EOF
+000
+111
+EOF
+test_expect_success 'Undo the commit' '
+    stg undo &&
+    git rev-parse HEAD > head3.txt &&
+    test_cmp head0.txt head3.txt &&
+    test "$(echo $(stg applied))" =3D "p1" &&
+    test "$(echo $(stg unapplied))" =3D "" &&
+    test_cmp expected.txt a
+'
+
+test_done
