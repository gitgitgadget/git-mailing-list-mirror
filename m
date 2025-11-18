Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91CA630FF27
	for <git@vger.kernel.org>; Tue, 18 Nov 2025 09:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763457130; cv=none; b=hzPzQQzJ1ZgwnBA3KG7/RbSstAu7tHLRiORaJXC7ozWpahWLKMxrY7Uh7QGws2GeqjxVhUZja6cx0+NxD0BLxaB3Mf09QDRkWje8vik2nRNxppbECdIpqzo/TbpoiSP+inWsHoGgr9Upk3DYsTAULbGvK/cRKEZH2PUhaSc+Be8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763457130; c=relaxed/simple;
	bh=AA1E8DAGDTaaBzo1tubwltdfHsQJgSGyDjknBrhlZtE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ju35lEvDAN/b9hj+8FwESikUk0AWv+JzozmNGB+SQxVWzFQJGuX79tYYd7VVqYaHy7TPGZ/taBApEyGCLzkDBU47R/mPzSiRoCB9qm0zlkOiToxwJ3CloFSey1pJ0r1RqIIqXY+L8MXY+SIgfxqeY7I3q6jTtcfg/0qig4Cn2qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=YOSiKUtY; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="YOSiKUtY"
Received: (qmail 19753 invoked by uid 109); 18 Nov 2025 09:12:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=AA1E8DAGDTaaBzo1tubwltdfHsQJgSGyDjknBrhlZtE=; b=YOSiKUtY9ZoGmlvT+lCe/9fRcRNDLQnv/SdL9ktubqbp5xGXzcxv9/4RoCKWD9WxYcK5xrTTHWxqBotgNsnJ9rSLDpuypFf9tw6en0YipDJs1U8Ks3IZBd71qKR66+Vieh6GbfDwNoK+tjsCCaexb6EJiraxqSjs4HHO3lvEIcvXGu/ewo/FH6eitZ+2yDwTXaP30J0ZA62RCJ4szFR0i2b1Eb4TBAKRFfHdMCD6t91eiyGrIA9MA7/v0s9yIbxiZEvRPV9S9NxdyzQsFyaqd9/Bbf0wer8DNVTFfedbExaiZqZs6A5YhrqpWFdNumODdmIjxnk8qVa4DvqeVWq10w==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 18 Nov 2025 09:12:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27383 invoked by uid 111); 18 Nov 2025 09:12:12 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 18 Nov 2025 04:12:11 -0500
Authentication-Results: peff.net; auth=none
Date: Tue, 18 Nov 2025 04:12:06 -0500
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Cc: Patrick Steinhardt <ps@pks.im>, correctmost <cmlists@sent.com>,
	Taylor Blau <me@ttaylorr.com>
Subject: [PATCH v2 2/9] pack-bitmap: handle name-hash lookups in incremental
 bitmaps
Message-ID: <20251118091206.GB529192@coredump.intra.peff.net>
References: <20251118091127.GA4175601@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251118091127.GA4175601@coredump.intra.peff.net>

If a bitmap has a name-hash cache, it is an array of 32-bit integers,
one per entry in the bitmap, which we've mmap'd from the .bitmap file.
We access it directly like this:

    if (bitmap_git->hashes)
            hash = get_be32(bitmap_git->hashes + index_pos);

That works for both regular pack bitmaps and for non-incremental midx
bitmaps. There is one bitmap_index with one "hashes" array, and
index_pos is within its bounds (we do the bounds-checking when we load
the bitmap).

But for an incremental midx bitmap, we have a linked list of
bitmap_index structs, and each one has only its own small slice of the
name-hash array. If index_pos refers to an object that is not in the
first bitmap_git of the chain, then we'll access memory outside of the
bounds of its "hashes" array, and often outside of the mmap.

Instead, we should walk through the list until we find the bitmap_index
which serves our index_pos, and use its hash (after adjusting index_pos
to make it relative to the slice we found). This is exactly what we do
elsewhere for incremental midx lookups (like the pack_pos_to_midx() call
a few lines above). But we can't use existing helpers like
midx_for_object() here, because we're walking through the chain of
bitmap_index structs (each of which refers to a midx), not the chain of
incremental multi_pack_index structs themselves.

The problem is triggered in the test suite, but we don't get a segfault
because the out-of-bounds index is too small. The OS typically rounds
our mmap up to the nearest page size, so we just end up accessing some
extra zero'd memory. Nor do we catch it with ASan, since it doesn't seem
to instrument mmaps at all. But if we build with NO_MMAP, then our maps
are replaced with heap allocations, which ASan does check. And so:

  make NO_MMAP=1 SANITIZE=address
  cd t
  ./t5334-incremental-multi-pack-index.sh

does show the problem (and this patch makes it go away).

Signed-off-by: Jeff King <peff@peff.net>
---
 pack-bitmap.c | 29 +++++++++++++++++++++++++----
 1 file changed, 25 insertions(+), 4 deletions(-)

diff --git a/pack-bitmap.c b/pack-bitmap.c
index 291e1a9cf4..8ca79725b1 100644
--- a/pack-bitmap.c
+++ b/pack-bitmap.c
@@ -213,6 +213,28 @@ static uint32_t bitmap_num_objects(struct bitmap_index *index)
 	return index->pack->num_objects;
 }
 
+static uint32_t bitmap_name_hash(struct bitmap_index *index, uint32_t pos)
+{
+	if (bitmap_is_midx(index)) {
+		while (index && pos < index->midx->num_objects_in_base) {
+			ASSERT(bitmap_is_midx(index));
+			index = index->base;
+		}
+
+		if (!index)
+			BUG("NULL base bitmap for object position: %"PRIu32, pos);
+
+		pos -= index->midx->num_objects_in_base;
+		if (pos >= index->midx->num_objects)
+			BUG("out-of-bounds midx bitmap object at %"PRIu32, pos);
+	}
+
+	if (!index->hashes)
+		return 0;
+
+	return get_be32(index->hashes + pos);
+}
+
 static struct repository *bitmap_repo(struct bitmap_index *bitmap_git)
 {
 	if (bitmap_is_midx(bitmap_git))
@@ -1724,8 +1746,7 @@ static void show_objects_for_type(
 				pack = bitmap_git->pack;
 			}
 
-			if (bitmap_git->hashes)
-				hash = get_be32(bitmap_git->hashes + index_pos);
+			hash = bitmap_name_hash(bitmap_git, index_pos);
 
 			show_reach(&oid, object_type, 0, hash, pack, ofs, payload);
 		}
@@ -3124,8 +3145,8 @@ uint32_t *create_bitmap_mapping(struct bitmap_index *bitmap_git,
 
 		if (oe) {
 			reposition[i] = oe_in_pack_pos(mapping, oe) + 1;
-			if (bitmap_git->hashes && !oe->hash)
-				oe->hash = get_be32(bitmap_git->hashes + index_pos);
+			if (!oe->hash)
+				oe->hash = bitmap_name_hash(bitmap_git, index_pos);
 		}
 	}
 
-- 
2.52.0.278.gadc6434dc3

