From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>
Subject: [PATCH 1/2] strbuf: export strbuf_addchars()
Date: Sun, 07 Sep 2014 09:03:32 +0200
Message-ID: <540C0344.9060002@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Sep 07 09:04:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XQWW7-0001Wr-QG
	for gcvg-git-2@plane.gmane.org; Sun, 07 Sep 2014 09:04:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750877AbaIGHDy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Sep 2014 03:03:54 -0400
Received: from mout.web.de ([212.227.15.3]:53999 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750822AbaIGHDy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Sep 2014 03:03:54 -0400
Received: from [192.168.178.27] ([79.250.174.198]) by smtp.web.de (mrweb002)
 with ESMTPSA (Nemesis) id 0LeLin-1YA64f3Hpt-00qCVj; Sun, 07 Sep 2014 09:03:48
 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.1.0
X-Provags-ID: V03:K0:L/yUWVvqb50aYko/qzvoyU4eZVEr4UX8oHQiZZwuJxnNzj8Y5mq
 K4xthNQdXQf6X1Tb/U4NL41KP6pwtMc8x2e6mjnSpG59SBjFFfBGzOlMjjNqpTobysUW1mf
 90q4l6bRnWmVcudfl03KgGMcAMvQGcAqP3KJCN4jifdmv998f0Lkbx1EHTx/42jpJqQ9X5g
 ZU6qKU5VbZeG1VFJUs7Tg==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256612>

Move strbuf_addchars() to strbuf.c, where it belongs, and make it
available for other callers.

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 Documentation/technical/api-strbuf.txt | 4 ++++
 strbuf.c                               | 7 +++++++
 strbuf.h                               | 1 +
 utf8.c                                 | 7 -------
 4 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/Documentation/technical/api-strbuf.txt b/Documentation/technical/api-strbuf.txt
index 430302c..cca6543 100644
--- a/Documentation/technical/api-strbuf.txt
+++ b/Documentation/technical/api-strbuf.txt
@@ -160,6 +160,10 @@ then they will free() it.
 
 	Add a single character to the buffer.
 
+`strbuf_addchars`::
+
+	Add a character the specified number of times to the buffer.
+
 `strbuf_insert`::
 
 	Insert data to the given position of the buffer. The remaining contents
diff --git a/strbuf.c b/strbuf.c
index 4d31443..0346e74 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -204,6 +204,13 @@ void strbuf_adddup(struct strbuf *sb, size_t pos, size_t len)
 	strbuf_setlen(sb, sb->len + len);
 }
 
+void strbuf_addchars(struct strbuf *sb, int c, size_t n)
+{
+	strbuf_grow(sb, n);
+	memset(sb->buf + sb->len, c, n);
+	strbuf_setlen(sb, sb->len + n);
+}
+
 void strbuf_addf(struct strbuf *sb, const char *fmt, ...)
 {
 	va_list ap;
diff --git a/strbuf.h b/strbuf.h
index 7bdc1da..652b6c4 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -138,6 +138,7 @@ static inline void strbuf_addbuf(struct strbuf *sb, const struct strbuf *sb2)
 	strbuf_add(sb, sb2->buf, sb2->len);
 }
 extern void strbuf_adddup(struct strbuf *sb, size_t pos, size_t len);
+extern void strbuf_addchars(struct strbuf *sb, int c, size_t n);
 
 typedef size_t (*expand_fn_t) (struct strbuf *sb, const char *placeholder, void *context);
 extern void strbuf_expand(struct strbuf *sb, const char *format, expand_fn_t fn, void *context);
diff --git a/utf8.c b/utf8.c
index b30790d..6d4d04a 100644
--- a/utf8.c
+++ b/utf8.c
@@ -239,13 +239,6 @@ int is_utf8(const char *text)
 	return 1;
 }
 
-static void strbuf_addchars(struct strbuf *sb, int c, size_t n)
-{
-	strbuf_grow(sb, n);
-	memset(sb->buf + sb->len, c, n);
-	strbuf_setlen(sb, sb->len + n);
-}
-
 static void strbuf_add_indented_text(struct strbuf *buf, const char *text,
 				     int indent, int indent2)
 {
-- 
2.1.0
