From: Maxime Coste <frrrwww@gmail.com>
Subject: [PATCH] Fix git-p4 submit in non --prepare-p4-only mode
Date: Tue, 10 Jun 2014 13:14:46 +0100
Message-ID: <20140610121446.GA25634@nekage>
References: <20140110181807.GA29164@nekage>
 <20140112222946.GA13519@padd.com>
 <20140113121011.GA9711@nekage>
 <20140114000613.GA11594@padd.com>
 <20140524013942.GA29751@nekage>
 <20140524135215.GA9386@padd.com>
 <20140524174034.GA7560@nekage>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Pete Wyckoff <pw@padd.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 10 14:10:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WuKtF-0006QW-La
	for gcvg-git-2@plane.gmane.org; Tue, 10 Jun 2014 14:10:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751316AbaFJMKy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2014 08:10:54 -0400
Received: from mail-we0-f169.google.com ([74.125.82.169]:48349 "EHLO
	mail-we0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751099AbaFJMKx (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2014 08:10:53 -0400
Received: by mail-we0-f169.google.com with SMTP id t60so2116125wes.0
        for <git@vger.kernel.org>; Tue, 10 Jun 2014 05:10:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=QFCFlZQlRCmZKTIGhRIMTKW9ZqqS3ONlgK/vERUqdXM=;
        b=V09aHpbyie7+c/YIh9wIaik2a2Hcp8oZmXMAVM/dvMd9lKQlvlEOrtW1sQNTJXB02S
         Zc8ltB7XOY0tCuuYfenMFV7MdGbIUAdZPVLciBPZjH6CP3WMTY5UMjvOeAXQlG77WPyZ
         AlICC689oSA6aknqV2iL1HzycdtG17cavOa6ykZE6we6JniWBngLbPBzmNc+8I8xhB7m
         TUmsLatlzVlaAThrAJJKWnJJvcNOeJER9kLAwkpphrMKh4emfpyfOlmNKLhtS4Gpg5aK
         n/qg1mHKOfvd+cQCnrmK7GYIqP6hUHiTUAW836p73MHC+ffAd79sn8TMyD3HWf9mTlfF
         VcXg==
X-Received: by 10.194.190.42 with SMTP id gn10mr41418538wjc.9.1402402251688;
        Tue, 10 Jun 2014 05:10:51 -0700 (PDT)
Received: from localhost ([46.7.115.253])
        by mx.google.com with ESMTPSA id cd1sm2641878wjc.19.2014.06.10.05.10.50
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 10 Jun 2014 05:10:51 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20140524174034.GA7560@nekage>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251181>

b4073bb387ef303c9ac3c044f46d6a8ae6e190f0 broke git p4 submit, here
is a proper fix, including proper handling for windows end of lines.

Signed-off-by: Maxime Coste <frrrwww@gmail.com>
---
 git-p4.py | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 7bb0f73..ff132b2 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -1238,7 +1238,7 @@ class P4Submit(Command, P4UserMap):
             if response == 'n':
                 return False
 
-    def get_diff_description(self, editedFiles):
+    def get_diff_description(self, editedFiles, filesToAdd):
         # diff
         if os.environ.has_key("P4DIFF"):
             del(os.environ["P4DIFF"])
@@ -1258,7 +1258,7 @@ class P4Submit(Command, P4UserMap):
                 newdiff += "+" + line
             f.close()
 
-        return diff + newdiff
+        return (diff + newdiff).replace('\r\n', '\n')
 
     def applyCommit(self, id):
         """Apply one commit, return True if it succeeded."""
@@ -1422,10 +1422,10 @@ class P4Submit(Command, P4UserMap):
         separatorLine = "######## everything below this line is just the diff #######\n"
         if not self.prepare_p4_only:
             submitTemplate += separatorLine
-            submitTemplate += self.get_diff_description(editedFiles)
+            submitTemplate += self.get_diff_description(editedFiles, filesToAdd)
 
         (handle, fileName) = tempfile.mkstemp()
-        tmpFile = os.fdopen(handle, "w+")
+        tmpFile = os.fdopen(handle, "w+b")
         if self.isWindows:
             submitTemplate = submitTemplate.replace("\n", "\r\n")
         tmpFile.write(submitTemplate)
@@ -1475,9 +1475,9 @@ class P4Submit(Command, P4UserMap):
             tmpFile = open(fileName, "rb")
             message = tmpFile.read()
             tmpFile.close()
-            submitTemplate = message[:message.index(separatorLine)]
             if self.isWindows:
-                submitTemplate = submitTemplate.replace("\r\n", "\n")
+                message = message.replace("\r\n", "\n")
+            submitTemplate = message[:message.index(separatorLine)]
             p4_write_pipe(['submit', '-i'], submitTemplate)
 
             if self.preserveUser:
-- 
2.0.0
