From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH 2/4] Teach new infrastructure to apply patches
Date: Tue, 29 Jan 2008 04:15:52 +0100
Message-ID: <20080129031537.1177.87398.stgit@yoghurt>
References: <20080129031310.1177.83290.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 29 04:16:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JJgxX-0006h9-Rq
	for gcvg-git-2@gmane.org; Tue, 29 Jan 2008 04:16:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754275AbYA2DP5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Jan 2008 22:15:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754340AbYA2DP5
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jan 2008 22:15:57 -0500
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4650 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753681AbYA2DPz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jan 2008 22:15:55 -0500
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1JJgwx-0000eb-00; Tue, 29 Jan 2008 03:15:51 +0000
In-Reply-To: <20080129031310.1177.83290.stgit@yoghurt>
User-Agent: StGIT/0.14.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71941>

Two new methods: one index method that applies a patch to that index
or fails without side-effects (without touching a worktree in either
case); and one repository method that uses a temp index to apply a
patch to a tree and returning the new tree (or None if the application
failed), entirely side-effect free.

Nothing uses this yet, but "stg edit" will soon.

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

 stgit/lib/git.py |   24 ++++++++++++++++++++++++
 1 files changed, 24 insertions(+), 0 deletions(-)


diff --git a/stgit/lib/git.py b/stgit/lib/git.py
index 8678979..9cb2521 100644
--- a/stgit/lib/git.py
+++ b/stgit/lib/git.py
@@ -338,6 +338,23 @@ class Repository(RunWithEnv):
                 return None
         finally:
             index.delete()
+    def apply(self, tree, patch_text):
+        """Given a tree and a patch, will either return the new tree t=
hat
+        results when the patch is applied, or None if the patch
+        couldn't be applied."""
+        assert isinstance(tree, Tree)
+        if not patch_text:
+            return tree
+        index =3D self.temp_index()
+        try:
+            index.read_tree(tree)
+            try:
+                index.apply(patch_text)
+                return index.write_tree()
+            except MergeException:
+                return None
+        finally:
+            index.delete()
=20
 class MergeException(exception.StgException):
     pass
@@ -374,6 +391,13 @@ class Index(RunWithEnv):
         """In-index merge, no worktree involved."""
         self.run(['git', 'read-tree', '-m', '-i', '--aggressive',
                   base.sha1, ours.sha1, theirs.sha1]).no_output()
+    def apply(self, patch_text):
+        """In-index patch application, no worktree involved."""
+        try:
+            self.run(['git', 'apply', '--cached']
+                     ).raw_input(patch_text).no_output()
+        except run.RunException:
+            raise MergeException('Patch does not apply cleanly')
     def delete(self):
         if os.path.isfile(self.__filename):
             os.remove(self.__filename)
