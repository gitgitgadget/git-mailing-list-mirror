From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v3 20/20] remote-hg: fix bad file paths
Date: Mon,  8 Apr 2013 12:13:34 -0500
Message-ID: <1365441214-21096-21-git-send-email-felipe.contreras@gmail.com>
References: <1365441214-21096-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Max Horn <max@quendi.de>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 08 19:16:18 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UPFft-0005gW-Op
	for gcvg-git-2@plane.gmane.org; Mon, 08 Apr 2013 19:16:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934722Ab3DHRPw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Apr 2013 13:15:52 -0400
Received: from mail-oa0-f45.google.com ([209.85.219.45]:35560 "EHLO
	mail-oa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760775Ab3DHRPq (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Apr 2013 13:15:46 -0400
Received: by mail-oa0-f45.google.com with SMTP id o6so6330985oag.4
        for <git@vger.kernel.org>; Mon, 08 Apr 2013 10:15:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=6qWUZO8hJ5WsFGEC41JuCvzdVFaDQrGeSc+JYtyk10g=;
        b=h3HblayaK+r94UQeWPCGH9aK/eAijtEyzTrRCyceBpk6qtsKejzT1ajXHiDM3yfThg
         SiQOqeY/o7JRMmCBiW19IJU75a49XWTyHBne6h+UwzAjEEUuD5TLwYGuIZb1BR10Ygnw
         ja2X/soMZ1C28GuBFBBWyzZFZfSqkps0rGNKFyEopUiSC1+mNSaCVhDokKLGJHvauXtA
         AEkHDQC3gJVVRXhsEX0vuLa6B+dkqjVQxTD+ib+n0DIa5A4kpLGYZPgDSwKXtSM1nsCz
         lFRv+SqdoDf2zr08GrgteQyCQN3nD9WqCXgQTnR2TpNHx29+4564+n0TI+h2VMMr90IS
         Mjdw==
X-Received: by 10.60.29.161 with SMTP id l1mr16450083oeh.111.1365441346027;
        Mon, 08 Apr 2013 10:15:46 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPS id a3sm26142426oee.8.2013.04.08.10.15.44
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 08 Apr 2013 10:15:45 -0700 (PDT)
X-Mailer: git-send-email 1.8.2
In-Reply-To: <1365441214-21096-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220458>

Mercurial allows absolute file paths, and Git doesn't like that.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 contrib/remote-helpers/git-remote-hg | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/contrib/remote-helpers/git-remote-hg b/contrib/remote-helpers/git-remote-hg
index 37e6aec..d45f16d 100755
--- a/contrib/remote-helpers/git-remote-hg
+++ b/contrib/remote-helpers/git-remote-hg
@@ -205,9 +205,15 @@ class Parser:
         tz = ((tz / 100) * 3600) + ((tz % 100) * 60)
         return (user, int(date), -tz)
 
+def fix_file_path(path):
+    if not os.path.isabs(path):
+        return path
+    return os.path.relpath(path, '/')
+
 def export_file(fc):
     d = fc.data()
-    print "M %s inline %s" % (gitmode(fc.flags()), fc.path())
+    path = fix_file_path(fc.path())
+    print "M %s inline %s" % (gitmode(fc.flags()), path)
     print "data %d" % len(d)
     print d
 
@@ -401,7 +407,7 @@ def export_ref(repo, name, kind, head):
         for f in modified:
             export_file(c.filectx(f))
         for f in removed:
-            print "D %s" % (f)
+            print "D %s" % (fix_file_path(f))
         print
 
         count += 1
-- 
1.8.2
