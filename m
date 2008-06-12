From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH 10/14] Move stack reset function to a shared location
Date: Thu, 12 Jun 2008 07:35:08 +0200
Message-ID: <20080612053508.23549.98668.stgit@yoghurt>
References: <20080612052913.23549.69687.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 12 07:36:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K6fU0-000594-Ez
	for gcvg-git-2@gmane.org; Thu, 12 Jun 2008 07:36:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752567AbYFLFfY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 12 Jun 2008 01:35:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752560AbYFLFfX
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Jun 2008 01:35:23 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2180 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752511AbYFLFfU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jun 2008 01:35:20 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1K6fSm-00015y-00; Thu, 12 Jun 2008 06:35:08 +0100
In-Reply-To: <20080612052913.23549.69687.stgit@yoghurt>
User-Agent: StGIT/0.14.2.171.g5c0d
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/84714>

Move reset_stack() from commands/reset.py to lib/log.py, so that more
commands besides reset can use it. (No such commands exist currently,
but undo and redo will use it.)

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

 stgit/commands/reset.py  |   70 +++++---------------------------------=
--------
 stgit/lib/log.py         |   62 ++++++++++++++++++++++++++++++++++++++=
+++
 stgit/lib/transaction.py |    3 +-
 3 files changed, 71 insertions(+), 64 deletions(-)


diff --git a/stgit/commands/reset.py b/stgit/commands/reset.py
index a7b5d35..5ad9914 100644
--- a/stgit/commands/reset.py
+++ b/stgit/commands/reset.py
@@ -47,67 +47,6 @@ directory =3D common.DirectoryHasRepositoryLib()
 options =3D [make_option('--hard', action =3D 'store_true',
                        help =3D 'discard changes in your index/worktre=
e')]
=20
-def reset_stack(stack, iw, state, only_patches, hard):
-    only_patches =3D set(only_patches)
-    def mask(s):
-        if only_patches:
-            return s & only_patches
-        else:
-            return s
-    patches_to_reset =3D mask(set(state.applied + state.unapplied))
-    existing_patches =3D set(stack.patchorder.all)
-    to_delete =3D mask(existing_patches - patches_to_reset)
-    trans =3D transaction.StackTransaction(stack, 'reset', discard_cha=
nges =3D hard)
-
-    # If we have to change the stack base, we need to pop all patches
-    # first.
-    if not only_patches and trans.base !=3D state.base:
-        trans.pop_patches(lambda pn: True)
-        out.info('Setting stack base to %s' % state.base.sha1)
-        trans.base =3D state.base
-
-    # In one go, do all the popping we have to in order to pop the
-    # patches we're going to delete or modify.
-    def mod(pn):
-        if only_patches and not pn in only_patches:
-            return False
-        if pn in to_delete:
-            return True
-        if stack.patches.get(pn).commit !=3D state.patches.get(pn, Non=
e):
-            return True
-        return False
-    trans.pop_patches(mod)
-
-    # Delete and modify/create patches. We've previously popped all
-    # patches that we touch in this step.
-    trans.delete_patches(lambda pn: pn in to_delete)
-    for pn in patches_to_reset:
-        if pn in existing_patches:
-            if trans.patches[pn] =3D=3D state.patches[pn]:
-                continue
-            else:
-                out.info('Resetting %s' % pn)
-        else:
-            trans.unapplied.append(pn)
-            out.info('Resurrecting %s' % pn)
-        trans.patches[pn] =3D state.patches[pn]
-
-    # Push/pop patches as necessary.
-    try:
-        if only_patches:
-            # Push all the patches that we've popped, if they still
-            # exist.
-            pushable =3D set(trans.unapplied)
-            for pn in stack.patchorder.applied:
-                if pn in pushable:
-                    trans.push_patch(pn, iw)
-        else:
-            # Recreate the exact order specified by the goal state.
-            trans.reorder_patches(state.applied, state.unapplied, iw)
-    except transaction.TransactionHalted:
-        pass
-    return trans.run(iw)
-
 def func(parser, options, args):
     stack =3D directory.repository.current_stack
     if len(args) >=3D 1:
@@ -115,5 +54,10 @@ def func(parser, options, args):
         state =3D log.Log(stack.repository, ref, stack.repository.rev_=
parse(ref))
     else:
         raise common.CmdException('Wrong number of arguments')
-    return reset_stack(stack, stack.repository.default_iw, state, patc=
hes,
-                       options.hard)
+    trans =3D transaction.StackTransaction(stack, 'reset',
+                                         discard_changes =3D options.h=
ard)
+    try:
+        log.reset_stack(trans, stack.repository.default_iw, state, pat=
ches)
+    except transaction.TransactionHalted:
+        pass
+    return trans.run(stack.repository.default_iw)
diff --git a/stgit/lib/log.py b/stgit/lib/log.py
index 3aec6e7..2449913 100644
--- a/stgit/lib/log.py
+++ b/stgit/lib/log.py
@@ -285,3 +285,65 @@ def copy_log(repo, src_branch, dst_branch, msg):
=20
 def default_repo():
     return stack.Repository.default()
+
+def reset_stack(trans, iw, state, only_patches):
+    """Reset the stack to a given previous state. If C{only_patches} i=
s
+    not empty, touch only patches whose names appear in it.
+
+    @param only_patches: Reset only these patches
+    @type only_patches: iterable"""
+    only_patches =3D set(only_patches)
+    def mask(s):
+        if only_patches:
+            return s & only_patches
+        else:
+            return s
+    patches_to_reset =3D mask(set(state.applied + state.unapplied))
+    existing_patches =3D set(trans.all_patches)
+    original_applied_order =3D list(trans.applied)
+    to_delete =3D mask(existing_patches - patches_to_reset)
+
+    # If we have to change the stack base, we need to pop all patches
+    # first.
+    if not only_patches and trans.base !=3D state.base:
+        trans.pop_patches(lambda pn: True)
+        out.info('Setting stack base to %s' % state.base.sha1)
+        trans.base =3D state.base
+
+    # In one go, do all the popping we have to in order to pop the
+    # patches we're going to delete or modify.
+    def mod(pn):
+        if only_patches and not pn in only_patches:
+            return False
+        if pn in to_delete:
+            return True
+        if trans.patches[pn] !=3D state.patches.get(pn, None):
+            return True
+        return False
+    trans.pop_patches(mod)
+
+    # Delete and modify/create patches. We've previously popped all
+    # patches that we touch in this step.
+    trans.delete_patches(lambda pn: pn in to_delete)
+    for pn in patches_to_reset:
+        if pn in existing_patches:
+            if trans.patches[pn] =3D=3D state.patches[pn]:
+                continue
+            else:
+                out.info('Resetting %s' % pn)
+        else:
+            trans.unapplied.append(pn)
+            out.info('Resurrecting %s' % pn)
+        trans.patches[pn] =3D state.patches[pn]
+
+    # Push/pop patches as necessary.
+    if only_patches:
+        # Push all the patches that we've popped, if they still
+        # exist.
+        pushable =3D set(trans.unapplied)
+        for pn in original_applied_order:
+            if pn in pushable:
+                trans.push_patch(pn, iw)
+    else:
+        # Recreate the exact order specified by the goal state.
+        trans.reorder_patches(state.applied, state.unapplied, iw)
diff --git a/stgit/lib/transaction.py b/stgit/lib/transaction.py
index 10c9b39..2003105 100644
--- a/stgit/lib/transaction.py
+++ b/stgit/lib/transaction.py
@@ -103,6 +103,7 @@ class StackTransaction(object):
     def __set_unapplied(self, val):
         self.__unapplied =3D list(val)
     unapplied =3D property(lambda self: self.__unapplied, __set_unappl=
ied)
+    all_patches =3D property(lambda self: self.__applied + self.__unap=
plied)
     def __set_base(self, val):
         assert (not self.__applied
                 or self.patches[self.applied[0]].data.parent =3D=3D va=
l)
@@ -136,7 +137,7 @@ class StackTransaction(object):
         raise TransactionException(
             'Command aborted (all changes rolled back)')
     def __check_consistency(self):
-        remaining =3D set(self.__applied + self.__unapplied)
+        remaining =3D set(self.all_patches)
         for pn, commit in self.__patches.iteritems():
             if commit =3D=3D None:
                 assert self.__stack.patches.exists(pn)
