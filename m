Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 011111F462
	for <e@80x24.org>; Thu, 20 Jun 2019 07:41:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730710AbfFTHlo (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Jun 2019 03:41:44 -0400
Received: from cloud.peff.net ([104.130.231.41]:45476 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726732AbfFTHlo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jun 2019 03:41:44 -0400
Received: (qmail 16748 invoked by uid 109); 20 Jun 2019 07:41:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 20 Jun 2019 07:41:43 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13012 invoked by uid 111); 20 Jun 2019 07:42:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 20 Jun 2019 03:42:32 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 20 Jun 2019 03:41:42 -0400
Date:   Thu, 20 Jun 2019 03:41:42 -0400
From:   Jeff King <peff@peff.net>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 15/17] khash: rename oid helper functions
Message-ID: <20190620074141.GO3713@sigill.intra.peff.net>
References: <20190620073952.GA1539@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190620073952.GA1539@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

For use in object_id hash tables, we have oid_hash() and oid_equal().
But these are confusingly similar to the existing oideq() and the
oidhash() we plan to add to replace sha1hash().

The big difference from those functions is that rather than accepting a
const pointer to the "struct object_id", we take the arguments by value
(which is a khash internal convention). So let's make that obvious by
calling them oidhash_by_value() and oideq_by_value().

Those names are fairly horrendous to type, but we rarely need to do so;
they are passed to the khash implementation macro and then only used
internally. Callers get to use the nice kh_put_oid_map(), etc.

Signed-off-by: Jeff King <peff@peff.net>
---
 khash.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/khash.h b/khash.h
index cb2cd3d7e4..f911d2b005 100644
--- a/khash.h
+++ b/khash.h
@@ -324,20 +324,20 @@ static const double __ac_HASH_UPPER = 0.77;
 		code;												\
 	} }
 
-static inline unsigned int oid_hash(struct object_id oid)
+static inline unsigned int oidhash_by_value(struct object_id oid)
 {
 	return sha1hash(oid.hash);
 }
 
-static inline int oid_equal(struct object_id a, struct object_id b)
+static inline int oideq_by_value(struct object_id a, struct object_id b)
 {
 	return oideq(&a, &b);
 }
 
-KHASH_INIT(oid_set, struct object_id, int, 0, oid_hash, oid_equal)
+KHASH_INIT(oid_set, struct object_id, int, 0, oidhash_by_value, oideq_by_value)
 
-KHASH_INIT(oid_map, struct object_id, void *, 1, oid_hash, oid_equal)
+KHASH_INIT(oid_map, struct object_id, void *, 1, oidhash_by_value, oideq_by_value)
 
-KHASH_INIT(oid_pos, struct object_id, int, 1, oid_hash, oid_equal)
+KHASH_INIT(oid_pos, struct object_id, int, 1, oidhash_by_value, oideq_by_value)
 
 #endif /* __AC_KHASH_H */
-- 
2.22.0.732.g5402924b4b

