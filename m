From: Luke Diamand <luke@diamand.org>
Subject: [PATCHv2 3/4] git-p4: importing labels should cope with missing owner
Date: Wed, 30 Nov 2011 09:03:36 +0000
Message-ID: <1322643817-13051-4-git-send-email-luke@diamand.org>
References: <1322643817-13051-1-git-send-email-luke@diamand.org>
Cc: Pete Wyckoff <pw@padd.com>, Luke Diamand <luke@diamand.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Nov 30 10:04:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RVg5u-0005LU-II
	for gcvg-git-2@lo.gmane.org; Wed, 30 Nov 2011 10:04:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757235Ab1K3JEj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Nov 2011 04:04:39 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:61786 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757206Ab1K3JE2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Nov 2011 04:04:28 -0500
Received: by bkas6 with SMTP id s6so571120bka.19
        for <git@vger.kernel.org>; Wed, 30 Nov 2011 01:04:27 -0800 (PST)
Received: by 10.204.0.82 with SMTP id 18mr1232158bka.86.1322643867317;
        Wed, 30 Nov 2011 01:04:27 -0800 (PST)
Received: from ethel.cable.virginmedia.net (cpc1-cmbg14-2-0-cust973.5-4.cable.virginmedia.com. [86.26.7.206])
        by mx.google.com with ESMTPS id c4sm2565364bkk.13.2011.11.30.01.04.25
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 30 Nov 2011 01:04:26 -0800 (PST)
X-Mailer: git-send-email 1.7.8.rc1.209.geac91.dirty
In-Reply-To: <1322643817-13051-1-git-send-email-luke@diamand.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186121>

In p4, the Owner field is optional. If it is missing,
construct something sensible rather than crashing.

Signed-off-by: Luke Diamand <luke@diamand.org>
---
 contrib/fast-import/git-p4 |   45 +++++++++++++++++++++++--------------------
 1 files changed, 24 insertions(+), 21 deletions(-)

diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
index 02f0f54..d97f927 100755
--- a/contrib/fast-import/git-p4
+++ b/contrib/fast-import/git-p4
@@ -553,6 +553,27 @@ class Command:
     def __init__(self):
         self.usage = "usage: %prog [options]"
         self.needsGit = True
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
+
 
 class P4UserMap:
     def __init__(self):
@@ -694,7 +715,6 @@ class P4Submit(Command, P4UserMap):
         self.verbose = False
         self.preserveUser = gitConfig("git-p4.preserveUser").lower() == "true"
         self.isWindows = (platform.system() == "Windows")
-        self.myP4UserId = None
 
     def check(self):
         if len(p4CmdList("opened ...")) > 0:
@@ -802,25 +822,6 @@ class P4Submit(Command, P4UserMap):
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
@@ -1506,7 +1507,9 @@ class P4Sync(Command, P4UserMap):
 
                     owner = labelDetails["Owner"]
                     tagger = ""
-                    if author in self.users:
+                    if not owner:
+                        tagger = "%s <a@b> %s %s" % (self.p4UserId(), epoch, self.tz)
+                    elif author in self.users:
                         tagger = "%s %s %s" % (self.users[owner], epoch, self.tz)
                     else:
                         tagger = "%s <a@b> %s %s" % (owner, epoch, self.tz)
-- 
1.7.8.rc1.209.geac91.dirty
