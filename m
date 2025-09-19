Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB011F099C
	for <git@vger.kernel.org>; Fri, 19 Sep 2025 16:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758300506; cv=none; b=YKcqZPUPCZNdYJLevyT4x+Eng4+9tycmfBi7s/06XozR+KBrrSeL9kWvOGEe1/QkvK7dx55JCSeCoXPNOiWYUye1Xu7+DtQsh4O58IwgYkGThfwQRWk6a/UKizCXRwUJjxDtdFBZuVyOm/FbnDlWBNL4ibRSAkuu4/NeNEBIf8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758300506; c=relaxed/simple;
	bh=ow/5mbzqD5JC3ASXI0CtwFl7OUIr9NQ/qC616czmX5w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hkoCSFkA8gzQANdPxUoOmixfaTfkbmYi/8KrS+G0YrJkDOaU4peZT8ydicZyfHcFA46FjeKRFEsoiFhJvplMNTA7juUMc6Vc79naA0lB5T0wMP4v7ixR9xSKkEz+bTd77Wdnzalyyo17kF/6p/v9PkwRKQSRjEkKaqi/1UmovsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=DcGN7d3K; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="DcGN7d3K"
Received: (qmail 131613 invoked by uid 109); 19 Sep 2025 16:48:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=ow/5mbzqD5JC3ASXI0CtwFl7OUIr9NQ/qC616czmX5w=; b=DcGN7d3K1FgGpMIzc1JIjUEM3HcQgjUV39aYEg0oA9LudecFntsGjm1ZL53dAQv8yBUPhYs4azXZQ6ejZh3SPw9dH8vcqUWo7uN0njDJ92rXQBPvdyX8N+oqXVGXfYfE2BR5eoIaVToI+FTQzZPzbtY6oKht5pA/eNma8NkryN67ojIhXJHIkUpDJMnGtHOurhRsT9d6bl0KqgyC9leG3a9+1N8iemXYUo/JVoHN+JJJAfnTSzkJA3cgtvccTj9afFW0+Zdf4UkIiOwiNbCquCPkzHlaTiTTf4Kh6j0OKOtd0v7/n1hEe5oS0fZzhaDeFZjqy/lp10ocurySElBEYQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 19 Sep 2025 16:48:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 207779 invoked by uid 111); 19 Sep 2025 16:48:20 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 19 Sep 2025 12:48:20 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 19 Sep 2025 12:48:20 -0400
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Lauri Niskanen <ape@ape3000.com>, git@vger.kernel.org,
	Patrick Steinhardt <ps@pks.im>
Subject: Re: [BUG] git stash show -p with invalid option aborts with
 double-free in show_stash() (strvec_clear)
Message-ID: <20250919164820.GA24939@coredump.intra.peff.net>
References: <CAMCKZdV+ASXAhYXaTdtB=7YZprCxFUjwEsqQP7i_ccOwx8Lo6Q@mail.gmail.com>
 <1321ff39-6f09-426a-aa75-939ef4e1ad93@app.fastmail.com>
 <xmqq4isy77qr.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq4isy77qr.fsf@gitster.g>

On Fri, Sep 19, 2025 at 09:00:12AM -0700, Junio C Hamano wrote:

> The easier, more performant, and closer to the original design
> around the revisions API is to do this:
> 
> diff --git c/builtin/stash.c w/builtin/stash.c
> index f5ddee5c7f..b6312b1b70 100644
> --- c/builtin/stash.c
> +++ w/builtin/stash.c
> @@ -1016,6 +1016,8 @@ static int show_stash(int argc, const char **argv, const char *prefix,
>  	}
>  
>  	argc = setup_revisions(revision_args.nr, revision_args.v, &rev, NULL);
> +	for (i = argc; i < revision_args.nr; i++)
> +		revision_args.v[i] = NULL;
>  	if (argc > 1)
>  		goto usage;
>  	if (!rev.diffopt.output_format) {

I think we'll have leaked the string holding "-p" in this instance,
though. We probably need to pass in a setup_revision_opt struct with its
free_removed_argv_elements flag set.

That's true even without your patch, too, of course. I'm mildly
surprised that the test suite doesn't hit this in leak-checking mode,
since it is a problem any time we rearrange argv. E.g., I think:

  git stash show -p --

leaks (I was surprised that "stash show -p --stat" didn't leak, but it
doesn't seem to rearrange?).

Another interesting thing about your patch above is that it fills the
strvec with a bunch of NULL entries. Which happens to work, because
free(NULL) is a noop, but I think may be subtly violating assumptions
made about strvecs. Probably:

  revision_args.nr = setup_revisions(...);

fits my mental model better, though that is violating a different strvec
invariant now (that the .v[.nr] is always NULL). I think
setup_revisions() is a little sloppy not to set argv[argc] to NULL
itself.

> A less performant but may in the longer term safer alternative is to
> change the caller-callee contract around setup_revisions() so that
> the later "unused" slots in the argv array is NULLed before
> returning to the caller, i.e. instead of leaving
> 
>     .v = { "show", "--no-such-option", "--no-such-option", NULL }
> 
> in the revision_args.v[] array, teach setup_revisions() to leave
> 
>     .v = { "show", "--no-such-option", NULL, NULL }
> 
> there (again, we cannot do anything about .nr that is only available
> to the caller).

I think we should consider a fix like this. Grepping for the
free_removed_argv_elements option, there are a few other spots that
correctly use that flag, but aren't updating the strvec argc. E.g.,
bisect_rev_setup(). So they're going to run into the same problem.

I wonder if the best solution is a setup_revisions() wrapper for strvecs
that will:

  - turn on the free_removed_argv_elements option automatically

  - collect the return value of setup_revisions() and use it to fix
    the .nr field of the strvec

  - restore the NULL invariant at the end of the array (though I would
    also be happy if setup_revisions() just did this itself)

-Peff
