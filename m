Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32593E9585
	for <git@vger.kernel.org>; Wed, 27 May 2026 09:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779873859; cv=none; b=mQPi6djyRBPzafE5dlrX25Go+HVQu+g3XsaQWEFKHi6ryHtORXRJFMcv0xoLS3Pannm97kdSNz7gynKRULCKRhX+nGy9KaH02s5yKl4DIxCaxyN2y+YRxYE4rYIav304WiWoBpQ22zxPcFajE+i6b9e320G61ruYaGduMTSV3oE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779873859; c=relaxed/simple;
	bh=gatpw2RMniLurlzokXUu6EYPBG54oTj96GK8H2BqTm0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LV/3idA9yvyb3ijIdizAgqz9JNE8arJjsvXlP0n8xyGId6Q9kjewKzBsbWsbulB6hjkeWdHstdnEHI034da5tjUsrwnyW226FMF77hXajfuGia25HxFsLkkM2JTSdkGGNX5PVKYCOteWTzI4AFPQ7vFNEuCK5u5y0Y1poe9hrEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=OTyjmWdz; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="OTyjmWdz"
Received: (qmail 28981 invoked by uid 106); 27 May 2026 09:24:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=gatpw2RMniLurlzokXUu6EYPBG54oTj96GK8H2BqTm0=; b=OTyjmWdzj+NL0tTSyQ+tuWHOwa2zVOEFGJWOv2aajk4F+fXSSDc9NSlvOoTg3eSAO9rXtWtGj9X6dtG2vr1YwRcCootiIXD9nPLXXLULr3uDeILVMaIAFMyr1MrBixoU/rc0acRFrjHDpBwBkXoaOOL1N+tIJS4n6oNI7yKZKD9gRoJIMcfOwh/dTygymIkAGitpz3YeUluCWq7sKHjQpV1OjYb/NVg98w8HuiLXQsSv19SoSTJfbVrMty+kgkanMTZgpHVPfejiIeh5xU2l1ipsvSvxb8rUavD+tV2F2v0A4LfKRT4iZ8SGrj/5HkKIV3mQKt4MtGsGwxGrwVbGtA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 27 May 2026 09:24:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 71598 invoked by uid 111); 27 May 2026 09:24:18 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 27 May 2026 05:24:18 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 27 May 2026 05:24:12 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH 3/8] pack-bitmap: reuse stored selected bitmaps
Message-ID: <20260527092412.GD981444@coredump.intra.peff.net>
References: <cover.1779207127.git.me@ttaylorr.com>
 <6e1f6bef5f641481a6a875bc215b35fc56cef80c.1779207127.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6e1f6bef5f641481a6a875bc215b35fc56cef80c.1779207127.git.me@ttaylorr.com>

On Tue, May 19, 2026 at 12:12:41PM -0400, Taylor Blau wrote:

> Building bitmaps from scratch on the same test repository from the
> previous commits yields a significant speed-up:
> 
>     +------------------+-------------+-------------+---------------------+
>     |                  | HEAD^       | HEAD        | Delta               |
>     +------------------+-------------+-------------+---------------------+
>     | elapsed          |   562.8 s   |   324.8 s   |   -237.9 s (-42.3%) |
>     | cycles           | 2,621.3 B   | 1,508.6 B   | -1,112.7 B (-42.4%) |
>     | instructions     | 2,348.9 B   | 1,436.6 B   |   -912.3 B (-38.8%) |
>     | CPI              |     1.116   |     1.050   |   -0.066    (-5.9%) |
>     +------------------+-------------+-------------+---------------------+

Oh my, that's a rather nice speedup. I can reproduce here on linux.git
(~47% improvement).

> When `fill_bitmap_commit()` reaches an ancestor that was selected for
> its own bitmap and processed earlier, its object closure is already
> stored in `writer->bitmaps` as an EWAH bitmap. As a result, walking
> through that commit's tree and parents again is redundant.
> 
> Teach `fill_bitmap_commit()` to notice that case. For non-root commits in
> the walk, look for a stored selected bitmap and OR it into the bitmap
> being built. If one exists, skip the commit, its tree, and its parents.

I feel like this _shouldn't_ be necessary, because the idea of the
current writing code is to go from the roots up, following inverted
parent pointers, and passing the bitmap up as we go. So whenever we
visit a commit we should in theory have all of the ancestor's bits set
in that bitmap. But I remember that the simple-and-stupid approach ended
up being too memory hungry, so we pick some focal points in the graph
and then fill them independently.

And I guess that's what you're showing here:

> In our testing repository, there are 1,261 commits selected for bitmap
> coverage, and 1,382 maximal commits induced as a result of that. Of the
> 1,382 calls made to `fill_bitmap_commit()` (one per maximal commit), 131
> of them can be short-circuited at some point during their traversal as a
> consequence of this change.

We'll end up seeing some of the same parts of history for various
maximal commits, and this lets us sometimes reuse the earlier efforts.

Anyway, it is hard to argue with the numbers.

> @@ -553,6 +559,28 @@ static int fill_bitmap_commit(struct bitmap_writer *writer,
>  			bitmap_free(remapped);
>  		}
>  
> +		/*
> +		 * If we encounter an ancestor for which we have already
> +		 * computed a bitmap during this build (i.e. a regular
> +		 * selected commit processed earlier in topo order), we can
> +		 * short-circuit the walk: its stored bitmap already covers
> +		 * the commit itself, its tree, and all of its ancestors.
> +		 */
> +		if (c != commit) {
> +			khiter_t hash_pos = kh_get_oid_map(writer->bitmaps,
> +							   c->object.oid);
> +			if (hash_pos != kh_end(writer->bitmaps)) {
> +				struct bitmapped_commit *stored =
> +					kh_value(writer->bitmaps, hash_pos);
> +				if (stored && stored->bitmap) {
> +					fill_bitmap_commit_found_ancestor_nr++;
> +					bitmap_or_ewah(ent->bitmap,
> +						       stored->bitmap);
> +					continue;
> +				}
> +			}
> +		}

OK, so we incur one hash lookup per commit as we walk, which seems like
a good tradeoff.

I wondered about "c != commit" here. "c" is the commit we're traversing,
and "commit" is the one for which we're trying to build the bitmap. So
we would not expect to ever have an entry in writer->bitmaps for "c"
yet, but the conditional is just short-circuiting the hash lookup.

The rest of the patch looks obviously correct. The trace2 bits aren't
strictly necessary, of course, but some metrics might help with further
tuning.

-Peff
