Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0AC911F453
	for <e@80x24.org>; Thu, 18 Oct 2018 07:05:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727598AbeJRPE6 (ORCPT <rfc822;e@80x24.org>);
        Thu, 18 Oct 2018 11:04:58 -0400
Received: from cloud.peff.net ([104.130.231.41]:44458 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727351AbeJRPE6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Oct 2018 11:04:58 -0400
Received: (qmail 17406 invoked by uid 109); 18 Oct 2018 07:05:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 18 Oct 2018 07:05:24 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27669 invoked by uid 111); 18 Oct 2018 07:04:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 18 Oct 2018 03:04:35 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 18 Oct 2018 03:05:22 -0400
Date:   Thu, 18 Oct 2018 03:05:22 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: [PATCH] config.mak.dev: enable -Wunused-function
Message-ID: <20181018070522.GA29499@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We explicitly omitted -Wunused-function when we added
-Wextra, but there is no need: the current code compiles
cleanly with it. And it's worth having, since it can let you
know when there are cascading effects from a cleanup (e.g.,
deleting one function lets you delete its static helpers).

There are cases where we may need an unused function to
exist, but we can handle these easily:

  - macro-generated code like commit-slab; there we have the
    MAYBE_UNUSED annotation to silence the compiler

  - conditional compilation, where we may or may not need a
    static helper. These generally fall into one of two
    categories:

      - the call should not be conditional, but rather the
	function body itself should be (and may just be a
	no-op on one side of the #if). That keeps the
	conditional pollution out of the main code.

      - call-chains of static helpers should all be in the
        same #if block, so they are all-or-nothing

    And if there's some case that doesn't cover, we still
    have MAYBE_UNUSED as a fallback.

Signed-off-by: Jeff King <peff@peff.net>
---
 config.mak.dev | 1 -
 1 file changed, 1 deletion(-)

diff --git a/config.mak.dev b/config.mak.dev
index 92d268137f..bbeeff44fe 100644
--- a/config.mak.dev
+++ b/config.mak.dev
@@ -34,7 +34,6 @@ ifeq ($(filter extra-all,$(DEVOPTS)),)
 CFLAGS += -Wno-empty-body
 CFLAGS += -Wno-missing-field-initializers
 CFLAGS += -Wno-sign-compare
-CFLAGS += -Wno-unused-function
 CFLAGS += -Wno-unused-parameter
 endif
 endif
-- 
2.19.1.823.g84a1dd67bf
