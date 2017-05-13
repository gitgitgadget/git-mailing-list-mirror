Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7FF67201A7
	for <e@80x24.org>; Sat, 13 May 2017 03:48:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751388AbdEMDsX (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 May 2017 23:48:23 -0400
Received: from cloud.peff.net ([104.130.231.41]:50659 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751327AbdEMDsW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 May 2017 23:48:22 -0400
Received: (qmail 7702 invoked by uid 109); 13 May 2017 03:48:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 13 May 2017 03:48:21 +0000
Received: (qmail 29192 invoked by uid 111); 13 May 2017 03:48:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 12 May 2017 23:48:52 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 12 May 2017 23:48:18 -0400
Date:   Fri, 12 May 2017 23:48:18 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Brandon Williams <bmwill@google.com>
Subject: [PATCH] usage.c: drop set_error_handle()
Message-ID: <20170513034818.h3aaihqmf4q43vef@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The set_error_handle() function was introduced by 3b331e926
(vreportf: report to arbitrary filehandles, 2015-08-11) so
that run-command could send post-fork, pre-exec errors to
the parent's original stderr.

That use went away in 79319b194 (run-command: eliminate
calls to error handling functions in child, 2017-04-19),
which pushes all of the error reporting to the parent.
This leaves no callers of set_error_handle(). As we're not
likely to add any new ones, let's drop it.

Signed-off-by: Jeff King <peff@peff.net>
---
This goes on top of bw/forking-and-threading.

 git-compat-util.h |  1 -
 usage.c           | 10 +---------
 2 files changed, 1 insertion(+), 10 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index 8a4a3f85e..f1f2a2d73 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -445,7 +445,6 @@ extern void (*get_error_routine(void))(const char *err, va_list params);
 extern void set_warn_routine(void (*routine)(const char *warn, va_list params));
 extern void (*get_warn_routine(void))(const char *warn, va_list params);
 extern void set_die_is_recursing_routine(int (*routine)(void));
-extern void set_error_handle(FILE *);
 
 extern int starts_with(const char *str, const char *prefix);
 
diff --git a/usage.c b/usage.c
index ad6d2910f..2623c078e 100644
--- a/usage.c
+++ b/usage.c
@@ -6,12 +6,9 @@
 #include "git-compat-util.h"
 #include "cache.h"
 
-static FILE *error_handle;
-
 void vreportf(const char *prefix, const char *err, va_list params)
 {
 	char msg[4096];
-	FILE *fh = error_handle ? error_handle : stderr;
 	char *p;
 
 	vsnprintf(msg, sizeof(msg), err, params);
@@ -19,7 +16,7 @@ void vreportf(const char *prefix, const char *err, va_list params)
 		if (iscntrl(*p) && *p != '\t' && *p != '\n')
 			*p = '?';
 	}
-	fprintf(fh, "%s%s\n", prefix, msg);
+	fprintf(stderr, "%s%s\n", prefix, msg);
 }
 
 static NORETURN void usage_builtin(const char *err, va_list params)
@@ -88,11 +85,6 @@ void set_die_is_recursing_routine(int (*routine)(void))
 	die_is_recursing = routine;
 }
 
-void set_error_handle(FILE *fh)
-{
-	error_handle = fh;
-}
-
 void NORETURN usagef(const char *err, ...)
 {
 	va_list params;
-- 
2.13.0.452.g0afc8e12b
