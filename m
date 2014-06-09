From: Jeremiah Mahler <jmmahler@gmail.com>
Subject: [PATCH/RFC v1 1/5] add strbuf_set operations
Date: Mon,  9 Jun 2014 01:36:25 -0700
Message-ID: <25ef7350029a96c02fc4450c981728d9746d0324.1402301816.git.jmmahler@gmail.com>
References: <cover.1402301815.git.jmmahler@gmail.com>
Cc: Jeremiah Mahler <jmmahler@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 09 10:37:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wtv5A-0007Aw-0W
	for gcvg-git-2@plane.gmane.org; Mon, 09 Jun 2014 10:37:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754938AbaFIIh3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jun 2014 04:37:29 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:59831 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753950AbaFIIh1 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jun 2014 04:37:27 -0400
Received: by mail-pa0-f51.google.com with SMTP id ey11so517399pad.24
        for <git@vger.kernel.org>; Mon, 09 Jun 2014 01:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=iv3rD7lyepvQatP4eUzrg8iN+h/gd7rB38fKlavmmj0=;
        b=vidCPSxqKWzOBcifdI+iP125PmFn2xGc9TQOY3jtTIzE0p4DVAC0fLD/RDAuvQVwRJ
         d35LACvprPbF2TS3+cwngx/3ivrvJlShpf58M1iBGVivP9N70mGDvi6WtnZTnvo6s8EI
         DHbHhr9oyoa22dtDtmoPhXNL7mTB3jT6v8896Fx+XVSA36Rz4lOPi5/j+yHSaYUoJS1a
         PGnmMb85URSugWm7tLo7N8F8L2bL9tWQ8KZoNtD8V0v17zviVFjqjUNOaBMkIZrzShMJ
         +zyOC6pibVJBzey1QEPJTAFzcgbiN494Z4DIoL9vAJErvS+VoCN9I66lZLC13n2NKGxO
         f5Xw==
X-Received: by 10.68.221.42 with SMTP id qb10mr3054919pbc.65.1402303047075;
        Mon, 09 Jun 2014 01:37:27 -0700 (PDT)
Received: from hudson (108-76-185-60.lightspeed.frokca.sbcglobal.net. [108.76.185.60])
        by mx.google.com with ESMTPSA id io8sm62622261pbc.96.2014.06.09.01.37.24
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 09 Jun 2014 01:37:25 -0700 (PDT)
X-Google-Original-From: "Jeremiah Mahler" <jeri@hudson>
Received: by hudson (sSMTP sendmail emulation); Mon, 09 Jun 2014 01:37:23 -0700
X-Mailer: git-send-email 2.0.0.573.ged771ce.dirty
In-Reply-To: <cover.1402301815.git.jmmahler@gmail.com>
In-Reply-To: <cover.1402301815.git.jmmahler@gmail.com>
References: <cover.1402301815.git.jmmahler@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251060>

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
 strbuf.c | 21 +++++++++++++++++++++
 strbuf.h | 14 ++++++++++++++
 2 files changed, 35 insertions(+)

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
2.0.0.573.ged771ce.dirty
