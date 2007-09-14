From: David =?utf-8?q?K=C3=A5gedal?= <davidk@lysator.liu.se>
Subject: [StGit PATCH 06/13] Refactor Series.push_patch
Date: Sat, 15 Sep 2007 00:31:39 +0200
Message-ID: <20070914223139.7001.14801.stgit@morpheus.local>
References: <20070914222819.7001.55921.stgit@morpheus.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org, catalin.marinas@gmail.com
X-From: git-owner@vger.kernel.org Sat Sep 15 00:31:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IWJhR-0001NS-0u
	for gcvg-git-2@gmane.org; Sat, 15 Sep 2007 00:31:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758100AbXINWbn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 Sep 2007 18:31:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758072AbXINWbn
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Sep 2007 18:31:43 -0400
Received: from mail.lysator.liu.se ([130.236.254.3]:56508 "EHLO
	mail.lysator.liu.se" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751941AbXINWbm (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Sep 2007 18:31:42 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.lysator.liu.se (Postfix) with ESMTP id 39E30200A1D7;
	Sat, 15 Sep 2007 00:31:41 +0200 (CEST)
Received: from mail.lysator.liu.se ([127.0.0.1])
	by localhost (lenin.lysator.liu.se [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 06982-01-6; Sat, 15 Sep 2007 00:31:40 +0200 (CEST)
Received: from morpheus (c83-253-242-75.bredband.comhem.se [83.253.242.75])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.lysator.liu.se (Postfix) with ESMTP id 06CBA200A1CE;
	Sat, 15 Sep 2007 00:31:40 +0200 (CEST)
Received: from morpheus.local (morpheus [127.0.0.1])
	by morpheus (Postfix) with ESMTP id AE359BFA59;
	Sat, 15 Sep 2007 00:31:39 +0200 (CEST)
In-Reply-To: <20070914222819.7001.55921.stgit@morpheus.local>
User-Agent: StGIT/0.13
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at lysator.liu.se
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58198>

Refactor the Series.push_patch function to make the code flow
simpler. It identifies the simple case and handles it early, and
reduces the number of if statements.

Most changes are simply indentation changes.

Signed-off-by: David K=C3=A5gedal <davidk@lysator.liu.se>
---

 stgit/stack.py |   87 ++++++++++++++++++++++++++++++------------------=
--------
 1 files changed, 46 insertions(+), 41 deletions(-)


diff --git a/stgit/stack.py b/stgit/stack.py
index f31f308..9b8ed6e 100644
--- a/stgit/stack.py
+++ b/stgit/stack.py
@@ -1054,60 +1054,65 @@ class Series(PatchSet):
         head =3D git.get_head()
         bottom =3D patch.get_bottom()
         top =3D patch.get_top()
-
-        ex =3D None
-        modified =3D False
-
         # top !=3D bottom always since we have a commit for each patch
+
         if head =3D=3D bottom:
-            # reset the backup information. No need for logging
+            # A fast-forward push. Just reset the backup
+            # information. No need for logging
             patch.set_bottom(bottom, backup =3D True)
             patch.set_top(top, backup =3D True)
=20
             git.switch(top)
-        else:
-            # new patch needs to be refreshed.
-            # The current patch is empty after merge.
-            patch.set_bottom(head, backup =3D True)
-            patch.set_top(head, backup =3D True)
-
-            # Try the fast applying first. If this fails, fall back to=
 the
-            # three-way merge
-            if not git.apply_diff(bottom, top):
-                # if git.apply_diff() fails, the patch requires a diff=
3
-                # merge and can be reported as modified
-                modified =3D True
-
-                # merge can fail but the patch needs to be pushed
-                try:
-                    git.merge(bottom, head, top, recursive =3D True)
-                except git.GitException, ex:
-                    out.error('The merge failed during "push".',
-                              'Use "refresh" after fixing the conflict=
s or'
-                              ' revert the operation with "push --undo=
".')
+            append_string(self.__applied_file, name)
+
+            unapplied.remove(name)
+            write_strings(self.__unapplied_file, unapplied)
+            return False
+
+        # Need to create a new commit an merge in the old patch
+        ex =3D None
+        modified =3D False
+
+        # new patch needs to be refreshed.
+        # The current patch is empty after merge.
+        patch.set_bottom(head, backup =3D True)
+        patch.set_top(head, backup =3D True)
+
+        # Try the fast applying first. If this fails, fall back to the
+        # three-way merge
+        if not git.apply_diff(bottom, top):
+            # if git.apply_diff() fails, the patch requires a diff3
+            # merge and can be reported as modified
+            modified =3D True
+
+            # merge can fail but the patch needs to be pushed
+            try:
+                git.merge(bottom, head, top, recursive =3D True)
+            except git.GitException, ex:
+                out.error('The merge failed during "push".',
+                          'Use "refresh" after fixing the conflicts or=
'
+                          ' revert the operation with "push --undo".')
=20
         append_string(self.__applied_file, name)
=20
         unapplied.remove(name)
         write_strings(self.__unapplied_file, unapplied)
=20
-        # head =3D=3D bottom case doesn't need to refresh the patch
-        if head !=3D bottom:
-            if not ex:
-                # if the merge was OK and no conflicts, just refresh t=
he patch
-                # The GIT cache was already updated by the merge opera=
tion
-                if modified:
-                    log =3D 'push(m)'
-                else:
-                    log =3D 'push'
-                self.refresh_patch(cache_update =3D False, log =3D log=
)
+        if not ex:
+            # if the merge was OK and no conflicts, just refresh the p=
atch
+            # The GIT cache was already updated by the merge operation
+            if modified:
+                log =3D 'push(m)'
             else:
-                # we store the correctly merged files only for
-                # tracking the conflict history. Note that the
-                # git.merge() operations should always leave the index
-                # in a valid state (i.e. only stage 0 files)
-                self.refresh_patch(cache_update =3D False, log =3D 'pu=
sh(c)')
-                raise StackException, str(ex)
+                log =3D 'push'
+            self.refresh_patch(cache_update =3D False, log =3D log)
+        else:
+            # we store the correctly merged files only for
+            # tracking the conflict history. Note that the
+            # git.merge() operations should always leave the index
+            # in a valid state (i.e. only stage 0 files)
+            self.refresh_patch(cache_update =3D False, log =3D 'push(c=
)')
+            raise StackException, str(ex)
=20
         return modified
=20
