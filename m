From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH 2/2] Check for top == head at the start of every
	transaction
Date: Thu, 28 Aug 2008 00:06:57 +0200
Message-ID: <20080827220657.3607.88972.stgit@yoghurt>
References: <20080827220606.3607.17134.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Erik Sandberg <mandolaerik@gmail.com>, git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Thu Aug 28 00:08:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYTBs-00074M-5X
	for gcvg-git-2@gmane.org; Thu, 28 Aug 2008 00:08:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754388AbYH0WHJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 27 Aug 2008 18:07:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756135AbYH0WHI
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Aug 2008 18:07:08 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1281 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753925AbYH0WHD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2008 18:07:03 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1KYTVq-0007lx-00; Wed, 27 Aug 2008 23:29:15 +0100
In-Reply-To: <20080827220606.3607.17134.stgit@yoghurt>
User-Agent: StGIT/0.14.3.232.g9dfa
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93966>

We used to check it in the run() method, but that's sometimes too
late: for example, it causes stg coalesce to ask for a commit message
_before_ the check, resulting in a lost commit message if the check
fails.

As before, the check can be disabled for the few commands that need
it.

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

 stgit/commands/redo.py     |    3 ++-
 stgit/commands/reset.py    |    3 ++-
 stgit/commands/uncommit.py |    3 ++-
 stgit/commands/undo.py     |    3 ++-
 stgit/lib/transaction.py   |   11 ++++++++---
 t/t2600-coalesce.sh        |    2 +-
 6 files changed, 17 insertions(+), 8 deletions(-)


diff --git a/stgit/commands/redo.py b/stgit/commands/redo.py
index a1075ec..97b7edc 100644
--- a/stgit/commands/redo.py
+++ b/stgit/commands/redo.py
@@ -44,7 +44,8 @@ def func(parser, options, args):
         raise common.CmdException('Bad number of undos to redo')
     state =3D log.undo_state(stack, -options.number)
     trans =3D transaction.StackTransaction(stack, 'redo %d' % options.=
number,
-                                         discard_changes =3D options.h=
ard)
+                                         discard_changes =3D options.h=
ard,
+                                         allow_bad_head =3D True)
     try:
         log.reset_stack(trans, stack.repository.default_iw, state)
     except transaction.TransactionHalted:
diff --git a/stgit/commands/reset.py b/stgit/commands/reset.py
index 2499b26..d79ce70 100644
--- a/stgit/commands/reset.py
+++ b/stgit/commands/reset.py
@@ -56,7 +56,8 @@ def func(parser, options, args):
     else:
         raise common.CmdException('Wrong number of arguments')
     trans =3D transaction.StackTransaction(stack, 'reset',
-                                         discard_changes =3D options.h=
ard)
+                                         discard_changes =3D options.h=
ard,
+                                         allow_bad_head =3D True)
     try:
         if patches:
             log.reset_stack_partially(trans, stack.repository.default_=
iw,
diff --git a/stgit/commands/uncommit.py b/stgit/commands/uncommit.py
index c21306b..3ffdc1e 100644
--- a/stgit/commands/uncommit.py
+++ b/stgit/commands/uncommit.py
@@ -132,7 +132,8 @@ def func(parser, options, args):
         patchnames.reverse()
=20
     trans =3D transaction.StackTransaction(stack, 'uncommit',
-                                         allow_conflicts =3D True)
+                                         allow_conflicts =3D True,
+                                         allow_bad_head =3D True)
     for commit, pn in zip(commits, patchnames):
         trans.patches[pn] =3D commit
     trans.applied =3D list(reversed(patchnames)) + trans.applied
diff --git a/stgit/commands/undo.py b/stgit/commands/undo.py
index 58f1da6..a9cee3a 100644
--- a/stgit/commands/undo.py
+++ b/stgit/commands/undo.py
@@ -41,7 +41,8 @@ def func(parser, options, args):
         raise common.CmdException('Bad number of commands to undo')
     state =3D log.undo_state(stack, options.number)
     trans =3D transaction.StackTransaction(stack, 'undo %d' % options.=
number,
-                                         discard_changes =3D options.h=
ard)
+                                         discard_changes =3D options.h=
ard,
+                                         allow_bad_head =3D True)
     try:
         log.reset_stack(trans, stack.repository.default_iw, state)
     except transaction.TransactionHalted:
diff --git a/stgit/lib/transaction.py b/stgit/lib/transaction.py
index 7c7139c..c6e2db3 100644
--- a/stgit/lib/transaction.py
+++ b/stgit/lib/transaction.py
@@ -75,7 +75,7 @@ class StackTransaction(object):
       your refs and index+worktree, or fail without having done
       anything."""
     def __init__(self, stack, msg, discard_changes =3D False,
-                 allow_conflicts =3D False):
+                 allow_conflicts =3D False, allow_bad_head =3D False):
         """Create a new L{StackTransaction}.
=20
         @param discard_changes: Discard any changes in index+worktree
@@ -99,6 +99,8 @@ class StackTransaction(object):
         else:
             self.__allow_conflicts =3D allow_conflicts
         self.__temp_index =3D self.temp_index_tree =3D None
+        if not allow_bad_head:
+            self.__assert_head_top_equal()
     stack =3D property(lambda self: self.__stack)
     patches =3D property(lambda self: self.__patches)
     def __set_applied(self, val):
@@ -137,13 +139,16 @@ class StackTransaction(object):
     def __set_head(self, val):
         self.__bad_head =3D val
     head =3D property(__get_head, __set_head)
-    def __checkout(self, tree, iw, allow_bad_head):
-        if not (allow_bad_head or self.__stack.head_top_equal()):
+    def __assert_head_top_equal(self):
+        if not self.__stack.head_top_equal():
             out.error(
                 'HEAD and top are not the same.',
                 'This can happen if you modify a branch with git.',
                 '"stg repair --help" explains more about what to do ne=
xt.')
             self.__abort()
+    def __checkout(self, tree, iw, allow_bad_head):
+        if not allow_bad_head:
+            self.__assert_head_top_equal()
         if self.__current_tree =3D=3D tree and not self.__discard_chan=
ges:
             # No tree change, but we still want to make sure that
             # there are no unresolved conflicts. Conflicts
diff --git a/t/t2600-coalesce.sh b/t/t2600-coalesce.sh
index 33c073d..9a043fd 100755
--- a/t/t2600-coalesce.sh
+++ b/t/t2600-coalesce.sh
@@ -33,7 +33,7 @@ cat > editor <<EOF
 echo "Editor was invoked" | tee editor-invoked
 EOF
 chmod a+x editor
-test_expect_failure 'Coalesce with top !=3D head' '
+test_expect_success 'Coalesce with top !=3D head' '
     echo blahonga >> foo.txt &&
     git commit -a -m "a new commit" &&
     EDITOR=3D./editor command_error stg coalesce --name=3Dr0 p0 q1 &&
