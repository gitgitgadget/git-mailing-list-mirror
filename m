From: Fredrik Kuivinen <freku045@student.liu.se>
Subject: [PATCH 1/5] Be more like the 'resolve' strategy.
Date: Tue, 13 Sep 2005 23:39:34 +0200
Message-ID: <20050913213934.GB10953@c165.ib.student.liu.se>
References: <20050913213730.GA10953@c165.ib.student.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: junkio@cox.net
X-From: git-owner@vger.kernel.org Tue Sep 13 23:40:52 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EFIV9-000677-F9
	for gcvg-git@gmane.org; Tue, 13 Sep 2005 23:39:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750893AbVIMVjg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Sep 2005 17:39:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750892AbVIMVjg
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Sep 2005 17:39:36 -0400
Received: from [85.8.31.11] ([85.8.31.11]:13703 "EHLO mail6.wasadata.com")
	by vger.kernel.org with ESMTP id S1750891AbVIMVjf (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Sep 2005 17:39:35 -0400
Received: from c165 (unknown [85.8.2.189])
	by mail6.wasadata.com (Postfix) with ESMTP
	id 2BE47411B; Tue, 13 Sep 2005 23:44:39 +0200 (CEST)
Received: from ksorim by c165 with local (Exim 3.36 #1 (Debian))
	id 1EFIV4-0002u3-00; Tue, 13 Sep 2005 23:39:34 +0200
To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20050913213730.GA10953@c165.ib.student.liu.se>
User-Agent: Mutt/1.5.6+20040907i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8489>

If there are non-mergeable changes leave the head contents in the
cache and update the working directory with the output from merge(1).

In the add/add and delete/modify conflict cases leave unmerged cache
entries in the index.

Signed-off-by: Fredrik Kuivinen <freku045@student.liu.se>


---

 git-merge-recursive.py |   68 +++++++++++++++++++++++-------------------------
 1 files changed, 33 insertions(+), 35 deletions(-)

11a6300badeb3b2a46d088877f2f264d18b2160d
diff --git a/git-merge-recursive.py b/git-merge-recursive.py
--- a/git-merge-recursive.py
+++ b/git-merge-recursive.py
@@ -7,8 +7,6 @@ from sets import Set
 sys.path.append('@@GIT_PYTHON_PATH@@')
 from gitMergeCommon import *
 
-alwaysWriteTree = False
-
 # The actual merge code
 # ---------------------
 
@@ -46,19 +44,14 @@ def merge(h1, h2, branch1Name, branch2Na
             runProgram(['git-update-cache', '-q', '--refresh'])
         # Use the original index if we only have one common ancestor
         
-        updateWd = True
-        if alwaysWriteTree:
-            cleanCache = True
-        else:
-            cleanCache = False
+        cleanCache = False
     else:
         runProgram(['git-read-tree', h1.tree()])
-        updateWd = False
         cleanCache = True
 
     [shaRes, clean] = mergeTrees(h1.tree(), h2.tree(), Ms.tree(),
                                  branch1Name, branch2Name,
-                                 cleanCache, updateWd)
+                                 cleanCache)
 
     if clean or cleanCache:
         res = Commit(None, [h1, h2], tree=shaRes)
@@ -125,7 +118,7 @@ def unmergedCacheEntries():
     return res
 
 def mergeTrees(head, merge, common, branch1Name, branch2Name,
-               cleanCache, updateWd):
+               cleanCache):
     '''Merge the trees 'head' and 'merge' with the common ancestor
     'common'. The name of the head branch is 'branch1Name' and the name of
     the merge branch is 'branch2Name'. Return a tuple (tree, cleanMerge)
@@ -138,10 +131,11 @@ def mergeTrees(head, merge, common, bran
         print 'Already uptodate!'
         return [head, True]
 
-    if updateWd:
-        updateArg = '-u'
-    else:
+    if cleanCache:
         updateArg = '-i'
+    else:
+        updateArg = '-u'
+
     runProgram(['git-read-tree', updateArg, '-m', common, head, merge])
     cleanMerge = True
 
@@ -157,7 +151,7 @@ def mergeTrees(head, merge, common, bran
         entries = unmergedCacheEntries()
         for name in entries:
             if not processEntry(entries[name], branch1Name, branch2Name,
-                                files, dirs, cleanCache, updateWd):
+                                files, dirs, cleanCache):
                 cleanMerge = False
                 
         if cleanMerge or cleanCache:
@@ -169,29 +163,25 @@ def mergeTrees(head, merge, common, bran
 
     return [tree, cleanMerge]
 
-def processEntry(entry, branch1Name, branch2Name, files, dirs,
-                 cleanCache, updateWd):
+def processEntry(entry, branch1Name, branch2Name, files, dirs, cleanCache):
     '''Merge one cache entry. 'files' is a Set with the files in both of
     the heads that we are going to merge. 'dirs' contains the
     corresponding data for directories. If 'cleanCache' is True no
     non-zero stages will be left in the cache for the path
     corresponding to the entry 'entry'.'''
 
-# cleanCache == True  => Don't leave any non-stage 0 entries in the cache.
-#               False => Leave unmerged entries
-
-# updateWd  == True  => Update the working directory to correspond to the cache
-#              False => Leave the working directory unchanged
+# cleanCache == True  => Don't leave any non-stage 0 entries in the cache and
+#                        don't update the working directory
+#               False => Leave unmerged entries and update the working directory
 
 # clean     == True  => non-conflict case
 #              False => conflict case
 
 # If cleanCache == False then the cache shouldn't be updated if clean == False
 
-    def updateFile(clean, sha, mode, path):
-        if cleanCache or (not cleanCache and clean):
-            runProgram(['git-update-cache', '--add', '--cacheinfo',
-                        '0%o' % mode, sha, path])
+    def updateFile(clean, sha, mode, path, onlyWd=False):
+        updateCache = not onlyWd and (cleanCache or (not cleanCache and clean))
+        updateWd = onlyWd or (not cleanCache and clean)
 
         if updateWd:
             prog = ['git-cat-file', 'blob', sha]
@@ -213,13 +203,18 @@ def processEntry(entry, branch1Name, bra
                 os.symlink(linkTarget, path)
             else:
                 assert(False)
-            runProgram(['git-update-cache', '--', path])
+
+        if updateWd and updateCache:
+            runProgram(['git-update-cache', '--add', '--', path])
+        elif updateCache:
+            runProgram(['git-update-cache', '--add', '--cacheinfo',
+                        '0%o' % mode, sha, path])
 
     def removeFile(clean, path):
         if cleanCache or (not cleanCache and clean):
             runProgram(['git-update-cache', '--force-remove', '--', path])
 
-        if updateWd:
+        if not cleanCache and clean:
             try:
                 os.unlink(path)
             except OSError, e:
@@ -235,8 +230,7 @@ def processEntry(entry, branch1Name, bra
         files.add(newPath)
         return newPath
 
-    debug('processing', entry.path, 'clean cache:', cleanCache,
-          'wd:', updateWd)
+    debug('processing', entry.path, 'clean cache:', cleanCache)
 
     cleanMerge = True
 
@@ -327,9 +321,9 @@ def processEntry(entry, branch1Name, bra
             if aMode != bMode:
                 cleanMerge = False
                 print 'CONFLICT: File "' + path + \
-                      '" added identically in both branches,'
-                print 'CONFLICT: but permissions conflict', '0%o' % aMode, \
-                      '->', '0%o' % bMode
+                      '" added identically in both branches,', \
+                      'but permissions conflict', '0%o' % aMode, '->', \
+                      '0%o' % bMode
                 print 'CONFLICT: adding with permission:', '0%o' % aMode
 
                 updateFile(False, aSha, aMode, path)
@@ -341,8 +335,7 @@ def processEntry(entry, branch1Name, bra
             newPath1 = uniquePath(path, branch1Name)
             newPath2 = uniquePath(path, branch2Name)
             print 'CONFLICT (add/add): File "' + path + \
-                  '" added non-identically in both branches.', \
-                  'Adding "' + newPath1 + '" and "' + newPath2 + '" instead.'
+                  '" added non-identically in both branches.'
             removeFile(False, path)
             updateFile(False, aSha, aMode, newPath1)
             updateFile(False, bSha, bMode, newPath2)
@@ -372,7 +365,12 @@ def processEntry(entry, branch1Name, bra
         if ret != 0:
             cleanMerge = False
             print 'CONFLICT (content): Merge conflict in "' + path + '".'
-            updateFile(False, sha, mode, path)
+
+            if cleanCache:
+                updateFile(False, sha, mode, path)
+            else:
+                updateFile(True, aSha, aMode, path)
+                updateFile(False, sha, mode, path, True)
         else:
             updateFile(True, sha, mode, path)
 
