Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 901441FBB0
	for <e@80x24.org>; Wed, 31 Aug 2016 03:41:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1759186AbcHaDl3 (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Aug 2016 23:41:29 -0400
Received: from cloud.peff.net ([104.130.231.41]:35703 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1759155AbcHaDl2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Aug 2016 23:41:28 -0400
Received: (qmail 32136 invoked by uid 109); 31 Aug 2016 03:41:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 31 Aug 2016 03:41:26 +0000
Received: (qmail 2712 invoked by uid 111); 31 Aug 2016 03:41:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 30 Aug 2016 23:41:32 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 30 Aug 2016 23:41:22 -0400
Date:   Tue, 30 Aug 2016 23:41:22 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 1/2] error_errno: use constant return similar to error()
Message-ID: <20160831034121.llw7ypnnwgaszarb@sigill.intra.peff.net>
References: <20160831033934.m2at7ci5f6lty5nb@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20160831033934.m2at7ci5f6lty5nb@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commit e208f9c (make error()'s constant return value more
visible, 2012-12-15) introduced some macro trickery to make
the constant return from error() more visible to callers,
which in turn can help gcc produce better warnings (and
possibly even better code).

Later, fd1d672 (usage.c: add warning_errno() and
error_errno(), 2016-05-08) introduced another variant, and
subsequent commits converted some uses of error() to
error_errno(), losing the magic from e208f9c for those
sites.

As a result, compiling vcs-svn/svndiff.c with "gcc -O3"
produces -Wmaybe-uninitialized false positives (at least
with gcc 6.2.0). Let's give error_errno() the same
treatment, which silences these warnings.

Signed-off-by: Jeff King <peff@peff.net>
---
 git-compat-util.h | 1 +
 usage.c           | 1 +
 2 files changed, 2 insertions(+)

diff --git a/git-compat-util.h b/git-compat-util.h
index db89ba7..2ad45b3 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -436,6 +436,7 @@ static inline int const_error(void)
 	return -1;
 }
 #define error(...) (error(__VA_ARGS__), const_error())
+#define error_errno(...) (error_errno(__VA_ARGS__), const_error())
 #endif
 
 extern void set_die_routine(NORETURN_PTR void (*routine)(const char *err, va_list params));
diff --git a/usage.c b/usage.c
index 1dad03f..0efa3fa 100644
--- a/usage.c
+++ b/usage.c
@@ -148,6 +148,7 @@ void NORETURN die_errno(const char *fmt, ...)
 	va_end(params);
 }
 
+#undef error_errno
 int error_errno(const char *fmt, ...)
 {
 	char buf[1024];
-- 
2.10.0.rc2.125.gcfb3d08

