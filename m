From: Kevin Green <Kevin.T.Green@morganstanley.com>
Subject: [PATCH] git-p4: Work around race between p4_edit and p4_change
Date: Thu, 3 Apr 2008 15:51:35 -0400
Message-ID: <20080403195135.GI22542@morganstanley.com>
References: <20080401222856.GA22542@morganstanley.com> <200804032032.39860.simon@lst.de> <20080403184537.GH22542@morganstanley.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: Simon Hausmann <simon@lst.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 03 21:59:04 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JhVaR-00030j-09
	for gcvg-git-2@gmane.org; Thu, 03 Apr 2008 21:59:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932503AbYDCT55 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Apr 2008 15:57:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760881AbYDCT55
	(ORCPT <rfc822;git-outgoing>); Thu, 3 Apr 2008 15:57:57 -0400
Received: from hqmtabh1.ms.com ([205.228.12.101]:38790 "EHLO hqmtabh1.ms.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1760404AbYDCT5z (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Apr 2008 15:57:55 -0400
X-Greylist: delayed 379 seconds by postgrey-1.27 at vger.kernel.org; Thu, 03 Apr 2008 15:57:55 EDT
Received: from hqmtabh1 (localhost.ms.com [127.0.0.1])
	by hqmtabh1.ms.com (output Postfix) with ESMTP id A6A2C48443;
	Thu,  3 Apr 2008 15:51:35 -0400 (EDT)
Received: from ny0031as01 (unknown [144.203.194.93])
	by hqmtabh1.ms.com (internal Postfix) with ESMTP id 7641B180013;
	Thu,  3 Apr 2008 15:51:35 -0400 (EDT)
Received: from hn315c1n4 (localhost [127.0.0.1])
	by ny0031as01 (msa-out Postfix) with ESMTP id 67A9C972040;
	Thu,  3 Apr 2008 15:51:35 -0400 (EDT)
Received: from menevado.ms.com (unknown [144.203.222.190])
	by ny0031as01 (msa-in Postfix) with ESMTP id 48E6065C029;
	Thu,  3 Apr 2008 15:51:35 -0400 (EDT)
Received: (kgreen@localhost) by menevado.ms.com (8.12.11.20060308/sendmail.cf.client v1.05) id m33JpZWx004495; Thu, 3 Apr 2008 15:51:35 -0400
X-Authentication-Warning: menevado.ms.com: kgreen set sender to Kevin.T.Green@morganstanley.com using -f
Mail-Followup-To: Simon Hausmann <simon@lst.de>, git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20080403184537.GH22542@morganstanley.com>
User-Agent: Mutt/1.5.6i
X-Anti-Virus: Kaspersky Anti-Virus for MailServers 5.5.15/RELEASE, bases: 03042008 #610516, status: clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78772>

On 04/03/08 14:45:38, Kevin Green wrote:
> On 04/03/08 14:32:32, Simon Hausmann wrote:
> > 
> > Last but not least we could of course also generate the entire Files: section 
> > ourselves, using 'p4 change -o' just to get the rest of the template right.
> > 
> > I almost prefer the last approach, since we know the base depot path and the 
> > relative paths of all edited/added files.
> > 
> > What do you think?
> > 
> 
> Thank you...  That's the right approach.  Stop as soon as we get to the Files:
> section and then just add in the depot + filepath string for each change...
> 

And here's the patch that does what we just described...


--Kevin


>From dff9c9a00e3aaf41023ff11ecc75902a87b4c16b Mon Sep 17 00:00:00 2001
From: Kevin Green <Kevin.Green@morganstanley.com>
Date: Thu, 3 Apr 2008 15:47:07 -0400
Subject: [PATCH] git-p4: Work around race between p4_edit and p4_change

There exists a race in p4, such that p4_edit immediately followed by a
p4_change will not show the new edits in the changelist template.

Instead of removing files not in our concerned depot from the Files: section
we instead use p4_change as a template only up to the Files: section and then
file in the files explicitly ourselves, since we know the full list of files
and they current state, e.g. add, delete, edit.

Signed-off-by: Kevin Green <Kevin.Green@morganstanley.com>
---
 contrib/fast-import/git-p4 |   30 ++++++++++++++----------------
 1 files changed, 14 insertions(+), 16 deletions(-)

diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
index d8de9f6..7760764 100755
--- a/contrib/fast-import/git-p4
+++ b/contrib/fast-import/git-p4
@@ -511,29 +511,20 @@ class P4Submit(Command):
     def prepareSubmitTemplate(self):
         # remove lines in the Files section that show changes to files outside the depot path we're committing into
         template = ""
-        inFilesSection = False
         for line in read_pipe_lines("p4 change -o"):
             if line.endswith("\r\n"):
                 line = line[:-2] + "\n"
-            if inFilesSection:
-                if line.startswith("\t"):
-                    # path starts and ends with a tab
-                    path = line[1:]
-                    lastTab = path.rfind("\t")
-                    if lastTab != -1:
-                        path = path[:lastTab]
-                        if not path.startswith(self.depotPath):
-                            continue
-                else:
-                    inFilesSection = False
-            else:
-                if line.startswith("Files:"):
-                    inFilesSection = True
+            if line.startswith("Files:"):
+                template += line
+                break
 
             template += line
 
         return template
 
+    def addToFilesSection(self, path, type):
+        return "\t" + self.depotPath + "/" + path + "\t# " + type + "\n"
+
     def applyCommit(self, id):
         print "Applying %s" % (read_pipe("git log --max-count=1 --pretty=oneline %s" % id))
         diffOpts = ("", "-M")[self.detectRename]
@@ -609,11 +600,19 @@ class P4Submit(Command):
 
         system(applyPatchCmd)
 
+        template = self.prepareSubmitTemplate()
+
         for f in filesToAdd:
             system("p4 add \"%s\"" % f)
+            template += self.addToFilesSection(f,"add")
+
         for f in filesToDelete:
             system("p4 revert \"%s\"" % f)
             system("p4 delete \"%s\"" % f)
+            template += self.addToFilesSection(f,"delete")
+
+        for f in editedFiles:
+            template += self.addToFilesSection(f,"edit")
 
         # Set/clear executable bits
         for f in filesToChangeExecBit.keys():
@@ -623,7 +622,6 @@ class P4Submit(Command):
         logMessage = extractLogMessageFromGitCommit(id)
         logMessage = logMessage.strip()
 
-        template = self.prepareSubmitTemplate()
 
         if self.interactive:
             submitTemplate = self.prepareLogMessage(template, logMessage)
-- 
1.5.4.2
