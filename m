From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 2/5] strbuf: add strbuf_vaddf
Date: Fri, 25 Feb 2011 23:08:53 -0600
Message-ID: <20110226050853.GB27887@elie>
References: <20110226050723.GA27864@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 26 06:09:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PtCOz-0007RY-VU
	for gcvg-git-2@lo.gmane.org; Sat, 26 Feb 2011 06:09:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751228Ab1BZFJC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Feb 2011 00:09:02 -0500
Received: from mail-vw0-f46.google.com ([209.85.212.46]:42591 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751104Ab1BZFJB (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Feb 2011 00:09:01 -0500
Received: by mail-vw0-f46.google.com with SMTP id 12so1956872vws.19
        for <git@vger.kernel.org>; Fri, 25 Feb 2011 21:09:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        bh=/MsHIIEzVRP05EXSE6EMvKkK3bc0b8MPQoZJ6dh+ncg=;
        b=Xi41iWVGRWfri/rBVQlcCFiK/HjMfxUfvDHC8hkMMCqdI1yTPRYPFg8tDgEtyMYFVk
         r3PNkCTAZkb/OA9dEvYPZMMB0M6E3JOjqT9RqBMwqjmp97MRHOMyYe1fIEkBhI9f3By8
         MajHzSRF9k/cTUD5jsAt0c/WImv2PK/6izQVw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=PiuR8iSXzc58nX6eedVv1hl6kA76qFnZpWqr5tjQxPjtXCFvSlyEs84Ue8mCsEVCzQ
         BoOCws2mVECahKX2Pz1qUWWZzitca3wejyTDWlbub/oJf3II3am0AYcogADjpm7t9jYI
         TRmVEyL396jTIQ2dwikJdT4C1fziI1jGZiBQU=
Received: by 10.52.161.225 with SMTP id xv1mr5384330vdb.244.1298696940489;
        Fri, 25 Feb 2011 21:09:00 -0800 (PST)
Received: from elie ([69.209.53.52])
        by mx.google.com with ESMTPS id j15sm717337vcs.44.2011.02.25.21.08.58
        (version=SSLv3 cipher=OTHER);
        Fri, 25 Feb 2011 21:08:59 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20110226050723.GA27864@elie>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167956>

From: Jeff King <peff@peff.net>

In a variable-args function, the code for writing into a strbuf is
non-trivial. We ended up cutting and pasting it in several places
because there was no vprintf-style function for strbufs (which in turn
was held up by a lack of va_copy).

Now that we have a fallback va_copy, we can add strbuf_vaddf, the
strbuf equivalent of vsprintf. And we can clean up the cut and paste
mess.

Signed-off-by: Jeff King <peff@peff.net>
Improved-by: Christian Couder <christian.couder@gmail.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 fsck.c            |   14 +-------------
 merge-recursive.c |   15 +--------------
 strbuf.c          |   27 ++++++++++++++++-----------
 strbuf.h          |    2 ++
 trace.c           |   32 ++++++--------------------------
 5 files changed, 26 insertions(+), 64 deletions(-)

diff --git a/fsck.c b/fsck.c
index 3d05d4a..6f266c1 100644
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
+	strbuf_vaddf(&sb, fmt, ap);
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
index 16c2dbe..2a4f739 100644
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
+	strbuf_vaddf(&o->obuf, fmt, ap);
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
index 07e8883..77444a9 100644
--- a/strbuf.c
+++ b/strbuf.c
@@ -195,24 +195,29 @@ void strbuf_adddup(struct strbuf *sb, size_t pos, size_t len)
 
 void strbuf_addf(struct strbuf *sb, const char *fmt, ...)
 {
-	int len;
 	va_list ap;
-
-	if (!strbuf_avail(sb))
-		strbuf_grow(sb, 64);
 	va_start(ap, fmt);
-	len = vsnprintf(sb->buf + sb->len, sb->alloc - sb->len, fmt, ap);
+	strbuf_vaddf(sb, fmt, ap);
 	va_end(ap);
+}
+
+void strbuf_vaddf(struct strbuf *sb, const char *fmt, va_list ap)
+{
+	int len;
+	va_list cp;
+
+	if (!strbuf_avail(sb))
+		strbuf_grow(sb, 64);
+	va_copy(cp, ap);
+	len = vsnprintf(sb->buf + sb->len, sb->alloc - sb->len, fmt, cp);
+	va_end(cp);
 	if (len < 0)
-		die("your vsnprintf is broken");
+		die("BUG: your vsnprintf is broken (returned %d)", len);
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
index 675a91f..f722331 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -120,6 +120,8 @@ extern void strbuf_addbuf_percentquote(struct strbuf *dst, const struct strbuf *
 
 __attribute__((format (printf,2,3)))
 extern void strbuf_addf(struct strbuf *sb, const char *fmt, ...);
+__attribute__((format (printf,2,0)))
+extern void strbuf_vaddf(struct strbuf *sb, const char *fmt, va_list ap);
 
 extern size_t strbuf_fread(struct strbuf *, size_t, FILE *);
 /* XXX: if read fails, any partial read is undone */
diff --git a/trace.c b/trace.c
index 35d388d..eda3f6d 100644
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
+	strbuf_vaddf(&buf, fmt, ap);
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
+	strbuf_vaddf(&buf, fmt, ap);
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
1.7.4.1
