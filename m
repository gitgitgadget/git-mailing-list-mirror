From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: [PATCH 4/7] builtin/log: teach show about OBJ_LINK
Date: Fri,  5 Apr 2013 00:00:40 +0530
Message-ID: <1365100243-13676-5-git-send-email-artagnon@gmail.com>
References: <1365100243-13676-1-git-send-email-artagnon@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Apr 04 20:30:04 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNovD-0007fT-GN
	for gcvg-git-2@plane.gmane.org; Thu, 04 Apr 2013 20:30:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1764547Ab3DDS3Y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Apr 2013 14:29:24 -0400
Received: from mail-pd0-f169.google.com ([209.85.192.169]:59955 "EHLO
	mail-pd0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764537Ab3DDS3W (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Apr 2013 14:29:22 -0400
Received: by mail-pd0-f169.google.com with SMTP id 10so1590088pdc.28
        for <git@vger.kernel.org>; Thu, 04 Apr 2013 11:29:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        bh=bKn0fE9Xy0mEP5xYd/sKUmXbExR5DBEyx9UWT/lh1WI=;
        b=uf2cAlVBRIUyciRMP6sf80ViTFIHjbtrk7GKXaWDFLt2hURKcE0XjuW7RN7OrtipPi
         Ek2ddYPxS4mwQRWZ+FR6o3RvWgJ3C9KxrCiScJejcrLGaHPdsUqibPxhmqGHkpmUK3KD
         HAmknTOzLGvgg9Yh8rJ8odWfjNxyuUtQ9wiweh4AVUEKqmpNP2UbmcuV0t/j7zIjTUlf
         7e7Zq4+xBshEH+BSMMfxIu2JmTWgbR4xFN7H4dTbh+ypURTr3R2uQhdp+3khWbY1ur82
         +8eRIwiabm1JcQ+GpkCdRbBtfjhEyLJZIG/+7h3QAak7cphIYjEoScg0mxMYFUGYIDM0
         2v1g==
X-Received: by 10.66.119.7 with SMTP id kq7mr10964707pab.116.1365100162327;
        Thu, 04 Apr 2013 11:29:22 -0700 (PDT)
Received: from localhost.localdomain ([122.174.41.36])
        by mx.google.com with ESMTPS id xl10sm12418525pac.15.2013.04.04.11.29.20
        (version=TLSv1.2 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 04 Apr 2013 11:29:21 -0700 (PDT)
X-Mailer: git-send-email 1.8.2.380.g0d4e79b
In-Reply-To: <1365100243-13676-1-git-send-email-artagnon@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220051>

'git show' now works with link objects.

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>
---
 builtin/log.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/builtin/log.c b/builtin/log.c
index 0f31810..a170df9 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -411,6 +411,20 @@ static int show_blob_object(const unsigned char *sha1, struct rev_info *rev)
 	return stream_blob_to_fd(1, sha1, NULL, 0);
 }
 
+static int show_link_object(const unsigned char *sha1, struct rev_info *rev)
+{
+	unsigned long size;
+	enum object_type type;
+	char *buf = read_sha1_file(sha1, &type, &size);
+
+	if (!buf)
+		return error(_("Could not read object %s"), sha1_to_hex(sha1));
+
+	assert(type == OBJ_LINK);
+	printf("%s", buf);
+	return 0;
+}
+
 static int show_tag_object(const unsigned char *sha1, struct rev_info *rev)
 {
 	unsigned long size;
@@ -534,6 +548,9 @@ int cmd_show(int argc, const char **argv, const char *prefix)
 			add_object_array(o, name, &rev.pending);
 			ret = cmd_log_walk(&rev);
 			break;
+		case OBJ_LINK:
+			ret = show_link_object(o->sha1, NULL);
+			break;
 		default:
 			ret = error(_("Unknown type: %d"), o->type);
 		}
-- 
1.8.2.380.g0d4e79b
