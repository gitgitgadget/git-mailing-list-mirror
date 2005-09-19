From: Fredrik Kuivinen <freku045@student.liu.se>
Subject: Re: Yet another set of merge test cases from the kernel tree.
Date: Mon, 19 Sep 2005 18:13:12 +0200
Message-ID: <20050919161312.GB1782@c165.ib.student.liu.se>
References: <20050907164734.GA20198@c165.ib.student.liu.se> <20050907165012.GA20392@c165.ib.student.liu.se> <7vzmqk2u1w.fsf_-_@assigned-by-dhcp.cox.net> <7vpsrcqjj6.fsf_-_@assigned-by-dhcp.cox.net> <7vvf13b1hi.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Fredrik Kuivinen <freku045@student.liu.se>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 19 18:15:21 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EHOGm-0004VI-6h
	for gcvg-git@gmane.org; Mon, 19 Sep 2005 18:13:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932485AbVISQNY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Sep 2005 12:13:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932486AbVISQNY
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Sep 2005 12:13:24 -0400
Received: from [85.8.31.11] ([85.8.31.11]:39583 "EHLO mail6.wasadata.com")
	by vger.kernel.org with ESMTP id S932485AbVISQNY (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 19 Sep 2005 12:13:24 -0400
Received: from c165 (unknown [85.8.2.189])
	by mail6.wasadata.com (Postfix) with ESMTP
	id CF1D64103; Mon, 19 Sep 2005 18:18:37 +0200 (CEST)
Received: from ksorim by c165 with local (Exim 3.36 #1 (Debian))
	id 1EHOGW-0001b1-00; Mon, 19 Sep 2005 18:13:12 +0200
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vvf13b1hi.fsf_-_@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.6+20040907i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8879>

On Wed, Sep 14, 2005 at 05:47:53PM -0700, Junio C Hamano wrote:
> I've tried to reproduce 400+ merges I picked up from various
> kernel trees that have more than one merge base.
> 
> number of commits looked at      : 83292
> number of merge commits          : 11089
> commits with more than one base  :   426
> 
> Interestingly enough, some of them have timestamps in 2002 or
> 2003, and comparing what our merge strategies do with what
> actually got recorded is interesting.  I hope comparing what was
> recorded by the SCM used back then and what we would produce
> today given the same input does not violate any license
> agreements somebody might have ;-).
> 
> I've taken a look at only handful of results, but I can already
> see some patterns:
> 
>  - Overall we seem to do reasonably well -- IOW many merges are
>    trivial even to 'stupid' strategy;
> 
>  - In some cases, all strategies do quite poorly.  For example:
> 
>    091cced38d83732ee3212806ef5ea07abbef01fe
>    44583d380d189095fa959ec8ba87f0cb6deb15f5

091c... seems to be a bit complicated. I have tried to understand what
the correct result should be, but I haven't managed to do that yet.

4458... is kind of interesting as it has no less than six common
ancestors.


> 
>  - There are quite a few case #16 (45 out of 426).  While
>    'stupid' strategy fails to merge many of them, there are
>    plenty of cases that it trivially resolves to what the SCM
>    used back then did.  'resolve' being too cautious _might_
>    irritate some users in these cases, but personally I feel
>    that being safer is better than letting ambiguities go
>    unnoticed.  It _might_ indicate that the SCM used back then
>    made the same mistake as our 'stupid' strategy does today
>    ;-).  A couple of examples:
> 
>    39284791a2ca8cb32b5597bf9ccf8e5c548e7aa7
>    662756c753b13231d437e4bc78032b5891c9d4ea
> 
>  - 'recursive' strategy seems to most often produce results that
>    match what the SCM used back then did, but it still gets some
>    cases different.  E.g.
> 
>    10f44c023ef22c8c125d5ef15bed560d46c66af9
>    2e7bdf93a8c4d7ecd54f1ceb19881faf0f6b14f3
>    46f58b7869ffd1f2009065ffa626db3b0498925a
>    5f4fbfe6d1986a99cb62f433346c92e57e7b9814
>    651a8cf62546f2425df09b1b4451fe317f84431d
>

The reason we get the wrong result for those is that they all involve
renames. I have an experimental patch at the end of this mail which
makes git-merge-recursive.py handle some rename cases. The support for
renames is currently interleaved with other unrelated changes and
this patch should not yet be considered for inclusion. With the rename
patch we get clean merges that matches the actual commit for all of
those except for 46f5.... git-merge-recursive.py do not merge
46f5... cleanly with the rename patch applied.

Peter's merge, reported in <4318E754.9000703@zytor.com>, is merged
cleanly if this patch is applied. (and I _think_ the result is
correct)

- Fredrik


---

 git-merge-recursive.py |  466 +++++++++++++++++++++++++++++++++++--------------
 1 files changed, 334 insertions(+), 132 deletions(-)

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
@@ -26,6 +23,13 @@ def setupIndex(temporary):
         newIndex = originalIndexFile
     os.environ['GIT_INDEX_FILE'] = newIndex
 
+def fmtP(path):
+    '''Format path for printing'''
+    return '"' + path + '"'
+
+# The entry point to the merge code
+# ---------------------------------
+
 def merge(h1, h2, branch1Name, branch2Name, graph, callDepth=0):
     '''Merge the commits h1 and h2, return the resulting virtual
     commit object and a flag indicating the cleaness of the merge.'''
@@ -74,7 +78,7 @@ def merge(h1, h2, branch1Name, branch2Na
 
     return [res, clean]
 
-getFilesRE = re.compile(r'^([0-7]+) (\S+) ([0-9a-f]{40})\t(.*)$', re.S)
+getFilesRE = re.compile('([0-9]+) ([a-z0-9]+) ([0-9a-f]{40})\t(.*)')
 def getFilesAndDirs(tree):
     files = Set()
     dirs = Set()
@@ -89,6 +93,149 @@ def getFilesAndDirs(tree):
 
     return [files, dirs]
 
+def mergeTrees(head, merge, common, branch1Name, branch2Name,
+               cleanCache):
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
+    if cleanCache:
+        updateArg = '-i'
+    else:
+        updateArg = '-u'
+
+    runProgram(['git-read-tree', updateArg, '-m', common, head, merge])
+    cleanMerge = True
+
+    [tree, code] = runProgram('git-write-tree', returnCode=True)
+    tree = tree.rstrip()
+    if code != 0:
+        [files, dirs] = getFilesAndDirs(head)
+        [filesM, dirsM] = getFilesAndDirs(merge)
+        files.union_update(filesM)
+        dirs.union_update(dirsM)
+        
+        renamesHead = getRenames(common, head)
+        renamesMerge = getRenames(common, merge)
+
+        entries = unmergedCacheEntries()
+        cleanMerge = processRenames(entries, renamesHead, renamesMerge,
+                                    branch1Name, branch2Name, cleanCache)
+        for entry in entries.itervalues():
+            if entry.processed:
+                continue
+            if not processEntry(entry, branch1Name, branch2Name,
+                                files, dirs, cleanCache):
+                cleanMerge = False
+                
+        if cleanMerge or cleanCache:
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
+MERGE_NOCHANGES = 0
+MERGE_SIMPLE = 1
+MERGE_3WAY = 2
+def mergeFile(path, oSha, oMode, aSha, aMode, bSha, bMode,
+              branch1Name, branch2Name):
+
+    merge = MERGE_NOCHANGES
+    clean = True
+
+    if aSha != oSha or bSha != oSha:
+        merge = MERGE_SIMPLE
+
+    if aSha == oSha:
+        sha = bSha
+    elif bSha == oSha:
+        sha = aSha
+    else:
+        merge = MERGE_3WAY
+        orig = runProgram(['git-unpack-file', oSha]).rstrip()
+        src1 = runProgram(['git-unpack-file', aSha]).rstrip()
+        src2 = runProgram(['git-unpack-file', bSha]).rstrip()
+        [out, code] = runProgram(['merge',
+                                  '-L', branch1Name + '/' + path,
+                                  '-L', 'orig/' + path,
+                                  '-L', branch2Name + '/' + path,
+                                  src1, orig, src2], returnCode=True)
+
+        sha = runProgram(['git-hash-object', '-t', 'blob', '-w',
+                          src1]).rstrip()
+
+        os.unlink(orig)
+        os.unlink(src1)
+        os.unlink(src2)
+
+        clean = (code == 0)
+
+    if aMode == oMode:
+        mode = bMode
+    else:
+        mode = aMode
+
+    return [sha, mode, clean, merge]
+
+def updateFile(clean, sha, mode, path, cleanCache, onlyWd=False):
+    updateCache = not onlyWd and (cleanCache or (not cleanCache and clean))
+    updateWd = onlyWd or (not cleanCache and clean)
+
+    if updateWd:
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
+def removeFile(clean, path, cleanCache):
+    if cleanCache or (not cleanCache and clean):
+        runProgram(['git-update-index', '--force-remove', '--', path])
+
+    if not cleanCache and clean:
+        try:
+            os.unlink(path)
+        except OSError, e:
+            if e.errno != errno.ENOENT and e.errno != errno.EISDIR:
+                raise
+
+# Cache entry management
+# ----------------------
+
 class CacheEntry:
     def __init__(self, path):
         class Stage:
@@ -98,8 +245,15 @@ class CacheEntry:
         
         self.stages = [Stage(), Stage(), Stage()]
         self.path = path
+        self.processed = False
 
-unmergedRE = re.compile(r'^([0-7]+) ([0-9a-f]{40}) ([1-3])\t(.*)$', re.S)
+def getCacheEntry(entries, path):
+    for e in entries.itervalues():
+        if e.path == path:
+            return e
+    return None
+
+unmergedRE = re.compile('^([0-9]+) ([0-9a-f]{40}) ([1-3])\t(.*)$')
 def unmergedCacheEntries():
     '''Create a dictionary mapping file names to CacheEntry
     objects. The dictionary contains one entry for every path with a
@@ -130,52 +284,160 @@ def unmergedCacheEntries():
                 'git-ls-files:', l)
     return res
 
-def mergeTrees(head, merge, common, branch1Name, branch2Name,
-               cleanCache):
-    '''Merge the trees 'head' and 'merge' with the common ancestor
-    'common'. The name of the head branch is 'branch1Name' and the name of
-    the merge branch is 'branch2Name'. Return a tuple (tree, cleanMerge)
-    where tree is the resulting tree and cleanMerge is True iff the
-    merge was clean.'''
-    
-    assert(isSha(head) and isSha(merge) and isSha(common))
+# Rename detection and handling
+# -----------------------------
 
-    if common == merge:
-        print 'Already uptodate!'
-        return [head, True]
+class RenameEntry:
+    def __init__(self, src, srcSha, srcMode, dst, dstSha, dstMode, score):
+        self.srcName = src
+        self.srcSha = srcSha
+        self.srcMode = srcMode
+        self.dstName = dst
+        self.dstSha = dstSha
+        self.dstMode = dstMode
+        self.score = score
+
+class RenameInfo:
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
+parseDiffRenamesRE = re.compile(':([0-7]+) ([0-7]+) ([0-9a-f]{40}) ([0-9a-f]{40}) R([0-9]*)')
+def getRenames(treeOrig, tree):
+    inp = runProgram(['git-diff-tree', '-M', '--diff-filter=R', '-r', '-z', treeOrig, tree])
 
-    if cleanCache:
-        updateArg = '-i'
-    else:
-        updateArg = '-u'
+    ret = RenameInfo()
+    try:
+        recs = inp.split("\0")
+        recs.pop() # remove last entry (which is '')
+        it = recs.__iter__()
+        while True:
+            rec = it.next()
+            m = parseDiffRenamesRE.match(rec)
+            
+            if not m:
+                die('Unexpected output from git-diff-tree!:', rec)
+
+            srcMode = int(m.group(1), 8)
+            dstMode = int(m.group(2), 8)
+            srcSha = m.group(3)
+            dstSha = m.group(4)
+            score = m.group(5)
+            src = it.next()
+            dst = it.next()
+            ret.add(RenameEntry(src, srcSha, srcMode, dst, dstSha, dstMode, score))
+    except StopIteration:
+        pass
+    return ret
 
-    runProgram(['git-read-tree', updateArg, '-m', common, head, merge])
-    cleanMerge = True
+def processRenames(entries, renamesA, renamesB, branchNameA, branchNameB, cleanCache):
+    srcNames = Set()
+    for x in renamesA:
+        srcNames.add(x.srcName)
+    for x in renamesB:
+        srcNames.add(x.srcName)
 
-    [tree, code] = runProgram('git-write-tree', returnCode=True)
-    tree = tree.rstrip()
-    if code != 0:
-        [files, dirs] = getFilesAndDirs(head)
-        [filesM, dirsM] = getFilesAndDirs(merge)
-        files.union_update(filesM)
-        dirs.union_update(dirsM)
+    cleanMerge = True
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
+        e = getCacheEntry(entries, ren1.dstName)
+        if e:
+            e.processed = True
+        e = getCacheEntry(entries, ren1.srcName)
+        if e:
+            e.processed = True
+        removeFile(True, ren1.srcName, cleanCache)
+        if ren2:
+            assert(ren1.srcName == ren2.srcName)
+            e = getCacheEntry(entries, ren2.dstName)
+            if e:
+                e.processed = True
+            if ren1.dstName != ren2.dstName:
+                print 'CONFLICT (ren/ren):', fmtP(path), 'renamed to', \
+                      fmtP(ren1.dstName), 'in branch', branchName1, 'and to', fmtP(ren2.dstName), \
+                      'in', branchName2
                 cleanMerge = False
-                
-        if cleanMerge or cleanCache:
-            tree = runProgram('git-write-tree').rstrip()
+                updateFile(False, ren1.dstSha, ren1.dstMode, ren1.dstName, cleanCache)
+                updateFile(False, ren2.dstSha, ren2.dstMode, ren2.dstName, cleanCache)
+            else:
+                print fmtP(path), 'renamed to', fmtP(ren1.dstName), 'in both branches'
+                [resSha, resMode, clean, merge] = \
+                         mergeFile(ren1.srcName,
+                                   ren1.srcSha, ren1.srcMode,
+                                   ren1.dstSha, ren1.dstMode,
+                                   ren2.dstSha, ren2.dstMode,
+                                   branchName1, branchName2)
+
+                if merge:
+                    print 'Auto-merging', fmtP(ren1.dstName)
+
+                if not clean:
+                    print 'CONFLICT (mod/mod): merge conflict in', fmtP(ren1.dstName)
+                updateFile(clean, resSha, resMode, ren1.dstName, cleanCache)
+                    
+        # Renamed in 1, maybe changed in 2
         else:
-            tree = None
-    else:
-        cleanMerge = True
+            # FIXME ar det verkligen sakert att ren1.srcName finns i cachen som unmerged?
+            e = getCacheEntry(entries, ren1.srcName)
+            if renamesA == renames1:
+                sha = e.stages[2].sha1
+                mode = e.stages[2].mode
+            else:
+                sha = e.stages[1].sha1
+                mode = e.stages[1].mode
 
-    return [tree, cleanMerge]
+            [resSha, resMode, clean, merge] = \
+                     mergeFile(ren1.srcName,
+                               ren1.srcSha, ren1.srcMode,
+                               ren1.dstSha, ren1.dstMode,
+                               sha, mode, branchName1, branchName2)
+
+            if merge:
+                print fmtP(ren1.srcName), 'renamed to', fmtP(ren1.dstName), 'in', \
+                      branchName1, 'and modified in', branchName2 + ', auto-merging'
+
+                if not clean:
+                    print 'CONFLICT (ren/mod):', fmtP(ren1.srcName), 'renamed to ', \
+                          fmtP(ren1.dstName), 'in branch', branchName1, 'and modified in', \
+                          'branch', branchName2, 'merge conflict in', fmtP(ren1.dstName)
+                    cleanMerge = False
+            else:
+                print fmtP(ren1.srcName), 'renamed to', fmtP(ren1.dstName), 'in', \
+                      branchName1
 
+            e.processed = True
+            updateFile(clean, resSha, resMode, ren1.dstName, cleanCache)
+    return cleanMerge
+
+# Per entry merge function
+# ------------------------
+ 
 def processEntry(entry, branch1Name, branch2Name, files, dirs, cleanCache):
     '''Merge one cache entry. 'files' is a Set with the files in both of
     the heads that we are going to merge. 'dirs' contains the
@@ -192,48 +454,6 @@ def processEntry(entry, branch1Name, bra
 
 # If cleanCache == False then the cache shouldn't be updated if clean == False
 
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
-                else:
-                    mode = 0666
-                fd = os.open(path, os.O_WRONLY | os.O_TRUNC | os.O_CREAT, mode)
-                proc = subprocess.Popen(prog, stdout=fd)
-                proc.wait()
-                os.close(fd)
-            elif stat.S_ISLNK(mode):
-                linkTarget = runProgram(prog)
-                os.symlink(linkTarget, path)
-            else:
-                assert(False)
-
-        if updateWd and updateCache:
-            runProgram(['git-update-index', '--add', '--', path])
-        elif updateCache:
-            runProgram(['git-update-index', '--add', '--cacheinfo',
-                        '0%o' % mode, sha, path])
-
-    def removeFile(clean, path):
-        if cleanCache or (not cleanCache and clean):
-            runProgram(['git-update-index', '--force-remove', '--', path])
-
-        if not cleanCache and clean:
-            try:
-                os.unlink(path)
-            except OSError, e:
-                if e.errno != errno.ENOENT and e.errno != errno.EISDIR:
-                    raise
-
     def uniquePath(path, branch):
         newPath = path + '_' + branch
         suffix = 0
@@ -273,26 +493,26 @@ def processEntry(entry, branch1Name, bra
     # Deleted in both or deleted in one and unchanged in the other
             if aSha:
                 print 'Removing ' + path
-            removeFile(True, path)
+            removeFile(True, path, cleanCache)
         else:
     # Deleted in one and changed in the other
             cleanMerge = False
             if not aSha:
-                print 'CONFLICT (del/mod): "' + path + '" deleted in', \
+                print 'CONFLICT (del/mod):', fmtP(path), ' deleted in', \
                       branch1Name, 'and modified in', branch2Name, \
-                      '. Version', branch2Name, ' of "' + path + \
-                      '" left in tree'
+                      '. Version', branch2Name, 'of', fmtP(path), \
+                      'left in tree'
                 mode = bMode
                 sha = bSha
             else:
-                print 'CONFLICT (mod/del): "' + path + '" deleted in', \
+                print 'CONFLICT (mod/del):', fmtP(path), 'deleted in', \
                       branch2Name, 'and modified in', branch1Name + \
-                      '. Version', branch1Name, 'of "' + path + \
-                      '" left in tree'
+                      '. Version', branch1Name, 'of', path, \
+                      'left in tree'
                 mode = aMode
                 sha = aSha
 
-            updateFile(False, sha, mode, path)
+            updateFile(False, sha, mode, path, cleanCache)
     
     elif (not oSha and aSha     and not bSha) or \
          (not oSha and not aSha and bSha):
@@ -316,15 +536,15 @@ def processEntry(entry, branch1Name, bra
             cleanMerge = False
             newPath = uniquePath(path, addBranch)
             print 'CONFLICT (' + conf + \
-                  '): There is a directory with name "' + path + '" in', \
-                  otherBranch + '. Adding "' + path + '" as "' + newPath + '"'
+                  '): There is a directory with name', path, 'in', \
+                  otherBranch + '. Adding', fmtP(path), 'as', fmtP(newPath)
 
-            removeFile(False, path)
+            removeFile(False, path, cleanCache)
             path = newPath
         else:
-            print 'Adding "' + path + '"'
+            print 'Adding', fmtP(path)
 
-        updateFile(True, sha, mode, path)
+        updateFile(True, sha, mode, path, cleanCache)
     
     elif not oSha and aSha and bSha:
     #
@@ -333,13 +553,13 @@ def processEntry(entry, branch1Name, bra
         if aSha == bSha:
             if aMode != bMode:
                 cleanMerge = False
-                print 'CONFLICT: File "' + path + \
-                      '" added identically in both branches,', \
+                print 'CONFLICT: File', fmtP(path), \
+                      'added identically in both branches,', \
                       'but permissions conflict', '0%o' % aMode, '->', \
                       '0%o' % bMode
                 print 'CONFLICT: adding with permission:', '0%o' % aMode
 
-                updateFile(False, aSha, aMode, path)
+                updateFile(False, aSha, aMode, path, cleanCache)
             else:
                 # This case is handled by git-read-tree
                 assert(False)
@@ -347,49 +567,31 @@ def processEntry(entry, branch1Name, bra
             cleanMerge = False
             newPath1 = uniquePath(path, branch1Name)
             newPath2 = uniquePath(path, branch2Name)
-            print 'CONFLICT (add/add): File "' + path + \
-                  '" added non-identically in both branches.'
-            removeFile(False, path)
-            updateFile(False, aSha, aMode, newPath1)
-            updateFile(False, bSha, bMode, newPath2)
+            print 'CONFLICT (add/add): File', fmtP(path), \
+                  'added non-identically in both branches.'
+            removeFile(False, path, cleanCache)
+            updateFile(False, aSha, aMode, newPath1, cleanCache)
+            updateFile(False, bSha, bMode, newPath2, cleanCache)
 
     elif oSha and aSha and bSha:
     #
     # case D: Modified in both, but differently.
     #
         print 'Auto-merging', path 
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
+        [sha, mode, clean, merge] = \
+              mergeFile(path, oSha, oMode, aSha, aMode, bSha, bMode,
+                        branch1Name, branch2Name)
+        if clean:
+            updateFile(True, sha, mode, path, cleanCache)
         else:
-            mode = aMode
-
-        sha = runProgram(['git-hash-object', '-t', 'blob', '-w',
-                          src1]).rstrip()
-
-        if ret != 0:
             cleanMerge = False
-            print 'CONFLICT (content): Merge conflict in "' + path + '".'
+            print 'CONFLICT (content): Merge conflict in', fmtP(path)
 
             if cleanCache:
-                updateFile(False, sha, mode, path)
+                updateFile(False, sha, mode, path, cleanCache)
             else:
-                updateFile(True, aSha, aMode, path)
-                updateFile(False, sha, mode, path, True)
-        else:
-            updateFile(True, sha, mode, path)
-
-        os.unlink(orig)
-        os.unlink(src1)
-        os.unlink(src2)
+                updateFile(True, aSha, aMode, path, cleanCache)
+                updateFile(False, sha, mode, path, cleanCache, True)
     else:
         die("ERROR: Fatal merge failure, shouldn't happen.")
 
