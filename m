Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01E311534EC
	for <git@vger.kernel.org>; Wed, 18 Dec 2024 12:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734525203; cv=none; b=HBQFKv1G38+Ronjoi7BpWnQbYw0+ON4KG/G/l8RIr6369qk4JawdbiIZ2bgbkwjd5ToZ5rRgOX+DQ+eGmj2uQttKAW03TIon3CSz477dnIPCpUkEbMmRXlLu05ZR0cWx/ZKo8/T9oY5tXnKwWLRuenyr8MoqU2pi1z+gt2QZwoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734525203; c=relaxed/simple;
	bh=K7nocB0O3VHgHY/AzTBVwGwT6MFrfcPd02EABpvLvTQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DNvxlNt+W7vLvgoeDdpxdTEMG0OPZeiTBttj9QtTLAed/CO6PuLEwgqrznxVw+jZydffsy1sjNH2wxeBN0D2nmiHrWVchUc0K1N3IU5Bmqr/EQB1lquL/3Yx378o0BYRCwXv5m6kc02n8pcX4s6RwfIAgtxUrFlwFmOPGSzwz7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=CWl4RHnr; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="CWl4RHnr"
Received: (qmail 6987 invoked by uid 109); 18 Dec 2024 12:33:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=K7nocB0O3VHgHY/AzTBVwGwT6MFrfcPd02EABpvLvTQ=; b=CWl4RHnrH06soqJwoMshqdn76FLBuhU1YfsNxEy/HdVOJuuIciAevbEZhCm268925pkGMQwwVaRBCZNZk5tpjB9kj8hyR3gPO67bvuaTv5C0B9pvAhFAGAJdBZoxdQSSsExr7p7M6yk6vH3GkjSEIvyres/VuZbJ6Kw4InQ+Rr6a9PTrMG+95vARGmhPVog/yXsUkfXJAxn4VjPM3xEAAYt5q/tD4x/GCq3cOoRah+x1uWSMHcb4BXMxKMtVvlamjFXMKphUU2PXGOxHm1L2zZbiXHz1uS+C0Jj49q2KYqShRSEL1i0bPOIUS4uqw9wf2VRx2zB2m289MRvH734X7A==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 18 Dec 2024 12:33:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25190 invoked by uid 111); 18 Dec 2024 12:33:19 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 18 Dec 2024 07:33:19 -0500
Authentication-Results: peff.net; auth=none
Date: Wed, 18 Dec 2024 07:33:19 -0500
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH] pack-bitmap.c: ensure pack validity for all reuse packs
Message-ID: <20241218123319.GB695807@coredump.intra.peff.net>
References: <7fdbfadc04926efc094633b238a55168c92e3d58.1734117577.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <7fdbfadc04926efc094633b238a55168c92e3d58.1734117577.git.me@ttaylorr.com>

On Fri, Dec 13, 2024 at 02:20:02PM -0500, Taylor Blau wrote:

> Commit 44f9fd6496 (pack-bitmap.c: check preferred pack validity when
> opening MIDX bitmap, 2022-05-24) prevents a race condition whereby the
> preferred pack disappears between opening the MIDX bitmap and attempting
> verbatim reuse out of its packs.
> 
> That commit forces open_midx_bitmap_1() to ensure the validity of the
> MIDX's preferred pack, meaning that we have an open file handle on the
> *.pack, ensuring that we can reuse bytes out of verbatim later on in the
> process[^1].
> 
> But 44f9fd6496 was not extended to cover multi-pack reuse, meaning that
> this same race condition exists for non-preferred packs during verbatim
> reuse. Work around that race in the same way by only marking valid packs
> as reuse-able. For packs that aren't reusable, skip over them but
> include the number of objects they have to ensure we allocate a large
> enough 'reuse' bitmap (e.g. if a pack in the middle of the MIDX
> disappeared but we still want to reuse later packs).

Nicely explained.

> Since we're ensuring the validity of these packs within the verbatim
> reuse code, we no longer have to special-case the preferred pack and
> open it within the open_midx_bitmap_1() function.

Right, makes sense.

> An alternative approach to the one taken here would be to open all
> MIDX'd packs from within open_midx_bitmap_1(). But that would be both
> slower and make the bitmaps less useful, since we can still perform some
> pack reuse among the packs that still exist when the *.bitmap is opened.

Yeah, I agree that what you wrote is much nicer. It lets us use the
optimization as much as possible.

I think unsaid here is what happens to the objects in the pack that
disappeared. And they are fine: their bits are still set in the
reachability bitmap, but not in the verbatim reuse bitmap. So we skip
them during that optimized step, but still handle them in the usual way
in the rest of pack-objects (adding them to the to_pack struct,
considering them for deltas, and so on). Good.

> After applying this patch, we can simulate the new behavior after
> instrumenting Git like so:
> 
>     diff --git a/packfile.c b/packfile.c
>     index 9560f0a33c..aedce72524 100644
>     --- a/packfile.c
>     +++ b/packfile.c
>     @@ -557,6 +557,11 @@ static int open_packed_git_1(struct packed_git *p)
>      		; /* nothing */
> 
>      	p->pack_fd = git_open(p->pack_name);
>     +	{
>     +		const char *delete = getenv("GIT_RACILY_DELETE");
>     +		if (delete && !strcmp(delete, pack_basename(p)))
>     +			return -1;
>     +	}
>      	if (p->pack_fd < 0 || fstat(p->pack_fd, &st))
>      		return -1;
>      	pack_open_fds++;

Cute. I wondered if we could convince pack-objects to pause at the right
spot (and actually repack/delete the pack in question) without such a
patch, but I'm not sure. I guess the right spot is after we load the
midx, but before we finish making the bitmap.

Possibly you could start the pack-objects process, feed a few lines that
require object access (maybe a tag that needs to be peeled?), and then
pause before sending the rest of the input.

But it feels quite complex and error-prone.

> Note that we could relax the single-pack version of this which was most
> recently addressed in dc1daacdcc (pack-bitmap: check pack validity when
> opening bitmap, 2021-07-23), but only partially. Because we still need
> to know the object count in the pack, we'd still have to open the pack's
> *.idx, so the savings there are marginal.

Yeah, since the reuse there is all-or-nothing anyway, I think there's
not much to be gained. If the bitmap result from the traversal turns out
not to use _any_ objects from that big pack, I guess we save opening the
pack. But I don't think opening is really that expensive (we do not even
mmap until asked for a specific object).

> Note likewise that we add a new "if (!packs_nr)" early return in the
> pack reuse code to avoid a potentially expensive allocation on the
> 'reuse' bitmap in the case that no packs are available for reuse.

OK. It's not like we aren't also allocating a bitmap result of the same
size, so it's purely a constant-time speedup. But every little bit
helps, and the change is quite simple.

> @@ -2285,8 +2272,10 @@ void reuse_partial_packfile_from_bitmap(struct bitmap_index *bitmap_git,
>  			if (!pack.bitmap_nr)
>  				continue;
>  
> -			ALLOC_GROW(packs, packs_nr + 1, packs_alloc);
> -			memcpy(&packs[packs_nr++], &pack, sizeof(pack));
> +			if (is_pack_valid(pack.p)) {
> +				ALLOC_GROW(packs, packs_nr + 1, packs_alloc);
> +				memcpy(&packs[packs_nr++], &pack, sizeof(pack));
> +			}
>  
>  			objects_nr += pack.p->num_objects;
>  		}

OK, so this is the multi-pack reuse code path. So we know we have a midx
here.

> @@ -2320,16 +2309,22 @@ void reuse_partial_packfile_from_bitmap(struct bitmap_index *bitmap_git,
>  			pack_int_id = -1;
>  		}
>  
> -		ALLOC_GROW(packs, packs_nr + 1, packs_alloc);
> -		packs[packs_nr].p = pack;
> -		packs[packs_nr].pack_int_id = pack_int_id;
> -		packs[packs_nr].bitmap_nr = pack->num_objects;
> -		packs[packs_nr].bitmap_pos = 0;
> -		packs[packs_nr].from_midx = bitmap_git->midx;
> +		if (is_pack_valid(pack)) {
> +			ALLOC_GROW(packs, packs_nr + 1, packs_alloc);
> +			packs[packs_nr].p = pack;
> +			packs[packs_nr].pack_int_id = pack_int_id;
> +			packs[packs_nr].bitmap_nr = pack->num_objects;
> +			packs[packs_nr].bitmap_pos = 0;
> +			packs[packs_nr].from_midx = bitmap_git->midx;
> +			packs_nr++;
> +		}
>  
> -		objects_nr = packs[packs_nr++].bitmap_nr;
> +		objects_nr = pack->num_objects;

And this one is the single-reuse case, where we either have a single
pack or are reusing the first pack out of a midx. We need to cover it
because you dropped the earlier check from 44f9fd6496. Makes sense.

In the long run I'm not sure there is a reason to keep this "only do
single pack reuse even if we have a midx" code path. I see it as mostly
there for testing and comparison with the new, better path. But I guess
it's possible that some repacking/midx strategies could prefer spending
more resources to possibly make better packs.

If we did get rid of that feature, then this is_pack_valid() would be
pointless (since the single path case is already covered by dc1daacdcc
(pack-bitmap: check pack validity when opening bitmap, 2021-07-23). But
it does not really hurt to leave it; if the pack has already been opened
then it is a cheap noop.

So this all looks good to me. If I nerd-sniped you into the fifo madness
that is required to trigger the race in our test suite without a code
change, I'll review what you write. But I also think it is OK to leave
it.

-Peff
