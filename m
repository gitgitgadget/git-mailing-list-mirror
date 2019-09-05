Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 38A601F461
	for <e@80x24.org>; Thu,  5 Sep 2019 22:53:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731109AbfIEWxi (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Sep 2019 18:53:38 -0400
Received: from cloud.peff.net ([104.130.231.41]:41456 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726837AbfIEWxi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Sep 2019 18:53:38 -0400
Received: (qmail 10388 invoked by uid 109); 5 Sep 2019 22:53:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 05 Sep 2019 22:53:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32533 invoked by uid 111); 5 Sep 2019 22:55:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 05 Sep 2019 18:55:21 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 5 Sep 2019 18:53:37 -0400
From:   Jeff King <peff@peff.net>
To:     Stephan Beyer <s-beyer@gmx.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Paul Tan <pyokagan@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Subject: [PATCH 4/6] diff-delta: set size out-parameter to 0 for NULL delta
Message-ID: <20190905225336.GD25657@sigill.intra.peff.net>
References: <20190905224859.GA28660@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190905224859.GA28660@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When we cannot generate a delta, we return NULL but leave delta_size
untouched. This is generally OK, as callers rely on NULL to decide if
the output is usable or not. But it can confuse compilers; in
particular, gcc 9.2.1 with "-flto -O3" complains in fast-import's
store_object() that delta_len may be used uninitialized.

Let's change the diff-delta code to set the size explicitly to 0 for a
NULL return. That silences the compiler and makes it easier to reason
about the result.

Reported-by: Stephan Beyer <s-beyer@gmx.net>
Helped-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Jeff King <peff@peff.net>
---
I suspect this same pattern of "if we return error, out-parameters are
undefined" is used in a lot of other functions, too. And I wouldn't
necessarily want to go around changing all of them. But the fact that
this tickles the compiler makes me think it's worthwhile.

 diff-delta.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/diff-delta.c b/diff-delta.c
index e49643353b..77fea08dfb 100644
--- a/diff-delta.c
+++ b/diff-delta.c
@@ -326,6 +326,8 @@ create_delta(const struct delta_index *index,
 	const unsigned char *ref_data, *ref_top, *data, *top;
 	unsigned char *out;
 
+	*delta_size = 0;
+
 	if (!trg_buf || !trg_size)
 		return NULL;
 
-- 
2.23.0.463.g883b23b1c5

