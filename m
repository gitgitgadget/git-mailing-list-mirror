From: Chuck Lever <cel@netapp.com>
Subject: [PATCH 7/7] Use a separate directory for patches under each branch subdir
Date: Tue, 29 Nov 2005 17:09:52 -0500
Message-ID: <20051129220951.9885.59702.stgit@dexter.citi.umich.edu>
References: <20051129220552.9885.41086.stgit@dexter.citi.umich.edu>
Reply-To: Chuck Lever <cel@citi.umich.edu>
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 29 23:11:50 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EhDfl-0006zv-D9
	for gcvg-git@gmane.org; Tue, 29 Nov 2005 23:10:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932441AbVK2WJx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 29 Nov 2005 17:09:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932440AbVK2WJx
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Nov 2005 17:09:53 -0500
Received: from citi.umich.edu ([141.211.133.111]:8271 "EHLO citi.umich.edu")
	by vger.kernel.org with ESMTP id S964776AbVK2WJw (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Nov 2005 17:09:52 -0500
Received: from dexter.citi.umich.edu (dexter.citi.umich.edu [141.211.133.33])
	by citi.umich.edu (Postfix) with ESMTP id E9BFE1BBDE;
	Tue, 29 Nov 2005 17:09:51 -0500 (EST)
To: catalin.marinas@gmail.com
In-Reply-To: <20051129220552.9885.41086.stgit@dexter.citi.umich.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12960>

Currently you can't specify a patch name that matches the name of one of
the stgit special files under .git/patches/<branch-name>.  Let's use a
new subdirectory under .git/patches/<branch-name> to contain just the
patch directories to remove this limitation.

Signed-off-by: Chuck Lever <cel@netapp.com>
---

 stgit/stack.py |   24 +++++++++++++++---------
 1 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/stgit/stack.py b/stgit/stack.py
index 2866121..46b404c 100644
--- a/stgit/stack.py
+++ b/stgit/stack.py
@@ -264,14 +264,19 @@ class Series:
 
         if self.__name:
             base_dir = git.get_base_dir()
-            self.__patch_dir = os.path.join(base_dir, 'patches',
-                                            self.__name)
             self.__base_file = os.path.join(base_dir, 'refs', 'bases',
                                             self.__name)
-            self.__applied_file = os.path.join(self.__patch_dir, 'applied')
-            self.__unapplied_file = os.path.join(self.__patch_dir, 'unapplied')
-            self.__current_file = os.path.join(self.__patch_dir, 'current')
-            self.__descr_file = os.path.join(self.__patch_dir, 'description')
+            self.__series_dir = os.path.join(base_dir, 'patches',
+                                             self.__name)
+
+            self.__applied_file = os.path.join(self.__series_dir, 'applied')
+            self.__unapplied_file = os.path.join(self.__series_dir, 'unapplied')
+            self.__current_file = os.path.join(self.__series_dir, 'current')
+            self.__descr_file = os.path.join(self.__series_dir, 'description')
+
+            self.__patch_dir = os.path.join(self.__series_dir, 'patches')
+            if not os.path.isdir(self.__patch_dir):
+                self.__patch_dir = self.__series_dir
 
     def get_branch(self):
         """Return the branch name for the Series object
@@ -323,15 +328,15 @@ class Series:
         return self.__base_file
 
     def get_protected(self):
-        return os.path.isfile(os.path.join(self.__patch_dir, 'protected'))
+        return os.path.isfile(os.path.join(self.__series_dir, 'protected'))
 
     def protect(self):
-        protect_file = os.path.join(self.__patch_dir, 'protected')
+        protect_file = os.path.join(self.__series_dir, 'protected')
         if not os.path.isfile(protect_file):
             create_empty_file(protect_file)
 
     def unprotect(self):
-        protect_file = os.path.join(self.__patch_dir, 'protected')
+        protect_file = os.path.join(self.__series_dir, 'protected')
         if os.path.isfile(protect_file):
             os.remove(protect_file)
 
@@ -399,6 +404,7 @@ class Series:
         create_empty_file(self.__applied_file)
         create_empty_file(self.__unapplied_file)
         create_empty_file(self.__descr_file)
+        os.makedirs(os.path.join(self.__series_dir, 'patches'))
         self.__begin_stack_check()
 
     def rename(self, to_name):
