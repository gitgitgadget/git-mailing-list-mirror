From: larsxschneider@gmail.com
Subject: [PATCH v2] git-p4: improve path encoding verbose output
Date: Wed, 16 Sep 2015 14:37:04 +0200
Message-ID: <1442407024-33516-2-git-send-email-larsxschneider@gmail.com>
References: <1442407024-33516-1-git-send-email-larsxschneider@gmail.com>
Cc: gitster@pobox.com, luke@diamand.org,
	Lars Schneider <larsxschneider@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 16 14:37:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZcBxc-00081d-5h
	for gcvg-git-2@plane.gmane.org; Wed, 16 Sep 2015 14:37:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752515AbbIPMhL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Sep 2015 08:37:11 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:38249 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752286AbbIPMhI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Sep 2015 08:37:08 -0400
Received: by wiclk2 with SMTP id lk2so68842702wic.1
        for <git@vger.kernel.org>; Wed, 16 Sep 2015 05:37:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mV5an4he3xBjUCnxIyNMRS7V4/7SfdZS/rPr/vDlhsU=;
        b=WpiTqPm0MaQMdsxNksxRhCelenfbqIBtEaJp0KdP0fJd8+qu7gXT0AhcXkSkjbjKCf
         Qd+E6Ef+wY+2tfMnNqFC6qpMFataP/jupeV86YcDy9Bhlx73nPiWyjl8/MQvzgR9KMJc
         YVtQ2+x7b8QhJXlDrKzdRp27BIwGMUlI8LFCwL4kLUf5UdCbotfIFJGshdwWoKjt+cn7
         o6I3EgQc06yfQha8UQGr2nH4s5aiC2QiJIwuC/1pNRIFONMQyEX442GCWa1zJ6iVnkZy
         piArtATbI5mlparJjQtI25gKxU71azeg5+onnSJpGJT9FKMGvoUXyIEUH+3zVB0MS7A/
         Y6gA==
X-Received: by 10.180.85.229 with SMTP id k5mr18680850wiz.76.1442407027230;
        Wed, 16 Sep 2015 05:37:07 -0700 (PDT)
Received: from slxBook3.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id bi6sm26402377wjc.25.2015.09.16.05.37.06
        (version=TLSv1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 16 Sep 2015 05:37:06 -0700 (PDT)
X-Mailer: git-send-email 2.5.1
In-Reply-To: <1442407024-33516-1-git-send-email-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278026>

From: Lars Schneider <larsxschneider@gmail.com>

If a path with non-ASCII characters is detected then print the
encoding and the encoded string in verbose mode.

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 git-p4.py | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index d45cf2b..e7510a9 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -2220,16 +2220,15 @@ class P4Sync(Command, P4UserMap):
             text = regexp.sub(r'$\1$', text)
             contents = [ text ]
 
-        if gitConfig("git-p4.pathEncoding"):
-            relPath = relPath.decode(gitConfig("git-p4.pathEncoding")).encode('utf8', 'replace')
-        elif self.verbose:
-            try:
-                relPath.decode('ascii')
-            except:
-                print (
-                    "Path with Non-ASCII characters detected and no path encoding defined. "
-                    "Please check the encoding: %s" % relPath
-                )
+        try:
+            relPath.decode('ascii')
+        except:
+            encoding = 'utf8'
+            if gitConfig('git-p4.pathEncoding'):
+                encoding = gitConfig('git-p4.pathEncoding')
+            relPath = relPath.decode(encoding).encode('utf8', 'replace')
+            if self.verbose:
+                print 'Path with non-ASCII characters detected. Used %s to encode: %s ' % (encoding, relPath)
 
         self.gitStream.write("M %s inline %s\n" % (git_mode, relPath))
 
-- 
2.5.1
