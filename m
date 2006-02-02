From: Fredrik Kuivinen <freku045@student.liu.se>
Subject: [PATCH 1/2] merge-recursive: Make use of provided bases
Date: Thu, 2 Feb 2006 12:43:20 +0100
Message-ID: <20060202114320.GB8103@c165.ib.student.liu.se>
References: <20060202113848.GA8103@c165.ib.student.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: junkio@cox.net
X-From: git-owner@vger.kernel.org Thu Feb 02 12:43:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F4cs0-0000zK-Ha
	for gcvg-git@gmane.org; Thu, 02 Feb 2006 12:43:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750897AbWBBLnW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Feb 2006 06:43:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750879AbWBBLnW
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Feb 2006 06:43:22 -0500
Received: from [85.8.31.11] ([85.8.31.11]:64421 "EHLO mail6.wasadata.com")
	by vger.kernel.org with ESMTP id S1750758AbWBBLnV (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Feb 2006 06:43:21 -0500
Received: from c165 (unknown [85.8.2.189])
	by mail6.wasadata.com (Postfix) with ESMTP
	id B45344114; Thu,  2 Feb 2006 12:56:49 +0100 (CET)
Received: from ksorim by c165 with local (Exim 3.36 #1 (Debian))
	id 1F4crw-0007Xm-00; Thu, 02 Feb 2006 12:43:20 +0100
To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20060202113848.GA8103@c165.ib.student.liu.se>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15503>

This makes some cases faster as we don't have to build the commit graph.

Signed-off-by: Fredrik Kuivinen <freku045@student.liu.se>


---

 git-merge-recursive.py |   31 +++++++++++++++++++++----------
 1 files changed, 21 insertions(+), 10 deletions(-)

c78eacd112489b264df5d176df287f7ff5696948
diff --git a/git-merge-recursive.py b/git-merge-recursive.py
index b17c8e5..ce8a31f 100755
--- a/git-merge-recursive.py
+++ b/git-merge-recursive.py
@@ -45,11 +45,10 @@ cacheOnly = False
 # The entry point to the merge code
 # ---------------------------------
 
-def merge(h1, h2, branch1Name, branch2Name, graph, callDepth=0):
+def merge(h1, h2, branch1Name, branch2Name, graph, callDepth=0, ancestor=None):
     '''Merge the commits h1 and h2, return the resulting virtual
     commit object and a flag indicating the cleaness of the merge.'''
     assert(isinstance(h1, Commit) and isinstance(h2, Commit))
-    assert(isinstance(graph, Graph))
 
     global outputIndent
 
@@ -58,7 +57,11 @@ def merge(h1, h2, branch1Name, branch2Na
     output(h2)
     sys.stdout.flush()
 
-    ca = getCommonAncestors(graph, h1, h2)
+    if ancestor:
+        ca = [ancestor]
+    else:
+        assert(isinstance(graph, Graph))
+        ca = getCommonAncestors(graph, h1, h2)
     output('found', len(ca), 'common ancestor(s):')
     for x in ca:
         output(x)
@@ -86,7 +89,7 @@ def merge(h1, h2, branch1Name, branch2Na
     [shaRes, clean] = mergeTrees(h1.tree(), h2.tree(), mergedCA.tree(),
                                  branch1Name, branch2Name)
 
-    if clean or cacheOnly:
+    if graph and (clean or cacheOnly):
         res = Commit(None, [h1, h2], tree=shaRes)
         graph.addNode(res)
     else:
@@ -891,12 +894,11 @@ def usage():
 
 # main entry point as merge strategy module
 # The first parameters up to -- are merge bases, and the rest are heads.
-# This strategy module figures out merge bases itself, so we only
-# get heads.
 
 if len(sys.argv) < 4:
     usage()
 
+bases = []
 for nextArg in xrange(1, len(sys.argv)):
     if sys.argv[nextArg] == '--':
         if len(sys.argv) != nextArg + 3:
@@ -907,6 +909,8 @@ for nextArg in xrange(1, len(sys.argv)):
         except IndexError:
             usage()
         break
+    else:
+        bases.append(sys.argv[nextArg])
 
 print 'Merging', h1, 'with', h2
 
@@ -914,10 +918,17 @@ try:
     h1 = runProgram(['git-rev-parse', '--verify', h1 + '^0']).rstrip()
     h2 = runProgram(['git-rev-parse', '--verify', h2 + '^0']).rstrip()
 
-    graph = buildGraph([h1, h2])
-
-    [dummy, clean] = merge(graph.shaMap[h1], graph.shaMap[h2],
-                           firstBranch, secondBranch, graph)
+    if len(bases) == 1:
+        base = runProgram(['git-rev-parse', '--verify',
+                           bases[0] + '^0']).rstrip()
+        ancestor = Commit(base, None)
+        [dummy, clean] = merge(Commit(h1, None), Commit(h2, None),
+                               firstBranch, secondBranch, None, 0,
+                               ancestor)
+    else:
+        graph = buildGraph([h1, h2])
+        [dummy, clean] = merge(graph.shaMap[h1], graph.shaMap[h2],
+                               firstBranch, secondBranch, graph)
 
     print ''
 except:
-- 
1.1.6.gc78e-dirty
