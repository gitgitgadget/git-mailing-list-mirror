From: David =?utf-8?q?K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: [StGit PATCH 08/13] Add a 'bottom' parameter to Series.refresh_patch
	and use it
Date: Sat, 15 Sep 2007 00:31:49 +0200
Message-ID: <20070914223149.7001.39170.stgit@morpheus.local>
References: <20070914222819.7001.55921.stgit@morpheus.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org, catalin.marinas@gmail.com
X-From: git-owner@vger.kernel.org Sat Sep 15 00:32:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IWJho-0001VC-Ru
	for gcvg-git-2@gmane.org; Sat, 15 Sep 2007 00:32:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758198AbXINWbz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 Sep 2007 18:31:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758194AbXINWbz
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Sep 2007 18:31:55 -0400
Received: from mail.lysator.liu.se ([130.236.254.3]:56515 "EHLO
	mail.lysator.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758141AbXINWby (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Sep 2007 18:31:54 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id AF0E1200A1D3;
	Sat, 15 Sep 2007 00:31:52 +0200 (CEST)
Received: from mail.lysator.liu.se ([127.0.0.1])
	by localhost (lenin.lysator.liu.se [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 06982-01-7; Sat, 15 Sep 2007 00:31:50 +0200 (CEST)
Received: from morpheus (c83-253-242-75.bredband.comhem.se [83.253.242.75])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTP id 2AE77200A1CE;
	Sat, 15 Sep 2007 00:31:50 +0200 (CEST)
Received: from morpheus.local (morpheus [127.0.0.1])
	by morpheus (Postfix) with ESMTP id D5A15BFA59;
	Sat, 15 Sep 2007 00:31:49 +0200 (CEST)
In-Reply-To: <20070914222819.7001.55921.stgit@morpheus.local>
User-Agent: StGIT/0.13
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at lysator.liu.se
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58200>

By specifying a bottom for the new patch commit, it is no longer
necessary to update the bottom of the patch before calling
refresh_patch.  This ensures that the patch top always correspond to a
commit object, and the bottom to its parent.

Signed-off-by: David K=C3=A5gedal <davidk@lysator.liu.se>
---

 stgit/stack.py |   24 ++++++++----------------
 1 files changed, 8 insertions(+), 16 deletions(-)


diff --git a/stgit/stack.py b/stgit/stack.py
index 03ce218..fd19a82 100644
--- a/stgit/stack.py
+++ b/stgit/stack.py
@@ -748,7 +748,7 @@ class Series(PatchSet):
                       author_date =3D None,
                       committer_name =3D None, committer_email =3D Non=
e,
                       backup =3D False, sign_str =3D None, log =3D 're=
fresh',
-                      notes =3D None):
+                      notes =3D None, bottom =3D None):
         """Generates a new commit for the topmost patch
         """
         patch =3D self.get_current_patch()
@@ -780,7 +780,8 @@ class Series(PatchSet):
=20
         descr =3D add_sign_line(descr, sign_str, committer_name, commi=
tter_email)
=20
-        bottom =3D patch.get_bottom()
+        if not bottom:
+            bottom =3D patch.get_bottom()
=20
         commit_id =3D git.commit(files =3D files,
                                message =3D descr, parents =3D [bottom]=
,
@@ -1026,20 +1027,15 @@ class Series(PatchSet):
         unapplied =3D self.get_unapplied()
         assert(name in unapplied)
=20
-        patch =3D self.get_patch(name)
+        # patch =3D self.get_patch(name)
         head =3D git.get_head()
=20
-        # The top is updated by refresh_patch since we need an empty
-        # commit
-        patch.set_bottom(head, backup =3D True)
-        patch.set_top(head, backup =3D True)
-
         append_string(self.__applied_file, name)
=20
         unapplied.remove(name)
         write_strings(self.__unapplied_file, unapplied)
=20
-        self.refresh_patch(cache_update =3D False, log =3D 'push(m)')
+        self.refresh_patch(bottom =3D head, cache_update =3D False, lo=
g =3D 'push(m)')
=20
     def push_patch(self, name):
         """Pushes a patch on the stack
@@ -1071,11 +1067,6 @@ class Series(PatchSet):
         ex =3D None
         modified =3D False
=20
-        # new patch needs to be refreshed.
-        # The current patch is empty after merge.
-        patch.set_bottom(head, backup =3D True)
-        patch.set_top(head, backup =3D True)
-
         # Try the fast applying first. If this fails, fall back to the
         # three-way merge
         if not git.apply_diff(bottom, top):
@@ -1103,13 +1094,14 @@ class Series(PatchSet):
                 log =3D 'push(m)'
             else:
                 log =3D 'push'
-            self.refresh_patch(cache_update =3D False, log =3D log)
+            self.refresh_patch(bottom =3D head, cache_update =3D False=
, log =3D log)
         else:
             # we store the correctly merged files only for
             # tracking the conflict history. Note that the
             # git.merge() operations should always leave the index
             # in a valid state (i.e. only stage 0 files)
-            self.refresh_patch(cache_update =3D False, log =3D 'push(c=
)')
+            self.refresh_patch(bottom =3D head, cache_update =3D False=
,
+                               log =3D 'push(c)')
             raise StackException, str(ex)
=20
         return modified
