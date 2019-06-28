Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 817781F461
	for <e@80x24.org>; Fri, 28 Jun 2019 09:42:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726618AbfF1JmO (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Jun 2019 05:42:14 -0400
Received: from cloud.peff.net ([104.130.231.41]:53758 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726561AbfF1JmO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Jun 2019 05:42:14 -0400
Received: (qmail 14495 invoked by uid 109); 28 Jun 2019 09:42:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 28 Jun 2019 09:42:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16183 invoked by uid 111); 28 Jun 2019 09:43:05 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 28 Jun 2019 05:43:05 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 28 Jun 2019 05:42:12 -0400
Date:   Fri, 28 Jun 2019 05:42:12 -0400
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Subject: [PATCH 6/6] t6200: use test_commit_bulk
Message-ID: <20190628094212.GF27329@sigill.intra.peff.net>
References: <20190628093751.GA3569@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190628093751.GA3569@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There's a loop that creates 30 commits using test_commit. Using
test_commit_bulk speeds this up from:

  Benchmark #1: ./t6200-fmt-merge-msg.sh --root=/var/ram/git-tests
    Time (mean ± σ):      1.926 s ±  0.240 s    [User: 1.055 s, System: 0.963 s]
    Range (min … max):    1.431 s …  2.166 s    10 runs

to:

  Benchmark #1: ./t6200-fmt-merge-msg.sh --root=/var/ram/git-tests
    Time (mean ± σ):      1.343 s ±  0.179 s    [User: 766.5 ms, System: 662.9 ms]
    Range (min … max):    1.032 s …  1.664 s    10 runs

for an average savings of over 30%.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t6200-fmt-merge-msg.sh | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/t/t6200-fmt-merge-msg.sh b/t/t6200-fmt-merge-msg.sh
index 93f23cfa82..d4e5af4338 100755
--- a/t/t6200-fmt-merge-msg.sh
+++ b/t/t6200-fmt-merge-msg.sh
@@ -66,12 +66,7 @@ test_expect_success setup '
 	git commit -a -m "Right #5" &&
 
 	git checkout -b long &&
-	i=0 &&
-	while test $i -lt 30
-	do
-		test_commit $i one &&
-		i=$(($i+1))
-	done &&
+	test_commit_bulk --start=0 --message="\$n" --filename=one 30 &&
 
 	git show-branch &&
 
-- 
2.22.0.768.gd89de1e449
