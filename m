Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 85DE81F404
	for <e@80x24.org>; Wed, 14 Feb 2018 18:06:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1161604AbeBNSGh (ORCPT <rfc822;e@80x24.org>);
        Wed, 14 Feb 2018 13:06:37 -0500
Received: from cloud.peff.net ([104.130.231.41]:52266 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1161595AbeBNSGg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Feb 2018 13:06:36 -0500
Received: (qmail 29273 invoked by uid 109); 14 Feb 2018 18:06:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 14 Feb 2018 18:06:36 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30997 invoked by uid 111); 14 Feb 2018 18:07:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Wed, 14 Feb 2018 13:07:21 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 14 Feb 2018 13:06:34 -0500
Date:   Wed, 14 Feb 2018 13:06:34 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 2/6] test-hashmap: check allocation computation for overflow
Message-ID: <20180214180634.GB9919@sigill.intra.peff.net>
References: <20180214180322.GA9190@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180214180322.GA9190@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When we allocate the test_entry flex-struct, we have to add
up all of the elements that go into the flex array. If these
were to overflow a size_t, this would allocate a too-small
buffer, which we would then overflow in our memcpy steps.

Since this is just a test-helper, it probably doesn't matter
in practice, but we should model the correct technique by
using the st_add() macros.

Unfortunately, we cannot use the FLEX_ALLOC() macros here,
because we are stuffing two different buffers into a single
flex array.

While we're here, let's also swap out "malloc" for our
error-checking "xmalloc", and use the preferred
"sizeof(*var)" instead of "sizeof(type)".

Signed-off-by: Jeff King <peff@peff.net>
---
 t/helper/test-hashmap.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/t/helper/test-hashmap.c b/t/helper/test-hashmap.c
index b36886bf35..2100877c2b 100644
--- a/t/helper/test-hashmap.c
+++ b/t/helper/test-hashmap.c
@@ -32,8 +32,7 @@ static int test_entry_cmp(const void *cmp_data,
 static struct test_entry *alloc_test_entry(int hash, char *key, int klen,
 		char *value, int vlen)
 {
-	struct test_entry *entry = malloc(sizeof(struct test_entry) + klen
-			+ vlen + 2);
+	struct test_entry *entry = xmalloc(st_add4(sizeof(*entry), klen, vlen, 2));
 	hashmap_entry_init(entry, hash);
 	memcpy(entry->key, key, klen + 1);
 	memcpy(entry->key + klen + 1, value, vlen + 1);
-- 
2.16.1.464.gc4bae515b7

