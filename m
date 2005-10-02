From: Fredrik Kuivinen <freku045@student.liu.se>
Subject: [PATCH] Teach the recursive merge strategy about renames.
Date: Sun, 2 Oct 2005 17:43:07 +0200
Message-ID: <20051002154307.GB1685@c165.ib.student.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: junkio@cox.net
X-From: git-owner@vger.kernel.org Sun Oct 02 17:43:45 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EM5zk-0002oi-A3
	for gcvg-git@gmane.org; Sun, 02 Oct 2005 17:43:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751114AbVJBPnQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 2 Oct 2005 11:43:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751115AbVJBPnP
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Oct 2005 11:43:15 -0400
Received: from [85.8.31.11] ([85.8.31.11]:14779 "EHLO mail6.wasadata.com")
	by vger.kernel.org with ESMTP id S1751114AbVJBPnO (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 2 Oct 2005 11:43:14 -0400
Received: from c165 (unknown [85.8.2.189])
	by mail6.wasadata.com (Postfix) with ESMTP
	id 21E5C4102; Sun,  2 Oct 2005 17:49:24 +0200 (CEST)
Received: from ksorim by c165 with local (Exim 3.36 #1 (Debian))
	id 1EM5zX-0006f5-00; Sun, 02 Oct 2005 17:43:07 +0200
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9619>

It will now merge cases where a file was renamed in one branch and
modified in the other branch cleanly. We also detect a couple of
conflict cases now that wasn't detected before.

Signed-off-by: Fredrik Kuivinen <freku045@student.liu.se>


---

This patch turned out to be quite large.

I have tested it on all the problematic merge cases that have been
reported on this list, all multiple common ancestor cases in Thomas
Gleixner's historic Linux repository and a number of handcrafted test
cases.

With the patch the recursive merge strategy produces correct result
for all those merge commits (with one possible exception, see below).
With 'correct result' I mean that one of the following cases occur:

1. The merge is clean and the result match the committed tree.
2. The merge is non-clean.
3. The merge is clean and the difference from the committed tree can
   be explained. One commit which is in this category is Tony Luck's
   merge (<200508232256.j7NMuR1q027892@agluck-lia64.sc.intel.com>).

The possible exception is commit
091cced38d83732ee3212806ef5ea07abbef01fe in the historic repository.
I have still not managed to find out what the correct result should be
in this case. The recursive strategy merges it cleanly and the result
differs from what was actually committed. The resolve strategy
produces a non-clean result.

There are 409 merge commits in the historic repository which has more
than one common ancestor. Of those 409 commits 26 are merged
non-cleanly by the recursive strategy. Everything else, except
091cce..., is merged cleanly and correctly.

With the resolve strategy we get 73 non-clean results and five cases
which are merged cleanly but the result do not match what was
committed.


 git-merge-recursive.py |  794 +++++++++++++++++++++++++++++++++++++-----------
 1 files changed, 605 insertions(+), 189 deletions(-)

eccd8d673e2401ed2495272204b42173214ae27c
diff --git a/git-merge-recursive.py b/git-merge-recursive.py
--- a/git-merge-recursive.py
+++ b/git-merge-recursive.py
@@ -7,9 +7,6 @@ from sets import Set
 sys.path.append('@@GIT_PYTHON_PATH@@')
 from gitMergeCommon import *
 
-# The actual merge code
-# ---------------------
-
 originalIndexFile = os.environ.get('GIT_INDEX_FILE',
                                    os.environ.get('GIT_DIR', '.git') + '/index')
 temporaryIndexFile = os.environ.get('GIT_DIR', '.git') + \
@@ -21,11 +18,23 @@ def setupIndex(temporary):
         pass
     if temporary:
         newIndex = temporaryIndexFile
-        os.environ
     else:
         newIndex = originalIndexFile
     os.environ['GIT_INDEX_FILE'] = newIndex
 
+# This is a global variable which is used in a number of places but
+# only written to in the 'merge' function.
+
+# cacheOnly == True  => Don't leave any non-stage 0 entries in the cache and
+#                       don't update the working directory.
+#              False => Leave unmerged entries in the cache and update
+#                       the working directory.
+
+cacheOnly = False
+
+# The entry point to the merge code
+# ---------------------------------
+
 def merge(h1, h2, branch1Name, branch2Name, graph, callDepth=0):
     '''Merge the commits h1 and h2, return the resulting virtual
     commit object and a flag indicating the cleaness of the merge.'''
@@ -35,6 +44,7 @@ def merge(h1, h2, branch1Name, branch2Na
     def infoMsg(*args):
         sys.stdout.write('  '*callDepth)
         printList(args)
+
     infoMsg('Merging:')
     infoMsg(h1)
     infoMsg(h2)
@@ -46,27 +56,27 @@ def merge(h1, h2, branch1Name, branch2Na
         infoMsg(x)
     sys.stdout.flush()
 
-    Ms = ca[0]
+    mergedCA = ca[0]
     for h in ca[1:]:
-        [Ms, ignore] = merge(Ms, h,
-                             'Temporary shared merge branch 1',
-                             'Temporary shared merge branch 2',
-                             graph, callDepth+1)
-        assert(isinstance(Ms, Commit))
+        [mergedCA, dummy] = merge(mergedCA, h,
+                                  'Temporary shared merge branch 1',
+                                  'Temporary shared merge branch 2',
+                                  graph, callDepth+1)
+        assert(isinstance(mergedCA, Commit))
 
+    global cacheOnly
     if callDepth == 0:
         setupIndex(False)
-        cleanCache = False
+        cacheOnly = False
     else:
         setupIndex(True)
         runProgram(['git-read-tree', h1.tree()])
-        cleanCache = True
+        cacheOnly = True
 
-    [shaRes, clean] = mergeTrees(h1.tree(), h2.tree(), Ms.tree(),
-                                 branch1Name, branch2Name,
-                                 cleanCache)
+    [shaRes, clean] = mergeTrees(h1.tree(), h2.tree(), mergedCA.tree(),
+                                 branch1Name, branch2Name)
 
-    if clean or cleanCache:
+    if clean or cacheOnly:
         res = Commit(None, [h1, h2], tree=shaRes)
         graph.addNode(res)
     else:
@@ -89,16 +99,255 @@ def getFilesAndDirs(tree):
 
     return [files, dirs]
 
+# Those two global variables are used in a number of places but only
+# written to in 'mergeTrees' and 'uniquePath'. They keep track of
+# every file and directory in the two branches that are about to be
+# merged.
+currentFileSet = None
+currentDirectorySet = None
+
+def mergeTrees(head, merge, common, branch1Name, branch2Name):
+    '''Merge the trees 'head' and 'merge' with the common ancestor
+    'common'. The name of the head branch is 'branch1Name' and the name of
+    the merge branch is 'branch2Name'. Return a tuple (tree, cleanMerge)
+    where tree is the resulting tree and cleanMerge is True iff the
+    merge was clean.'''
+    
+    assert(isSha(head) and isSha(merge) and isSha(common))
+
+    if common == merge:
+        print 'Already uptodate!'
+        return [head, True]
+
+    if cacheOnly:
+        updateArg = '-i'
+    else:
+        updateArg = '-u'
+
+    [out, code] = runProgram(['git-read-tree', updateArg, '-m',
+                                common, head, merge], returnCode = True)
+    if code != 0:
+        die('git-read-tree:', out)
+
+    [tree, code] = runProgram('git-write-tree', returnCode=True)
+    tree = tree.rstrip()
+    if code != 0:
+        global currentFileSet, currentDirectorySet
+        [currentFileSet, currentDirectorySet] = getFilesAndDirs(head)
+        [filesM, dirsM] = getFilesAndDirs(merge)
+        currentFileSet.union_update(filesM)
+        currentDirectorySet.union_update(dirsM)
+
+        entries = unmergedCacheEntries()
+        renamesHead =  getRenames(head, common, head, merge, entries)
+        renamesMerge = getRenames(merge, common, head, merge, entries)
+
+        cleanMerge = processRenames(renamesHead, renamesMerge,
+                                    branch1Name, branch2Name)
+        for entry in entries:
+            if entry.processed:
+                continue
+            if not processEntry(entry, branch1Name, branch2Name):
+                cleanMerge = False
+                
+        if cleanMerge or cacheOnly:
+            tree = runProgram('git-write-tree').rstrip()
+        else:
+            tree = None
+    else:
+        cleanMerge = True
+
+    return [tree, cleanMerge]
+
+# Low level file merging, update and removal
+# ------------------------------------------
+
+def mergeFile(oPath, oSha, oMode, aPath, aSha, aMode, bPath, bSha, bMode,
+              branch1Name, branch2Name):
+
+    merge = False
+    clean = True
+
+    if stat.S_IFMT(aMode) != stat.S_IFMT(bMode):
+        clean = False
+        if stat.S_ISREG(aMode):
+            mode = aMode
+            sha = aSha
+        else:
+            mode = bMode
+            sha = bSha
+    else:
+        if aSha != oSha and bSha != oSha:
+            merge = True
+
+        if aMode == oMode:
+            mode = bMode
+        else:
+            mode = aMode
+
+        if aSha == oSha:
+            sha = bSha
+        elif bSha == oSha:
+            sha = aSha
+        elif stat.S_ISREG(aMode):
+            assert(stat.S_ISREG(bMode))
+
+            orig = runProgram(['git-unpack-file', oSha]).rstrip()
+            src1 = runProgram(['git-unpack-file', aSha]).rstrip()
+            src2 = runProgram(['git-unpack-file', bSha]).rstrip()
+            [out, code] = runProgram(['merge',
+                                      '-L', branch1Name + '/' + aPath,
+                                      '-L', 'orig/' + oPath,
+                                      '-L', branch2Name + '/' + bPath,
+                                      src1, orig, src2], returnCode=True)
+
+            sha = runProgram(['git-hash-object', '-t', 'blob', '-w',
+                              src1]).rstrip()
+
+            os.unlink(orig)
+            os.unlink(src1)
+            os.unlink(src2)
+            
+            clean = (code == 0)
+        else:
+            assert(stat.S_ISLNK(aMode) and stat.S_ISLNK(bMode))
+            sha = aSha
+
+            if aSha != bSha:
+                clean = False
+
+    return [sha, mode, clean, merge]
+
+def updateFile(clean, sha, mode, path):
+    updateCache = cacheOnly or clean
+    updateWd = not cacheOnly
+
+    return updateFileExt(sha, mode, path, updateCache, updateWd)
+
+def updateFileExt(sha, mode, path, updateCache, updateWd):
+    if cacheOnly:
+        updateWd = False
+
+    if updateWd:
+        pathComponents = path.split('/')
+        for x in xrange(1, len(pathComponents)):
+            p = '/'.join(pathComponents[0:x])
+
+            try:
+                createDir = not stat.S_ISDIR(os.lstat(p).st_mode)
+            except: 
+                createDir = True
+            
+            if createDir:
+                try:
+                    os.mkdir(p)
+                except OSError, e:
+                    die("Couldn't create directory", p, e.strerror)
+
+        prog = ['git-cat-file', 'blob', sha]
+        if stat.S_ISREG(mode):
+            try:
+                os.unlink(path)
+            except OSError:
+                pass
+            if mode & 0100:
+                mode = 0777
+            else:
+                mode = 0666
+            fd = os.open(path, os.O_WRONLY | os.O_TRUNC | os.O_CREAT, mode)
+            proc = subprocess.Popen(prog, stdout=fd)
+            proc.wait()
+            os.close(fd)
+        elif stat.S_ISLNK(mode):
+            linkTarget = runProgram(prog)
+            os.symlink(linkTarget, path)
+        else:
+            assert(False)
+
+    if updateWd and updateCache:
+        runProgram(['git-update-index', '--add', '--', path])
+    elif updateCache:
+        runProgram(['git-update-index', '--add', '--cacheinfo',
+                    '0%o' % mode, sha, path])
+
+def removeFile(clean, path):
+    updateCache = cacheOnly or clean
+    updateWd = not cacheOnly
+
+    if updateCache:
+        runProgram(['git-update-index', '--force-remove', '--', path])
+
+    if updateWd:
+        try:
+            os.unlink(path)
+        except OSError, e:
+            if e.errno != errno.ENOENT and e.errno != errno.EISDIR:
+                raise
+
+def uniquePath(path, branch):
+    def fileExists(path):
+        try:
+            os.lstat(path)
+            return True
+        except OSError, e:
+            if e.errno == errno.ENOENT:
+                return False
+            else:
+                raise
+
+    newPath = path + '_' + branch
+    suffix = 0
+    while newPath in currentFileSet or \
+          newPath in currentDirectorySet  or \
+          fileExists(newPath):
+        suffix += 1
+        newPath = path + '_' + branch + '_' + str(suffix)
+    currentFileSet.add(newPath)
+    return newPath
+
+# Cache entry management
+# ----------------------
+
 class CacheEntry:
     def __init__(self, path):
         class Stage:
             def __init__(self):
                 self.sha1 = None
                 self.mode = None
+
+            # Used for debugging only
+            def __str__(self):
+                if self.mode != None:
+                    m = '0%o' % self.mode
+                else:
+                    m = 'None'
+
+                if self.sha1:
+                    sha1 = self.sha1
+                else:
+                    sha1 = 'None'
+                return 'sha1: ' + sha1 + ' mode: ' + m
         
-        self.stages = [Stage(), Stage(), Stage()]
+        self.stages = [Stage(), Stage(), Stage(), Stage()]
         self.path = path
+        self.processed = False
+
+    def __str__(self):
+        return 'path: ' + self.path + ' stages: ' + repr([str(x) for x in self.stages])
+
+class CacheEntryContainer:
+    def __init__(self):
+        self.entries = {}
+
+    def add(self, entry):
+        self.entries[entry.path] = entry
 
+    def get(self, path):
+        return self.entries.get(path)
+
+    def __iter__(self):
+        return self.entries.itervalues()
+    
 unmergedRE = re.compile(r'^([0-7]+) ([0-9a-f]{40}) ([1-3])\t(.*)$', re.S)
 def unmergedCacheEntries():
     '''Create a dictionary mapping file names to CacheEntry
@@ -108,155 +357,340 @@ def unmergedCacheEntries():
     lines = runProgram(['git-ls-files', '-z', '--unmerged']).split('\0')
     lines.pop()
 
-    res = {}
+    res = CacheEntryContainer()
     for l in lines:
         m = unmergedRE.match(l)
         if m:
             mode = int(m.group(1), 8)
             sha1 = m.group(2)
-            stage = int(m.group(3)) - 1
+            stage = int(m.group(3))
             path = m.group(4)
 
-            if res.has_key(path):
-                e = res[path]
-            else:
+            e = res.get(path)
+            if not e:
                 e = CacheEntry(path)
-                res[path] = e
-                
+                res.add(e)
+
             e.stages[stage].mode = mode
             e.stages[stage].sha1 = sha1
         else:
-            die('Error: Merge program failed: Unexpected output from', \
+            die('Error: Merge program failed: Unexpected output from',
                 'git-ls-files:', l)
     return res
 
-def mergeTrees(head, merge, common, branch1Name, branch2Name,
-               cleanCache):
-    '''Merge the trees 'head' and 'merge' with the common ancestor
-    'common'. The name of the head branch is 'branch1Name' and the name of
-    the merge branch is 'branch2Name'. Return a tuple (tree, cleanMerge)
-    where tree is the resulting tree and cleanMerge is True iff the
-    merge was clean.'''
+lsTreeRE = re.compile(r'^([0-7]+) (\S+) ([0-9a-f]{40})\t(.*)\n$', re.S)
+def getCacheEntry(path, origTree, aTree, bTree):
+    '''Returns a CacheEntry object which doesn't have to correspond to
+    a real cache entry in Git's index.'''
     
-    assert(isSha(head) and isSha(merge) and isSha(common))
+    def parse(out):
+        if out == '':
+            return [None, None]
+        else:
+            m = lsTreeRE.match(out)
+            if not m:
+                die('Unexpected output from git-ls-tree:', out)
+            elif m.group(2) == 'blob':
+                return [m.group(3), int(m.group(1), 8)]
+            else:
+                return [None, None]
 
-    if common == merge:
-        print 'Already uptodate!'
-        return [head, True]
+    res = CacheEntry(path)
 
-    if cleanCache:
-        updateArg = '-i'
+    [oSha, oMode] = parse(runProgram(['git-ls-tree', origTree, '--', path]))
+    [aSha, aMode] = parse(runProgram(['git-ls-tree', aTree, '--', path]))
+    [bSha, bMode] = parse(runProgram(['git-ls-tree', bTree, '--', path]))
+
+    res.stages[1].sha1 = oSha
+    res.stages[1].mode = oMode
+    res.stages[2].sha1 = aSha
+    res.stages[2].mode = aMode
+    res.stages[3].sha1 = bSha
+    res.stages[3].mode = bMode
+
+    return res
+
+# Rename detection and handling
+# -----------------------------
+
+class RenameEntry:
+    def __init__(self,
+                 src, srcSha, srcMode, srcCacheEntry,
+                 dst, dstSha, dstMode, dstCacheEntry,
+                 score):
+        self.srcName = src
+        self.srcSha = srcSha
+        self.srcMode = srcMode
+        self.srcCacheEntry = srcCacheEntry
+        self.dstName = dst
+        self.dstSha = dstSha
+        self.dstMode = dstMode
+        self.dstCacheEntry = dstCacheEntry
+        self.score = score
+
+        self.processed = False
+
+class RenameEntryContainer:
+    def __init__(self):
+        self.entriesSrc = {}
+        self.entriesDst = {}
+
+    def add(self, entry):
+        self.entriesSrc[entry.srcName] = entry
+        self.entriesDst[entry.dstName] = entry
+
+    def getSrc(self, path):
+        return self.entriesSrc.get(path)
+
+    def getDst(self, path):
+        return self.entriesDst.get(path)
+
+    def __iter__(self):
+        return self.entriesSrc.itervalues()
+
+parseDiffRenamesRE = re.compile('^:([0-7]+) ([0-7]+) ([0-9a-f]{40}) ([0-9a-f]{40}) R([0-9]*)$')
+def getRenames(tree, oTree, aTree, bTree, cacheEntries):
+    '''Get information of all renames which occured between 'oTree' and
+    'tree'. We need the three trees in the merge ('oTree', 'aTree' and
+    'bTree') to be able to associate the correct cache entries with
+    the rename information. 'tree' is always equal to either aTree or bTree.'''
+
+    assert(tree == aTree or tree == bTree)
+    inp = runProgram(['git-diff-tree', '-M', '--diff-filter=R', '-r',
+                      '-z', oTree, tree])
+
+    ret = RenameEntryContainer()
+    try:
+        recs = inp.split("\0")
+        recs.pop() # remove last entry (which is '')
+        it = recs.__iter__()
+        while True:
+            rec = it.next()
+            m = parseDiffRenamesRE.match(rec)
+
+            if not m:
+                die('Unexpected output from git-diff-tree:', rec)
+
+            srcMode = int(m.group(1), 8)
+            dstMode = int(m.group(2), 8)
+            srcSha = m.group(3)
+            dstSha = m.group(4)
+            score = m.group(5)
+            src = it.next()
+            dst = it.next()
+
+            srcCacheEntry = cacheEntries.get(src)
+            if not srcCacheEntry:
+                srcCacheEntry = getCacheEntry(src, oTree, aTree, bTree)
+                cacheEntries.add(srcCacheEntry)
+
+            dstCacheEntry = cacheEntries.get(dst)
+            if not dstCacheEntry:
+                dstCacheEntry = getCacheEntry(dst, oTree, aTree, bTree)
+                cacheEntries.add(dstCacheEntry)
+
+            ret.add(RenameEntry(src, srcSha, srcMode, srcCacheEntry,
+                                dst, dstSha, dstMode, dstCacheEntry,
+                                score))
+    except StopIteration:
+        pass
+    return ret
+
+def fmtRename(src, dst):
+    srcPath = src.split('/')
+    dstPath = dst.split('/')
+    path = []
+    endIndex = min(len(srcPath), len(dstPath)) - 1
+    for x in range(0, endIndex):
+        if srcPath[x] == dstPath[x]:
+            path.append(srcPath[x])
+        else:
+            endIndex = x
+            break
+
+    if len(path) > 0:
+        return '/'.join(path) + \
+               '/{' + '/'.join(srcPath[endIndex:]) + ' => ' + \
+               '/'.join(dstPath[endIndex:]) + '}'
     else:
-        updateArg = '-u'
+        return src + ' => ' + dst
 
-    [out, code] = runProgram(['git-read-tree', updateArg, '-m', common, head, merge], returnCode = True)
-    if code != 0:
-        die('git-read-tree:', out)
+def processRenames(renamesA, renamesB, branchNameA, branchNameB):
+    srcNames = Set()
+    for x in renamesA:
+        srcNames.add(x.srcName)
+    for x in renamesB:
+        srcNames.add(x.srcName)
 
     cleanMerge = True
-
-    [tree, code] = runProgram('git-write-tree', returnCode=True)
-    tree = tree.rstrip()
-    if code != 0:
-        [files, dirs] = getFilesAndDirs(head)
-        [filesM, dirsM] = getFilesAndDirs(merge)
-        files.union_update(filesM)
-        dirs.union_update(dirsM)
+    for path in srcNames:
+        if renamesA.getSrc(path):
+            renames1 = renamesA
+            renames2 = renamesB
+            branchName1 = branchNameA
+            branchName2 = branchNameB
+        else:
+            renames1 = renamesB
+            renames2 = renamesA
+            branchName1 = branchNameB
+            branchName2 = branchNameA
         
-        cleanMerge = True
-        entries = unmergedCacheEntries()
-        for name in entries:
-            if not processEntry(entries[name], branch1Name, branch2Name,
-                                files, dirs, cleanCache):
+        ren1 = renames1.getSrc(path)
+        ren2 = renames2.getSrc(path)
+
+        ren1.dstCacheEntry.processed = True
+        ren1.srcCacheEntry.processed = True
+
+        if ren1.processed:
+            continue
+
+        ren1.processed = True
+        removeFile(True, ren1.srcName)
+        if ren2:
+            # Renamed in 1 and renamed in 2
+            assert(ren1.srcName == ren2.srcName)
+            ren2.dstCacheEntry.processed = True
+            ren2.processed = True
+
+            if ren1.dstName != ren2.dstName:
+                print 'CONFLICT (rename/rename): Rename', \
+                      fmtRename(path, ren1.dstName), 'in branch', branchName1, \
+                      'rename', fmtRename(path, ren2.dstName), 'in', branchName2
                 cleanMerge = False
-                
-        if cleanMerge or cleanCache:
-            tree = runProgram('git-write-tree').rstrip()
-        else:
-            tree = None
-    else:
-        cleanMerge = True
 
-    return [tree, cleanMerge]
+                if ren1.dstName in currentDirectorySet:
+                    dstName1 = uniquePath(ren1.dstName, branchName1)
+                    print ren1.dstName, 'is a directory in', branchName2, \
+                          'adding as', dstName1, 'instead.'
+                    removeFile(False, ren1.dstName)
+                else:
+                    dstName1 = ren1.dstName
 
-def processEntry(entry, branch1Name, branch2Name, files, dirs, cleanCache):
-    '''Merge one cache entry. 'files' is a Set with the files in both of
-    the heads that we are going to merge. 'dirs' contains the
-    corresponding data for directories. If 'cleanCache' is True no
-    non-zero stages will be left in the cache for the path
-    corresponding to the entry 'entry'.'''
-
-# cleanCache == True  => Don't leave any non-stage 0 entries in the cache and
-#                        don't update the working directory
-#               False => Leave unmerged entries and update the working directory
-
-# clean     == True  => non-conflict case
-#              False => conflict case
-
-# If cleanCache == False then the cache shouldn't be updated if clean == False
-
-    def updateFile(clean, sha, mode, path, onlyWd=False):
-        updateCache = not onlyWd and (cleanCache or (not cleanCache and clean))
-        updateWd = onlyWd or (not cleanCache and clean)
-
-        if updateWd:
-            prog = ['git-cat-file', 'blob', sha]
-            if stat.S_ISREG(mode):
-                try:
-                    os.unlink(path)
-                except OSError:
-                    pass
-                if mode & 0100:
-                    mode = 0777
+                if ren2.dstName in currentDirectorySet:
+                    dstName2 = uniquePath(ren2.dstName, branchName2)
+                    print ren2.dstName, 'is a directory in', branchName1, \
+                          'adding as', dstName2, 'instead.'
+                    removeFile(False, ren2.dstName)
                 else:
-                    mode = 0666
-                fd = os.open(path, os.O_WRONLY | os.O_TRUNC | os.O_CREAT, mode)
-                proc = subprocess.Popen(prog, stdout=fd)
-                proc.wait()
-                os.close(fd)
-            elif stat.S_ISLNK(mode):
-                linkTarget = runProgram(prog)
-                os.symlink(linkTarget, path)
+                    dstName2 = ren1.dstName
+
+                updateFile(False, ren1.dstSha, ren1.dstMode, dstName1)
+                updateFile(False, ren2.dstSha, ren2.dstMode, dstName2)
             else:
-                assert(False)
+                print 'Renaming', fmtRename(path, ren1.dstName)
+                [resSha, resMode, clean, merge] = \
+                         mergeFile(ren1.srcName, ren1.srcSha, ren1.srcMode,
+                                   ren1.dstName, ren1.dstSha, ren1.dstMode,
+                                   ren2.dstName, ren2.dstSha, ren2.dstMode,
+                                   branchName1, branchName2)
+
+                if merge:
+                    print 'Auto-merging', ren1.dstName
+
+                if not clean:
+                    print 'CONFLICT (content): merge conflict in', ren1.dstName
+                    cleanMerge = False
+
+                    if not cacheOnly:
+                        updateFileExt(ren1.dstSha, ren1.dstMode, ren1.dstName,
+                                      updateCache=True, updateWd=False)
+                updateFile(clean, resSha, resMode, ren1.dstName)
+        else:
+            # Renamed in 1, maybe changed in 2
+            if renamesA == renames1:
+                stage = 3
+            else:
+                stage = 2
+                
+            srcShaOtherBranch  = ren1.srcCacheEntry.stages[stage].sha1
+            srcModeOtherBranch = ren1.srcCacheEntry.stages[stage].mode
 
-        if updateWd and updateCache:
-            runProgram(['git-update-index', '--add', '--', path])
-        elif updateCache:
-            runProgram(['git-update-index', '--add', '--cacheinfo',
-                        '0%o' % mode, sha, path])
-
-    def removeFile(clean, path):
-        if cleanCache or (not cleanCache and clean):
-            runProgram(['git-update-index', '--force-remove', '--', path])
+            dstShaOtherBranch  = ren1.dstCacheEntry.stages[stage].sha1
+            dstModeOtherBranch = ren1.dstCacheEntry.stages[stage].mode
 
-        if not cleanCache and clean:
-            try:
-                os.unlink(path)
-            except OSError, e:
-                if e.errno != errno.ENOENT and e.errno != errno.EISDIR:
-                    raise
-
-    def uniquePath(path, branch):
-        newPath = path + '_' + branch
-        suffix = 0
-        while newPath in files or newPath in dirs:
-            suffix += 1
-            newPath = path + '_' + branch + '_' + str(suffix)
-        files.add(newPath)
-        return newPath
+            tryMerge = False
+            
+            if ren1.dstName in currentDirectorySet:
+                newPath = uniquePath(ren1.dstName, branchName1)
+                print 'CONFLICT (rename/directory): Rename', \
+                      fmtRename(ren1.srcName, ren1.dstName), 'in', branchName1,\
+                      'directory', ren1.dstName, 'added in', branchName2
+                print 'Renaming', ren1.srcName, 'to', newPath, 'instead'
+                cleanMerge = False
+                removeFile(False, ren1.dstName)
+                updateFile(False, ren1.dstSha, ren1.dstMode, newPath)
+            elif srcShaOtherBranch == None:
+                print 'CONFLICT (rename/delete): Rename', \
+                      fmtRename(ren1.srcName, ren1.dstName), 'in', \
+                      branchName1, 'and deleted in', branchName2
+                cleanMerge = False
+                updateFile(False, ren1.dstSha, ren1.dstMode, ren1.dstName)
+            elif dstShaOtherBranch:
+                newPath = uniquePath(ren1.dstName, branchName2)
+                print 'CONFLICT (rename/add): Rename', \
+                      fmtRename(ren1.srcName, ren1.dstName), 'in', \
+                      branchName1 + '.', ren1.dstName, 'added in', branchName2
+                print 'Adding as', newPath, 'instead'
+                updateFile(False, dstShaOtherBranch, dstModeOtherBranch, newPath)
+                cleanMerge = False
+                tryMerge = True
+            elif renames2.getDst(ren1.dstName):
+                dst2 = renames2.getDst(ren1.dstName)
+                newPath1 = uniquePath(ren1.dstName, branchName1)
+                newPath2 = uniquePath(dst2.dstName, branchName2)
+                print 'CONFLICT (rename/rename): Rename', \
+                      fmtRename(ren1.srcName, ren1.dstName), 'in', \
+                      branchName1+'. Rename', \
+                      fmtRename(dst2.srcName, dst2.dstName), 'in', branchName2
+                print 'Renaming', ren1.srcName, 'to', newPath1, 'and', \
+                      dst2.srcName, 'to', newPath2, 'instead'
+                removeFile(False, ren1.dstName)
+                updateFile(False, ren1.dstSha, ren1.dstMode, newPath1)
+                updateFile(False, dst2.dstSha, dst2.dstMode, newPath2)
+                dst2.processed = True
+                cleanMerge = False
+            else:
+                tryMerge = True
+
+            if tryMerge:
+                print 'Renaming', fmtRename(ren1.srcName, ren1.dstName)
+                [resSha, resMode, clean, merge] = \
+                         mergeFile(ren1.srcName, ren1.srcSha, ren1.srcMode,
+                                   ren1.dstName, ren1.dstSha, ren1.dstMode,
+                                   ren1.srcName, srcShaOtherBranch, srcModeOtherBranch,
+                                   branchName1, branchName2)
+
+                if merge:
+                    print 'Auto-merging', ren1.dstName
+
+                if not clean:
+                    print 'CONFLICT (rename/modify): Merge conflict in', ren1.dstName
+                    cleanMerge = False
+
+                    if not cacheOnly:
+                        updateFileExt(ren1.dstSha, ren1.dstMode, ren1.dstName,
+                                      updateCache=True, updateWd=False)
+                updateFile(clean, resSha, resMode, ren1.dstName)
+
+    return cleanMerge
 
-    debug('processing', entry.path, 'clean cache:', cleanCache)
+# Per entry merge function
+# ------------------------
+
+def processEntry(entry, branch1Name, branch2Name):
+    '''Merge one cache entry.'''
+
+    debug('processing', entry.path, 'clean cache:', cacheOnly)
 
     cleanMerge = True
 
     path = entry.path
-    oSha = entry.stages[0].sha1
-    oMode = entry.stages[0].mode
-    aSha = entry.stages[1].sha1
-    aMode = entry.stages[1].mode
-    bSha = entry.stages[2].sha1
-    bMode = entry.stages[2].mode
+    oSha = entry.stages[1].sha1
+    oMode = entry.stages[1].mode
+    aSha = entry.stages[2].sha1
+    aMode = entry.stages[2].mode
+    bSha = entry.stages[3].sha1
+    bMode = entry.stages[3].mode
 
     assert(oSha == None or isSha(oSha))
     assert(aSha == None or isSha(aSha))
@@ -275,28 +709,26 @@ def processEntry(entry, branch1Name, bra
            (not aSha     and bSha == oSha):
     # Deleted in both or deleted in one and unchanged in the other
             if aSha:
-                print 'Removing ' + path
+                print 'Removing', path
             removeFile(True, path)
         else:
     # Deleted in one and changed in the other
             cleanMerge = False
             if not aSha:
-                print 'CONFLICT (del/mod): "' + path + '" deleted in', \
-                      branch1Name, 'and modified in', branch2Name, \
-                      '. Version', branch2Name, ' of "' + path + \
-                      '" left in tree'
+                print 'CONFLICT (delete/modify):', path, 'deleted in', \
+                      branch1Name, 'and modified in', branch2Name + '.', \
+                      'Version', branch2Name, 'of', path, 'left in tree.'
                 mode = bMode
                 sha = bSha
             else:
-                print 'CONFLICT (mod/del): "' + path + '" deleted in', \
-                      branch2Name, 'and modified in', branch1Name + \
-                      '. Version', branch1Name, 'of "' + path + \
-                      '" left in tree'
+                print 'CONFLICT (modify/delete):', path, 'deleted in', \
+                      branch2Name, 'and modified in', branch1Name + '.', \
+                      'Version', branch1Name, 'of', path, 'left in tree.'
                 mode = aMode
                 sha = aSha
 
             updateFile(False, sha, mode, path)
-    
+
     elif (not oSha and aSha     and not bSha) or \
          (not oSha and not aSha and bSha):
     #
@@ -307,27 +739,26 @@ def processEntry(entry, branch1Name, bra
             otherBranch = branch2Name
             mode = aMode
             sha = aSha
-            conf = 'file/dir'
+            conf = 'file/directory'
         else:
             addBranch = branch2Name
             otherBranch = branch1Name
             mode = bMode
             sha = bSha
-            conf = 'dir/file'
+            conf = 'directory/file'
     
-        if path in dirs:
+        if path in currentDirectorySet:
             cleanMerge = False
             newPath = uniquePath(path, addBranch)
-            print 'CONFLICT (' + conf + \
-                  '): There is a directory with name "' + path + '" in', \
-                  otherBranch + '. Adding "' + path + '" as "' + newPath + '"'
+            print 'CONFLICT (' + conf + '):', \
+                  'There is a directory with name', path, 'in', \
+                  otherBranch + '. Adding', path, 'as', newPath
 
             removeFile(False, path)
-            path = newPath
+            updateFile(False, sha, mode, newPath)
         else:
-            print 'Adding "' + path + '"'
-
-        updateFile(True, sha, mode, path)
+            print 'Adding', path
+            updateFile(True, sha, mode, path)
     
     elif not oSha and aSha and bSha:
     #
@@ -336,10 +767,9 @@ def processEntry(entry, branch1Name, bra
         if aSha == bSha:
             if aMode != bMode:
                 cleanMerge = False
-                print 'CONFLICT: File "' + path + \
-                      '" added identically in both branches,', \
-                      'but permissions conflict', '0%o' % aMode, '->', \
-                      '0%o' % bMode
+                print 'CONFLICT: File', path, \
+                      'added identically in both branches, but permissions', \
+                      'conflict', '0%o' % aMode, '->', '0%o' % bMode
                 print 'CONFLICT: adding with permission:', '0%o' % aMode
 
                 updateFile(False, aSha, aMode, path)
@@ -350,8 +780,9 @@ def processEntry(entry, branch1Name, bra
             cleanMerge = False
             newPath1 = uniquePath(path, branch1Name)
             newPath2 = uniquePath(path, branch2Name)
-            print 'CONFLICT (add/add): File "' + path + \
-                  '" added non-identically in both branches.'
+            print 'CONFLICT (add/add): File', path, \
+                  'added non-identically in both branches. Adding as', \
+                  newPath1, 'and', newPath2, 'instead.'
             removeFile(False, path)
             updateFile(False, aSha, aMode, newPath1)
             updateFile(False, bSha, bMode, newPath2)
@@ -360,39 +791,24 @@ def processEntry(entry, branch1Name, bra
     #
     # case D: Modified in both, but differently.
     #
-        print 'Auto-merging', path 
-        orig = runProgram(['git-unpack-file', oSha]).rstrip()
-        src1 = runProgram(['git-unpack-file', aSha]).rstrip()
-        src2 = runProgram(['git-unpack-file', bSha]).rstrip()
-        [out, ret] = runProgram(['merge',
-                                 '-L', branch1Name + '/' + path,
-                                 '-L', 'orig/' + path,
-                                 '-L', branch2Name + '/' + path,
-                                 src1, orig, src2], returnCode=True)
-
-        if aMode == oMode:
-            mode = bMode
+        print 'Auto-merging', path
+        [sha, mode, clean, dummy] = \
+              mergeFile(path, oSha, oMode,
+                        path, aSha, aMode,
+                        path, bSha, bMode,
+                        branch1Name, branch2Name)
+        if clean:
+            updateFile(True, sha, mode, path)
         else:
-            mode = aMode
-
-        sha = runProgram(['git-hash-object', '-t', 'blob', '-w',
-                          src1]).rstrip()
-
-        if ret != 0:
             cleanMerge = False
-            print 'CONFLICT (content): Merge conflict in "' + path + '".'
+            print 'CONFLICT (content): Merge conflict in', path
 
-            if cleanCache:
+            if cacheOnly:
                 updateFile(False, sha, mode, path)
             else:
-                updateFile(True, aSha, aMode, path)
-                updateFile(False, sha, mode, path, True)
-        else:
-            updateFile(True, sha, mode, path)
-
-        os.unlink(orig)
-        os.unlink(src1)
-        os.unlink(src2)
+                updateFileExt(aSha, aMode, path,
+                              updateCache=True, updateWd=False)
+                updateFileExt(sha, mode, path, updateCache=False, updateWd=True)
     else:
         die("ERROR: Fatal merge failure, shouldn't happen.")
 
@@ -416,7 +832,7 @@ for nextArg in xrange(1, len(sys.argv)):
         try:
             h1 = firstBranch = sys.argv[nextArg + 1]
             h2 = secondBranch = sys.argv[nextArg + 2]
-	except IndexError:
+        except IndexError:
             usage()
         break
 
@@ -428,8 +844,8 @@ try:
 
     graph = buildGraph([h1, h2])
 
-    [res, clean] = merge(graph.shaMap[h1], graph.shaMap[h2],
-                         firstBranch, secondBranch, graph)
+    [dummy, clean] = merge(graph.shaMap[h1], graph.shaMap[h2],
+                           firstBranch, secondBranch, graph)
 
     print ''
 except:
