Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 516C61F461
	for <e@80x24.org>; Fri, 19 Jul 2019 21:56:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728425AbfGSV4Z (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Jul 2019 17:56:25 -0400
Received: from cloud.peff.net ([104.130.231.41]:40700 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727344AbfGSV4Z (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Jul 2019 17:56:25 -0400
Received: (qmail 8731 invoked by uid 109); 19 Jul 2019 21:56:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 19 Jul 2019 21:56:25 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29239 invoked by uid 111); 19 Jul 2019 21:57:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 19 Jul 2019 17:57:22 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 19 Jul 2019 17:56:23 -0400
Date:   Fri, 19 Jul 2019 17:56:23 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: [PATCH v3 6/6] t6200: use test_commit_bulk
Message-ID: <20190719215623.GF32188@sigill.intra.peff.net>
References: <20190719215417.GA31841@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190719215417.GA31841@sigill.intra.peff.net>
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
index 93f23cfa82..8a72b4c43a 100755
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
+	test_commit_bulk --start=0 --message=%s --filename=one 30 &&
 
 	git show-branch &&
 
-- 
2.22.0.993.gcc1030c86b
