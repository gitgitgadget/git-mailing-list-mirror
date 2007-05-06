From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGIT PATCH] Don't use patches/<branch>/current
Date: Sun, 06 May 2007 17:13:44 +0200
Message-ID: <20070506150852.8985.98091.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 06 17:16:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HkiTD-0004dD-CT
	for gcvg-git@gmane.org; Sun, 06 May 2007 17:16:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751581AbXEFPQQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 6 May 2007 11:16:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751555AbXEFPQQ
	(ORCPT <rfc822;git-outgoing>); Sun, 6 May 2007 11:16:16 -0400
Received: from ch-smtp01.sth.basefarm.net ([80.76.149.212]:52484 "EHLO
	ch-smtp01.sth.basefarm.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751276AbXEFPQP (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 6 May 2007 11:16:15 -0400
Received: from c83-250-140-11.bredband.comhem.se ([83.250.140.11]:37101 helo=yoghurt)
	by ch-smtp01.sth.basefarm.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.66)
	(envelope-from <kha@treskal.com>)
	id 1HkiT7-0002M2-5R; Sun, 06 May 2007 17:16:14 +0200
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by yoghurt with esmtp (Exim 4.62)
	(envelope-from <kha@treskal.com>)
	id 1HkiQi-0002ND-QZ; Sun, 06 May 2007 17:13:44 +0200
User-Agent: StGIT/0.12
X-Scan-Result: No virus found in message 1HkiT7-0002M2-5R.
X-Scan-Signature: ch-smtp01.sth.basefarm.net 1HkiT7-0002M2-5R 572b2bc9f2b8cae50d343bc0fb460399
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46339>

The name of the current patch, if any, is always the last line of
patches/<branch>/applied (and there is no current patch if and only if
the "applied" file is empty). So use that instead, and stop having to
worry about keeping the redundant "current" file up-to-date.

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>
---

This is another remove-redundant-metadata cleanup patch. Not only does
it remove more code than it adds, the removed code (mostly calls to
__set_current) is the kind that one easily forgets to insert in the
proper places when writing new code.

 stgit/stack.py |   35 +++++++++--------------------------
 1 files changed, 9 insertions(+), 26 deletions(-)

diff --git a/stgit/stack.py b/stgit/stack.py
index 2477ac6..3e9fc4f 100644
--- a/stgit/stack.py
+++ b/stgit/stack.py
@@ -295,7 +295,6 @@ class Series(StgitObject):
         self.__applied_file =3D os.path.join(self._dir(), 'applied')
         self.__unapplied_file =3D os.path.join(self._dir(), 'unapplied=
')
         self.__hidden_file =3D os.path.join(self._dir(), 'hidden')
-        self.__current_file =3D os.path.join(self._dir(), 'current')
         self.__descr_file =3D os.path.join(self._dir(), 'description')
=20
         # where this series keeps its patches
@@ -325,11 +324,6 @@ class Series(StgitObject):
         """
         return self.__name
=20
-    def __set_current(self, name):
-        """Sets the topmost patch
-        """
-        self._set_field('current', name)
-
     def get_patch(self, name):
         """Return a Patch object for the given name
         """
@@ -346,11 +340,16 @@ class Series(StgitObject):
     def get_current(self):
         """Return the name of the topmost patch, or None if there is
         no such patch."""
-        name =3D self._get_field('current')
-        if name =3D=3D '':
+        try:
+            applied =3D self.get_applied()
+        except StackException:
+            # No "applied" file: branch is not initialized.
+            return None
+        try:
+            return applied[-1]
+        except IndexError:
+            # No patches applied.
             return None
-        else:
-            return name
=20
     def get_applied(self):
         if not os.path.isfile(self.__applied_file):
@@ -650,8 +649,6 @@ class Series(StgitObject):
                 os.remove(self.__unapplied_file)
             if os.path.exists(self.__hidden_file):
                 os.remove(self.__hidden_file)
-            if os.path.exists(self.__current_file):
-                os.remove(self.__current_file)
             if os.path.exists(self.__descr_file):
                 os.remove(self.__descr_file)
             if os.path.exists(self._dir()+'/orig-base'):
@@ -825,11 +822,8 @@ class Series(StgitObject):
             self.log_patch(patch, 'new')
=20
             insert_string(self.__applied_file, patch.get_name())
-            if not self.get_current():
-                self.__set_current(name)
         else:
             append_string(self.__applied_file, patch.get_name())
-            self.__set_current(name)
             if refresh:
                 self.refresh_patch(cache_update =3D False, log =3D 'ne=
w')
=20
@@ -936,8 +930,6 @@ class Series(StgitObject):
         f.writelines([line + '\n' for line in unapplied])
         f.close()
=20
-        self.__set_current(name)
-
         return forwarded
=20
     def merged_patches(self, names):
@@ -1019,8 +1011,6 @@ class Series(StgitObject):
         f.writelines([line + '\n' for line in unapplied])
         f.close()
=20
-        self.__set_current(name)
-
         # head =3D=3D bottom case doesn't need to refresh the patch
         if empty or head !=3D bottom:
             if not ex:
@@ -1098,11 +1088,6 @@ class Series(StgitObject):
         f.writelines([line + '\n' for line in applied])
         f.close()
=20
-        if applied =3D=3D []:
-            self.__set_current(None)
-        else:
-            self.__set_current(applied[-1])
-
     def empty_patch(self, name):
         """Returns True if the patch is empty
         """
@@ -1144,8 +1129,6 @@ class Series(StgitObject):
             f.close()
         elif oldname in applied:
             Patch(oldname, self.__patch_dir, self.__refs_dir).rename(n=
ewname)
-            if oldname =3D=3D self.get_current():
-                self.__set_current(newname)
=20
             applied[applied.index(oldname)] =3D newname
=20
