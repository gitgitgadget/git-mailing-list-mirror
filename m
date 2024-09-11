Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE4922BAE3
	for <git@vger.kernel.org>; Wed, 11 Sep 2024 06:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726036333; cv=none; b=ft9WG41mGLGgly92eiymmW+r3RDhn2KW64uTS7AE5A1QFWgHmwZtZdjdcXInl9IlZA9BV7TLCNioDc8j6C/j9InzJzDdAOoiAifaFPtQT3PBY0w5Ni4APt6fPI/EpXf3wVqQ/2Jbvj9gPSIWcFjnf/FFzhZJLwGsR71etSNo59A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726036333; c=relaxed/simple;
	bh=o3uWZmbVMeWlMdcpRiqdQmVOi/+j1e3tWpTAyrRHQkE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aaie44LY8yB+qMadJkD/fedvvmQF8T9mg2Thq20+nMJXwtSsynu6C/mslnxbQTcftthUp0tOpVgcVrOv2Q0XfEO0NY9+l+yl7abHMWMRJvjgEsfZn6wOz521MaHD8AR4Kk5nM2xtJL0yEzuJ0M2Jl2n3odvNAOXiet+ZXEvkI8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 9597 invoked by uid 109); 11 Sep 2024 06:32:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 11 Sep 2024 06:32:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 5880 invoked by uid 111); 11 Sep 2024 06:32:03 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 11 Sep 2024 02:32:03 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 11 Sep 2024 02:32:03 -0400
From: Jeff King <peff@peff.net>
To: Derrick Stolee <stolee@gmail.com>
Cc: Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>,
	Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
	git@vger.kernel.org, johannes.schindelin@gmx.de, ps@pks.im,
	johncai86@gmail.com, newren@gmail.com
Subject: Re: [PATCH 0/4] pack-objects: create new name-hash algorithm
Message-ID: <20240911063203.GA1538586@coredump.intra.peff.net>
References: <pull.1785.git.1725890210.gitgitgadget@gmail.com>
 <xmqqjzfkr9b0.fsf@gitster.g>
 <0e6dde0f-63e2-4db3-9225-9a8ca5e78eb3@gmail.com>
 <ZuBeHh7uCfhq2XBB@nand.local>
 <81139d84-b428-4019-bbd1-cda3206d2d68@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <81139d84-b428-4019-bbd1-cda3206d2d68@gmail.com>

On Tue, Sep 10, 2024 at 05:05:09PM -0400, Derrick Stolee wrote:

> > I'm not sure which value you'd actually record in the pack, though.
> > Ideally there is a hash function which captures some information about
> > the full path as well as the final path component, so we could use a
> > single value here, though I suspect the implementation would be more
> > complicated than what is presented here.
> 
> Is the name hash stored in the pack itself? I know that it is stored
> in the 'struct object_entry' data in the packing data. While we could
> add another uint32_t into that struct to store both hash values, this
> would increase the memory requirements of repacking by four bytes per
> object. The struct seemed to be very clear about trying as hard as
> possible to avoid doing that.

It's stored in the .bitmap files, since otherwise a pack-objects which
uses bitmaps to serve a fetch would have no clue of their path names.
See the "HASH_CACHE" bitmap extension.

You generally don't want to make deltas out of two entries in the bitmap
(they're already in the same pack, so we'd usually skip them), but you
do want to consider making on-the-fly deltas against other objects.

I guess we may also consider deltas between objects in two packs that
are both covered by the same midx bitmap.

> But maybe an alternative could be replacing that 32-bit number with
> an index into an array of paths that have their hash values stored
> there.

Yes, that would work, though how big is that path array going to be?
Uncompressed linux.git is probably 3-4MB, which actually doesn't sound
_too_ bad. You could obviously go a long way with prefix compression,
too.

But if I understand the proposal, it is just replacing one 32-bit hash
with another. You could just store that in the bitmap instead (or if the
direction is to use both, introduce a new extension to store both).
Obviously you'll get lousy results if the bitmap reader does not use the
same algorithm for its non-bitmap objects, but I don't think this is
something you'd be flipping back and forth on.

> This is part of the reason why I think the --full-name-hash option is
> an interesting consideration. It doesn't have any obvious reason why
> it couldn't work with features like delta islands, so it may provide
> some quick wins in "large enough" repositories, or at least "large in
> the right way".
> 
> I unfortunately don't know enough about how the delta islands feature
> works to be confident in the possibility of integrating it with the
> --path-walk option. At minimum, it would require two object walks:
> the first would mark the objects and the second would do the delta
> compression with those markings in mind.

The delta islands code already does its own tree walk to propagate the
bits down (it does rely on the base walk's show_commit() to propagate
through the commits).

Once each object has its island bitmaps, I think however you choose to
come up with delta candidates (whether the current type/size/namehash
sorted list, or some path walking), you should be able to use it. It's
fundamentally just answering the question of "am I allowed to delta
between these two objects".

Of course the devil may be in the details. ;)

-Peff
