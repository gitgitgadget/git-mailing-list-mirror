From: Simon Hausmann <simon@lst.de>
Subject: [PATCH] [git-p4] Make it possible to abort the submission of a change to Perforce
Date: Wed, 27 Aug 2008 09:30:29 +0200
Message-ID: <200808270937.10577.simon@lst.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 27 09:38:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYFbk-0001Mc-Eh
	for gcvg-git-2@gmane.org; Wed, 27 Aug 2008 09:38:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752053AbYH0HhS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Aug 2008 03:37:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752045AbYH0HhS
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Aug 2008 03:37:18 -0400
Received: from hoat.troll.no ([62.70.27.150]:53010 "EHLO hoat.troll.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752018AbYH0HhR (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Aug 2008 03:37:17 -0400
Received: from hoat.troll.no (tedur.troll.no [62.70.27.154])
	by hoat.troll.no (Postfix) with SMTP id 3BAD420AE1;
	Wed, 27 Aug 2008 09:37:11 +0200 (CEST)
Received: from rhea.localnet (rhea.troll.no [10.3.4.5])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by hoat.troll.no (Postfix) with ESMTP id 31ADB20A70;
	Wed, 27 Aug 2008 09:37:11 +0200 (CEST)
User-Agent: KMail/1.10.0 (Linux/2.6.24-18-generic; KDE/4.1.0; x86_64; ; )
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93864>

Currently it is not possible to skip the submission of a change to Perforce
when running git-p4 submit. This patch compares the modification time before
and after the submit editor invokation and offers a prompt for skipping if
the submit template file was not saved.

Signed-off-by: Simon Hausmann <simon@lst.de>
---
 contrib/fast-import/git-p4 |   31 +++++++++++++++++++++++--------
 1 files changed, 23 insertions(+), 8 deletions(-)

diff --git a/contrib/fast-import/git-p4 b/contrib/fast-import/git-p4
index 46136d4..c1d24b3 100755
--- a/contrib/fast-import/git-p4
+++ b/contrib/fast-import/git-p4
@@ -708,6 +708,7 @@ class P4Submit(Command):
                 newdiff = newdiff.replace("\n", "\r\n")
             tmpFile.write(submitTemplate + separatorLine + diff + newdiff)
             tmpFile.close()
+            mtime = os.stat(fileName).st_mtime
             defaultEditor = "vi"
             if platform.system() == "Windows":
                 defaultEditor = "notepad"
@@ -716,15 +717,29 @@ class P4Submit(Command):
             else:
                 editor = os.environ.get("EDITOR", defaultEditor);
             system(editor + " " + fileName)
-            tmpFile = open(fileName, "rb")
-            message = tmpFile.read()
-            tmpFile.close()
-            os.remove(fileName)
-            submitTemplate = message[:message.index(separatorLine)]
-            if self.isWindows:
-                submitTemplate = submitTemplate.replace("\r\n", "\n")
 
-            p4_write_pipe("submit -i", submitTemplate)
+            response = "y"
+            if os.stat(fileName).st_mtime <= mtime:
+                response = "x"
+                while response != "y" and response != "n":
+                    response = raw_input("Submit template unchanged. Submit anyway? [y]es, [n]o (skip this patch) ")
+
+            if response == "y":
+                tmpFile = open(fileName, "rb")
+                message = tmpFile.read()
+                tmpFile.close()
+                submitTemplate = message[:message.index(separatorLine)]
+                if self.isWindows:
+                    submitTemplate = submitTemplate.replace("\r\n", "\n")
+                p4_write_pipe("submit -i", submitTemplate)
+            else:
+                for f in editedFiles:
+                    p4_system("revert \"%s\"" % f);
+                for f in filesToAdd:
+                    p4_system("revert \"%s\"" % f);
+                    system("rm %s" %f)
+
+            os.remove(fileName)
         else:
             fileName = "submit.txt"
             file = open(fileName, "w+")
-- 
1.6.0.2.g2ebc0
