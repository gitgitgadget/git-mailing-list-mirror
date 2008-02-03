From: Tommy Thorn <tommy-git@thorn.ws>
Subject: [PATCH 2/3] git-p4: support exclude paths
Date: Sun,  3 Feb 2008 01:21:05 -0800
Message-ID: <dd96ea0b47e8ec67ef14e4e954aa9ec7bec3c295.1202029604.git.tommy-git@thorn.ws>
References: <9439626e72a267ff29cb6eaa1c733ec4641341d9.1202029604.git.tommy-git@thorn.ws>
Cc: Tommy Thorn <tommy-git@thorn.ws>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Feb 03 11:03:55 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLbhZ-0001K7-5l
	for gcvg-git-2@gmane.org; Sun, 03 Feb 2008 11:03:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758452AbYBCKDD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Feb 2008 05:03:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760493AbYBCKDC
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Feb 2008 05:03:02 -0500
Received: from server204.webhostingpad.com ([69.65.0.218]:60868 "EHLO
	server204.webhostingpad.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1758301AbYBCKDA (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 3 Feb 2008 05:03:00 -0500
Received: from 208.65.183.75.static.etheric.net ([208.65.183.75] helo=localhost.localdomain)
	by server204.webhostingpad.com with esmtpa (Exim 4.68)
	(envelope-from <tommy-git@thorn.ws>)
	id 1JLb2C-0006wh-3Z; Sun, 03 Feb 2008 03:21:08 -0600
X-Mailer: git-send-email 1.5.4.rc5.17.g22b645
In-Reply-To: <9439626e72a267ff29cb6eaa1c733ec4641341d9.1202029604.git.tommy-git@thorn.ws>
In-Reply-To: <9439626e72a267ff29cb6eaa1c733ec4641341d9.1202029604.git.tommy-git@thorn.ws>
References: <9439626e72a267ff29cb6eaa1c733ec4641341d9.1202029604.git.tommy-git@thorn.ws>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - server204.webhostingpad.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - thorn.ws
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72343>

Teach git-p4 about the -/ option which adds depot paths to the exclude
list, used when cloning. The option is chosen such that the natural
Perforce syntax works, eg:

  git p4 clone //branch/path/... -//branch/path/{large,old}/...

Trailing ... on exclude paths are optional.

This is a generalization of a change by Dmitry Kakurin (thanks).

Signed-off-by: Tommy Thorn <tommy-git@thorn.ws>
---
 contrib/fast-import/git-p4 |   26 ++++++++++++++++++++++----
 1 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
index 553e237..2340876 100755
--- a/contrib/fast-import/git-p4
+++ b/contrib/fast-import/git-p4
@@ -876,18 +876,25 @@ class P4Sync(Command):
         self.keepRepoPath = False
         self.depotPaths = None
         self.p4BranchesInGit = []
+        self.cloneExclude = []
 
         if gitConfig("git-p4.syncFromOrigin") == "false":
             self.syncWithOrigin = False
 
     def extractFilesFromCommit(self, commit):
+        self.cloneExclude = [re.sub(r"\.\.\.$", "", path)
+                             for path in self.cloneExclude]
         files = []
         fnum = 0
         while commit.has_key("depotFile%s" % fnum):
             path =  commit["depotFile%s" % fnum]
 
-            found = [p for p in self.depotPaths
-                     if path.startswith (p)]
+            if [p for p in self.cloneExclude
+                if path.startswith (p)]:
+                found = False
+            else:
+                found = [p for p in self.depotPaths
+                         if path.startswith (p)]
             if not found:
                 fnum = fnum + 1
                 continue
@@ -1658,13 +1665,23 @@ class P4Clone(P4Sync):
         P4Sync.__init__(self)
         self.description = "Creates a new git repository and imports from Perforce into it"
         self.usage = "usage: %prog [options] //depot/path[@revRange]"
-        self.options.append(
+        self.options += [
             optparse.make_option("--destination", dest="cloneDestination",
                                  action='store', default=None,
-                                 help="where to leave result of the clone"))
+                                 help="where to leave result of the clone"),
+            optparse.make_option("-/", dest="cloneExclude",
+                                 action="append", type="string",
+                                 help="exclude depot path")
+        ]
         self.cloneDestination = None
         self.needsGit = False
 
+    # This is required for the "append" cloneExclude action
+    def ensure_value(self, attr, value):
+        if not hasattr(self, attr) or getattr(self, attr) is None:
+            setattr(self, attr, value)
+        return getattr(self, attr)
+
     def defaultDestination(self, args):
         ## TODO: use common prefix of args?
         depotPath = args[0]
@@ -1688,6 +1705,7 @@ class P4Clone(P4Sync):
             self.cloneDestination = depotPaths[-1]
             depotPaths = depotPaths[:-1]
 
+        self.cloneExclude = ["/"+p for p in self.cloneExclude]
         for p in depotPaths:
             if not p.startswith("//"):
                 return False
-- 
1.5.4.rc5.17.g22b645
