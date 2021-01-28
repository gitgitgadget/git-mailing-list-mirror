Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE25BC433E0
	for <git@archiver.kernel.org>; Thu, 28 Jan 2021 05:29:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F20664DCC
	for <git@archiver.kernel.org>; Thu, 28 Jan 2021 05:29:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229569AbhA1F3P (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 28 Jan 2021 00:29:15 -0500
Received: from cloud.peff.net ([104.130.231.41]:41586 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229551AbhA1F3P (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Jan 2021 00:29:15 -0500
Received: (qmail 9339 invoked by uid 109); 28 Jan 2021 05:28:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 28 Jan 2021 05:28:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24799 invoked by uid 111); 28 Jan 2021 05:28:36 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 28 Jan 2021 00:28:36 -0500
Authentication-Results: peff.net; auth=none
Date:   Thu, 28 Jan 2021 00:28:33 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH] git-compat-util: always enable variadic macros
Message-ID: <YBJLgY+CWtS9TeVb@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We allow variadic macros in the code base, but only if there is fallback
code for platforms that lack it. This leads to some annoyances:

  - the code is more complicated because of the fallbacks (e.g.,
    trace_printf(), etc, is implemented twice with a set of parallel
    wrappers).

  - some constructs are just impossible and we've had to live without
    them (e.g., a cross between FLEX_ALLOC and xstrfmt)

Since this feature is present in C99, we may be able to start counting
on it being available everywhere. Let's start with a weather balloon
patch to find out.

This patch makes the absolute minimal change by always setting
HAVE_VARIADIC_MACROS. If somebody runs into a platform where it's a
problem, they can undo it by commenting out the define. Likewise, if we
have to revert this, it would be quite unlikely to cause conflicts.

Once we feel comfortable that this is the right direction, then we can
start ripping out all the spots that actually look at the flag, and
removing the dead code.

Signed-off-by: Jeff King <peff@peff.net>
---
We've talked about this off and on for a few years. I don't have any
immediate plans for any features that need it, but let's get the ball
rolling.

 git-compat-util.h | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/git-compat-util.h b/git-compat-util.h
index 104993b975..5d5e47fbe2 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -1176,9 +1176,12 @@ static inline int regexec_buf(const regex_t *preg, const char *buf, size_t size,
 #endif
 #endif
 
-#if defined(__GNUC__) || (_MSC_VER >= 1400) || defined(__C99_MACRO_WITH_VA_ARGS)
+/*
+ * This is always defined as a first step towards making the use of variadic
+ * macros unconditional. If it causes compilation problems on your platform,
+ * please report it to the Git mailing list at git@vger.kernel.org.
+ */
 #define HAVE_VARIADIC_MACROS 1
-#endif
 
 /* usage.c: only to be used for testing BUG() implementation (see test-tool) */
 extern int BUG_exit_code;
-- 
2.30.0.758.gfe500d6872
