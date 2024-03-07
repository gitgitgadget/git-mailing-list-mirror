Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53AA839E3
	for <git@vger.kernel.org>; Thu,  7 Mar 2024 09:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709803165; cv=none; b=iXdQeLcAMbRQcjWLWwg0NJ7RC04h9wrqEuYuOgvIa9tfQFX7Pg33wurw8uRBxMg6XWB+eGc4nrbD3YxZuTY8rlS5ukyW7CtH2DTC3MahA4S/Vgb7cH5kzDaIkvzmcD1OqVmaRoBur1BDAsgbV+vFVz72Zwn8i0TWLnRaPDGFH+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709803165; c=relaxed/simple;
	bh=XU73t0aytWrPkUc0m+/TL/QAtYhe0OToIAHc7v1fV+4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XoZ9wtno/wq85O70LLQ0TYWX1EkN7V2g3TvYv1od7NiO74N+bWm8redymAemVw+xWntzYRb8j5lx67Gs8PQyMp1l/bvslOC9CXkasy4S+zTH8f1sq702AMURxXa9p2yYdfplG9BEt1wZr5S2gE6Aifjp4v63+dnJcJmDAmLHvOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 6876 invoked by uid 109); 7 Mar 2024 09:19:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 07 Mar 2024 09:19:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12572 invoked by uid 111); 7 Mar 2024 09:19:27 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 07 Mar 2024 04:19:27 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 7 Mar 2024 04:19:22 -0500
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>, Dragan Simic <dsimic@manjaro.org>,
	Kristoffer Haugsbakk <code@khaugsbakk.name>,
	Manlio Perillo <manlio.perillo@gmail.com>
Subject: [PATCH 04/15] strbuf: avoid shadowing global comment_line_char name
Message-ID: <20240307091922.GD2080210@coredump.intra.peff.net>
References: <20240307091407.GA2072522@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240307091407.GA2072522@coredump.intra.peff.net>

Several comment-related strbuf functions take a comment_line_char
parameter. There's also a global comment_line_char variable, which is
closely related (most callers pass it in as this parameter). Let's avoid
shadowing the global name. This makes it more obvious that we're not
using the global value, and it will be especially helpful as we refactor
the global in future patches (in particular, any macro trickery wouldn't
work because the preprocessor doesn't respect scope).

We'll use "comment_prefix". That should be descriptive enough, and as a
bonus is more neutral with respect to the "char" type (since we'll
eventually swap it out for a string).

Signed-off-by: Jeff King <peff@peff.net>
---
 strbuf.c | 16 ++++++++--------
 strbuf.h |  8 ++++----
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/strbuf.c b/strbuf.c
index ca80a2c77e..a33aed6c07 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -359,16 +359,16 @@ static void add_lines(struct strbuf *out,
 }
 
 void strbuf_add_commented_lines(struct strbuf *out, const char *buf,
-				size_t size, char comment_line_char)
+				size_t size, char comment_prefix)
 {
 	char prefix[2];
 
-	prefix[0] = comment_line_char;
+	prefix[0] = comment_prefix;
 	prefix[1] = '\0';
 	add_lines(out, prefix, buf, size, 1);
 }
 
-void strbuf_commented_addf(struct strbuf *sb, char comment_line_char,
+void strbuf_commented_addf(struct strbuf *sb, char comment_prefix,
 			   const char *fmt, ...)
 {
 	va_list params;
@@ -379,7 +379,7 @@ void strbuf_commented_addf(struct strbuf *sb, char comment_line_char,
 	strbuf_vaddf(&buf, fmt, params);
 	va_end(params);
 
-	strbuf_add_commented_lines(sb, buf.buf, buf.len, comment_line_char);
+	strbuf_add_commented_lines(sb, buf.buf, buf.len, comment_prefix);
 	if (incomplete_line)
 		sb->buf[--sb->len] = '\0';
 
@@ -1001,10 +1001,10 @@ static size_t cleanup(char *line, size_t len)
  *
  * If last line does not have a newline at the end, one is added.
  *
- * Pass a non-NUL comment_line_char to skip every line starting
+ * Pass a non-NUL comment_prefix to skip every line starting
  * with it.
  */
-void strbuf_stripspace(struct strbuf *sb, char comment_line_char)
+void strbuf_stripspace(struct strbuf *sb, char comment_prefix)
 {
 	size_t empties = 0;
 	size_t i, j, len, newlen;
@@ -1017,8 +1017,8 @@ void strbuf_stripspace(struct strbuf *sb, char comment_line_char)
 		eol = memchr(sb->buf + i, '\n', sb->len - i);
 		len = eol ? eol - (sb->buf + i) + 1 : sb->len - i;
 
-		if (comment_line_char && len &&
-		    sb->buf[i] == comment_line_char) {
+		if (comment_prefix && len &&
+		    sb->buf[i] == comment_prefix) {
 			newlen = 0;
 			continue;
 		}
diff --git a/strbuf.h b/strbuf.h
index e959caca87..860fcec5fb 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -288,7 +288,7 @@ void strbuf_splice(struct strbuf *sb, size_t pos, size_t len,
  */
 void strbuf_add_commented_lines(struct strbuf *out,
 				const char *buf, size_t size,
-				char comment_line_char);
+				char comment_prefix);
 
 
 /**
@@ -379,7 +379,7 @@ void strbuf_addf(struct strbuf *sb, const char *fmt, ...);
  * blank to the buffer.
  */
 __attribute__((format (printf, 3, 4)))
-void strbuf_commented_addf(struct strbuf *sb, char comment_line_char, const char *fmt, ...);
+void strbuf_commented_addf(struct strbuf *sb, char comment_prefix, const char *fmt, ...);
 
 __attribute__((format (printf,2,0)))
 void strbuf_vaddf(struct strbuf *sb, const char *fmt, va_list ap);
@@ -513,11 +513,11 @@ int strbuf_getcwd(struct strbuf *sb);
 int strbuf_normalize_path(struct strbuf *sb);
 
 /**
- * Strip whitespace from a buffer. If comment_line_char is non-NUL,
+ * Strip whitespace from a buffer. If comment_prefix is non-NUL,
  * then lines beginning with that character are considered comments,
  * thus removed.
  */
-void strbuf_stripspace(struct strbuf *buf, char comment_line_char);
+void strbuf_stripspace(struct strbuf *buf, char comment_prefix);
 
 static inline int strbuf_strip_suffix(struct strbuf *sb, const char *suffix)
 {
-- 
2.44.0.463.g71abcb3a9f

