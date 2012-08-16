From: Pete Wyckoff <pw@padd.com>
Subject: [PATCH 04/12] git p4: remove submit failure options [a]pply and [w]rite
Date: Thu, 16 Aug 2012 19:35:06 -0400
Message-ID: <1345160114-27654-5-git-send-email-pw@padd.com>
References: <1345160114-27654-1-git-send-email-pw@padd.com>
Cc: Luke Diamand <luke@diamand.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 17 01:36:46 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T29cL-0003gq-1Z
	for gcvg-git-2@plane.gmane.org; Fri, 17 Aug 2012 01:36:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752685Ab2HPXgi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Aug 2012 19:36:38 -0400
Received: from honk.padd.com ([74.3.171.149]:47762 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751662Ab2HPXgh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Aug 2012 19:36:37 -0400
Received: from arf.padd.com (unknown [50.55.149.165])
	by honk.padd.com (Postfix) with ESMTPSA id 47DFBD27;
	Thu, 16 Aug 2012 16:36:37 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 0C152313FD; Thu, 16 Aug 2012 19:36:34 -0400 (EDT)
X-Mailer: git-send-email 1.7.12.rc2.111.g96f7c73
In-Reply-To: <1345160114-27654-1-git-send-email-pw@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When a patch failed to apply, these interactive options offered
to:

    1) apply the patch anyway, leaving reject (.rej) files around, or,
    2) write the patch to a file (patch.txt)

In both cases it suggested to invoke "git p4 submit --continue",
an unimplemented option.

While manually fixing the rejects and submitting the result might
work, there are many steps that must be done to the job properly:

    * apply patch
    * invoke p4 add and delete
    * change executable bits
    * p4 sync -f renamed/copied files
    * extract commit message into p4 change description and
      move Jobs lines out of description section
    * set changelist owner for --preserve-user

Plus the following manual sync/rebase will cause conflicts too,
which must be resolved once again.

Drop these workflows.  Instead users should do a sync/rebase in
git, fix the conflicts there, and do a clean "git p4 submit".

Signed-off-by: Pete Wyckoff <pw@padd.com>
---
 git-p4.py | 20 ++------------------
 1 file changed, 2 insertions(+), 18 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 2405f38..e08fea1 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -1200,9 +1200,8 @@ class P4Submit(Command, P4UserMap):
         if not patch_succeeded:
             print "What do you want to do?"
             response = "x"
-            while response != "s" and response != "a" and response != "w":
-                response = raw_input("[s]kip this patch / [a]pply the patch forcibly "
-                                     "and with .rej files / [w]rite the patch to a file (patch.txt) ")
+            while response != "s":
+                response = raw_input("[s]kip this patch ")
             if response == "s":
                 print "Skipping! Good luck with the next patches..."
                 for f in editedFiles:
@@ -1210,21 +1209,6 @@ class P4Submit(Command, P4UserMap):
                 for f in filesToAdd:
                     os.remove(f)
                 return False
-            elif response == "a":
-                os.system(applyPatchCmd)
-                if len(filesToAdd) > 0:
-                    print "You may also want to call p4 add on the following files:"
-                    print " ".join(filesToAdd)
-                if len(filesToDelete):
-                    print "The following files should be scheduled for deletion with p4 delete:"
-                    print " ".join(filesToDelete)
-                die("Please resolve and submit the conflict manually and "
-                    + "continue afterwards with git p4 submit --continue")
-            elif response == "w":
-                system(diffcmd + " > patch.txt")
-                print "Patch saved to patch.txt in %s !" % self.clientPath
-                die("Please resolve and submit the conflict manually and "
-                    "continue afterwards with git p4 submit --continue")
 
         system(applyPatchCmd)
 
-- 
1.7.11.4
