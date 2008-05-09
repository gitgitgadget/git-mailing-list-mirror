From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH 1/2] Move stack reset function to a shared location
Date: Fri, 09 May 2008 02:44:29 +0200
Message-ID: <20080509004429.20312.11009.stgit@yoghurt>
References: <20080509003824.20312.17819.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 09 02:46:02 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JuGk2-0003IH-Sb
	for gcvg-git-2@gmane.org; Fri, 09 May 2008 02:45:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754324AbYEIAoz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 8 May 2008 20:44:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756143AbYEIAoy
	(ORCPT <rfc822;git-outgoing>); Thu, 8 May 2008 20:44:54 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1853 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754217AbYEIAod (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 May 2008 20:44:33 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1JuGiq-0004Zk-00; Fri, 09 May 2008 01:44:28 +0100
In-Reply-To: <20080509003824.20312.17819.stgit@yoghurt>
User-Agent: StGIT/0.14.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81581>

Move reset_stack() from commands/reset.py to lib/log.py, so that more
commands besides reset can use it. (No such commands exist currently,
but undo and redo will use it.)

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

 stgit/commands/reset.py  |   70 +++++---------------------------------=
--------
 stgit/lib/log.py         |   57 +++++++++++++++++++++++++++++++++++++
 stgit/lib/transaction.py |    1 +
 3 files changed, 65 insertions(+), 63 deletions(-)


diff --git a/stgit/commands/reset.py b/stgit/commands/reset.py
index bcc4c6a..2bbac8b 100644
--- a/stgit/commands/reset.py
+++ b/stgit/commands/reset.py
@@ -45,67 +45,6 @@ directory =3D common.DirectoryHasRepositoryLib()
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
@@ -113,5 +52,10 @@ def func(parser, options, args):
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
index e9e89ff..dfc2b9f 100644
--- a/stgit/lib/log.py
+++ b/stgit/lib/log.py
@@ -180,3 +180,60 @@ def copy_log(repo, src_branch, dst_branch, msg):
=20
 def default_repo():
     return stack.Repository.default()
+
+def reset_stack(trans, iw, state, only_patches):
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
index a008780..dd64eb6 100644
--- a/stgit/lib/transaction.py
+++ b/stgit/lib/transaction.py
@@ -60,6 +60,7 @@ class StackTransaction(object):
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
