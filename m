Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 182F218FC80
	for <git@vger.kernel.org>; Fri, 10 Jan 2025 10:38:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736505488; cv=none; b=T1uDY1PluvvlVX+i5d5KBxGXp8UQ4T523Omkp9kqSYS4jB6WXbFQujzwolS55QIERVNDMsMT/o11gIZubrEVG1uLq4dS9b7FDN8vADjR/4qpMHxqsuMQa6VNwJ5x3oHH/QZurWQkzNtRIM9QRRUCbA9ZUP/AsW2DufC/dANpmAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736505488; c=relaxed/simple;
	bh=AemW2tGbPa52KWEr4A/um1p2c3YgNhyoYCMVnoeisfI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ejiI/gTrDh2wkE3GQQZTUsL2kwNishJO0xErhRuTl9KUzCa80yoNB7Y1ytUlvsUWJyevT4IGieUIUsik7aNRAx/ORQOLQlWsBKPSIgBoJYriZq4/30Z5lP/2Hr1B8NWntZq507mLAfDz3ECj3p2JMkF1OSrNyCZ7vxEYlozjqaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=Z9djMkEV; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="Z9djMkEV"
Received: (qmail 3651 invoked by uid 109); 10 Jan 2025 10:37:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=AemW2tGbPa52KWEr4A/um1p2c3YgNhyoYCMVnoeisfI=; b=Z9djMkEVNQef+YK5B756ouZuSA07D7AomosLiHpPh/1xxce8jV65yxwdbRHTH0za5ULN60BOfV54ZCVc9a1oZfLqm0WVUOSoaM+ABEHWXv5P90PFpdS0EPQD81G6UF0A3Zx14+n3chiFqYa4IAGoVRogcFnvVRBaQNMTHld3ARTyM+xUB2LMWb50/ZJSWDI0DPf46w4R+0ak+pkwbnPbR1I5zto9w6mpmvZI+yVbr86LH56vcci2tN7qX7zs2c0NWJzHx1c+0HgW+fxCDMrWtnQHURN91rTdvmhC2x9+azDQulubuo3JPMxb25bOOMRoi/kA+9SyInj1Qq8BViETYQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 10 Jan 2025 10:37:58 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 3918 invoked by uid 111); 10 Jan 2025 10:37:57 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 10 Jan 2025 05:37:57 -0500
Authentication-Results: peff.net; auth=none
Date: Fri, 10 Jan 2025 05:37:56 -0500
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v2 7/8] csum-file: introduce hashfile_checkpoint_init()
Message-ID: <20250110103756.GA1014709@coredump.intra.peff.net>
References: <cover.1732130001.git.me@ttaylorr.com>
 <cover.1736363652.git.me@ttaylorr.com>
 <94c07fd8a557c569fdc83015d5f3902094f21994.1736363652.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <94c07fd8a557c569fdc83015d5f3902094f21994.1736363652.git.me@ttaylorr.com>

On Wed, Jan 08, 2025 at 02:14:51PM -0500, Taylor Blau wrote:

> Introduce and use a new function which ensures that both parts of a
> hashfile and hashfile_checkpoint pair use the same hash function
> implementation to avoid such crashes.

That makes sense. This should have been encapsulated all along, just
like the actual hash initialization happens inside hashfile_init().

A hashfile_checkpoint is sort of inherently tied to a hashfile, right? I
mean, it is recording an offset that only makes sense in the context of
the parent hashfile.

And that is only more true after the unsafe-hash patches, because now it
needs to use the "algop" pointer from the parent hashfile (though for
now we expect all hashfiles to use the same unsafe-algop, in theory we
could use different checksums for each file).

So in the new constructor:

> +void hashfile_checkpoint_init(struct hashfile *f,
> +			      struct hashfile_checkpoint *checkpoint)
> +{
> +	memset(checkpoint, 0, sizeof(*checkpoint));
> +	f->algop->init_fn(&checkpoint->ctx);
> +}

...should we actually record "f" itself? And then in the existing
functions:

>  void hashfile_checkpoint(struct hashfile *f, struct hashfile_checkpoint *checkpoint)

...they'd no longer need to take the extra parameter.

It creates a lifetime dependency of the checkpoint struct on the "f" it
is checkpointing, but I think that is naturally modeling the domain.

A semi-related thing I wondered about: do we need a destructor/release
function of some kind? Long ago when this checkpoint code was added, a
memcpy() of the sha_ctx struct was sufficient. But these days we use
clone_fn(), which may call openssl_SHA1_Clone(), which does
EVP_MD_CTX_copy_ex() under the hood. Do we have any promise that this
doesn't allocate any resources that might need a call to _Final() to
release (or I guess the more efficient way is directly EVP_MD_CTX_free()
under the hood).

My reading of the openssl manpages suggests that we should be doing
that, or we may see leaks. But it may also be the case that it doesn't
happen to trigger for their implementation.

At any rate, we do not seem to have such a cleanup function. So it is
certainly an orthogonal issue to your series. I wondered about it here
because if we did have one, it would be necessary to clean up checkpoint
before the hashfile due to the lifetime dependency I mentioned above.

-Peff
