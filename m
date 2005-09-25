From: Fredrik Kuivinen <freku045@student.liu.se>
Subject: [PATCH] recursive-merge: Don't print a stack trace when read-tree fails.
Date: Sun, 25 Sep 2005 16:48:24 +0200
Message-ID: <20050925144824.GB20527@c165.ib.student.liu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 25 16:49:35 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EJXo2-00089S-VH
	for gcvg-git@gmane.org; Sun, 25 Sep 2005 16:48:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751469AbVIYOsd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Sep 2005 10:48:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751472AbVIYOsc
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Sep 2005 10:48:32 -0400
Received: from [85.8.31.11] ([85.8.31.11]:44202 "EHLO mail6.wasadata.com")
	by vger.kernel.org with ESMTP id S1751469AbVIYOsc (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 25 Sep 2005 10:48:32 -0400
Received: from c165 (unknown [85.8.2.189])
	by mail6.wasadata.com (Postfix) with ESMTP
	id 2BA304100; Sun, 25 Sep 2005 16:54:12 +0200 (CEST)
Received: from ksorim by c165 with local (Exim 3.36 #1 (Debian))
	id 1EJXnl-0007B6-00; Sun, 25 Sep 2005 16:48:25 +0200
To: junkio@cox.net
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040907i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9265>

If the working tree is dirty read-tree will fail, and we don't want an
ugly stack trace in that case. Also make sure we don't print stack
traces when we use 'die'.

Signed-off-by: Fredrik Kuivinen <freku045@student.liu.se>


---

 git-merge-recursive.py |   12 +++++++++---
 1 files changed, 9 insertions(+), 3 deletions(-)

5f47cf871d07317d42470f5fa261257e74b57f0e
diff --git a/git-merge-recursive.py b/git-merge-recursive.py
--- a/git-merge-recursive.py
+++ b/git-merge-recursive.py
@@ -149,7 +149,10 @@ def mergeTrees(head, merge, common, bran
     else:
         updateArg = '-u'
 
-    runProgram(['git-read-tree', updateArg, '-m', common, head, merge])
+    [out, code] = runProgram(['git-read-tree', updateArg, '-m', common, head, merge], returnCode = True)
+    if code != 0:
+        die('git-read-tree:', out)
+
     cleanMerge = True
 
     [tree, code] = runProgram('git-write-tree', returnCode=True)
@@ -430,8 +433,11 @@ try:
 
     print ''
 except:
-    traceback.print_exc(None, sys.stderr)
-    sys.exit(2)
+    if isinstance(sys.exc_info()[1], SystemExit):
+        raise
+    else:
+        traceback.print_exc(None, sys.stderr)
+        sys.exit(2)
 
 if clean:
     sys.exit(0)
