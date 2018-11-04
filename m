Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 409631F453
	for <e@80x24.org>; Sun,  4 Nov 2018 02:34:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728847AbeKDLrm (ORCPT <rfc822;e@80x24.org>);
        Sun, 4 Nov 2018 06:47:42 -0500
Received: from cloud.peff.net ([104.130.231.41]:39652 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727238AbeKDLrm (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 4 Nov 2018 06:47:42 -0500
Received: (qmail 24083 invoked by uid 109); 4 Nov 2018 02:27:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 04 Nov 2018 02:27:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8570 invoked by uid 111); 4 Nov 2018 02:27:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sat, 03 Nov 2018 22:27:06 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 03 Nov 2018 22:27:46 -0400
Date:   Sat, 3 Nov 2018 22:27:46 -0400
From:   Jeff King <peff@peff.net>
To:     Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
Cc:     git@vger.kernel.org, stolee@gmail.com
Subject: Re: [PATCH] multi-pack-index: make code -Wunused-parameter clean
Message-ID: <20181104022746.GA30936@sigill.intra.peff.net>
References: <20181104004957.52913-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20181104004957.52913-1-carenas@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Nov 03, 2018 at 05:49:57PM -0700, Carlo Marcelo Arenas Belón wrote:

> introduced in 662148c435 ("midx: write object offsets", 2018-07-12)
> but included on all previous versions as well.
> 
> midx.c:713:54: warning: unused parameter 'nr_objects' [-Wunused-parameter]
> 
> likely an oversight as the information needed to iterate over is
> embedded in nr_large_offset

I've been preparing a series to make the whole code base compile with
-Wunused-parameter, and I handled this case a bit differently.

-- >8 --
Subject: [PATCH] midx: double-check large object write loop

The write_midx_large_offsets() function takes an array of object
entries, the number of entries in the array (nr_objects), and the number
of entries with large offsets (nr_large_offset). But we never actually
use nr_objects; instead we keep walking down the array and counting down
nr_large_offset until we've seen all of the large entries.

This is correct, but we can be a bit more defensive. If there were ever
a mismatch between nr_large_offset and the actual set of large-offset
objects, we'd walk off the end of the array.

Since we know the size of the array, we can use nr_objects to make sure
we don't walk too far.

Signed-off-by: Jeff King <peff@peff.net>
---
 midx.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/midx.c b/midx.c
index 4fac0cd08a..ecd583666a 100644
--- a/midx.c
+++ b/midx.c
@@ -712,12 +712,18 @@ static size_t write_midx_object_offsets(struct hashfile *f, int large_offset_nee
 static size_t write_midx_large_offsets(struct hashfile *f, uint32_t nr_large_offset,
 				       struct pack_midx_entry *objects, uint32_t nr_objects)
 {
-	struct pack_midx_entry *list = objects;
+	struct pack_midx_entry *list = objects, *end = objects + nr_objects;
 	size_t written = 0;
 
 	while (nr_large_offset) {
-		struct pack_midx_entry *obj = list++;
-		uint64_t offset = obj->offset;
+		struct pack_midx_entry *obj;
+		uint64_t offset;
+
+		if (list >= end)
+			BUG("too many large-offset objects");
+
+		obj = list++;
+		offset = obj->offset;
 
 		if (!(offset >> 31))
 			continue;
-- 
2.19.1.1352.g60f3b1a4c2

