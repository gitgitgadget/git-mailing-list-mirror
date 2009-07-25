From: Pete Wyckoff <pw@padd.com>
Subject: [PATCH 2/5] git-p4 stream: do not pass branchPrefixes so much
Date: Sat, 25 Jul 2009 10:24:16 -0400
Message-ID: <20090725142416.GC3841@arf.padd.com>
References: <1247301071-9541-1-git-send-email-luke@diamand.org> <20090725142329.GA3841@arf.padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Luke Diamand <luke@diamand.org>
X-From: git-owner@vger.kernel.org Sat Jul 25 16:33:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MUiJI-0007D8-RX
	for gcvg-git-2@gmane.org; Sat, 25 Jul 2009 16:33:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751717AbZGYOdL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Jul 2009 10:33:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751768AbZGYOdI
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Jul 2009 10:33:08 -0400
Received: from marge.padd.com ([99.188.165.110]:39110 "EHLO marge.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751706AbZGYOdE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Jul 2009 10:33:04 -0400
Received: from arf.padd.com (pool-71-111-229-253.rlghnc.dsl-w.verizon.net [71.111.229.253])
	by marge.padd.com (Postfix) with ESMTPSA id EE650121A75C;
	Sat, 25 Jul 2009 07:24:19 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 8AA863E40FE; Sat, 25 Jul 2009 10:24:16 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20090725142329.GA3841@arf.padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/124012>

Just set it in self when commit starts and use it everywhere.
This makes the code a bit cleaner, but no functional change

Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 contrib/fast-import/git-p4 |   19 ++++++++++---------
 1 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
index 70fa403..3a52254 100755
--- a/contrib/fast-import/git-p4
+++ b/contrib/fast-import/git-p4
@@ -953,11 +953,11 @@ class P4Sync(Command):
     # output one file from the P4 stream
     # - helper for streamP4Files
 
-    def streamOneP4File(self, file, contents, branchPrefixes):
+    def streamOneP4File(self, file, contents):
         if verbose:
             sys.stderr.write("%s\n" %  file["depotFile"])
 
-        relPath = self.stripRepoPath(file['depotFile'], branchPrefixes)
+        relPath = self.stripRepoPath(file['depotFile'], self.branchPrefixes)
 
         mode = "644"
         if isP4Exec(file["type"]):
@@ -993,16 +993,16 @@ class P4Sync(Command):
             self.gitStream.write(d)
         self.gitStream.write("\n")
 
-    def streamOneP4Deletion(self, file, branchPrefixes):
+    def streamOneP4Deletion(self, file):
         if verbose:
             sys.stderr.write("delete %s\n" %  file["path"])
 
-        relPath = self.stripRepoPath(file['path'], branchPrefixes)
+        relPath = self.stripRepoPath(file['path'], self.branchPrefixes)
 
         self.gitStream.write("D %s\n" % relPath)
 
     # Stream directly from "p4 files" into "git fast-import"
-    def streamP4Files(self, files, branchPrefixes):
+    def streamP4Files(self, files):
         filesForCommit = []
         filesToRead = []
         filesToDelete = []
@@ -1026,7 +1026,7 @@ class P4Sync(Command):
 
         # deleted files...
         for f in filesToDelete:
-            self.streamOneP4Deletion(f, branchPrefixes)
+            self.streamOneP4Deletion(f)
 
         if len(filesToRead) > 0:
             stdin_file = tempfile.TemporaryFile(prefix='p4-stdin', mode='w+b')
@@ -1058,7 +1058,7 @@ class P4Sync(Command):
                             continue
 
 
-                        self.streamOneP4File(file,contents,branchPrefixes)
+                        self.streamOneP4File(file, contents)
                         file = {}
                         contents = []
                         have_file_info = False
@@ -1078,7 +1078,7 @@ class P4Sync(Command):
             # do the last chunk
 
             if file.has_key('depotFile'):
-                self.streamOneP4File(file,contents,branchPrefixes)
+                self.streamOneP4File(file,contents)
 
             exitCode = p4.wait()
             if exitCode != 0:
@@ -1088,6 +1088,7 @@ class P4Sync(Command):
     def commit(self, details, files, branch, branchPrefixes, parent = ""):
         epoch = details["time"]
         author = details["user"]
+	self.branchPrefixes = branchPrefixes
 
         if self.verbose:
             print "commit into %s" % branch
@@ -1127,7 +1128,7 @@ class P4Sync(Command):
                 print "parent %s" % parent
             self.gitStream.write("from %s\n" % parent)
 
-        self.streamP4Files(new_files,branchPrefixes)
+        self.streamP4Files(new_files)
         self.gitStream.write("\n")
 
         change = int(details["change"])
-- 
1.6.2.5
