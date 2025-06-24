Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 710CF1ADFFB
	for <git@vger.kernel.org>; Tue, 24 Jun 2025 10:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750762148; cv=none; b=qmJw/CNRCrP9UjK7fEgkUDrIEAkJFCWit6IV83fd+c5jX7zpv9AYrlzixzQJL1+HU/wiq8AOmAhR/ifztuMIqp7BVCoE7WeKewA85EW5vsXfWEFkFXTk/+5pJG5E+cyc9usWHJasiENQ9gcx1Cyx1AA37tsd79VjTrzopAQnuII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750762148; c=relaxed/simple;
	bh=tzPBH4JjQJcL4LWE4NDC8rza4BKmCZvdsi6LOoGsj0c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qBSVYaXOe26wAV3mYRP4aNMwI5sWmxZIOLLRp7bDxMoafQhTkRIaMQvHfGVA0ifgef9O+t4LaIJbDWMcB5IxaWgcwyM07fl+dzSW7htYlkUtzHhxLme85/4mBOmkdGJUC5dq7vdc0Eoxidb5H9aWNPCSVqkbcyOWAncc6/vBYQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=PsQPoCi1; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="PsQPoCi1"
Received: (qmail 17861 invoked by uid 109); 24 Jun 2025 10:49:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=tzPBH4JjQJcL4LWE4NDC8rza4BKmCZvdsi6LOoGsj0c=; b=PsQPoCi1VFDoVdfKaG7N1FxQBdSjIqYuI/wHYKTZDc8EjCGnNkP2QJ5NiUGJKzOII0/Z5g3QmtT0Wh1mYhuiALdO5RewdytTCDQAAJnMFEPJcWc7dRJ/IFuukfWNhsgYQIVJmJ9YHvQOPb1YxUrqLdqRg9zDr9L1Sc1w1DCQFdpyZQRs6/akWSU2gAeRGP0iI3D1fMMrA0Ay+909P0ifbeT2QFEkufh+OCqQDgELGMzCWbr9djV0hz3ImJn5U/ahpboRmeFezRT1yHAfQX60mYxxmYekvhdT6t2MeTtiafU3POISvGa6TJ5DASbtpp1w12jieXsGPaMkCpbNqMW6vA==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 24 Jun 2025 10:49:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29754 invoked by uid 111); 24 Jun 2025 10:49:04 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 24 Jun 2025 06:49:04 -0400
Authentication-Results: peff.net; auth=none
Date: Tue, 24 Jun 2025 06:49:04 -0400
From: Jeff King <peff@peff.net>
To: Phil Hord <phil.hord@gmail.com>
Cc: gitster@pobox.com, git@vger.kernel.org,
	Jacob Keller <jacob.e.keller@intel.com>
Subject: Re: [PATCH v2 1/2] fetch-prune: optimize dangling-ref reporting
Message-ID: <20250624104904.GE636332@coredump.intra.peff.net>
References: <20250623234327.335490-1-phil.hord@gmail.com>
 <20250623234327.335490-2-phil.hord@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250623234327.335490-2-phil.hord@gmail.com>

On Mon, Jun 23, 2025 at 04:43:26PM -0700, Phil Hord wrote:

> diff --git a/builtin/fetch.c b/builtin/fetch.c
> index 40a0e8d24434..65d606c6de08 100644
> --- a/builtin/fetch.c
> +++ b/builtin/fetch.c
> @@ -1383,9 +1383,13 @@ static int prune_refs(struct display_state *display_state,
>  	int result = 0;
>  	struct ref *ref, *stale_refs = get_stale_heads(rs, ref_map);
>  	struct strbuf err = STRBUF_INIT;
> +	struct string_list refnames = STRING_LIST_INIT_NODUP;
>  	const char *dangling_msg = dry_run
> -		? _("   (%s will become dangling)")
> -		: _("   (%s has become dangling)");
> +		? _("   %s will become dangling after %s is deleted")
> +		: _("   %s has become dangling after %s was deleted");

This approach seems reasonable. It is a little ugly that
refs_warn_dangling_symrefs() takes a printf-formatted string that must
contain the correct number of "%s" fields (and that we get no compiler
warnings if we get it wrong).

But that is not really new in your series. Given that there are two
callers and they use (almost) the same string, I wonder if we could
refactor the interface. We'd need to pass in the indentation level, and
the dry-run flag.

I guess alternatively, we could have a function which passes back a
strvec or similar of danglers, but then both call sites would have more
printing boilerplate. I dunno. Maybe we should just avert our eyes and
live with it. ;)

> diff --git a/refs.c b/refs.c
> index dce5c49ca2ba..e2075a98c844 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -461,7 +461,9 @@ static int warn_if_dangling_symref(const char *refname, const char *referent UNU
>  		return 0;
>  	}
>  
> -	fprintf(d->fp, d->msg_fmt, refname);
> +	skip_prefix(refname, "refs/remotes/", &refname);
> +	skip_prefix(resolves_to, "refs/remotes/", &resolves_to);
> +	fprintf(d->fp, d->msg_fmt, refname, resolves_to);
>  	fputc('\n', d->fp);
>  	return 0;

This prefix handling feels kind of ad-hoc. Should we use something like
refs_shorten_unambiguous_ref() to follow the usual rules?

This is also shortening the symref name, which didn't happen before.
Arguably that should happen in a separate patch, but I can live with it
either way.

-Peff
