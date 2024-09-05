Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 112C619EEA0
	for <git@vger.kernel.org>; Thu,  5 Sep 2024 20:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725568032; cv=none; b=Ej/rL8dJ/3YwLZRmNZbuFL/bhy+nN5jKt5GS69fkgQ8cRVYfS9oymN9XJP92Z74KN6wYoLSHPfPcE47JBhQNKr8Wt1BYiTStNPqkhkL2tzmH6GBGzfRTkdmfr9IojfgyLyFvscjkHZucJAlHLXeZgnkcqp6UmQ+xEPlI8S+vn5s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725568032; c=relaxed/simple;
	bh=q6JqGQl10/gUu6ni5B8a83fybg4ExGCm8Nkgx8hge3Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TaAG0cAeBZnM5aTbQNFRO6HKigey2ewZfbSdialECWGcrx0akA9EbE9gYrarRFN+ULkQWy8F2iiJ3STfctwzRp7hs3TY0d7GIpMbnjplU+k1bs3LGAuaqUM8Hn/RtisqGqPLemHcJEDqKHwecW9wikRoBieefJbJ6rvHg2flBAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 13214 invoked by uid 109); 5 Sep 2024 20:27:09 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 05 Sep 2024 20:27:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12829 invoked by uid 111); 5 Sep 2024 20:27:08 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 05 Sep 2024 16:27:08 -0400
Authentication-Results: peff.net; auth=none
Date: Thu, 5 Sep 2024 16:27:07 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	git@vger.kernel.org, Elijah Newren <newren@gmail.com>,
	Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 0/4] hash.h: support choosing a separate SHA-1 for
 non-cryptographic uses
Message-ID: <20240905202707.GA2602440@coredump.intra.peff.net>
References: <cover.1725206584.git.me@ttaylorr.com>
 <ZtXG2cEbxr8pNg7j@tapette.crustytoothpaste.net>
 <Ztdn25zfi8WHO+GS@nand.local>
 <20240905103736.GC2556395@coredump.intra.peff.net>
 <xmqq34me5crn.fsf@gitster.g>
 <ZtnbFXL7W5DvW8UN@nand.local>
 <xmqq34me3uyz.fsf@gitster.g>
 <ZtnkovOqrJNxUtez@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZtnkovOqrJNxUtez@nand.local>

On Thu, Sep 05, 2024 at 01:04:34PM -0400, Taylor Blau wrote:

> On Thu, Sep 05, 2024 at 09:51:00AM -0700, Junio C Hamano wrote:
> > Taylor Blau <me@ttaylorr.com> writes:
> >
> > > If so, I agree, but would note that this series does not yet switch
> > > index-pack to use the non-collision detecting SHA-1 implementation when
> > > available, so that would not be a prerequisite for merging this series.
> >
> > Hmph, I am confused.  It needs to be corrected in order to address
> > collisions of the tail sum Peff raised, as no longer checked the
> > tail sum with SHA1DC but with "fast" SHA-1.
> 
> Peff's mail supposes that we have already modified index-pack to use the
> non-collision detecting SHA-1 implementation. But this series does not
> do that, so I don't think we have an issue to address here.

Yes, this is correct. You are modifying only the writing side (which of
course would be under attacker control in this scenario anyway). So we
are only getting the benefit there, but without any additional threat on
the reading side.

But I'm not sure how comfortable I am leaving us in that state, even if
it is by itself OK. It feels fragile, and we're a small step away from
somebody accidentally using the "fast" variant to do reading.

If it's possible to fix the overwrite issue without too much code (and I
think it probably is), then that leaves us in a much safer spot, even
with what's in your series. And the fact that it lets us speed up the
reading side _and_ opens the door to possible alternate-hash
improvements is the cherry on top.

  Side note: I do really like the xxHash direction in general, but I
  think we may be underestimating the difficulty. Obviously it needs a
  protocol extension for sending packfiles, but what about other
  cross-repo access? E.g., dumb http blindly downloads the packfiles.
  How does it learn which hash is in use?

-Peff
