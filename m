From: Chuck Lever <cel@netapp.com>
Subject: [PATCH 2/2] Add an option to "stg branch" to convert the internal format
Date: Sun, 29 Jan 2006 13:14:01 -0500
Message-ID: <20060129181401.1919.90761.stgit@dexter.citi.umich.edu>
References: <20060129181004.1919.92166.stgit@dexter.citi.umich.edu>
Reply-To: Chuck Lever <cel@citi.umich.edu>
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 29 19:14:17 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F3H3w-0001ow-PD
	for gcvg-git@gmane.org; Sun, 29 Jan 2006 19:14:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751100AbWA2SOD (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 Jan 2006 13:14:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751097AbWA2SOD
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jan 2006 13:14:03 -0500
Received: from citi.umich.edu ([141.211.133.111]:37179 "EHLO citi.umich.edu")
	by vger.kernel.org with ESMTP id S1751100AbWA2SOB (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 29 Jan 2006 13:14:01 -0500
Received: from dexter.citi.umich.edu (dexter.citi.umich.edu [141.211.133.33])
	by citi.umich.edu (Postfix) with ESMTP id 3B1FB1BC08;
	Sun, 29 Jan 2006 13:14:01 -0500 (EST)
To: catalin.marinas@gmail.com
In-Reply-To: <20060129181004.1919.92166.stgit@dexter.citi.umich.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15226>

Previous patch adds support for a separate patch directory in each branch.
Let's give users an option to convert their old branches to new style ones
and back.

Signed-off-by: Chuck Lever <cel@netapp.com>
---

 stgit/commands/branch.py |   11 +++++++++++
 stgit/stack.py           |   36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 47 insertions(+), 0 deletions(-)

diff --git a/stgit/commands/branch.py b/stgit/commands/branch.py
index 6a551e4..ef44349 100644
--- a/stgit/commands/branch.py
+++ b/stgit/commands/branch.py
@@ -45,6 +45,9 @@ options = [make_option('-c', '--create',
            make_option('--clone',
                        help = 'clone the contents of the current branch',
                        action = 'store_true'),
+           make_option('--convert',
+                       help = 'switch between old and new format branches',
+                       action = 'store_true'),
            make_option('--delete',
                        help = 'delete an existing development branch',
                        action = 'store_true'),
@@ -150,6 +153,14 @@ def func(parser, options, args):
 
         return
 
+    elif options.convert:
+
+        if len(args) != 0:
+            parser.error('incorrect number of arguments')
+
+        crt_series.convert()
+        return
+
     elif options.delete:
 
         if len(args) != 1:
diff --git a/stgit/stack.py b/stgit/stack.py
index 89a2413..145f93c 100644
--- a/stgit/stack.py
+++ b/stgit/stack.py
@@ -410,6 +410,42 @@ class Series:
         os.makedirs(os.path.join(self.__series_dir, 'patches'))
         self.__begin_stack_check()
 
+    def convert(self):
+        """Either convert to use a separate patch directory, or
+        unconvert to place the patches in the same directory with
+        series control files
+        """
+        if self.__patch_dir == self.__series_dir:
+            print 'Converting old-style to new-style... ',
+            sys.stdout.flush()
+
+            self.__patch_dir = os.path.join(self.__series_dir, 'patches')
+            os.makedirs(self.__patch_dir)
+
+            for p in self.get_applied() + self.get_unapplied():
+                src = os.path.join(self.__series_dir, p)
+                dest = os.path.join(self.__patch_dir, p)
+                os.rename(src, dest)
+
+            print 'done'
+
+        else:
+            print 'Converting new-style to old-style... ',
+            sys.stdout.flush()
+
+            for p in self.get_applied() + self.get_unapplied():
+                src = os.path.join(self.__patch_dir, p)
+                dest = os.path.join(self.__series_dir, p)
+                os.rename(src, dest)
+
+            if not os.listdir(self.__patch_dir):
+                os.rmdir(self.__patch_dir)
+                print 'done'
+            else:
+                print 'Patch directory %s is not empty.' % self.__name
+
+            self.__patch_dir = self.__series_dir
+
     def rename(self, to_name):
         """Renames a series
         """
