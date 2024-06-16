Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C880C16C6A4
	for <git@vger.kernel.org>; Sun, 16 Jun 2024 04:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718513984; cv=none; b=W88mCds+CRk4X8UVKMSAOTnHOfJx4Lv9LyHh1tTRpCFkka4BfNm5HnEMSZz7Ek/eNu7Z/8lqpNUOUQI2G6z6CnQCCfUwCRmsEUJYfqWlVt4WZk2L45pIMTXZi06M3TPu79/BwkD8AdxujNzdpxtb0cJO+byyYLbRm91cFnthJPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718513984; c=relaxed/simple;
	bh=lh1/it1ZRa+ZatnPEhyVEePwMC9TGtsSmENhJkDBNVY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MSaLD7QvaGqDN3IRfnDJVfCVlQ+chlt27PAgQmSMOQzWyhaj/ZE5H/zkvhnW7lNvHr/PPAGEpBtqw51nceG+GObjBCSJ35jEl+xW9WLu9cgHMvlZfhxdFJqXFm1qEgcG4B32TPpi1jxcnXZlx+fEWlxxtczvHkT4XN7nxT5U4Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 2618 invoked by uid 109); 16 Jun 2024 04:53:01 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Sun, 16 Jun 2024 04:53:01 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14734 invoked by uid 111); 16 Jun 2024 04:52:58 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 16 Jun 2024 00:52:58 -0400
Authentication-Results: peff.net; auth=none
Date: Sun, 16 Jun 2024 00:52:59 -0400
From: Jeff King <peff@peff.net>
To: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Christian Couder <christian.couder@gmail.com>,
	Patrick Steinhardt <ps@pks.im>, ach.lumap@gmail.com,
	chriscool@tuxfamily.org, git@vger.kernel.org,
	kaartic.sivaraam@gmail.com
Subject: Re: [PATCH v3 2/3] t/: port helper/test-sha1.c to unit-tests/t-hash.c
Message-ID: <20240616045259.GA17750@coredump.intra.peff.net>
References: <20240229054004.3807-1-ach.lumap@gmail.com>
 <20240523235945.26833-1-shyamthakkar001@gmail.com>
 <20240523235945.26833-3-shyamthakkar001@gmail.com>
 <ZlCWcpcUkgUMWJYz@tanuki>
 <CAP8UFD1=yjZEZWvMYKq1RyY8fMSHze4XcLbCZMSFhCLBheaM+w@mail.gmail.com>
 <xmqqo78vnrba.fsf@gitster.g>
 <6fhpz4aqq7jr6ca2durig7e5a37g6ndzjjc2v46kjjkldohtja@tu7cdo4tu2r6>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6fhpz4aqq7jr6ca2durig7e5a37g6ndzjjc2v46kjjkldohtja@tu7cdo4tu2r6>

On Sun, Jun 16, 2024 at 01:44:07AM +0530, Ghanshyam Thakkar wrote:

> On Fri, 24 May 2024, Junio C Hamano <gitster@pobox.com> wrote:
> > Christian Couder <christian.couder@gmail.com> writes:
> > 
> > >> Can we refactor this test to stop doing that? E.g., would it work if we
> > >> used git-hash-object(1) to check that SHA1DC does its thing? Then we
> > >> could get rid of the helper altogether, as far as I understand.
> > >
> > > It could perhaps work if we used git-hash-object(1) instead of
> > > `test-tool sha1` in t0013-sha1dc to check that SHA1DC does its thing,
> > > but we could do that in a separate patch or patch series.
> > 
> > Yeah, I think such a plan to make preliminary refactoring as a
> > separate series, and then have another series to get rid of
> > "test-tool sha1" (and "test-tool sha256" as well?) on top of it
> > would work well.
> 
> It seems that git-hash-object does not die (or give an error) when
> providing t0013/shattered-1.pdf, and gives a different hash than the
> one explicitly mentioned t0013-sha1dc.sh. I suppose it is silently
> replacing the hash when it detects the collision. Is this an expected
> behaviour?

The shattered files do not create a collision (nor trigger the detection
in sha1dc) when hashed as Git objects. The reason is that Git objects
are not a straight hash of the contents, but have the object type and
size prepended.  One _could_ use the same techniques that created the
shattered files to create a colliding set of Git objects, but AFAIK
nobody has done so (and it probably costs tens of thousands of USD,
though perhaps getting cheaper every year).

So no, git-hash-object can't be used to test this. You have to directly
hash some contents with sha1, and I don't think there is any way to do
that with regular Git commands. Anything working with objects will use
the type+size format. We also use sha1 for the csum-file.[ch] mechanism,
where it is a straight hash of the contents (and we use this for
packfiles, etc). But there's not an easy way to feed an arbitrary file
to that system.

It's possible there might be a way to abuse hashfd_check() to feed an
arbitrary file. E.g., stick shattered-1.pdf into a .pack file or
something, then ask "index-pack --verify" to check it. But I don't think
even that works, because before we even get to the final checksum, we're
verifying the actual contents as we go.

So I think we need to keep some mechanism for computing the sha1 of
arbitrary contents.

-Peff
