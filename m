From: larsxschneider@gmail.com
Subject: [PATCH v1 2/2] git-p4: handle "Translation of file content failed"
Date: Mon,  7 Sep 2015 14:42:03 +0200
Message-ID: <1441629723-90604-3-git-send-email-larsxschneider@gmail.com>
References: <1441629723-90604-1-git-send-email-larsxschneider@gmail.com>
Cc: luke@diamand.org, Lars Schneider <larsxschneider@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 07 14:42:33 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZYvkY-0002lH-Vo
	for gcvg-git-2@plane.gmane.org; Mon, 07 Sep 2015 14:42:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751252AbbIGMmP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Sep 2015 08:42:15 -0400
Received: from mail-wi0-f173.google.com ([209.85.212.173]:33769 "EHLO
	mail-wi0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751040AbbIGMmN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Sep 2015 08:42:13 -0400
Received: by wiclk2 with SMTP id lk2so87565215wic.0
        for <git@vger.kernel.org>; Mon, 07 Sep 2015 05:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=nvAPTpUG6rE4XEOd5fN/SN5kP2woIDdv7cFABTSNbOA=;
        b=UCJcpogs8exttUn/tPRvfegPEkHNxXeYNqouK1apsRJbZnR63ioGV6WvGM2xMSVP7o
         m162wMqHURsZI+opr7g9p8N933RqXn6p6z8aTgAnevP4lQODiVRFR8AIHGwiVHn5bNSe
         oBUMuK88NAm7fC8IZPl5I0Rw2UybDZM5nH0faCqhvu9QKMYTLqBACQ9CIGmpSuqmeOOz
         UNPuqJBP2DklIhZfEff3hXCeupLBmm9XuOJG3OGXEE0uxeqYctDwC3AgYlWQ2uELGW4E
         9THwgOIdmTB+E3OUatEJyAeY6wunQjJU5Tnuf7+A14LTDSvYK3Vxe1RA5swuran+80ka
         Vdlg==
X-Received: by 10.194.242.166 with SMTP id wr6mr33762854wjc.31.1441629732757;
        Mon, 07 Sep 2015 05:42:12 -0700 (PDT)
Received: from slxBook3.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id ul1sm19891852wjc.30.2015.09.07.05.42.12
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 07 Sep 2015 05:42:12 -0700 (PDT)
X-Mailer: git-send-email 2.5.1
In-Reply-To: <1441629723-90604-1-git-send-email-larsxschneider@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277458>

From: Lars Schneider <larsxschneider@gmail.com>

A P4 repository can get into a state where it contains a file with file
type UTF16 that does not not contain valid UTF16 characters. If git-p4
attempts to retrieve the file as UTF16 from P4 then the process crashes
with a "Translation of file content failed" error.

Fix this by detecting this error and retrieving the file as binary
instead. The result in Git is the same.
---
 git-p4.py | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 36a4bcb..aaa0ad9 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -2186,10 +2186,17 @@ class P4Sync(Command, P4UserMap):
             # them back too.  This is not needed to the cygwin windows version,
             # just the native "NT" type.
             #
-            text = p4_read_pipe(['print', '-q', '-o', '-', "%s@%s" % (file['depotFile'], file['change']) ])
-            if p4_version_string().find("/NT") >= 0:
-                text = text.replace("\r\n", "\n")
-            contents = [ text ]
+            try:
+                text = p4_read_pipe(['print', '-q', '-o', '-', '%s@%s' % (file['depotFile'], file['change'])])
+            except Exception as e:
+                if 'Translation of file content failed' in str(e):
+                    type_base = 'binary'
+                else:
+                    raise e
+            else:
+                if p4_version_string().find('/NT') >= 0:
+                    text = text.replace('\r\n', '\n')
+                contents = [ text ]
 
         if type_base == "apple":
             # Apple filetype files will be streamed as a concatenation of
-- 
2.5.1
