Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A244C1F461
	for <e@80x24.org>; Fri, 19 Jul 2019 21:56:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728283AbfGSV4S (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Jul 2019 17:56:18 -0400
Received: from cloud.peff.net ([104.130.231.41]:40684 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727344AbfGSV4S (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Jul 2019 17:56:18 -0400
Received: (qmail 8712 invoked by uid 109); 19 Jul 2019 21:56:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 19 Jul 2019 21:56:18 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29207 invoked by uid 111); 19 Jul 2019 21:57:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 19 Jul 2019 17:57:16 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 19 Jul 2019 17:56:16 -0400
Date:   Fri, 19 Jul 2019 17:56:16 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: [PATCH v3 4/6] t5702: use test_commit_bulk
Message-ID: <20190719215616.GD32188@sigill.intra.peff.net>
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

There are two loops that create 32 commits each using test_commit. Using
test_commit_bulk speeds this up from:

  Benchmark #1: ./t5702-protocol-v2.sh --root=/var/ram/git-tests
    Time (mean ± σ):      5.409 s ±  0.513 s    [User: 2.382 s, System: 2.466 s]
    Range (min … max):    4.633 s …  5.927 s    10 runs

to:

  Benchmark #1: ./t5702-protocol-v2.sh --root=/var/ram/git-tests
    Time (mean ± σ):      3.956 s ±  0.242 s    [User: 1.775 s, System: 1.627 s]
    Range (min … max):    3.449 s …  4.239 s    10 runs

for an average savings of over 25%.

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t5702-protocol-v2.sh | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/t/t5702-protocol-v2.sh b/t/t5702-protocol-v2.sh
index 5b33f625dd..011b81d4fc 100755
--- a/t/t5702-protocol-v2.sh
+++ b/t/t5702-protocol-v2.sh
@@ -499,10 +499,7 @@ test_expect_success 'upload-pack respects client shallows' '
 
 	# Add extra commits to the client so that the whole fetch takes more
 	# than 1 request (due to negotiation)
-	for i in $(test_seq 1 32)
-	do
-		test_commit -C client c$i
-	done &&
+	test_commit_bulk -C client --id=c 32 &&
 
 	git -C server checkout -b newbranch base &&
 	test_commit -C server client_wants &&
@@ -711,10 +708,7 @@ test_expect_success 'when server does not send "ready", expect FLUSH' '
 	# Create many commits to extend the negotiation phase across multiple
 	# requests, so that the server does not send "ready" in the first
 	# request.
-	for i in $(test_seq 1 32)
-	do
-		test_commit -C http_child c$i
-	done &&
+	test_commit_bulk -C http_child --id=c 32 &&
 
 	# After the acknowledgments section, pretend that a DELIM
 	# (0001) was sent instead of a FLUSH (0000).
-- 
2.22.0.993.gcc1030c86b

