Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3DE8720248
	for <e@80x24.org>; Fri,  5 Apr 2019 18:04:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731607AbfDESE0 (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Apr 2019 14:04:26 -0400
Received: from cloud.peff.net ([104.130.231.41]:48652 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1731588AbfDESE0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Apr 2019 14:04:26 -0400
Received: (qmail 10971 invoked by uid 109); 5 Apr 2019 18:04:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 05 Apr 2019 18:04:26 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28098 invoked by uid 111); 5 Apr 2019 18:04:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 05 Apr 2019 14:04:53 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 05 Apr 2019 14:04:24 -0400
Date:   Fri, 5 Apr 2019 14:04:24 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Cc:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Subject: [PATCH v2 02/13] pack-revindex: open index if necessary
Message-ID: <20190405180423.GB32243@sigill.intra.peff.net>
References: <20190405180306.GA21113@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190405180306.GA21113@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We can't create a pack revindex if we haven't actually looked at the
index. Normally we would never get as far as creating a revindex without
having already been looking in the pack, so this code never bothered to
double-check that pack->index_data had been loaded.

But with the new multi-pack-index feature, many code paths might not
load the individual pack .idx at all (they'd find objects via the midx
and then open the .pack, but not its index).

This can't yet be triggered in practice, because a bug in the midx code
means we accidentally open up the individual .idx files anyway. But in
preparation for fixing that, let's have the revindex code check that
everything it needs has been loaded.

In most cases this will just be a quick noop. But note that this does
introduce a possibility of error (if we have to open the index and it's
corrupt), so load_pack_revindex() now returns a result code, and callers
need to handle the error.

Signed-off-by: Jeff King <peff@peff.net>
---
 pack-bitmap.c   |  3 ++-
 pack-revindex.c | 13 ++++++++++---
 pack-revindex.h |  2 +-
 packfile.c      |  6 ++++--
 4 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index 4695aaf6b4..3960ad94c8 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -308,7 +308,8 @@ static int load_pack_bitmap(struct bitmap_index *bitmap_git)
 
 	bitmap_git->bitmaps = kh_init_sha1();
 	bitmap_git->ext_index.positions = kh_init_sha1_pos();
-	load_pack_revindex(bitmap_git->pack);
+	if (load_pack_revindex(bitmap_git->pack))
+		goto failed;
 
 	if (!(bitmap_git->commits = read_bitmap_1(bitmap_git)) ||
 		!(bitmap_git->trees = read_bitmap_1(bitmap_git)) ||
diff --git a/pack-revindex.c b/pack-revindex.c
index 50891f77a2..d28a7e43d0 100644
--- a/pack-revindex.c
+++ b/pack-revindex.c
@@ -1,6 +1,7 @@
 #include "cache.h"
 #include "pack-revindex.h"
 #include "object-store.h"
+#include "packfile.h"
 
 /*
  * Pack index for existing packs give us easy access to the offsets into
@@ -158,10 +159,14 @@ static void create_pack_revindex(struct packed_git *p)
 	sort_revindex(p->revindex, num_ent, p->pack_size);
 }
 
-void load_pack_revindex(struct packed_git *p)
+int load_pack_revindex(struct packed_git *p)
 {
-	if (!p->revindex)
+	if (!p->revindex) {
+		if (open_pack_index(p))
+			return -1;
 		create_pack_revindex(p);
+	}
+	return 0;
 }
 
 int find_revindex_position(struct packed_git *p, off_t ofs)
@@ -188,7 +193,9 @@ struct revindex_entry *find_pack_revindex(struct packed_git *p, off_t ofs)
 {
 	int pos;
 
-	load_pack_revindex(p);
+	if (load_pack_revindex(p))
+		return NULL;
+
 	pos = find_revindex_position(p, ofs);
 
 	if (pos < 0)
diff --git a/pack-revindex.h b/pack-revindex.h
index e262f3efe8..848331d5d6 100644
--- a/pack-revindex.h
+++ b/pack-revindex.h
@@ -8,7 +8,7 @@ struct revindex_entry {
 	unsigned int nr;
 };
 
-void load_pack_revindex(struct packed_git *p);
+int load_pack_revindex(struct packed_git *p);
 int find_revindex_position(struct packed_git *p, off_t ofs);
 
 struct revindex_entry *find_pack_revindex(struct packed_git *p, off_t ofs);
diff --git a/packfile.c b/packfile.c
index 16bcb75262..6e40bd89c7 100644
--- a/packfile.c
+++ b/packfile.c
@@ -2023,8 +2023,10 @@ int for_each_object_in_pack(struct packed_git *p,
 	uint32_t i;
 	int r = 0;
 
-	if (flags & FOR_EACH_OBJECT_PACK_ORDER)
-		load_pack_revindex(p);
+	if (flags & FOR_EACH_OBJECT_PACK_ORDER) {
+		if (load_pack_revindex(p))
+			return -1;
+	}
 
 	for (i = 0; i < p->num_objects; i++) {
 		uint32_t pos;
-- 
2.21.0.729.g7d31bf3764

