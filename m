Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2ED641F453
	for <e@80x24.org>; Thu, 14 Feb 2019 05:50:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405439AbfBNFue (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Feb 2019 00:50:34 -0500
Received: from cloud.peff.net ([104.130.231.41]:43750 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726155AbfBNFud (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Feb 2019 00:50:33 -0500
Received: (qmail 880 invoked by uid 109); 14 Feb 2019 05:50:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 14 Feb 2019 05:50:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6927 invoked by uid 111); 14 Feb 2019 05:50:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 14 Feb 2019 00:50:44 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 14 Feb 2019 00:50:32 -0500
Date:   Thu, 14 Feb 2019 00:50:32 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     Duy Nguyen <pclouds@gmail.com>
Subject: [PATCH 06/10] pack-objects: drop unused parameter from
 oe_map_new_pack()
Message-ID: <20190214055031.GF20578@sigill.intra.peff.net>
References: <20190214054736.GA20091@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190214054736.GA20091@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since 43fa44fa3b (pack-objects: move in_pack out of struct object_entry,
2018-04-14), we store the source pack for each object as a small index
rather than as a pointer. When we see a new pack that has no allocated
index, we fall back to generating an array of pointers by calling
oe_map_new_pack().

Perhaps counter-intuitively, that function does not need to actually see
our new index-less pack. It only allocates and populates the array with
the existing packs, after which oe_set_in_pack() actually adds the new
pack to the array.

Let's drop the unused "struct packed_git" argument to oe_map_new_pack()
to avoid confusion.

Signed-off-by: Jeff King <peff@peff.net>
---
 pack-objects.c | 3 +--
 pack-objects.h | 6 +++---
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/pack-objects.c b/pack-objects.c
index e7cd337bee..ce33b8906e 100644
--- a/pack-objects.c
+++ b/pack-objects.c
@@ -119,8 +119,7 @@ static void prepare_in_pack_by_idx(struct packing_data *pdata)
  * this fall back code, just stay simple and fall back to using
  * in_pack[] array.
  */
-void oe_map_new_pack(struct packing_data *pack,
-		     struct packed_git *p)
+void oe_map_new_pack(struct packing_data *pack)
 {
 	uint32_t i;
 
diff --git a/pack-objects.h b/pack-objects.h
index 6bfacc7d2c..6fde7ce27c 100644
--- a/pack-objects.h
+++ b/pack-objects.h
@@ -247,14 +247,14 @@ static inline struct packed_git *oe_in_pack(const struct packing_data *pack,
 		return pack->in_pack[e - pack->objects];
 }
 
-void oe_map_new_pack(struct packing_data *pack,
-		     struct packed_git *p);
+void oe_map_new_pack(struct packing_data *pack);
+
 static inline void oe_set_in_pack(struct packing_data *pack,
 				  struct object_entry *e,
 				  struct packed_git *p)
 {
 	if (!p->index)
-		oe_map_new_pack(pack, p);
+		oe_map_new_pack(pack);
 	if (pack->in_pack_by_idx)
 		e->in_pack_idx = p->index;
 	else
-- 
2.21.0.rc1.567.g648f076c3f

