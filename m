From: Pete Wyckoff <pw@padd.com>
Subject: [PATCH 5/5] git p4: make branch detection work with --use-client-spec
Date: Sat, 11 Aug 2012 12:55:04 -0400
Message-ID: <1344704104-17727-5-git-send-email-pw@padd.com>
References: <20120811165143.GA2004@padd.com>
Cc: Matthew Korich <matthew@korich.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 11 18:56:33 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T0EzI-00038z-9u
	for gcvg-git-2@plane.gmane.org; Sat, 11 Aug 2012 18:56:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753343Ab2HKQ41 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Aug 2012 12:56:27 -0400
Received: from honk.padd.com ([74.3.171.149]:50679 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752670Ab2HKQ41 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Aug 2012 12:56:27 -0400
Received: from arf.padd.com (unknown [50.55.149.165])
	by honk.padd.com (Postfix) with ESMTPSA id 9494DD27;
	Sat, 11 Aug 2012 09:56:26 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 5807D5A90C; Sat, 11 Aug 2012 12:56:24 -0400 (EDT)
X-Mailer: git-send-email 1.7.11.2.329.ga84ed21
In-Reply-To: <20120811165143.GA2004@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203294>

The bug report in http://stackoverflow.com/questions/11893688
observes that files are mapped into the wrong locations in
git when both --use-client-spec and --branch-detection are enabled.

Fix this by changing the relative path prefix to match discovered
branches when using a client spec.

The problem was likely introduced with ecb7cf9 (git-p4: rewrite view
handling, 2012-01-02).

Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 git-p4.py                | 37 +++++++++++++++++++++++++++++++------
 t/t9801-git-p4-branch.sh |  2 +-
 2 files changed, 32 insertions(+), 7 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index e20ff5d..aed1a2d 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -1818,21 +1818,41 @@ class P4Sync(Command, P4UserMap):
         return files
 
     def stripRepoPath(self, path, prefixes):
+        """When streaming files, this is called to map a p4 depot path
+           to where it should go in git.  The prefixes are either
+           self.depotPaths, or self.branchPrefixes in the case of
+           branch detection."""
+
         if self.useClientSpec:
+            # branch detection moves files up a level (the branch name)
+            # from what client spec interpretation gives
             path = self.clientSpecDirs.map_in_client(path)
+            if self.detectBranches:
+                for b in self.knownBranches:
+                    if path.startswith(b + "/"):
+                        path = path[len(b)+1:]
+
+        elif self.keepRepoPath:
+            # Preserve everything in relative path name except leading
+            # //depot/; just look at first prefix as they all should
+            # be in the same depot.
+            depot = re.sub("^(//[^/]+/).*", r'\1', prefixes[0])
+            if p4PathStartsWith(path, depot):
+                path = path[len(depot):]
 
         else:
-            if self.keepRepoPath:
-                prefixes = [re.sub("^(//[^/]+/).*", r'\1', prefixes[0])]
-
             for p in prefixes:
                 if p4PathStartsWith(path, p):
                     path = path[len(p):]
+                    break
 
         path = wildcard_decode(path)
         return path
 
     def splitFilesIntoBranches(self, commit):
+        """Look at each depotFile in the commit to figure out to what
+           branch it belongs."""
+
         branches = {}
         fnum = 0
         while commit.has_key("depotFile%s" % fnum):
@@ -1850,11 +1870,16 @@ class P4Sync(Command, P4UserMap):
             file["type"] = commit["type%s" % fnum]
             fnum = fnum + 1
 
-            relPath = self.stripRepoPath(path, self.depotPaths)
+            # start with the full relative path where this file would
+            # go in a p4 client
+            if self.useClientSpec:
+                relPath = self.clientSpecDirs.map_in_client(path)
+            else:
+                relPath = self.stripRepoPath(path, self.depotPaths)
 
             for branch in self.knownBranches.keys():
-
-                # add a trailing slash so that a commit into qt/4.2foo doesn't end up in qt/4.2
+                # add a trailing slash so that a commit into qt/4.2foo
+                # doesn't end up in qt/4.2, e.g.
                 if relPath.startswith(branch + "/"):
                     if branch not in branches:
                         branches[branch] = []
diff --git a/t/t9801-git-p4-branch.sh b/t/t9801-git-p4-branch.sh
index ca3a7f9..c5f0977 100755
--- a/t/t9801-git-p4-branch.sh
+++ b/t/t9801-git-p4-branch.sh
@@ -438,7 +438,7 @@ test_expect_success 'use-client-spec detect-branches setup' '
 	)
 '
 
-test_expect_failure 'use-client-spec detect-branches files in top-level' '
+test_expect_success 'use-client-spec detect-branches files in top-level' '
 	test_when_finished cleanup_git &&
 	test_create_repo "$git" &&
 	(
-- 
1.7.12.rc2.24.gc304662
