From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH 4/5] Convert "stg commit" to new infrastructure
Date: Fri, 14 Dec 2007 07:32:30 +0100
Message-ID: <20071214063230.29290.22561.stgit@yoghurt>
References: <20071214062618.29290.70792.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	David =?utf-8?q?K=C3=A5gedal?= <davidk@lysator.liu.se>
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 14 07:33:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J347G-0003xt-Pq
	for gcvg-git-2@gmane.org; Fri, 14 Dec 2007 07:33:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761475AbXLNGce convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 Dec 2007 01:32:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758280AbXLNGce
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Dec 2007 01:32:34 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4235 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761438AbXLNGcd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Dec 2007 01:32:33 -0500
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1J3461-0002pR-00; Fri, 14 Dec 2007 06:32:29 +0000
In-Reply-To: <20071214062618.29290.70792.stgit@yoghurt>
User-Agent: StGIT/0.14.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68246>

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

 stgit/commands/commit.py |   42 ++++++++++++++------------------------=
----
 stgit/lib/transaction.py |    7 ++++++-
 2 files changed, 20 insertions(+), 29 deletions(-)


diff --git a/stgit/commands/commit.py b/stgit/commands/commit.py
index e56f5a0..f822181 100644
--- a/stgit/commands/commit.py
+++ b/stgit/commands/commit.py
@@ -15,13 +15,9 @@ along with this program; if not, write to the Free S=
oftware
 Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 US=
A
 """
=20
-import sys, os
-from optparse import OptionParser, make_option
-
-from stgit.commands.common import *
-from stgit.utils import *
+from stgit.commands import common
+from stgit.lib import transaction
 from stgit.out import *
-from stgit import stack, git
=20
 help =3D 'permanently store the applied patches into stack base'
 usage =3D """%prog [options]
@@ -32,7 +28,7 @@ remove them from the series while advancing the base.
 Use this command only if you want to permanently store the applied
 patches and no longer manage them with StGIT."""
=20
-directory =3D DirectoryGotoToplevel()
+directory =3D common.DirectoryHasRepositoryLib()
 options =3D []
=20
=20
@@ -43,25 +39,15 @@ def func(parser, options, args):
     if len(args) !=3D 0:
         parser.error('incorrect number of arguments')
=20
-    check_local_changes()
-    check_conflicts()
-    check_head_top_equal(crt_series)
-
-    applied =3D crt_series.get_applied()
-    if not applied:
-        raise CmdException, 'No patches applied'
-
-    if crt_series.get_protected():
-        raise CmdException, 'This branch is protected.  Commit is not =
permitted'
-
-    crt_head =3D git.get_head()
-
-    out.start('Committing %d patches' % len(applied))
-
-    crt_series.pop_patch(applied[0])
-    git.switch(crt_head)
-
-    for patch in applied:
-        crt_series.delete_patch(patch)
-
+    stack =3D directory.repository.current_stack
+    patches =3D stack.patchorder.applied
+    if not patches:
+        raise CmdException('No patches to commit')
+    out.start('Committing %d patches' % len(patches))
+    trans =3D transaction.StackTransaction(stack, 'stg commit')
+    for pn in patches:
+        trans.patches[pn] =3D None
+    trans.applied =3D []
+    trans.base =3D stack.head
+    trans.run()
     out.done()
diff --git a/stgit/lib/transaction.py b/stgit/lib/transaction.py
index 0ca647e..a7c4f7e 100644
--- a/stgit/lib/transaction.py
+++ b/stgit/lib/transaction.py
@@ -41,6 +41,7 @@ class StackTransaction(object):
         self.__unapplied =3D list(self.__stack.patchorder.unapplied)
         self.__error =3D None
         self.__current_tree =3D self.__stack.head.data.tree
+        self.__base =3D self.__stack.base
     stack =3D property(lambda self: self.__stack)
     patches =3D property(lambda self: self.__patches)
     def __set_applied(self, val):
@@ -49,6 +50,10 @@ class StackTransaction(object):
     def __set_unapplied(self, val):
         self.__unapplied =3D list(val)
     unapplied =3D property(lambda self: self.__unapplied, __set_unappl=
ied)
+    def __set_base(self, val):
+        assert not self.__applied
+        self.__base =3D val
+    base =3D property(lambda self: self.__base, __set_base)
     def __checkout(self, tree, iw):
         if not self.__stack.head_top_equal():
             out.error(
@@ -76,7 +81,7 @@ class StackTransaction(object):
         if self.__applied:
             return self.__patches[self.__applied[-1]]
         else:
-            return self.__stack.base
+            return self.__base
     def abort(self, iw =3D None):
         # The only state we need to restore is index+worktree.
         if iw:
