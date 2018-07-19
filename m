Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 37E471F597
	for <e@80x24.org>; Thu, 19 Jul 2018 20:39:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727769AbeGSVYW (ORCPT <rfc822;e@80x24.org>);
        Thu, 19 Jul 2018 17:24:22 -0400
Received: from cloud.peff.net ([104.130.231.41]:53214 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727523AbeGSVYW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jul 2018 17:24:22 -0400
Received: (qmail 9072 invoked by uid 109); 19 Jul 2018 20:39:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 19 Jul 2018 20:39:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16528 invoked by uid 111); 19 Jul 2018 20:39:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 19 Jul 2018 16:39:40 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 19 Jul 2018 16:39:34 -0400
Date:   Thu, 19 Jul 2018 16:39:34 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCH 2/2] banned.h: mark strncpy as banned
Message-ID: <20180719203934.GB8079@sigill.intra.peff.net>
References: <20180719203259.GA7869@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180719203259.GA7869@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The strncpy() function is less horrible than strcpy(). But
it's still pretty easy to misuse because of its funny
termination semantics. And we already have a ready-made
alternative in strlcpy. So let's ban it, to make sure uses
don't creep in.

Note that there is one instance of strncpy in
compat/regex/regcomp.c. But this doesn't trigger the
ban-list even when compiling with NO_REGEX=1, because we
don't use git-compat-util.h when compiling it (instead we
rely on the system includes from the upstream library).

Since this use of strncpy was verified by manual inspection
and since it doesn't trigger the automated ban-list, we're
better off leaving it to keep our divergence from glibc
minimal.

Signed-off-by: Jeff King <peff@peff.net>
---
 banned.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/banned.h b/banned.h
index fe81020e0f..ae6aaaa4a9 100644
--- a/banned.h
+++ b/banned.h
@@ -11,6 +11,7 @@
 #define BANNED(func) sorry_##func##_is_a_banned_function()
 
 #define strcpy(x,y) BANNED(strcpy)
+#define strncpy(x,y,n) BANNED(strncpy)
 
 #ifdef HAVE_VARIADIC_MACROS
 #define sprintf(...) BANNED(sprintf)
-- 
2.18.0.540.g6c38643a7b
