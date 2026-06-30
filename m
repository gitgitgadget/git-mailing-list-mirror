Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE4C632A3D7
	for <git@vger.kernel.org>; Tue, 30 Jun 2026 05:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782797172; cv=none; b=d2NZesLOcWKZDLBHTOPFAgkHd1hV0Q4zsyrIfdM7g5wJsH0SevPY5IMdE3VVd/Rfy6SkuO3oTeGB8NvCaV/3hV1MFWcF5e3Mt0dKgn/TxleTpvnDIQysNck/roZdl8MK5Nm0bAMaT/vTIXHHICMAfbU5uo3ho3w8S8B2YebHOZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782797172; c=relaxed/simple;
	bh=OJncVEhTdpngDNHlqBGjODtfH5otxLwJZvGbPCHHhQk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=q+IRcuSnLdQ4dowdqadrhhYcvZDvRTvBkSaT6cfVAA2o5yQBbzp7z08OuXC4NTNZoZxIjuEMfc5Bs/OaFc5VOrZU6LWZwM2t7xOfTiUSMIub7x+ZGhkid8QMzjj40GdJaidwPxWfdhc4pFt3nTJspzPK1AdthmI5YKh4U0lJcWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=SLCgdMd6; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="SLCgdMd6"
Received: (qmail 69592 invoked by uid 106); 30 Jun 2026 05:26:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=OJncVEhTdpngDNHlqBGjODtfH5otxLwJZvGbPCHHhQk=; b=SLCgdMd6wYNV+etBfwS0f++DJphNYsNV1H0KLWevycnoMjco5AHW6CH9dywwHZp6QK+zCCMQa3ldRW+qbAZ3Mh41XsTh78JbPUvIwq8owmcdFCqCaaAHQI7pwxvtOH+a7tHoyHfAgywFrTF/Dah03XMBQk/+AlRPZSTM/C+//105R7rjHP4nMfDISa3MOaRaDh7Mr22OO1sKnyyorXDlnh6nS7QkV5dYrw+MgHodJeB1PFfVHi/Kfz1r5cwTd9VQUFOBzTvppsqUvh5XnCY/3IMXFquE7A5jt4oYiMChtKEK4jWSBOt+c3vA+LZIkLdfojkR2iPZ/mzoqMLJ5+mPOQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 30 Jun 2026 05:26:09 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 140763 invoked by uid 111); 30 Jun 2026 05:26:08 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 30 Jun 2026 01:26:08 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 30 Jun 2026 01:26:08 -0400
From: Jeff King <peff@peff.net>
To: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc: Git mailing list <git@vger.kernel.org>, Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH] builtin/history: unuse the commit buffer after use
Message-ID: <20260630052608.GA2495216@coredump.intra.peff.net>
References: <20260614141600.620272-1-kaartic.sivaraam@gmail.com>
 <ai_KWo9o1Fhc6OFs@pks.im>
 <20260615172946.GD91269@coredump.intra.peff.net>
 <317d0f7b-469f-4456-8808-506e17de264d@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <317d0f7b-469f-4456-8808-506e17de264d@gmail.com>

On Tue, Jun 30, 2026 at 09:15:49AM +0530, Kaartic Sivaraam wrote:

> > So what the patch is doing is correct, but the explanation is a little
> > confused. We see the leak only when re-encoding, so we'd probably want a
> > test case that triggers that. Which I assume implies rewriting a commit
> > that was previously generated with an encoding header.
> > 
> 
> Thank you very much for these insights! It has been helpful but on further
> digging I think this is not about reencoding. On testing and digging
> further, the leak appears to be happening when the commit that is being
> reworded we get is a freshly allocated buffer from repo_get_commit_buffer.
> I'm still trying to figure out how specific commits get cached in the slab
> while other commits don't. I'll update this thread shortly once I get an
> idea about the same.
> 
> Meanwhile, if anyone knows offhand about this, kindly chime in.

The most likely cause of an uncached commit buffer is that we loaded the
commit from the commit-graph (and thus never opened the object in the
first place, so there was nothing to cache).

I suppose it is also possible that we might create a commit struct and
then before ever calling parse_commit() on it, ask to see the commit
msg. And thus we never looked at either the commit graph nor the object
itself.

We'd also refuse to cache if save_commit_buffer is disabled (since
that's the point of that flag). If that were the case I'd expect it to
be set consistently within a given program.

So my guess is probably the commit graph, but it could be that the
command tries to format unparsed commits (which is _not_ a bug or error,
but would trigger the situation where we hand back a freshly allocated
buffer).

I suspect the leak could _also_ be caused by re-encoding, but yeah, the
root cause is "repo_logmsg_reencode gave us an allocated string", and
that can happen when re-encoding is necessary, or when we did not have a
cached buffer in the first place.

> > But note that you need to do _both_ the unuse and free calls. If we did
> > re-encode, the former is needed to free the newly allocated buffer. The
> > latter only drops the original buffer in the cache.
> 
> From my understanding, I think we may not need free_commit_buffer for the
> following reasons:
> 
> - The leak was only being reported when the commit did not come
>   from the commit slab.
> - We are not going to be reading too many commit objects into memory in
>   this code path. Hence freeing the commit in the slab isn't strictly
>   necessary.
> 
> Kindly correct me if I missed something, though.

It depends on the definition of "too many" here. ;) Probably nobody will
notice if you keep a dozen in memory, but they may if the command
happens to get thousands of commits as input. That's not likely, but if
there's an easy moment where the program can say "ah, I am done with
commit X, let's free any resources associated with it" then I think it
is worth doing.

If there isn't such an easy moment, it is probably not that big a deal
to leave it as-is. It's a rare case when somebody would notice at all,
and if you think over the implications above, a repo with an up-to-date
commit graph won't have very many cached entries in the first place.

> To conclude, I think the change that the patch proposes if fine but the
> commit message definitely needs updation.

Yep. Whether we should be calling free_commit_buffer() or not is really
an orthogonal question to the leak. If we want to do something about it,
it would be a separate patch anyway.

-Peff
