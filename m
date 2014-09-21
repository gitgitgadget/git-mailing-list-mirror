From: Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH] mailinfo: resolve -Wstring-plus-int warning
Date: Sun, 21 Sep 2014 05:13:58 -0400
Message-ID: <1411290838-45622-1-git-send-email-sunshine@sunshineco.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 21 11:14:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XVdEF-0005T7-Jf
	for gcvg-git-2@plane.gmane.org; Sun, 21 Sep 2014 11:14:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751680AbaIUJOf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Sep 2014 05:14:35 -0400
Received: from mail-ie0-f176.google.com ([209.85.223.176]:49835 "EHLO
	mail-ie0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751115AbaIUJOe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Sep 2014 05:14:34 -0400
Received: by mail-ie0-f176.google.com with SMTP id ar1so5886043iec.21
        for <git@vger.kernel.org>; Sun, 21 Sep 2014 02:14:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id;
        bh=KNkuUE5CccFKjB/FQ08E9N9c/mZsdbdcC/NqpwOoXHo=;
        b=nwMg1zD00avw4e4Pixns8YqezCKP53iDC+XvOlRcTHWGm0YsSTzW0yiKcpy7/SN+f1
         CWYvyemyEDc02aqBCAFAzTv++mtZ518PqMiFnqNy5fCWzcuz8XM/YoNKq1eZ2D5z+llz
         Btd1av5HT0YnF/WAeGG7/D2M8NwrxP+SUfhHyUuGG7S3qeTKgz60Mkn+YU8KDaqWeJIF
         pVBtW+irYtoxdk6CrVK0Kqo+aOHW3xlgAnrWFsvJ790B+0bb3aDSQ9kqj+vjrmd6sBkQ
         M7VaSARvJIO823+xtybaz1ViVW3/YEW4nvPLtegIGoh/LdPYKFUfq0w3JRub29bohgY3
         vwOw==
X-Received: by 10.50.102.73 with SMTP id fm9mr7359468igb.44.1411290873568;
        Sun, 21 Sep 2014 02:14:33 -0700 (PDT)
Received: from localhost.localdomain (user-12l3cpl.cable.mindspring.com. [69.81.179.53])
        by mx.google.com with ESMTPSA id a2sm6095320igx.4.2014.09.21.02.14.32
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sun, 21 Sep 2014 02:14:33 -0700 (PDT)
X-Mailer: git-send-email 2.1.1.391.g7a54a76.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257345>

The just-released Apple Xcode 6.0.1 has -Wstring-plus-int enabled by
default which complains about pointer arithmetic applied to a string
literal:

    builtin/mailinfo.c:303:24: warning:
        adding 'long' to a string does not append to the string
            return !memcmp(SAMPLE + (cp - line), cp, strlen(SAMPLE) ...
                           ~~~~~~~^~~~~~~~~~~~~

Resolve this issue.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---

This is atop 2da1f366 (mailinfo: make ">From" in-body header check more
robust; 2014-09-13) in 'next'.

In addition to the above diagnostic, the Apple compiler also helpfully
recommends &SAMPLE[cp - line] as a replacement to avoid the warning,
however, the solution in this patch allows us drop a couple strlen()s in
favor of sizeof()s.

 builtin/mailinfo.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/builtin/mailinfo.c b/builtin/mailinfo.c
index 2632fb0..b6b1c19 100644
--- a/builtin/mailinfo.c
+++ b/builtin/mailinfo.c
@@ -288,19 +288,20 @@ static inline int cmp_header(const struct strbuf *line, const char *hdr)
 			line->buf[len] == ':' && isspace(line->buf[len + 1]);
 }
 
-#define SAMPLE "From e6807f3efca28b30decfecb1732a56c7db1137ee Mon Sep 17 00:00:00 2001\n"
 static int is_format_patch_separator(const char *line, int len)
 {
+	static const char SAMPLE[] =
+		"From e6807f3efca28b30decfecb1732a56c7db1137ee Mon Sep 17 00:00:00 2001\n";
 	const char *cp;
 
-	if (len != strlen(SAMPLE))
+	if (len != sizeof(SAMPLE) - 1)
 		return 0;
 	if (!skip_prefix(line, "From ", &cp))
 		return 0;
 	if (strspn(cp, "0123456789abcdef") != 40)
 		return 0;
 	cp += 40;
-	return !memcmp(SAMPLE + (cp - line), cp, strlen(SAMPLE) - (cp - line));
+	return !memcmp(SAMPLE + (cp - line), cp, sizeof(SAMPLE) - 1 - (cp - line));
 }
 
 static int check_header(const struct strbuf *line,
-- 
2.1.1.391.g7a54a76.dirty
