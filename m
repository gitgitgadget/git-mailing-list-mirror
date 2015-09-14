From: larsxschneider@gmail.com
Subject: [PATCH v7] git-p4: improve path encoding verbose output
Date: Mon, 14 Sep 2015 19:10:40 +0200
Message-ID: <1442250640-93838-2-git-send-email-larsxschneider@gmail.com>
References: <1442250640-93838-1-git-send-email-larsxschneider@gmail.com>
Cc: luke@diamand.org, Lars Schneider <larsxschneider@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 14 19:10:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZbXHG-0000nx-82
	for gcvg-git-2@plane.gmane.org; Mon, 14 Sep 2015 19:10:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754661AbbINRKq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Sep 2015 13:10:46 -0400
Received: from mail-wi0-f174.google.com ([209.85.212.174]:38249 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753927AbbINRKp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Sep 2015 13:10:45 -0400
Received: by wiclk2 with SMTP id lk2so141831703wic.1
        for <git@vger.kernel.org>; Mon, 14 Sep 2015 10:10:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yoT3up79CfbUp+pev7EgdFvJyAeVILemUg34GpKGvXs=;
        b=QwKiGS7UObUwHWDQSuu22gW8mcKNFGmFmfyNMn/xtzZtx3kxZoFFRQ4SvVaM6RlrCn
         4X5EdoceUZ73RCqxI5uc+3YgyjMiNaU0XejDjr1Ov/v9xEf5PaYfkhFims6oa6o03Uw0
         stKNDnMVffRFgoiB3GIOb+xqyFMejG4yRcSayvWMcBUEadCUe/UHgYJIXeGDjD7RsEQ3
         OzNdEKlnz1KNhLGWe6W620vk23eWEmw826BQsEaaw+00gkt9OGKpl4xTm6MHDU+YzbYN
         G1LjELHUKCE1Ddyfb4WzXkwqAKBkZaQVDbvkdRvxEnPphil53Gy3PAhkhD+l6aHjVhDp
         ndGw==
X-Received: by 10.180.104.68 with SMTP id gc4mr27760231wib.78.1442250643815;
        Mon, 14 Sep 2015 10:10:43 -0700 (PDT)
Received: from slxBook3.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id qc4sm2276533wjc.33.2015.09.14.10.10.42
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 14 Sep 2015 10:10:43 -0700 (PDT)
X-Mailer: git-send-email 2.5.1
In-Reply-To: <1442250640-93838-1-git-send-email-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277842>

From: Lars Schneider <larsxschneider@gmail.com>

If a path with non-ASCII characters is detected then print always the
encoding and the encoded string in verbose mode.

Signed-off-by: Lars Schneider <larsxschneider@gmail.com>
---
 git-p4.py | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index d45cf2b..da25d3f 100755
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
+                relPath = relPath.decode(encoding).encode('utf8', 'replace')
+            if self.verbose:
+                print 'Path with non-ASCII characters detected. Used %s to encode: %s ' % (encoding, relPath)
 
         self.gitStream.write("M %s inline %s\n" % (git_mode, relPath))
 
-- 
2.5.1
