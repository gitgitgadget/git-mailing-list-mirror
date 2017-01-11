Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B3624205C9
	for <e@80x24.org>; Wed, 11 Jan 2017 14:02:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S967102AbdAKOCI (ORCPT <rfc822;e@80x24.org>);
        Wed, 11 Jan 2017 09:02:08 -0500
Received: from cloud.peff.net ([104.130.231.41]:37982 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S967099AbdAKOCH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Jan 2017 09:02:07 -0500
Received: (qmail 811 invoked by uid 109); 11 Jan 2017 14:02:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 11 Jan 2017 14:02:07 +0000
Received: (qmail 22091 invoked by uid 111); 11 Jan 2017 14:02:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 11 Jan 2017 09:02:59 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 11 Jan 2017 09:02:03 -0500
Date:   Wed, 11 Jan 2017 09:02:03 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 1/2] Revert "vreportf: avoid intermediate buffer"
Message-ID: <20170111140203.obhd2t6yorszex73@sigill.intra.peff.net>
References: <20170111140138.5p647xuqpqrej63b@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170111140138.5p647xuqpqrej63b@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This reverts commit f4c3edc0b156362a92bf9de4f0ec794e90a757fc.

The purpose of that commit was to let us write errors of
arbitrary length to stderr by skipping the intermediate
buffer and sending our varargs straight to fprintf. That
works, but it comes with a downside: we do not get access to
the varargs before they are sent to stderr.

On balance, it's not a good tradeoff. Error messages larger
than our 4K buffer are quite uncommon, and we've lost the
ability to make any modifications to the output (e.g., to
remove non-printable characters).

The only way to have both would be one of:

  1. Write into a dynamic buffer. But this is a bad idea for
     a low-level function that may be called when malloc()
     has failed.

  2. Do our own printf-format varargs parsing. This is too
     complex to be worth the trouble.

Let's just revert that change and go back to a fixed buffer.

Signed-off-by: Jeff King <peff@peff.net>
---
 usage.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/usage.c b/usage.c
index 17f52c1b5..b1cbe6799 100644
--- a/usage.c
+++ b/usage.c
@@ -7,21 +7,13 @@
 #include "cache.h"
 
 static FILE *error_handle;
-static int tweaked_error_buffering;
 
 void vreportf(const char *prefix, const char *err, va_list params)
 {
+	char msg[4096];
 	FILE *fh = error_handle ? error_handle : stderr;
-
-	fflush(fh);
-	if (!tweaked_error_buffering) {
-		setvbuf(fh, NULL, _IOLBF, 0);
-		tweaked_error_buffering = 1;
-	}
-
-	fputs(prefix, fh);
-	vfprintf(fh, err, params);
-	fputc('\n', fh);
+	vsnprintf(msg, sizeof(msg), err, params);
+	fprintf(fh, "%s%s\n", prefix, msg);
 }
 
 static NORETURN void usage_builtin(const char *err, va_list params)
@@ -93,7 +85,6 @@ void set_die_is_recursing_routine(int (*routine)(void))
 void set_error_handle(FILE *fh)
 {
 	error_handle = fh;
-	tweaked_error_buffering = 0;
 }
 
 void NORETURN usagef(const char *err, ...)
-- 
2.11.0.627.gfa6151259

