From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH 01/10] Prevent most commands from running when there are
	conflicts
Date: Mon, 21 Apr 2008 00:10:27 +0200
Message-ID: <20080420221027.5837.19012.stgit@yoghurt>
References: <20080420215625.5837.82896.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Mon Apr 21 00:11:39 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jnhl1-0007vt-6E
	for gcvg-git-2@gmane.org; Mon, 21 Apr 2008 00:11:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751717AbYDTWKs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 20 Apr 2008 18:10:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751518AbYDTWKs
	(ORCPT <rfc822;git-outgoing>); Sun, 20 Apr 2008 18:10:48 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3184 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751484AbYDTWKr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 20 Apr 2008 18:10:47 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1Jnhjt-00081T-00; Sun, 20 Apr 2008 23:10:25 +0100
In-Reply-To: <20080420215625.5837.82896.stgit@yoghurt>
User-Agent: StGIT/0.14.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79992>

When there are conflicts, we want most commands to fail, since the
conflicts conceptually belong to the topmost patch. git read-tree
already checks this for us when we check out a new tree, but there are
operations where the top tree stays the same, e.g. stg new.

This patch inserts a conflict check when the tree to check out is the
same. By default, conflicts will prevent the checkout from succeeding,
but commands can choose to override this if the same patch stays on
top (for some definition of "same").

This change only affects the new-infrastructure commands; the others
always refuse to run when there are local changes of any kind.

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

 stgit/commands/clean.py    |    3 ++-
 stgit/commands/coalesce.py |    3 ++-
 stgit/commands/commit.py   |    7 ++++++-
 stgit/commands/delete.py   |   10 +++++++++-
 stgit/commands/edit.py     |    3 ++-
 stgit/commands/uncommit.py |    3 ++-
 stgit/lib/transaction.py   |   27 ++++++++++++++++++++++-----
 7 files changed, 45 insertions(+), 11 deletions(-)


diff --git a/stgit/commands/clean.py b/stgit/commands/clean.py
index 889c1dc..ed6fc6e 100644
--- a/stgit/commands/clean.py
+++ b/stgit/commands/clean.py
@@ -37,7 +37,8 @@ options =3D [make_option('-a', '--applied',
=20
=20
 def _clean(stack, clean_applied, clean_unapplied):
-    trans =3D transaction.StackTransaction(stack, 'stg clean')
+    trans =3D transaction.StackTransaction(stack, 'stg clean',
+                                         allow_conflicts =3D True)
     def del_patch(pn):
         if pn in stack.patchorder.applied:
             if pn =3D=3D stack.patchorder.applied[-1]:
diff --git a/stgit/commands/coalesce.py b/stgit/commands/coalesce.py
index 291a537..bf40427 100644
--- a/stgit/commands/coalesce.py
+++ b/stgit/commands/coalesce.py
@@ -79,7 +79,8 @@ def _coalesce(stack, iw, name, msg, save_template, pa=
tches):
         trans.patches[name] =3D stack.repository.commit(new_commit_dat=
a)
         trans.unapplied.insert(0, name)
=20
-    trans =3D transaction.StackTransaction(stack, 'stg coalesce')
+    trans =3D transaction.StackTransaction(stack, 'stg coalesce',
+                                         allow_conflicts =3D True)
     push_new_patch =3D bool(set(patches) & set(trans.applied))
     try:
         new_commit_data =3D _coalesce_patches(trans, patches, msg, sav=
e_template)
diff --git a/stgit/commands/commit.py b/stgit/commands/commit.py
index bff94ce..ee95836 100644
--- a/stgit/commands/commit.py
+++ b/stgit/commands/commit.py
@@ -69,7 +69,12 @@ def func(parser, options, args):
         raise common.CmdException('No patches to commit')
=20
     iw =3D stack.repository.default_iw
-    trans =3D transaction.StackTransaction(stack, 'stg commit')
+    def allow_conflicts(trans):
+        # As long as the topmost patch stays where it is, it's OK to
+        # run "stg commit" with conflicts in the index.
+        return len(trans.applied) >=3D 1
+    trans =3D transaction.StackTransaction(stack, 'stg commit',
+                                         allow_conflicts =3D allow_con=
flicts)
     try:
         common_prefix =3D 0
         for i in xrange(min(len(stack.patchorder.applied), len(patches=
))):
diff --git a/stgit/commands/delete.py b/stgit/commands/delete.py
index 106fbd2..14bf442 100644
--- a/stgit/commands/delete.py
+++ b/stgit/commands/delete.py
@@ -46,7 +46,15 @@ def func(parser, options, args):
                        + list(stack.patchorder.unapplied))))
     else:
         parser.error('No patches specified')
-    trans =3D transaction.StackTransaction(stack, 'stg delete')
+    def allow_conflicts(trans):
+        # Allow conflicts if the topmost patch stays the same.
+        if stack.patchorder.applied:
+            return (trans.applied
+                    and trans.applied[-1] =3D=3D stack.patchorder.appl=
ied[-1])
+        else:
+            return not trans.applied
+    trans =3D transaction.StackTransaction(stack, 'stg delete',
+                                         allow_conflicts =3D allow_con=
flicts)
     try:
         to_push =3D trans.delete_patches(lambda pn: pn in patches)
         for pn in to_push:
diff --git a/stgit/commands/edit.py b/stgit/commands/edit.py
index eff9117..c354730 100644
--- a/stgit/commands/edit.py
+++ b/stgit/commands/edit.py
@@ -173,7 +173,8 @@ def func(parser, options, args):
     # The patch applied, so now we have to rewrite the StGit patch
     # (and any patches on top of it).
     iw =3D stack.repository.default_iw
-    trans =3D transaction.StackTransaction(stack, 'stg edit')
+    trans =3D transaction.StackTransaction(stack, 'stg edit',
+                                         allow_conflicts =3D True)
     if patchname in trans.applied:
         popped =3D trans.applied[trans.applied.index(patchname)+1:]
         assert not trans.pop_patches(lambda pn: pn in popped)
diff --git a/stgit/commands/uncommit.py b/stgit/commands/uncommit.py
index 272c5db..b6765bc 100644
--- a/stgit/commands/uncommit.py
+++ b/stgit/commands/uncommit.py
@@ -131,7 +131,8 @@ def func(parser, options, args):
             taken_names.add(pn)
         patchnames.reverse()
=20
-    trans =3D transaction.StackTransaction(stack, 'stg uncommit')
+    trans =3D transaction.StackTransaction(stack, 'stg uncommit',
+                                         allow_conflicts =3D True)
     for commit, pn in zip(commits, patchnames):
         trans.patches[pn] =3D commit
     trans.applied =3D list(reversed(patchnames)) + trans.applied
diff --git a/stgit/lib/transaction.py b/stgit/lib/transaction.py
index 1ece01e..874f81b 100644
--- a/stgit/lib/transaction.py
+++ b/stgit/lib/transaction.py
@@ -34,7 +34,7 @@ class _TransPatchMap(dict):
             return self.__stack.patches.get(pn).commit
=20
 class StackTransaction(object):
-    def __init__(self, stack, msg):
+    def __init__(self, stack, msg, allow_conflicts =3D False):
         self.__stack =3D stack
         self.__msg =3D msg
         self.__patches =3D _TransPatchMap(stack)
@@ -43,6 +43,10 @@ class StackTransaction(object):
         self.__error =3D None
         self.__current_tree =3D self.__stack.head.data.tree
         self.__base =3D self.__stack.base
+        if isinstance(allow_conflicts, bool):
+            self.__allow_conflicts =3D lambda trans: allow_conflicts
+        else:
+            self.__allow_conflicts =3D allow_conflicts
     stack =3D property(lambda self: self.__stack)
     patches =3D property(lambda self: self.__patches)
     def __set_applied(self, val):
@@ -63,10 +67,19 @@ class StackTransaction(object):
                 'This can happen if you modify a branch with git.',
                 '"stg repair --help" explains more about what to do ne=
xt.')
             self.__abort()
-        if self.__current_tree !=3D tree:
-            assert iw !=3D None
-            iw.checkout(self.__current_tree, tree)
-            self.__current_tree =3D tree
+        if self.__current_tree =3D=3D tree:
+            # No tree change, but we still want to make sure that
+            # there are no unresolved conflicts. Conflicts
+            # conceptually "belong" to the topmost patch, and just
+            # carrying them along to another patch is confusing.
+            if (self.__allow_conflicts(self) or iw =3D=3D None
+                or not iw.index.conflicts()):
+                return
+            out.error('Need to resolve conflicts first')
+            self.__abort()
+        assert iw !=3D None
+        iw.checkout(self.__current_tree, tree)
+        self.__current_tree =3D tree
     @staticmethod
     def __abort():
         raise TransactionException(
@@ -214,4 +227,8 @@ class StackTransaction(object):
         self.applied.append(pn)
         out.info('Pushed %s%s' % (pn, s))
         if merge_conflict:
+            # We've just caused conflicts, so we must allow them in
+            # the final checkout.
+            self.__allow_conflicts =3D lambda trans: True
+
             self.__halt('Merge conflict')
