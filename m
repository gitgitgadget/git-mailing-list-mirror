Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5F721201A7
	for <e@80x24.org>; Sat, 13 May 2017 03:28:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750909AbdEMD2y (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 May 2017 23:28:54 -0400
Received: from cloud.peff.net ([104.130.231.41]:50638 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750734AbdEMD2x (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 May 2017 23:28:53 -0400
Received: (qmail 6565 invoked by uid 109); 13 May 2017 03:28:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 13 May 2017 03:28:53 +0000
Received: (qmail 29059 invoked by uid 111); 13 May 2017 03:29:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 12 May 2017 23:29:24 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 12 May 2017 23:28:50 -0400
Date:   Fri, 12 May 2017 23:28:50 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Josh Hagins <hagins.josh@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 1/3] usage.c: add BUG() function
Message-ID: <20170513032850.zeru4cm2l7i23rkc@sigill.intra.peff.net>
References: <20170513032414.mfrwabt4hovujde2@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170513032414.mfrwabt4hovujde2@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There's a convention in Git's code base to write assertions
as:

  if (...some_bad_thing...)
	die("BUG: the terrible thing happened");

with the idea that users should never see a "BUG:" message
(but if they, it at least gives a clue what happened).  We
use die() here because it's convenient, but there are a few
draw-backs:

  1. Without parsing the messages, it's hard for callers to
     distinguish BUG assertions from regular errors.

     For instance, it would be nice if the test suite could
     check that we don't hit any assertions, but
     test_must_fail will pass BUG deaths as OK.

  2. It would be useful to add more debugging features to
     BUG assertions, like file/line numbers or dumping core.

  3. The die() handler can be replaced, and might not
     actually exit the whole program (e.g., it may just
     pthread_exit()). This is convenient for normal errors,
     but for an assertion failure (which is supposed to
     never happen), we're probably better off taking down
     the whole process as quickly and cleanly as possible.

We could address these by checking in die() whether the
error message starts with "BUG", and behaving appropriately.
But there's little advantage at that point to sharing the
die() code, and only downsides (e.g., we can't change the
BUG() interface independently). Moreover, converting all of
the existing BUG calls reveals that the test suite does
indeed trigger a few of them.

Instead, this patch introduces a new BUG() function, which
prints an error before dying via SIGABRT. This gives us test
suite checking and core dumps.  The function is actually a
macro (when supported) so that we can show the file/line
number.

We can convert die("BUG") invocations to BUG() in further
patches, dealing with any test fallouts individually.

Signed-off-by: Jeff King <peff@peff.net>
---
I actually don't care that much about the file/line thing
personally. The messages are generally unique, which lets
you find them in the code base easily. And it does introduce
a lot of complexity due to the variadic macro fallback. So
we could just drop it and have a much simpler patch
(basically just die() without the abstracted handler, and
with abort() instead of exit()).

 git-compat-util.h |  9 +++++++++
 usage.c           | 32 ++++++++++++++++++++++++++++++++
 2 files changed, 41 insertions(+)

diff --git a/git-compat-util.h b/git-compat-util.h
index bd04564a6..4575b3890 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -1064,6 +1064,15 @@ static inline int regexec_buf(const regex_t *preg, const char *buf, size_t size,
 #define HAVE_VARIADIC_MACROS 1
 #endif
 
+#ifdef HAVE_VARIADIC_MACROS
+__attribute__((format (printf, 3, 4))) NORETURN
+void BUG_fl(const char *file, int line, const char *fmt, ...);
+#define BUG(...) BUG_fl(__FILE__, __LINE__, __VA_ARGS__)
+#else
+__attribute__((format (printf, 1, 2))) NORETURN
+void BUG(const char *fmt, ...);
+#endif
+
 /*
  * Preserves errno, prints a message, but gives no warning for ENOENT.
  * Returns 0 on success, which includes trying to unlink an object that does
diff --git a/usage.c b/usage.c
index ad6d2910f..7e6cb2028 100644
--- a/usage.c
+++ b/usage.c
@@ -201,3 +201,35 @@ void warning(const char *warn, ...)
 	warn_routine(warn, params);
 	va_end(params);
 }
+
+static NORETURN void BUG_vfl(const char *file, int line, const char *fmt, va_list params)
+{
+	char prefix[256];
+
+	/* truncation via snprintf is OK here */
+	if (file)
+		snprintf(prefix, sizeof(prefix), "BUG: %s:%d: ", file, line);
+	else
+		snprintf(prefix, sizeof(prefix), "BUG: ");
+
+	vreportf(prefix, fmt, params);
+	abort();
+}
+
+#ifdef HAVE_VARIADIC_MACROS
+void BUG_fl(const char *file, int line, const char *fmt, ...)
+{
+	va_list ap;
+	va_start(ap, fmt);
+	BUG_vfl(file, line, fmt, ap);
+	va_end(ap);
+}
+#else
+void BUG(const char *fmt, ...)
+{
+	va_list ap;
+	va_start(ap, fmt);
+	BUG_vfl(NULL, 0, fmt, ap);
+	va_end(ap);
+}
+#endif
-- 
2.13.0.452.g0afc8e12b

