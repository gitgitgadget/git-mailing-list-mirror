Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9734C1F404
	for <e@80x24.org>; Wed, 14 Feb 2018 18:05:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161584AbeBNSFs (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Feb 2018 13:05:48 -0500
Received: from cloud.peff.net ([104.130.231.41]:52258 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1161541AbeBNSFs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Feb 2018 13:05:48 -0500
Received: (qmail 29213 invoked by uid 109); 14 Feb 2018 18:05:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 14 Feb 2018 18:05:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30972 invoked by uid 111); 14 Feb 2018 18:06:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 14 Feb 2018 13:06:32 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 14 Feb 2018 13:05:46 -0500
Date:   Wed, 14 Feb 2018 13:05:46 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Code AI <techsupport@mycode.ai>
Subject: [PATCH 1/6] test-hashmap: use ALLOC_ARRAY rather than bare malloc
Message-ID: <20180214180545.GA9919@sigill.intra.peff.net>
References: <20180214180322.GA9190@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180214180322.GA9190@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

These two array allocations have several minor flaws:

  - they use bare malloc, rather than our error-checking
    xmalloc

  - they do a bare multiplication to determine the total
    size (which in theory can overflow, though in this case
    the sizes are all constants)

  - they use sizeof(type), but the type in the second one
    doesn't match the actual array (though it's "int" versus
    "unsigned int", which are guaranteed by C99 to have the
    same size)

None of these are likely to be problems in practice, and
this is just a test helper. But since people often look at
test helpers as reference code, we should do our best to
model the recommended techniques.

Switching to ALLOC_ARRAY fixes all three.

Signed-off-by: Jeff King <peff@peff.net>
---
The sizeof() thing came from Code AI's original email. I'm happy to
include a Reported-by there, but I wasn't sure of the correct entity to
credit. :)

 t/helper/test-hashmap.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/helper/test-hashmap.c b/t/helper/test-hashmap.c
index 1145d51671..b36886bf35 100644
--- a/t/helper/test-hashmap.c
+++ b/t/helper/test-hashmap.c
@@ -85,8 +85,8 @@ static void perf_hashmap(unsigned int method, unsigned int rounds)
 	unsigned int *hashes;
 	unsigned int i, j;
 
-	entries = malloc(TEST_SIZE * sizeof(struct test_entry *));
-	hashes = malloc(TEST_SIZE * sizeof(int));
+	ALLOC_ARRAY(entries, TEST_SIZE);
+	ALLOC_ARRAY(hashes, TEST_SIZE);
 	for (i = 0; i < TEST_SIZE; i++) {
 		snprintf(buf, sizeof(buf), "%i", i);
 		entries[i] = alloc_test_entry(0, buf, strlen(buf), "", 0);
-- 
2.16.1.464.gc4bae515b7

