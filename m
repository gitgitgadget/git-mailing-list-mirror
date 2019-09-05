Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7E22D1F461
	for <e@80x24.org>; Thu,  5 Sep 2019 22:52:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730065AbfIEWw0 (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Sep 2019 18:52:26 -0400
Received: from cloud.peff.net ([104.130.231.41]:41414 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727115AbfIEWw0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Sep 2019 18:52:26 -0400
Received: (qmail 10330 invoked by uid 109); 5 Sep 2019 22:52:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 05 Sep 2019 22:52:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32447 invoked by uid 111); 5 Sep 2019 22:54:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 05 Sep 2019 18:54:09 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 5 Sep 2019 18:52:25 -0400
From:   Jeff King <peff@peff.net>
To:     Stephan Beyer <s-beyer@gmx.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Paul Tan <pyokagan@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Subject: [PATCH 2/6] pack-objects: use object_id in packlist_alloc()
Message-ID: <20190905225224.GB25657@sigill.intra.peff.net>
References: <20190905224859.GA28660@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190905224859.GA28660@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The only caller of packlist_alloc() already has a "struct object_id",
and we immediately copy the hash they pass us into our own object_id.
Let's avoid the unnecessary round-trip to a raw sha1 pointer.

Signed-off-by: Jeff King <peff@peff.net>
---
Just noticed since I was touching that function.

This is the second-to-last raw sha1 in pack-objects.c. The final one is
slightly tricky to get rid of, because it comes from the raw base_ref
pointer we parse out of the packfile's mmap. I left it out of this
series, but I wouldn't mind if somebody wants to take a stab at it.

 builtin/pack-objects.c | 2 +-
 pack-objects.c         | 4 ++--
 pack-objects.h         | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 76ce906946..dc2a7e9ac0 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1147,7 +1147,7 @@ static void create_object_entry(const struct object_id *oid,
 {
 	struct object_entry *entry;
 
-	entry = packlist_alloc(&to_pack, oid->hash, index_pos);
+	entry = packlist_alloc(&to_pack, oid, index_pos);
 	entry->hash = hash;
 	oe_set_type(entry, type);
 	if (exclude)
diff --git a/pack-objects.c b/pack-objects.c
index 52560293b6..c1df08df1a 100644
--- a/pack-objects.c
+++ b/pack-objects.c
@@ -153,7 +153,7 @@ void prepare_packing_data(struct repository *r, struct packing_data *pdata)
 }
 
 struct object_entry *packlist_alloc(struct packing_data *pdata,
-				    const unsigned char *sha1,
+				    const struct object_id *oid,
 				    uint32_t index_pos)
 {
 	struct object_entry *new_entry;
@@ -177,7 +177,7 @@ struct object_entry *packlist_alloc(struct packing_data *pdata,
 	new_entry = pdata->objects + pdata->nr_objects++;
 
 	memset(new_entry, 0, sizeof(*new_entry));
-	hashcpy(new_entry->idx.oid.hash, sha1);
+	oidcpy(&new_entry->idx.oid, oid);
 
 	if (pdata->index_size * 3 <= pdata->nr_objects * 4)
 		rehash_objects(pdata);
diff --git a/pack-objects.h b/pack-objects.h
index 857d43850b..47bf7ebf86 100644
--- a/pack-objects.h
+++ b/pack-objects.h
@@ -183,7 +183,7 @@ static inline void packing_data_unlock(struct packing_data *pdata)
 }
 
 struct object_entry *packlist_alloc(struct packing_data *pdata,
-				    const unsigned char *sha1,
+				    const struct object_id *oid,
 				    uint32_t index_pos);
 
 struct object_entry *packlist_find(struct packing_data *pdata,
-- 
2.23.0.463.g883b23b1c5

