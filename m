From: John Chapman <thestar@fussycoder.id.au>
Subject: [PATCH 1/2] Added support for purged files and also optimised memory usage.
Date: Sat,  8 Nov 2008 14:22:48 +1100
Message-ID: <1226114569-8506-1-git-send-email-thestar@fussycoder.id.au>
Cc: John Chapman <thestar@fussycoder.id.au>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 08 06:07:42 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kyg2t-00084B-5a
	for gcvg-git-2@gmane.org; Sat, 08 Nov 2008 06:07:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750765AbYKHFGY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Nov 2008 00:06:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750749AbYKHFGY
	(ORCPT <rfc822;git-outgoing>); Sat, 8 Nov 2008 00:06:24 -0500
Received: from nskntqsrv01p.mx.bigpond.com ([61.9.168.231]:21031 "EHLO
	nskntqsrv01p.mx.bigpond.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750718AbYKHFGX (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 8 Nov 2008 00:06:23 -0500
Received: from nskntotgx03p.mx.bigpond.com ([58.173.132.215])
          by nskntmtas01p.mx.bigpond.com with ESMTP
          id <20081108031222.NUFQ17256.nskntmtas01p.mx.bigpond.com@nskntotgx03p.mx.bigpond.com>;
          Sat, 8 Nov 2008 03:12:22 +0000
Received: from localhost.localdomain ([58.173.132.215])
          by nskntotgx03p.mx.bigpond.com with ESMTP
          id <20081108031217.BPMS12257.nskntotgx03p.mx.bigpond.com@localhost.localdomain>;
          Sat, 8 Nov 2008 03:12:17 +0000
X-Mailer: git-send-email 1.6.0.3.643.g233db
X-RPD-ScanID: Class unknown; VirusThreatLevel unknown, RefID str=0001.0A150205.49150392.003C,ss=1,fgs=0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100378>

Purged files are handled as if they are merely deleted, which is not
entirely optimal, but I don't know of any other way to handle them.
File data is deleted from memory as early as they can, and they are more
efficiently handled, at (significant) cost to CPU usage.

Still need to handle p4 branches with spaces in their names.
Still need to make git-p4 clone more reliable.
 - Perhaps with a --continue option. (Sometimes the p4 server kills
 the connection)

Signed-off-by: John Chapman <thestar@fussycoder.id.au>
---
 contrib/fast-import/git-p4 |   14 +++++++-------
 1 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
index 2216cac..38d1a17 100755
--- a/contrib/fast-import/git-p4
+++ b/contrib/fast-import/git-p4
@@ -946,7 +946,7 @@ class P4Sync(Command):
 
             if includeFile:
                 filesForCommit.append(f)
-                if f['action'] != 'delete':
+                if f['action'] not in ('delete', 'purge'):
                     filesToRead.append(f)
 
         filedata = []
@@ -965,11 +965,11 @@ class P4Sync(Command):
         while j < len(filedata):
             stat = filedata[j]
             j += 1
-            text = [];
+            text = ''
             while j < len(filedata) and filedata[j]['code'] in ('text', 'unicode', 'binary'):
-                text.append(filedata[j]['data'])
+                text += filedata[j]['data']
+                del filedata[j]['data']
                 j += 1
-            text = ''.join(text)
 
             if not stat.has_key('depotFile'):
                 sys.stderr.write("p4 print fails with: %s\n" % repr(stat))
@@ -1038,7 +1038,7 @@ class P4Sync(Command):
                 continue
 
             relPath = self.stripRepoPath(file['path'], branchPrefixes)
-            if file["action"] == "delete":
+            if file["action"] in ("delete", "purge"):
                 self.gitStream.write("D %s\n" % relPath)
             else:
                 data = file['data']
@@ -1077,7 +1077,7 @@ class P4Sync(Command):
 
                 cleanedFiles = {}
                 for info in files:
-                    if info["action"] == "delete":
+                    if info["action"] in ("delete", "purge"):
                         continue
                     cleanedFiles[info["depotFile"]] = info["rev"]
 
@@ -1400,7 +1400,7 @@ class P4Sync(Command):
             if change > newestRevision:
                 newestRevision = change
 
-            if info["action"] == "delete":
+            if info["action"] in ("delete", "purge"):
                 # don't increase the file cnt, otherwise details["depotFile123"] will have gaps!
                 #fileCnt = fileCnt + 1
                 continue
-- 
1.6.0.3.643.g233db
