From: Jeff King <peff@peff.net>
Subject: [PATCH 3/8] trace: add trace_vprintf
Date: Thu, 24 Feb 2011 09:28:15 -0500
Message-ID: <20110224142814.GC15477@sigill.intra.peff.net>
References: <20110224142308.GA15356@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 24 15:28:21 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PscB3-0007H4-CT
	for gcvg-git-2@lo.gmane.org; Thu, 24 Feb 2011 15:28:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756057Ab1BXO2Q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Feb 2011 09:28:16 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:57944 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754868Ab1BXO2Q (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Feb 2011 09:28:16 -0500
Received: (qmail 23303 invoked by uid 111); 24 Feb 2011 14:28:15 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Thu, 24 Feb 2011 14:28:15 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 Feb 2011 09:28:15 -0500
Content-Disposition: inline
In-Reply-To: <20110224142308.GA15356@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167813>

This is a necessary cleanup to adding new types of trace
functions.

Signed-off-by: Jeff King <peff@peff.net>
---
 cache.h |    1 +
 trace.c |   14 +++++++++-----
 2 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/cache.h b/cache.h
index 4a758ba..08b23b2 100644
--- a/cache.h
+++ b/cache.h
@@ -1067,6 +1067,7 @@ extern void alloc_report(void);
 /* trace.c */
 __attribute__((format (printf, 1, 2)))
 extern void trace_printf(const char *format, ...);
+extern void trace_vprintf(const char *format, va_list ap);
 __attribute__((format (printf, 2, 3)))
 extern void trace_argv_printf(const char **argv, const char *format, ...);
 extern void trace_repo_setup(const char *prefix);
diff --git a/trace.c b/trace.c
index 745543c..6ad7788 100644
--- a/trace.c
+++ b/trace.c
@@ -62,10 +62,9 @@ static int get_trace_fd(int *need_close)
 static const char err_msg[] = "Could not trace into fd given by "
 	"GIT_TRACE environment variable";
 
-void trace_printf(const char *fmt, ...)
+void trace_vprintf(const char *fmt, va_list ap)
 {
 	struct strbuf buf = STRBUF_INIT;
-	va_list ap;
 	int fd, need_close = 0;
 
 	fd = get_trace_fd(&need_close);
@@ -73,10 +72,7 @@ void trace_printf(const char *fmt, ...)
 		return;
 
 	set_try_to_free_routine(NULL);	/* is never reset */
-	va_start(ap, fmt);
 	strbuf_addv(&buf, fmt, ap);
-	va_end(ap);
-
 	write_or_whine_pipe(fd, buf.buf, buf.len, err_msg);
 	strbuf_release(&buf);
 
@@ -84,6 +80,14 @@ void trace_printf(const char *fmt, ...)
 		close(fd);
 }
 
+void trace_printf(const char *fmt, ...)
+{
+	va_list ap;
+	va_start(ap, fmt);
+	trace_vprintf(fmt, ap);
+	va_end(ap);
+}
+
 void trace_argv_printf(const char **argv, const char *fmt, ...)
 {
 	struct strbuf buf = STRBUF_INIT;
-- 
1.7.2.5.25.g3bb93
