Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3EA91D7995
	for <git@vger.kernel.org>; Tue,  8 Jul 2025 01:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751938539; cv=none; b=DqEVQtrM9bHma7X4PyPlgE3aYDBtV9E8z5bytgtYQTaBu41SIHh7Id2an7LUCGgMq3QdhK9tgYj+WcBwqieajLg49G0xoqIv1z6ylDmUpZ9qkU/GfDpWZnV7Me1ZlLFGW6aurhQvkpK/29oRjf/Dq8pG0Ke39sdD0fQGMI68skA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751938539; c=relaxed/simple;
	bh=0g6QfaLeDzFRAEjFYhiUl1lWe8GMv+wGRCD5EjIWjK8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WHIn6sJLDN/QAtwVl9TrkDRAavjZoR2lH+8eCp98kH1HheL9/z9yr1ScDw8cpghA30ImK/0OYSarLN0ja7Na+zVpA0tP/2NRbEmD1CB19AgNCQa70fcz6nK1h7P831hyWlJg0pIEXg+NB4Axb48fjEBRSS9YFk5hCka/yvNNWkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=CruXVvwv; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="CruXVvwv"
Received: (qmail 10709 invoked by uid 109); 8 Jul 2025 01:35:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=0g6QfaLeDzFRAEjFYhiUl1lWe8GMv+wGRCD5EjIWjK8=; b=CruXVvwvkwCgJLC2AOyfXHdHTFhe2/kYSrpwkpfdPDJhobzQQjKNDoRZ8xYQzIKnhj1wzf+Aywzr0GrRAPpPGYkgKP+PtXHLxe7Pg1dVwjIv/O1UUiW06MvYBMqLI1Be8XInBVW9kTSwO1rvSHO/gB1yNPYa4EoUAIw3vTiJFaohQqE2cF3sx1sCK4QwojO0ewR7qrcAteNehN3HTlSI36fh+DBZ48ESdNan8a+dInjC3j2uBetkU6ulFJ1kKu25TK+8Mx6Srn+j4KznRtvJTqb/j2C3+/bd1Chd0In3LJJ8TH0f6gnKSUSSajyyyX4vRbPYk1ksoSlyfVl4XjiF9A==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 08 Jul 2025 01:35:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13946 invoked by uid 111); 8 Jul 2025 01:35:37 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Mon, 07 Jul 2025 21:35:37 -0400
Authentication-Results: peff.net; auth=none
Date: Mon, 7 Jul 2025 21:35:34 -0400
From: Jeff King <peff@peff.net>
To: Phil Hord <phil.hord@gmail.com>
Cc: gitster@pobox.com, git@vger.kernel.org,
	Jacob Keller <jacob.e.keller@intel.com>
Subject: Re: [PATCH v4 3/3] clean up interface for refs_warn_dangling_symrefs
Message-ID: <20250708013534.GA549007@coredump.intra.peff.net>
References: <20250702011214.2835529-2-phil.hord@gmail.com>
 <20250702011214.2835529-5-phil.hord@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250702011214.2835529-5-phil.hord@gmail.com>

On Tue, Jul 01, 2025 at 06:12:15PM -0700, Phil Hord wrote:

> The refs_warn_dangling_symrefs interface is a bit fragile as it passes
> in printf-formatting strings with expectations about the number of
> arguments. This patch series made it worse by adding a 2nd positional
> argument. But there are only two call sites, and they both use almost
> identical display options.
> 
> Make this safer by moving the format strings into the function that uses
> them to make it easier to see when the arguments don't match. Pass a
> prefix string and a dry_run flag so the decision logic can be handled
> where needed.

Thanks, I think the result is nicer. I have two comments, but I don't
think either will merit a re-roll.

> @@ -1384,9 +1384,6 @@ static int prune_refs(struct display_state *display_state,
>  	struct ref *ref, *stale_refs = get_stale_heads(rs, ref_map);
>  	struct strbuf err = STRBUF_INIT;
>  	struct string_list refnames = STRING_LIST_INIT_NODUP;
> -	const char *dangling_msg = dry_run
> -		? _("   %s will become dangling after %s is deleted")
> -		: _("   %s has become dangling after %s was deleted");
>  
>  	for (ref = stale_refs; ref; ref = ref->next)
>  		string_list_append(&refnames, ref->name);
> @@ -1417,7 +1414,7 @@ static int prune_refs(struct display_state *display_state,
>  		}
>  		string_list_sort(&refnames);
>  		refs_warn_dangling_symrefs(get_main_ref_store(the_repository),
> -					   stderr, dangling_msg, &refnames);
> +					   stderr, "   ", dry_run, &refnames);
>  	}

I had imagined passing in an "int indent", and not an arbitrary string.
But passing in the string is actually more flexible (it really could be
any prefix, not just an indentation). I think calling it "prefix" in the
actual function might be the more usual term here, but it's probably
just bike-shedding.

> -	fprintf(d->fp, d->msg_fmt, refname, resolves_to);
> -	fputc('\n', d->fp);
> +	msg = d->dry_run
> +		? _("%s%s will become dangling after %s is deleted\n")
> +		: _("%s%s has become dangling after %s was deleted\n");
> +	fprintf(d->fp, msg, d->indent, refname, resolves_to);

Translators might find the extra "%s" at the beginning confusing without
context. I think you can do something like:

  /* TRANSLATORS: The first %s is whitespace indentation. */

or similar. But maybe it would be more obvious as:

  fputs(d->indent, d->fp);
  fprintf(d->fp, msg, refname, resolves_to);
  fputc('\n', d->fp);

? I dunno. Maybe putting it all together gives translators more options
(e.g., in a RTL language). I don't know much about translation.

Likewise on including the newline in the translated string. I think we
usually don't, just because we're mostly passing in strings for error(),
etc. But I don't know how much it matters.

-Peff
