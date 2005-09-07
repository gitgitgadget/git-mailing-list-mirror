From: Fredrik Kuivinen <freku045@student.liu.se>
Subject: [PATCH 2/2] A new merge algorithm
Date: Wed, 7 Sep 2005 18:51:41 +0200
Message-ID: <20050907165141.GB20392@c165.ib.student.liu.se>
References: <20050907164734.GA20198@c165.ib.student.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: junkio@cox.net
X-From: git-owner@vger.kernel.org Wed Sep 07 18:54:40 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ED39G-0001Kf-Ts
	for gcvg-git@gmane.org; Wed, 07 Sep 2005 18:51:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932181AbVIGQvo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 7 Sep 2005 12:51:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932182AbVIGQvo
	(ORCPT <rfc822;git-outgoing>); Wed, 7 Sep 2005 12:51:44 -0400
Received: from [85.8.31.11] ([85.8.31.11]:31455 "EHLO mail6.wasadata.com")
	by vger.kernel.org with ESMTP id S932181AbVIGQvn (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 7 Sep 2005 12:51:43 -0400
Received: from c165 (unknown [85.8.2.189])
	by mail6.wasadata.com (Postfix) with ESMTP
	id C47E240FF; Wed,  7 Sep 2005 18:56:24 +0200 (CEST)
Received: from ksorim by c165 with local (Exim 3.36 #1 (Debian))
	id 1ED39B-0005KG-00; Wed, 07 Sep 2005 18:51:41 +0200
To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20050907164734.GA20198@c165.ib.student.liu.se>
User-Agent: Mutt/1.5.6+20040907i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8171>

The new algorithm handles multiple common ancestors in a better way.

Signed-off-by: Fredrik Kuivinen <freku@ida.liu.se>


---

 Makefile          |    3 
 git-merge-script  |  491 +++++++++++++++++++++++++++++++++++++++++++++++++++++
 gitMergeCommon.py |  286 +++++++++++++++++++++++++++++++
 3 files changed, 779 insertions(+), 1 deletions(-)
 create mode 100644 git-merge-script
 create mode 100644 gitMergeCommon.py

4c86af6fac9d0f527c277c88d7ae3d200dd24f61
diff --git a/Makefile b/Makefile
--- a/Makefile
+++ b/Makefile
@@ -66,7 +66,8 @@ SCRIPTS=git git-merge-one-file-script gi
 	git-format-patch-script git-sh-setup-script git-push-script \
 	git-branch-script git-parse-remote-script git-verify-tag-script \
 	git-ls-remote-script git-rename-script \
-	git-request-pull-script git-bisect-script
+	git-request-pull-script git-bisect-script gitMergeCommon.py \
+	git-merge-script
 
 SCRIPTS += git-count-objects-script
 SCRIPTS += git-revert-script
diff --git a/git-merge-script b/git-merge-script
new file mode 100755
--- /dev/null
+++ b/git-merge-script
@@ -0,0 +1,491 @@
+#!/usr/bin/env python
+
+import sys, math, random, os, re, signal, tempfile, stat, errno
+from heapq import heappush, heappop
+from sets import Set
+from gitMergeCommon import *
+
+alwaysWriteTree = False
+
+# The actual merge code
+# ---------------------
+
+def merge(h1, h2, branch1Name, branch2Name, graph, callDepth=0):
+    '''Merge the commits h1 and h2, return the resulting virtual
+    commit object and a flag indicating the cleaness of the merge.'''
+    assert(isinstance(h1, Commit) and isinstance(h2, Commit))
+    assert(isinstance(graph, Graph))
+
+    def infoMsg(*args):
+        sys.stdout.write('  '*callDepth)
+        printList(args)
+    infoMsg('Merging:')
+    infoMsg(h1)
+    infoMsg(h2)
+    sys.stdout.flush()
+
+    ca = getCommonAncestors(graph, h1, h2)
+    infoMsg('found', len(ca), 'common ancestor(s):')
+    for x in ca:
+        infoMsg(x)
+    sys.stdout.flush()
+
+    Ms = ca[0]
+    for h in ca[1:]:
+        [Ms, ignore] = merge(Ms, h,
+                             'Temporary shared merge branch 1',
+                             'Temporary shared merge branch 2',
+                             graph, callDepth+1)
+        assert(isinstance(Ms, Commit))
+
+    if callDepth == 0:
+        if len(ca) > 1:
+            runProgram(['git-read-tree', h1.tree()])
+            runProgram(['git-update-cache', '-q', '--refresh'])
+        # Use the original index if we only have one common ancestor
+        
+        updateWd = True
+        if alwaysWriteTree:
+            cleanCache = True
+        else:
+            cleanCache = False
+    else:
+        runProgram(['git-read-tree', h1.tree()])
+        updateWd = False
+        cleanCache = True
+
+    [shaRes, clean] = mergeTrees(h1.tree(), h2.tree(), Ms.tree(),
+                                 branch1Name, branch2Name,
+                                 cleanCache, updateWd)
+
+    if clean or alwaysWriteTree:
+        res = Commit(None, [h1, h2], tree=shaRes)
+        graph.addNode(res)
+    else:
+        res = None
+
+    return [res, clean]
+
+getFilesRE = re.compile('([0-9]+) ([a-z0-9]+) ([0-9a-f]{40})\t(.*)')
+def getFilesAndDirs(tree):
+    files = Set()
+    dirs = Set()
+    out = runProgram(['git-ls-tree', '-r', '-z', tree])
+    for l in out.split('\0'):
+        m = getFilesRE.match(l)
+        if m:
+            if m.group(2) == 'tree':
+                dirs.add(m.group(4))
+            elif m.group(2) == 'blob':
+                files.add(m.group(4))
+
+    return [files, dirs]
+
+class CacheEntry:
+    def __init__(self, path):
+        class Stage:
+            def __init__(self):
+                self.sha1 = None
+                self.mode = None
+        
+        self.stages = [Stage(), Stage(), Stage()]
+        self.path = path
+
+unmergedRE = re.compile('^([0-9]+) ([0-9a-f]{40}) ([1-3])\t(.*)$')
+def unmergedCacheEntries():
+    '''Create a dictionary mapping file names to CacheEntry
+    objects. The dictionary contains one entry for every path with a
+    non-zero stage entry.'''
+
+    lines = runProgram(['git-ls-files', '-z', '--unmerged']).split('\0')
+    lines.pop()
+
+    res = {}
+    for l in lines:
+        m = unmergedRE.match(l)
+        if m:
+            mode = int(m.group(1), 8)
+            sha1 = m.group(2)
+            stage = int(m.group(3)) - 1
+            path = m.group(4)
+
+            if res.has_key(path):
+                e = res[path]
+            else:
+                e = CacheEntry(path)
+                res[path] = e
+                
+            e.stages[stage].mode = mode
+            e.stages[stage].sha1 = sha1
+        else:
+            print 'Error: Merge program failed: Unexpected output from', \
+                  'git-ls-files:', l
+            sys.exit(1)
+    return res
+
+def mergeTrees(head, merge, common, branch1Name, branch2Name,
+               cleanCache, updateWd):
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
+    if updateWd:
+        updateArg = '-u'
+    else:
+        updateArg = '-i'
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
+        cleanMerge = True
+        entries = unmergedCacheEntries()
+        for name in entries:
+            if not processEntry(entries[name], branch1Name, branch2Name,
+                                files, dirs, cleanCache, updateWd):
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
+def processEntry(entry, branch1Name, branch2Name, files, dirs,
+                 cleanCache, updateWd):
+    '''Merge one cache entry. 'files' is a Set with the files in both of
+    the heads that we are going to merge. 'dirs' contains the
+    corresponding data for directories. If 'cleanCache' is True no
+    non-zero stages will be left in the cache for the path
+    corresponding to the entry 'entry'.'''
+
+# cleanCache == True  => Don't leave any non-stage 0 entries in the cache.
+#               False => Leave unmerged entries
+
+# updateWd  == True  => Update the working directory to correspond to the cache
+#              False => Leave the working directory unchanged
+
+# clean     == True  => non-conflict case
+#              False => conflict case
+
+# If cleanCache == False then the cache shouldn't be updated if clean == False
+
+    def updateFile(clean, sha, mode, path):
+        if cleanCache or (not cleanCache and clean):
+            runProgram(['git-update-cache', '--add', '--cacheinfo',
+                        '0%o' % mode, sha, path])
+
+        if updateWd:
+            prog = ['git-cat-file', 'blob', sha]
+            if stat.S_ISREG(mode):
+                try:
+                    os.unlink(path)
+                except OSError:
+                    pass
+                if mode & 0100:
+                    mode = 0777
+                else:
+                    mode = 0666
+                fd = os.open(path, os.O_WRONLY | os.O_TRUNC | os.O_CREAT, mode)
+                proc = subprocess.Popen(prog, stdout=fd)
+                proc.wait()
+                os.close(fd)
+            elif stat.S_ISLNK(mode):
+                linkTarget = runProgram(prog)
+                os.symlink(linkTarget, path)
+            else:
+                assert(False)
+            runProgram(['git-update-cache', '--', path])
+
+    def removeFile(clean, path):
+        if cleanCache or (not cleanCache and clean):
+            runProgram(['git-update-cache', '--force-remove', '--', path])
+
+        if updateWd:
+            try:
+                os.unlink(path)
+            except OSError, e:
+                if e.errno != errno.ENOENT and e.errno != errno.EISDIR:
+                    raise
+
+    def uniquePath(path, branch):
+        newPath = path + '_' + branch
+        suffix = 0
+        while newPath in files or newPath in dirs:
+            suffix += 1
+            newPath = path + '_' + branch + '_' + str(suffix)
+        files.add(newPath)
+        return newPath
+
+    debug('processing', entry.path, 'clean cache:', cleanCache,
+          'wd:', updateWd)
+
+    cleanMerge = True
+
+    path = entry.path
+    oSha = entry.stages[0].sha1
+    oMode = entry.stages[0].mode
+    aSha = entry.stages[1].sha1
+    aMode = entry.stages[1].mode
+    bSha = entry.stages[2].sha1
+    bMode = entry.stages[2].mode
+
+    assert(oSha == None or isSha(oSha))
+    assert(aSha == None or isSha(aSha))
+    assert(bSha == None or isSha(bSha))
+
+    assert(oMode == None or type(oMode) is int)
+    assert(aMode == None or type(aMode) is int)
+    assert(bMode == None or type(bMode) is int)
+
+    if (oSha and (not aSha or not bSha)):
+    #
+    # Case A: Deleted in one
+    #
+        if (not aSha     and not bSha) or \
+           (aSha == oSha and not bSha) or \
+           (not aSha     and bSha == oSha):
+    # Deleted in both or deleted in one and unchanged in the other
+            if aSha:
+                print 'Removing ' + path
+            removeFile(True, path)
+        else:
+    # Deleted in one and changed in the other
+            cleanMerge = False
+            if not aSha:
+                print 'CONFLICT (del/mod): "' + path + '" deleted in', \
+                      branch1Name, 'and modified in', branch2Name, \
+                      '. Version', branch2Name, ' of "' + path + \
+                      '" left in tree'
+                mode = bMode
+                sha = bSha
+            else:
+                print 'CONFLICT (mod/del): "' + path + '" deleted in', \
+                      branch2Name, 'and modified in', branch1Name + \
+                      '. Version', branch1Name, 'of "' + path + \
+                      '" left in tree'
+                mode = aMode
+                sha = aSha
+
+            updateFile(False, sha, mode, path)
+    
+    elif (not oSha and aSha     and not bSha) or \
+         (not oSha and not aSha and bSha):
+    #
+    # Case B: Added in one.
+    #
+        if aSha:
+            addBranch = branch1Name
+            otherBranch = branch2Name
+            mode = aMode
+            sha = aSha
+            conf = 'file/dir'
+        else:
+            addBranch = branch2Name
+            otherBranch = branch1Name
+            mode = bMode
+            sha = bSha
+            conf = 'dir/file'
+    
+        if path in dirs:
+            cleanMerge = False
+            newPath = uniquePath(path, addBranch)
+            print 'CONFLICT (' + conf + \
+                  '): There is a directory with name "' + path + '" in', \
+                  otherBranch + '. Adding "' + path + '" as "' + newPath + '"'
+
+            removeFile(False, path)
+            path = newPath
+        else:
+            print 'Adding "' + path + '"'
+
+        updateFile(True, sha, mode, path)
+    
+    elif not oSha and aSha and bSha:
+    #
+    # Case C: Added in both (check for same permissions).
+    #
+        if aSha == bSha:
+            if aMode != bMode:
+                cleanMerge = False
+                print 'CONFLICT: File "' + path + \
+                      '" added identically in both branches,'
+                print 'CONFLICT: but permissions conflict', '0%o' % aMode, \
+                      '->', '0%o' % bMode
+                print 'CONFLICT: adding with permission:', '0%o' % aMode
+
+                updateFile(False, aSha, aMode, path)
+            else:
+                # This case is handled by git-read-tree
+                assert(False)
+        else:
+            cleanMerge = False
+            newPath1 = uniquePath(path, branch1Name)
+            newPath2 = uniquePath(path, branch2Name)
+            print 'CONFLICT (add/add): File "' + path + \
+                  '" added non-identically in both branches.', \
+                  'Adding "' + newPath1 + '" and "' + newPath2 + '" instead.'
+            removeFile(False, path)
+            updateFile(False, aSha, aMode, newPath1)
+            updateFile(False, bSha, bMode, newPath2)
+
+    elif oSha and aSha and bSha:
+    #
+    # case D: Modified in both, but differently.
+    #
+        print 'Auto-merging', path 
+        orig = runProgram(['git-unpack-file', oSha]).rstrip()
+        src1 = runProgram(['git-unpack-file', aSha]).rstrip()
+        src2 = runProgram(['git-unpack-file', bSha]).rstrip()
+        [out, ret] = runProgram(['merge',
+                                 '-L', branch1Name + '/' + path,
+                                 '-L', 'orig/' + path,
+                                 '-L', branch2Name + '/' + path,
+                                 src1, orig, src2], returnCode=True)
+
+        if aMode == oMode:
+            mode = bMode
+        else:
+            mode = aMode
+
+        sha = runProgram(['git-hash-object', '-t', 'blob', '-w',
+                          src1]).rstrip()
+
+        if ret != 0:
+            cleanMerge = False
+            print 'CONFLICT (content): Merge conflict in "' + path + '".'
+            updateFile(False, sha, mode, path)
+        else:
+            updateFile(True, sha, mode, path)
+
+        os.unlink(orig)
+        os.unlink(src1)
+        os.unlink(src2)
+    else:
+        print 'ERROR: Fatal merge failure.'
+        print "ERROR: Shouldn't happen"
+        sys.exit(1)
+
+    return cleanMerge
+
+def dropHeads():
+    try:
+        os.unlink(os.environ['GIT_DIR'] + '/MERGE_HEAD')
+    except OSError:
+        pass
+
+    try:
+        os.unlink(os.environ['GIT_DIR'] + '/LAST_MERGE')
+    except OSError:
+        pass
+
+def writeHead(head, sha):
+    if sha[-1] != '\n':
+        sha += '\n'
+
+    try:
+        f = open(os.environ['GIT_DIR'] + '/' + head, 'w')
+        f.write(sha)
+        f.close()
+    except IOError, e:
+        print 'Failed to write to', os.environ['GIT_DIR'] + '/' + head + ':', \
+              e.strerror
+        sys.exit(1)
+    return True
+
+def checkCleanTree():
+    [ignore, code] = runProgram(['git-update-cache', '--refresh'],
+                                returnCode = True)
+    if code != 0:
+        return False
+    out = runProgram(['git-diff-cache', '--name-only', '--cached', 'HEAD'])
+    if len(out) > 0:
+        return False
+    return True
+
+def doCommit(msg, p1, p2, tree):
+    assert(isSha(tree))
+    commit = runProgram(['git-commit-tree', tree, '-p', p1, '-p', p2],
+                        msg + '\n').rstrip()
+    assert(isSha(commit))
+    writeHead('HEAD', commit)
+    return commit.rstrip()
+
+def usage():
+    print 'Usage:', sys.argv[0], ' <head> <remote> <merge-message>'
+    sys.exit(1)
+
+if not checkCleanTree():
+    print 'Either the cache is out of sync or the working tree does not match HEAD.'
+    print 'Aborting merge.'
+    sys.exit(1)
+
+setupEnvironment()
+repoValid()
+
+try:
+    nextArg = 1
+    if sys.argv[nextArg] == '--write-tree':
+        alwaysWriteTree = True
+        nextArg += 1
+    else:
+        alwaysWriteTree = False
+
+    h1 = firstBranch = sys.argv[nextArg]
+    nextArg += 1
+    h2 = secondBranch = sys.argv[nextArg]
+    nextArg += 1
+    commitMessage = sys.argv[nextArg]
+    nextArg += 1
+except IndexError:
+    usage()
+    
+if len(sys.argv) != nextArg:
+    usage()
+
+print 'Merging', h1, 'with', h2
+h1 = runProgram(['git-rev-parse', '--verify', h1 + '^0']).rstrip()
+h2 = runProgram(['git-rev-parse', '--verify', h2 + '^0']).rstrip()
+
+writeHead('ORIG_HEAD', h1)
+writeHead('LAST_MERGE', h2)
+
+graph = buildGraph([h1, h2])
+
+[res, clean] = merge(graph.shaMap[h1], graph.shaMap[h2],
+                     firstBranch, secondBranch, graph)
+
+print ''
+
+if clean:
+    cmit = doCommit(commitMessage, h1, h2, res.tree())
+    print 'Committed merge', cmit
+    print runProgram('git-diff-tree -p ORIG_HEAD ' + cmit + \
+                     ' | git-apply --stat')
+    dropHeads()
+else:
+    print 'Automatic merge failed, fix up by hand'
+    writeHead('MERGE_HEAD', h2)
+
+if alwaysWriteTree:
+    print res.tree()
+
+if not clean:
+    sys.exit(1)
diff --git a/gitMergeCommon.py b/gitMergeCommon.py
new file mode 100644
--- /dev/null
+++ b/gitMergeCommon.py
@@ -0,0 +1,286 @@
+import sys, re, os, traceback
+from sets import Set
+
+if sys.version_info[0] < 2 or \
+       (sys.version_info[0] == 2 and sys.version_info[1] < 4):
+    print 'Python version 2.4 required, found', \
+          str(sys.version_info[0])+'.'+str(sys.version_info[1])+'.'+ \
+          str(sys.version_info[2])
+    sys.exit(1)
+
+import subprocess
+
+# Debugging machinery
+# -------------------
+
+DEBUG = 0
+functionsToDebug = Set()
+
+def addDebug(func):
+    if type(func) == str:
+        functionsToDebug.add(func)
+    else:
+        functionsToDebug.add(func.func_name)
+
+def debug(*args):
+    if DEBUG:
+        funcName = traceback.extract_stack()[-2][2]
+        if funcName in functionsToDebug:
+            printList(args)
+
+def printList(list):
+    for x in list:
+        sys.stdout.write(str(x))
+        sys.stdout.write(' ')
+    sys.stdout.write('\n')
+
+# Program execution
+# -----------------
+
+class ProgramError(Exception):
+    def __init__(self, progStr, error):
+        self.progStr = progStr
+        self.error = error
+
+addDebug('runProgram')
+def runProgram(prog, input=None, returnCode=False, env=None, pipeOutput=True):
+    debug('runProgram prog:', str(prog), 'input:', str(input))
+    if type(prog) is str:
+        progStr = prog
+    else:
+        progStr = ' '.join(prog)
+    
+    try:
+        if pipeOutput:
+            stderr = subprocess.STDOUT
+            stdout = subprocess.PIPE
+        else:
+            stderr = None
+            stdout = None
+        pop = subprocess.Popen(prog,
+                               shell = type(prog) is str,
+                               stderr=stderr,
+                               stdout=stdout,
+                               stdin=subprocess.PIPE,
+                               env=env)
+    except OSError, e:
+        debug('strerror:', e.strerror)
+        raise ProgramError(progStr, e.strerror)
+
+    if input != None:
+        pop.stdin.write(input)
+    pop.stdin.close()
+
+    if pipeOutput:
+        out = pop.stdout.read()
+    else:
+        out = ''
+
+    code = pop.wait()
+    if returnCode:
+        ret = [out, code]
+    else:
+        ret = out
+    if code != 0 and not returnCode:
+        debug('error output:', out)
+        debug('prog:', prog)
+        raise ProgramError(progStr, out)
+#    debug('output:', out.replace('\0', '\n'))
+    return ret
+
+# Git repository validation and initialization
+# --------------------------------------------
+
+def setupEnvironment():
+    if 'GIT_DIR' not in os.environ:
+        os.environ['GIT_DIR'] = '.git'
+
+    if not os.environ.has_key('GIT_OBJECT_DIRECTORY'):
+        os.environ['GIT_OBJECT_DIRECTORY'] = os.environ['GIT_DIR'] + '/objects'
+
+def repoValid():
+    if not (os.path.exists(os.environ['GIT_DIR']) and
+            os.path.exists(os.environ['GIT_DIR'] + '/refs') and
+            os.path.exists(os.environ['GIT_OBJECT_DIRECTORY']) and
+            os.path.exists(os.environ['GIT_OBJECT_DIRECTORY'] + '/00')):
+        print "Not a Git archive"
+        sys.exit(1)
+
+# Code for computing common ancestors
+# -----------------------------------
+
+currentId = 0
+def getUniqueId():
+    global currentId
+    currentId += 1
+    return currentId
+
+# The 'virtual' commit objects have SHAs which are integers
+shaRE = re.compile('^[0-9a-f]{40}$')
+def isSha(obj):
+    return (type(obj) is str and bool(shaRE.match(obj))) or \
+           (type(obj) is int and obj >= 1)
+
+class Commit:
+    def __init__(self, sha, parents, tree=None):
+        self.parents = parents
+        self.firstLineMsg = None
+        self.children = []
+
+        if tree:
+            tree = tree.rstrip()
+            assert(isSha(tree))
+        self._tree = tree
+
+        if not sha:
+            self.sha = getUniqueId()
+            self.virtual = True
+            self.firstLineMsg = 'virtual commit'
+            assert(isSha(tree))
+        else:
+            self.virtual = False
+            self.sha = sha.rstrip()
+        assert(isSha(self.sha))
+
+    def tree(self):
+        self.getInfo()
+        assert(self._tree != None)
+        return self._tree
+
+    def shortInfo(self):
+        self.getInfo()
+        return str(self.sha) + ' ' + self.firstLineMsg
+
+    def __str__(self):
+        return self.shortInfo()
+
+    def getInfo(self):
+        if self.virtual or self.firstLineMsg != None:
+            return
+        else:
+            info = runProgram(['git-cat-file', 'commit', self.sha])
+            info = info.split('\n')
+            msg = False
+            for l in info:
+                if msg:
+                    self.firstLineMsg = l
+                    break
+                else:
+                    if l.startswith('tree'):
+                        self._tree = l[5:].rstrip()
+                    elif l == '':
+                        msg = True
+
+class Graph:
+    def __init__(self):
+        self.commits = []
+        self.shaMap = {}
+
+    def addNode(self, node):
+        assert(isinstance(node, Commit))
+        self.shaMap[node.sha] = node
+        self.commits.append(node)
+        for p in node.parents:
+            p.children.append(node)
+        return node
+
+    def reachableNodes(self, n1, n2):
+        res = {}
+        def traverse(n):
+            res[n] = True
+            for p in n.parents:
+                traverse(p)
+
+        traverse(n1)
+        traverse(n2)
+        return res
+
+    def fixParents(self, node):
+        for x in range(0, len(node.parents)):
+            node.parents[x] = self.shaMap[node.parents[x]]
+
+# addDebug('buildGraph')
+def buildGraph(heads):
+    debug('buildGraph heads:', heads)
+    for h in heads:
+        assert(isSha(h))
+
+    g = Graph()
+
+    out = runProgram(['git-rev-list', '--parents'] + heads)
+    for l in out.split('\n'):
+        if l == '':
+            continue
+        shas = l.split(' ')
+
+        # This is a hack, we temporarily use the 'parents' attribute
+        # to contain a list of SHA1:s. They are later replaced by proper
+        # Commit objects.
+        c = Commit(shas[0], shas[1:])
+
+        g.commits.append(c)
+        g.shaMap[c.sha] = c
+
+    for c in g.commits:
+        g.fixParents(c)
+
+    for c in g.commits:
+        for p in c.parents:
+            p.children.append(c)
+    return g
+
+# Write the empty tree to the object database and return its SHA1
+def writeEmptyTree():
+    tmpIndex = os.environ['GIT_DIR'] + '/merge-tmp-index'
+    def delTmpIndex():
+        try:
+            os.unlink(tmpIndex)
+        except OSError:
+            pass
+    delTmpIndex()
+    newEnv = os.environ.copy()
+    newEnv['GIT_INDEX_FILE'] = tmpIndex
+    res = runProgram(['git-write-tree'], env=newEnv).rstrip()
+    delTmpIndex()
+    return res
+
+def addCommonRoot(graph):
+    roots = []
+    for c in graph.commits:
+        if len(c.parents) == 0:
+            roots.append(c)
+
+    superRoot = Commit(sha=None, parents=[], tree=writeEmptyTree())
+    graph.addNode(superRoot)
+    for r in roots:
+        r.parents = [superRoot]
+    superRoot.children = roots
+    return superRoot
+
+def getCommonAncestors(graph, commit1, commit2):
+    '''Find the common ancestors for commit1 and commit2'''
+    assert(isinstance(commit1, Commit) and isinstance(commit2, Commit))
+
+    def traverse(start, set):
+        stack = [start]
+        while len(stack) > 0:
+            el = stack.pop()
+            set.add(el)
+            for p in el.parents:
+                if p not in set:
+                    stack.append(p)
+    h1Set = Set()
+    h2Set = Set()
+    traverse(commit1, h1Set)
+    traverse(commit2, h2Set)
+    shared = h1Set.intersection(h2Set)
+
+    if len(shared) == 0:
+        shared = [addCommonRoot(graph)]
+        
+    res = Set()
+
+    for s in shared:
+        if len([c for c in s.children if c in shared]) == 0:
+            res.add(s)
+    return list(res)
