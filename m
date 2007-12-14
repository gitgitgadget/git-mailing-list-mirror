From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH 2/5] stg coalesce: Support --file and --save-template
Date: Fri, 14 Dec 2007 07:32:19 +0100
Message-ID: <20071214063219.29290.24743.stgit@yoghurt>
References: <20071214062618.29290.70792.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org,
	David =?utf-8?q?K=C3=A5gedal?= <davidk@lysator.liu.se>
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 14 07:32:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J346E-0003fp-Ra
	for gcvg-git-2@gmane.org; Fri, 14 Dec 2007 07:32:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760887AbXLNGcX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 Dec 2007 01:32:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758375AbXLNGcX
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Dec 2007 01:32:23 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4227 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756551AbXLNGcW (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Dec 2007 01:32:22 -0500
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1J345q-0002p1-00; Fri, 14 Dec 2007 06:32:18 +0000
In-Reply-To: <20071214062618.29290.70792.stgit@yoghurt>
User-Agent: StGIT/0.14.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68242>

--save-template was a bit tricky, because we want that

  * if we reached the stage where the message is needed without
    conflicts, the message should be written and no other side effects
    should occur; but

  * if we run into conflicts before reaching that point, behave just
    as if --save-template was not given.

This makes this script

  stg coalesce --save-template <patches>
  if template was saved:
    let user edit template
    if user didn't abort:
      stg coalesce --file <patches>

equivalent to

  stg coalesce <patches>

with the added benefit that the user can abort the whole thing without
visible side effects.

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

 stgit/commands/coalesce.py |   28 +++++++++++++++++++---------
 1 files changed, 19 insertions(+), 9 deletions(-)


diff --git a/stgit/commands/coalesce.py b/stgit/commands/coalesce.py
index e3e1629..2330231 100644
--- a/stgit/commands/coalesce.py
+++ b/stgit/commands/coalesce.py
@@ -34,11 +34,13 @@ you specify, you will have to resolve them manually=
 just as if you had
 done a sequence of pushes and pops yourself."""
=20
 directory =3D common.DirectoryHasRepositoryLib()
-options =3D [make_option('-n', '--name', help =3D 'name of coalesced p=
atch'),
-           make_option('-m', '--message',
-                       help =3D 'commit message of coalesced patch')]
+options =3D [make_option('-n', '--name', help =3D 'name of coalesced p=
atch')
+           ] + utils.make_message_options()
=20
-def _coalesce_patches(trans, patches, msg):
+class SaveTemplateDone(Exception):
+    pass
+
+def _coalesce_patches(trans, patches, msg, save_template):
     cd =3D trans.patches[patches[0]].data
     cd =3D git.Commitdata(tree =3D cd.tree, parents =3D cd.parents)
     for pn in patches[1:]:
@@ -53,12 +55,16 @@ def _coalesce_patches(trans, patches, msg):
         msg =3D '\n\n'.join('%s\n\n%s' % (pn.ljust(70, '-'),
                                         trans.patches[pn].data.message=
)
                           for pn in patches)
-        msg =3D utils.edit_string(msg, '.stgit-coalesce.txt').strip()
+        if save_template:
+            save_template(msg)
+            raise SaveTemplateDone()
+        else:
+            msg =3D utils.edit_string(msg, '.stgit-coalesce.txt').stri=
p()
     cd =3D cd.set_message(msg)
=20
     return cd
=20
-def _coalesce(stack, iw, name, msg, patches):
+def _coalesce(stack, iw, name, msg, save_template, patches):
=20
     # If a name was supplied on the command line, make sure it's OK.
     def bad_name(pn):
@@ -75,8 +81,8 @@ def _coalesce(stack, iw, name, msg, patches):
=20
     trans =3D transaction.StackTransaction(stack, 'stg coalesce')
     push_new_patch =3D bool(set(patches) & set(trans.applied))
-    new_commit_data =3D _coalesce_patches(trans, patches, msg)
     try:
+        new_commit_data =3D _coalesce_patches(trans, patches, msg, sav=
e_template)
         if new_commit_data:
             # We were able to construct the coalesced commit
             # automatically. So just delete its constituent patches.
@@ -88,7 +94,8 @@ def _coalesce(stack, iw, name, msg, patches):
             to_push =3D trans.pop_patches(lambda pn: pn in patches)
             for pn in patches:
                 trans.push_patch(pn, iw)
-            new_commit_data =3D _coalesce_patches(trans, patches, msg)
+            new_commit_data =3D _coalesce_patches(trans, patches, msg,
+                                                save_template)
             assert not trans.delete_patches(lambda pn: pn in patches)
         make_coalesced_patch(trans, new_commit_data)
=20
@@ -98,6 +105,9 @@ def _coalesce(stack, iw, name, msg, patches):
             trans.push_patch(get_name(new_commit_data), iw)
         for pn in to_push:
             trans.push_patch(pn, iw)
+    except SaveTemplateDone:
+        trans.abort(iw)
+        return
     except transaction.TransactionHalted:
         pass
     trans.run(iw)
@@ -109,4 +119,4 @@ def func(parser, options, args):
     if len(patches) < 2:
         raise common.CmdException('Need at least two patches')
     _coalesce(stack, stack.repository.default_iw(),
-              options.name, options.message, patches)
+              options.name, options.message, options.save_template, pa=
tches)
