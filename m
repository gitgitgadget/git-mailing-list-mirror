From: Luke Diamand <luke@diamand.org>
Subject: [PATCHv4 3/5] git-p4: importing labels should cope with missing owner
Date: Thu, 19 Jan 2012 09:52:27 +0000
Message-ID: <1326966749-9077-4-git-send-email-luke@diamand.org>
References: <1326966749-9077-1-git-send-email-luke@diamand.org>
Cc: Pete Wyckoff <pw@padd.com>, Vitor Antunes <vitor.hda@gmail.com>,
	Luke Diamand <luke@diamand.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 19 10:53:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rnofw-00023s-Te
	for gcvg-git-2@lo.gmane.org; Thu, 19 Jan 2012 10:52:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756522Ab2ASJwy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Jan 2012 04:52:54 -0500
Received: from mail-we0-f174.google.com ([74.125.82.174]:43925 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756312Ab2ASJwn (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jan 2012 04:52:43 -0500
Received: by werb13 with SMTP id b13so1052346wer.19
        for <git@vger.kernel.org>; Thu, 19 Jan 2012 01:52:42 -0800 (PST)
Received: by 10.216.132.195 with SMTP id o45mr1473144wei.17.1326966762291;
        Thu, 19 Jan 2012 01:52:42 -0800 (PST)
Received: from ethel.diamand (cpc1-cmbg14-2-0-cust973.5-4.cable.virginmedia.com. [86.26.7.206])
        by mx.google.com with ESMTPS id bj10sm27093411wib.9.2012.01.19.01.52.40
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 19 Jan 2012 01:52:41 -0800 (PST)
X-Mailer: git-send-email 1.7.8.rc1.209.geac91.dirty
In-Reply-To: <1326966749-9077-1-git-send-email-luke@diamand.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188802>

In p4, the Owner field is optional. If it is missing,
construct something sensible rather than crashing.

Signed-off-by: Luke Diamand <luke@diamand.org>
---
 contrib/fast-import/git-p4 |   63 ++++++++++++++++++++++++-------------------
 1 files changed, 35 insertions(+), 28 deletions(-)

diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
index 5b59bc8..58551b9 100755
--- a/contrib/fast-import/git-p4
+++ b/contrib/fast-import/git-p4
@@ -563,6 +563,26 @@ class Command:
 class P4UserMap:
     def __init__(self):
         self.userMapFromPerforceServer = False
+        self.myP4UserId = None
+
+    def p4UserId(self):
+        if self.myP4UserId:
+            return self.myP4UserId
+
+        results = p4CmdList("user -o")
+        for r in results:
+            if r.has_key('User'):
+                self.myP4UserId = r['User']
+                return r['User']
+        die("Could not find your p4 user id")
+
+    def p4UserIsMe(self, p4User):
+        # return True if the given p4 user is actually me
+        me = self.p4UserId()
+        if not p4User or p4User != me:
+            return False
+        else:
+            return True
 
     def getUserCacheFilename(self):
         home = os.environ.get("HOME", os.environ.get("USERPROFILE"))
@@ -700,7 +720,6 @@ class P4Submit(Command, P4UserMap):
         self.verbose = False
         self.preserveUser = gitConfig("git-p4.preserveUser").lower() == "true"
         self.isWindows = (platform.system() == "Windows")
-        self.myP4UserId = None
 
     def check(self):
         if len(p4CmdList("opened ...")) > 0:
@@ -808,25 +827,6 @@ class P4Submit(Command, P4UserMap):
                     return 1
         return 0
 
-    def p4UserId(self):
-        if self.myP4UserId:
-            return self.myP4UserId
-
-        results = p4CmdList("user -o")
-        for r in results:
-            if r.has_key('User'):
-                self.myP4UserId = r['User']
-                return r['User']
-        die("Could not find your p4 user id")
-
-    def p4UserIsMe(self, p4User):
-        # return True if the given p4 user is actually me
-        me = self.p4UserId()
-        if not p4User or p4User != me:
-            return False
-        else:
-            return True
-
     def prepareSubmitTemplate(self):
         # remove lines in the Files section that show changes to files outside the depot path we're committing into
         template = ""
@@ -1675,6 +1675,12 @@ class P4Sync(Command, P4UserMap):
             if self.stream_file.has_key('depotFile'):
                 self.streamOneP4File(self.stream_file, self.stream_contents)
 
+    def make_email(self, userid):
+        if userid in self.users:
+            return self.users[userid]
+        else:
+            return "%s <a@b>" % userid
+
     def commit(self, details, files, branch, branchPrefixes, parent = ""):
         epoch = details["time"]
         author = details["user"]
@@ -1698,10 +1704,7 @@ class P4Sync(Command, P4UserMap):
         committer = ""
         if author not in self.users:
             self.getUserMapFromPerforceServer()
-        if author in self.users:
-            committer = "%s %s %s" % (self.users[author], epoch, self.tz)
-        else:
-            committer = "%s <a@b> %s %s" % (author, epoch, self.tz)
+        committer = "%s %s %s" % (self.make_email(author), epoch, self.tz)
 
         self.gitStream.write("committer %s\n" % committer)
 
@@ -1746,11 +1749,15 @@ class P4Sync(Command, P4UserMap):
                     self.gitStream.write("from %s\n" % branch)
 
                     owner = labelDetails["Owner"]
-                    tagger = ""
-                    if author in self.users:
-                        tagger = "%s %s %s" % (self.users[owner], epoch, self.tz)
+
+                    # Try to use the owner of the p4 label, or failing that,
+                    # the current p4 user id.
+                    if owner:
+                        email = self.make_email(owner)
                     else:
-                        tagger = "%s <a@b> %s %s" % (owner, epoch, self.tz)
+                        email = self.make_email(self.p4UserId())
+                    tagger = "%s %s %s" % (email, epoch, self.tz)
+
                     self.gitStream.write("tagger %s\n" % tagger)
 
                     description = labelDetails["Description"]
-- 
1.7.8.rc1.209.geac91.dirty
