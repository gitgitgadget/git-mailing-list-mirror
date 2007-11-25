From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH 09/10] Let "stg goto" use the new infrastructure
Date: Sun, 25 Nov 2007 21:51:53 +0100
Message-ID: <20071125205152.7823.70589.stgit@yoghurt>
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
	id 1IwOSy-0003t1-0Q
	for gcvg-git-2@gmane.org; Sun, 25 Nov 2007 21:52:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756732AbXKYUv6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 25 Nov 2007 15:51:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756689AbXKYUv5
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Nov 2007 15:51:57 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3586 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756727AbXKYUv5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Nov 2007 15:51:57 -0500
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1IwOSH-0007cC-00; Sun, 25 Nov 2007 20:51:53 +0000
In-Reply-To: <20071125203717.7823.70046.stgit@yoghurt>
User-Agent: StGIT/0.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66000>

In the process, it loses the --keep option, since the new
infrastructure always keeps local changes (and aborts cleanly if they
are in the way).

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

 stgit/commands/clean.py |    2 +-
 stgit/commands/goto.py  |   52 ++++++++++++++++-----------------------=
--------
 2 files changed, 19 insertions(+), 35 deletions(-)


diff --git a/stgit/commands/clean.py b/stgit/commands/clean.py
index cfcc004..55ab858 100644
--- a/stgit/commands/clean.py
+++ b/stgit/commands/clean.py
@@ -37,7 +37,7 @@ options =3D [make_option('-a', '--applied',
=20
=20
 def _clean(stack, clean_applied, clean_unapplied):
-    trans =3D transaction.StackTransaction(stack, 'clean')
+    trans =3D transaction.StackTransaction(stack, 'stg clean')
     def del_patch(pn):
         if pn in stack.patchorder.applied:
             return clean_applied and trans.patches[pn].data.is_empty()
diff --git a/stgit/commands/goto.py b/stgit/commands/goto.py
index 84b840b..3ea69dd 100644
--- a/stgit/commands/goto.py
+++ b/stgit/commands/goto.py
@@ -15,13 +15,9 @@ along with this program; if not, write to the Free S=
oftware
 Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA 02111-1307 US=
A
 """
=20
-import sys, os
 from optparse import OptionParser, make_option
-
-from stgit.commands.common import *
-from stgit.utils import *
-from stgit import stack, git
-
+from stgit.commands import common
+from stgit.lib import transaction
=20
 help =3D 'push or pop patches to the given one'
 usage =3D """%prog [options] <name>
@@ -30,38 +26,26 @@ Push/pop patches to/from the stack until the one gi=
ven on the command
 line becomes current. There is no '--undo' option for 'goto'. Use the
 'push --undo' command for this."""
=20
-directory =3D DirectoryGotoToplevel()
-options =3D [make_option('-k', '--keep',
-                       help =3D 'keep the local changes when popping p=
atches',
-                       action =3D 'store_true')]
-
+directory =3D common.DirectoryHasRepositoryLib()
+options =3D []
=20
 def func(parser, options, args):
-    """Pushes the given patch or all onto the series
-    """
     if len(args) !=3D 1:
         parser.error('incorrect number of arguments')
-
-    check_conflicts()
-    check_head_top_equal(crt_series)
-
-    if not options.keep:
-        check_local_changes()
-
-    applied =3D crt_series.get_applied()
-    unapplied =3D crt_series.get_unapplied()
     patch =3D args[0]
=20
-    if patch in applied:
-        applied.reverse()
-        patches =3D applied[:applied.index(patch)]
-        pop_patches(crt_series, patches, options.keep)
-    elif patch in unapplied:
-        if options.keep:
-            raise CmdException, 'Cannot use --keep with patch pushing'
-        patches =3D unapplied[:unapplied.index(patch)+1]
-        push_patches(crt_series, patches)
+    stack =3D directory.repository.current_stack
+    iw =3D stack.repository.default_iw()
+    trans =3D transaction.StackTransaction(stack, 'stg goto')
+    if patch in trans.applied:
+        to_pop =3D set(trans.applied[trans.applied.index(patch)+1:])
+        assert not trans.pop_patches(lambda pn: pn in to_pop)
+    elif patch in trans.unapplied:
+        try:
+            for pn in trans.unapplied[:trans.unapplied.index(patch)+1]=
:
+                trans.push_patch(pn, iw)
+        except transaction.TransactionHalted:
+            pass
     else:
-        raise CmdException, 'Patch "%s" does not exist' % patch
-
-    print_crt_patch(crt_series)
+        raise CmdException('Patch "%s" does not exist' % patch)
+    trans.run(iw)
