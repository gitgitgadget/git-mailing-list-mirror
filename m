Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5B1F520248
	for <e@80x24.org>; Fri,  5 Apr 2019 13:40:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727398AbfDENkk (ORCPT <rfc822;e@80x24.org>);
        Fri, 5 Apr 2019 09:40:40 -0400
Received: from cloud.peff.net ([104.130.231.41]:48130 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726135AbfDENkk (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Apr 2019 09:40:40 -0400
Received: (qmail 7678 invoked by uid 109); 5 Apr 2019 13:40:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 05 Apr 2019 13:40:39 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25080 invoked by uid 111); 5 Apr 2019 13:41:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 05 Apr 2019 09:41:07 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 05 Apr 2019 09:40:38 -0400
Date:   Fri, 5 Apr 2019 09:40:38 -0400
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 04/12] packfile: check midx coverage with .idx rather
 than .pack
Message-ID: <20190405134037.GC1460@sigill.intra.peff.net>
References: <20190404232104.GA27770@sigill.intra.peff.net>
 <20190404232546.GD21839@sigill.intra.peff.net>
 <20190405120120.GA8796@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190405120120.GA8796@szeder.dev>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 05, 2019 at 02:01:20PM +0200, SZEDER Gábor wrote:

> > The tests don't notice because there's nothing about opening those .idx
> > files that would cause us to give incorrect output. It's just a little
> > slower. The new test checks this case by corrupting the covered .idx,
> > and then making sure we don't complain about it.
> 
> When the test suite is run with GIT_TEST_MULTI_PACK_INDEX=1, the
> following tests fail with this patch:
> 
>   t1006-cat-file.sh                                (Wstat: 256 Tests: 111 Failed: 1)
>     Failed test:  87
>     Non-zero exit status: 1
>   t5320-delta-islands.sh                           (Wstat: 256 Tests: 15 Failed: 10)
>     Failed tests:  2-4, 6-10, 12-13
>     Non-zero exit status: 1
>   t5310-pack-bitmaps.sh                            (Wstat: 256 Tests: 46 Failed: 1)
>     Failed test:  44
>     Non-zero exit status: 1
>   t5570-git-daemon.sh                              (Wstat: 256 Tests: 21 Failed: 1)
>     Failed test:  10
>     Non-zero exit status: 1

Thanks. It looks like this is not a bug in my patch per se, but rather
that the feature of the midx code it is un-breaking is not actually a
good idea.

The problem is with generating the pack revindex. It needs the actual
index for each pack to be loaded, and now open_packed_git() will
sometimes quietly not do that.

Probably we _could_ be generating a big revindex off of the midx, but in
the meantime, the revindex code needs to make sure that the index is
loaded before looking at it.

This patch clears up those test failures (I'll re-roll the whole series
with it in the proper spot).

---
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
index e7ca135ed5..ca73a5b12a 100644
--- a/packfile.c
+++ b/packfile.c
@@ -2040,8 +2040,10 @@ int for_each_object_in_pack(struct packed_git *p,
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
