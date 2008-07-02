From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGit PATCH 1/2] Do simple in-index merge with diff+apply instead of
	read-tree
Date: Wed, 02 Jul 2008 08:12:44 +0200
Message-ID: <20080702061243.11361.75544.stgit@yoghurt>
References: <20080702060113.11361.39006.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 02 08:14:50 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDvc7-0001mW-5P
	for gcvg-git-2@gmane.org; Wed, 02 Jul 2008 08:14:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759853AbYGBGNt convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 2 Jul 2008 02:13:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759388AbYGBGNr
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Jul 2008 02:13:47 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:1109 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757801AbYGBGNp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jul 2008 02:13:45 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1KDvaW-000716-00; Wed, 02 Jul 2008 07:13:08 +0100
In-Reply-To: <20080702060113.11361.39006.stgit@yoghurt>
User-Agent: StGIT/0.14.3.182.gb4dc
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87088>

The advantage is that patch application will resolve some file content
conflicts for us, so that we'll fall back to merge-recursive less
often. This is a significant speedup, especially since merge-recursive
needs to touch the worktree, which means we have to check out the
index first.

(A simple test, pushing 250 patches in a 32k-file repository, with one
file-level merge necessary per push, went from 1.07 to 0.36 seconds
per patch with this patch applied.)

Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

 stgit/lib/git.py |   13 ++++++++-----
 1 files changed, 8 insertions(+), 5 deletions(-)


diff --git a/stgit/lib/git.py b/stgit/lib/git.py
index 6ccdfa7..a38eaa5 100644
--- a/stgit/lib/git.py
+++ b/stgit/lib/git.py
@@ -475,9 +475,10 @@ class Repository(RunWithEnv):
             return ours
=20
         index =3D self.temp_index()
+        index.read_tree(ours)
         try:
-            index.merge(base, ours, theirs)
             try:
+                index.apply_treediff(base, theirs)
                 return index.write_tree()
             except MergeException:
                 return None
@@ -548,10 +549,6 @@ class Index(RunWithEnv):
             return False
         else:
             return True
-    def merge(self, base, ours, theirs):
-        """In-index merge, no worktree involved."""
-        self.run(['git', 'read-tree', '-m', '-i', '--aggressive',
-                  base.sha1, ours.sha1, theirs.sha1]).no_output()
     def apply(self, patch_text):
         """In-index patch application, no worktree involved."""
         try:
@@ -559,6 +556,12 @@ class Index(RunWithEnv):
                      ).raw_input(patch_text).no_output()
         except run.RunException:
             raise MergeException('Patch does not apply cleanly')
+    def apply_treediff(self, tree1, tree2):
+        """Apply the diff from C{tree1} to C{tree2} to the index."""
+        # Passing --full-index here is necessary to support binary
+        # files. It is also sufficient, since the repository already
+        # contains all involved objects.
+        self.apply(self.__repository.diff_tree(tree1, tree2, ['--full-=
index']))
     def delete(self):
         if os.path.isfile(self.__filename):
             os.remove(self.__filename)
