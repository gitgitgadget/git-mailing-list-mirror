Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3703B22DC21
	for <git@vger.kernel.org>; Tue, 14 Jan 2025 09:30:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736847003; cv=none; b=VSfI9/TiODIJgWgBaoGeSWe6j18a4bLsySl5T2RCu5gk56QkFRbKCvnpi6dBfKofejv000ncr872vg108szaHLdKDHdWsshZEapDtniYxu4IakSGht7ySg0cKYgDLiOTrmhYGgiranIpqGvCCwpmXFLhdYFkKX8ENHSat5sJW9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736847003; c=relaxed/simple;
	bh=DIOr12UL8o++EU6kSQ1A4veGQwEEo0Nq2GAUlWJfDRE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k0/KnGf36Yh82JXm6tmbOm2ri3tD3276rZdonwUjRRQbv3BvqQ+dNjDthOI65Ak3O2nT46kltpgMTcHDDjCJTxeYiPfXN7AmnzrHF1wzn75KWn3vEDxp9qq+TntatcYJ2UZFbYYcDCeyba5Kbv8oy6TIgCI2KZiksSSMv45T1s0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=BWZeLWt8; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="BWZeLWt8"
Received: (qmail 27151 invoked by uid 109); 14 Jan 2025 09:30:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=DIOr12UL8o++EU6kSQ1A4veGQwEEo0Nq2GAUlWJfDRE=; b=BWZeLWt8xa2viFzEJ8ac+4ZmIuuGnywnYxLqDs/h2qorONh4X4zrSGcTMU0Vaty/TN9Sw89Kod5NQqvXrXjS9TEdjPPbm2DTtw/bJoRiXIrZX7krpv9qYOTOrCVmRKqnWlwUdeQ0EehbqCJv31KZB/zEf+gcLBUg5/1bQDaNt5LmJlEq9+QS74nDqdH3dkJWgmfLR2MVd45wRwMmrTUrnJYeaoFBHaA3zQx4pCf2vgFliymlV4pNmVmt3WInSn71zXJnd8gWYpviSqkxUfRNK2KgOj+x0bG8z746j7pyuJU5RwmYXxne4IJWbDN8MKbAZ6Gx7u96INC2NoGEl9MaTQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 14 Jan 2025 09:30:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 4780 invoked by uid 111); 14 Jan 2025 09:30:04 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 14 Jan 2025 04:30:04 -0500
Authentication-Results: peff.net; auth=none
Date: Tue, 14 Jan 2025 04:29:59 -0500
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
	Wink Saville <wink@saville.com>
Subject: Re: [PATCH 02/14] combine-diff: add combine_diff_path_new()
Message-ID: <20250114092959.GB882468@coredump.intra.peff.net>
References: <20250109082723.GA2748497@coredump.intra.peff.net>
 <20250109083236.GB2748836@coredump.intra.peff.net>
 <Z4Uz43eByZHqW8UK@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z4Uz43eByZHqW8UK@pks.im>

On Mon, Jan 13, 2025 at 04:40:19PM +0100, Patrick Steinhardt wrote:

> > +struct combine_diff_path *combine_diff_path_new(const char *path,
> > +						size_t path_len,
> > +						unsigned int mode,
> > +						const struct object_id *oid,
> > +						size_t num_parents)
> > +{
> > +	struct combine_diff_path *p;
> > +
> > +	p = xmalloc(combine_diff_path_size(num_parents, path_len));
> > +	p->path = (char *)&(p->parent[num_parents]);
> > +	memcpy(p->path, path, path_len);
> > +	p->path[path_len] = 0;
> > +	p->next = NULL;
> > +	p->mode = mode;
> > +	oidcpy(&p->oid, oid);
> > +
> > +	memset(p->parent, 0, sizeof(p->parent[0]) * num_parents);
> > +
> > +	return p;
> > +}
> 
> If I were to write this anew I'd probably use `xcalloc()` instead of
> manually `memset()`ing parts of it to zero. But it's a faithful
> transplant of the code from `intersect_paths()`, so that's probably
> okay.

Yeah, I actually wrote it that way originally (thinking the issue was
that we were leaving uninitialized fields all over), before realizing
that most callers were explicitly zero-ing the parents. So I went for
the minimal change.

From an efficiency standpoint, I don't know that it matters much between
the two (xcalloc would zero some fields which we're going to assign
anyway, but the zeroing may be more efficient on the backend). xcalloc
means you'd never forget to initialize any part of it, so maybe it's
more readable / less error prone?

We could do a patch on top, but I doubt it's a big deal either way.

-Peff
