From: Fredrik Kuivinen <freku045@student.liu.se>
Subject: [RFC, PATCH] A new merge algorithm (EXPERIMENTAL)
Date: Fri, 26 Aug 2005 20:47:31 +0200
Message-ID: <20050826184731.GA13629@c165.ib.student.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Aug 26 20:49:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E8jEw-0005z2-RZ
	for gcvg-git@gmane.org; Fri, 26 Aug 2005 20:47:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030182AbVHZSro (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 26 Aug 2005 14:47:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030183AbVHZSrn
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Aug 2005 14:47:43 -0400
Received: from [85.8.31.11] ([85.8.31.11]:20141 "EHLO mail6.wasadata.com")
	by vger.kernel.org with ESMTP id S1030182AbVHZSrn (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Aug 2005 14:47:43 -0400
Received: from c165 (unknown [85.8.2.189])
	by mail6.wasadata.com (Postfix) with ESMTP id A21F840FD
	for <git@vger.kernel.org>; Fri, 26 Aug 2005 20:51:32 +0200 (CEST)
Received: from ksorim by c165 with local (Exim 3.36 #1 (Debian))
	id 1E8jEh-0003b4-00
	for <git@vger.kernel.org>; Fri, 26 Aug 2005 20:47:31 +0200
To: git@vger.kernel.org
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7821>

Hi,

I have for some time now been playing with a new merge algorithm.  It
is designed to solve some of the content merges that comes up now and
then. For example the criss-cross merge case described by Bram Cohen
[1], the similar case described by Matthias Urlichs [3] and the merge
case Tony Luck found [2].

It does _not_ do anything smart with respect to tree changes. So with
respect to file renames, directory renames etc it wont be any better
than the current git-resolve-script.

The new code consists of a few files merge.py,
git-new-merge-one-file-script.py, gitMergeCommon.py and
gitMergeCore.py. Its all written in Python, at least version 2.4 is
required. It also need a small patch to read-tree.c. Right now its all
very much experimental. It seems to do the right thing on the test
cases I have given to it, but it probably contains lots of bugs and
unsolved corner cases.

The user interface consists of the program 'merge.py'. 
The syntax is: merge.py <branch> 

merge.py expects that the working directory is in sync with both the
cache and HEAD. It will merge HEAD with <branch>. The result of the
merge will be written to the working directory and the cache will be
updated to match the working directory. Those two steps are always
done, even if the merge was non-clean. merge.py will create the
appropriate .git/MERGE_HEAD.

I will try to describe how the algorithm works. The problem with the
usual 3-way merge algorithm is that we sometimes do not have a unique
common ancestor. In [1] B and C seems to be equally good. What this
algorithm does is to _merge_ the common ancestors, in this case B and
C, into a temporary tree lets call it T. It does then use this
temporary tree T as the common ancestor for D and E to produce the
final merge result. In the case described in [1] this will work out
fine and we get a clean merge with the expected result.

The common ancestors that are found to be "equally good" are named
"shared heads" in the code. In the criss-cross merge case there are
two shared heads, B and C.

In [2] the algorithm finds three shared heads,
f6fdd7d9c273bb2a20ab467cb57067494f932fa3,
3a931d4cca1b6dabe1085cc04e909575df9219ae and
c1ffb910f7a4e1e79d462bb359067d97ad1a8a25. Those three commits are then
merged to produce a new temporary tree T. T is then used as the common
ancestor to merge the original
a4cce10492358b33d33bb43f98284c80482037e8 and
7ffacc1a2527c219b834fe226a7a55dc67ca3637.

The result is the expected one, that is the diff between the merge
produced by 'merge.py' and 'git-resolve-script' is

diff --git a/arch/ia64/hp/sim/boot/bootloader.c b/arch/ia64/hp/sim/boot/bootloader.c
--- a/arch/ia64/hp/sim/boot/bootloader.c
+++ b/arch/ia64/hp/sim/boot/bootloader.c
@@ -30,10 +30,14 @@ struct disk_req {
        unsigned len;
 };
 
+/* SSC_WAIT_COMPLETION appears to want this large alignment.  gcc < 4
+ * seems to give it by default, however gcc > 4 is smarter and may
+ * not.
+ */
 struct disk_stat {
        int fd;
        unsigned count;
-};
+} __attribute__ ((aligned (16)));
 
 extern void jmp_to_kernel (unsigned long bp, unsigned long e_entry);
 extern struct ia64_boot_param *sys_fw_init (const char *args, int arglen);



In most merges there is only one shared head, in this case 'merge.py'
is supposed to produce similar results as we get with
'git-resolve-script'.

In real numbers it is as follows: In Linus' kernel tree there are
5996 commits. 400 of those have more than one parent. Of those 400
merge commits 4 have more than one shared head.

Currently the main problems and questions that I see with this patch
are:

* There is no way to easily detect if the merge was clean or not. A
  message about it is written to stdout but merge.py wont return a
  usable error code. This shouldn't be too hard to fix.
* Temporary trees and other objects may be written to the object
  database during the merge. They are currently not deleted.
* If this is going to be used for anything real it has to be cleaned
  up.
* Are there merge cases for which this algorithm clearly produces the 
  wrong result?
* Is it worth it? That is, is the added complexity in the merge logic
  worth the advantages of correctly handling some strange (but real
  life) merge cases?

- Fredrik

[1] http://www.gelato.unsw.edu.au/archives/git/0504/2279.html
[2] http://www.gelato.unsw.edu.au/archives/git/0508/8072.html, and the
    follow-up discussion.
[3] http://www.gelato.unsw.edu.au/archives/git/0507/6082.html

Signed-off-by: Fredrik Kuivinen <freku045@student.liu.se>

---

 Makefile                  |    3 
 git-new-merge-one-file.py |  153 ++++++++++++++++++++
 gitMergeCommon.py         |   68 +++++++++
 gitMergeCore.py           |  350 +++++++++++++++++++++++++++++++++++++++++++++
 merge.py                  |   39 +++++
 read-tree.c               |   13 +-
 6 files changed, 623 insertions(+), 3 deletions(-)

diff --git a/Makefile b/Makefile
--- a/Makefile
+++ b/Makefile
@@ -66,7 +66,8 @@ SCRIPTS=git git-apply-patch-script git-m
 	git-format-patch-script git-sh-setup-script git-push-script \
 	git-branch-script git-parse-remote-script git-verify-tag-script \
 	git-ls-remote-script git-clone-dumb-http git-rename-script \
-	git-request-pull-script git-bisect-script
+	git-request-pull-script git-bisect-script merge.py gitMergeCommon.py \
+	gitMergeCore.py git-new-merge-one-file.py
 
 SCRIPTS += git-count-objects-script
 # SCRIPTS += git-send-email-script
diff --git a/git-new-merge-one-file.py b/git-new-merge-one-file.py
new file mode 100755
--- /dev/null
+++ b/git-new-merge-one-file.py
@@ -0,0 +1,153 @@
+#!/usr/bin/env python
+#
+# This script is based on 'git-merge-one-file-script' in the Git
+# distribution.
+#
+# This is a git per-file merge script, called with
+#
+#   $1 - original file SHA1 (or empty)
+#   $2 - file in branch1 SHA1 (or empty)
+#   $3 - file in branch2 SHA1 (or empty)
+#   $4 - pathname in repository
+#   $5 - orignal file mode (or empty)
+#   $6 - file in branch1 mode (or empty)
+#   $7 - file in branch2 mode (or empty)
+#
+# Handle some trivial cases.. The _really_ trivial cases have
+# been handled already by git-read-tree, but that one doesn't
+# do any merges that might change the tree layout.
+
+import sys, os
+from gitMergeCommon import *
+from sets import Set
+
+oSha = sys.argv[1]
+aSha = sys.argv[2]
+bSha = sys.argv[3]
+path = sys.argv[4]
+oMode = sys.argv[5]
+aMode = sys.argv[6]
+bMode = sys.argv[7]
+
+branch1 = os.environ['GIT_MERGE_BRANCH_1']
+branch2 = os.environ['GIT_MERGE_BRANCH_2']
+[files, dirs] = eval(open(os.environ['GIT_MERGE_DIRS']).read())
+
+# TODO
+# dir/file name conflicts
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
+
+if (oSha != '' and (aSha == '' or bSha == '')):
+#
+# Case A: Deleted in one
+#
+    if (aSha == ''   and bSha == '') or \
+       (aSha == oSha and bSha == '') or \
+       (aSha == ''   and bSha == oSha):
+# Deleted in both or deleted in one and unchanged in the other
+        print 'Removing ' + path
+        runProgram(['git-update-cache', '--force-remove', '--', path])
+    else:
+# Deleted in one and changed in the other
+        if aSha == '':
+            print 'CONFLICT (del/mod): "' + path + '" deleted in', \
+                  branch1, 'and modified in', branch2, '. Version ', branch2, ' of "' + path + '" left in tree'
+            mode = bMode
+            sha = bSha
+        else:
+            print 'CONFLICT (mod/del): "' + path + '" deleted in ' + branch2 + ' and modified in ' + branch1 + \
+                  '. Version ' + branch1 + ' of "' + path + '" left in tree'
+            mode = aMode
+            sha = aSha
+        runProgram(['git-update-cache', '--cacheinfo', mode, sha, path])
+
+elif (oSha == '' and aSha != '' and bSha == '') or \
+     (oSha == '' and aSha == '' and bSha != ''):
+#
+# Case B: Added in one.
+#
+    if aSha != '':
+        addBranch = branch1
+        otherBranch = branch2
+        conf = 'file/dir'
+    else:
+        addBranch = branch2
+        otherBranch = branch1
+        conf = 'dir/file'
+
+    if path in dirs:
+        newPath = path + '_' + addBranch
+        print 'CONFLICT (' + conf + '): There is a directory with name "' + path + '" in ' + otherBranch + \
+              '. Adding "' + path + '" as "' + newPath + '"'
+        runProgram(['git-update-cache', '--force-remove', '--', path])
+        path = newPath
+    else:
+        print 'Adding "' + path + '"'
+    runProgram(['git-update-cache', '--add', '--cacheinfo', aMode+bMode, aSha+bSha, path])
+
+elif oSha == '' and aSha != '' and bSha != '':
+#
+# Case C: Added in both (check for same permissions).
+#
+    if aSha == bSha:
+        if aMode != bMode:
+            print 'CONFLICT: File "' + path + '" added identically in both branches,'
+            print 'CONFLICT: but permissions conflict ' + aMode + '->' + bMode + '.'
+            print 'CONFLICT: adding with permission: ' + aMode
+            runProgram(['git-update-cache', '--add', '--cacheinfo', aMode, aSha, path])
+        else:
+            # This case is handled by git-read-tree
+            print 'Adding ' + path
+            runProgram(['git-update-cache', '--add', '--cacheinfo', aMode, aSha, path])
+    else:
+        newPath1 = path + '_' + branch1
+        newPath2 = path + '_' + branch2
+        print 'CONFLICT (add/add): File "' + path + '" added non-identically in both branches. ' + \
+              'Adding "' + newPath1 + '" and "' + newPath2 + '" instead.'
+        runProgram(['git-update-cache', '--force-remove', '--', path])
+        runProgram(['git-update-cache', '--add',
+                    '--cacheinfo', aMode, aSha, newPath1,
+                    '--cacheinfo', bMode, bSha, newPath2])
+
+elif oSha != '' and aSha != '' and bSha != '':
+#
+# case D: Modified in both, but differently.
+#
+    print 'Auto-merging ' + path + '.'
+    orig = runProgram(['git-unpack-file', oSha]).rstrip()
+    src1 = runProgram(['git-unpack-file', aSha]).rstrip()
+    src2 = runProgram(['git-unpack-file', bSha]).rstrip()
+    [out, ret] = runProgram(['merge',
+                             '-L', os.environ['GIT_MERGE_BRANCH_1'] + '/' + path,
+                             '-L', 'orig/' + path,
+                             '-L', os.environ['GIT_MERGE_BRANCH_2'] + '/' + path,
+                             src1, orig, src2], returnCode=True)
+
+    if ret != 0:
+        print 'CONFLICT (content): Merge conflict in "' + path + '".'
+
+    if aMode == oMode:
+        mode = bMode
+    else:
+        mode = aMode
+
+    sha = runProgram(['git-hash-object', '-t', 'blob', '-w', src1])
+    runProgram(['git-update-cache', '--cacheinfo', aMode, sha, path])
+    os.unlink(orig)
+    os.unlink(src1)
+    os.unlink(src2)
+else:
+    print 'ERROR: Fatal merge failure.'
+    print "ERROR: Shouldn't happen"
+
diff --git a/gitMergeCommon.py b/gitMergeCommon.py
new file mode 100644
--- /dev/null
+++ b/gitMergeCommon.py
@@ -0,0 +1,68 @@
+import sys
+
+if sys.version_info[0] < 2 or (sys.version_info[0] == 2 and sys.version_info[1] < 4):
+    print 'Python version 2.4 required, found', \
+    str(sys.version_info[0])+'.'+str(sys.version_info[1])+'.'+str(sys.version_info[2])
+    sys.exit(1)
+
+import subprocess, os
+
+DEBUG = 1
+
+def debug(str, level=1):
+    if level > DEBUG:
+        print str
+
+class ProgramError(Exception):
+    def __init__(self, progStr, error):
+        self.progStr = progStr
+        self.error = error
+
+def runProgram(prog, input=None, returnCode=False):
+    debug('runProgram prog: ' + str(prog) + " input: " + str(input))
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
+                               stdin=subprocess.PIPE)
+    except OSError, e:
+        debug("strerror: " + e.strerror, 2)
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
+            print "error output: " + out
+            print 'prog: ' + str(prog)
+            raise ProgramError(progStr, out)
+    debug("output: " + out.replace('\0', '\n'))
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
@@ -0,0 +1,350 @@
+import sys, math, random, os, re, signal, tempfile
+from gitMergeCommon import runProgram, debug, DEBUG
+from heapq import heappush, heappop
+from sets import Set
+
+class GitObject:
+    def __init__(self, sha):
+        self.sha = sha.rstrip()
+
+def loadCommit(sha):
+    c = Commit(sha)
+    c.getInfo()
+    return c
+
+class Commit(GitObject):
+    def __init__(self, sha, parents=None, tree=None, author=None,
+                 committer=None, msg=None):
+        self.parents = parents
+        self.author = author
+        self.committer = committer
+        self.msg = msg
+        self.children = []
+
+        if tree:
+            tree = tree.rstrip()
+        self._tree = tree
+
+        if not sha:
+            sha = self.writeObject(False)
+
+        GitObject.__init__(self, sha)
+
+    def writeObject(self, write=True):
+        fout = tempfile.NamedTemporaryFile('w')
+
+        fout.write('tree ' + self._tree + '\n')
+        for p in self.parents:
+            if isinstance(p, Commit):
+                p = p.sha
+            fout.write('parent ' + p + '\n')
+        fout.write('author Temporary merge author <temp@example.com> 0 +0000\n')
+        fout.write('committer Temporary merge committer <temp@example.com> 0 +0000\n\n')
+        fout.write(self.msg + '\n')
+        fout.flush()
+        if write:
+            runProgram(['git-hash-object', '-w', '-t', 'commit', fout.name])
+            ret = None
+        else:
+            ret = runProgram(['git-hash-object', '-t', 'commit', fout.name]).rstrip()
+        fout.close()
+        return ret
+        
+    def tree(self):
+        self.getInfo()
+        return self._tree
+
+    def shortInfo(self):
+        self.getInfo()
+        return self.sha.rstrip() + ' ' + self.msg.split('\n')[0]
+
+    def __str__(self):
+        return self.shortInfo()
+
+    def getInfo(self):
+        if self.msg != None:
+            return
+        else:
+            info = runProgram(['git-cat-file', 'commit', self.sha])
+            info = info.split('\n')
+            msg = False
+            self.msg = ''
+            newParents = []
+            for l in info:
+                if msg:
+                    self.msg += l + '\n'
+                else:
+                    if l.startswith('tree'):
+                        self._tree = l[5:].rstrip()
+                    elif l.startswith('author'):
+                        self.author = l
+                    elif l.startswith('committer'):
+                        self.committer = l
+                    elif l.startswith('parent'):
+                        newParents.append(l[7:].rstrip())
+                    elif l == '':
+                        msg = True
+            if not self.parents:
+                self.parents = newParents
+
+    # This is needed by the heap implementation in heapq. We want a
+    # max heap, but heapq provides us with a min heap. We therefore use
+    # >= instead of <= in this function.
+    def __le__(self, other):
+        return self.index >= other.index
+
+class Graph:
+    def __init__(self):
+        self.topoOrder = []
+        self.shaMap = {}
+
+    def addNode(self, node):
+        assert(isinstance(node, Commit) or isSha(node))
+        if isSha(node):
+            node = loadCommit(node)
+            self.fixParents(node)
+        self.shaMap[node.sha] = node
+        node.index = len(self.topoOrder)
+        self.topoOrder.append(node)
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
+def buildGraph(heads):
+    print 'buildGraph heads: ' + str(heads)
+    for h in heads:
+        assert(isSha(h))
+
+    g = Graph()
+
+    out = runProgram(['git-rev-list', '--parents', '--topo-order'] + heads)
+    print 'git-rev-list done.'
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
+        g.topoOrder.append(c)
+        g.shaMap[c.sha] = c
+
+    for c in g.topoOrder:
+        g.fixParents(c)
+
+    g.topoOrder.reverse()
+
+#    print 'topoOrder:'
+#    for c in topoOrder:
+#        print str(c) + ' sha: ' + c.sha
+#        print 'parents: ' + str(c.parents)
+            
+    i = 0
+    for c in g.topoOrder:
+        c.index = i
+        i += 1
+        for p in c.parents:
+#            print 'p: ' + str(p) + ' c: ' + str(c)
+            p.children.append(c)
+    return g
+
+# Write the empty tree to the object database and return its SHA1
+def writeEmptyTree():
+    try:
+        os.unlink(os.environ['GIT_DIR'] + '/index')
+    except OSError:
+        pass
+    return runProgram(['git-write-tree']).rstrip()
+
+# Given a Graph of commit objects and two heads (which also are commit
+# objects), h1 and h2, this function computes the Minimal Most Common
+# Ancestor of h1 and h2.
+def mmca(graph, h1, h2):
+    h = []
+    heappush(h, h1)
+    heappush(h, h2)
+
+    roots = []
+    while(len(h) > 0):
+#        print 'heap: '
+#        for x in h:
+#            print str(x), x.index
+        if len(h) == 1 and len(roots) == 0:
+            break
+        
+        el = heappop(h)
+
+        if len(el.parents) == 0:
+            roots.append(el)
+
+        for p in el.parents:
+            if not p in h:
+                heappush(h, p)
+
+    if len(roots) > 0:
+        superRoot = Commit(sha=None, parents=[], tree=writeEmptyTree(), author='author',
+                           committer='committer', msg='empty tree commit')
+        graph.addNode(superRoot)
+        for r in roots:
+            r.parents = [superRoot]
+        superRoot.children = roots
+        return superRoot
+    else:
+        return h[0]
+
+def findShared(mmca, h1, h2):
+    def traverse(start, end, set):
+        stack = [start]
+        while len(stack) > 0:
+            el = stack.pop()
+            set.add(el)
+            if start != end:
+                for p in el.parents:
+                    if p not in set:
+                        stack.append(p)
+    h1Set = Set()
+    h2Set = Set()
+    traverse(h1, mmca, h1Set)
+    traverse(h2, mmca, h2Set)
+
+    return h1Set.intersection(h2Set)
+
+def sharedHeads(mmca, shared):
+    h = Set()
+    searched = Set()
+    stack = [mmca]
+    while len(stack) > 0:
+        el = stack.pop()
+        searched.add(el)
+        if len([c for c in el.children if c in shared]) == 0:
+            h.add(el)
+
+        for c in el.children:
+            if c in shared and c not in searched:
+                stack.append(c)
+
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
+    print '\n' + '  '*indent, 'Merging:'
+    print '  '*indent, h1
+    print '  '*indent, h2
+    assert(isinstance(h1, Commit) and isinstance(h2, Commit))
+    assert(isinstance(graph, Graph))
+
+    a = mmca(graph, h1, h2)
+    print '  '*indent, 'mmca:', a
+    s = findShared(a, h1, h2)
+    print '  '*indent, 'found', len(s), 'shared commits.'
+    if len(s) < 10:
+        for x in s:
+            print '  '*indent, x
+    sys.stdout.flush()
+    s = sharedHeads(a, s)
+    print '  '*indent, 'found', len(s), 'shared head(s):'
+    for x in s :
+        print '  '*indent, x
+    Ms = s[0]
+
+    for h in s[1:]:
+        Ms = merge(Ms, h, branch1Name, branch2Name, graph, indent+1, False)
+
+    filesDirs = getFilesAndDirs(h1.tree(), h2.tree())
+    
+    print '  '*indent, 'running resolve on'
+    print '  '*indent, h1
+    print '  '*indent, h2
+
+    if first:
+        b1 = branch1Name
+        b2 = branch2Name
+    else:
+        b1 = 'Temporary shared merge branch 1'
+        b2 = 'Temporary shared merge branch 2'
+    shaRes = resolve(h1.tree(), h2.tree(), Ms.tree(), b1, b2, filesDirs)
+
+    res = Commit(None, [h1, h2], tree=shaRes, msg='Temporary merge commit')
+    graph.addNode(res)
+    res.writeObject()
+    print '  '*indent, 'merge returned: (tree)',  res.tree(), '(commit)', res.sha
+    return res
+
+shaRE = re.compile('^[0-9a-f]{40}$')
+def isSha(obj):
+    return type(obj) is str and bool(shaRE.match(obj))
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
+            [out, code] = runProgram(['git-merge-cache', '-o',
+                                      'git-new-merge-one-file.py', '-a'],
+                                     returnCode=True)
+            
+            print out
+            if code != 0:
+                # Shouldn't happen...
+                print 'Fatal error: merge program failed.'
+                print out
+                sys.exit(1)
+            else:
+                return runProgram('git-write-tree').rstrip()
+        else:
+            return tree
+    finally:
+        fdirs.close()
diff --git a/merge.py b/merge.py
new file mode 100755
--- /dev/null
+++ b/merge.py
@@ -0,0 +1,39 @@
+#!/usr/bin/env python
+
+from gitMergeCommon import *
+from gitMergeCore import buildGraph, merge
+import sys
+
+if len(sys.argv) < 1:
+    print 'Usage:', sys.argv[0], '<branch>'
+    sys.exit(1)
+
+setupEnvironment()
+repoValid()
+
+h1 = firstBranch = 'HEAD'
+h2 = secondBranch = sys.argv[1]
+
+print 'h1: ' + h1 + ' h2: ' + h2
+h1 = runProgram(['git-rev-parse', '--revs-only', h1]).rstrip()
+h2 = runProgram(['git-rev-parse', '--revs-only', h2]).rstrip()
+print 'Resolved heads: h1: ' + h1 + ' h2: ' + h2
+
+print 'Building graph...'
+graph = buildGraph([h1, h2])
+print 'graph done.'
+
+res = merge(graph.shaMap[h1], graph.shaMap[h2], firstBranch, secondBranch, graph)
+print 'Merge result: (tree) ' + res.tree() + ' (commit) ' + res.sha
+
+# Checkout the merge results
+runProgram(['git-read-tree', 'HEAD'])
+runProgram(['git-update-cache', '--refresh'])
+runProgram(['git-read-tree', '-m', '-u', 'HEAD', res.tree()])
+
+try:
+    fout = open(os.environ['GIT_DIR'] + '/MERGE_HEAD', 'w+')
+    fout.write(h2 + '\n')
+    fout.close()
+except OSError, e:
+    print 'Failed to open', os.environ['GIT_DIR'] + '/MERGE_HEAD', '!'
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
