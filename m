From: Pete Wyckoff <pw@padd.com>
Subject: [PATCH 4/5] git p4: do wildcard decoding in stripRepoPath
Date: Sat, 11 Aug 2012 12:55:03 -0400
Message-ID: <1344704104-17727-4-git-send-email-pw@padd.com>
References: <20120811165143.GA2004@padd.com>
Cc: Matthew Korich <matthew@korich.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 11 18:56:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T0Ez0-0002a1-2b
	for gcvg-git-2@plane.gmane.org; Sat, 11 Aug 2012 18:56:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753326Ab2HKQ4K (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Aug 2012 12:56:10 -0400
Received: from honk.padd.com ([74.3.171.149]:50677 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752670Ab2HKQ4H (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Aug 2012 12:56:07 -0400
Received: from arf.padd.com (unknown [50.55.149.165])
	by honk.padd.com (Postfix) with ESMTPSA id 7EEA2D27;
	Sat, 11 Aug 2012 09:56:06 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 4124C5A90C; Sat, 11 Aug 2012 12:56:04 -0400 (EDT)
X-Mailer: git-send-email 1.7.11.2.329.ga84ed21
In-Reply-To: <20120811165143.GA2004@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203293>

Instead of having to remember to do it after each call to
stripRepoPath, make it part of that function.

Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 git-p4.py | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 6d07115..e20ff5d 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -1819,15 +1819,17 @@ class P4Sync(Command, P4UserMap):
 
     def stripRepoPath(self, path, prefixes):
         if self.useClientSpec:
-            return self.clientSpecDirs.map_in_client(path)
+            path = self.clientSpecDirs.map_in_client(path)
 
-        if self.keepRepoPath:
-            prefixes = [re.sub("^(//[^/]+/).*", r'\1', prefixes[0])]
+        else:
+            if self.keepRepoPath:
+                prefixes = [re.sub("^(//[^/]+/).*", r'\1', prefixes[0])]
 
-        for p in prefixes:
-            if p4PathStartsWith(path, p):
-                path = path[len(p):]
+            for p in prefixes:
+                if p4PathStartsWith(path, p):
+                    path = path[len(p):]
 
+        path = wildcard_decode(path)
         return path
 
     def splitFilesIntoBranches(self, commit):
@@ -1849,7 +1851,6 @@ class P4Sync(Command, P4UserMap):
             fnum = fnum + 1
 
             relPath = self.stripRepoPath(path, self.depotPaths)
-            relPath = wildcard_decode(relPath)
 
             for branch in self.knownBranches.keys():
 
@@ -1867,7 +1868,6 @@ class P4Sync(Command, P4UserMap):
 
     def streamOneP4File(self, file, contents):
         relPath = self.stripRepoPath(file['depotFile'], self.branchPrefixes)
-        relPath = wildcard_decode(relPath)
         if verbose:
             sys.stderr.write("%s\n" % relPath)
 
@@ -1936,7 +1936,6 @@ class P4Sync(Command, P4UserMap):
 
     def streamOneP4Deletion(self, file):
         relPath = self.stripRepoPath(file['path'], self.branchPrefixes)
-        relPath = wildcard_decode(relPath)
         if verbose:
             sys.stderr.write("delete %s\n" % relPath)
         self.gitStream.write("D %s\n" % relPath)
-- 
1.7.12.rc2.24.gc304662
