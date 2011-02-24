From: Jeff King <peff@peff.net>
Subject: [PATCH 2/8] strbuf: add strbuf_addv
Date: Thu, 24 Feb 2011 09:27:11 -0500
Message-ID: <20110224142711.GB15477@sigill.intra.peff.net>
References: <20110224142308.GA15356@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 24 15:27:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PscA1-0006ii-U0
	for gcvg-git-2@lo.gmane.org; Thu, 24 Feb 2011 15:27:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755991Ab1BXO1N (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Feb 2011 09:27:13 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:57942 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755446Ab1BXO1M (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Feb 2011 09:27:12 -0500
Received: (qmail 23278 invoked by uid 111); 24 Feb 2011 14:27:11 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Thu, 24 Feb 2011 14:27:11 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 Feb 2011 09:27:11 -0500
Content-Disposition: inline
In-Reply-To: <20110224142308.GA15356@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167812>

In a variable-args function, the code for writing into a
strbuf is non-trivial. We ended up cutting and pasting it in
several places because there was no vprintf-style function
for strbufs (which in turn was held up by a lack of
va_copy).

Now that we have a fallback va_copy, we can add strbuf_addv,
the strbuf equivalent of vsprintf. And we can clean up the
cut and paste mess.

Signed-off-by: Jeff King <peff@peff.net>
---
 fsck.c            |   14 +-------------
 merge-recursive.c |   15 +--------------
 strbuf.c          |   25 +++++++++++++++----------
 strbuf.h          |    1 +
 trace.c           |   32 ++++++--------------------------
 5 files changed, 24 insertions(+), 63 deletions(-)

diff --git a/fsck.c b/fsck.c
index 3d05d4a..398b137 100644
--- a/fsck.c
+++ b/fsck.c
@@ -347,26 +347,14 @@ int fsck_object(struct object *obj, int strict, fsck_error error_func)
 int fsck_error_function(struct object *obj, int type, const char *fmt, ...)
 {
 	va_list ap;
-	int len;
 	struct strbuf sb = STRBUF_INIT;
 
 	strbuf_addf(&sb, "object %s:", obj->sha1?sha1_to_hex(obj->sha1):"(null)");
 
 	va_start(ap, fmt);
-	len = vsnprintf(sb.buf + sb.len, strbuf_avail(&sb), fmt, ap);
+	strbuf_addv(&sb, fmt, ap);
 	va_end(ap);
 
-	if (len < 0)
-		len = 0;
-	if (len >= strbuf_avail(&sb)) {
-		strbuf_grow(&sb, len + 2);
-		va_start(ap, fmt);
-		len = vsnprintf(sb.buf + sb.len, strbuf_avail(&sb), fmt, ap);
-		va_end(ap);
-		if (len >= strbuf_avail(&sb))
-			die("this should not happen, your snprintf is broken");
-	}
-
 	error("%s", sb.buf);
 	strbuf_release(&sb);
 	return 1;
diff --git a/merge-recursive.c b/merge-recursive.c
index 16c2dbe..b418d5b 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -137,7 +137,6 @@ static void flush_output(struct merge_options *o)
 __attribute__((format (printf, 3, 4)))
 static void output(struct merge_options *o, int v, const char *fmt, ...)
 {
-	int len;
 	va_list ap;
 
 	if (!show(o, v))
@@ -148,21 +147,9 @@ static void output(struct merge_options *o, int v, const char *fmt, ...)
 	strbuf_setlen(&o->obuf, o->obuf.len + o->call_depth * 2);
 
 	va_start(ap, fmt);
-	len = vsnprintf(o->obuf.buf + o->obuf.len, strbuf_avail(&o->obuf), fmt, ap);
+	strbuf_addv(&o->obuf, fmt, ap);
 	va_end(ap);
 
-	if (len < 0)
-		len = 0;
-	if (len >= strbuf_avail(&o->obuf)) {
-		strbuf_grow(&o->obuf, len + 2);
-		va_start(ap, fmt);
-		len = vsnprintf(o->obuf.buf + o->obuf.len, strbuf_avail(&o->obuf), fmt, ap);
-		va_end(ap);
-		if (len >= strbuf_avail(&o->obuf)) {
-			die("this should not happen, your snprintf is broken");
-		}
-	}
-	strbuf_setlen(&o->obuf, o->obuf.len + len);
 	strbuf_add(&o->obuf, "\n", 1);
 	if (!o->buffer_output)
 		flush_output(o);
diff --git a/strbuf.c b/strbuf.c
index 07e8883..7a2e17f 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -195,24 +195,29 @@ void strbuf_adddup(struct strbuf *sb, size_t pos, size_t len)
 
 void strbuf_addf(struct strbuf *sb, const char *fmt, ...)
 {
-	int len;
 	va_list ap;
+	va_start(ap, fmt);
+	strbuf_addv(sb, fmt, ap);
+	va_end(ap);
+}
+
+void strbuf_addv(struct strbuf *sb, const char *fmt, va_list ap)
+{
+	int len;
+	va_list cp;
 
 	if (!strbuf_avail(sb))
 		strbuf_grow(sb, 64);
-	va_start(ap, fmt);
-	len = vsnprintf(sb->buf + sb->len, sb->alloc - sb->len, fmt, ap);
-	va_end(ap);
+	va_copy(cp, ap);
+	len = vsnprintf(sb->buf + sb->len, sb->alloc - sb->len, fmt, cp);
+	va_end(cp);
 	if (len < 0)
-		die("your vsnprintf is broken");
+		die("BUG: your vsnprintf is broken (returned -1)");
 	if (len > strbuf_avail(sb)) {
 		strbuf_grow(sb, len);
-		va_start(ap, fmt);
 		len = vsnprintf(sb->buf + sb->len, sb->alloc - sb->len, fmt, ap);
-		va_end(ap);
-		if (len > strbuf_avail(sb)) {
-			die("this should not happen, your snprintf is broken");
-		}
+		if (len > strbuf_avail(sb))
+			die("BUG: your vsnprintf is broken (insatiable)");
 	}
 	strbuf_setlen(sb, sb->len + len);
 }
diff --git a/strbuf.h b/strbuf.h
index 675a91f..65b44a0 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -120,6 +120,7 @@ extern void strbuf_addbuf_percentquote(struct strbuf *dst, const struct strbuf *
 
 __attribute__((format (printf,2,3)))
 extern void strbuf_addf(struct strbuf *sb, const char *fmt, ...);
+extern void strbuf_addv(struct strbuf *sb, const char *fmt, va_list ap);
 
 extern size_t strbuf_fread(struct strbuf *, size_t, FILE *);
 /* XXX: if read fails, any partial read is undone */
diff --git a/trace.c b/trace.c
index 35d388d..745543c 100644
--- a/trace.c
+++ b/trace.c
@@ -64,28 +64,18 @@ static const char err_msg[] = "Could not trace into fd given by "
 
 void trace_printf(const char *fmt, ...)
 {
-	struct strbuf buf;
+	struct strbuf buf = STRBUF_INIT;
 	va_list ap;
-	int fd, len, need_close = 0;
+	int fd, need_close = 0;
 
 	fd = get_trace_fd(&need_close);
 	if (!fd)
 		return;
 
 	set_try_to_free_routine(NULL);	/* is never reset */
-	strbuf_init(&buf, 64);
 	va_start(ap, fmt);
-	len = vsnprintf(buf.buf, strbuf_avail(&buf), fmt, ap);
+	strbuf_addv(&buf, fmt, ap);
 	va_end(ap);
-	if (len >= strbuf_avail(&buf)) {
-		strbuf_grow(&buf, len - strbuf_avail(&buf) + 128);
-		va_start(ap, fmt);
-		len = vsnprintf(buf.buf, strbuf_avail(&buf), fmt, ap);
-		va_end(ap);
-		if (len >= strbuf_avail(&buf))
-			die("broken vsnprintf");
-	}
-	strbuf_setlen(&buf, len);
 
 	write_or_whine_pipe(fd, buf.buf, buf.len, err_msg);
 	strbuf_release(&buf);
@@ -96,28 +86,18 @@ void trace_printf(const char *fmt, ...)
 
 void trace_argv_printf(const char **argv, const char *fmt, ...)
 {
-	struct strbuf buf;
+	struct strbuf buf = STRBUF_INIT;
 	va_list ap;
-	int fd, len, need_close = 0;
+	int fd, need_close = 0;
 
 	fd = get_trace_fd(&need_close);
 	if (!fd)
 		return;
 
 	set_try_to_free_routine(NULL);	/* is never reset */
-	strbuf_init(&buf, 64);
 	va_start(ap, fmt);
-	len = vsnprintf(buf.buf, strbuf_avail(&buf), fmt, ap);
+	strbuf_addv(&buf, fmt, ap);
 	va_end(ap);
-	if (len >= strbuf_avail(&buf)) {
-		strbuf_grow(&buf, len - strbuf_avail(&buf) + 128);
-		va_start(ap, fmt);
-		len = vsnprintf(buf.buf, strbuf_avail(&buf), fmt, ap);
-		va_end(ap);
-		if (len >= strbuf_avail(&buf))
-			die("broken vsnprintf");
-	}
-	strbuf_setlen(&buf, len);
 
 	sq_quote_argv(&buf, argv, 0);
 	strbuf_addch(&buf, '\n');
-- 
1.7.2.5.25.g3bb93
