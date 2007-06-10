From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGIT PATCH 2/6] Make use of the get_patch() utility function
Date: Sun, 10 Jun 2007 02:55:02 -0700
Message-ID: <20070610095502.12000.56056.stgit@bill>
References: <20070610094322.12000.56284.stgit@bill>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 10 11:55:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HxK8c-0006cM-Tx
	for gcvg-git@gmane.org; Sun, 10 Jun 2007 11:55:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752830AbXFJJzJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 10 Jun 2007 05:55:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752648AbXFJJzI
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Jun 2007 05:55:08 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1827 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752526AbXFJJzH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Jun 2007 05:55:07 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1HxK8V-0008RU-00; Sun, 10 Jun 2007 10:55:04 +0100
In-Reply-To: <20070610094322.12000.56284.stgit@bill>
User-Agent: StGIT/0.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49701>

We already had it, but no one was using it

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>
---

 stgit/stack.py |   27 +++++++++++++--------------
 1 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/stgit/stack.py b/stgit/stack.py
index 7a06458..0a486bd 100644
--- a/stgit/stack.py
+++ b/stgit/stack.py
@@ -404,7 +404,7 @@ class Series(StgitObject):
         crt =3D self.get_current()
         if not crt:
             return None
-        return Patch(crt, self.__patch_dir, self.__refs_dir)
+        return self.get_patch(crt)
=20
     def get_current(self):
         """Return the name of the topmost patch, or None if there is
@@ -678,7 +678,7 @@ class Series(StgitObject):
                 raise StackException, \
                       'Cannot delete: the series still contains patche=
s'
             for p in patches:
-                Patch(p, self.__patch_dir, self.__refs_dir).delete()
+                self.get_patch(p).delete()
=20
             # remove the trash directory
             for fname in os.listdir(self.__trash_dir):
@@ -732,7 +732,7 @@ class Series(StgitObject):
         if not name:
             raise StackException, 'No patches applied'
=20
-        patch =3D Patch(name, self.__patch_dir, self.__refs_dir)
+        patch =3D self.get_patch(name)
=20
         descr =3D patch.get_description()
         if not (message or descr):
@@ -798,7 +798,7 @@ class Series(StgitObject):
         name =3D self.get_current()
         assert(name)
=20
-        patch =3D Patch(name, self.__patch_dir, self.__refs_dir)
+        patch =3D self.get_patch(name)
         old_bottom =3D patch.get_old_bottom()
         old_top =3D patch.get_old_top()
=20
@@ -839,7 +839,7 @@ class Series(StgitObject):
         if name =3D=3D None:
             name =3D make_patch_name(descr, self.patch_exists)
=20
-        patch =3D Patch(name, self.__patch_dir, self.__refs_dir)
+        patch =3D self.get_patch(name)
         patch.create()
=20
         if bottom:
@@ -919,7 +919,7 @@ class Series(StgitObject):
         for name in names:
             assert(name in unapplied)
=20
-            patch =3D Patch(name, self.__patch_dir, self.__refs_dir)
+            patch =3D self.get_patch(name)
=20
             head =3D top
             bottom =3D patch.get_bottom()
@@ -988,8 +988,7 @@ class Series(StgitObject):
         patches detected to have been applied. The state of the tree
         is restored to the original one
         """
-        patches =3D [Patch(name, self.__patch_dir, self.__refs_dir)
-                   for name in names]
+        patches =3D [self.get_patch(name) for name in names]
         patches.reverse()
=20
         merged =3D []
@@ -1008,7 +1007,7 @@ class Series(StgitObject):
         unapplied =3D self.get_unapplied()
         assert(name in unapplied)
=20
-        patch =3D Patch(name, self.__patch_dir, self.__refs_dir)
+        patch =3D self.get_patch(name)
=20
         head =3D git.get_head()
         bottom =3D patch.get_bottom()
@@ -1084,7 +1083,7 @@ class Series(StgitObject):
         name =3D self.get_current()
         assert(name)
=20
-        patch =3D Patch(name, self.__patch_dir, self.__refs_dir)
+        patch =3D self.get_patch(name)
         old_bottom =3D patch.get_old_bottom()
         old_top =3D patch.get_old_top()
=20
@@ -1110,7 +1109,7 @@ class Series(StgitObject):
         applied.reverse()
         assert(name in applied)
=20
-        patch =3D Patch(name, self.__patch_dir, self.__refs_dir)
+        patch =3D self.get_patch(name)
=20
         if git.get_head_file() =3D=3D self.get_branch():
             if keep and not git.apply_diff(git.get_head(), patch.get_b=
ottom()):
@@ -1142,7 +1141,7 @@ class Series(StgitObject):
         """Returns True if the patch is empty
         """
         self.__patch_name_valid(name)
-        patch =3D Patch(name, self.__patch_dir, self.__refs_dir)
+        patch =3D self.get_patch(name)
         bottom =3D patch.get_bottom()
         top =3D patch.get_top()
=20
@@ -1171,14 +1170,14 @@ class Series(StgitObject):
             self.hide_patch(newname)
=20
         if oldname in unapplied:
-            Patch(oldname, self.__patch_dir, self.__refs_dir).rename(n=
ewname)
+            self.get_patch(oldname).rename(newname)
             unapplied[unapplied.index(oldname)] =3D newname
=20
             f =3D file(self.__unapplied_file, 'w+')
             f.writelines([line + '\n' for line in unapplied])
             f.close()
         elif oldname in applied:
-            Patch(oldname, self.__patch_dir, self.__refs_dir).rename(n=
ewname)
+            self.get_patch(oldname).rename(newname)
=20
             applied[applied.index(oldname)] =3D newname
=20
