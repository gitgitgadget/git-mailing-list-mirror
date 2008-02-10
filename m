From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH 1/2] Convert "stg delete" to the new infrastructure
Date: Sun, 10 Feb 2008 21:48:45 +0100
Message-ID: <20080210204706.17886.69425.stgit@yoghurt>
References: <20080210204628.17886.27365.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	David =?utf-8?q?K=C3=A5gedal?= <davidk@lysator.liu.se>
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sun Feb 10 21:49:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOJ75-0006dS-M6
	for gcvg-git-2@gmane.org; Sun, 10 Feb 2008 21:49:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754827AbYBJUsu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 10 Feb 2008 15:48:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754755AbYBJUst
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Feb 2008 15:48:49 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2855 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754032AbYBJUst (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Feb 2008 15:48:49 -0500
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1JOJ6S-0005G3-00; Sun, 10 Feb 2008 20:48:44 +0000
In-Reply-To: <20080210204628.17886.27365.stgit@yoghurt>
User-Agent: StGIT/0.14.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73411>

In the process, it gains the ability to delete any applied patch (not
just the topmost one, like before), even when deleting patches from
another branch. (However, when deleting patches on another branch, we
obviously can't represent a conflict in the index and worktree, so any
conflicts will make the operation abort.)

One of the t1600 subtests made sure that we couldn't delete
non-topmost patches, and had to be corrected.

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

Unlike the "stg new" conversion, this resulted in a sizeable reduction
of lines of code, and of code complexity.

 stgit/commands/delete.py |   72 +++++++++++++++-----------------------=
--------
 t/t1600-delete-one.sh    |    8 +++--
 2 files changed, 27 insertions(+), 53 deletions(-)


diff --git a/stgit/commands/delete.py b/stgit/commands/delete.py
index 1696cb9..106fbd2 100644
--- a/stgit/commands/delete.py
+++ b/stgit/commands/delete.py
@@ -16,67 +16,41 @@ along with this program; if not, write to the Free =
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
-from stgit.out import *
-from stgit import stack, git
+from optparse import make_option
=20
+from stgit.commands import common
+from stgit.lib import transaction
=20
 help =3D 'delete patches'
 usage =3D """%prog [options] <patch1> [<patch2>] [<patch3>..<patch4>]
=20
-Delete the patches passed as arguments. If an applied patch is to be
-deleted, all other patches applied on top of it must be deleted too,
-and they must be explicitly specified, since this command will not try
-to delete a patch unless you explicitly ask it to. If any applied
-patches are deleted, they are popped from the stack.
+Delete the patches passed as arguments.
=20
 Note that the 'delete' operation is irreversible."""
=20
-directory =3D DirectoryGotoToplevel()
+directory =3D common.DirectoryHasRepositoryLib()
 options =3D [make_option('-b', '--branch',
                        help =3D 'use BRANCH instead of the default one=
')]
=20
 def func(parser, options, args):
-    """Deletes one or more patches.
-    """
-    applied_patches =3D crt_series.get_applied()
-    unapplied_patches =3D crt_series.get_unapplied()
-    all_patches =3D applied_patches + unapplied_patches
-
+    """Delete one or more patches."""
+    if options.branch:
+        stack =3D directory.repository.get_stack(options.branch)
+        iw =3D None # can't use index/workdir to manipulate another br=
anch
+    else:
+        stack =3D directory.repository.current_stack
+        iw =3D stack.repository.default_iw
     if args:
-        patches =3D parse_patches(args, all_patches, len(applied_patch=
es))
+        patches =3D set(common.parse_patches(
+                args, (list(stack.patchorder.applied)
+                       + list(stack.patchorder.unapplied))))
     else:
         parser.error('No patches specified')
-
-    applied =3D []
-
-    # find the applied patches to be deleted. We can only delete
-    # consecutive patches in the applied range
-    for patch in applied_patches[::-1]:
-        if patch in patches:
-            applied.append(patch)
-            patches.remove(patch)
-        else:
-            break
-
-    # any applied patches to be deleted but not in consecutive order?
-    for patch in patches:
-        if patch in applied_patches:
-            raise CmdException, 'Cannot delete the applied patch "%s"'=
 % patch
-
-    if applied and not options.branch:
-        check_local_changes()
-        check_conflicts()
-        check_head_top_equal(crt_series)
-
-    # delete the patches
-    for patch in applied + patches:
-        crt_series.delete_patch(patch)
-        out.info('Patch "%s" successfully deleted' % patch)
-
-    if not options.branch:
-        print_crt_patch(crt_series)
+    trans =3D transaction.StackTransaction(stack, 'stg delete')
+    try:
+        to_push =3D trans.delete_patches(lambda pn: pn in patches)
+        for pn in to_push:
+            trans.push_patch(pn, iw)
+    except transaction.TransactionHalted:
+        pass
+    return trans.run(iw)
diff --git a/t/t1600-delete-one.sh b/t/t1600-delete-one.sh
index 3052b3a..c3451d8 100755
--- a/t/t1600-delete-one.sh
+++ b/t/t1600-delete-one.sh
@@ -77,8 +77,8 @@ test_expect_success \
     'Try to delete a non-topmost applied patch' \
     '
     [ $(stg applied | wc -l) -eq 2 ] &&
-    ! stg delete foo &&
-    [ $(stg applied | wc -l) -eq 2 ]
+    stg delete foo &&
+    [ $(stg applied | wc -l) -eq 1 ]
     '
=20
 test_expect_success \
@@ -99,10 +99,10 @@ test_expect_success \
 test_expect_success \
     'Delete a patch in another branch' \
     '
-    [ $(stg applied | wc -l) -eq 3 ] &&
+    [ $(stg applied | wc -l) -eq 2 ] &&
     [ $(stg applied -b br | wc -l) -eq 1 ] &&
     stg delete -b br baz &&
-    [ $(stg applied | wc -l) -eq 3 ] &&
+    [ $(stg applied | wc -l) -eq 2 ] &&
     [ $(stg applied -b br | wc -l) -eq 0 ]
     '
=20
