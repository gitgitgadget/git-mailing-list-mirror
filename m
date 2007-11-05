From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH 4/5] Let "stg clean" use the new infrastructure
Date: Mon, 05 Nov 2007 04:14:54 +0100
Message-ID: <20071105031453.6108.57440.stgit@yoghurt>
References: <20071105030847.6108.44653.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 05 04:15:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IosQp-0002iZ-7t
	for gcvg-git-2@gmane.org; Mon, 05 Nov 2007 04:15:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755798AbXKEDO7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 4 Nov 2007 22:14:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755723AbXKEDO6
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Nov 2007 22:14:58 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2137 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755403AbXKEDO5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Nov 2007 22:14:57 -0500
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1IosQP-0003Gy-00; Mon, 05 Nov 2007 03:14:53 +0000
In-Reply-To: <20071105030847.6108.44653.stgit@yoghurt>
User-Agent: StGIT/0.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63477>

TODO:

  * detect uninitialized stack

  * upgrade stack

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

 stgit/commands/clean.py  |   68 ++++++++++++++++++++++++--------------=
--------
 stgit/commands/common.py |   10 ++++++-
 2 files changed, 44 insertions(+), 34 deletions(-)


diff --git a/stgit/commands/clean.py b/stgit/commands/clean.py
index 4484ecd..ad0b920 100644
--- a/stgit/commands/clean.py
+++ b/stgit/commands/clean.py
@@ -15,14 +15,10 @@ along with this program; if not, write to the Free =
Software
 Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 US=
A
 """
=20
-import sys, os
-from optparse import OptionParser, make_option
-
-from stgit.commands.common import *
-from stgit.utils import *
+from optparse import make_option
 from stgit.out import *
-from stgit import stack, git
-
+from stgit.commands import common
+from stgit.lib import transaction
=20
 help =3D 'delete the empty patches in the series'
 usage =3D """%prog [options]
@@ -31,7 +27,7 @@ Delete the empty patches in the whole series or only =
those applied or
 unapplied. A patch is considered empty if the two commit objects
 representing its boundaries refer to the same tree object."""
=20
-directory =3D DirectoryHasRepository()
+directory =3D common.DirectoryHasRepositoryLib()
 options =3D [make_option('-a', '--applied',
                        help =3D 'delete the empty applied patches',
                        action =3D 'store_true'),
@@ -40,18 +36,35 @@ options =3D [make_option('-a', '--applied',
                        action =3D 'store_true')]
=20
=20
-def __delete_empty(patches, applied):
-    """Delete the empty patches
-    """
-    for p in patches:
-        if crt_series.empty_patch(p):
-            out.start('Deleting patch "%s"' % p)
-            if applied and crt_series.patch_applied(p):
-                crt_series.pop_patch(p)
-            crt_series.delete_patch(p)
-            out.done()
-        elif applied and crt_series.patch_unapplied(p):
-            crt_series.push_patch(p)
+def _clean(stack, clean_applied, clean_unapplied):
+    def deleting(pn):
+        out.info('Deleting empty patch %s' % pn)
+    trans =3D transaction.StackTransaction(stack, 'clean')
+    if clean_unapplied:
+        trans.unapplied =3D []
+        for pn in stack.patchorder.unapplied:
+            p =3D stack.patches.get(pn)
+            if p.is_empty():
+                trans.patches[pn] =3D None
+                deleting(pn)
+            else:
+                trans.unapplied.append[pn]
+    if clean_applied:
+        trans.applied =3D []
+        parent =3D stack.base
+        for pn in stack.patchorder.applied:
+            p =3D stack.patches.get(pn)
+            if p.is_empty():
+                trans.patches[pn] =3D None
+                deleting(pn)
+            else:
+                if parent !=3D p.commit.data.parent:
+                    parent =3D trans.patches[pn] =3D stack.repository.=
commit(
+                        p.commit.data.set_parent(parent))
+                else:
+                    parent =3D p.commit
+                trans.applied.append(pn)
+    trans.run()
=20
 def func(parser, options, args):
     """Delete the empty patches in the series
@@ -59,19 +72,8 @@ def func(parser, options, args):
     if len(args) !=3D 0:
         parser.error('incorrect number of arguments')
=20
-    check_local_changes()
-    check_conflicts()
-    check_head_top_equal(crt_series)
-
     if not (options.applied or options.unapplied):
         options.applied =3D options.unapplied =3D True
=20
-    if options.applied:
-        applied =3D crt_series.get_applied()
-        __delete_empty(applied, True)
-
-    if options.unapplied:
-        unapplied =3D crt_series.get_unapplied()
-        __delete_empty(unapplied, False)
-
-    print_crt_patch(crt_series)
+    _clean(directory.repository.current_stack,
+           options.applied, options.unapplied)
diff --git a/stgit/commands/common.py b/stgit/commands/common.py
index ceeebbc..0a017a8 100644
--- a/stgit/commands/common.py
+++ b/stgit/commands/common.py
@@ -27,7 +27,7 @@ from stgit.out import *
 from stgit.run import *
 from stgit import stack, git, basedir
 from stgit.config import config, file_extensions
-
+from stgit.lib import stack as libstack
=20
 # Command exception class
 class CmdException(StgException):
@@ -537,3 +537,11 @@ class DirectoryGotoToplevel(DirectoryInWorktree):
     def setup(self):
         DirectoryInWorktree.setup(self)
         self.cd_to_topdir()
+
+class DirectoryHasRepositoryLib(_Directory):
+    """For commands that use the new infrastructure in stgit.lib.*."""
+    def __init__(self):
+        self.needs_current_series =3D False
+    def setup(self):
+        # This will throw an exception if we don't have a repository.
+        self.repository =3D libstack.Repository.default()
