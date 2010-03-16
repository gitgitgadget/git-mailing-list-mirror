From: Benjamin C Meyer <bmeyer@rim.com>
Subject: [PATCH] Improve git-p4 to be able to submit patches back to perforce when the git repository is made up of multiple perforce directories.
Date: Tue, 16 Mar 2010 15:23:43 -0400
Message-ID: <1268767423-7431-1-git-send-email-bmeyer@rim.com>
Cc: simon.hausmann@nokia.com, Benjamin C Meyer <bmeyer@rim.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 16 20:23:55 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NrcMt-0001WY-0s
	for gcvg-git-2@lo.gmane.org; Tue, 16 Mar 2010 20:23:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752825Ab0CPTXs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Mar 2010 15:23:48 -0400
Received: from qmta09.westchester.pa.mail.comcast.net ([76.96.62.96]:55979
	"EHLO qmta09.westchester.pa.mail.comcast.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751136Ab0CPTXr (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Mar 2010 15:23:47 -0400
Received: from omta10.westchester.pa.mail.comcast.net ([76.96.62.28])
	by qmta09.westchester.pa.mail.comcast.net with comcast
	id ttku1d0020cZkys59vPnHu; Tue, 16 Mar 2010 19:23:47 +0000
Received: from localhost.localdomain ([71.192.50.29])
	by omta10.westchester.pa.mail.comcast.net with comcast
	id tvPn1d0050dnthT3WvPnwy; Tue, 16 Mar 2010 19:23:47 +0000
X-Mailer: git-send-email 1.6.3.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142347>

git-p4 lets you sync several perforce directories into the one git repository,
but when you would do a git perforce submit it was hardcoded to apply
the patches to whatever was the first directory in the list that
the repository was synced from which would usually fail.  When
multiple perforce directories are now present git-p4 will apply them
to the common root directory where the patches can successfully be applied.

For example if you synced these two directories from perforce in git

//depot/foo/bar,//depot/test

git-p4 will now lookup that the client paths are:

~/p4/foo/bar,~/p4/test

and then set self.clientPath to the root of all of the client paths
(~/p4) permitting the patches from git to be cleanly applied for all
of the directories.

Signed-off-by: Benjamin C Meyer <bmeyer@rim.com>
---
 contrib/fast-import/git-p4 |   40 +++++++++++++++++++++++++++++-----------
 1 files changed, 29 insertions(+), 11 deletions(-)

diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
index c1ea643..b4b509c 100755
--- a/contrib/fast-import/git-p4
+++ b/contrib/fast-import/git-p4
@@ -766,6 +766,21 @@ class P4Submit(Command):
                    + "Please review/edit and then use p4 submit -i < %s to submit directly!"
                    % (fileName, fileName))
 
+    def findCommonPath(self, settings):
+        dirs = []
+        for path in settings:
+            localDir = p4Where(path)
+            if len(localDir) > 0:
+                dirs.append(localDir)
+        localDir = dirs[0];
+        maxMatch = len(localDir) - 1
+        for dir in dirs:
+            if maxMatch > len(dir) - 1:
+                maxMatch = len(dir) - 1
+            while dir[maxMatch] != localDir[maxMatch]:
+                maxMatch = maxMatch - 1;
+        return localDir[0:maxMatch]
+
     def run(self, args):
         if len(args) == 0:
             self.master = currentGitBranch()
@@ -781,23 +796,26 @@ class P4Submit(Command):
             die("%s is not in git-p4.allowSubmit" % self.master)
 
         [upstream, settings] = findUpstreamBranchPoint()
-        self.depotPath = settings['depot-paths'][0]
+        if (len(settings['depot-paths']) > 0):
+            self.depotPath = ""
+            self.clientPath = self.findCommonPath(settings['depot-paths'])
+        else:
+            self.depotPath = settings['depot-paths'][0]
+            if len(self.depotPath) == 0:
+                print "Internal error: cannot locate perforce depot path from existing branches"
+                sys.exit(128)
+            self.clientPath = p4Where(self.depotPath)
+
+        if len(self.clientPath) == 0:
+            print "Error: Cannot locate perforce checkout of %s in client view" % self.depotPath
+            sys.exit(128)
+
         if len(self.origin) == 0:
             self.origin = upstream
 
         if self.verbose:
             print "Origin branch is " + self.origin
 
-        if len(self.depotPath) == 0:
-            print "Internal error: cannot locate perforce depot path from existing branches"
-            sys.exit(128)
-
-        self.clientPath = p4Where(self.depotPath)
-
-        if len(self.clientPath) == 0:
-            print "Error: Cannot locate perforce checkout of %s in client view" % self.depotPath
-            sys.exit(128)
-
         print "Perforce checkout for depot path %s located at %s" % (self.depotPath, self.clientPath)
         self.oldWorkingDirectory = os.getcwd()
 
-- 
1.6.3.3
