From: Simon Hausmann <simon@lst.de>
Subject: [PATCH] git-p4: Fix import of changesets with file deletions
Date: Mon, 3 Mar 2008 11:55:48 +0100
Message-ID: <200803031155.51015.simon@lst.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Tor Arvid Lund <torarvid@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Mar 03 11:58:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JW8N1-0007BV-Ht
	for gcvg-git-2@gmane.org; Mon, 03 Mar 2008 11:58:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760506AbYCCK5A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2008 05:57:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753673AbYCCK47
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Mar 2008 05:56:59 -0500
Received: from verein.lst.de ([213.95.11.210]:38920 "EHLO verein.lst.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758357AbYCCK4b (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2008 05:56:31 -0500
Received: from rhea.troll.no (nat0.troll.no [62.70.27.100])
	(authenticated bits=0)
	by verein.lst.de (8.12.3/8.12.3/Debian-7.1) with ESMTP id m23AtvF3010098
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NO);
	Mon, 3 Mar 2008 11:55:57 +0100
User-Agent: KMail/1.9.9
Content-Disposition: inline
X-Spam-Score: 0 () 
X-Scanned-By: MIMEDefang 2.39
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75913>

Commit 3a70cdfa42199e16d2d047c286431c4274d65b1a made readP4Files abort quickly
when the changeset only contains files that are marked for deletion with an empty return
value, which caused the commit to not do anything.

This commit changes readP4Files to distinguish between files that need to be passed to p4
print and files that have no content ("deleted") and merge them in the returned
list.

Signed-off-by: Simon Hausmann <simon@lst.de>
---
 contrib/fast-import/git-p4 |   45 ++++++++++++++++++++++++-------------------
 1 files changed, 25 insertions(+), 20 deletions(-)

diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
index be96600..650ea34 100755
--- a/contrib/fast-import/git-p4
+++ b/contrib/fast-import/git-p4
@@ -850,29 +850,32 @@ class P4Sync(Command):
 
     ## Should move this out, doesn't use SELF.
     def readP4Files(self, files):
+        filesForCommit = []
+        filesToRead = []
+
         for f in files:
+            includeFile = True
             for val in self.clientSpecDirs:
                 if f['path'].startswith(val[0]):
-                    if val[1] > 0:
-                        f['include'] = True
-                    else:
-                        f['include'] = False
+                    if val[1] <= 0:
+                        includeFile = False
                     break
 
-        files = [f for f in files
-                 if f['action'] != 'delete' and
-                 (f.has_key('include') == False or f['include'] == True)]
+            if includeFile:
+                filesForCommit.append(f)
+                if f['action'] != 'delete':
+                    filesToRead.append(f)
 
-        if not files:
-            return []
+        filedata = []
+        if len(filesToRead) > 0:
+            filedata = p4CmdList('-x - print',
+                                 stdin='\n'.join(['%s#%s' % (f['path'], f['rev'])
+                                                  for f in filesToRead]),
+                                 stdin_mode='w+')
 
-        filedata = p4CmdList('-x - print',
-                             stdin='\n'.join(['%s#%s' % (f['path'], f['rev'])
-                                              for f in files]),
-                             stdin_mode='w+')
-        if "p4ExitCode" in filedata[0]:
-            die("Problems executing p4. Error: [%d]."
-                % (filedata[0]['p4ExitCode']));
+            if "p4ExitCode" in filedata[0]:
+                die("Problems executing p4. Error: [%d]."
+                    % (filedata[0]['p4ExitCode']));
 
         j = 0;
         contents = {}
@@ -896,10 +899,12 @@ class P4Sync(Command):
 
             contents[stat['depotFile']] = text
 
-        for f in files:
-            assert not f.has_key('data')
-            f['data'] = contents[f['path']]
-        return files
+        for f in filesForCommit:
+            path = f['path']
+            if contents.has_key(path):
+                f['data'] = contents[path]
+
+        return filesForCommit
 
     def commit(self, details, files, branch, branchPrefixes, parent = ""):
         epoch = details["time"]
-- 
1.5.4.3.325.g6d216

