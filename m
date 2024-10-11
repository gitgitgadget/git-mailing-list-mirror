Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 109D3207217
	for <git@vger.kernel.org>; Fri, 11 Oct 2024 07:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728633295; cv=none; b=QE2Dly/orczGVsxrq/kB0/43g8uOfVdkUPCr2RQZPCklBwvmsJyqGhgb156WyWbpm+gn5Bt+EucGfpWU+Dm6Hi6hN3VORA7c15XVCGc7ZYnR/4tMEE/m9d69dy72Hg0xg8UoHDbqR+Y4U57JxErETWBx1hjpLSqYcZcQYnvGSZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728633295; c=relaxed/simple;
	bh=ArTuIvtGfDLYXAtpyZYTcH7JZeQhgEz3/DG00PLEyx0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rgKGQ2lEgKLLwG7P08VsoRQSmzrhqs6ulfUdaLAMiZoru0QAfeNdzpRB6dt4MB6M35oVe2aDiJM2A34kgtHwSkJ5uCXhJX9W5TMOWx7LsMVcX0IZkfHDv0TyUsX68Hi2I37Doip8N4aXqk9bb+GWiBSqiYDqjFreffnq6kVjltI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=LnWiloyB; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="LnWiloyB"
Received: (qmail 5158 invoked by uid 109); 11 Oct 2024 07:54:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=ArTuIvtGfDLYXAtpyZYTcH7JZeQhgEz3/DG00PLEyx0=; b=LnWiloyBsQe8ZO4RLyCnXwDalcVVXcS76xcMUpG54qXOJN6yNPnY5RnyGpGzQT9HvaYrt7239O8uE/uVQBtSEq9e1FNFNO9IP6/OL6SCavDdeYct6QTixD8+EB7zr+jnGJzuX7+9b4oGjkky74z0563BEP2XTCaCL8pCCxhInHvT7Zlr/ImTtBsmQWyK05GHyVHObq7BIQwF4OU0IjS6D8YCbaWearmcFsysVIKiMrZaHqgdXHHwbmDhK1FuWWmY8CI15YbbcBUL3zhMmIwJfyBv7bBm1VqJpAqBIg/cTjPPhVUU9LpwncfovYms5Z3QYIOG4+iE8K608hXP+D/KQA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 11 Oct 2024 07:54:52 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 17458 invoked by uid 111); 11 Oct 2024 07:54:51 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 11 Oct 2024 03:54:51 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 11 Oct 2024 03:54:51 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 00/11] pack-bitmap: convert offset to ref deltas where
 possible
Message-ID: <20241011075451.GD18010@coredump.intra.peff.net>
References: <cover.1728505840.git.me@ttaylorr.com>
 <xmqqzfnblxdj.fsf@gitster.g>
 <ZwgJt19kWVRTQhld@nand.local>
 <xmqq8quvk8w9.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq8quvk8w9.fsf@gitster.g>

On Thu, Oct 10, 2024 at 01:20:06PM -0700, Junio C Hamano wrote:

> Taylor Blau <me@ttaylorr.com> writes:
> 
> >> So when you pick the copy of Y out of another pack, what's so
> >> different?  After emitting Y to the resulting pack stream (and
> >> remembering where in the packstream you did so), when it is X's turn
> >> to be emitted, shouldn't you be able to compute the distance in the
> >> resulting packstream to represent X as an ofs-delta against Y, which
> >> should already be happening when you had both X and Y in the same
> >> original pack?
> >
> > Good question. The difference is that if you're reusing X and Y from
> > same pack, you know that Y occurs some number of bytes *before* X in the
> > resulting pack.
> >
> > But if Y comes from a different pack, it may get pushed further back in
> > the MIDX pseudo-pack order. So in that case the assembled pack may list
> > X before Y, in which case X cannot be an OFS_DELTA of Y, since offset
> > deltas require that the base object appears first.
> 
> That is what we have always done even before we started bitmap based
> optimization.  If we happen to write Y before X, we consider doing
> ofs-delta for X, but otherwise we do ref-delta for X.  We do reorder
> fairly late in the pipeline when we notice that X that we are about
> to write out depends on Y that we haven't emitted to avoid this,
> though.  All of that the bitmap-based optimization code path should
> be able to imitate, I would think.

A small nitpick on your final sentence here. As you note, we do not ever
write Y before X, because compute_write_order() always places bases
before their deltas in the output pack (and we do not allow cycles of
deltas, of course).

And even with bitmaps we'd do the same, as long as those objects are
both fed to the regular pack-writing machinery.

It is only the special verbatim-pack-reuse[1] code that is trying to
blit out the start of an existing pack that is affected. And in theory
there it _could_ try to reorder to produce an ofs delta, but in practice
the whole point is to take a single very cheap pass over the start of
the pack (or multiple packs in the case of the midx). Doing any
reordering would be counterproductive to the "cheap" adjective there (it
does not even keep a list of object ids it is sending), so we are better
to leave those objects for the regular output code (which does make such
a list).

Taylor's series introduces an in-between where we choose not to reorder,
but switch to REF_DELTA. That is still cheap on CPU on the generating
side, though the resulting pack is slightly larger.

-Peff

[1] I wish we had good names to distinguish the various cases, because
    the term "reuse" is kind of overloaded. The "slower" regular
    object-sending path may still reuse verbatim bytes found in an
    on-disk path. But this "blit out matching parts of a pack without
    otherwise considering the objects" feature happens outside of that.
    We called it "pack reuse" back in 2013, but that was not a good name
    even then. I don't have a good suggestion, though.
