From: Fredrik Kuivinen <freku045@student.liu.se>
Subject: [PATCH] A new merge algorithm, take 2
Date: Sat, 27 Aug 2005 22:51:35 +0200
Message-ID: <20050827205135.GB16587@c165.ib.student.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Sat Aug 27 22:52:34 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E97eZ-0007fX-PS
	for gcvg-git@gmane.org; Sat, 27 Aug 2005 22:51:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750768AbVH0Uvs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 27 Aug 2005 16:51:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750774AbVH0Uvs
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Aug 2005 16:51:48 -0400
Received: from [85.8.31.11] ([85.8.31.11]:12207 "EHLO mail6.wasadata.com")
	by vger.kernel.org with ESMTP id S1750768AbVH0Uvs (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 27 Aug 2005 16:51:48 -0400
Received: from c165 (unknown [85.8.2.189])
	by mail6.wasadata.com (Postfix) with ESMTP id 24416413E
	for <git@vger.kernel.org>; Sat, 27 Aug 2005 22:55:40 +0200 (CEST)
Received: from ksorim by c165 with local (Exim 3.36 #1 (Debian))
	id 1E97eJ-0005MN-00
	for <git@vger.kernel.org>; Sat, 27 Aug 2005 22:51:35 +0200
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7853>

Hi,

I have cleaned up the code for the merge algorithm quite a lot. It is
in a much better shape now.

The main changes compared to the previous version are:

* Lots of clean up.
* Some of the scripts have been renamed to better match the naming
  convention used in Git.
* A new option ('-s') has been added to git-merge-cache
* Unclean merges are detected and reported
* Clean merges are committed

The user interface has been changed to:

   git-merge-script <branch> <message>

HEAD will be merged with <branch>. If the merge turns out to be clean
then it will be committed with the message <message>. The working
directory will always be updated to reflect the result of the merge.

git-merge-cache has a new flag, '-s'. When this flag is given
git-merge-cache will only run the merge-script once, instead of once
per cache entry. The needed information is written to the
merge-scripts stdin in the following form:

<oSha> SP <aSha> SP <bSha> SP <oMode> SP <aMode> SP <bMode> SP <path> NUL

where

   <oSha>  - original file SHA1 (or empty)
   <aSha>  - file in branch1 SHA1 (or empty)
   <bSha>  - file in branch2 SHA1 (or empty)
   <oMode> - orignal file mode (or empty)
   <aMode> - file in branch1 mode (or empty)
   <bMode> - file in branch2 mode (or empty)
   <path>  - pathname in repository

SP is a single space and NUL is \0. An empty SHA1 is represented as
'0000000000000000000000000000000000000000' and an empty mode is
represented with '0'.

This flag is nice to have when you have a merge-script which needs to
keep some state between different cache entries.

- Fredrik

Signed-off-by: Fredrik Kuivinen <freku045@student.liu.se>

---

 Makefile               |    3 -
 git-merge-files-script |  188 ++++++++++++++++++++++++++++++++
 git-merge-script       |   94 ++++++++++++++++
 gitMergeCommon.py      |   86 +++++++++++++++
 gitMergeCore.py        |  281 ++++++++++++++++++++++++++++++++++++++++++++++++
 merge-cache.c          |   78 +++++++++++++
 read-tree.c            |   13 ++
 7 files changed, 737 insertions(+), 6 deletions(-)
 create mode 100755 git-merge-files-script
 create mode 100755 git-merge-script
 create mode 100644 gitMergeCommon.py
 create mode 100644 gitMergeCore.py

diff --git a/Makefile b/Makefile
--- a/Makefile
+++ b/Makefile
@@ -66,7 +66,8 @@ SCRIPTS=git git-apply-patch-script git-m
 	git-format-patch-script git-sh-setup-script git-push-script \
 	git-branch-script git-parse-remote-script git-verify-tag-script \
 	git-ls-remote-script git-clone-dumb-http git-rename-script \
-	git-request-pull-script git-bisect-script
+	git-request-pull-script git-bisect-script git-merge-script \
+	gitMergeCommon.py gitMergeCore.py git-merge-files-script
 
 SCRIPTS += git-count-objects-script
 SCRIPTS += git-revert-script
diff --git a/git-merge-files-script b/git-merge-files-script
new file mode 100755
--- /dev/null
+++ b/git-merge-files-script
@@ -0,0 +1,188 @@
+#!/usr/bin/env python
+#
+# This script is based on 'git-merge-one-file-script' in the Git
+# distribution.
+#
+# This script is supposed to be executed by git-merge-cache.  When
+# git-merge-cache is used with the '-s' flag it will write entries to
+# the executed programs stdin. The syntax of one entry is:
+#
+# <oSha> SP <aSha> SP <bSha> SP <oMode> SP <aMode> SP <bMode> SP <path> NUL
+#
+#   <oSha>  - original file SHA1 (or empty)
+#   <aSha>  - file in branch1 SHA1 (or empty)
+#   <bSha>  - file in branch2 SHA1 (or empty)
+#   <oMode> - orignal file mode (or empty)
+#   <aMode> - file in branch1 mode (or empty)
+#   <bMode> - file in branch2 mode (or empty)
+#   <path>  - pathname in repository
+#
+# SP is a single space and NUL is \0. An empty SHA1 is represented as
+# '0000000000000000000000000000000000000000' and an empty mode is
+# represented with '0'.
+
+import sys, os, re
+from gitMergeCommon import *
+from sets import Set
+
+# TODO
+# Generate a unique file name when we get a name conflict.
+
+# x <==> sha != '', - <==> sha == '' 
+#
+# Case  o a b
+# D     x x x
+# A     x x -
+# A     x - x
+# A     x - -
+# C     - x x
+# B     - x -
+# B     - - x
+#       - - - Doesn't happen
+def processEntry(oSha, aSha, bSha, oMode, aMode, bMode, path):
+    global cleanMerge
+    debug('processing', path)
+    if oSha == '0'*40:
+        oSha = ''
+    if aSha == '0'*40:
+        aSha = ''
+    if bSha == '0'*40:
+        bSha = ''
+    if oMode == '0':
+        oMode = ''
+    if aMode == '0':
+        aMode = ''
+    if bMode == '0':
+        bMode = ''
+
+    if (oSha != '' and (aSha == '' or bSha == '')):
+    #
+    # Case A: Deleted in one
+    #
+        if (aSha == ''   and bSha == '') or \
+           (aSha == oSha and bSha == '') or \
+           (aSha == ''   and bSha == oSha):
+    # Deleted in both or deleted in one and unchanged in the other
+            print 'Removing ' + path
+            runProgram(['git-update-cache', '--force-remove', '--', path])
+        else:
+    # Deleted in one and changed in the other
+            cleanMerge = False
+            if aSha == '':
+                print 'CONFLICT (del/mod): "' + path + '" deleted in', \
+                      branch1, 'and modified in', branch2, '. Version', branch2, ' of "' + path + '" left in tree'
+                mode = bMode
+                sha = bSha
+            else:
+                print 'CONFLICT (mod/del): "' + path + '" deleted in', branch2, 'and modified in', branch1, \
+                      '. Version', branch1, 'of "' + path + '" left in tree'
+                mode = aMode
+                sha = aSha
+            runProgram(['git-update-cache', '--cacheinfo', mode, sha, path])
+    
+    elif (oSha == '' and aSha != '' and bSha == '') or \
+         (oSha == '' and aSha == '' and bSha != ''):
+    #
+    # Case B: Added in one.
+    #
+        if aSha != '':
+            addBranch = branch1
+            otherBranch = branch2
+            conf = 'file/dir'
+        else:
+            addBranch = branch2
+            otherBranch = branch1
+            conf = 'dir/file'
+    
+        if path in dirs:
+            cleanMerge = False
+            newPath = path + '_' + addBranch
+            print 'CONFLICT (' + conf + '): There is a directory with name "' + path + '" in', otherBranch, \
+                  '. Adding "' + path + '" as "' + newPath + '"'
+            runProgram(['git-update-cache', '--force-remove', '--', path])
+            path = newPath
+        else:
+            print 'Adding "' + path + '"'
+        runProgram(['git-update-cache', '--add', '--cacheinfo', aMode+bMode, aSha+bSha, path])
+    
+    elif oSha == '' and aSha != '' and bSha != '':
+    #
+    # Case C: Added in both (check for same permissions).
+    #
+        if aSha == bSha:
+            if aMode != bMode:
+                cleanMerge = False
+                print 'CONFLICT: File "' + path + '" added identically in both branches,'
+                print 'CONFLICT: but permissions conflict', aMode, '->', bMode
+                print 'CONFLICT: adding with permission:', aMode
+                runProgram(['git-update-cache', '--add', '--cacheinfo', aMode, aSha, path])
+            else:
+                # This case is handled by git-read-tree
+                print 'Adding', path
+                runProgram(['git-update-cache', '--add', '--cacheinfo', aMode, aSha, path])
+        else:
+            cleanMerge = False
+            newPath1 = path + '_' + branch1
+            newPath2 = path + '_' + branch2
+            print 'CONFLICT (add/add): File "' + path + '" added non-identically in both branches.', \
+                  'Adding "' + newPath1 + '" and "' + newPath2 + '" instead.'
+            runProgram(['git-update-cache', '--force-remove', '--', path])
+            runProgram(['git-update-cache', '--add',
+                        '--cacheinfo', aMode, aSha, newPath1,
+                        '--cacheinfo', bMode, bSha, newPath2])
+    
+    elif oSha != '' and aSha != '' and bSha != '':
+    #
+    # case D: Modified in both, but differently.
+    #
+        print 'Auto-merging', path 
+        orig = runProgram(['git-unpack-file', oSha]).rstrip()
+        src1 = runProgram(['git-unpack-file', aSha]).rstrip()
+        src2 = runProgram(['git-unpack-file', bSha]).rstrip()
+        [out, ret] = runProgram(['merge',
+                                 '-L', os.environ['GIT_MERGE_BRANCH_1'] + '/' + path,
+                                 '-L', 'orig/' + path,
+                                 '-L', os.environ['GIT_MERGE_BRANCH_2'] + '/' + path,
+                                 src1, orig, src2], returnCode=True)
+    
+        if ret != 0:
+            cleanMerge = False
+            print 'CONFLICT (content): Merge conflict in "' + path + '".'
+    
+        if aMode == oMode:
+            mode = bMode
+        else:
+            mode = aMode
+    
+        sha = runProgram(['git-hash-object', '-t', 'blob', '-w', src1])
+        runProgram(['git-update-cache', '--cacheinfo', aMode, sha, path])
+        os.unlink(orig)
+        os.unlink(src1)
+        os.unlink(src2)
+    else:
+        print 'ERROR: Fatal merge failure.'
+        print "ERROR: Shouldn't happen"
+        sys.exit(1)
+
+[files, dirs] = eval(open(os.environ['GIT_MERGE_DIRS']).read())
+branch1 = os.environ['GIT_MERGE_BRANCH_1']
+branch2 = os.environ['GIT_MERGE_BRANCH_2']
+cleanMerge = True
+
+input = sys.stdin.read()
+entries = input.split("\0")
+entries.pop() # remove last entry (which is '')
+entryRE = re.compile('^([0-9a-f]{40}) ([0-9a-f]{40}) ([0-9a-f]{40}) ([0-9]+) ([0-9]+) ([0-9]+) (.*)$')
+debug('starting processing...', repr(entries))
+for entry in entries:
+    m = entryRE.match(entry)
+    if m:
+        processEntry(m.group(1), m.group(2), m.group(3), m.group(4),
+                     m.group(5), m.group(6), m.group(7))
+    else:
+        print sys.argv[0], 'Invalid input from merge program:', entry
+        sys.exit(1)
+
+if not cleanMerge:
+    sys.exit(1)
+
diff --git a/git-merge-script b/git-merge-script
new file mode 100755
--- /dev/null
+++ b/git-merge-script
@@ -0,0 +1,94 @@
+#!/usr/bin/env python
+
+from gitMergeCommon import *
+from gitMergeCore import buildGraph, merge
+import sys
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
+        print 'Failed to write to', os.environ['GIT_DIR'] + '/' + head + ':', e.strerror
+        sys.exit(1)
+    return True
+
+def checkCleanTree():
+    [out, code] = runProgram(['git-update-cache', '--refresh'], returnCode = True)
+
+    if code != 0:
+        return False
+    out = runProgram(['git-diff-cache', '--name-only', '--cached', 'HEAD'])
+    if len(out) > 0:
+        return False
+
+    return True
+
+def doCommit(msg, p1, p2):
+    tree = runProgram(['git-write-tree'])
+    tree = tree.rstrip()
+
+    commit = runProgram(['git-commit-tree', tree, '-p', p1, '-p', p2], msg + '\n')
+    writeHead('HEAD', commit)
+    return commit.rstrip()
+
+if len(sys.argv) < 2:
+    print 'Usage:', sys.argv[0], '<branch> <msg>'
+    sys.exit(1)
+
+setupEnvironment()
+repoValid()
+
+if not checkCleanTree():
+    print 'Either the cache is out of sync or the working tree does not match HEAD.'
+    print 'Aborting merge.'
+    sys.exit(1)
+
+h1 = firstBranch = 'HEAD'
+h2 = secondBranch = sys.argv[1]
+commitMessage = sys.argv[2]
+
+print 'Merging', h1, 'with', h2
+h1 = runProgram(['git-rev-parse', '--revs-only', h1]).rstrip()
+h2 = runProgram(['git-rev-parse', '--revs-only', h2]).rstrip()
+print 'Resolved heads: h1:', h1, 'h2:', h2
+
+writeHead('ORIG_HEAD', h1)
+writeHead('LAST_MERGE', h2)
+
+print 'Building graph...'
+graph = buildGraph([h1, h2])
+print 'graph done.'
+
+[res, clean] = merge(graph.shaMap[h1], graph.shaMap[h2], firstBranch, secondBranch, graph)
+print 'Merge result: (tree)', res.tree()
+
+# Checkout the merge results
+runProgram(['git-read-tree', 'HEAD'])
+runProgram(['git-update-cache', '--refresh'])
+runProgram(['git-read-tree', '-m', '-u', 'HEAD', res.tree()])
+
+if clean:
+    cmit = doCommit(commitMessage, h1, h2)
+    print 'Committed merge', cmit
+    print runProgram('git-diff-tree -p ORIG_HEAD ' + cmit + ' | git-apply --stat')
+    dropHeads()
+else:
+    print 'Automatic merge failed, fix up by hand'
+    writeHead('MERGE_HEAD', h2)
+    sys.exit(1)
diff --git a/gitMergeCommon.py b/gitMergeCommon.py
new file mode 100644
--- /dev/null
+++ b/gitMergeCommon.py
@@ -0,0 +1,86 @@
+import sys
+
+if sys.version_info[0] < 2 or (sys.version_info[0] == 2 and sys.version_info[1] < 4):
+    print 'Python version 2.4 required, found', \
+    str(sys.version_info[0])+'.'+str(sys.version_info[1])+'.'+str(sys.version_info[2])
+    sys.exit(1)
+
+import subprocess, os, sets, traceback
+
+DEBUG = 0
+
+functionsToDebug = sets.Set()
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
+class ProgramError(Exception):
+    def __init__(self, progStr, error):
+        self.progStr = progStr
+        self.error = error
+
+# addDebug('runProgram')
+def runProgram(prog, input=None, returnCode=False, env=None):
+    debug('runProgram prog:', str(prog), 'input:', str(input))
+    if type(prog) is str:
+        progStr = prog
+    else:
+        progStr = ' '.join(prog)
+    
+    try:
+        pop = subprocess.Popen(prog,
+                               shell = type(prog) is str,
+                               stderr=subprocess.STDOUT,
+                               stdout=subprocess.PIPE,
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
+    out = pop.stdout.read()
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
diff --git a/gitMergeCore.py b/gitMergeCore.py
new file mode 100644
--- /dev/null
+++ b/gitMergeCore.py
@@ -0,0 +1,281 @@
+import sys, math, random, os, re, signal, tempfile
+from gitMergeCommon import runProgram, debug, addDebug, printList
+from heapq import heappush, heappop
+from sets import Set
+
+currentId = 0
+def getUniqueId():
+    global currentId
+    currentId += 1
+    return currentId
+
+class Commit:
+    def __init__(self, sha, parents, tree=None):
+        self.parents = parents
+        self.firstLineMsg = None
+        self.children = []
+
+        if tree:
+            tree = tree.rstrip()
+        self._tree = tree
+
+        if not sha:
+            self.sha = getUniqueId()
+            self.virtual = True
+            self.firstLineMsg = 'virtual commit'
+            assert(tree != None)
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
+def findShared(h1, h2):
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
+    traverse(h1, h1Set)
+    traverse(h2, h2Set)
+
+    return h1Set.intersection(h2Set)
+
+def sharedHeads(shared):
+    h = Set()
+
+    for s in shared:
+        if len([c for c in s.children if c in shared]) == 0:
+            h.add(s)
+    return list(h)
+
+getFilesRE = re.compile('([0-9]+) ([a-z0-9]+) ([0-9a-f]{40})\t(.*)')
+def getFilesAndDirs(tree1, tree2):
+    files = Set()
+    dirs = Set()
+    def addFilesDirs(tree):
+        out = runProgram(['git-ls-tree', '-r', '-z', tree])
+        for l in out.split('\0'):
+            m = getFilesRE.match(l)
+            if m:
+                if m.group(2) == 'tree':
+                    dirs.add(m.group(4))
+                elif m.group(2) == 'blob':
+                    files.add(m.group(4))
+
+    addFilesDirs(tree1)
+    addFilesDirs(tree2)
+    return [files, dirs]
+
+def merge(h1, h2, branch1Name, branch2Name, graph, indent=0, first=True):
+    def infoMsg(*args):
+        sys.stdout.write('  '*indent)
+        printList(args)
+    infoMsg('Merging:')
+    infoMsg(h1)
+    infoMsg(h2)
+    assert(isinstance(h1, Commit) and isinstance(h2, Commit))
+    assert(isinstance(graph, Graph))
+
+    s = findShared(h1, h2)
+    if len(s) == 0:
+        s = [addCommonRoot(graph)]
+
+    # infoMsg('found', len(s), 'shared commits.')
+    # if len(s) < 10:
+    #    for x in s:
+    #        infoMsg(x)
+    sys.stdout.flush()
+    s = sharedHeads(s)
+    infoMsg('found', len(s), 'shared head(s):')
+    for x in s :
+        infoMsg(x)
+    Ms = s[0]
+
+    for h in s[1:]:
+        [Ms, ignore] = merge(Ms, h, branch1Name, branch2Name, graph, indent+1, False)
+
+    filesDirs = getFilesAndDirs(h1.tree(), h2.tree())
+    
+    infoMsg('running resolve on')
+    infoMsg(h1)
+    infoMsg(h2)
+
+    if first:
+        b1 = branch1Name
+        b2 = branch2Name
+    else:
+        b1 = 'Temporary shared merge branch 1'
+        b2 = 'Temporary shared merge branch 2'
+    [shaRes, clean] = resolve(h1.tree(), h2.tree(), Ms.tree(), b1, b2, filesDirs)
+
+    res = Commit(None, [h1, h2], tree=shaRes)
+    graph.addNode(res)
+    # infoMsg('merge returned: (tree)',  res.tree())
+    return [res, clean]
+
+# The 'virtual' commit objects have SHAs which are integers
+shaRE = re.compile('^[0-9a-f]{40}$')
+def isSha(obj):
+    return (type(obj) is str and bool(shaRE.match(obj))) or \
+           (type(obj) is int and obj >= 1)
+
+def resolve(head, merge, common, b1, b2, filesDirs):
+    assert(isSha(head) and isSha(merge) and isSha(common))
+    head = runProgram(['git-rev-parse', '--revs-only', head]).rstrip()
+    merge = runProgram(['git-rev-parse', '--revs-only', merge]).rstrip()
+
+    if common == merge:
+        return head
+
+    if common == head:
+        return merge
+
+    runProgram(['git-read-tree', head])
+    runProgram(['git-read-tree', '-i', '-m', common, head, merge])
+    os.environ['GIT_MERGE_BRANCH_1'] = b1
+    os.environ['GIT_MERGE_BRANCH_2'] = b2
+    fdirs = tempfile.NamedTemporaryFile('w')
+    fdirs.write(repr(filesDirs))
+    fdirs.flush()
+    os.environ['GIT_MERGE_DIRS'] = fdirs.name
+    try:
+        [tree, code] = runProgram('git-write-tree', returnCode=True)
+        tree = tree.rstrip()
+        if code != 0:
+            [out, code] = runProgram(['git-merge-cache', '-s',
+                                      'git-merge-files-script', '-a'],
+                                     returnCode=True)
+            print out
+            if code != 0:
+                # Non-clean merge
+                clean = False
+            else:
+                clean = True
+            tree = runProgram('git-write-tree').rstrip()
+        else:
+            clean = True
+    finally:
+        fdirs.close()
+
+    return [tree, clean]
+
diff --git a/merge-cache.c b/merge-cache.c
--- a/merge-cache.c
+++ b/merge-cache.c
@@ -5,7 +5,7 @@
 
 static const char *pgm = NULL;
 static const char *arguments[8];
-static int one_shot, quiet;
+static int one_shot, quiet, use_stdin, stdin_fd, pgm_pid;
 static int err;
 
 static void run_program(void)
@@ -37,6 +37,59 @@ static void run_program(void)
 	}
 }
 
+static void start_program(void)
+{
+	int pid, fds[2];
+
+	if (pipe(fds) < 0)
+		die("pipe failed: %s", strerror(errno));
+
+	pid = fork();
+	if (pid < 0)
+		die("unable to fork");
+
+	if (!pid) {
+		close(fds[1]);
+		dup2(fds[0], 0);
+		close(fds[0]);
+		execlp(pgm, pgm, NULL);
+		die("unable to execute '%s': %s", pgm, strerror(errno));
+	}
+
+	pgm_pid = pid;
+	close(fds[0]);
+	stdin_fd = fds[1];
+}
+
+static void die_write(int fd, const char* buf, int len)
+{
+	if (write(fd, buf, len) != len)
+		die("unable to write: %s", strerror(errno));
+}
+
+static void write_to_program(void)
+{
+	int arg;
+	for(arg = 1; arg < 4; arg++) {
+		if(!strcmp("", arguments[arg]))
+			die_write(stdin_fd, "0000000000000000000000000000000000000000", 40);
+		else
+			die_write(stdin_fd, arguments[arg], 40);
+		die_write(stdin_fd, " ", 1);
+	}
+
+	for(arg = 5; arg < 8; arg++) {
+		if(!strcmp("", arguments[arg]))
+			die_write(stdin_fd, "0", 1);
+		else
+			die_write(stdin_fd, arguments[arg], strlen(arguments[arg]));
+		die_write(stdin_fd, " ", 1);
+	}
+
+	/* Make sure we write the terminating \0 too. */
+	die_write(stdin_fd, arguments[4], strlen(arguments[4])+1);
+}
+
 static int merge_entry(int pos, const char *path)
 {
 	int found;
@@ -68,7 +121,11 @@ static int merge_entry(int pos, const ch
 	} while (++pos < active_nr);
 	if (!found)
 		die("git-merge-cache: %s not in the cache", path);
-	run_program();
+
+        if(use_stdin)
+            write_to_program();
+        else
+            run_program();
 	return found;
 }
 
@@ -100,7 +157,7 @@ int main(int argc, char **argv)
 	int i, force_file = 0;
 
 	if (argc < 3)
-		usage("git-merge-cache [-o] [-q] <merge-program> (-a | <filename>*)");
+		usage("git-merge-cache [-o] [-q] [-s] <merge-program> (-a | <filename>*)");
 
 	read_cache();
 
@@ -113,7 +170,14 @@ int main(int argc, char **argv)
 		quiet = 1;
 		i++;
 	}
+        if (!strcmp(argv[i], "-s")) {
+            use_stdin = 1;
+            i++;
+        }
 	pgm = argv[i++];
+        if(use_stdin)
+            start_program();
+        
 	for (; i < argc; i++) {
 		char *arg = argv[i];
 		if (!force_file && *arg == '-') {
@@ -129,6 +193,14 @@ int main(int argc, char **argv)
 		}
 		merge_file(arg);
 	}
+
+        if(use_stdin) {
+            int status;
+            close(stdin_fd);
+            if (waitpid(pgm_pid, &status, 0) < 0 || !WIFEXITED(status) || WEXITSTATUS(status))
+                err = 1;
+	}
+
 	if (err && !quiet)
 		die("merge program failed");
 	return err;
diff --git a/read-tree.c b/read-tree.c
--- a/read-tree.c
+++ b/read-tree.c
@@ -7,6 +7,7 @@
 
 static int stage = 0;
 static int update = 0;
+static int ignore_working_dir = 0;
 
 static int unpack_tree(unsigned char *sha1)
 {
@@ -80,7 +81,10 @@ static void verify_uptodate(struct cache
 {
 	struct stat st;
 
-	if (!lstat(ce->name, &st)) {
+        if (ignore_working_dir)
+            return;
+
+        if (!lstat(ce->name, &st)) {
 		unsigned changed = ce_match_stat(ce, &st);
 		if (!changed)
 			return;
@@ -510,7 +514,7 @@ static int read_cache_unmerged(void)
 	return deleted;
 }
 
-static const char read_tree_usage[] = "git-read-tree (<sha> | -m [-u] <sha1> [<sha2> [<sha3>]])";
+static const char read_tree_usage[] = "git-read-tree (<sha> | -m [-u] [-i] <sha1> [<sha2> [<sha3>]])";
 
 static struct cache_file cache_file;
 
@@ -535,6 +539,11 @@ int main(int argc, char **argv)
 			continue;
 		}
 
+                if (!strcmp(arg, "-i")) {
+                        ignore_working_dir = 1;
+                        continue;
+                }
+
 		/* This differs from "-m" in that we'll silently ignore unmerged entries */
 		if (!strcmp(arg, "--reset")) {
 			if (stage || merge || emu23)
