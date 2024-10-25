Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EFF967A0D
	for <git@vger.kernel.org>; Fri, 25 Oct 2024 07:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729840094; cv=none; b=lOaHY5Pl7vBTYYs61vGQ6wAz6GdUqG2blotDEqcD8pfMa4gM44b1m5SROjPWd+olPxqTo5CI6ubfWzXND5Eo1brBb4AKYd/GaTcIYmr0f3cTzg2ZP/QxhlQ0q+6CrH71kldoaOuLC8LkaNPr4GEqc8DTe8cTNgJlxbAh0oJGb+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729840094; c=relaxed/simple;
	bh=AVFplhlld4wvjTvchPzO6bvAR8bgYe7EqFZJDzfkygQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nKFgm5z0CLY7KQBOtKUW//o+fvoYKfLdUikPzkFKWYM3qBcW12TX+FlMuAPc4rkFKWsfujoij1e6DM9U++hmtAsAR7H+KoQ9HBTczZ5SopJLVYIm8IFjF/u0eM7Vr/SqLUVBrBcUMholizKFyg+uwIABYkzvu3+sVab9LMBYzm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=WOqytyNM; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="WOqytyNM"
Received: (qmail 614 invoked by uid 109); 25 Oct 2024 07:08:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=AVFplhlld4wvjTvchPzO6bvAR8bgYe7EqFZJDzfkygQ=; b=WOqytyNMVQS7PKKXzLBB9s1u096KhhvsOWNz3ZMxblOWDFKKh8jabRAeJcfvopyVoQJS3eAIdV8/MQrXQfK2TjpEeb+LW/tlNc+0COMVfZMmgrh1JXkneIqfYhtnXbvMKdFR84+hFouwBfybAK/Xb6kfqxFmW0dxQD+xK/N8f2MSsJjuGdZcW2T5IU0uHiLejNEBje+AYTJT9LFF9WIYVMlS3NqBSZlN1J7gvlbe+8cQy9LqFXqA+PS+UhBxKzrqpE1aj3WhmWUTxQSVnCuqcEhdEmlpjpSn3FPLTNTABUAmu5px1LpHDBprv/H9p7ycdlQoCiIbK8b0ZpTWm2PbZw==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 25 Oct 2024 07:08:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13004 invoked by uid 111); 25 Oct 2024 07:08:10 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 25 Oct 2024 03:08:10 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 25 Oct 2024 03:08:10 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: Patrick Steinhardt <ps@pks.im>, fox <fox.gbr@townlong-yak.com>,
	Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org
Subject: [PATCH 11/11] packfile: use oidread() instead of hashcpy() to fill
 object_id
Message-ID: <20241025070810.GK2110355@coredump.intra.peff.net>
References: <20241025064148.GA2110169@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241025064148.GA2110169@coredump.intra.peff.net>

When chasing a REF_DELTA, we need to pull the raw hash bytes out of the
mmap'd packfile into an object_id struct. We do that with a raw
hashcpy() of the appropriate length (that happens directly now, though
before the previous commit it happened inside find_pack_entry_one(),
also using a hashcpy).

But I think this creates a potentially dangerous situation due to
d4d364b2c7 (hash: convert `oidcmp()` and `oideq()` to compare whole
hash, 2024-06-14). When using sha1, we'll have uninitialized bytes in
the latter part of the object_id.hash buffer, which could fool oideq(),
etc.

We should use oidread() instead, which correctly zero-pads the extra
bytes, as of c98d762ed9 (global: ensure that object IDs are always
padded, 2024-06-14).

As far as I can see, this has not been a problem in practice because the
object_id we feed to find_pack_entry_one() is never used with oideq(),
etc. It is being compared to the bytes mmap'd from a pack idx file,
which of course do not have the extra padding bytes themselves. So
there's no bug here, but this just puzzled me while looking at the code.
We should do the more obviously safe thing, both for future-proofing and
to avoid confusing readers.

Signed-off-by: Jeff King <peff@peff.net>
---
+cc Patrick for any wisdom here. I'd guess that the conversions from
c98d762ed9 were found by using ASan, valgrind, or similar with the new
oideq() implementation.  And so this case, because it actually is safe,
was not flagged.

 packfile.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/packfile.c b/packfile.c
index 005ca670b4..9560f0a33c 100644
--- a/packfile.c
+++ b/packfile.c
@@ -1240,7 +1240,7 @@ off_t get_delta_base(struct packed_git *p,
 	} else if (type == OBJ_REF_DELTA) {
 		/* The base entry _must_ be in the same pack */
 		struct object_id oid;
-		hashcpy(oid.hash, base_info, the_repository->hash_algo);
+		oidread(&oid, base_info, the_repository->hash_algo);
 		base_offset = find_pack_entry_one(&oid, p);
 		*curpos += the_hash_algo->rawsz;
 	} else
-- 
2.47.0.363.g6e72b256be
