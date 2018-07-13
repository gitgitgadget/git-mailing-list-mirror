Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F02AE1F85E
	for <e@80x24.org>; Fri, 13 Jul 2018 20:43:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731622AbeGMVAH (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Jul 2018 17:00:07 -0400
Received: from cloud.peff.net ([104.130.231.41]:58980 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1731564AbeGMVAG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Jul 2018 17:00:06 -0400
Received: (qmail 3054 invoked by uid 109); 13 Jul 2018 20:43:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 13 Jul 2018 20:43:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 7323 invoked by uid 111); 13 Jul 2018 20:43:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 13 Jul 2018 16:43:55 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 13 Jul 2018 16:43:50 -0400
Date:   Fri, 13 Jul 2018 16:43:50 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>
Subject: [PATCH] blame: prefer xsnprintf to strcpy for colors
Message-ID: <20180713204350.GA16999@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Our color buffers are all COLOR_MAXLEN, which fits the
largest possible color. So we can never overflow the buffer
by copying an existing color. However, using strcpy() makes
it harder to audit the code-base for calls that _are_
problems. We should use something like xsnprintf(), which
shows the reader that we expect this never to fail (and
provides a run-time assertion if it does, just in case).

Signed-off-by: Jeff King <peff@peff.net>
---
Another option would just be color_parse(repeated_meta_color, "cyan").
The run-time cost is slightly higher, but it probably doesn't matter
here, and perhaps it's more readable.

This is a repost from:

  https://public-inbox.org/git/20180610204419.GA11273@sigill.intra.peff.net/

which I think just got overlooked as we were in the midst of the 2.18
release cycle.

 builtin/blame.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/builtin/blame.c b/builtin/blame.c
index 5a0388aaef..63bdf755bb 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -1069,7 +1069,9 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 		find_alignment(&sb, &output_option);
 		if (!*repeated_meta_color &&
 		    (output_option & OUTPUT_COLOR_LINE))
-			strcpy(repeated_meta_color, GIT_COLOR_CYAN);
+			xsnprintf(repeated_meta_color,
+				  sizeof(repeated_meta_color),
+				  "%s", GIT_COLOR_CYAN);
 	}
 	if (output_option & OUTPUT_ANNOTATE_COMPAT)
 		output_option &= ~(OUTPUT_COLOR_LINE | OUTPUT_SHOW_AGE_WITH_COLOR);
-- 
2.18.0.433.gb9621797ee
