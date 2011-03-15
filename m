From: Tor Arvid Lund <torarvid@gmail.com>
Subject: [PATCH 2/3] Teach git-p4 to ignore case in perforce filenames if
 configured.
Date: Tue, 15 Mar 2011 13:08:02 +0100
Message-ID: <1300190883-31833-2-git-send-email-torarvid@gmail.com>
References: <1300190883-31833-1-git-send-email-torarvid@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN
Content-Transfer-Encoding: 7BIT
Cc: Tor Arvid Lund <torarvid@gmail.com>
To: git@vger.kernel.org, Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Tue Mar 15 14:08:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PzTzH-0001Aw-Mr
	for gcvg-git-2@lo.gmane.org; Tue, 15 Mar 2011 14:08:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757732Ab1CONIV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Mar 2011 09:08:21 -0400
Received: from thalia-smout.broadpark.no ([80.202.8.21]:46152 "EHLO
	thalia-smout.broadpark.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757677Ab1CONIV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Mar 2011 09:08:21 -0400
Received: from terra-smin.broadpark.no ([80.202.8.13])
 by thalia-smout.broadpark.no
 (Sun Java(tm) System Messaging Server 7u3-15.01 64bit (built Feb 12 2010))
 with ESMTP id <0LI300DN5LPV7I40@thalia-smout.broadpark.no> for
 git@vger.kernel.org; Tue, 15 Mar 2011 13:08:19 +0100 (CET)
Received: from exchange.qsystems.no ([84.49.55.106]) by terra-smin.broadpark.no
 (Sun Java(tm) System Messaging Server 7u3-15.01 64bit (built Feb 12 2010))
 with ESMTP id <0LI30084ALPV4A50@terra-smin.broadpark.no> for
 git@vger.kernel.org; Tue, 15 Mar 2011 13:08:19 +0100 (CET)
Received: from pingvin1 ([192.168.223.6]) by exchange.qsystems.no with
 Microsoft SMTPSVC(6.0.3790.4675); Tue, 15 Mar 2011 13:08:19 +0100
Received: by pingvin1 (Postfix, from userid 1000)	id 6F04F240910; Tue,
 15 Mar 2011 13:08:19 +0100 (CET)
X-Mailer: git-send-email 1.7.3.1.68.g06779.dirty
In-reply-to: <1300190883-31833-1-git-send-email-torarvid@gmail.com>
X-OriginalArrivalTime: 15 Mar 2011 12:08:19.0531 (UTC)
 FILETIME=[AC4FC1B0:01CBE309]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169069>

When files are added to perforce, the path to that file has whichever case
configuration that exists on the machine of the user who added the file.
What does that mean? It means that when Alice adds a file

//depot/DirA/FileA.txt

... and Bob adds:

//depot/dirA/FileB.txt

... we may or may not get a problem. If a user sets the config variable
git-p4.ignorecase to "true", we will consider //depot/DirA and //depot/dirA
to be the same directory.

Signed-off-by: Tor Arvid Lund <torarvid@gmail.com>
---
 contrib/fast-import/git-p4 |   27 ++++++++++++++++++++-------
 1 files changed, 20 insertions(+), 7 deletions(-)

diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
index 4425220..d47596f 100755
--- a/contrib/fast-import/git-p4
+++ b/contrib/fast-import/git-p4
@@ -456,6 +456,19 @@ def p4ChangesForPaths(depotPaths, changeRange):
     changelist.sort()
     return changelist
 
+def p4PathStartsWith(path, prefix):
+    # This method tries to remedy a potential mixed-case issue:
+    #
+    # If UserA adds  //depot/DirA/file1
+    # and UserB adds //depot/dira/file2
+    #
+    # we may or may not have a problem. If you have core.ignorecase=true,
+    # we treat DirA and dira as the same directory
+    ignorecase = gitConfig("core.ignorecase", "--bool") == "true"
+    if ignorecase:
+        return path.lower().startswith(prefix.lower())
+    return path.startswith(prefix)
+
 class Command:
     def __init__(self):
         self.usage = "usage: %prog [options]"
@@ -603,7 +616,7 @@ class P4Submit(Command):
                     lastTab = path.rfind("\t")
                     if lastTab != -1:
                         path = path[:lastTab]
-                        if not path.startswith(self.depotPath):
+                        if not p4PathStartsWith(path, self.depotPath):
                             continue
                 else:
                     inFilesSection = False
@@ -941,11 +954,11 @@ class P4Sync(Command):
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
@@ -980,7 +993,7 @@ class P4Sync(Command):
             prefixes = [re.sub("^(//[^/]+/).*", r'\1', prefixes[0])]
 
         for p in prefixes:
-            if path.startswith(p):
+            if p4PathStartsWith(path, p):
                 path = path[len(p):]
 
         return path
@@ -991,7 +1004,7 @@ class P4Sync(Command):
         while commit.has_key("depotFile%s" % fnum):
             path =  commit["depotFile%s" % fnum]
             found = [p for p in self.depotPaths
-                     if path.startswith (p)]
+                     if p4PathStartsWith(path, p)]
             if not found:
                 fnum = fnum + 1
                 continue
@@ -1144,7 +1157,7 @@ class P4Sync(Command):
         # create a commit.
         new_files = []
         for f in files:
-            if [p for p in branchPrefixes if f['path'].startswith(p)]:
+            if [p for p in branchPrefixes if p4PathStartsWith(f['path'], p)]:
                 new_files.append (f)
             else:
                 sys.stderr.write("Ignoring file outside of prefix: %s\n" % path)
@@ -1308,7 +1321,7 @@ class P4Sync(Command):
                 source = paths[0]
                 destination = paths[1]
                 ## HACK
-                if source.startswith(self.depotPaths[0]) and destination.startswith(self.depotPaths[0]):
+                if p4PathStartsWith(source, self.depotPaths[0]) and p4PathStartsWith(destination, self.depotPaths[0]):
                     source = source[len(self.depotPaths[0]):-4]
                     destination = destination[len(self.depotPaths[0]):-4]
 
-- 
1.7.3.1.68.g06779.dirty
