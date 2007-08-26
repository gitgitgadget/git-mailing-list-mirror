From: Karl =?utf-8?q?Hasselstr=C3=B6m?= <kha@treskal.com>
Subject: [StGIT PATCH 2/6] Leave working dir and index alone after failed
	(conflicting) push
Date: Sun, 26 Aug 2007 22:42:43 +0200
Message-ID: <20070826204242.16700.60432.stgit@yoghurt>
References: <20070826203745.16700.5655.stgit@yoghurt>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>,
	David =?utf-8?q?K=C3=A5gedal?= <davidk@lysator.liu.se>
X-From: git-owner@vger.kernel.org Sun Aug 26 22:42:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IPOwg-0002EK-1y
	for gcvg-git@gmane.org; Sun, 26 Aug 2007 22:42:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751060AbXHZUmu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 26 Aug 2007 16:42:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750983AbXHZUmt
	(ORCPT <rfc822;git-outgoing>); Sun, 26 Aug 2007 16:42:49 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:2203 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750887AbXHZUms (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Aug 2007 16:42:48 -0400
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
	by diana.vm.bytemark.co.uk with esmtp (Exim 3.36 #1 (Debian))
	id 1IPOwV-00060h-00; Sun, 26 Aug 2007 21:42:43 +0100
In-Reply-To: <20070826203745.16700.5655.stgit@yoghurt>
User-Agent: StGIT/0.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56724>

=46rom: David K=C3=A5gedal <davidk@lysator.liu.se>

This leaves the index and working tree in the state that merge-recursiv=
e
left it, with unmerged files in different stages, and the non-conflicti=
ng
changes in the index.

Signed-off-by: David K=C3=A5gedal <davidk@lysator.liu.se>
Signed-off-by: Karl Hasselstr=C3=B6m <kha@treskal.com>

---

 stgit/git.py   |   20 +-------------------
 stgit/stack.py |   18 +++++++++++++-----
 2 files changed, 14 insertions(+), 24 deletions(-)

diff --git a/stgit/git.py b/stgit/git.py
index 87551ee..82cb211 100644
--- a/stgit/git.py
+++ b/stgit/git.py
@@ -675,25 +675,7 @@ def merge_recursive(base, head1, head2):
         # error and we have to abort the merge
         raise GitException, err_output
=20
-    # merge the unmerged files
-    errors =3D False
-    for path in files:
-        # remove additional files that might be generated for some
-        # newer versions of GIT
-        for suffix in [base, head1, head2]:
-            if not suffix:
-                continue
-            fname =3D path + '~' + suffix
-            if os.path.exists(fname):
-                os.remove(fname)
-
-        stages =3D files[path]
-        if gitmergeonefile.merge(stages['1'][1], stages['2'][1],
-                                 stages['3'][1], path, stages['1'][0],
-                                 stages['2'][0], stages['3'][0]) !=3D =
0:
-            errors =3D True
-
-    if errors:
+    if files:
         raise GitException, 'GIT index merging failed (possible confli=
cts)'
=20
 def merge(base, head1, head2):
diff --git a/stgit/stack.py b/stgit/stack.py
index a82392f..eb0114e 100644
--- a/stgit/stack.py
+++ b/stgit/stack.py
@@ -734,6 +734,7 @@ class Series(PatchSet):
         config.unset(self.format_version_key())
=20
     def refresh_patch(self, files =3D None, message =3D None, edit =3D=
 False,
+                      empty =3D False,
                       show_patch =3D False,
                       cache_update =3D True,
                       author_name =3D None, author_email =3D None,
@@ -783,9 +784,16 @@ class Series(PatchSet):
=20
         bottom =3D patch.get_bottom()
=20
+        if empty:
+            tree_id =3D git.get_commit(bottom).get_tree()
+        else:
+            tree_id =3D None
+
         commit_id =3D git.commit(files =3D files,
                                message =3D descr, parents =3D [bottom]=
,
                                cache_update =3D cache_update,
+                               tree_id =3D tree_id,
+                               set_head =3D True,
                                allowempty =3D True,
                                author_name =3D author_name,
                                author_email =3D author_email,
@@ -1088,11 +1096,11 @@ class Series(PatchSet):
                     log =3D 'push'
                 self.refresh_patch(cache_update =3D False, log =3D log=
)
             else:
-                # we store the correctly merged files only for
-                # tracking the conflict history. Note that the
-                # git.merge() operations should always leave the index
-                # in a valid state (i.e. only stage 0 files)
-                self.refresh_patch(cache_update =3D False, log =3D 'pu=
sh(c)')
+                # We make the patch empty, with the merged state in
+                # the working tree and index just like after a failed
+                # git merge.
+                self.refresh_patch(cache_update =3D False, empty =3D T=
rue,
+                                   log =3D 'push(c)')
                 raise StackException, str(ex)
=20
         return modified
