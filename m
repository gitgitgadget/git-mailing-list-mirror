Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6555E1BF4F
	for <git@vger.kernel.org>; Tue, 16 Jan 2024 15:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Received: (qmail 23479 invoked by uid 109); 16 Jan 2024 15:10:30 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 16 Jan 2024 15:10:30 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29190 invoked by uid 111); 16 Jan 2024 15:10:30 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 16 Jan 2024 10:10:30 -0500
Authentication-Results: peff.net; auth=none
Date: Tue, 16 Jan 2024 10:10:29 -0500
From: Jeff King <peff@peff.net>
To: Linus Arver <linusa@google.com>
Cc: Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/7] chunk-format: introduce `pair_chunk_expect()` helper
Message-ID: <20240116151029.GC2119690@coredump.intra.peff.net>
References: <20231109070310.GA2697602@coredump.intra.peff.net>
 <cover.1699569246.git.me@ttaylorr.com>
 <af5fe3b7237caeba8f970e967933db96c83a230e.1699569246.git.me@ttaylorr.com>
 <owly8r4qi5zj.fsf@fine.c.googlers.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <owly8r4qi5zj.fsf@fine.c.googlers.com>

On Mon, Jan 15, 2024 at 02:31:12PM -0800, Linus Arver wrote:

> > +static int pair_chunk_expect_fn(const unsigned char *chunk_start,
> > +				size_t chunk_size,
> > +				void *data)
> > +{
> > +	struct pair_chunk_data *pcd = data;
> > +	if (chunk_size / pcd->record_size != pcd->record_nr)
> > +		return -1;
> > +	*pcd->p = chunk_start;
> > +	return 0;
> > +}
> > +
> 
> I don't think this function should assume anything about the inputs
> (chunk_size, record_size, nor record_nr). If we are asking the helper to
> be the common tool for multiple locations, it should assume even less
> about what these inputs could look like.
>
> For example, if record_size is 0 this will lead to a
> divide-by-zero. Likewise, if record_nr is zero it doesn't make
> sense to check if chunk_size fits into record_size * record_nr.

I'm not sure that divide-by-zero is a big deal, because 0-length
fixed-size records do not make any sense to ask about. And even if
somebody accidentally passed 0, even though it won't be caught by the
compiler, it would barf on any input, so even rudimentary testing would
catch it.

A zero record_nr is a perfectly reasonable thing to ask about. If you
have a chunk file with zero entries for some entity, then we are
checking that the chunk is the expected zero length as well.

> And even if there are no (unexpected) zero-values involved, shouldn't we
> also check for nonsensical comparisons, such as if chunk_size is smaller
> than record_size?

Aren't we checking that already? If chunk_size is less than record_size,
then the division will result in "0". If the expected number of records
is not also 0, then that's a bogus file.

What we really care about here is that we won't walk off the end of the
buffer while looking at N fixed-size records (in that sense, the "too
big" test is overly careful, but it's easy to include as a sanity
check).

> So in summary there appear to be the following possibilities:
> 
> CHUNK_MISSING
> CHUNK_TOO_SMALL
> CHUNK_OK
> CHUNK_TOO_BIG_ALIGNED
> CHUNK_TOO_BIG_MISALIGNED

So yes, I agree all these cases exist. We detect them all except the
"misaligned" case (which I think was discussed earlier in the thread as
not worth caring too much about).

But...

> (on top of the cases where record_* inputs are zero).
> 
> And it seems prudent to treat each of the not-OK cases differently
> (including how we report error messages) once we know which category we
> fall into.

I'm not sure it is worth caring too much about the different cases. From
the caller's perspective the end result is always to avoid using the
chunk/file. From the user's perspective, any error of the form "we
expected N bytes and got X" is plenty. Especially since record_nr
typically comes from another part of the file, we cannot tell if our
chunk is too big/small, or if another chunk gave us a bogus record_nr.

-Peff
