From: David =?utf-8?q?K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: [StGit PATCH 13/13] Remove the 'top' field
Date: Sat, 15 Sep 2007 00:32:15 +0200
Message-ID: <20070914223215.7001.80066.stgit@morpheus.local>
References: <20070914222819.7001.55921.stgit@morpheus.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org, catalin.marinas@gmail.com
X-From: git-owner@vger.kernel.org Sat Sep 15 00:33:05 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IWJiQ-0001cu-RR
	for gcvg-git-2@gmane.org; Sat, 15 Sep 2007 00:32:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758454AbXINWcW convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 Sep 2007 18:32:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758371AbXINWcU
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Sep 2007 18:32:20 -0400
Received: from mail.lysator.liu.se ([130.236.254.3]:56529 "EHLO
	mail.lysator.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758273AbXINWcR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Sep 2007 18:32:17 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id AED32200A1D3;
	Sat, 15 Sep 2007 00:32:16 +0200 (CEST)
Received: from mail.lysator.liu.se ([127.0.0.1])
	by localhost (lenin.lysator.liu.se [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 05544-01-44; Sat, 15 Sep 2007 00:32:15 +0200 (CEST)
Received: from morpheus (c83-253-242-75.bredband.comhem.se [83.253.242.75])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTP id 86331200A1CE;
	Sat, 15 Sep 2007 00:32:15 +0200 (CEST)
Received: from morpheus.local (morpheus [127.0.0.1])
	by morpheus (Postfix) with ESMTP id 3F670BFA59;
	Sat, 15 Sep 2007 00:32:15 +0200 (CEST)
In-Reply-To: <20070914222819.7001.55921.stgit@morpheus.local>
User-Agent: StGIT/0.13
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at lysator.liu.se
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58205>

The top is instead implicitly defined by the patch ref.

Signed-off-by: David K=C3=A5gedal <davidk@lysator.liu.se>
---

 stgit/stack.py |   26 +++++++++-----------------
 1 files changed, 9 insertions(+), 17 deletions(-)


diff --git a/stgit/stack.py b/stgit/stack.py
index 00b91c6..94d3eee 100644
--- a/stgit/stack.py
+++ b/stgit/stack.py
@@ -158,7 +158,6 @@ class Patch(StgitObject):
=20
     def create(self):
         os.mkdir(self._dir())
-        self.create_empty_field('top')
=20
     def delete(self):
         for f in os.listdir(self._dir()):
@@ -190,11 +189,6 @@ class Patch(StgitObject):
     def __update_log_ref(self, ref):
         git.set_ref(self.__log_ref, ref)
=20
-    def update_top_ref(self):
-        top =3D self.get_top()
-        if top:
-            self.__update_top_ref(top)
-
     def get_old_bottom(self):
         return git.get_commit(self.get_old_top()).get_parent()
=20
@@ -205,26 +199,18 @@ class Patch(StgitObject):
         return self._get_field('top.old')
=20
     def get_top(self):
-        top =3D self._get_field('top')
-        try:
-            ref =3D git.rev_parse(self.__top_ref)
-        except:
-            ref =3D None
-        assert not ref or top =3D=3D ref
-        return top
+        return git.rev_parse(self.__top_ref)
=20
     def set_top(self, value, backup =3D False):
         if backup:
-            curr =3D self._get_field('top')
+            curr =3D self.get_top()
             self._set_field('top.old', curr)
-        self._set_field('top', value)
         self.__update_top_ref(value)
=20
     def restore_old_boundaries(self):
         top =3D self._get_field('top.old')
=20
         if top:
-            self._set_field('top', top)
             self.__update_top_ref(top)
             return True
         else:
@@ -436,7 +422,13 @@ class Series(PatchSet):
                 patch =3D patch.strip()
                 os.rename(os.path.join(branch_dir, patch),
                           os.path.join(patch_dir, patch))
-                Patch(patch, patch_dir, refs_base).update_top_ref()
+                topfield =3D os.path.join(patch_dir, patch, 'top')
+                if os.path.isfile(topfield):
+                    top =3D read_string(topfield, False)
+                else:
+                    top =3D None
+                if top:
+                    git.set_ref(refs_base + '/' + patch, top)
             set_format_version(1)
=20
         # Update 1 -> 2.
