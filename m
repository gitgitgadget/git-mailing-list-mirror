Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39BD64183B5
	for <git@vger.kernel.org>; Mon, 15 Jun 2026 17:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781544589; cv=none; b=SLuhnYZQYTF49nZ5OLOjdc3vJmW6oVu/zuTwVnjp+IPwmARYiQslb7t8Ck9Zs4n6HUbTe7wnzCTURCP11YdF8jhIlI8WwLRu1p/EVpUnjY0AVlHJ7yBaN+e/RtaodP5Awikn9Hy0syjCsL7b6rdVu86DpsbcYNrm0oNCw+GM45M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781544589; c=relaxed/simple;
	bh=1T0INc/Qe5jQ9cm9ZpdZg9wigUXwrUg6huS+gNRp5Ds=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IX598QYHxpmXveJ6bbdkHrEyyoOcHCgy6KDmdWvP3wjBA+AvlB/pSo+nwgVi/npeFWsLQ14aCAZCCD91QW4Q34jvxBZIT3a7g5Th0h0thmxdf2/1Q0UOeC0uK/bvViaD0ddftkKZLtZGhTPhs29WHVPIngjUCoeDAPEdsR8co1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=dm9lx0Pt; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="dm9lx0Pt"
Received: (qmail 144322 invoked by uid 106); 15 Jun 2026 17:29:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=1T0INc/Qe5jQ9cm9ZpdZg9wigUXwrUg6huS+gNRp5Ds=; b=dm9lx0PtDn6y0RfwtuMHcIJNuRhfY+q97S5fdPxuqBhwwTDZ6HR93kJz+8omw9ByMs1UXhHg7rhkCeD5SNnD/3S1N6ITx9gKY2VgWURMGmnCIoVqO648SPESLfH4tlU/JtopnNJU+SHHBR0/EmnGOERz90uniBs79jYB1r7UJgS4VQij0j0rTTIOTn5X6d81YUhefZIUguI3bx8UsqdCAHDJSJ93OaOOwJ7b9bZkZdmTuR3b7ZvWsovxiFjqu3mSs7rYxghvHBf9UQZc85cBbeoAGpPvyzlOHtdgIw7YhHmDLl963OY2Y4jh4C3gEWR258F2eE1g/GpQya3EovYp0Q==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 15 Jun 2026 17:29:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 394563 invoked by uid 111); 15 Jun 2026 17:29:47 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 15 Jun 2026 13:29:47 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 15 Jun 2026 13:29:46 -0400
From: Jeff King <peff@peff.net>
To: Patrick Steinhardt <ps@pks.im>
Cc: Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
	Git mailing list <git@vger.kernel.org>
Subject: Re: [PATCH] builtin/history: unuse the commit buffer after use
Message-ID: <20260615172946.GD91269@coredump.intra.peff.net>
References: <20260614141600.620272-1-kaartic.sivaraam@gmail.com>
 <ai_KWo9o1Fhc6OFs@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ai_KWo9o1Fhc6OFs@pks.im>

On Mon, Jun 15, 2026 at 11:48:10AM +0200, Patrick Steinhardt wrote:

> On Sun, Jun 14, 2026 at 02:15:40PM +0000, Kaartic Sivaraam wrote:
> > While running `git history reword` using a Git built with `SANITIZE` flag set
> > to `address,leak`, we could observe the following leak being reported:
> 
> Huh, curious. That seems to hint that we're missing test coverage for
> this specific scenario, as our test suite doesn't detect this leak.

I think it will only leak when the commit object has an "encoding"
header. See below.

> > As part of rewording a commit in `git history`, we get the commit message
> > buffer in the `commit_tree_ext` function. This in turn obtains the buffer
> > from `repo_logmsg_reencode`. Given how `commit_tree_ext` is invoking the
> > function with the last two parameters as NULL, we are clearly not expecting
> > a reencode to happen. In this case, the buffer that we receive from
> > `repo_logmsg_reencode` ends up always being obtained from a call to
> > `repo_get_commit_buffer`.
> > 
> > This buffer is expected to be released with an accompanying call to
> > `repo_unuse_commit_buffer` which takes care of freeing it. This call
> > is missing in the `commit_tree_ext` flow thus resulting in the leak.
> 
> So this doesn't really read specific at all, and I would have expected
> us to hit this leak. Puzzling.

The first paragraph is accurate here. We'd generally just get a pointer
to the buffer cached in the slab, because no re-encoding occurs. And in
that case you _don't_ need to call unuse_commit_buffer(), because you
have a read-only copy, and the slab cache will hold it forever[1].
Calling the unuse function will be a noop.

But when we _do_ re-encode, then you get a new buffer which must be
freed. And that is when you have to call the unuse function. And the
reason it is "unuse" and not just "free" is that you don't necessarily
know which you have, but that function figures it out (and frees it only
if necessary).

So what the patch is doing is correct, but the explanation is a little
confused. We see the leak only when re-encoding, so we'd probably want a
test case that triggers that. Which I assume implies rewriting a commit
that was previously generated with an encoding header.

Now back to that [1] note. Even if we didn't re-encode, we'll still hold
onto that buffer forever. It's not a "leak" in the traditional sense
because it's still referenced in the commit slab cache. But if you are
going to walk over a million commits (like git-log does), you probably
don't want to hold a million commit messages in memory at once.

For that you'd want to call free_commit_buffer() when you know you're
totally done with it (again, like git-log does after it finishes showing
the commit). That might be the case here in commit_tree_ext(), or it
might happen later (I'm not familiar with the git-history code).

But note that you need to do _both_ the unuse and free calls. If we did
re-encode, the former is needed to free the newly allocated buffer. The
latter only drops the original buffer in the cache.

-Peff
