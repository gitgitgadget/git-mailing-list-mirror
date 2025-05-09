Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFCEF23237B
	for <git@vger.kernel.org>; Fri,  9 May 2025 15:59:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746806379; cv=none; b=EwL7lPkombQQkugp+02+yLF3H8x5ew+Og3M9YZjVf0b5O/zbLGKuiejrAW5OW6gF1gI3xmSLhZKDCjykchwrNiNqULFVbwmEWWVef8Udf5gO+7BSsPjiTCONbsgGUp+mGvyzcLvFuluOXObnqFoirSeAq77FCzxnQDGAdsnQJsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746806379; c=relaxed/simple;
	bh=A0ZcBS+u8Oa59gmZ62YdGgKIjKRd+nqFsGX0/ileQco=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BAeStZZWEadGF/Hy99VjcQBuBoBEeI2zU78X+Ze5Ktv734ii8h+dINqXyWywHeyttkFuSDm3t9ICwtJMAHHQH1AZwCk0AlOqHTXtn+DIj95yur+/pJl1MpQJTULtx0Eaps6efUwCrWxjLoXBWI32ICG7vJewYo4X1kDVtkK+va0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=UfNHC0dv; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="UfNHC0dv"
Received: (qmail 3697 invoked by uid 109); 9 May 2025 15:59:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=A0ZcBS+u8Oa59gmZ62YdGgKIjKRd+nqFsGX0/ileQco=; b=UfNHC0dvReAsZi6yQiKGPjOs7oqSFKcBd3AAd2WTq7cDO8Hp90WnfFPNZ3UDpoTW2qOYLZ9RB6Nev4KQgVISE6hnqEifW8cJKYYnu+UU/eVZt709bCNdp4vLlzNJPaczOwfT6zHyjwMDWxBY45Oi8hdLmK6QqLyKtjVz7d2ggh0mHvjo3QqqsMMe7bE0q7X2ZK+dfAsgjd1/xR7qzbVMTGwCt8dhcMBnfzqRDAA+2vdte9UZdd5sCTnHAcIOGreA1C/2N4Y03jgLLgWDeq2ufsryj7/oM86WCS7KJNYG3jMZqdWR5D9taRJ5Q2aKrrp7XUE+BvNYWvSj2RDkqrx25A==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 09 May 2025 15:59:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32668 invoked by uid 111); 9 May 2025 15:59:36 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 09 May 2025 11:59:36 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 9 May 2025 11:59:34 -0400
From: Jeff King <peff@peff.net>
To: shejialuo <shejialuo@gmail.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v2 4/4] packed-backend: mmap large "packed-refs" file
 during fsck
Message-ID: <20250509155934.GA25686@coredump.intra.peff.net>
References: <aBtzn4nwLsI9p5Cp@ArchLinux>
 <aBt0C8gdBecq5f8U@ArchLinux>
 <20250508200741.GB18229@coredump.intra.peff.net>
 <aB4dflpFNW4mJlq6@ArchLinux>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aB4dflpFNW4mJlq6@ArchLinux>

On Fri, May 09, 2025 at 11:21:34PM +0800, shejialuo wrote:

> > > -	struct strbuf packed_ref_content = STRBUF_INIT;
> > > +	struct snapshot *snapshot = xcalloc(1, sizeof(*snapshot));
> > 
> > Minor, but is there any reason to allocate this here and not just:
> > 
> >   struct snapshot snapshot = { 0 };
> > 
> > ?
> 
> I simply copy the code from the existing code... I will change.

Ah, I see. The existing code must allocate on the heap because it is
returning the snapshot to its caller. But here the variable is
completely local to the function.

However, if we stop using mmap_strategy altogether and just use xmmap()
directly, I don't think you'd even need a snapshot variable.

> > Why are we unmapping here before we use the content? That will create an
> > allocated in-memory copy of the mmap'd content. I thought the whole
> > point here was to avoid doing so.
> > 
> 
> I simply follow how "create_snapshot" does. Actually, I am also quite
> confused about this. If we would eventually copy the content into the
> user space's memory. What is the reason that we mmap at Windows in the
> first place?
> 
> My understanding is that after mmaping, we need to do some sanity checks
> and then if there is a need, we may sort the "packed-refs" file. So, we
> would improve some efficiency at Windows for this part?

Ah, yes, that makes sense for the existing code. If we do have to sort,
then mapping on Windows means we could sort into our internal buffer,
saving an extra copy. That is probably a rare case these days (once upon
a time the file was not guaranteed to be sorted, but these days the
writer makes sure it is sorted and puts a marker in the header claiming
it is so). So maybe that approach is not as useful as it once was, but I
don't know if it's worth spending effort to rip it out now.

I don't think any of that applies for packed_fsck(), though, since it is
just processing the file linearly in that case (rather than making a
sorted copy).

-Peff
