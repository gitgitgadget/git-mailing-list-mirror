From: Fredrik Kuivinen <freku045@student.liu.se>
Subject: [PATCH 4/5] Use a temporary index file when we merge the common ancestors.
Date: Tue, 13 Sep 2005 23:41:16 +0200
Message-ID: <20050913214116.GE10953@c165.ib.student.liu.se>
References: <20050913213730.GA10953@c165.ib.student.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: junkio@cox.net
X-From: git-owner@vger.kernel.org Tue Sep 13 23:42:12 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EFIWm-0006ZE-ID
	for gcvg-git@gmane.org; Tue, 13 Sep 2005 23:41:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751034AbVIMVlS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Sep 2005 17:41:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751044AbVIMVlR
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Sep 2005 17:41:17 -0400
Received: from [85.8.31.11] ([85.8.31.11]:15495 "EHLO mail6.wasadata.com")
	by vger.kernel.org with ESMTP id S1751012AbVIMVlR (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 13 Sep 2005 17:41:17 -0400
Received: from c165 (unknown [85.8.2.189])
	by mail6.wasadata.com (Postfix) with ESMTP
	id DDA2C411B; Tue, 13 Sep 2005 23:46:20 +0200 (CEST)
Received: from ksorim by c165 with local (Exim 3.36 #1 (Debian))
	id 1EFIWi-0002uh-00; Tue, 13 Sep 2005 23:41:16 +0200
To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20050913213730.GA10953@c165.ib.student.liu.se>
User-Agent: Mutt/1.5.6+20040907i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8491>

With this change we can get rid of a call to 'git-update-index
--refresh'.

Signed-off-by: Fredrik Kuivinen <freku045@student.liu.se>


---

 git-merge-recursive.py |   23 ++++++++++++++++++-----
 1 files changed, 18 insertions(+), 5 deletions(-)

68a73c83a0ba2175cb366bddf3b851f824c6d598
diff --git a/git-merge-recursive.py b/git-merge-recursive.py
--- a/git-merge-recursive.py
+++ b/git-merge-recursive.py
@@ -10,6 +10,22 @@ from gitMergeCommon import *
 # The actual merge code
 # ---------------------
 
+originalIndexFile = os.environ.get('GIT_INDEX_FILE',
+                                   os.environ.get('GIT_DIR', '.git') + '/index')
+temporaryIndexFile = os.environ.get('GIT_DIR', '.git') + \
+                     '/merge-recursive-tmp-index'
+def setupIndex(temporary):
+    try:
+        os.unlink(temporaryIndexFile)
+    except OSError:
+        pass
+    if temporary:
+        newIndex = temporaryIndexFile
+        os.environ
+    else:
+        newIndex = originalIndexFile
+    os.environ['GIT_INDEX_FILE'] = newIndex
+
 def merge(h1, h2, branch1Name, branch2Name, graph, callDepth=0):
     '''Merge the commits h1 and h2, return the resulting virtual
     commit object and a flag indicating the cleaness of the merge.'''
@@ -39,13 +55,10 @@ def merge(h1, h2, branch1Name, branch2Na
         assert(isinstance(Ms, Commit))
 
     if callDepth == 0:
-        if len(ca) > 1:
-            runProgram(['git-read-tree', h1.tree()])
-            runProgram(['git-update-index', '-q', '--refresh'])
-        # Use the original index if we only have one common ancestor
-        
+        setupIndex(False)
         cleanCache = False
     else:
+        setupIndex(True)
         runProgram(['git-read-tree', h1.tree()])
         cleanCache = True
 
