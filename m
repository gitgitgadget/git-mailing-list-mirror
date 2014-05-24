From: Maxime Coste <frrrwww@gmail.com>
Subject: [PATCH] git-p4: Do not include diff in spec file when just preparing
 p4
Date: Sat, 24 May 2014 18:40:35 +0100
Message-ID: <20140524174034.GA7560@nekage>
References: <20140110181807.GA29164@nekage>
 <20140112222946.GA13519@padd.com>
 <20140113121011.GA9711@nekage>
 <20140114000613.GA11594@padd.com>
 <20140524013942.GA29751@nekage>
 <20140524135215.GA9386@padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Pete Wyckoff <pw@padd.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat May 24 19:37:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WoFsq-0005Z0-1b
	for gcvg-git-2@plane.gmane.org; Sat, 24 May 2014 19:37:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751231AbaEXRhL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 24 May 2014 13:37:11 -0400
Received: from mail-we0-f181.google.com ([74.125.82.181]:47004 "EHLO
	mail-we0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751133AbaEXRhK (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 24 May 2014 13:37:10 -0400
Received: by mail-we0-f181.google.com with SMTP id w61so6341578wes.12
        for <git@vger.kernel.org>; Sat, 24 May 2014 10:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=m/J2QoTPSuaZWQcyGXgUl7LJHgdVHW+j6bkhLBf9f2U=;
        b=KRbb01Z7qkCZeGvyv0LpGSeq8V88QSI6CkSo2EL+QNrtsP2Cx0OKfxIyPLV/yNS2Zw
         HhsfkECRQIxI9b3qG6OQ01Lr/vxC7/EQCuk2GO+KFsSPjI2PY2jVwgqhX0k1WUoK0IGK
         5trfB+0M4tazdLrZa8nbnfgNzyf6qplvFAsE44aIFjb8olfMDlLw7ca+UNo8SLs2Eznt
         MDY5VYjRPevcLV46Si27ozHhUTqCrU3rFTlzOcqMvNxO3O60c0fCY0jLP0ZZuahRzTBs
         8ZZALqNGf0YxXKUXJ+Pk/HHV/ik79LuQzThRqMP00cVYBF74KFUVkT/3E4JAvcRFBeHr
         MoRQ==
X-Received: by 10.180.19.201 with SMTP id h9mr12845361wie.17.1400953028777;
        Sat, 24 May 2014 10:37:08 -0700 (PDT)
Received: from localhost ([109.255.47.65])
        by mx.google.com with ESMTPSA id v15sm12023779wjq.17.2014.05.24.10.37.07
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 24 May 2014 10:37:08 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20140524135215.GA9386@padd.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250063>

The diff information render the spec file unusable as is by p4,
do not include it when run with --prepare-p4-only so that the
given file can be directly passed to p4.

With --prepare-p4-only, git-p4 already tells the user it can use
p4 submit with the generated spec file. This fails because of the
diff being present in the file. Not including the diff fixes that.

Without --prepare-p4-only, keeping the diff makes sense for a
quick review of the patch before submitting it. And does not cause
problems with p4 as we remove it programmatically.

Signed-off-by: Maxime Coste <frrrwww@gmail.com>
Acked-by: Pete Wyckoff <pw@padd.com>
---
 git-p4.py                | 49 +++++++++++++++++++++++++-----------------------
 t/t9807-git-p4-submit.sh |  3 ++-
 2 files changed, 28 insertions(+), 24 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 773cafc..7bb0f73 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -1238,6 +1238,28 @@ class P4Submit(Command, P4UserMap):
             if response == 'n':
                 return False
 
+    def get_diff_description(self, editedFiles):
+        # diff
+        if os.environ.has_key("P4DIFF"):
+            del(os.environ["P4DIFF"])
+        diff = ""
+        for editedFile in editedFiles:
+            diff += p4_read_pipe(['diff', '-du',
+                                  wildcard_encode(editedFile)])
+
+        # new file diff
+        newdiff = ""
+        for newFile in filesToAdd:
+            newdiff += "==== new file ====\n"
+            newdiff += "--- /dev/null\n"
+            newdiff += "+++ %s\n" % newFile
+            f = open(newFile, "r")
+            for line in f.readlines():
+                newdiff += "+" + line
+            f.close()
+
+        return diff + newdiff
+
     def applyCommit(self, id):
         """Apply one commit, return True if it succeeded."""
 
@@ -1398,34 +1420,15 @@ class P4Submit(Command, P4UserMap):
             submitTemplate += "######## Variable git-p4.skipUserNameCheck hides this message.\n"
 
         separatorLine = "######## everything below this line is just the diff #######\n"
+        if not self.prepare_p4_only:
+            submitTemplate += separatorLine
+            submitTemplate += self.get_diff_description(editedFiles)
 
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
         (handle, fileName) = tempfile.mkstemp()
         tmpFile = os.fdopen(handle, "w+")
         if self.isWindows:
             submitTemplate = submitTemplate.replace("\n", "\r\n")
-            separatorLine = separatorLine.replace("\n", "\r\n")
-            newdiff = newdiff.replace("\n", "\r\n")
-        tmpFile.write(submitTemplate + separatorLine + diff + newdiff)
+        tmpFile.write(submitTemplate)
         tmpFile.close()
 
         if self.prepare_p4_only:
diff --git a/t/t9807-git-p4-submit.sh b/t/t9807-git-p4-submit.sh
index 4caf36e..7fab2ed 100755
--- a/t/t9807-git-p4-submit.sh
+++ b/t/t9807-git-p4-submit.sh
@@ -403,7 +403,8 @@ test_expect_success 'submit --prepare-p4-only' '
 		git commit -m "prep only add" &&
 		git p4 submit --prepare-p4-only >out &&
 		test_i18ngrep "prepared for submission" out &&
-		test_i18ngrep "must be deleted" out
+		test_i18ngrep "must be deleted" out &&
+		! test_i18ngrep "everything below this line is just the diff" out
 	) &&
 	(
 		cd "$cli" &&
-- 
1.9.3
