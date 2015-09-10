From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v17 03/14] utf8: add function to align a string into given strbuf
Date: Thu, 10 Sep 2015 21:18:19 +0530
Message-ID: <1441900110-4015-4-git-send-email-Karthik.188@gmail.com>
References: <1441900110-4015-1-git-send-email-Karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	gitster@pobox.com, Karthik Nayak <Karthik.188@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 10 17:48:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Za45Y-00053k-40
	for gcvg-git-2@plane.gmane.org; Thu, 10 Sep 2015 17:48:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753563AbbIJPse (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Sep 2015 11:48:34 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:33207 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752132AbbIJPsc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Sep 2015 11:48:32 -0400
Received: by pacex6 with SMTP id ex6so46668013pac.0
        for <git@vger.kernel.org>; Thu, 10 Sep 2015 08:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zRFNI5aJfTgJeATHzMK7gNq+dMLDJmHk8Bfir1UcsuA=;
        b=pJOeV+aH/fafqdDqP1FYute366PmdMHo9hyKS318z4rQ7CQnoRJrQRmPL6GaulcvuR
         38zilQpju5dQeN7daZ1qlFQsBc58wCFuGtylUgCwdQB2Q21C4AlZDCDcySvcS0CoNowg
         TI4cUQRq75WitQ9Xj9aT8/xE3udFtAV22SEqeTmShz1xisEvUaLdpPIoqwpqk6JKb+dn
         1za/IyFHi5gdvUanXT/zF2sY5Skocu7hxWfafq1DFVrkBG6wygnh4z10FHKr4iS5w47a
         vBIFznkJ4ABCddF8LS7kgkytkmf/V2RC2z3mETPTyP86fpeYK576g4VafWW3PyMVix+m
         d+Wg==
X-Received: by 10.66.160.34 with SMTP id xh2mr6619395pab.67.1441900111856;
        Thu, 10 Sep 2015 08:48:31 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by smtp.gmail.com with ESMTPSA id ts1sm12738918pbc.74.2015.09.10.08.48.29
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 10 Sep 2015 08:48:31 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.5.1
In-Reply-To: <1441900110-4015-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277585>

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
2.5.1
