Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E840E40BE0
	for <git@vger.kernel.org>; Tue, 19 Nov 2024 18:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732042429; cv=none; b=rIEDivmBP6PrKGEvy7XQpAgWKxgrqnYNwKeYSfZCBaNekdJokdhtI8ja/sXNauIsFFkouKY1T2gleetqSibdreTRs3ZfbHsZ4GbETpWknTKbWIxxBZyK9QEWVxR8pQR6X4Wl8qZ5fAfVBAwTSCCmoiy71NzBF+spygwRoEEPob4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732042429; c=relaxed/simple;
	bh=L1CDIA2T2AaWAtfsBWzV946jMCPOWy9PJg6kxu8EIN4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EGAzQBxZHGSeKsxHT5g/W5ZrnqZ137dQkYnNORbY/O/U2xFte07BaWVnaSJfuUmIYMyW1ndE/lnmk7YLLClSRa+gHXIdaqFy+zE/kqe4qzAyVH8djZbq6kE7HoRAT+3kmIOSrO0o1eF5KlNukcGcpDW4X8JB+rDNU/GzyIQyIZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=HPnMP2xU; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="HPnMP2xU"
Received: (qmail 7633 invoked by uid 109); 19 Nov 2024 18:53:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=L1CDIA2T2AaWAtfsBWzV946jMCPOWy9PJg6kxu8EIN4=; b=HPnMP2xUGhbZaAWwqQ6dF5WWzpTuSEZd/v7JPWhH/knEuosPoYmRryKDk7MUQSnG36PCr06NyatCEmOkrdwf8P9D+KKpQlo+z/3l5F0v7JO4s/nAKU8TnzlEKqHOAEyKUdQVryNRVoE4T7MvnqWX6IYsiSJ5oa5iuKpUFz6Sy/qC/5i42+C1DL7DPw5ACuGivmRmakLO8NMI0irxSIFkcXlJioULHAFNgGl+IFlnC/iU8LnQm4PFzNtoCtXXEokSdIWH0azwYbzmFztI7O6VdDvskHIoFVLIcHzoiyBRn1FsaOGIALdrU85xHduTSg1s0QVI+Hqqu7bc1X+W5QdIXA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 19 Nov 2024 18:53:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 2642 invoked by uid 111); 19 Nov 2024 18:53:47 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 19 Nov 2024 13:53:47 -0500
Authentication-Results: peff.net; auth=none
Date: Tue, 19 Nov 2024 13:53:45 -0500
From: Jeff King <peff@peff.net>
To: Jonathan Tan <jonathantanmy@google.com>
Cc: git@vger.kernel.org, stolee@gmail.com
Subject: Re: [PATCH] index-pack: teach --promisor to require --stdin
Message-ID: <20241119185345.GB15723@coredump.intra.peff.net>
References: <20241116032352.GA1782794@coredump.intra.peff.net>
 <20241118190210.772105-1-jonathantanmy@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241118190210.772105-1-jonathantanmy@google.com>

On Mon, Nov 18, 2024 at 11:02:06AM -0800, Jonathan Tan wrote:

> Currently, Git uses "index-pack --promisor" only when fetching into
> a repo, so it could be argued that we should teach "index-pack" a new
> argument (say, "--fetching-mode") instead of tying --promisor to a
> generic argument like "--stdin". However, this --promisor feature could
> conceivably be used whenever we have a packfile that is known to come
> from the promisor remote (whether obtained through Git's fetch protocol
> or through other means) so it seems reasonable to use --stdin here -
> one could envision a user-made script obtaining a packfile and then
> running "index-pack --promisor --stdin", for example. In fact, it might
> be possible to relax the restriction further (say, by also allowing
> --promisor when indexing a packfile that is in the object DB), but
> relaxing the restriction is backwards-compatible so we can revisit that
> later.

Yeah, I agree with this summary.

> This change requires the change to t5300 by 1f52cdfacb (index-pack:
> document and test the --promisor option, 2022-03-09) to be undone.
> (--promisor is already tested indirectly, so we don't need the explicit
> test here any more.)

OK, I think this is reasonable.

> Looking into it further, I think that we also need to require no
> packfile name to be given (so that we are writing the file to the
> repository). Therefore, I've added that requirement both in the code and
> in the documentation.

Hmm. I didn't realize that you could specify a pack name _and_ --stdin,
but I guess it makes sense if you wanted to write the result to a
non-standard location (though curiously --stdin requires a repo, which
feels overly restrictive if you give a pack name).

But I think that makes the --stdin check redundant. I.e., here:

> diff --git a/builtin/index-pack.c b/builtin/index-pack.c
> index 08b340552f..c46b6e4061 100644
> --- a/builtin/index-pack.c
> +++ b/builtin/index-pack.c
> @@ -1970,6 +1970,10 @@ int cmd_index_pack(int argc,
>  		usage(index_pack_usage);
>  	if (fix_thin_pack && !from_stdin)
>  		die(_("the option '%s' requires '%s'"), "--fix-thin", "--stdin");
> +	if (promisor_msg && !from_stdin)
> +		die(_("the option '%s' requires '%s'"), "--promisor", "--stdin");
> +	if (promisor_msg && pack_name)
> +		die(_("--promisor cannot be used with a pack name"));

...just the second one would be sufficient, because the context just
above this has:

	if (!pack_name && !from_stdin)
		usage(index_pack_usage);

So if there isn't a pack name then from_stdin must be set anyway.

What you've written won't behave incorrectly, but I wonder if this means
we can explain the rule in a more simple way:

  - the --promisor option requires that we be indexing a pack in the
    object database

  - when not given a pack name on the command line, we know this is true
    (because we generate the name ourselves internally)

  - when given a pack name on the command line, we _could_ check that it
    is inside the object directory, but we don't currently do so and
    just bail. That could be changed in the future.

And then there is no mention of --stdin at all (though of course it is
an implication of the second point, since we have to get input somehow).

-Peff
