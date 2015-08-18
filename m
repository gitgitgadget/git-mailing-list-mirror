From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v12 04/13] utf8: add function to align a string into given strbuf
Date: Wed, 19 Aug 2015 00:07:23 +0530
Message-ID: <1439923052-7373-5-git-send-email-Karthik.188@gmail.com>
References: <1439923052-7373-1-git-send-email-Karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	gitster@pobox.com, Karthik Nayak <Karthik.188@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 18 20:37:52 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZRllb-0008Iz-QI
	for gcvg-git-2@plane.gmane.org; Tue, 18 Aug 2015 20:37:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753998AbbHRShm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Aug 2015 14:37:42 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:34100 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751612AbbHRShl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Aug 2015 14:37:41 -0400
Received: by paccq16 with SMTP id cq16so94601708pac.1
        for <git@vger.kernel.org>; Tue, 18 Aug 2015 11:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JHArrAW4lGGd8JvxvCZaco4f/Z28TekTm3yscw2HPl0=;
        b=w3GzoqdBzf8f/ijLgDpXgvm6GDIN7J0qelYQY8pzYocn0ITg1+3+BbRC7WZkJZe6Uf
         nMTzMEFNClZpv5UOpuwVoDqSxZ188jibNj2yw2k0qnaigRRG95YNxOz04oXfsBmARhbz
         up/cuM3gWw+u1Mjldsi5KIOaRopA+ZBJ1Yh0nYv7TnZnrxy+Ith8Csy4nKc37qV1Duml
         F80V/hw89kJnb2Tl7nLBax3sYEVasZ58MmUcjjUyT5Wq+uYUjVD3dMqM8nt9G36tmSXg
         lx77RhGrYePxe8kI8zNw7rcdJ6lVN7j/WlA/3+vfMLqsUuzL3AnY6CyWUfPyGebPoAiO
         4K8Q==
X-Received: by 10.66.145.74 with SMTP id ss10mr16242586pab.28.1439923061103;
        Tue, 18 Aug 2015 11:37:41 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by smtp.gmail.com with ESMTPSA id i9sm18858190pbq.44.2015.08.18.11.37.38
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 18 Aug 2015 11:37:40 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1439923052-7373-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276135>

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
index 28e6d76..00e10c8 100644
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
+		int left = (width - display_len) / 2;
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
