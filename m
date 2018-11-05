Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3FFED1F453
	for <e@80x24.org>; Mon,  5 Nov 2018 06:38:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729398AbeKEP42 (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Nov 2018 10:56:28 -0500
Received: from cloud.peff.net ([104.130.231.41]:40354 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1729182AbeKEP42 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Nov 2018 10:56:28 -0500
Received: (qmail 21516 invoked by uid 109); 5 Nov 2018 06:38:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 05 Nov 2018 06:38:21 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17078 invoked by uid 111); 5 Nov 2018 06:37:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 05 Nov 2018 01:37:39 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 05 Nov 2018 01:38:19 -0500
Date:   Mon, 5 Nov 2018 01:38:19 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 01/13] apply: mark include/exclude options as NONEG
Message-ID: <20181105063819.GA25864@sigill.intra.peff.net>
References: <20181105063718.GA24877@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20181105063718.GA24877@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The options callback for "git apply --no-include" is not ready to handle
the "unset" parameter, and as a result will segfault when it adds a NULL
argument to the include list (likewise for "--no-exclude").

In theory this might be used to clear the list, but since both
"--include" and "--exclude" add to the same list, it's not immediately
obvious what the semantics should be. Let's punt on that for now and
just disallow the broken options.

Signed-off-by: Jeff King <peff@peff.net>
---
 apply.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/apply.c b/apply.c
index 073d5f0451..d1ca6addeb 100644
--- a/apply.c
+++ b/apply.c
@@ -4939,10 +4939,10 @@ int apply_parse_options(int argc, const char **argv,
 	struct option builtin_apply_options[] = {
 		{ OPTION_CALLBACK, 0, "exclude", state, N_("path"),
 			N_("don't apply changes matching the given path"),
-			0, apply_option_parse_exclude },
+			PARSE_OPT_NONEG, apply_option_parse_exclude },
 		{ OPTION_CALLBACK, 0, "include", state, N_("path"),
 			N_("apply changes matching the given path"),
-			0, apply_option_parse_include },
+			PARSE_OPT_NONEG, apply_option_parse_include },
 		{ OPTION_CALLBACK, 'p', NULL, state, N_("num"),
 			N_("remove <num> leading slashes from traditional diff paths"),
 			0, apply_option_parse_p },
-- 
2.19.1.1505.g9cd28186cf

