Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8FC5720987
	for <e@80x24.org>; Mon,  3 Oct 2016 20:34:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752758AbcJCUeR (ORCPT <rfc822;e@80x24.org>);
        Mon, 3 Oct 2016 16:34:17 -0400
Received: from cloud.peff.net ([104.130.231.41]:51427 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752676AbcJCUeP (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Oct 2016 16:34:15 -0400
Received: (qmail 17227 invoked by uid 109); 3 Oct 2016 20:34:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 03 Oct 2016 20:34:15 +0000
Received: (qmail 29696 invoked by uid 111); 3 Oct 2016 20:34:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 03 Oct 2016 16:34:31 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 03 Oct 2016 16:34:12 -0400
Date:   Mon, 3 Oct 2016 16:34:12 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: [PATCH 06/18] t5613: clarify "too deep" recursion tests
Message-ID: <20161003203412.bekizvlqtg4ls5fb@sigill.intra.peff.net>
References: <20161003203321.rj5jepviwo57uhqw@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161003203321.rj5jepviwo57uhqw@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These tests are just trying to show that we allow recursion
up to a certain depth, but not past it. But the counting is
a bit non-intuitive, and rather than test at the edge of the
breakage, we test "OK" cases in the middle of the chain.
Let's explain what's going on, and explicitly test the
switch between "OK" and "too deep".

Signed-off-by: Jeff King <peff@peff.net>
---
 t/t5613-info-alternate.sh | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/t/t5613-info-alternate.sh b/t/t5613-info-alternate.sh
index 7bc1c3c..b393613 100755
--- a/t/t5613-info-alternate.sh
+++ b/t/t5613-info-alternate.sh
@@ -39,6 +39,18 @@ test_expect_success 'preparing third repository' '
 	)
 '
 
+# Note: These tests depend on the hard-coded value of 5 as "too deep". We start
+# the depth at 0 and count links, not repositories, so in a chain like:
+#
+#   A -> B -> C -> D -> E -> F -> G -> H
+#      0    1    2    3    4    5    6
+#
+# we are OK at "G", but break at "H".
+#
+# Note also that we must use "--bare -l" to make the link to H. The "-l"
+# ensures we do not do a connectivity check, and the "--bare" makes sure
+# we do not try to checkout the result (which needs objects), either of
+# which would cause the clone to fail.
 test_expect_success 'creating too deep nesting' '
 	git clone -l -s C D &&
 	git clone -l -s D E &&
@@ -47,16 +59,12 @@ test_expect_success 'creating too deep nesting' '
 	git clone --bare -l -s G H
 '
 
-test_expect_success 'invalidity of deepest repository' '
-	test_must_fail git -C H fsck
-'
-
-test_expect_success 'validity of third repository' '
-	git -C C fsck
+test_expect_success 'validity of fifth-deep repository' '
+	git -C G fsck
 '
 
-test_expect_success 'validity of fourth repository' '
-	git -C D fsck
+test_expect_success 'invalidity of sixth-deep repository' '
+	test_must_fail git -C H fsck
 '
 
 test_expect_success 'breaking of loops' '
-- 
2.10.0.618.g82cc264

