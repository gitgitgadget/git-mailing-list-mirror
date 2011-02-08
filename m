From: Tor Arvid Lund <torarvid@gmail.com>
Subject: [PATCH] Teach git-p4 to ignore case in perforce filenames if configured.
Date: Tue,  8 Feb 2011 12:11:39 +0100
Message-ID: <1297163499-18776-1-git-send-email-torarvid@gmail.com>
Cc: Tor Arvid Lund <torarvid@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 08 13:34:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pmmlm-00046K-L7
	for gcvg-git-2@lo.gmane.org; Tue, 08 Feb 2011 13:34:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753568Ab1BHMeD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Feb 2011 07:34:03 -0500
Received: from smtp2.powertech.no ([195.159.0.177]:40184 "EHLO
	smtp3.powertech.no" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751113Ab1BHMeC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Feb 2011 07:34:02 -0500
X-Greylist: delayed 1109 seconds by postgrey-1.27 at vger.kernel.org; Tue, 08 Feb 2011 07:34:02 EST
Received: from exchange.qsystems.no (unknown [77.40.144.122])
	by smtp3.powertech.no (Postfix) with ESMTP id E2BC747BCC7;
	Tue,  8 Feb 2011 13:15:29 +0100 (CET)
Received: from pingvin1 ([192.168.223.6]) by exchange.qsystems.no with Microsoft SMTPSVC(6.0.3790.4675);
	 Tue, 8 Feb 2011 13:15:29 +0100
Received: by pingvin1 (Postfix, from userid 1000)
	id 975CE58E83; Tue,  8 Feb 2011 13:15:29 +0100 (CET)
X-Mailer: git-send-email 1.7.3.1.68.g06779.dirty
X-OriginalArrivalTime: 08 Feb 2011 12:15:29.0740 (UTC) FILETIME=[E04730C0:01CBC789]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/166350>

When files are added to perforce, the path to that file has whichever case
configuration that exists on the machine of the user who added the file.
What does that mean? It means that when Alice adds a file

//depot/DirA/FileA.txt

... and Bob adds:

//depot/dirA/FileB.txt

... we may or may not get a problem. If a user sets the config variable
git-p4.ignorecase to "true", we will consider //depot/DirA and //depot/dirA
to be the same directory.
---
 contrib/fast-import/git-p4     |   22 ++++++++++++++--------
 contrib/fast-import/git-p4.txt |   12 ++++++++++++
 2 files changed, 26 insertions(+), 8 deletions(-)

diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
index 04ce7e3..ca3cea0 100755
--- a/contrib/fast-import/git-p4
+++ b/contrib/fast-import/git-p4
@@ -452,6 +452,12 @@ def p4ChangesForPaths(depotPaths, changeRange):
     changelist.sort()
     return changelist
 
+def p4PathStartsWith(path, prefix):
+    ignorecase = gitConfig("git-p4.ignorecase").lower()
+    if ignorecase in ["true", "yes", "1"]:
+        return path.lower().startswith(prefix.lower())
+    return path.startswith(prefix)
+
 class Command:
     def __init__(self):
         self.usage = "usage: %prog [options]"
@@ -599,7 +605,7 @@ class P4Submit(Command):
                     lastTab = path.rfind("\t")
                     if lastTab != -1:
                         path = path[:lastTab]
-                        if not path.startswith(self.depotPath):
+                        if not p4PathStartsWith(path, self.depotPath):
                             continue
                 else:
                     inFilesSection = False
@@ -891,11 +897,11 @@ class P4Sync(Command):
             path =  commit["depotFile%s" % fnum]
 
             if [p for p in self.cloneExclude
-                if path.startswith (p)]:
+                if p4PathStartsWith(path, p)]:
                 found = False
             else:
                 found = [p for p in self.depotPaths
-                         if path.startswith (p)]
+                         if p4PathStartsWith(path, p)]
             if not found:
                 fnum = fnum + 1
                 continue
@@ -914,7 +920,7 @@ class P4Sync(Command):
             prefixes = [re.sub("^(//[^/]+/).*", r'\1', prefixes[0])]
 
         for p in prefixes:
-            if path.startswith(p):
+            if p4PathStartsWith(path, p):
                 path = path[len(p):]
 
         return path
@@ -925,7 +931,7 @@ class P4Sync(Command):
         while commit.has_key("depotFile%s" % fnum):
             path =  commit["depotFile%s" % fnum]
             found = [p for p in self.depotPaths
-                     if path.startswith (p)]
+                     if p4PathStartsWith(path, p)]
             if not found:
                 fnum = fnum + 1
                 continue
@@ -1031,7 +1037,7 @@ class P4Sync(Command):
         for f in files:
             includeFile = True
             for val in self.clientSpecDirs:
-                if f['path'].startswith(val[0]):
+                if p4PathStartsWith(f['path'], val[0]):
                     if val[1] <= 0:
                         includeFile = False
                     break
@@ -1077,7 +1083,7 @@ class P4Sync(Command):
         # create a commit.
         new_files = []
         for f in files:
-            if [p for p in branchPrefixes if f['path'].startswith(p)]:
+            if [p for p in branchPrefixes if p4PathStartsWith(f['path'], p)]:
                 new_files.append (f)
             else:
                 sys.stderr.write("Ignoring file outside of prefix: %s\n" % path)
@@ -1241,7 +1247,7 @@ class P4Sync(Command):
                 source = paths[0]
                 destination = paths[1]
                 ## HACK
-                if source.startswith(self.depotPaths[0]) and destination.startswith(self.depotPaths[0]):
+                if p4PathStartsWith(source, self.depotPaths[0]) and p4PathStartsWith(destination, self.depotPaths[0]):
                     source = source[len(self.depotPaths[0]):-4]
                     destination = destination[len(self.depotPaths[0]):-4]
 
diff --git a/contrib/fast-import/git-p4.txt b/contrib/fast-import/git-p4.txt
index 49b3359..bf7904a 100644
--- a/contrib/fast-import/git-p4.txt
+++ b/contrib/fast-import/git-p4.txt
@@ -191,6 +191,18 @@ git-p4.useclientspec
 
   git config [--global] git-p4.useclientspec false
 
+git-p4.ignorecase
+
+If this variable is set to 'true' (or 'yes' or '1'), perforce paths like:
+
+//depot/Path/
+//depot/path/
+//dePoT/PATH/
+
+will all be considered to be the same directory.
+
+  git config [--global] git-p4.ignorecase false
+
 Implementation Details...
 =========================
 
-- 
1.7.3.1.68.g06779.dirty
