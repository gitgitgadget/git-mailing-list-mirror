From: Fredrik Kuivinen <freku045@student.liu.se>
Subject: [PATCH 1/3] merge-recursive: Indent the output properly
Date: Sat, 12 Nov 2005 00:53:07 +0100
Message-ID: <20051111235306.GA9757@c165.ib.student.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: junkio@cox.net
X-From: git-owner@vger.kernel.org Sat Nov 12 00:54:00 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eaihq-0007x0-FR
	for gcvg-git@gmane.org; Sat, 12 Nov 2005 00:53:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750723AbVKKXxP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 11 Nov 2005 18:53:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750725AbVKKXxP
	(ORCPT <rfc822;git-outgoing>); Fri, 11 Nov 2005 18:53:15 -0500
Received: from [85.8.31.11] ([85.8.31.11]:63380 "EHLO mail6.wasadata.com")
	by vger.kernel.org with ESMTP id S1750723AbVKKXxO (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 11 Nov 2005 18:53:14 -0500
Received: from c165 (unknown [85.8.2.189])
	by mail6.wasadata.com (Postfix) with ESMTP
	id 200D440FD; Sat, 12 Nov 2005 01:01:42 +0100 (CET)
Received: from ksorim by c165 with local (Exim 3.36 #1 (Debian))
	id 1Eaihf-0006Qh-00; Sat, 12 Nov 2005 00:53:07 +0100
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/11647>

If we have multiple common ancestors and have to recursively merge
them then the output will be much more readable with this commit.

Signed-off-by: Fredrik Kuivinen <freku045@student.liu.se>


---

 git-merge-recursive.py |  132 +++++++++++++++++++++++++-----------------------
 1 files changed, 70 insertions(+), 62 deletions(-)

applies-to: 61d3c7b885a193afa970b5dd319d5264dcbd11ad
66f3f641939645d4f26849adfdc54f4f00cb72f1
diff --git a/git-merge-recursive.py b/git-merge-recursive.py
index 90e889c..e6cbdde 100755
--- a/git-merge-recursive.py
+++ b/git-merge-recursive.py
@@ -7,6 +7,11 @@ from sets import Set
 sys.path.append('''@@GIT_PYTHON_PATH@@''')
 from gitMergeCommon import *
 
+outputIndent = 0
+def output(*args):
+    sys.stdout.write('  '*outputIndent)
+    printList(args)
+
 originalIndexFile = os.environ.get('GIT_INDEX_FILE',
                                    os.environ.get('GIT_DIR', '.git') + '/index')
 temporaryIndexFile = os.environ.get('GIT_DIR', '.git') + \
@@ -41,27 +46,27 @@ def merge(h1, h2, branch1Name, branch2Na
     assert(isinstance(h1, Commit) and isinstance(h2, Commit))
     assert(isinstance(graph, Graph))
 
-    def infoMsg(*args):
-        sys.stdout.write('  '*callDepth)
-        printList(args)
-
-    infoMsg('Merging:')
-    infoMsg(h1)
-    infoMsg(h2)
+    global outputIndent
+
+    output('Merging:')
+    output(h1)
+    output(h2)
     sys.stdout.flush()
 
     ca = getCommonAncestors(graph, h1, h2)
-    infoMsg('found', len(ca), 'common ancestor(s):')
+    output('found', len(ca), 'common ancestor(s):')
     for x in ca:
-        infoMsg(x)
+        output(x)
     sys.stdout.flush()
 
     mergedCA = ca[0]
     for h in ca[1:]:
+        outputIndent = callDepth+1
         [mergedCA, dummy] = merge(mergedCA, h,
-                                  'Temporary shared merge branch 1',
-                                  'Temporary shared merge branch 2',
+                                  'Temporary merge branch 1',
+                                  'Temporary merge branch 2',
                                   graph, callDepth+1)
+        outputIndent = callDepth
         assert(isinstance(mergedCA, Commit))
 
     global cacheOnly
@@ -116,7 +121,7 @@ def mergeTrees(head, merge, common, bran
     assert(isSha(head) and isSha(merge) and isSha(common))
 
     if common == merge:
-        print 'Already uptodate!'
+        output('Already uptodate!')
         return [head, True]
 
     if cacheOnly:
@@ -554,23 +559,24 @@ def processRenames(renamesA, renamesB, b
             ren2.processed = True
 
             if ren1.dstName != ren2.dstName:
-                print 'CONFLICT (rename/rename): Rename', \
-                      fmtRename(path, ren1.dstName), 'in branch', branchName1, \
-                      'rename', fmtRename(path, ren2.dstName), 'in', branchName2
+                output('CONFLICT (rename/rename): Rename',
+                       fmtRename(path, ren1.dstName), 'in branch', branchName1,
+                       'rename', fmtRename(path, ren2.dstName), 'in',
+                       branchName2)
                 cleanMerge = False
 
                 if ren1.dstName in currentDirectorySet:
                     dstName1 = uniquePath(ren1.dstName, branchName1)
-                    print ren1.dstName, 'is a directory in', branchName2, \
-                          'adding as', dstName1, 'instead.'
+                    output(ren1.dstName, 'is a directory in', branchName2,
+                           'adding as', dstName1, 'instead.')
                     removeFile(False, ren1.dstName)
                 else:
                     dstName1 = ren1.dstName
 
                 if ren2.dstName in currentDirectorySet:
                     dstName2 = uniquePath(ren2.dstName, branchName2)
-                    print ren2.dstName, 'is a directory in', branchName1, \
-                          'adding as', dstName2, 'instead.'
+                    output(ren2.dstName, 'is a directory in', branchName1,
+                           'adding as', dstName2, 'instead.')
                     removeFile(False, ren2.dstName)
                 else:
                     dstName2 = ren1.dstName
@@ -585,13 +591,14 @@ def processRenames(renamesA, renamesB, b
                                    branchName1, branchName2)
 
                 if merge or not clean:
-                    print 'Renaming', fmtRename(path, ren1.dstName)
+                    output('Renaming', fmtRename(path, ren1.dstName))
 
                 if merge:
-                    print 'Auto-merging', ren1.dstName
+                    output('Auto-merging', ren1.dstName)
 
                 if not clean:
-                    print 'CONFLICT (content): merge conflict in', ren1.dstName
+                    output('CONFLICT (content): merge conflict in',
+                           ren1.dstName)
                     cleanMerge = False
 
                     if not cacheOnly:
@@ -615,25 +622,25 @@ def processRenames(renamesA, renamesB, b
             
             if ren1.dstName in currentDirectorySet:
                 newPath = uniquePath(ren1.dstName, branchName1)
-                print 'CONFLICT (rename/directory): Rename', \
-                      fmtRename(ren1.srcName, ren1.dstName), 'in', branchName1,\
-                      'directory', ren1.dstName, 'added in', branchName2
-                print 'Renaming', ren1.srcName, 'to', newPath, 'instead'
+                output('CONFLICT (rename/directory): Rename',
+                       fmtRename(ren1.srcName, ren1.dstName), 'in', branchName1,
+                       'directory', ren1.dstName, 'added in', branchName2)
+                output('Renaming', ren1.srcName, 'to', newPath, 'instead')
                 cleanMerge = False
                 removeFile(False, ren1.dstName)
                 updateFile(False, ren1.dstSha, ren1.dstMode, newPath)
             elif srcShaOtherBranch == None:
-                print 'CONFLICT (rename/delete): Rename', \
-                      fmtRename(ren1.srcName, ren1.dstName), 'in', \
-                      branchName1, 'and deleted in', branchName2
+                output('CONFLICT (rename/delete): Rename',
+                       fmtRename(ren1.srcName, ren1.dstName), 'in',
+                       branchName1, 'and deleted in', branchName2)
                 cleanMerge = False
                 updateFile(False, ren1.dstSha, ren1.dstMode, ren1.dstName)
             elif dstShaOtherBranch:
                 newPath = uniquePath(ren1.dstName, branchName2)
-                print 'CONFLICT (rename/add): Rename', \
-                      fmtRename(ren1.srcName, ren1.dstName), 'in', \
-                      branchName1 + '.', ren1.dstName, 'added in', branchName2
-                print 'Adding as', newPath, 'instead'
+                output('CONFLICT (rename/add): Rename',
+                       fmtRename(ren1.srcName, ren1.dstName), 'in',
+                       branchName1 + '.', ren1.dstName, 'added in', branchName2)
+                output('Adding as', newPath, 'instead')
                 updateFile(False, dstShaOtherBranch, dstModeOtherBranch, newPath)
                 cleanMerge = False
                 tryMerge = True
@@ -641,12 +648,12 @@ def processRenames(renamesA, renamesB, b
                 dst2 = renames2.getDst(ren1.dstName)
                 newPath1 = uniquePath(ren1.dstName, branchName1)
                 newPath2 = uniquePath(dst2.dstName, branchName2)
-                print 'CONFLICT (rename/rename): Rename', \
-                      fmtRename(ren1.srcName, ren1.dstName), 'in', \
-                      branchName1+'. Rename', \
-                      fmtRename(dst2.srcName, dst2.dstName), 'in', branchName2
-                print 'Renaming', ren1.srcName, 'to', newPath1, 'and', \
-                      dst2.srcName, 'to', newPath2, 'instead'
+                output('CONFLICT (rename/rename): Rename',
+                       fmtRename(ren1.srcName, ren1.dstName), 'in',
+                       branchName1+'. Rename',
+                       fmtRename(dst2.srcName, dst2.dstName), 'in', branchName2)
+                output('Renaming', ren1.srcName, 'to', newPath1, 'and',
+                       dst2.srcName, 'to', newPath2, 'instead')
                 removeFile(False, ren1.dstName)
                 updateFile(False, ren1.dstSha, ren1.dstMode, newPath1)
                 updateFile(False, dst2.dstSha, dst2.dstMode, newPath2)
@@ -663,13 +670,14 @@ def processRenames(renamesA, renamesB, b
                                    branchName1, branchName2)
 
                 if merge or not clean:
-                    print 'Renaming', fmtRename(ren1.srcName, ren1.dstName)
+                    output('Renaming', fmtRename(ren1.srcName, ren1.dstName))
 
                 if merge:
-                    print 'Auto-merging', ren1.dstName
+                    output('Auto-merging', ren1.dstName)
 
                 if not clean:
-                    print 'CONFLICT (rename/modify): Merge conflict in', ren1.dstName
+                    output('CONFLICT (rename/modify): Merge conflict in',
+                           ren1.dstName)
                     cleanMerge = False
 
                     if not cacheOnly:
@@ -714,21 +722,21 @@ def processEntry(entry, branch1Name, bra
            (not aSha     and bSha == oSha):
     # Deleted in both or deleted in one and unchanged in the other
             if aSha:
-                print 'Removing', path
+                output('Removing', path)
             removeFile(True, path)
         else:
     # Deleted in one and changed in the other
             cleanMerge = False
             if not aSha:
-                print 'CONFLICT (delete/modify):', path, 'deleted in', \
-                      branch1Name, 'and modified in', branch2Name + '.', \
-                      'Version', branch2Name, 'of', path, 'left in tree.'
+                output('CONFLICT (delete/modify):', path, 'deleted in',
+                       branch1Name, 'and modified in', branch2Name + '.',
+                       'Version', branch2Name, 'of', path, 'left in tree.')
                 mode = bMode
                 sha = bSha
             else:
-                print 'CONFLICT (modify/delete):', path, 'deleted in', \
-                      branch2Name, 'and modified in', branch1Name + '.', \
-                      'Version', branch1Name, 'of', path, 'left in tree.'
+                output('CONFLICT (modify/delete):', path, 'deleted in',
+                       branch2Name, 'and modified in', branch1Name + '.',
+                       'Version', branch1Name, 'of', path, 'left in tree.')
                 mode = aMode
                 sha = aSha
 
@@ -755,14 +763,14 @@ def processEntry(entry, branch1Name, bra
         if path in currentDirectorySet:
             cleanMerge = False
             newPath = uniquePath(path, addBranch)
-            print 'CONFLICT (' + conf + '):', \
-                  'There is a directory with name', path, 'in', \
-                  otherBranch + '. Adding', path, 'as', newPath
+            output('CONFLICT (' + conf + '):',
+                   'There is a directory with name', path, 'in',
+                   otherBranch + '. Adding', path, 'as', newPath)
 
             removeFile(False, path)
             updateFile(False, sha, mode, newPath)
         else:
-            print 'Adding', path
+            output('Adding', path)
             updateFile(True, sha, mode, path)
     
     elif not oSha and aSha and bSha:
@@ -772,10 +780,10 @@ def processEntry(entry, branch1Name, bra
         if aSha == bSha:
             if aMode != bMode:
                 cleanMerge = False
-                print 'CONFLICT: File', path, \
-                      'added identically in both branches, but permissions', \
-                      'conflict', '0%o' % aMode, '->', '0%o' % bMode
-                print 'CONFLICT: adding with permission:', '0%o' % aMode
+                output('CONFLICT: File', path,
+                       'added identically in both branches, but permissions',
+                       'conflict', '0%o' % aMode, '->', '0%o' % bMode)
+                output('CONFLICT: adding with permission:', '0%o' % aMode)
 
                 updateFile(False, aSha, aMode, path)
             else:
@@ -785,9 +793,9 @@ def processEntry(entry, branch1Name, bra
             cleanMerge = False
             newPath1 = uniquePath(path, branch1Name)
             newPath2 = uniquePath(path, branch2Name)
-            print 'CONFLICT (add/add): File', path, \
-                  'added non-identically in both branches. Adding as', \
-                  newPath1, 'and', newPath2, 'instead.'
+            output('CONFLICT (add/add): File', path,
+                   'added non-identically in both branches. Adding as',
+                   newPath1, 'and', newPath2, 'instead.')
             removeFile(False, path)
             updateFile(False, aSha, aMode, newPath1)
             updateFile(False, bSha, bMode, newPath2)
@@ -796,7 +804,7 @@ def processEntry(entry, branch1Name, bra
     #
     # case D: Modified in both, but differently.
     #
-        print 'Auto-merging', path
+        output('Auto-merging', path)
         [sha, mode, clean, dummy] = \
               mergeFile(path, oSha, oMode,
                         path, aSha, aMode,
@@ -806,7 +814,7 @@ def processEntry(entry, branch1Name, bra
             updateFile(True, sha, mode, path)
         else:
             cleanMerge = False
-            print 'CONFLICT (content): Merge conflict in', path
+            output('CONFLICT (content): Merge conflict in', path)
 
             if cacheOnly:
                 updateFile(False, sha, mode, path)
---
0.99.9.GIT
