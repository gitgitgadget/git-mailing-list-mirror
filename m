Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E3A31B85FC
	for <git@vger.kernel.org>; Tue, 10 Sep 2024 06:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725951217; cv=none; b=FB/RlLdXke+NZwh3Ddb7/2qWTWschOHFBIq3gGZBM4fRYi3lkHu+OaSWD/D1zoaqlUFAGHs2hnGKUj8OhSqEl0zOo2AnCA9Izv0WjAShJdfJM2zq+RbNkSx588ylu0gqSM15YPA2V8FHBwIoxM5or3BzT8PmvFRvKpXWDyprRpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725951217; c=relaxed/simple;
	bh=9ukclchDHdGquJXeh6WkoYrEhupnOooLf4s9ZMicAUU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Iu5q/EQXQTXdQ0p+gZ1uv4Xoy5GmcnMoo20rbt70yLmQq63nmQ5pSeiSE07RpLXiWrg121/mcakAeY7ZM7PLQzJ/Qvru51XtPvHk0km7hOLDz81P7RaxhH2BexgIrhPDVHgOQ6ET/2CygY6h/RSjoxpKJpIfzSECDJOJwvtnhJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 3405 invoked by uid 109); 10 Sep 2024 06:53:34 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 10 Sep 2024 06:53:34 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29216 invoked by uid 111); 10 Sep 2024 06:53:34 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 10 Sep 2024 02:53:34 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 10 Sep 2024 02:53:33 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH v3 3/9] finalize_object_file(): implement collision check
Message-ID: <20240910065333.GF1459778@coredump.intra.peff.net>
References: <cover.1725206584.git.me@ttaylorr.com>
 <cover.1725651952.git.me@ttaylorr.com>
 <0feee5d1d4fc1e0aa1ca5d98f2f404ecdbb2f6b6.1725651952.git.me@ttaylorr.com>
 <xmqqh6asv4nn.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqh6asv4nn.fsf@gitster.g>

On Fri, Sep 06, 2024 at 02:44:12PM -0700, Junio C Hamano wrote:

> > +static int check_collision(const char *filename_a, const char *filename_b)
> [...]
> 
> Two and two half comments on this function.
> 
>  * We compare 4k at a time here, while copy.c copies 8k at a time,
>    and bulk-checkin.c uses 16k at a time.  Outside the scope of this
>    topic, we probably should pick one number and stick to it, unless
>    we have measured to pick perfect number for each case (and I know
>    I picked 8k for copy.c and 16k for bulk-checkin.c both out of
>    thin air).

I can confirm that 4k was picked out of thin air by me while writing
this function. ;) It's my usual size for I/O just because it often
matches the page size. I wouldn't be surprised if other values are
faster, but I hope that this code would run pretty infrequently.

So I wouldn't worry too much about it, but if there's an obviously
better I/O size and we have a #define for it, it would make sense to use
it. I do wonder if we'd run into stack limitations at some point.

As an alternative, we could also mmap the files and then compare the
full arrays directly. That might be faster?

>  * I would have expected at least we would fstat() them to declare
>    difference immediately after we find their sizes differ, for
>    example.  As we assume that calling into this function should be
>    rare, we prefer not to pay in complexity for performance here?

I actually had the opposite thought about fstat() performance while
writing it.  In a world where you expect most name collisions to
actually have different content, then checking their sizes lets you skip
the more expensive byte-wise check. But in a world where you mostly
expect them _not_ to differ, then the size check usually does not help,
and you waste time doing it. I.e., it is a cache-miss problem with
weighted costs.

Now thinking on it more, that view is probably dumb. fstat() is really
cheap, and byte-wise comparisons are really expensive, so if it has even
a tiny chance of helping, it might be worth doing.

Though again, I'd hope this will trigger pretty rarely in practice,
because it's probably a sign that we could have skipped work earlier
(i.e., by realizing we were just going to generate an identical file,
and not generated it in the first place).

So I'd be content with just about any implementation, and waiting to see
if it ever becomes a performance pain point.

>  * We use read_in_full() and assume that a short-read return from
>    the function happens only at the end of file due to EOF, which is
>    another reason why we can do away without fstat() on these files.
> 
>  * An error causes the caller to assume collision (because we assign
>    the return value of error() to ret), which should do the same
>    action as an actual collision to abort and keep the problematic
>    file for forensics.

Yup, both of those were very intentional. :)

-Peff
