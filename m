Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D63781F51C
	for <e@80x24.org>; Sat, 19 May 2018 01:58:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752060AbeESB6X (ORCPT <rfc822;e@80x24.org>);
        Fri, 18 May 2018 21:58:23 -0400
Received: from cloud.peff.net ([104.130.231.41]:46186 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750957AbeESB6X (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 May 2018 21:58:23 -0400
Received: (qmail 9303 invoked by uid 109); 19 May 2018 01:58:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sat, 19 May 2018 01:58:23 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15906 invoked by uid 111); 19 May 2018 01:58:30 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 18 May 2018 21:58:30 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 18 May 2018 18:58:20 -0700
Date:   Fri, 18 May 2018 18:58:20 -0700
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 4/5] shorten_unambiguous_ref: use xsnprintf
Message-ID: <20180519015819.GD32492@sigill.intra.peff.net>
References: <20180519015444.GA12080@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180519015444.GA12080@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We convert the ref_rev_parse_rules array into scanf formats
on the fly, and use snprintf() to write into each string. We
should have enough memory to hold everything because of the
earlier total_len computation. Let's use xsnprintf() to
give runtime confirmation that this is the case, and to make
it easy for people auditing the code to know there's no
truncation bug.

Signed-off-by: Jeff King <peff@peff.net>
---
 refs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/refs.c b/refs.c
index 64aadd14c9..73c446628f 100644
--- a/refs.c
+++ b/refs.c
@@ -1147,8 +1147,8 @@ char *shorten_unambiguous_ref(const char *refname, int strict)
 		for (i = 0; i < nr_rules; i++) {
 			assert(offset < total_len);
 			scanf_fmts[i] = (char *)&scanf_fmts[nr_rules] + offset;
-			offset += snprintf(scanf_fmts[i], total_len - offset,
-					   ref_rev_parse_rules[i], 2, "%s") + 1;
+			offset += xsnprintf(scanf_fmts[i], total_len - offset,
+					    ref_rev_parse_rules[i], 2, "%s") + 1;
 		}
 	}
 
-- 
2.17.0.1052.g7d69f75dbf

