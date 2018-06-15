Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 61BB81F403
	for <e@80x24.org>; Fri, 15 Jun 2018 03:44:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965416AbeFODop (ORCPT <rfc822;e@80x24.org>);
        Thu, 14 Jun 2018 23:44:45 -0400
Received: from cloud.peff.net ([104.130.231.41]:45338 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S965160AbeFODoo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jun 2018 23:44:44 -0400
Received: (qmail 18072 invoked by uid 109); 15 Jun 2018 03:44:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 15 Jun 2018 03:44:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 18232 invoked by uid 111); 15 Jun 2018 03:45:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 14 Jun 2018 23:45:00 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 14 Jun 2018 23:44:43 -0400
Date:   Thu, 14 Jun 2018 23:44:43 -0400
From:   Jeff King <peff@peff.net>
To:     Luat Nguyen <root@l4w.io>
Cc:     git@vger.kernel.org
Subject: [PATCH 4/3] ewah: adjust callers of ewah_read_mmap()
Message-ID: <20180615034442.GA14422@sigill.intra.peff.net>
References: <2067D731-C415-4D19-8CDA-90D7DC638397@l4w.io>
 <20180615032850.GA23241@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180615032850.GA23241@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 14, 2018 at 11:28:50PM -0400, Jeff King wrote:

> Yep. We also fail to check if we even have enough bytes to read the
> buffer_size in the first place.
> 
> Here are some patches. The first one fixes the problem you found. The
> second one drops some dead code that has a related problem. And the
> third just drops some dead code that I noticed in the same file. :)
> 
>   [1/3]: ewah_read_mmap: bounds-check mmap reads
>   [2/3]: ewah: drop ewah_deserialize function
>   [3/3]: ewah: drop ewah_serialize_native function

Actually, we'd want this one on top. Arguably it could be squashed into
patch 1.

-- >8 --
Subject: ewah: adjust callers of ewah_read_mmap()

The return value of ewah_read_mmap() is now an ssize_t,
since we could (in theory) process up to 32GB of data. This
would never happen in practice, but a corrupt or malicious
.bitmap or index file could convince us to do so.

Let's make sure that we don't stuff the value into an int,
which would cause us to incorrectly move our pointer
forward.  We'd always move too little, since negative values
are used for reporting errors. So the worst case is just
that we end up reporting a corrupt file, not an
out-of-bounds read.

Signed-off-by: Jeff King <peff@peff.net>
---
 dir.c         | 3 ++-
 pack-bitmap.c | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/dir.c b/dir.c
index 61b513a078..d5185660f1 100644
--- a/dir.c
+++ b/dir.c
@@ -2725,7 +2725,8 @@ struct untracked_cache *read_untracked_extension(const void *data, unsigned long
 	struct read_data rd;
 	const unsigned char *next = data, *end = (const unsigned char *)data + sz;
 	const char *ident;
-	int ident_len, len;
+	int ident_len;
+	ssize_t len;
 	const char *exclude_per_dir;
 
 	if (sz <= 1 || end[-1] != '\0')
diff --git a/pack-bitmap.c b/pack-bitmap.c
index 369bf69d75..2f27b10e35 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -125,7 +125,7 @@ static struct ewah_bitmap *read_bitmap_1(struct bitmap_index *index)
 {
 	struct ewah_bitmap *b = ewah_pool_new();
 
-	int bitmap_size = ewah_read_mmap(b,
+	ssize_t bitmap_size = ewah_read_mmap(b,
 		index->map + index->map_pos,
 		index->map_size - index->map_pos);
 
-- 
2.18.0.rc2.534.g53d976aeb8

