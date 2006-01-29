From: Chuck Lever <cel@netapp.com>
Subject: [PATCH 1/2] Use a separate directory for patches under each branch subdir
Date: Sun, 29 Jan 2006 13:13:59 -0500
Message-ID: <20060129181358.1919.46348.stgit@dexter.citi.umich.edu>
References: <20060129181004.1919.92166.stgit@dexter.citi.umich.edu>
Reply-To: Chuck Lever <cel@citi.umich.edu>
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 29 19:14:16 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F3H3q-0001ma-Do
	for gcvg-git@gmane.org; Sun, 29 Jan 2006 19:14:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751096AbWA2SOA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 Jan 2006 13:14:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751097AbWA2SN7
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jan 2006 13:13:59 -0500
Received: from citi.umich.edu ([141.211.133.111]:32642 "EHLO citi.umich.edu")
	by vger.kernel.org with ESMTP id S1751096AbWA2SN7 (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 29 Jan 2006 13:13:59 -0500
Received: from dexter.citi.umich.edu (dexter.citi.umich.edu [141.211.133.33])
	by citi.umich.edu (Postfix) with ESMTP id 12F4D1BC08;
	Sun, 29 Jan 2006 13:13:59 -0500 (EST)
To: catalin.marinas@gmail.com
In-Reply-To: <20060129181004.1919.92166.stgit@dexter.citi.umich.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15225>

Currently you can't specify a patch name that matches the name of one of
the stgit special files under .git/patches/<branch-name>.  Let's use a
new subdirectory under .git/patches/<branch-name> to contain just the
patch directories to remove this limitation.

Signed-off-by: Chuck Lever <cel@netapp.com>
---

 stgit/stack.py |   41 ++++++++++++++++++++++++++---------------
 1 files changed, 26 insertions(+), 15 deletions(-)

diff --git a/stgit/stack.py b/stgit/stack.py
index b081c95..89a2413 100644
--- a/stgit/stack.py
+++ b/stgit/stack.py
@@ -122,10 +122,10 @@ def edit_file(series, line, comment, sho
 class Patch:
     """Basic patch implementation
     """
-    def __init__(self, name, patch_dir):
-        self.__patch_dir = patch_dir
+    def __init__(self, name, series_dir):
+        self.__series_dir = series_dir
         self.__name = name
-        self.__dir = os.path.join(self.__patch_dir, self.__name)
+        self.__dir = os.path.join(self.__series_dir, self.__name)
 
     def create(self):
         os.mkdir(self.__dir)
@@ -143,7 +143,7 @@ class Patch:
     def rename(self, newname):
         olddir = self.__dir
         self.__name = newname
-        self.__dir = os.path.join(self.__patch_dir, self.__name)
+        self.__dir = os.path.join(self.__series_dir, self.__name)
 
         os.rename(olddir, self.__dir)
 
@@ -266,14 +266,20 @@ class Series:
         except git.GitException, ex:
             raise StackException, 'GIT tree not initialised: %s' % ex
 
-        self.__patch_dir = os.path.join(base_dir, 'patches',
-                                        self.__name)
+        self.__series_dir = os.path.join(base_dir, 'patches',
+                                         self.__name)
         self.__base_file = os.path.join(base_dir, 'refs', 'bases',
                                         self.__name)
-        self.__applied_file = os.path.join(self.__patch_dir, 'applied')
-        self.__unapplied_file = os.path.join(self.__patch_dir, 'unapplied')
-        self.__current_file = os.path.join(self.__patch_dir, 'current')
-        self.__descr_file = os.path.join(self.__patch_dir, 'description')
+
+        self.__applied_file = os.path.join(self.__series_dir, 'applied')
+        self.__unapplied_file = os.path.join(self.__series_dir, 'unapplied')
+        self.__current_file = os.path.join(self.__series_dir, 'current')
+        self.__descr_file = os.path.join(self.__series_dir, 'description')
+
+        # where this series keeps its patches
+        self.__patch_dir = os.path.join(self.__series_dir, 'patches')
+        if not os.path.isdir(self.__patch_dir):
+            self.__patch_dir = self.__series_dir
 
     def get_branch(self):
         """Return the branch name for the Series object
@@ -325,15 +331,15 @@ class Series:
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
 
@@ -401,6 +407,7 @@ class Series:
         create_empty_file(self.__applied_file)
         create_empty_file(self.__unapplied_file)
         create_empty_file(self.__descr_file)
+        os.makedirs(os.path.join(self.__series_dir, 'patches'))
         self.__begin_stack_check()
 
     def rename(self, to_name):
@@ -415,8 +422,8 @@ class Series:
 
         git.rename_branch(self.__name, to_name)
 
-        if os.path.isdir(self.__patch_dir):
-            os.rename(self.__patch_dir, to_stack.__patch_dir)
+        if os.path.isdir(self.__series_dir):
+            os.rename(self.__series_dir, to_stack.__series_dir)
         if os.path.exists(self.__base_file):
             os.rename(self.__base_file, to_stack.__base_file)
 
@@ -471,6 +478,10 @@ class Series:
             if not os.listdir(self.__patch_dir):
                 os.rmdir(self.__patch_dir)
             else:
+                print 'Patch directory %s is not empty.' % self.__name
+            if not os.listdir(self.__series_dir):
+                os.rmdir(self.__series_dir)
+            else:
                 print 'Series directory %s is not empty.' % self.__name
 
         if os.path.exists(self.__base_file):
