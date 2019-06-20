Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 50A641F9F7
	for <e@80x24.org>; Thu, 20 Jun 2019 07:41:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbfFTHlJ (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Jun 2019 03:41:09 -0400
Received: from cloud.peff.net ([104.130.231.41]:45282 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725872AbfFTHlJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jun 2019 03:41:09 -0400
Received: (qmail 16501 invoked by uid 109); 20 Jun 2019 07:41:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 20 Jun 2019 07:41:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12763 invoked by uid 111); 20 Jun 2019 07:41:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 20 Jun 2019 03:41:58 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 20 Jun 2019 03:41:07 -0400
Date:   Thu, 20 Jun 2019 03:41:07 -0400
From:   Jeff King <peff@peff.net>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH 05/17] pack-objects: convert locate_object_entry_hash() to
 object_id
Message-ID: <20190620074106.GE3713@sigill.intra.peff.net>
References: <20190620073952.GA1539@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190620073952.GA1539@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There are no callers of locate_object_entry_hash() that aren't just
passing us the "hash" member of a "struct object_id". Let's take the
whole struct, which gets us closer to removing all raw sha1 variables.

Signed-off-by: Jeff King <peff@peff.net>
---
 pack-objects.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/pack-objects.c b/pack-objects.c
index 49fdf52ea6..00a5f6e0ec 100644
--- a/pack-objects.c
+++ b/pack-objects.c
@@ -6,17 +6,17 @@
 #include "config.h"
 
 static uint32_t locate_object_entry_hash(struct packing_data *pdata,
-					 const unsigned char *sha1,
+					 const struct object_id *oid,
 					 int *found)
 {
 	uint32_t i, mask = (pdata->index_size - 1);
 
-	i = sha1hash(sha1) & mask;
+	i = sha1hash(oid->hash) & mask;
 
 	while (pdata->index[i] > 0) {
 		uint32_t pos = pdata->index[i] - 1;
 
-		if (hasheq(sha1, pdata->objects[pos].idx.oid.hash)) {
+		if (oideq(oid, &pdata->objects[pos].idx.oid)) {
 			*found = 1;
 			return i;
 		}
@@ -56,7 +56,7 @@ static void rehash_objects(struct packing_data *pdata)
 	for (i = 0; i < pdata->nr_objects; i++) {
 		int found;
 		uint32_t ix = locate_object_entry_hash(pdata,
-						       entry->idx.oid.hash,
+						       &entry->idx.oid,
 						       &found);
 
 		if (found)
@@ -77,7 +77,7 @@ struct object_entry *packlist_find(struct packing_data *pdata,
 	if (!pdata->index_size)
 		return NULL;
 
-	i = locate_object_entry_hash(pdata, oid->hash, &found);
+	i = locate_object_entry_hash(pdata, oid, &found);
 
 	if (index_pos)
 		*index_pos = i;
-- 
2.22.0.732.g5402924b4b

