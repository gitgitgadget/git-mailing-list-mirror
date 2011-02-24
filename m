From: Jeff King <peff@peff.net>
Subject: [PATCH 4/8] trace: refactor to support multiple env variables
Date: Thu, 24 Feb 2011 09:28:41 -0500
Message-ID: <20110224142841.GD15477@sigill.intra.peff.net>
References: <20110224142308.GA15356@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 24 15:28:48 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PscBU-0007WL-He
	for gcvg-git-2@lo.gmane.org; Thu, 24 Feb 2011 15:28:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756135Ab1BXO2m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Feb 2011 09:28:42 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:57950 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754868Ab1BXO2m (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Feb 2011 09:28:42 -0500
Received: (qmail 23327 invoked by uid 111); 24 Feb 2011 14:28:41 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Thu, 24 Feb 2011 14:28:41 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 Feb 2011 09:28:41 -0500
Content-Disposition: inline
In-Reply-To: <20110224142308.GA15356@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167814>

Right now you turn all tracing off and on with GIT_TRACE. To
support new types of tracing without forcing the user to see
all of them, we will soon support turning each tracing area
on with GIT_TRACE_*.

This patch lays the groundwork by providing an interface
which does not assume GIT_TRACE. However, we still maintain
the trace_printf interface so that existing callers do not
need to be refactored.

Signed-off-by: Jeff King <peff@peff.net>
---
 cache.h |    2 +-
 trace.c |   28 ++++++++++++++++++----------
 2 files changed, 19 insertions(+), 11 deletions(-)

diff --git a/cache.h b/cache.h
index 08b23b2..2ab1bf9 100644
--- a/cache.h
+++ b/cache.h
@@ -1067,7 +1067,7 @@ extern void alloc_report(void);
 /* trace.c */
 __attribute__((format (printf, 1, 2)))
 extern void trace_printf(const char *format, ...);
-extern void trace_vprintf(const char *format, va_list ap);
+extern void trace_vprintf(const char *key, const char *format, va_list ap);
 __attribute__((format (printf, 2, 3)))
 extern void trace_argv_printf(const char **argv, const char *format, ...);
 extern void trace_repo_setup(const char *prefix);
diff --git a/trace.c b/trace.c
index 6ad7788..a74f00e 100644
--- a/trace.c
+++ b/trace.c
@@ -25,10 +25,10 @@
 #include "cache.h"
 #include "quote.h"
 
-/* Get a trace file descriptor from GIT_TRACE env variable. */
-static int get_trace_fd(int *need_close)
+/* Get a trace file descriptor from "key" env variable. */
+static int get_trace_fd(const char *key, int *need_close)
 {
-	char *trace = getenv("GIT_TRACE");
+	char *trace = getenv(key);
 
 	if (!trace || !strcmp(trace, "") ||
 	    !strcmp(trace, "0") || !strcasecmp(trace, "false"))
@@ -50,10 +50,10 @@ static int get_trace_fd(int *need_close)
 		return fd;
 	}
 
-	fprintf(stderr, "What does '%s' for GIT_TRACE mean?\n", trace);
+	fprintf(stderr, "What does '%s' for %s mean?\n", trace, key);
 	fprintf(stderr, "If you want to trace into a file, "
-		"then please set GIT_TRACE to an absolute pathname "
-		"(starting with /).\n");
+		"then please set %s to an absolute pathname "
+		"(starting with /).\n", key);
 	fprintf(stderr, "Defaulting to tracing on stderr...\n");
 
 	return STDERR_FILENO;
@@ -62,12 +62,12 @@ static int get_trace_fd(int *need_close)
 static const char err_msg[] = "Could not trace into fd given by "
 	"GIT_TRACE environment variable";
 
-void trace_vprintf(const char *fmt, va_list ap)
+void trace_vprintf(const char *key, const char *fmt, va_list ap)
 {
 	struct strbuf buf = STRBUF_INIT;
 	int fd, need_close = 0;
 
-	fd = get_trace_fd(&need_close);
+	fd = get_trace_fd(key, &need_close);
 	if (!fd)
 		return;
 
@@ -80,11 +80,19 @@ void trace_vprintf(const char *fmt, va_list ap)
 		close(fd);
 }
 
+void trace_printf_key(const char *key, const char *fmt, ...)
+{
+	va_list ap;
+	va_start(ap, fmt);
+	trace_vprintf(key, fmt, ap);
+	va_end(ap);
+}
+
 void trace_printf(const char *fmt, ...)
 {
 	va_list ap;
 	va_start(ap, fmt);
-	trace_vprintf(fmt, ap);
+	trace_vprintf("GIT_TRACE", fmt, ap);
 	va_end(ap);
 }
 
@@ -94,7 +102,7 @@ void trace_argv_printf(const char **argv, const char *fmt, ...)
 	va_list ap;
 	int fd, need_close = 0;
 
-	fd = get_trace_fd(&need_close);
+	fd = get_trace_fd("GIT_TRACE", &need_close);
 	if (!fd)
 		return;
 
-- 
1.7.2.5.25.g3bb93
