Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D8A4A1F462
	for <e@80x24.org>; Thu, 20 Jun 2019 07:40:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726351AbfFTHkx (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Jun 2019 03:40:53 -0400
Received: from cloud.peff.net ([104.130.231.41]:45220 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725872AbfFTHkw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jun 2019 03:40:52 -0400
Received: (qmail 16413 invoked by uid 109); 20 Jun 2019 07:40:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 20 Jun 2019 07:40:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12688 invoked by uid 111); 20 Jun 2019 07:41:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 20 Jun 2019 03:41:41 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 20 Jun 2019 03:40:50 -0400
Date:   Thu, 20 Jun 2019 03:40:50 -0400
From:   Jeff King <peff@peff.net>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 01/17] describe: fix accidental oid/hash type-punning
Message-ID: <20190620074050.GA3713@sigill.intra.peff.net>
References: <20190620073952.GA1539@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190620073952.GA1539@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The find_commit_name() function passes an object_id.hash as the key of a
hashmap. That ends up in commit_name_neq(), which then feeds it to
oideq(). Which means we should actually be the whole "struct object_id".

It works anyway because pointers to the two are interchangeable. And
because we're going through a layer of void pointers, the compiler
doesn't notice the type mismatch.

But it's worth cleaning up (especially since once we switch away from
sha1hash() on the same line, accessing the hash member will look doubly
out of place).

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/describe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/describe.c b/builtin/describe.c
index 1409cedce2..0a5cde00a2 100644
--- a/builtin/describe.c
+++ b/builtin/describe.c
@@ -76,7 +76,7 @@ static int commit_name_neq(const void *unused_cmp_data,
 
 static inline struct commit_name *find_commit_name(const struct object_id *peeled)
 {
-	return hashmap_get_from_hash(&names, sha1hash(peeled->hash), peeled->hash);
+	return hashmap_get_from_hash(&names, sha1hash(peeled->hash), peeled);
 }
 
 static int replace_name(struct commit_name *e,
-- 
2.22.0.732.g5402924b4b

