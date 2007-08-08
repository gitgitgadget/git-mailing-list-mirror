From: Simon Hausmann <simon@lst.de>
Subject: [PATCH] git-p4: Fix git-p4 submit to include only changed files in the perforce submit template.
Date: Wed, 8 Aug 2007 17:06:55 +0200
Message-ID: <200708081706.58088.simon@lst.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Marius Storm-Olsen <marius@trolltech.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 08 17:06:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IIn7J-0000wR-Kk
	for gcvg-git@gmane.org; Wed, 08 Aug 2007 17:06:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752247AbXHHPG3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Aug 2007 11:06:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752838AbXHHPG3
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Aug 2007 11:06:29 -0400
Received: from verein.lst.de ([213.95.11.210]:33575 "EHLO mail.lst.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751612AbXHHPG2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Aug 2007 11:06:28 -0400
Received: from rhea.troll.no (nat0.troll.no [62.70.27.100])
	(authenticated bits=0)
	by mail.lst.de (8.12.3/8.12.3/Debian-7.1) with ESMTP id l78F6FA5002237
	(version=TLSv1/SSLv3 cipher=RC4-SHA bits=128 verify=NO);
	Wed, 8 Aug 2007 17:06:16 +0200
User-Agent: KMail/1.9.7
Content-Disposition: inline
X-Spam-Score: 0 () 
X-Scanned-By: MIMEDefang 2.39
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55323>

Parse the files section in the "p4 change -o" output and remove lines with file changes in unrelated depot paths.

Signed-off-by: Simon Hausmann <simon@lst.de>
Signed-off-by: Marius Storm-Olsen <marius@trolltech.com>
---

 contrib/fast-import/git-p4 |   36 ++++++++++++++++++++++++++++++------
 1 files changed, 30 insertions(+), 6 deletions(-)

diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
index 3cbb2da..805d632 100755
--- a/contrib/fast-import/git-p4
+++ b/contrib/fast-import/git-p4
@@ -390,6 +390,30 @@ class P4Submit(Command):
 
         return result
 
+    def prepareSubmitTemplate(self):
+        # remove lines in the Files section that show changes to files outside the depot path we're committing into
+        template = ""
+        inFilesSection = False
+        for line in read_pipe_lines("p4 change -o"):
+            if inFilesSection:
+                if line.startswith("\t"):
+                    # path starts and ends with a tab
+                    path = line[1:]
+                    lastTab = path.rfind("\t")
+                    if lastTab != -1:
+                        path = path[:lastTab]
+                        if not path.startswith(self.depotPath):
+                            continue
+                else:
+                    inFilesSection = False
+            else:
+                if line.startswith("Files:"):
+                    inFilesSection = True
+
+            template += line
+
+        return template
+
     def applyCommit(self, id):
         if self.directSubmit:
             print "Applying local change in working directory/index"
@@ -467,7 +491,7 @@ class P4Submit(Command):
                 logMessage = logMessage.replace("\n", "\r\n")
             logMessage = logMessage.strip()
 
-        template = read_pipe("p4 change -o")
+        template = self.prepareSubmitTemplate()
 
         if self.interactive:
             submitTemplate = self.prepareLogMessage(template, logMessage)
@@ -558,24 +582,24 @@ class P4Submit(Command):
             return False
 
         [upstream, settings] = findUpstreamBranchPoint()
-        depotPath = settings['depot-paths'][0]
+        self.depotPath = settings['depot-paths'][0]
         if len(self.origin) == 0:
             self.origin = upstream
 
         if self.verbose:
             print "Origin branch is " + self.origin
 
-        if len(depotPath) == 0:
+        if len(self.depotPath) == 0:
             print "Internal error: cannot locate perforce depot path from existing branches"
             sys.exit(128)
 
-        self.clientPath = p4Where(depotPath)
+        self.clientPath = p4Where(self.depotPath)
 
         if len(self.clientPath) == 0:
-            print "Error: Cannot locate perforce checkout of %s in client view" % depotPath
+            print "Error: Cannot locate perforce checkout of %s in client view" % self.depotPath
             sys.exit(128)
 
-        print "Perforce checkout for depot path %s located at %s" % (depotPath, self.clientPath)
+        print "Perforce checkout for depot path %s located at %s" % (self.depotPath, self.clientPath)
         self.oldWorkingDirectory = os.getcwd()
 
         if self.directSubmit:
-- 
1.5.3.rc3.91.g5c75
