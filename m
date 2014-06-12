From: Jeremiah Mahler <jmmahler@gmail.com>
Subject: [PATCH v3 1/2] add strbuf_set operations
Date: Thu, 12 Jun 2014 00:29:33 -0700
Message-ID: <f4d043b7c1e00f9c967faff39244274fe40fd371.1402557437.git.jmmahler@gmail.com>
References: <cover.1402557437.git.jmmahler@gmail.com>
Cc: Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org,
	Jeremiah Mahler <jmmahler@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Thu Jun 12 09:30:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WuzT0-0004DP-Tk
	for gcvg-git-2@plane.gmane.org; Thu, 12 Jun 2014 09:30:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932514AbaFLHab (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Jun 2014 03:30:31 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:41894 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932147AbaFLHaa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Jun 2014 03:30:30 -0400
Received: by mail-pa0-f46.google.com with SMTP id eu11so713859pac.5
        for <git@vger.kernel.org>; Thu, 12 Jun 2014 00:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=LtV9l7TXCLke1ZMVcgs4T+vFpBLktJStNQEMYyjufoA=;
        b=vOYKqY4QM2em1vP2WxCq3vNnxAm3YOY4IKjCY722ysGNCxbsTQiAWcqduNiLkKQ+IL
         KbiJkWq8yJjqxIWs5iBM1m6V9+P1iYUllbWnkJ/C1kIdFAZz04STOuyt0VZucW/GIqlk
         qx9KVv2kXBJ3SFPOja2yC80fZkFIJTYGqZvvpOhBrWW2i9gWadFd2S4+ee29GEqsih11
         APT5hixVuRjkVgiND/XS4QASt8+Re1odG6o20fslvZUDUphifwXMgAwwTflv0135WCUy
         MPbL81L/1xnehcirWsXs6FIbyquuSPunpLJJnannNzYEtHkUUrQa5upWB13GN3D4v8aE
         JMsA==
X-Received: by 10.67.4.138 with SMTP id ce10mr19048525pad.12.1402558230330;
        Thu, 12 Jun 2014 00:30:30 -0700 (PDT)
Received: from localhost (108-76-185-60.lightspeed.frokca.sbcglobal.net. [108.76.185.60])
        by mx.google.com with ESMTPSA id xk3sm78742717pbb.65.2014.06.12.00.30.28
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Jun 2014 00:30:29 -0700 (PDT)
X-Mailer: git-send-email 2.0.0.660.g82aec34
In-Reply-To: <cover.1402557437.git.jmmahler@gmail.com>
In-Reply-To: <cover.1402557437.git.jmmahler@gmail.com>
References: <cover.1402557437.git.jmmahler@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251399>

A common use case with strubfs is to set the buffer to a new value.
This must be done in two steps: a reset followed by an add.

  strbuf_reset(buf);
  strbuf_add(buf, new_buf, len);

In cases where the buffer is being built up in steps, these operations
make sense and correctly convey what is being performed.

  strbuf_reset(buf);
  strbuf_add(buf, data1, len1);
  strbuf_add(buf, data2, len2);
  strbuf_add(buf, data3, len3);

However, in other cases, it can be confusing and is not very concise.

  strbuf_reset(buf);
  strbuf_add(buf, default, len1);

  if (cond1) {
    strbuf_reset(buf);
    strbuf_add(buf, data2, len2);
  }

  if (cond2) {
    strbuf_reset(buf);
    strbuf_add(buf, data3, len3);
  }

Add strbuf_set operations so that it can be re-written in a clear and
concise way.

  strbuf_set(buf, default len1);

  if (cond1) {
    strbuf_set(buf, data2, len2);
  }

  if (cond2) {
    strbuf_set(buf, data3, len3);
  }

Signed-off-by: Jeremiah Mahler <jmmahler@gmail.com>
---
 Documentation/technical/api-strbuf.txt | 18 ++++++++++++++++++
 strbuf.c                               | 21 +++++++++++++++++++++
 strbuf.h                               | 13 +++++++++++++
 3 files changed, 52 insertions(+)

diff --git a/Documentation/technical/api-strbuf.txt b/Documentation/technical/api-strbuf.txt
index f9c06a7..ae9c9cc 100644
--- a/Documentation/technical/api-strbuf.txt
+++ b/Documentation/technical/api-strbuf.txt
@@ -149,6 +149,24 @@ Functions
 	than zero if the first buffer is found, respectively, to be less than,
 	to match, or be greater than the second buffer.
 
+* Setting the buffer
+
+`strbuf_set`::
+
+	Replace content with data of a given length.
+
+`strbuf_setstr`::
+
+	Replace content with data from a NUL-terminated string.
+
+`strbuf_setf`::
+
+	Replace content with a formatted string.
+
+`strbuf_setbuf`::
+
+	Replace content with data from another buffer.
+
 * Adding data to the buffer
 
 NOTE: All of the functions in this section will grow the buffer as necessary.
diff --git a/strbuf.c b/strbuf.c
index ac62982..9d64b00 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -189,6 +189,27 @@ void strbuf_splice(struct strbuf *sb, size_t pos, size_t len,
 	strbuf_setlen(sb, sb->len + dlen - len);
 }
 
+void strbuf_set(struct strbuf *sb, const void *data, size_t len)
+{
+	strbuf_reset(sb);
+	strbuf_add(sb, data, len);
+}
+
+void strbuf_setf(struct strbuf *sb, const char *fmt, ...)
+{
+	va_list ap;
+	strbuf_reset(sb);
+	va_start(ap, fmt);
+	strbuf_vaddf(sb, fmt, ap);
+	va_end(ap);
+}
+
+void strbuf_setbuf(struct strbuf *sb, const struct strbuf *sb2)
+{
+	strbuf_reset(sb);
+	strbuf_add(sb, sb2->buf, sb2->len);
+}
+
 void strbuf_insert(struct strbuf *sb, size_t pos, const void *data, size_t len)
 {
 	strbuf_splice(sb, pos, 0, data, len);
diff --git a/strbuf.h b/strbuf.h
index e9ad03e..5041c35 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -101,6 +101,19 @@ static inline struct strbuf **strbuf_split(const struct strbuf *sb,
  */
 extern void strbuf_list_free(struct strbuf **);
 
+/*----- set buffer to data -----*/
+extern void strbuf_set(struct strbuf *sb, const void *data, size_t len);
+
+static inline void strbuf_setstr(struct strbuf *sb, const char *s)
+{
+	strbuf_set(sb, s, strlen(s));
+}
+
+__attribute__((format (printf,2,3)))
+extern void strbuf_setf(struct strbuf *sb, const char *fmt, ...);
+
+extern void strbuf_setbuf(struct strbuf *sb, const struct strbuf *sb2);
+
 /*----- add data in your buffer -----*/
 static inline void strbuf_addch(struct strbuf *sb, int c)
 {
-- 
2.0.0
