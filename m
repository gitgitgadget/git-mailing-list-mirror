From: Yann Dirson <ydirson@altern.org>
Subject: [PATCH] Fix deletion and move of a hidden patch (gna bug #9244).
Date: Mon, 04 Jun 2007 23:14:43 +0200
Message-ID: <20070604211419.469.38927.stgit@gandelf.nowhere.earth>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 04 23:14:52 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HvJt5-0002uB-Uc
	for gcvg-git@gmane.org; Mon, 04 Jun 2007 23:14:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753102AbXFDVOo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 4 Jun 2007 17:14:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753826AbXFDVOo
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Jun 2007 17:14:44 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:55610 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753102AbXFDVOn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jun 2007 17:14:43 -0400
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id C86BC783D;
	Mon,  4 Jun 2007 23:14:41 +0200 (CEST)
Received: from gandelf.nowhere.earth (localhost [127.0.0.1])
	by gandelf.nowhere.earth (Postfix) with ESMTP id 4E8831F157;
	Mon,  4 Jun 2007 23:14:43 +0200 (CEST)
User-Agent: StGIT/0.12
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49128>


We must unhide a patch before we delete it, or we get an exception
while trying to unhide a non-existent patch.

Similarly, when renaming a hidden patch, we must take care of hiding
an unhiding at the right moment.

Both problems introduced in commit
841c7b2a6b015e3ab3331713cf10caf7a4fd0b49 when first indroducing patch
hiding.

Signed-off-by: Yann Dirson <ydirson@altern.org>
---

 stgit/stack.py        |   13 +++++++++----
 t/t1600-delete-one.sh |   13 +++++++++++--
 2 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/stgit/stack.py b/stgit/stack.py
index 7a06458..ed54671 100644
--- a/stgit/stack.py
+++ b/stgit/stack.py
@@ -894,6 +894,9 @@ class Series(StgitObject):
         # save the commit id to a trash file
         write_string(os.path.join(self.__trash_dir, name), patch.get_top())
 
+        if self.patch_hidden(name):
+            self.unhide_patch(name)
+
         patch.delete()
 
         unapplied = self.get_unapplied()
@@ -902,9 +905,6 @@ class Series(StgitObject):
         f.writelines([line + '\n' for line in unapplied])
         f.close()
 
-        if self.patch_hidden(name):
-            self.unhide_patch(name)
-
     def forward_patches(self, names):
         """Try to fast-forward an array of patches.
 
@@ -1168,7 +1168,9 @@ class Series(StgitObject):
 
         if self.patch_hidden(oldname):
             self.unhide_patch(oldname)
-            self.hide_patch(newname)
+            was_hidden=True
+        else:
+            was_hidden=False
 
         if oldname in unapplied:
             Patch(oldname, self.__patch_dir, self.__refs_dir).rename(newname)
@@ -1188,6 +1190,9 @@ class Series(StgitObject):
         else:
             raise StackException, 'Unknown patch "%s"' % oldname
 
+        if was_hidden:
+            self.hide_patch(newname)
+
     def log_patch(self, patch, message):
         """Generate a log commit for a patch
         """
diff --git a/t/t1600-delete-one.sh b/t/t1600-delete-one.sh
index df03d79..d59d4ba 100755
--- a/t/t1600-delete-one.sh
+++ b/t/t1600-delete-one.sh
@@ -82,6 +82,15 @@ test_expect_success \
     '
 
 test_expect_success \
+    'Hide the topmost patch and try to delete it' \
+    '
+    [ $(stg applied | wc -l) -eq 2 ] &&
+    stg hide bar &&
+    stg delete bar &&
+    [ $(stg applied | wc -l) -eq 1 ]
+    '
+
+test_expect_success \
     'Create another branch, and put one patch in each branch' \
     '
     stg branch --create br &&
@@ -99,10 +108,10 @@ test_expect_success \
 test_expect_success \
     'Delete a patch in another branch' \
     '
-    [ $(stg applied | wc -l) -eq 3 ] &&
+    [ $(stg applied | wc -l) -eq 2 ] &&
     [ $(stg applied -b br | wc -l) -eq 1 ] &&
     stg delete -b br baz &&
-    [ $(stg applied | wc -l) -eq 3 ] &&
+    [ $(stg applied | wc -l) -eq 2 ] &&
     [ $(stg applied -b br | wc -l) -eq 0 ]
     '
 
