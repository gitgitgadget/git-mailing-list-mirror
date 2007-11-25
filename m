From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH 08/10] Let "stg clean" use the new transaction primitives
Date: Sun, 25 Nov 2007 21:51:46 +0100
Message-ID: <20071125205146.7823.47696.stgit@yoghurt>
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
	id 1IwOSx-0003t1-Al
	for gcvg-git-2@gmane.org; Sun, 25 Nov 2007 21:52:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756711AbXKYUvw convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 25 Nov 2007 15:51:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756689AbXKYUvw
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Nov 2007 15:51:52 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:3582 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756709AbXKYUvu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Nov 2007 15:51:50 -0500
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1IwOSB-0007bq-00; Sun, 25 Nov 2007 20:51:47 +0000
In-Reply-To: <20071125203717.7823.70046.stgit@yoghurt>
User-Agent: StGIT/0.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65999>

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

 stgit/commands/clean.py |   33 +++++++--------------------------
 1 files changed, 7 insertions(+), 26 deletions(-)


diff --git a/stgit/commands/clean.py b/stgit/commands/clean.py
index e2d1678..cfcc004 100644
--- a/stgit/commands/clean.py
+++ b/stgit/commands/clean.py
@@ -37,33 +37,14 @@ options =3D [make_option('-a', '--applied',
=20
=20
 def _clean(stack, clean_applied, clean_unapplied):
-    def deleting(pn):
-        out.info('Deleting empty patch %s' % pn)
     trans =3D transaction.StackTransaction(stack, 'clean')
-    if clean_unapplied:
-        trans.unapplied =3D []
-        for pn in stack.patchorder.unapplied:
-            p =3D stack.patches.get(pn)
-            if p.commit.data.is_empty():
-                trans.patches[pn] =3D None
-                deleting(pn)
-            else:
-                trans.unapplied.append(pn)
-    if clean_applied:
-        trans.applied =3D []
-        parent =3D stack.base
-        for pn in stack.patchorder.applied:
-            p =3D stack.patches.get(pn)
-            if p.commit.data.is_empty():
-                trans.patches[pn] =3D None
-                deleting(pn)
-            else:
-                if parent !=3D p.commit.data.parent:
-                    parent =3D trans.patches[pn] =3D stack.repository.=
commit(
-                        p.commit.data.set_parent(parent))
-                else:
-                    parent =3D p.commit
-                trans.applied.append(pn)
+    def del_patch(pn):
+        if pn in stack.patchorder.applied:
+            return clean_applied and trans.patches[pn].data.is_empty()
+        elif pn in stack.patchorder.unapplied:
+            return clean_unapplied and trans.patches[pn].data.is_empty=
()
+    for pn in trans.delete_patches(del_patch):
+        trans.push_patch(pn)
     trans.run()
=20
 def func(parser, options, args):
