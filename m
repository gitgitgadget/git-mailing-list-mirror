Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0EF43C684
	for <git@vger.kernel.org>; Fri, 10 Nov 2023 21:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1857131
	for <git@vger.kernel.org>; Fri, 10 Nov 2023 13:52:56 -0800 (PST)
Received: (qmail 15109 invoked by uid 109); 10 Nov 2023 21:52:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 10 Nov 2023 21:52:56 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 922 invoked by uid 111); 10 Nov 2023 21:52:58 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 10 Nov 2023 16:52:57 -0500
Authentication-Results: peff.net; auth=none
Date: Fri, 10 Nov 2023 16:52:55 -0500
From: Jeff King <peff@peff.net>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 6/9] commit-graph: use fanout value for graph size
Message-ID: <20231110215255.GF2758295@coredump.intra.peff.net>
References: <20231109070310.GA2697602@coredump.intra.peff.net>
 <20231109072435.GF2698043@coredump.intra.peff.net>
 <ZU1NNcP/ARxK6D89@nand.local>
 <20231109213813.GB2728242@coredump.intra.peff.net>
 <ZU1Z6WUrEhcxLBTO@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZU1Z6WUrEhcxLBTO@nand.local>

On Thu, Nov 09, 2023 at 05:15:05PM -0500, Taylor Blau wrote:

> > This is one of the ways that pair_chunk_expect() could do better without
> > adding a lot of code, because it can check the return value from
> > read_chunk(). It doesn't help the other cases (like OIDF) that still
> > have to call read_chunk() themselves, though. Possibly read_chunk()
> > should just take a flag to indicate that it should complain when the
> > chunk is missing. And then callers could just do:
> >
> >   if (read_chunk(cf, id, our_callback, CHUNK_REQUIRED)
> > 	return -1; /* no need to complain; either our_callback() did, or
> > 	              read_chunk() itself */
> 
> We do return CHUNK_NOT_FOUND when we have a missing chunk, which we
> could check for individually. But TBH, I don't find the first error all
> that useful. In this instance, there's really only one way for the OIDL
> chunk to be corrupt, which is that it has the wrong size.

But aren't there two ways it can go wrong? It can be the wrong size, or
it can be missing. In the first we say:

  error: wrong size
  error: missing or corrupted

and in the second we say:

  error: missing or corrupted

Which is why I think issuing a message from the callback has value. Of
course the ideal would be:

  error: wrong size

and:

  error: missing

but I didn't think it was worth making the code much longer for an error
condition we don't really expect anybody to see in practice.

And also...

> And short of making the error much more robust, e.g.:
> 
>     error: commit-graph OID lookup chunk is the wrong size (got: $X, wanted: $Y)

...yes, I think that would be worth doing, especially if you are
centralizing the error messages in pair_chunk_expect(). But your series
goes the opposite direction.

> and dropping the generic "missing or corrupt" error, I think that just
> the generic error is fine here.

If you drop that error, then who will warn about the missing-chunk case?
The user would see nothing at all.

-Peff
