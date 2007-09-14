From: David =?utf-8?q?K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: [StGit PATCH 12/13] Remove the 'bottom' field
Date: Sat, 15 Sep 2007 00:32:10 +0200
Message-ID: <20070914223210.7001.67124.stgit@morpheus.local>
References: <20070914222819.7001.55921.stgit@morpheus.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org, catalin.marinas@gmail.com
X-From: git-owner@vger.kernel.org Sat Sep 15 00:32:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IWJi0-0001Ys-Pn
	for gcvg-git-2@gmane.org; Sat, 15 Sep 2007 00:32:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758297AbXINWcR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 Sep 2007 18:32:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758308AbXINWcQ
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Sep 2007 18:32:16 -0400
Received: from mail.lysator.liu.se ([130.236.254.3]:56525 "EHLO
	mail.lysator.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758194AbXINWcM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Sep 2007 18:32:12 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id B7E9C200A1CE;
	Sat, 15 Sep 2007 00:32:11 +0200 (CEST)
Received: from mail.lysator.liu.se ([127.0.0.1])
	by localhost (lenin.lysator.liu.se [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 02165-01-84; Sat, 15 Sep 2007 00:32:10 +0200 (CEST)
Received: from morpheus (c83-253-242-75.bredband.comhem.se [83.253.242.75])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTP id 8EAA7200A1D7;
	Sat, 15 Sep 2007 00:32:10 +0200 (CEST)
Received: from morpheus.local (morpheus [127.0.0.1])
	by morpheus (Postfix) with ESMTP id 311C5BFA59;
	Sat, 15 Sep 2007 00:32:10 +0200 (CEST)
In-Reply-To: <20070914222819.7001.55921.stgit@morpheus.local>
User-Agent: StGIT/0.13
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at lysator.liu.se
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58201>

The bottom is instead always calculated from the top by getting its
parent commit.

Signed-off-by: David K=C3=A5gedal <davidk@lysator.liu.se>
---

 stgit/commands/sync.py |    1 -
 stgit/stack.py         |   29 +++--------------------------
 2 files changed, 3 insertions(+), 27 deletions(-)


diff --git a/stgit/commands/sync.py b/stgit/commands/sync.py
index 580b5bd..c18d7e0 100644
--- a/stgit/commands/sync.py
+++ b/stgit/commands/sync.py
@@ -148,7 +148,6 @@ def func(parser, options, args):
=20
         # reset the patch backup information. That's needed in case we
         # undo the sync but there were no changes made
-        patch.set_bottom(bottom, backup =3D True)
         patch.set_top(top, backup =3D True)
=20
         # the actual merging (either from a branch or an external file=
)
diff --git a/stgit/stack.py b/stgit/stack.py
index d9a2e56..00b91c6 100644
--- a/stgit/stack.py
+++ b/stgit/stack.py
@@ -158,7 +158,6 @@ class Patch(StgitObject):
=20
     def create(self):
         os.mkdir(self._dir())
-        self.create_empty_field('bottom')
         self.create_empty_field('top')
=20
     def delete(self):
@@ -197,22 +196,10 @@ class Patch(StgitObject):
             self.__update_top_ref(top)
=20
     def get_old_bottom(self):
-        old_bottom =3D self._get_field('bottom.old')
-        old_top =3D self.get_old_top()
-        assert old_bottom =3D=3D git.get_commit(old_top).get_parent()
-        return old_bottom
+        return git.get_commit(self.get_old_top()).get_parent()
=20
     def get_bottom(self):
-        bottom =3D self._get_field('bottom')
-        top =3D self.get_top()
-        assert bottom =3D=3D git.get_commit(top).get_parent()
-        return self._get_field('bottom')
-
-    def set_bottom(self, value, backup =3D False):
-        if backup:
-            curr =3D self._get_field('bottom')
-            self._set_field('bottom.old', curr)
-        self._set_field('bottom', value)
+        return git.get_commit(self.get_top()).get_parent()
=20
     def get_old_top(self):
         return self._get_field('top.old')
@@ -232,14 +219,11 @@ class Patch(StgitObject):
             self._set_field('top.old', curr)
         self._set_field('top', value)
         self.__update_top_ref(value)
-        self.get_bottom() # check the assert
=20
     def restore_old_boundaries(self):
-        bottom =3D self._get_field('bottom.old')
         top =3D self._get_field('top.old')
=20
-        if top and bottom:
-            self._set_field('bottom', bottom)
+        if top:
             self._set_field('top', top)
             self.__update_top_ref(top)
             return True
@@ -806,7 +790,6 @@ class Series(PatchSet):
                                committer_name =3D committer_name,
                                committer_email =3D committer_email)
=20
-        patch.set_bottom(bottom, backup =3D backup)
         patch.set_top(commit_id, backup =3D backup)
         patch.set_description(descr)
         patch.set_authname(author_name)
@@ -914,11 +897,8 @@ class Series(PatchSet):
                                    committer_name =3D committer_name,
                                    committer_email =3D committer_email=
)
             # set the patch top to the new commit
-            patch.set_bottom(bottom)
             patch.set_top(commit_id)
         else:
-            assert top !=3D bottom
-            patch.set_bottom(bottom)
             patch.set_top(top)
=20
         self.log_patch(patch, 'new')
@@ -972,7 +952,6 @@ class Series(PatchSet):
             if head =3D=3D bottom:
                 # reset the backup information. No logging since the
                 # patch hasn't changed
-                patch.set_bottom(head, backup =3D True)
                 patch.set_top(top, backup =3D True)
=20
             else:
@@ -1000,7 +979,6 @@ class Series(PatchSet):
                                      committer_name =3D committer_name=
,
                                      committer_email =3D committer_ema=
il)
=20
-                    patch.set_bottom(head, backup =3D True)
                     patch.set_top(top, backup =3D True)
=20
                     self.log_patch(patch, 'push(f)')
@@ -1073,7 +1051,6 @@ class Series(PatchSet):
         if head =3D=3D bottom:
             # A fast-forward push. Just reset the backup
             # information. No need for logging
-            patch.set_bottom(bottom, backup =3D True)
             patch.set_top(top, backup =3D True)
=20
             git.switch(top)
