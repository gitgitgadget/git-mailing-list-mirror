From: Luke Diamand <luke@diamand.org>
Subject: [PATCH] git-p4: add option to preserve user names
Date: Tue, 19 Apr 2011 19:01:18 +0100
Message-ID: <1303236078-14011-2-git-send-email-luke@diamand.org>
References: <1303236078-14011-1-git-send-email-luke@diamand.org>
Cc: Luke Diamand <luke@diamand.org>, Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Tue Apr 19 20:02:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QCFFd-0000Gk-QA
	for gcvg-git-2@lo.gmane.org; Tue, 19 Apr 2011 20:02:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754054Ab1DSSCH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Apr 2011 14:02:07 -0400
Received: from mail-ww0-f44.google.com ([74.125.82.44]:40828 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753371Ab1DSSCG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Apr 2011 14:02:06 -0400
Received: by mail-ww0-f44.google.com with SMTP id 36so7262680wwa.1
        for <git@vger.kernel.org>; Tue, 19 Apr 2011 11:02:05 -0700 (PDT)
Received: by 10.227.104.2 with SMTP id m2mr6628609wbo.35.1303236125493;
        Tue, 19 Apr 2011 11:02:05 -0700 (PDT)
Received: from localhost.localdomain ([212.183.128.32])
        by mx.google.com with ESMTPS id x1sm89143wbh.19.2011.04.19.11.01.56
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 19 Apr 2011 11:02:03 -0700 (PDT)
To: git@vger.kernel.org
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1303236078-14011-1-git-send-email-luke@diamand.org>
To: git@vger.kernel.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171805>

Patches from git passed into p4 end up with the committer
being identified as the person who ran git-p4.

With "submit --preserve-user", git-p4 sets P4USER. If the
submitter has sufficient p4 permissions, the p4 equivalent
of the git email committer will be passed into perforce.

Signed-off-by: Luke Diamand <luke@diamand.org>
---
 contrib/fast-import/git-p4     |   33 +++++++++++++++++++++++++++++++++
 contrib/fast-import/git-p4.txt |    6 ++++++
 2 files changed, 39 insertions(+), 0 deletions(-)

diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
index 78e5b3a..7d66aa9 100755
--- a/contrib/fast-import/git-p4
+++ b/contrib/fast-import/git-p4
@@ -561,6 +561,8 @@ class P4Submit(Command):
                 optparse.make_option("--verbose", dest="verbose", action="store_true"),
                 optparse.make_option("--origin", dest="origin"),
                 optparse.make_option("-M", dest="detectRenames", action="store_true"),
+                # preserve the user, assumes relevant p4 permissions available
+                optparse.make_option("--preserve-user", dest="preserveUser", action="store_true"),
         ]
         self.description = "Submit changes from git to the perforce depot."
         self.usage += " [name of git branch to submit into perforce depot]"
@@ -568,6 +570,7 @@ class P4Submit(Command):
         self.origin = ""
         self.detectRenames = False
         self.verbose = False
+        self.preserveUser = False
         self.isWindows = (platform.system() == "Windows")
 
     def check(self):
@@ -592,6 +595,11 @@ class P4Submit(Command):
                 else:
                     continue
             else:
+                if self.preserveUser:
+		    if self.p4user:
+                        if line.startswith("User:"):
+                            line = "User: %s" % self.p4user
+
                 if line.startswith("Description:"):
                     inDescriptionSection = True
                     line += "\n"
@@ -602,6 +610,18 @@ class P4Submit(Command):
 
         return result
 
+    def p4User(self,id):
+        # Return the perforce user for a given git commit id
+        git_email = read_pipe("git log --max-count=1 --format='%%ae' %s" % id)
+        git_email = git_email.strip()
+        if not self.email_to_user.has_key(git_email):
+            print("Cannot find perforce user for email %s in commit %s." %
+                (git_email, id))
+            print("Submitting changelist with default user - fixup later manually!")
+            return None
+        else:
+            return self.email_to_user[git_email]
+
     def prepareSubmitTemplate(self):
         # remove lines in the Files section that show changes to files outside the depot path we're committing into
         template = ""
@@ -631,6 +651,12 @@ class P4Submit(Command):
     def applyCommit(self, id):
         print "Applying %s" % (read_pipe("git log --max-count=1 --pretty=oneline %s" % id))
 
+        if self.preserveUser:
+            p4user = self.p4User(id)
+            self.p4user = p4user
+            if p4user:
+                os.putenv('P4USER', p4user)
+
         if not self.detectRenames:
             # If not explicitly set check the config variable
             self.detectRenames = gitConfig("git-p4.detectRenames").lower() == "true"
@@ -847,6 +873,13 @@ class P4Submit(Command):
         print "Perforce checkout for depot path %s located at %s" % (self.depotPath, self.clientPath)
         self.oldWorkingDirectory = os.getcwd()
 
+        if self.preserveUser:
+	    self.email_to_user = {}
+	    for output in p4CmdList("users"):
+	        if not output.has_key("User"):
+	            continue
+	        self.email_to_user[output["Email"]] = output["User"]
+
         chdir(self.clientPath)
         print "Synchronizing p4 checkout..."
         p4_system("sync ...")
diff --git a/contrib/fast-import/git-p4.txt b/contrib/fast-import/git-p4.txt
index e09da44..7c3c794 100644
--- a/contrib/fast-import/git-p4.txt
+++ b/contrib/fast-import/git-p4.txt
@@ -110,6 +110,12 @@ is not your current git branch you can also pass that as an argument:
 
 You can override the reference branch with the --origin=mysourcebranch option.
 
+The Perforce changelists will be created with the user who ran git-p4. If you
+use --preserve-user then git-p4 will attempt to create Perforce changelists
+with the Perforce user corresponding to the git commit author. You need to
+have sufficient permissions within Perforce, and the git users need to have
+Perforce accounts.
+
 If a submit fails you may have to "p4 resolve" and submit manually. You can
 continue importing the remaining changes with
 
-- 
1.7.1
