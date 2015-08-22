From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v13 03/12] utf8: add function to align a string into given strbuf
Date: Sat, 22 Aug 2015 09:09:39 +0530
Message-ID: <1440214788-1309-4-git-send-email-Karthik.188@gmail.com>
References: <1440214788-1309-1-git-send-email-Karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	gitster@pobox.com, Karthik Nayak <Karthik.188@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 22 05:40:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZSzex-0002CT-0h
	for gcvg-git-2@plane.gmane.org; Sat, 22 Aug 2015 05:39:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753134AbbHVDjy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Aug 2015 23:39:54 -0400
Received: from mail-pd0-f171.google.com ([209.85.192.171]:35991 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753115AbbHVDjx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Aug 2015 23:39:53 -0400
Received: by pdbmi9 with SMTP id mi9so32828988pdb.3
        for <git@vger.kernel.org>; Fri, 21 Aug 2015 20:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JHArrAW4lGGd8JvxvCZaco4f/Z28TekTm3yscw2HPl0=;
        b=NXcgW2QEpISBkFBI8ubTjMLZ6DgAgGEUbBGVrEizb3pofpV94Sz1ODETmeOg+s7AgO
         N03asjXnZ/51PE1/JXUnl14yTFkEU8uYAwdiKP+79pj6/2wt5zsxXOFR4zyjWAfPko4v
         shsSuBhnwDvGZQWURIpsVsz7ZtBXzjUqdo7EJA5l2/NUix5vI8+AB0U+LVVIQFr0dc5+
         +wlZS2gsEvy7LPS3cVcEajixf9QMJD9MvWxDkGcEzMWJGMf72pDqEtzIgp8MkTI41gh0
         RRb7g9DT3ebM394WxJc3XmeG41diI86XMFm+yd1hu+isFwUmjrcUl2Tkn+Vz0tB7T7a/
         zSOg==
X-Received: by 10.70.38.101 with SMTP id f5mr23570111pdk.140.1440214793059;
        Fri, 21 Aug 2015 20:39:53 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by smtp.gmail.com with ESMTPSA id e4sm9393515pdd.45.2015.08.21.20.39.50
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 21 Aug 2015 20:39:52 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1440214788-1309-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276365>

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
