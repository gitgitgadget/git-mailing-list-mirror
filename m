From: Simon Hausmann <simon@lst.de>
Subject: [PATCH] git-p4: Make 'git-p4 branches' work after an initial clone with git clone from an origin-updated repository.
Date: Fri, 24 Aug 2007 17:44:16 +0200
Message-ID: <200708241744.19063.simon@lst.de>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 24 17:41:36 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IObHy-0002Wp-PK
	for gcvg-git@gmane.org; Fri, 24 Aug 2007 17:41:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752261AbXHXPla (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Aug 2007 11:41:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751759AbXHXPla
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Aug 2007 11:41:30 -0400
Received: from esparsett.troll.no ([62.70.27.18]:44354 "EHLO
	esparsett.troll.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751079AbXHXPl3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Aug 2007 11:41:29 -0400
Received: from esparsett.troll.no (localhost [127.0.0.1])
	by localhost (Postfix) with SMTP
	id 2D537741C5; Fri, 24 Aug 2007 17:41:27 +0200 (CEST)
Received: from rhea.troll.no (rhea.troll.no [10.3.4.5])
	by esparsett.troll.no (Postfix) with ESMTP
	id 190EF741BC; Fri, 24 Aug 2007 17:41:27 +0200 (CEST)
X-Length: 6880
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56577>

After a clone with "git clone" of a repository the p4 branches are only in remotes/origin/p4/* and not in remotes/p4/*.
Separate the code for detection and creation out of the P4Sync command class into standalone methods and use them
from the P4Branches command.

Signed-off-by: Simon Hausmann <simon@lst.de>
---
 contrib/fast-import/git-p4 |  104 +++++++++++++++++++++++---------------------
 1 files changed, 55 insertions(+), 49 deletions(-)

diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
index 6d01062..b571e30 100755
--- a/contrib/fast-import/git-p4
+++ b/contrib/fast-import/git-p4
@@ -231,6 +231,56 @@ def findUpstreamBranchPoint(head = "HEAD"):
 
     return ["", settings]
 
+def createOrUpdateBranchesFromOrigin(localRefPrefix = "refs/remotes/p4/", silent=True):
+    if not silent:
+        print ("Creating/updating branch(es) in %s based on origin branch(es)"
+               % localRefPrefix)
+
+    originPrefix = "origin/p4/"
+
+    for line in read_pipe_lines("git rev-parse --symbolic --remotes"):
+        line = line.strip()
+        if (not line.startswith(originPrefix)) or line.endswith("HEAD"):
+            continue
+
+        headName = line[len(originPrefix):]
+        remoteHead = localRefPrefix + headName
+        originHead = line
+
+        original = extractSettingsGitLog(extractLogMessageFromGitCommit(originHead))
+        if (not original.has_key('depot-paths')
+            or not original.has_key('change')):
+            continue
+
+        update = False
+        if not gitBranchExists(remoteHead):
+            if verbose:
+                print "creating %s" % remoteHead
+            update = True
+        else:
+            settings = extractSettingsGitLog(extractLogMessageFromGitCommit(remoteHead))
+            if settings.has_key('change') > 0:
+                if settings['depot-paths'] == original['depot-paths']:
+                    originP4Change = int(original['change'])
+                    p4Change = int(settings['change'])
+                    if originP4Change > p4Change:
+                        print ("%s (%s) is newer than %s (%s). "
+                               "Updating p4 branch from origin."
+                               % (originHead, originP4Change,
+                                  remoteHead, p4Change))
+                        update = True
+                else:
+                    print ("Ignoring: %s was imported from %s while "
+                           "%s was imported from %s"
+                           % (originHead, ','.join(original['depot-paths']),
+                              remoteHead, ','.join(settings['depot-paths'])))
+
+        if update:
+            system("git update-ref %s %s" % (remoteHead, originHead))
+
+def originP4BranchesExist():
+        return gitBranchExists("origin") or gitBranchExists("origin/p4") or gitBranchExists("origin/p4/master")
+
 class Command:
     def __init__(self):
         self.usage = "usage: %prog [options]"
@@ -1041,53 +1091,6 @@ class P4Sync(Command):
         for branch in branches.keys():
             self.initialParents[self.refPrefix + branch] = branches[branch]
 
-    def createOrUpdateBranchesFromOrigin(self):
-        if not self.silent:
-            print ("Creating/updating branch(es) in %s based on origin branch(es)"
-                   % self.refPrefix)
-
-        originPrefix = "origin/p4/"
-
-        for line in read_pipe_lines("git rev-parse --symbolic --remotes"):
-            line = line.strip()
-            if (not line.startswith(originPrefix)) or line.endswith("HEAD"):
-                continue
-
-            headName = line[len(originPrefix):]
-            remoteHead = self.refPrefix + headName
-            originHead = line
-
-            original = extractSettingsGitLog(extractLogMessageFromGitCommit(originHead))
-            if (not original.has_key('depot-paths')
-                or not original.has_key('change')):
-                continue
-
-            update = False
-            if not gitBranchExists(remoteHead):
-                if self.verbose:
-                    print "creating %s" % remoteHead
-                update = True
-            else:
-                settings = extractSettingsGitLog(extractLogMessageFromGitCommit(remoteHead))
-                if settings.has_key('change') > 0:
-                    if settings['depot-paths'] == original['depot-paths']:
-                        originP4Change = int(original['change'])
-                        p4Change = int(settings['change'])
-                        if originP4Change > p4Change:
-                            print ("%s (%s) is newer than %s (%s). "
-                                   "Updating p4 branch from origin."
-                                   % (originHead, originP4Change,
-                                      remoteHead, p4Change))
-                            update = True
-                    else:
-                        print ("Ignoring: %s was imported from %s while "
-                               "%s was imported from %s"
-                               % (originHead, ','.join(original['depot-paths']),
-                                  remoteHead, ','.join(settings['depot-paths'])))
-
-            if update:
-                system("git update-ref %s %s" % (remoteHead, originHead))
-
     def updateOptionDict(self, d):
         option_keys = {}
         if self.keepRepoPath:
@@ -1108,7 +1111,7 @@ class P4Sync(Command):
         # map from branch depot path to parent branch
         self.knownBranches = {}
         self.initialParents = {}
-        self.hasOrigin = gitBranchExists("origin") or gitBranchExists("origin/p4") or gitBranchExists("origin/p4/master")
+        self.hasOrigin = originP4BranchesExist()
         if not self.syncWithOrigin:
             self.hasOrigin = False
 
@@ -1135,7 +1138,7 @@ class P4Sync(Command):
         # merge with previous imports, if possible.
         if args == []:
             if self.hasOrigin:
-                self.createOrUpdateBranchesFromOrigin()
+                createOrUpdateBranchesFromOrigin(self.refPrefix, self.silent)
             self.listExistingP4GitBranches()
 
             if len(self.p4BranchesInGit) > 1:
@@ -1518,6 +1521,9 @@ class P4Branches(Command):
         self.verbose = False
 
     def run(self, args):
+        if originP4BranchesExist():
+            createOrUpdateBranchesFromOrigin()
+
         cmdline = "git rev-parse --symbolic "
         cmdline += " --remotes"
 
-- 
1.5.3.rc6.1.ge31f
