From: Maxime Coste <frrrwww@gmail.com>
Subject: [PATCH] git-p4: Do not include diff in spec file when just preparing
 p4
Date: Fri, 10 Jan 2014 18:18:07 +0000
Message-ID: <20140110181807.GA29164@nekage>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 10 19:16:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W1gd8-0000Zr-Vo
	for gcvg-git-2@plane.gmane.org; Fri, 10 Jan 2014 19:16:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752235AbaAJSQX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Jan 2014 13:16:23 -0500
Received: from mail-wi0-f174.google.com ([209.85.212.174]:60184 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750855AbaAJSQV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Jan 2014 13:16:21 -0500
Received: by mail-wi0-f174.google.com with SMTP id z2so8699410wiv.7
        for <git@vger.kernel.org>; Fri, 10 Jan 2014 10:16:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        bh=b+LeM28G0nyvXRr98g2jRJRZTbdDyyrIdurqcq7TNKk=;
        b=oG2o2zyP1xGogpho3HjUewhsm13JMfELAlwAvDiA9ZnZEUC0F9jmTBfItmlyev4EEq
         6kMPX7WnuGRwApSYud6W+8Y+xlZ08LPC0Bd5wNobSq+DRUxW2IFFyqG2QnOxvAnTUgsu
         KvKrH5KRuvkM70E4tESTlL/G3zXk/qO2pEjPsLzbKSRNC+taLYscWv+yOQWq79rBkdGl
         KS/p260WCYSgTrIKgp5CqjjHoPOM5IhccJReSVTaLmBsd7oBuHuECu75RsLblrE7ncPL
         /nkg7I9Ei8baecBknUIefF3T1ZoK1DmLeGkGABQJmu8Jw2508rwOe+ej9TpePclqfaI9
         wf4A==
X-Received: by 10.180.36.51 with SMTP id n19mr4047976wij.48.1389377780406;
        Fri, 10 Jan 2014 10:16:20 -0800 (PST)
Received: from localhost ([89.100.253.33])
        by mx.google.com with ESMTPSA id k10sm4774833wjf.11.2014.01.10.10.16.19
        for <git@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Jan 2014 10:16:19 -0800 (PST)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240307>

The diff information render the spec file unusable as is by p4,
do not include it when run with --prepare-p4-only so that the
given file can be directly passed to p4.
---
 git-p4.py | 70 +++++++++++++++++++++++++++++++++++----------------------------
 1 file changed, 39 insertions(+), 31 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 5ea8bb8..7c65340 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -1397,38 +1397,14 @@ class P4Submit(Command, P4UserMap):
             submitTemplate += "######## Use option --preserve-user to modify authorship.\n"
             submitTemplate += "######## Variable git-p4.skipUserNameCheck hides this message.\n"
 
-        separatorLine = "######## everything below this line is just the diff #######\n"
-
-        # diff
-        if os.environ.has_key("P4DIFF"):
-            del(os.environ["P4DIFF"])
-        diff = ""
-        for editedFile in editedFiles:
-            diff += p4_read_pipe(['diff', '-du',
-                                  wildcard_encode(editedFile)])
-
-        # new file diff
-        newdiff = ""
-        for newFile in filesToAdd:
-            newdiff += "==== new file ====\n"
-            newdiff += "--- /dev/null\n"
-            newdiff += "+++ %s\n" % newFile
-            f = open(newFile, "r")
-            for line in f.readlines():
-                newdiff += "+" + line
-            f.close()
-
-        # change description file: submitTemplate, separatorLine, diff, newdiff
-        (handle, fileName) = tempfile.mkstemp()
-        tmpFile = os.fdopen(handle, "w+")
-        if self.isWindows:
-            submitTemplate = submitTemplate.replace("\n", "\r\n")
-            separatorLine = separatorLine.replace("\n", "\r\n")
-            newdiff = newdiff.replace("\n", "\r\n")
-        tmpFile.write(submitTemplate + separatorLine + diff + newdiff)
-        tmpFile.close()
-
         if self.prepare_p4_only:
+            (handle, fileName) = tempfile.mkstemp()
+            tmpFile = os.fdopen(handle, "w+")
+            if self.isWindows:
+                submitTemplate = submitTemplate.replace("\n", "\r\n")
+            tmpFile.write(submitTemplate)
+            tmpFile.close()
+
             #
             # Leave the p4 tree prepared, and the submit template around
             # and let the user decide what to do next
@@ -1463,6 +1439,38 @@ class P4Submit(Command, P4UserMap):
             print
             return True
 
+        else:
+            separatorLine = "######## everything below this line is just the diff #######\n"
+
+            # diff
+            if os.environ.has_key("P4DIFF"):
+                del(os.environ["P4DIFF"])
+            diff = ""
+            for editedFile in editedFiles:
+                diff += p4_read_pipe(['diff', '-du',
+                                      wildcard_encode(editedFile)])
+
+            # new file diff
+            newdiff = ""
+            for newFile in filesToAdd:
+                newdiff += "==== new file ====\n"
+                newdiff += "--- /dev/null\n"
+                newdiff += "+++ %s\n" % newFile
+                f = open(newFile, "r")
+                for line in f.readlines():
+                    newdiff += "+" + line
+                f.close()
+
+            # change description file: submitTemplate, separatorLine, diff, newdiff
+            (handle, fileName) = tempfile.mkstemp()
+            tmpFile = os.fdopen(handle, "w+")
+            if self.isWindows:
+                submitTemplate = submitTemplate.replace("\n", "\r\n")
+                separatorLine = separatorLine.replace("\n", "\r\n")
+                newdiff = newdiff.replace("\n", "\r\n")
+            tmpFile.write(submitTemplate + separatorLine + diff + newdiff)
+            tmpFile.close()
+
         #
         # Let the user edit the change description, then submit it.
         #
-- 
1.8.5.2
