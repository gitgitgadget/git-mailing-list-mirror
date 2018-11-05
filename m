Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 225F51F453
	for <e@80x24.org>; Mon,  5 Nov 2018 06:44:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729171AbeKEQCI (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Nov 2018 11:02:08 -0500
Received: from cloud.peff.net ([104.130.231.41]:40414 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728955AbeKEQCI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Nov 2018 11:02:08 -0500
Received: (qmail 21950 invoked by uid 109); 5 Nov 2018 06:44:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 05 Nov 2018 06:44:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17244 invoked by uid 111); 5 Nov 2018 06:43:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 05 Nov 2018 01:43:18 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 05 Nov 2018 01:43:59 -0500
Date:   Mon, 5 Nov 2018 01:43:59 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 11/13] apply: return -1 from option callback instead of
 calling exit(1)
Message-ID: <20181105064358.GK25864@sigill.intra.peff.net>
References: <20181105063718.GA24877@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181105063718.GA24877@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The option callback for "apply --whitespace" exits with status "1" on
error. It makes more sense for it to just return an error to
parse-options. That code will exit, too, but it will use status "129"
that is customary for option errors.

The exit() dates back to aaf6c447aa (builtin/apply: make
parse_whitespace_option() return -1 instead of die()ing, 2016-08-08).
That commit gives no reason why we'd prefer the current exit status (it
looks like it was just bumping the "die" up a level in the callstack,
but did not go as far as it could have).

Signed-off-by: Jeff King <peff@peff.net>
---
 apply.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/apply.c b/apply.c
index d1ca6addeb..c4c9f849b1 100644
--- a/apply.c
+++ b/apply.c
@@ -4812,7 +4812,7 @@ static int apply_option_parse_whitespace(const struct option *opt,
 	struct apply_state *state = opt->value;
 	state->whitespace_option = arg;
 	if (parse_whitespace_option(state, arg))
-		exit(1);
+		return -1;
 	return 0;
 }
 
-- 
2.19.1.1505.g9cd28186cf

