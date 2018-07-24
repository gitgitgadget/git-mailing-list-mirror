Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A5D3B1F597
	for <e@80x24.org>; Tue, 24 Jul 2018 09:28:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388407AbeGXKeD (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Jul 2018 06:34:03 -0400
Received: from cloud.peff.net ([104.130.231.41]:57194 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S2388145AbeGXKeD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Jul 2018 06:34:03 -0400
Received: (qmail 7743 invoked by uid 109); 24 Jul 2018 09:28:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 24 Jul 2018 09:28:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25659 invoked by uid 111); 24 Jul 2018 09:28:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 24 Jul 2018 05:28:29 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 24 Jul 2018 05:28:28 -0400
Date:   Tue, 24 Jul 2018 05:28:28 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 4/4] banned.h: mark strncpy() as banned
Message-ID: <20180724092828.GD3288@sigill.intra.peff.net>
References: <20180724092329.GA24250@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180724092329.GA24250@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The strncpy() function is less horrible than strcpy(), but
is still pretty easy to misuse because of its funny
termination semantics. Namely, that if it truncates it omits
the NUL terminator, and you must remember to add it
yourself. Even if you use it correctly, it's sometimes hard
for a reader to verify this without hunting through the
code. If you're thinking about using it, consider instead:

  - strlcpy() if you really just need a truncated but
    NUL-terminated string (we provide a compat version, so
    it's always available)

  - xsnprintf() if you're sure that what you're copying
    should fit

  - strbuf or xstrfmt() if you need to handle
    arbitrary-length heap-allocated strings

Note that there is one instance of strncpy in
compat/regex/regcomp.c, which is fine (it allocates a
sufficiently large string before copying). But this doesn't
trigger the ban-list even when compiling with NO_REGEX=1,
because:

  1. we don't use git-compat-util.h when compiling it
     (instead we rely on the system includes from the
     upstream library); and

  2. It's in an "#ifdef DEBUG" block

Since it's doesn't trigger the banned.h code, we're better
off leaving it to keep our divergence from upstream minimal.

Signed-off-by: Jeff King <peff@peff.net>
---
 banned.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/banned.h b/banned.h
index c83d6cb9df..ab96954583 100644
--- a/banned.h
+++ b/banned.h
@@ -14,6 +14,8 @@
 #define strcpy(x,y) BANNED(strcpy)
 #undef strcat
 #define strcat(x,y) BANNED(strcat)
+#undef strncpy
+#define strncpy(x,y,n) BANNED(strncpy)
 
 #undef sprintf
 #undef vsprintf
-- 
2.18.0.542.g2bf2fc4f7e
