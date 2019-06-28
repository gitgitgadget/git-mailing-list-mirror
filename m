Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9BCD21F461
	for <e@80x24.org>; Fri, 28 Jun 2019 06:41:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727217AbfF1GlF (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Jun 2019 02:41:05 -0400
Received: from cloud.peff.net ([104.130.231.41]:53602 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727148AbfF1GlF (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Jun 2019 02:41:05 -0400
Received: (qmail 13704 invoked by uid 109); 28 Jun 2019 06:41:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 28 Jun 2019 06:41:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15043 invoked by uid 111); 28 Jun 2019 06:41:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 28 Jun 2019 02:41:56 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 28 Jun 2019 02:41:03 -0400
Date:   Fri, 28 Jun 2019 02:41:03 -0400
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Git List <git@vger.kernel.org>,
        Christian Couder <christian.couder@gmail.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: Re: Git Test Coverage Report (Thurs. June 27)
Message-ID: <20190628064103.GA19777@sigill.intra.peff.net>
References: <49d98293-9f0b-44e9-cb07-d6b7ac791eb6@gmail.com>
 <14689d27-eecd-2e0a-715d-796b20d573e5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <14689d27-eecd-2e0a-715d-796b20d573e5@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 27, 2019 at 01:35:17PM -0400, Derrick Stolee wrote:

> > pack-bitmap-write.c
> > 05805d74 378) static struct ewah_bitmap *find_reused_bitmap(const struct object_id *oid)
> > d2bc62b1 385) hash_pos = kh_get_oid_map(writer.reused, *oid);
> > 05805d74 425) reused_bitmap = find_reused_bitmap(&chosen->object.oid);
> > 05805d74 432) reused_bitmap = find_reused_bitmap(&cm->object.oid);
> 
> Peff: it is interesting that these portions are not covered previously. (Your change
> is clearly mechanical and does not change the correctness.) In particular, lines 425
> and 432 are in two blocks of an if/else with one further inside a loop. The loop
> should always have at least one run, so this if/else isn't even covered.

One of 425 or 432 must run if we enter that "for(;;)" loop (in the
latter case, "next" is non-zero, so we enter the inner loop at least
once).

I think that the whole loop starting at line 409 is not exercised by the
test suite, because we hit the early return above it when there are
fewer than 100 commits to index.

I think this would exercise it, at the cost of making the test more
expensive:

diff --git a/t/t5310-pack-bitmaps.sh b/t/t5310-pack-bitmaps.sh
index 82d7f7f6a5..8ed6982dcb 100755
--- a/t/t5310-pack-bitmaps.sh
+++ b/t/t5310-pack-bitmaps.sh
@@ -21,7 +21,7 @@ has_any () {
 }
 
 test_expect_success 'setup repo with moderate-sized history' '
-	for i in $(test_seq 1 10)
+	for i in $(test_seq 1 100)
 	do
 		test_commit $i
 	done &&

It would be nice if we had a "test_commits_bulk" that used fast-import
to create larger numbers of commits.

-Peff
