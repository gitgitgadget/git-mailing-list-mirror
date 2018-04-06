Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 754C01F404
	for <e@80x24.org>; Fri,  6 Apr 2018 18:59:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751418AbeDFS72 (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Apr 2018 14:59:28 -0400
Received: from cloud.peff.net ([104.130.231.41]:56174 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1750815AbeDFS72 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Apr 2018 14:59:28 -0400
Received: (qmail 23550 invoked by uid 109); 6 Apr 2018 18:59:28 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 06 Apr 2018 18:59:28 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28086 invoked by uid 111); 6 Apr 2018 19:00:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 06 Apr 2018 15:00:29 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 06 Apr 2018 14:59:26 -0400
Date:   Fri, 6 Apr 2018 14:59:26 -0400
From:   Jeff King <peff@peff.net>
To:     Harald Nordgren <haraldnordgren@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 2/3] ref-filter: make ref_array_item allocation more
 consistent
Message-ID: <20180406185925.GB11108@sigill.intra.peff.net>
References: <20180406185801.GA921@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180406185801.GA921@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We have a helper function to allocate ref_array_item
structs, but it only takes a subset of the possible fields
in the struct as initializers. We could have it accept an
argument for _every_ field, but that becomes a pain for the
fields which some callers don't want to set initially.

Instead, let's be explicit that it takes only the minimum
required to create the ref, and that callers should then
fill in the rest themselves.

Signed-off-by: Jeff King <peff@peff.net>
---
Technically we don't need the oid to create the struct, just the name,
but I figured that every caller is going to have to have some oid.

 ref-filter.c | 18 +++++++++++-------
 1 file changed, 11 insertions(+), 7 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index ade97a8486..c1c3cc9480 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1824,15 +1824,18 @@ static const struct object_id *match_points_at(struct oid_array *points_at,
 	return NULL;
 }
 
-/* Allocate space for a new ref_array_item and copy the objectname and flag to it */
+/*
+ * Allocate space for a new ref_array_item and copy the name and oid to it.
+ *
+ * Callers can then fill in other struct members at their leisure.
+ */
 static struct ref_array_item *new_ref_array_item(const char *refname,
-						 const struct object_id *oid,
-						 int flag)
+						 const struct object_id *oid)
 {
 	struct ref_array_item *ref;
+
 	FLEX_ALLOC_STR(ref, refname, refname);
 	oidcpy(&ref->objectname, oid);
-	ref->flag = flag;
 
 	return ref;
 }
@@ -1927,12 +1930,13 @@ static int ref_filter_handler(const char *refname, const struct object_id *oid,
 	 * to do its job and the resulting list may yet to be pruned
 	 * by maxcount logic.
 	 */
-	ref = new_ref_array_item(refname, oid, flag);
+	ref = new_ref_array_item(refname, oid);
 	ref->commit = commit;
+	ref->flag = flag;
+	ref->kind = kind;
 
 	REALLOC_ARRAY(ref_cbdata->array->items, ref_cbdata->array->nr + 1);
 	ref_cbdata->array->items[ref_cbdata->array->nr++] = ref;
-	ref->kind = kind;
 	return 0;
 }
 
@@ -2169,7 +2173,7 @@ void pretty_print_ref(const char *name, const struct object_id *oid,
 		      const struct ref_format *format)
 {
 	struct ref_array_item *ref_item;
-	ref_item = new_ref_array_item(name, oid, 0);
+	ref_item = new_ref_array_item(name, oid);
 	ref_item->kind = ref_kind_from_refname(name);
 	show_ref_array_item(ref_item, format);
 	free_array_item(ref_item);
-- 
2.17.0.686.g08b0810b04

