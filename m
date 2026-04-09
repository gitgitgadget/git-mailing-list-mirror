Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF2273A8F7
	for <git@vger.kernel.org>; Thu,  9 Apr 2026 20:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775766213; cv=none; b=DkbfBJo4OnqCFo5N3HTnkLLoGgZ6OZxZ2C9gUwVC1FaTo61Nx1Xb2H/Zs98Zj9LrNXBeRz7odUTe1M+DvorpvjVuTAKHeyWOeSEDlwCBdRQ8iDCs/GG8H0KJg4wbyQGlSYkUnV6rEV0y2K88O69PfBOLlSniUJU/EMrr9OVOFEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775766213; c=relaxed/simple;
	bh=f3m2hOkQEDiyKRyKqRoivQq99XrSCZ9E+oSmT2kB0uI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UM3qjsSbsi1/NYJ3Lmu1tAwR0hAl4ooA6uLrGJfcBgBlOSn9ao6IUEPBLN6/ykMCStLf05Yfk3oRe45ePk/8lgABSe7aNljC4Ddz7mcxbJ6C7ZF4DPzGmyoJf7Bnm0/hJNAdiRFJQXDEYNULKP4CzLO4CzDFZQ+OXcv1wVxtXx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=EqGnEAe9; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="EqGnEAe9"
Received: (qmail 294793 invoked by uid 106); 9 Apr 2026 20:23:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=f3m2hOkQEDiyKRyKqRoivQq99XrSCZ9E+oSmT2kB0uI=; b=EqGnEAe9vz0zUzwiy0G7M5jHURSg4D0AuIuvfyoXRKGL4IJgZPNmc5QgeBwT6bju2AgGdHTiBGK/zldKQZ2IqSOMRRajfeKH/rzPnpoXIGkQAedQ3WCMqlQe96UFgZe2gk6GucN/BPHsKS5gh3s9NcTkG33hN4T0WVTYNORf/mcqDFvy+oNyoJlEPHSY6z2t0l8ljk7bFJq9ZgbJYkr2XstDvT7S/VODzkz/kyoCyFdlTUuB4iA2jbTymNBZJP+5718ZqJldyywvrTv/wIH2HRfGdSGB8OrDKbARRYRUVjCFzpHVlaQNvc8T+OUxx/MknPJUlRgy6HFe4n+HaCIK2w==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 09 Apr 2026 20:23:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 487231 invoked by uid 111); 9 Apr 2026 20:23:29 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 09 Apr 2026 16:23:29 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 9 Apr 2026 16:23:29 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	"Randall S. Becker" <randall.becker@nexbridge.ca>,
	Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH] wrapper: properly handle MAX_IO_SIZE in `write_in_full()`
Message-ID: <20260409202329.GA3076846@coredump.intra.peff.net>
References: <20260409-b4-pks-writev-max-io-size-v1-1-81730e8f35df@pks.im>
 <xmqqika0ultp.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqika0ultp.fsf@gitster.g>

On Thu, Apr 09, 2026 at 09:42:42AM -0700, Junio C Hamano wrote:

> > +	for (i = 0, total_length = 0; i < iovcnt; i++) {
> > +		if (unsigned_add_overflows(total_length, iov[i].iov_len))
> > +			break;
> 
> We add .iov_len up in this first loop, because we do not want to
> bust writev(3p)'s limit.
> 
> 	EINVAL The sum of the iov_len values in the iov array would
>               overflow an ssize_t.
> 
> cf. https://pubs.opengroup.org/onlinepubs/9799919799/functions/writev.html
> 
> As the width of ssize_t in bits can be a lot smaller than size_t,
> the above "unsigned_add_overflows() triggers way too late for the
> check to matter, no?

I think it is correct as-is.

The real check against ssize_t is later, when we compare total_length to
MAX_IO_SIZE (which is clamped to SSIZE_MAX). So this is just making sure
we do not overflow size_t when counting up the total (and if we do, we
_know_ we are going to overflow ssize_t, which must be smaller).

I think this can be made more clear by counting down allowable bytes
instead of up. I'll show an example in a second.

> > +	}
> > +
> > +	if (i < iovcnt) {
> > +		/*
> > +		 * The first entry exceeds MAX_IO_SIZE, so we pass it to
> > +		 * xwrite, which knows to handle this case.
> > +		 */
> > +		if (!i)
> > +			return xwrite(fd, iov->iov_base, iov->iov_len);
> 
> Ben has a similar comment, but it would be easier to see the
> correspondence if you rephrase the comment perhaps like
> [...]

Me three. I think this can be made more clear if we bail to xwrite()
immediately in the loop. So together with the count-down, something
like:

   ssize_t allowed = MAX_IO_SIZE;
   int i;

   for (i = 0; i < iovcnt; i++) {
	if (iov[i].iov_len > allowed) {
		if (!i)
			return xwrite(fd, iov->iov_base, iov_len);
		break;
	}
	allowed -= iov[i].iov_len;
  }
  return writev(fd, iov, i);

You can also directly return writev() instead of breaking out of the
loop. That makes it even more clear that we are doing a partial write,
but means duplicating the "return writev()" line.

And I think the whole thing would still deserve comments, but I omitted
them here since the point was to show the rearranged structure.

-Peff
