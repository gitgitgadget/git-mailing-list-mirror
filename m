Return-Path: <SRS0=prLJ=4M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CDC3C35641
	for <git@archiver.kernel.org>; Mon, 24 Feb 2020 04:30:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DD2A120658
	for <git@archiver.kernel.org>; Mon, 24 Feb 2020 04:30:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727236AbgBXEaJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 23 Feb 2020 23:30:09 -0500
Received: from cloud.peff.net ([104.130.231.41]:52304 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727189AbgBXEaJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 23 Feb 2020 23:30:09 -0500
Received: (qmail 5189 invoked by uid 109); 24 Feb 2020 04:30:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 24 Feb 2020 04:30:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6891 invoked by uid 111); 24 Feb 2020 04:39:13 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 23 Feb 2020 23:39:13 -0500
Authentication-Results: peff.net; auth=none
Date:   Sun, 23 Feb 2020 23:30:07 -0500
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 03/10] pack-objects: convert oe_set_delta_ext() to use
 object_id
Message-ID: <20200224043007.GC1018190@coredump.intra.peff.net>
References: <20200224042625.GA1015553@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200224042625.GA1015553@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We already store an object_id internally, and now our sole caller also
has one. Let's stop passing around the internal hash array, which adds a
bit of type safety.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/pack-objects.c | 2 +-
 pack-objects.c         | 4 ++--
 pack-objects.h         | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index 8692ab3fe6..44f44fcb1a 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -1756,7 +1756,7 @@ static void check_object(struct object_entry *entry)
 				entry->delta_sibling_idx = base_entry->delta_child_idx;
 				SET_DELTA_CHILD(base_entry, entry);
 			} else {
-				SET_DELTA_EXT(entry, base_ref.hash);
+				SET_DELTA_EXT(entry, &base_ref);
 			}
 
 			unuse_pack(&w_curs);
diff --git a/pack-objects.c b/pack-objects.c
index 5e5a3c62d9..f2a433885a 100644
--- a/pack-objects.c
+++ b/pack-objects.c
@@ -203,14 +203,14 @@ struct object_entry *packlist_alloc(struct packing_data *pdata,
 
 void oe_set_delta_ext(struct packing_data *pdata,
 		      struct object_entry *delta,
-		      const unsigned char *sha1)
+		      const struct object_id *oid)
 {
 	struct object_entry *base;
 
 	ALLOC_GROW(pdata->ext_bases, pdata->nr_ext + 1, pdata->alloc_ext);
 	base = &pdata->ext_bases[pdata->nr_ext++];
 	memset(base, 0, sizeof(*base));
-	hashcpy(base->idx.oid.hash, sha1);
+	oidcpy(&base->idx.oid, oid);
 
 	/* These flags mark that we are not part of the actual pack output. */
 	base->preferred_base = 1;
diff --git a/pack-objects.h b/pack-objects.h
index d3975e079b..9d88e3e518 100644
--- a/pack-objects.h
+++ b/pack-objects.h
@@ -292,7 +292,7 @@ static inline void oe_set_delta(struct packing_data *pack,
 
 void oe_set_delta_ext(struct packing_data *pack,
 		      struct object_entry *e,
-		      const unsigned char *sha1);
+		      const struct object_id *oid);
 
 static inline struct object_entry *oe_delta_child(
 		const struct packing_data *pack,
-- 
2.25.1.823.g95c5488cf7

