From: Jeff King <peff@peff.net>
Subject: [PATCH 5/8] trace: factor out "do we want to trace" logic
Date: Thu, 24 Feb 2011 09:28:59 -0500
Message-ID: <20110224142859.GE15477@sigill.intra.peff.net>
References: <20110224142308.GA15356@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 24 15:29:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PscBm-0007kj-W7
	for gcvg-git-2@lo.gmane.org; Thu, 24 Feb 2011 15:29:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756138Ab1BXO3B (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Feb 2011 09:29:01 -0500
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:57954 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755575Ab1BXO3A (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Feb 2011 09:29:00 -0500
Received: (qmail 23351 invoked by uid 111); 24 Feb 2011 14:29:00 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Thu, 24 Feb 2011 14:29:00 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 Feb 2011 09:28:59 -0500
Content-Disposition: inline
In-Reply-To: <20110224142308.GA15356@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167815>

As we add more tracing areas, this will avoid repeated code.

Technically, trace_printf already checks this and will avoid
printing if the trace key is not set. However, callers may
want to find out early whether or not tracing is enabled so
they can avoid doing work in the common non-trace case.

Signed-off-by: Jeff King <peff@peff.net>
---
 cache.h |    1 +
 trace.c |   14 +++++++++++---
 2 files changed, 12 insertions(+), 3 deletions(-)

diff --git a/cache.h b/cache.h
index 2ab1bf9..211d7bb 100644
--- a/cache.h
+++ b/cache.h
@@ -1071,6 +1071,7 @@ extern void trace_vprintf(const char *key, const char *format, va_list ap);
 __attribute__((format (printf, 2, 3)))
 extern void trace_argv_printf(const char **argv, const char *format, ...);
 extern void trace_repo_setup(const char *prefix);
+extern int trace_want(const char *key);
 
 /* convert.c */
 /* returns 1 if *dst was used */
diff --git a/trace.c b/trace.c
index a74f00e..f00d98f 100644
--- a/trace.c
+++ b/trace.c
@@ -148,10 +148,8 @@ void trace_repo_setup(const char *prefix)
 {
 	const char *git_work_tree;
 	char cwd[PATH_MAX];
-	char *trace = getenv("GIT_TRACE");
 
-	if (!trace || !strcmp(trace, "") ||
-	    !strcmp(trace, "0") || !strcasecmp(trace, "false"))
+	if (!trace_want("GIT_TRACE"))
 		return;
 
 	if (!getcwd(cwd, PATH_MAX))
@@ -168,3 +166,13 @@ void trace_repo_setup(const char *prefix)
 	trace_printf("setup: cwd: %s\n", quote_crnl(cwd));
 	trace_printf("setup: prefix: %s\n", quote_crnl(prefix));
 }
+
+int trace_want(const char *key)
+{
+	const char *trace = getenv(key);
+
+	if (!trace || !strcmp(trace, "") ||
+	    !strcmp(trace, "0") || !strcasecmp(trace, "false"))
+		return 0;
+	return 1;
+}
-- 
1.7.2.5.25.g3bb93
