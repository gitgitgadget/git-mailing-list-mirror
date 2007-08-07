From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGIT PATCH 1/5] Make use of the get_patch() utility function
Date: Tue, 07 Aug 2007 04:47:44 +0200
Message-ID: <20070807024744.11373.31514.stgit@yoghurt>
References: <20070807024508.11373.62875.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Tue Aug 07 04:47:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IIF6u-0005F2-CG
	for gcvg-git@gmane.org; Tue, 07 Aug 2007 04:47:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1765931AbXHGCrr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Mon, 6 Aug 2007 22:47:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1765921AbXHGCrr
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Aug 2007 22:47:47 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2237 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1765860AbXHGCrq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Aug 2007 22:47:46 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1IIF6n-0002U8-00; Tue, 07 Aug 2007 03:47:45 +0100
In-Reply-To: <20070807024508.11373.62875.stgit@yoghurt>
User-Agent: StGIT/0.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55206>

We already had it, but no one was using it

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

 stgit/stack.py |   27 +++++++++++++--------------
 1 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/stgit/stack.py b/stgit/stack.py
index dbd7ea4..6f87f28 100644
--- a/stgit/stack.py
+++ b/stgit/stack.py
@@ -466,7 +466,7 @@ class Series(PatchSet):
         crt =3D self.get_current()
         if not crt:
             return None
-        return Patch(crt, self.__patch_dir, self.__refs_dir)
+        return self.get_patch(crt)
=20
     def get_current(self):
         """Return the name of the topmost patch, or None if there is
@@ -684,7 +684,7 @@ class Series(PatchSet):
                 raise StackException, \
                       'Cannot delete: the series still contains patche=
s'
             for p in patches:
-                Patch(p, self.__patch_dir, self.__refs_dir).delete()
+                self.get_patch(p).delete()
=20
             # remove the trash directory if any
             if os.path.exists(self.__trash_dir):
@@ -741,7 +741,7 @@ class Series(PatchSet):
         if not name:
             raise StackException, 'No patches applied'
=20
-        patch =3D Patch(name, self.__patch_dir, self.__refs_dir)
+        patch =3D self.get_patch(name)
=20
         descr =3D patch.get_description()
         if not (message or descr):
@@ -807,7 +807,7 @@ class Series(PatchSet):
         name =3D self.get_current()
         assert(name)
=20
-        patch =3D Patch(name, self.__patch_dir, self.__refs_dir)
+        patch =3D self.get_patch(name)
         old_bottom =3D patch.get_old_bottom()
         old_top =3D patch.get_old_top()
=20
@@ -848,7 +848,7 @@ class Series(PatchSet):
         if name =3D=3D None:
             name =3D make_patch_name(descr, self.patch_exists)
=20
-        patch =3D Patch(name, self.__patch_dir, self.__refs_dir)
+        patch =3D self.get_patch(name)
         patch.create()
=20
         if not bottom:
@@ -936,7 +936,7 @@ class Series(PatchSet):
         for name in names:
             assert(name in unapplied)
=20
-            patch =3D Patch(name, self.__patch_dir, self.__refs_dir)
+            patch =3D self.get_patch(name)
=20
             head =3D top
             bottom =3D patch.get_bottom()
@@ -1002,8 +1002,7 @@ class Series(PatchSet):
         patches detected to have been applied. The state of the tree
         is restored to the original one
         """
-        patches =3D [Patch(name, self.__patch_dir, self.__refs_dir)
-                   for name in names]
+        patches =3D [self.get_patch(name) for name in names]
         patches.reverse()
=20
         merged =3D []
@@ -1022,7 +1021,7 @@ class Series(PatchSet):
         unapplied =3D self.get_unapplied()
         assert(name in unapplied)
=20
-        patch =3D Patch(name, self.__patch_dir, self.__refs_dir)
+        patch =3D self.get_patch(name)
=20
         head =3D git.get_head()
         bottom =3D patch.get_bottom()
@@ -1096,7 +1095,7 @@ class Series(PatchSet):
         name =3D self.get_current()
         assert(name)
=20
-        patch =3D Patch(name, self.__patch_dir, self.__refs_dir)
+        patch =3D self.get_patch(name)
         old_bottom =3D patch.get_old_bottom()
         old_top =3D patch.get_old_top()
=20
@@ -1122,7 +1121,7 @@ class Series(PatchSet):
         applied.reverse()
         assert(name in applied)
=20
-        patch =3D Patch(name, self.__patch_dir, self.__refs_dir)
+        patch =3D self.get_patch(name)
=20
         if git.get_head_file() =3D=3D self.get_name():
             if keep and not git.apply_diff(git.get_head(), patch.get_b=
ottom()):
@@ -1148,7 +1147,7 @@ class Series(PatchSet):
         """Returns True if the patch is empty
         """
         self.__patch_name_valid(name)
-        patch =3D Patch(name, self.__patch_dir, self.__refs_dir)
+        patch =3D self.get_patch(name)
         bottom =3D patch.get_bottom()
         top =3D patch.get_top()
=20
@@ -1173,11 +1172,11 @@ class Series(PatchSet):
             raise StackException, 'Patch "%s" already exists' % newnam=
e
=20
         if oldname in unapplied:
-            Patch(oldname, self.__patch_dir, self.__refs_dir).rename(n=
ewname)
+            self.get_patch(oldname).rename(newname)
             unapplied[unapplied.index(oldname)] =3D newname
             write_strings(self.__unapplied_file, unapplied)
         elif oldname in applied:
-            Patch(oldname, self.__patch_dir, self.__refs_dir).rename(n=
ewname)
+            self.get_patch(oldname).rename(newname)
=20
             applied[applied.index(oldname)] =3D newname
             write_strings(self.__applied_file, applied)
