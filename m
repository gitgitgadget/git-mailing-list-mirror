Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id ABF5C1F462
	for <e@80x24.org>; Thu, 20 Jun 2019 07:41:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730586AbfFTHla (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Jun 2019 03:41:30 -0400
Received: from cloud.peff.net ([104.130.231.41]:45392 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726732AbfFTHla (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jun 2019 03:41:30 -0400
Received: (qmail 16646 invoked by uid 109); 20 Jun 2019 07:41:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 20 Jun 2019 07:41:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12898 invoked by uid 111); 20 Jun 2019 07:42:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 20 Jun 2019 03:42:19 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 20 Jun 2019 03:41:28 -0400
Date:   Thu, 20 Jun 2019 03:41:28 -0400
From:   Jeff King <peff@peff.net>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 11/17] khash: rename kh_oid_t to kh_oid_set
Message-ID: <20190620074128.GK3713@sigill.intra.peff.net>
References: <20190620073952.GA1539@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190620073952.GA1539@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

khash lets us define a hash as either a map or a set (i.e., with no
"value" type). For the oid maps we define, "oid" is the set and
"oid_map" is the map. As the bug in the previous commit shows, it's easy
to pick the wrong one.

So let's make the names more distinct: "oid_set" and "oid_map".

An alternative naming scheme would be to actually name the type after
the key/value types. So e.g., "oid" _would_ be the set, since it has no
value type. And "oid_map" would become "oid_void" or similar (and
"oid_pos" becomes "oid_int"). That's better in some ways: it's more
regular, and a given map type can be more reasily reused in multiple
contexts (e.g., something storing an "int" that isn't a "pos"). But it's
also slightly less descriptive.

Signed-off-by: Jeff King <peff@peff.net>
---
 khash.h  |  2 +-
 oidset.c | 12 ++++++------
 oidset.h |  4 ++--
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/khash.h b/khash.h
index 64d4eeb2bd..ae9f78347f 100644
--- a/khash.h
+++ b/khash.h
@@ -342,7 +342,7 @@ static inline int oid_equal(struct object_id a, struct object_id b)
 	return oideq(&a, &b);
 }
 
-KHASH_INIT(oid, struct object_id, int, 0, oid_hash, oid_equal)
+KHASH_INIT(oid_set, struct object_id, int, 0, oid_hash, oid_equal)
 
 KHASH_INIT(oid_map, struct object_id, void *, 1, oid_hash, oid_equal)
 
diff --git a/oidset.c b/oidset.c
index fe4eb921df..8bdecb13de 100644
--- a/oidset.c
+++ b/oidset.c
@@ -5,33 +5,33 @@ void oidset_init(struct oidset *set, size_t initial_size)
 {
 	memset(&set->set, 0, sizeof(set->set));
 	if (initial_size)
-		kh_resize_oid(&set->set, initial_size);
+		kh_resize_oid_set(&set->set, initial_size);
 }
 
 int oidset_contains(const struct oidset *set, const struct object_id *oid)
 {
-	khiter_t pos = kh_get_oid(&set->set, *oid);
+	khiter_t pos = kh_get_oid_set(&set->set, *oid);
 	return pos != kh_end(&set->set);
 }
 
 int oidset_insert(struct oidset *set, const struct object_id *oid)
 {
 	int added;
-	kh_put_oid(&set->set, *oid, &added);
+	kh_put_oid_set(&set->set, *oid, &added);
 	return !added;
 }
 
 int oidset_remove(struct oidset *set, const struct object_id *oid)
 {
-	khiter_t pos = kh_get_oid(&set->set, *oid);
+	khiter_t pos = kh_get_oid_set(&set->set, *oid);
 	if (pos == kh_end(&set->set))
 		return 0;
-	kh_del_oid(&set->set, pos);
+	kh_del_oid_set(&set->set, pos);
 	return 1;
 }
 
 void oidset_clear(struct oidset *set)
 {
-	kh_release_oid(&set->set);
+	kh_release_oid_set(&set->set);
 	oidset_init(set, 0);
 }
diff --git a/oidset.h b/oidset.h
index 14f18f791f..505fad578b 100644
--- a/oidset.h
+++ b/oidset.h
@@ -20,7 +20,7 @@
  * A single oidset; should be zero-initialized (or use OIDSET_INIT).
  */
 struct oidset {
-	kh_oid_t set;
+	kh_oid_set_t set;
 };
 
 #define OIDSET_INIT { { 0 } }
@@ -62,7 +62,7 @@ int oidset_remove(struct oidset *set, const struct object_id *oid);
 void oidset_clear(struct oidset *set);
 
 struct oidset_iter {
-	kh_oid_t *set;
+	kh_oid_set_t *set;
 	khiter_t iter;
 };
 
-- 
2.22.0.732.g5402924b4b

