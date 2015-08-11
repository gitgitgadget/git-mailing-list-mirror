From: Jeff King <peff@peff.net>
Subject: [PATCH] usage: try harder to format very long error messages
Date: Tue, 11 Aug 2015 12:17:53 -0400
Message-ID: <20150811161752.GA14829@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 11 18:18:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZPCFW-0004r6-SX
	for gcvg-git-2@plane.gmane.org; Tue, 11 Aug 2015 18:18:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965327AbbHKQR6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Aug 2015 12:17:58 -0400
Received: from cloud.peff.net ([50.56.180.127]:43684 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965190AbbHKQR6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Aug 2015 12:17:58 -0400
Received: (qmail 16254 invoked by uid 102); 11 Aug 2015 16:17:57 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 11 Aug 2015 11:17:57 -0500
Received: (qmail 16744 invoked by uid 107); 11 Aug 2015 16:18:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 11 Aug 2015 12:18:08 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 11 Aug 2015 12:17:53 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275695>

We use a fixed-size buffer of 4096 bytes to format die() and
error() messages. We explicitly avoided using a strbuf or
other fanciness here, because we want to make sure that we
report the message even in the face of malloc() failure
(after all, we might even be dying due to a malloc call).

In most cases, this buffer is long enough to show any
reasonable message. However, if you are experimenting with
_unreasonable_ things (e.g., filenames approaching 4096
bytes), the messages can be truncated, making them
confusing. E.g., seeing:

  error: cannot stat 'aaaaaaaaaaaaaaaaaaaaaa

is much less useful than:

  error: cannot stat 'aaaaaaaaaaaaaaaaaaaaaaa/foo': File too long

(these are truncated for the sake of readability; obviously
real examples are much longer. Just imagine many lines full
of "a"'s).

This patch teaches vreportf and vwritef to at least try
using a dynamically sized buffer before falling back to the
fixed-size buffer. For most long errors (which are typically
reporting problems with syscalls on long filenames), this
means we'll generally see the full message. And in case that
fails, we still print the truncated message, but with a note
that it was truncated.

Note that die_errno does not need the same treatment for its
fixed-size buffers, as they are a combination of:

  - our fixed-size string constants, without placeholders
    expanded (so a literal "cannot stat '%s'", without %s
    expanded to arbitrary data)

  - the results of strerror(errno)

both of which should be predictably small.

Signed-off-by: Jeff King <peff@peff.net>
---
So this solution tries to change vreportf and vwritef as little as
possible, and ends up slightly complex as a result. But reading
vreportf's:

  vsnprintf(msg, sizeof(msg), err, params);
  fprintf(stderr, "%s%s\n", prefix, msg);

I had to wonder why this wasn't just:

  fputs(prefix, stderr);
  vfprintf(stderr, err, params);

In fact, we used to do this, but changed it in d048a96 (print
warning/error/fatal messages in one shot, 2007-11-09). I'm not sure of
the reasoning there, though. I would expect stdio to generally write
that as a single shot already, assuming:

  - there isn't anything in the stderr buffer already (i.e., we do not
    need to flush somewhere in the middle)

  - our prefix does not have a newline (which it doesn't; it is
    "error:", "fatal:", etc).

IOW, I wonder if it would be enough to simply fflush(stderr) before and
after to make sure we keep the buffer clear. I also wonder if this is
even enough as-is; if the resulting message is larger than stdio's
buffer size, I'd expect it to come through across several writes anyway.

As for vwritef, it exists solely to work over write(), _and_ it doesn't
get the "one-shot" thing right (which is probably OK, as we use it only
when exec fails). But we could probably teach run-command to fdopen(),
and get rid of it entirely (in favor of teaching vreportf to take a
FILE* handle instead of assuming stderr).

So I dunno. I think the solution here works fine, but maybe we should be
taking the opportunity to simplify.

 usage.c | 72 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 64 insertions(+), 8 deletions(-)

diff --git a/usage.c b/usage.c
index ed14645..78b0d75 100644
--- a/usage.c
+++ b/usage.c
@@ -6,23 +6,79 @@
 #include "git-compat-util.h"
 #include "cache.h"
 
+/*
+ * This buffer allows you to try formatting a full message, but if malloc
+ * fails, will fall back to a fixed-size buffer and truncate the message.
+ * If we truncate the message, it adds a note indicating so.
+ *
+ * No initialization is necessary before robust_buf_fmt, and after it returns,
+ * "buf" points to the contents (whether truncated or not). You should always
+ * robust_buf_free the result, which handles both cases.
+ */
+struct robust_buf {
+	char *buf;
+	char fixed[4096];
+};
+
+static int robust_buf_fmt(struct robust_buf *rb,
+			  const char *fmt, va_list ap)
+{
+	static const char trunc[] = " [message truncated]";
+	static const char broken[] = "BUG: your vsnprintf is broken";
+	va_list cp;
+	int len;
+
+	va_copy(cp, ap);
+	len = vsnprintf(rb->fixed, sizeof(rb->fixed), fmt, cp);
+	va_end(cp);
+
+	if (len < 0) {
+		memcpy(rb->fixed, broken, sizeof(broken));
+		rb->buf = rb->fixed;
+		return sizeof(broken) - 1;
+	}
+	if (len < sizeof(rb->fixed)) {
+		rb->buf = rb->fixed;
+		return len;
+	}
+
+	rb->buf = malloc(len + 1);
+	if (!rb->buf) {
+		memcpy(rb->fixed + sizeof(rb->fixed) - sizeof(trunc),
+		       trunc, sizeof(trunc));
+		rb->buf = rb->fixed;
+		return sizeof(rb->fixed) - 1;
+	}
+
+	if (vsnprintf(rb->buf, len + 1, fmt, ap) >= len)
+		; /* insatiable vsnprintf, nothing we can do */
+	return len;
+}
+
+static void robust_buf_free(struct robust_buf *rb)
+{
+	if (rb->buf != rb->fixed)
+		free(rb->buf);
+}
+
 void vreportf(const char *prefix, const char *err, va_list params)
 {
-	char msg[4096];
-	vsnprintf(msg, sizeof(msg), err, params);
-	fprintf(stderr, "%s%s\n", prefix, msg);
+	struct robust_buf msg;
+	robust_buf_fmt(&msg, err, params);
+	fprintf(stderr, "%s%s\n", prefix, msg.buf);
+	robust_buf_free(&msg);
 }
 
 void vwritef(int fd, const char *prefix, const char *err, va_list params)
 {
-	char msg[4096];
-	int len = vsnprintf(msg, sizeof(msg), err, params);
-	if (len > sizeof(msg))
-		len = sizeof(msg);
+	struct robust_buf msg;
+	int len = robust_buf_fmt(&msg, err, params);
 
 	write_in_full(fd, prefix, strlen(prefix));
-	write_in_full(fd, msg, len);
+	write_in_full(fd, msg.buf, len);
 	write_in_full(fd, "\n", 1);
+
+	robust_buf_free(&msg);
 }
 
 static NORETURN void usage_builtin(const char *err, va_list params)
-- 
2.5.0.417.g2db689c
