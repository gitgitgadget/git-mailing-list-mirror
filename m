From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v11 04/13] utf8: add function to align a string into given strbuf
Date: Sat, 15 Aug 2015 23:30:34 +0530
Message-ID: <1439661643-16094-5-git-send-email-Karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	gitster@pobox.com, Karthik Nayak <Karthik.188@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 15 20:00:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZQflJ-0001Hw-OZ
	for gcvg-git-2@plane.gmane.org; Sat, 15 Aug 2015 20:00:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754180AbbHOSAz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Aug 2015 14:00:55 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:36241 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754089AbbHOSAt (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Aug 2015 14:00:49 -0400
Received: by pacrr5 with SMTP id rr5so80465768pac.3
        for <git@vger.kernel.org>; Sat, 15 Aug 2015 11:00:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=7b/m04OJUJEWQS3ZGSA1wHtbWx15EYzQ1ged6A/SsK0=;
        b=PY3qzsTTkegx7aGnAMejh1TFG1g5sXT5hGVyt82FloOtLmjWL8ZYdzGhpR9uGyIgdz
         NzgBwqh4yQE1ak+vQs/f2QCJ4jx34/d5nKVuCeqMdqa630aQgvBW6UsmzDgw2/gffUpG
         YoLOc5lN2pXx/rRnQrsyddzs1zwQNyP9THW73ln+VP5GL1Tvv/eq5jc7dS+tWMTBjP1k
         fb4fxp84Y6wPKcXloidg+hLz/H34rm4t1A4e9cUd+5kG8g+VB++DstzIjmEnY/lRjK0T
         FwotxEcJ0fT0pfdCU4cTZ176btMfGoCUmFGC+2IjwvRkupiY1Z97ClOrnhRE8wMj6yeJ
         E//g==
X-Received: by 10.66.231.69 with SMTP id te5mr35248606pac.98.1439661648777;
        Sat, 15 Aug 2015 11:00:48 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by smtp.gmail.com with ESMTPSA id pe3sm9424144pdb.55.2015.08.15.11.00.46
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 15 Aug 2015 11:00:48 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.5.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275996>

Add strbuf_utf8_align() which will align a given string into a strbuf
as per given align_type and width. If the width is greater than the
string length then no alignment is performed.

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 utf8.c | 21 +++++++++++++++++++++
 utf8.h | 15 +++++++++++++++
 2 files changed, 36 insertions(+)

diff --git a/utf8.c b/utf8.c
index 28e6d76..0fb8e9d 100644
--- a/utf8.c
+++ b/utf8.c
@@ -644,3 +644,24 @@ int skip_utf8_bom(char **text, size_t len)
 	*text += strlen(utf8_bom);
 	return 1;
 }
+
+void strbuf_utf8_align(struct strbuf *buf, align_type position, unsigned int width,
+		       const char *s)
+{
+	int slen = strlen(s);
+	int display_len = utf8_strnwidth(s, slen, 0);
+	int utf8_compensation = slen - display_len;
+
+	if (display_len >= width) {
+		strbuf_addstr(buf, s);
+		return;
+	}
+
+	if (position == ALIGN_LEFT)
+		strbuf_addf(buf, "%-*s", width + utf8_compensation, s);
+	else if (position == ALIGN_MIDDLE) {
+		int left = (width - display_len)/2;
+		strbuf_addf(buf, "%*s%-*s", left, "", width - left + utf8_compensation, s);
+	} else if (position == ALIGN_RIGHT)
+		strbuf_addf(buf, "%*s", width + utf8_compensation, s);
+}
diff --git a/utf8.h b/utf8.h
index 5a9e94b..7930b44 100644
--- a/utf8.h
+++ b/utf8.h
@@ -55,4 +55,19 @@ int mbs_chrlen(const char **text, size_t *remainder_p, const char *encoding);
  */
 int is_hfs_dotgit(const char *path);
 
+typedef enum {
+	ALIGN_LEFT,
+	ALIGN_MIDDLE,
+	ALIGN_RIGHT
+} align_type;
+
+/*
+ * Align the string given and store it into a strbuf as per the
+ * 'position' and 'width'. If the given string length is larger than
+ * 'width' than then the input string is not truncated and no
+ * alignment is done.
+ */
+void strbuf_utf8_align(struct strbuf *buf, align_type position, unsigned int width,
+		       const char *s);
+
 #endif
-- 
2.5.0
