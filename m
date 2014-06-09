From: Jeremiah Mahler <jmmahler@gmail.com>
Subject: [PATCH v2 01/19] add strbuf_set operations
Date: Mon,  9 Jun 2014 15:19:20 -0700
Message-ID: <6fe33498512fc2ca1678517e51dc2e94a4260ff4.1402348696.git.jmmahler@gmail.com>
References: <cover.1402348696.git.jmmahler@gmail.com>
Cc: git@vger.kernel.org, Jeremiah Mahler <jmmahler@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue Jun 10 00:20:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wu7vV-0000MC-Sd
	for gcvg-git-2@plane.gmane.org; Tue, 10 Jun 2014 00:20:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932299AbaFIWUW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jun 2014 18:20:22 -0400
Received: from mail-pb0-f53.google.com ([209.85.160.53]:34304 "EHLO
	mail-pb0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932097AbaFIWUU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jun 2014 18:20:20 -0400
Received: by mail-pb0-f53.google.com with SMTP id md12so5421417pbc.26
        for <git@vger.kernel.org>; Mon, 09 Jun 2014 15:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=xBEQqUBrdgiYbhhkCFeUwmz5UvpLcrLgYuQ7BaN57Pw=;
        b=REEKBc/uySa4965q/fOCV4kgrmSxMWaSh/Vx8bkoXsSm/MRrk9WJo90XWTesH4rPMM
         fvRnVy9zeUSC7Dl/+laQ5KUeKXmv1tldEzBzK6jU5u+ihUhI5eLFcKrcICCX5qY+ZUfG
         kMzPpL1sUxWY+H8XvGPJpdd+l2qT1B79dbJgFsPGI5LcXDXbdjNKsoGV51p+or6DhHeW
         L/TKeEdtWiZBBj20Cmg69ULiaQ7CdlgkHR31RJpdcuuj+PJpefA6a2uD/8h4IGGpmhNL
         H88zxytRpUjEqLWTm38p/ZehGNQrUdJFxbaK4e0YchIU239zuApQ8NW0g7vGljSespFR
         9buQ==
X-Received: by 10.68.181.67 with SMTP id du3mr7402377pbc.96.1402352420006;
        Mon, 09 Jun 2014 15:20:20 -0700 (PDT)
Received: from hudson (108-76-185-60.lightspeed.frokca.sbcglobal.net. [108.76.185.60])
        by mx.google.com with ESMTPSA id wt6sm2692612pac.29.2014.06.09.15.20.17
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 09 Jun 2014 15:20:18 -0700 (PDT)
X-Google-Original-From: "Jeremiah Mahler" <jeri@hudson>
Received: by hudson (sSMTP sendmail emulation); Mon, 09 Jun 2014 15:20:16 -0700
X-Mailer: git-send-email 2.0.0.592.gf55b190
In-Reply-To: <cover.1402348696.git.jmmahler@gmail.com>
In-Reply-To: <cover.1402348696.git.jmmahler@gmail.com>
References: <cover.1402348696.git.jmmahler@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251109>

Currently, the data in a strbuf is modified using add operations.  To
set the buffer to some data a reset must be performed before an add.

  strbuf_reset(buf);
  strbuf_add(buf, cb.buf.buf, cb.buf.len);

And this is a common sequence of operations with 70 occurrences found in
the current source code.  This includes all the different variations
(add, addf, addstr, addbuf, addch).

  FILES=`find ./ -name '*.c'`
  CNT=$(pcregrep -M "strbuf_reset.*\n.*strbuf_add" $FILES | wc -l)
  CNT=$(echo "$CNT / 2" | bc)
  echo $CNT
  70

These patches add strbuf_set operations which allow this common sequence
to be performed in one line instead of two.

  strbuf_set(buf, cb.buf.buf, cb.buf.len);

Signed-off-by: Jeremiah Mahler <jmmahler@gmail.com>
---
 Documentation/technical/api-strbuf.txt | 18 ++++++++++++++++++
 strbuf.c                               | 21 +++++++++++++++++++++
 strbuf.h                               | 14 ++++++++++++++
 3 files changed, 53 insertions(+)

diff --git a/Documentation/technical/api-strbuf.txt b/Documentation/technical/api-strbuf.txt
index 077a709..b7e23da 100644
--- a/Documentation/technical/api-strbuf.txt
+++ b/Documentation/technical/api-strbuf.txt
@@ -149,6 +149,24 @@ Functions
 	than zero if the first buffer is found, respectively, to be less than,
 	to match, or be greater than the second buffer.
 
+* Setting the buffer
+
+`strbuf_set`::
+
+	Replace the buffer content with data of a given length.
+
+`strbuf_setstr`::
+
+	Replace the buffer content with data from a NUL-terminated string.
+
+`strbuf_setf`::
+
+	Replace the buffer content with a formatted string.
+
+`strbuf_setbuf`::
+
+	Replace the buffer content with data from another buffer.
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
index e9ad03e..b339f08 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -101,6 +101,20 @@ static inline struct strbuf **strbuf_split(const struct strbuf *sb,
  */
 extern void strbuf_list_free(struct strbuf **);
 
+/*----- set buffer to data -----*/
+
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
2.0.0.592.gf55b190
