From: Sam Hocevar <sam@hocevar.net>
Subject: [PATCH 2/2] git-p4: reduce number of server queries for fetches
Date: Sat, 5 Dec 2015 12:22:22 +0100
Message-ID: <20151205112222.GA15873@hocevar.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Luke Diamand <luke@diamand.org>, Pete Wyckoff <pw@padd.com>,
	Lars Schneider <larsxschneider@gmail.com>
To: Git Users <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Dec 05 12:28:00 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a5B0P-0003S7-OA
	for gcvg-git-2@plane.gmane.org; Sat, 05 Dec 2015 12:27:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753751AbbLEL1b (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Dec 2015 06:27:31 -0500
Received: from poulet.zoy.org ([193.200.42.166]:38455 "EHLO smtp.zoy.org"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753216AbbLEL1b (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Dec 2015 06:27:31 -0500
X-Greylist: delayed 316 seconds by postgrey-1.27 at vger.kernel.org; Sat, 05 Dec 2015 06:27:30 EST
Received: from w00t.w00t (localhost [IPv6:::1])
	by smtp.zoy.org (Postfix) with ESMTP id 1866C36125E;
	Sat,  5 Dec 2015 12:22:25 +0100 (CET)
Received: by w00t.w00t (Postfix, from userid 1000)
	id B614E21AF6; Sat,  5 Dec 2015 12:22:22 +0100 (CET)
Content-Disposition: inline
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Virus-Scanned: clamav-milter 0.98.7 at poulet
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/282032>

When fetching changes from a depot using a full client spec, there
is no need to perform as many queries as there are top-level paths
in the client spec.  Instead we query all changes in chronological
order, also getting rid of the need to sort the results and remove
duplicates.

Signed-off-by: Sam Hocevar <sam@hocevar.net>
---
 git-p4.py | 43 ++++++++++++++++++++-----------------------
 1 file changed, 20 insertions(+), 23 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 210f100..ea2bbb2 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -796,39 +796,36 @@ def p4ChangesForPaths(depotPaths, changeRange, requestedBlockSize):
                 die("cannot use --changes-block-size with non-numeric revisions")
             block_size = None
 
-    # Accumulate change numbers in a dictionary to avoid duplicates
-    changes = {}
+    changes = []
 
-    for p in depotPaths:
-        # Retrieve changes a block at a time, to prevent running
-        # into a MaxResults/MaxScanRows error from the server.
+    # Retrieve changes a block at a time, to prevent running
+    # into a MaxResults/MaxScanRows error from the server.
 
-        while True:
-            cmd = ['changes']
+    while True:
+        cmd = ['changes']
 
-            if block_size:
-                end = min(changeEnd, changeStart + block_size)
-                revisionRange = "%d,%d" % (changeStart, end)
-            else:
-                revisionRange = "%s,%s" % (changeStart, changeEnd)
+        if block_size:
+            end = min(changeEnd, changeStart + block_size)
+            revisionRange = "%d,%d" % (changeStart, end)
+        else:
+            revisionRange = "%s,%s" % (changeStart, changeEnd)
 
+        for p in depotPaths:
             cmd += ["%s...@%s" % (p, revisionRange)]
 
-            for line in p4_read_pipe_lines(cmd):
-                changeNum = int(line.split(" ")[1])
-                changes[changeNum] = True
+        # Insert changes in chronological order
+        for line in reversed(p4_read_pipe_lines(cmd)):
+            changes.append(int(line.split(" ")[1]))
 
-            if not block_size:
-                break
+        if not block_size:
+            break
 
-            if end >= changeEnd:
-                break
+        if end >= changeEnd:
+            break
 
-            changeStart = end + 1
+        changeStart = end + 1
 
-    changelist = changes.keys()
-    changelist.sort()
-    return changelist
+    return changes
 
 def p4PathStartsWith(path, prefix):
     # This method tries to remedy a potential mixed-case issue:
-- 
2.6.2
