From: Chuck Lever <cel@netapp.com>
Subject: [PATCH 2/2] Clean up StGIT's "branch --delete" command
Date: Tue, 15 Nov 2005 17:52:56 -0500
Message-ID: <20051115225256.16350.73548.stgit@dexter.citi.umich.edu>
References: <20051115225136.16350.96122.stgit@dexter.citi.umich.edu>
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 15 23:54:56 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ec9fg-0007k7-9P
	for gcvg-git@gmane.org; Tue, 15 Nov 2005 23:53:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965063AbVKOWw5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 15 Nov 2005 17:52:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965062AbVKOWw5
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Nov 2005 17:52:57 -0500
Received: from citi.umich.edu ([141.211.133.111]:47293 "EHLO citi.umich.edu")
	by vger.kernel.org with ESMTP id S965063AbVKOWw4 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Nov 2005 17:52:56 -0500
Received: from dexter.citi.umich.edu (dexter.citi.umich.edu [141.211.133.33])
	by citi.umich.edu (Postfix) with ESMTP id 704481BACA;
	Tue, 15 Nov 2005 17:52:56 -0500 (EST)
To: catalin.marinas@gmail.com
In-Reply-To: <20051115225136.16350.96122.stgit@dexter.citi.umich.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11957>

os.path.isfile is not the same as os.path.exists.

Signed-off-by: Chuck Lever <cel@netapp.com>
---

 stgit/stack.py |   21 +++++++++++----------
 1 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/stgit/stack.py b/stgit/stack.py
index 0907b37..7bf7e7c 100644
--- a/stgit/stack.py
+++ b/stgit/stack.py
@@ -404,16 +404,17 @@ class Series:
         """Renames a series
         """
         to_stack = Series(to_name)
-        if os.path.isdir(to_stack.__patch_dir):
-            raise StackException, '"%s" already exists' % to_stack.__patch_dir
-        if os.path.isfile(to_stack.__base_file):
-            raise StackException, '"%s" already exists' % to_stack.__base_file
+
+        if to_stack.is_initialised:
+            raise StackException, '"%s" already exists' % to_stack.get_branch()
+        if os.path.exists(to_stack.__base_file):
+            os.remove(to_stack.__base_file)
 
         git.rename_branch(self.__name, to_name)
 
         if os.path.isdir(self.__patch_dir):
             os.rename(self.__patch_dir, to_stack.__patch_dir)
-        if os.path.isfile(self.__base_file):
+        if os.path.exists(self.__base_file):
             os.rename(self.__base_file, to_stack.__base_file)
 
         self.__init__(to_name)
@@ -430,20 +431,20 @@ class Series:
             for p in patches:
                 self.delete_patch(p)
 
-            if os.path.isfile(self.__applied_file):
+            if os.path.exists(self.__applied_file):
                 os.remove(self.__applied_file)
-            if os.path.isfile(self.__unapplied_file):
+            if os.path.exists(self.__unapplied_file):
                 os.remove(self.__unapplied_file)
-            if os.path.isfile(self.__current_file):
+            if os.path.exists(self.__current_file):
                 os.remove(self.__current_file)
-            if os.path.isfile(self.__descr_file):
+            if os.path.exists(self.__descr_file):
                 os.remove(self.__descr_file)
             if not os.listdir(self.__patch_dir):
                 os.rmdir(self.__patch_dir)
             else:
                 print 'Series directory %s is not empty.' % self.__name
 
-        if os.path.isfile(self.__base_file):
+        if os.path.exists(self.__base_file):
             os.remove(self.__base_file)
 
     def refresh_patch(self, message = None, edit = False, show_patch = False,
