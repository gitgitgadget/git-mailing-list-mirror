From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v10 04/13] utf8: add function to align a string into given strbuf
Date: Sun,  9 Aug 2015 19:41:37 +0530
Message-ID: <1439129506-9989-5-git-send-email-Karthik.188@gmail.com>
References: <1439129506-9989-1-git-send-email-Karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	gitster@pobox.com, Karthik Nayak <Karthik.188@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Aug 09 16:12:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZORKt-0006u7-Rv
	for gcvg-git-2@plane.gmane.org; Sun, 09 Aug 2015 16:12:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933023AbbHIOML (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Aug 2015 10:12:11 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:35564 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754541AbbHIOLz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Aug 2015 10:11:55 -0400
Received: by pacgr6 with SMTP id gr6so8152021pac.2
        for <git@vger.kernel.org>; Sun, 09 Aug 2015 07:11:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=c3rdEQE2HNhxg1GjOHs48+Z9Cj8zUNwC1yD4i+nkVmA=;
        b=yu9JpyQdCrmat/vG1/j5/0gQT3GE0b3HtcRcvwkhWdPctNNK2D8dWOIjgAuMQ5MgSZ
         O19u8WASSlAebE7jd8hLQJRHePg62dROuRvgXcHzK6VYyo1+AyJm6Ag0Ck5ASShErol6
         d96nqLl0gTMcVCbwsZ8sBRjBNxkAuATfVKSfJk7mAo2KxUPtMkDlk62t+TEWEWiXIXQ5
         jt8hzblVuVQqKh51pCkTsjGWzM4e05d1NYNI8l5HtYtgjfXkGXYcSA0vZXJw4AybY5nZ
         tlLiQ1gJtF5EsiDSIoj/MIEhiyUngt5SyIXK1RKexWbLQW2z7BU/5Ipikfr10HFMh8gd
         pQmQ==
X-Received: by 10.66.244.230 with SMTP id xj6mr4707120pac.53.1439129515077;
        Sun, 09 Aug 2015 07:11:55 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by smtp.gmail.com with ESMTPSA id la4sm72920pbc.76.2015.08.09.07.11.52
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 09 Aug 2015 07:11:54 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1439129506-9989-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275540>

Add strbuf_utf8_align() which will align a given string into a strbuf
as per given align_type and width. If the width is greater than the
string length then no alignment is performed.

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 utf8.c | 22 ++++++++++++++++++++++
 utf8.h | 13 +++++++++++++
 2 files changed, 35 insertions(+)

diff --git a/utf8.c b/utf8.c
index 28e6d76..65e55cc 100644
--- a/utf8.c
+++ b/utf8.c
@@ -644,3 +644,25 @@ int skip_utf8_bom(char **text, size_t len)
 	*text += strlen(utf8_bom);
 	return 1;
 }
+
+void strbuf_utf8_align(struct strbuf *buf, align_type position, unsigned int width,
+		       const char *s)
+{
+	int display_len = utf8_strnwidth(s, strlen(s), 0);
+	int utf8_compenstation = strlen(s) - display_len;
+
+	if (!strlen(s))
+		return;
+	if (display_len >= width) {
+		strbuf_addstr(buf, s);
+		return;
+	}
+
+	if (position == ALIGN_LEFT)
+		strbuf_addf(buf, "%-*s", width + utf8_compenstation, s);
+	else if (position == ALIGN_MIDDLE) {
+		int left = (width - display_len)/2;
+		strbuf_addf(buf, "%*s%-*s", left, "", width - left + utf8_compenstation, s);
+	} else if (position == ALIGN_RIGHT)
+		strbuf_addf(buf, "%*s", width + utf8_compenstation, s);
+}
diff --git a/utf8.h b/utf8.h
index 5a9e94b..db8ca63 100644
--- a/utf8.h
+++ b/utf8.h
@@ -55,4 +55,17 @@ int mbs_chrlen(const char **text, size_t *remainder_p, const char *encoding);
  */
 int is_hfs_dotgit(const char *path);
 
+typedef enum {
+	ALIGN_LEFT,
+	ALIGN_MIDDLE,
+	ALIGN_RIGHT
+} align_type;
+
+/*
+ * Align the string given and store it into a strbuf as per the type
+ * and width.
+ */
+void strbuf_utf8_align(struct strbuf *buf, align_type position, unsigned int width,
+		       const char *s);
+
 #endif
-- 
2.5.0
