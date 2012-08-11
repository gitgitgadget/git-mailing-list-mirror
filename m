From: Pete Wyckoff <pw@padd.com>
Subject: [PATCH 3/5] git p4: set self.branchPrefixes in initialization
Date: Sat, 11 Aug 2012 12:55:02 -0400
Message-ID: <1344704104-17727-3-git-send-email-pw@padd.com>
References: <20120811165143.GA2004@padd.com>
Cc: Matthew Korich <matthew@korich.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 11 18:55:56 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T0Eye-0001p8-3q
	for gcvg-git-2@plane.gmane.org; Sat, 11 Aug 2012 18:55:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753320Ab2HKQzs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Aug 2012 12:55:48 -0400
Received: from honk.padd.com ([74.3.171.149]:50673 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752670Ab2HKQzr (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Aug 2012 12:55:47 -0400
Received: from arf.padd.com (unknown [50.55.149.165])
	by honk.padd.com (Postfix) with ESMTPSA id 76D82D27;
	Sat, 11 Aug 2012 09:55:46 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 377FE5A90C; Sat, 11 Aug 2012 12:55:44 -0400 (EDT)
X-Mailer: git-send-email 1.7.11.2.329.ga84ed21
In-Reply-To: <20120811165143.GA2004@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203292>

This instance variable is needed during commit() to map
files from p4 to their relative locations in git.  Set
it when initializing P4Sync to avoid passing it to every
commit() call.

Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 git-p4.py | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index e67d37d..6d07115 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -2041,10 +2041,9 @@ class P4Sync(Command, P4UserMap):
         gitStream.write(description)
         gitStream.write("\n")
 
-    def commit(self, details, files, branch, branchPrefixes, parent = ""):
+    def commit(self, details, files, branch, parent = ""):
         epoch = details["time"]
         author = details["user"]
-        self.branchPrefixes = branchPrefixes
 
         if self.verbose:
             print "commit into %s" % branch
@@ -2053,7 +2052,7 @@ class P4Sync(Command, P4UserMap):
         # create a commit.
         new_files = []
         for f in files:
-            if [p for p in branchPrefixes if p4PathStartsWith(f['path'], p)]:
+            if [p for p in self.branchPrefixes if p4PathStartsWith(f['path'], p)]:
                 new_files.append (f)
             else:
                 sys.stderr.write("Ignoring file outside of prefix: %s\n" % f['path'])
@@ -2070,8 +2069,8 @@ class P4Sync(Command, P4UserMap):
 
         self.gitStream.write("data <<EOT\n")
         self.gitStream.write(details["desc"])
-        self.gitStream.write("\n[git-p4: depot-paths = \"%s\": change = %s"
-                             % (','.join (branchPrefixes), details["change"]))
+        self.gitStream.write("\n[git-p4: depot-paths = \"%s\": change = %s" %
+                             (','.join(self.branchPrefixes), details["change"]))
         if len(details['options']) > 0:
             self.gitStream.write(": options = %s" % details['options'])
         self.gitStream.write("]\nEOT\n\n")
@@ -2094,7 +2093,7 @@ class P4Sync(Command, P4UserMap):
                 print "Change %s is labelled %s" % (change, labelDetails)
 
             files = p4CmdList(["files"] + ["%s...@%s" % (p, change)
-                                                    for p in branchPrefixes])
+                                                for p in self.branchPrefixes])
 
             if len(files) == len(labelRevisions):
 
@@ -2405,6 +2404,7 @@ class P4Sync(Command, P4UserMap):
                     for branch in branches.keys():
                         ## HACK  --hwn
                         branchPrefix = self.depotPaths[0] + branch + "/"
+                        self.branchPrefixes = [ branchPrefix ]
 
                         parent = ""
 
@@ -2449,19 +2449,19 @@ class P4Sync(Command, P4UserMap):
                             tempBranch = os.path.join(self.tempBranchLocation, "%d" % (change))
                             if self.verbose:
                                 print "Creating temporary branch: " + tempBranch
-                            self.commit(description, filesForCommit, tempBranch, [branchPrefix])
+                            self.commit(description, filesForCommit, tempBranch)
                             self.tempBranches.append(tempBranch)
                             self.checkpoint()
                             blob = self.searchParent(parent, branch, tempBranch)
                         if blob:
-                            self.commit(description, filesForCommit, branch, [branchPrefix], blob)
+                            self.commit(description, filesForCommit, branch, blob)
                         else:
                             if self.verbose:
                                 print "Parent of %s not found. Committing into head of %s" % (branch, parent)
-                            self.commit(description, filesForCommit, branch, [branchPrefix], parent)
+                            self.commit(description, filesForCommit, branch, parent)
                 else:
                     files = self.extractFilesFromCommit(description)
-                    self.commit(description, files, self.branch, self.depotPaths,
+                    self.commit(description, files, self.branch,
                                 self.initialParent)
                     self.initialParent = ""
             except IOError:
@@ -2525,7 +2525,7 @@ class P4Sync(Command, P4UserMap):
 
         self.updateOptionDict(details)
         try:
-            self.commit(details, self.extractFilesFromCommit(details), self.branch, self.depotPaths)
+            self.commit(details, self.extractFilesFromCommit(details), self.branch)
         except IOError:
             print "IO error with git fast-import. Is your git version recent enough?"
             print self.gitError.read()
@@ -2683,6 +2683,9 @@ class P4Sync(Command, P4UserMap):
 
         self.depotPaths = newPaths
 
+        # --detect-branches may change this for each branch
+        self.branchPrefixes = self.depotPaths
+
         self.loadUserMapFromCache()
         self.labels = {}
         if self.detectLabels:
-- 
1.7.12.rc2.24.gc304662
