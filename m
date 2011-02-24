From: Jeff King <peff@peff.net>
Subject: [PATCH 6/8] trace: add trace_strbuf
Date: Thu, 24 Feb 2011 09:29:50 -0500
Message-ID: <20110224142950.GF15477@sigill.intra.peff.net>
References: <20110224142308.GA15356@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 24 15:29:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PscCa-0008BJ-PG
	for gcvg-git-2@lo.gmane.org; Thu, 24 Feb 2011 15:29:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756098Ab1BXO3w (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Feb 2011 09:29:52 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:55840 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755575Ab1BXO3v (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Feb 2011 09:29:51 -0500
Received: (qmail 23376 invoked by uid 111); 24 Feb 2011 14:29:51 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Thu, 24 Feb 2011 14:29:51 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 Feb 2011 09:29:50 -0500
Content-Disposition: inline
In-Reply-To: <20110224142308.GA15356@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167816>

If you happen to have a strbuf, it is a little more readable
and a little more efficient to be able to print it directly
instead of jamming it through the trace_printf interface.

Signed-off-by: Jeff King <peff@peff.net>
---
 cache.h |    1 +
 trace.c |   23 ++++++++++++++++-------
 2 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/cache.h b/cache.h
index 211d7bb..3978112 100644
--- a/cache.h
+++ b/cache.h
@@ -1072,6 +1072,7 @@ __attribute__((format (printf, 2, 3)))
 extern void trace_argv_printf(const char **argv, const char *format, ...);
 extern void trace_repo_setup(const char *prefix);
 extern int trace_want(const char *key);
+extern void trace_strbuf(const char *key, const struct strbuf *buf);
 
 /* convert.c */
 /* returns 1 if *dst was used */
diff --git a/trace.c b/trace.c
index f00d98f..3f9f287 100644
--- a/trace.c
+++ b/trace.c
@@ -65,19 +65,14 @@ static const char err_msg[] = "Could not trace into fd given by "
 void trace_vprintf(const char *key, const char *fmt, va_list ap)
 {
 	struct strbuf buf = STRBUF_INIT;
-	int fd, need_close = 0;
 
-	fd = get_trace_fd(key, &need_close);
-	if (!fd)
+	if (!trace_want(key))
 		return;
 
 	set_try_to_free_routine(NULL);	/* is never reset */
 	strbuf_addv(&buf, fmt, ap);
-	write_or_whine_pipe(fd, buf.buf, buf.len, err_msg);
+	trace_strbuf(key, &buf);
 	strbuf_release(&buf);
-
-	if (need_close)
-		close(fd);
 }
 
 void trace_printf_key(const char *key, const char *fmt, ...)
@@ -96,6 +91,20 @@ void trace_printf(const char *fmt, ...)
 	va_end(ap);
 }
 
+void trace_strbuf(const char *key, const struct strbuf *buf)
+{
+	int fd, need_close = 0;
+
+	fd = get_trace_fd(key, &need_close);
+	if (!fd)
+		return;
+
+	write_or_whine_pipe(fd, buf->buf, buf->len, err_msg);
+
+	if (need_close)
+		close(fd);
+}
+
 void trace_argv_printf(const char **argv, const char *fmt, ...)
 {
 	struct strbuf buf = STRBUF_INIT;
-- 
1.7.2.5.25.g3bb93
