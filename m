Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4919A1FBC9A
	for <git@vger.kernel.org>; Fri, 21 Feb 2025 06:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740119984; cv=none; b=d4HJpNWs/iMbxxziB7R/2xTVtgjUfJWmBYpiZoVZvceeZoYWsaCYy4H2f0WTuSY21qqfQnkXHXw2PtjK2OsBkF6PMosdjihA/uzWn3yTQ7vSrMl6SVRf3Ey67IGEUNoLEWwJgD5OKXx4GQfuEQlKgtNvcmWE+W6leRySyLdsBxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740119984; c=relaxed/simple;
	bh=dErrAXSodP0GZT5TsV53JUUl9zAVzMy2h6J0givjDCs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SOCh6C+pnHuNzLVG/U5a91ItPYGeM95sIA0r0FYAH33d47kUFDdr6QBpVNErHHhTH0a4tUkeH52Yx9OOXQ6DWrmTiIqCNfSNeEZeCW/SMFAkQBWsB1/d6vYvKf0Mns8icJ9ZYtjyhHP9P++qosE2Gtt2OoNYsp2SG8arSTcofF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=R9QJywA8; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="R9QJywA8"
Received: (qmail 2743 invoked by uid 109); 21 Feb 2025 06:32:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=dErrAXSodP0GZT5TsV53JUUl9zAVzMy2h6J0givjDCs=; b=R9QJywA8+qb39U2+z+/gcV9XzzaRPdNXHljv7NWzy0oP9M4fskoGEqMGOEUfl/RGzrTVeBXPWNbijLhNVhUbWjkif9dBXvvEM4eTm/3BL4NRN/gXuTavNXZvtgHB5dkP3Wi6Mc5JhwnyDwi50uEJzbNo/87XmMDo6iDC7sGB3IB00oFp7qei8Ntluue3MsiOIhUHROETP5287w7CQlIFSx2Sfm60030W6yclROdVYsai5TVZjJfhJJeAMBpIidUQ7kdp3ggUwFLZpRLpPyOd6zNSyqirvnyP/4gZ8McDWPOM5htuxml9B91vv8ascr9Gr2hOkshRQD8AjRa6pq5Kyg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 21 Feb 2025 06:32:59 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 30197 invoked by uid 111); 21 Feb 2025 06:32:58 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 21 Feb 2025 01:32:58 -0500
Authentication-Results: peff.net; auth=none
Date: Fri, 21 Feb 2025 01:32:57 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Meet Soni <meetsoni3017@gmail.com>, git@vger.kernel.org,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Patrick Steinhardt <ps@pks.im>, Calvin Wan <calvinwan@google.com>,
	Elijah Newren <newren@gmail.com>
Subject: Re: [GSoC][RFC PATCH] show-branch: use commit-slab for flag storage
Message-ID: <20250221063257.GA568823@coredump.intra.peff.net>
References: <20250217055049.9217-1-meetsoni3017@gmail.com>
 <xmqqseobksfe.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqseobksfe.fsf@gitster.g>

On Tue, Feb 18, 2025 at 10:40:21AM -0800, Junio C Hamano wrote:

> > +static int get_commit_flags(struct commit *commit)
> > +{
> > +	int *result = commit_flags_peek(&commit_flags, commit);
> > +	return result ? *result : 0;
> > +}
> > +
> > +static void set_commit_flags(struct commit *commit, int flags)
> > +{
> > +	*commit_flags_at(&commit_flags, commit) = flags;
> > +}
> 
> ... it does not make much sense to use the slab mechanism if we are
> still limited to bitsizeof(type(flags)).  If your "int" is 32 bit,
> and the command line fed 100 revs, we'd want a flags parameter that
> can house at least 100 bits passed into the "set" function, and
> yields the result that can hold at least 100 bits from the "get"
> function.  I'd expect that the interface would be more like
> 
>     static int get_commit_flags(struct commit *commit, unsigned flags[]);
>     static int set_commit_flags(struct commit *commit, unsigned flags[]);
> 
> with a file-scope static variable signaling how many bits we are
> dealing with (allowing these functions to infer how many words
> flags[] array has), and the return values from these helpers to
> indicate success (with 0) and failure (with a negative value).  On a
> 32-bit platform, you'd need at least 4 words in flags[] array to
> deal with 100 revs.  On a 64-bit box, 2 words would be sufficient.
> 
> I would imagine that we would need two more helpers
> 
>     static int set_flag_bit(unsigned flags[], unsigned n);
>     static int get_flag_bit(unsigned flags[], unsigned n);
> 
> to query the n-th bit in a set of bits stored in flags[] array.

Yeah. I did not see the word "stride" anywhere in your email, so I
wanted to provide a further hint: the commit-slab "_with_stride()"
variant is meant to handle this kind of arbitrary-sized data. This was
part of the original commit-slab implementation in a84b794ad0
(commit-slab: introduce a macro to define a slab for new type,
2013-04-13), but AFAIK we've never actually used it in practice. See
that commit for some examples.

-Peff
