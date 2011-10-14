From: Andrei Warkentin <andreiw@vmware.com>
Subject: [PATCH] Git-p4: git-p4.changeOnSubmit to do 'change' instead of 'submit'.
Date: Fri, 14 Oct 2011 17:51:50 -0400
Message-ID: <1318629110-15232-1-git-send-email-andreiw@vmware.com>
Cc: Andrei Warkentin <andreiw@vmware.com>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Oct 14 23:52:02 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1REpfd-0008GO-Tq
	for gcvg-git-2@lo.gmane.org; Fri, 14 Oct 2011 23:52:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933423Ab1JNVvy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 14 Oct 2011 17:51:54 -0400
Received: from smtp-outbound-2.vmware.com ([65.115.85.73]:40947 "EHLO
	smtp-outbound-2.vmware.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932246Ab1JNVvx (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Oct 2011 17:51:53 -0400
Received: from mailhost4.vmware.com (mailhost4.vmware.com [10.16.67.124])
	by smtp-outbound-2.vmware.com (Postfix) with ESMTP id 960433400C;
	Fri, 14 Oct 2011 14:51:52 -0700 (PDT)
Received: from andreiw-eng-rhel5-64.eng.vmware.com (vmc-floorb-dhcp117-40.eng.vmware.com [10.17.117.40])
	by mailhost4.vmware.com (Postfix) with ESMTP id 3C1E5CA175;
	Fri, 14 Oct 2011 14:51:52 -0700 (PDT)
X-Mailer: git-send-email 1.7.4.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183616>

Many users of p4/sd use changelists for review, regression
tests and batch builds, thus changes are almost never directly
submitted.

This new config option lets a 'p4 change -i' run instead of
the 'p4 submit -i'.

Signed-off-by: Andrei Warkentin <andreiw@vmware.com>
---
 contrib/fast-import/git-p4     |   16 ++++++++++++----
 contrib/fast-import/git-p4.txt |   10 ++++++++++
 2 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
index 2f7b270..19c295b 100755
--- a/contrib/fast-import/git-p4
+++ b/contrib/fast-import/git-p4
@@ -959,7 +959,10 @@ class P4Submit(Command, P4UserMap):
                 submitTemplate = message[:message.index(separatorLine)]
                 if self.isWindows:
                     submitTemplate = submitTemplate.replace("\r\n", "\n")
-                p4_write_pipe("submit -i", submitTemplate)
+                if gitConfig("git-p4.changeOnSubmit"):
+                    p4_write_pipe("change -i", submitTemplate)
+                else:
+                    p4_write_pipe("subadasdmit -i", submitTemplate)
 
                 if self.preserveUser:
                     if p4User:
@@ -981,9 +984,14 @@ class P4Submit(Command, P4UserMap):
             file = open(fileName, "w+")
             file.write(self.prepareLogMessage(template, logMessage))
             file.close()
-            print ("Perforce submit template written as %s. "
-                   + "Please review/edit and then use p4 submit -i < %s to submit directly!"
-                   % (fileName, fileName))
+            if gitConfig("git-p4.changeOnSubmit"):
+                print ("Perforce submit template written as %s. "
+                       + "Please review/edit and then use p4 change -i < %s to create changelist!"
+                       % (fileName, fileName))
+            else:
+                print ("Perforce submit template written as %s. "
+                       + "Please review/edit and then use p4 submit -i < %s to submit directly!"
+                       % (fileName, fileName))
 
     def run(self, args):
         if len(args) == 0:
diff --git a/contrib/fast-import/git-p4.txt b/contrib/fast-import/git-p4.txt
index 52003ae..3a3a815 100644
--- a/contrib/fast-import/git-p4.txt
+++ b/contrib/fast-import/git-p4.txt
@@ -180,6 +180,16 @@ git-p4.allowSubmit
 
   git config [--global] git-p4.allowSubmit false
 
+git-p4.changeOnSubmit
+
+  git config [--global] git-p4.changeOnSubmit false
+
+Most places using p4/sourcedepot don't actually want you submit
+changes directly, and changelists are used to do regression testing,
+batch builds and review, hence, by setting this parameter to
+true you acknowledge you end up creating a changelist which you
+must then manually commit.
+
 git-p4.syncFromOrigin
 
 A useful setup may be that you have a periodically updated git repository
-- 
1.7.4.1
