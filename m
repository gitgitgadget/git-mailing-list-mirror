Return-Path: <SRS0=JG/V=3O=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5811EC35241
	for <git@archiver.kernel.org>; Sat, 25 Jan 2020 05:39:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35C782075E
	for <git@archiver.kernel.org>; Sat, 25 Jan 2020 05:39:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728266AbgAYFjb (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 25 Jan 2020 00:39:31 -0500
Received: from cloud.peff.net ([104.130.231.41]:44400 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725601AbgAYFja (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Jan 2020 00:39:30 -0500
Received: (qmail 10957 invoked by uid 109); 25 Jan 2020 05:39:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 25 Jan 2020 05:39:31 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13837 invoked by uid 111); 25 Jan 2020 05:46:43 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sat, 25 Jan 2020 00:46:43 -0500
Authentication-Results: peff.net; auth=none
Date:   Sat, 25 Jan 2020 00:39:29 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 3/4] xdiff: avoid computing non-zero offset from NULL pointer
Message-ID: <20200125053929.GC744673@coredump.intra.peff.net>
References: <20200125053542.GA744596@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200125053542.GA744596@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As with the previous commit, clang-11's UBSan complains about computing
offsets from a NULL pointer, causing some tests to fail. In this case,
though, we're actually computing a non-zero offset, which is even more
dubious. From t7810:

  xdiff-interface.c:268:14: runtime error: applying non-zero offset 1 to null pointer
  ...
  not ok 131 - grep -p with userdiff

The problem is our parsing of the funcname config. We count the number
of lines in the string, allocate an array, and then loop over our
allocated entries, parsing each line and moving our cursor to one past
the trailing newline for the next iteration.

But the final line will not generally have a trailing newline (since
it's a config value), and hence we go to one past NULL. In practice this
is OK, since our loop should terminate before we look at the value. But
even computing such an invalid pointer technically violates the
standard.

We can fix it by leaving the pointer at NULL if we're at the end, rather
than one-past. And while we're thinking about it, we can also document
the variant by asserting that our initial line-count matches the
second-pass of parsing.

Signed-off-by: Jeff King <peff@peff.net>
---
 xdiff-interface.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/xdiff-interface.c b/xdiff-interface.c
index 2f1fe48512..3cd2ac2855 100644
--- a/xdiff-interface.c
+++ b/xdiff-interface.c
@@ -250,9 +250,13 @@ void xdiff_set_find_func(xdemitconf_t *xecfg, const char *value, int cflags)
 	ALLOC_ARRAY(regs->array, regs->nr);
 	for (i = 0; i < regs->nr; i++) {
 		struct ff_reg *reg = regs->array + i;
-		const char *ep = strchr(value, '\n'), *expression;
+		const char *ep, *expression;
 		char *buffer = NULL;
 
+		if (!value)
+			BUG("mismatch between line count and parsing");
+		ep = strchr(value, '\n');
+
 		reg->negate = (*value == '!');
 		if (reg->negate && i == regs->nr - 1)
 			die("Last expression must not be negated: %s", value);
@@ -265,7 +269,7 @@ void xdiff_set_find_func(xdemitconf_t *xecfg, const char *value, int cflags)
 		if (regcomp(&reg->re, expression, cflags))
 			die("Invalid regexp to look for hunk header: %s", expression);
 		free(buffer);
-		value = ep + 1;
+		value = ep ? ep + 1 : NULL;
 	}
 }
 
-- 
2.25.0.421.gb74d19af79

