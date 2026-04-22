Received: from mail.delayed.space (delayed.space [195.231.85.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C244F3750CB
	for <git@vger.kernel.org>; Wed, 22 Apr 2026 22:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.231.85.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776898441; cv=none; b=DhnR8aJDuqNkVAY03IR1s8ELj91JggN8CX5oGARvnMMSwk0oBNBTmavL7+HNaJqhLyEfqh7tJRVA2npl6H8/Is8UaBueNfMF7kipNXcYgCzcY8+1y3sZkRQQ+uZerBu1YGb6xQkfsn9G7DK5XlOO2wiXv6RtVzFP1zxDrZXnd4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776898441; c=relaxed/simple;
	bh=OGBnzGeABcr0O4lS3Sp7MH3nGwoQDovIKP44uyY+KW8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=GZy2iyEax3vGUeNpFrAk2T4KHRVd0/cCeeaEbav8oaXWelo3fobrG/NPhkHNct88cbJHLXKOMgBdJap7s5rppf/wN7kj/GvKIBSIOofSFogw7xiIdBrVwzEo+xoHpTzik6vdVlFsPoyY/xTdwhoe9njdwpeZ2lwIHdIEKUtU8J8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space; spf=pass smtp.mailfrom=delayed.space; dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b=bOV2wJXA; arc=none smtp.client-ip=195.231.85.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=delayed.space
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=delayed.space
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=delayed.space header.i=@delayed.space header.b="bOV2wJXA"
Date: Thu, 23 Apr 2026 00:53:54 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=delayed.space;
	s=dkim; t=1776898436;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GIStDR5ctbGXsXu8LXx4in1l8jyyh1QW7zZTdai+Dg4=;
	b=bOV2wJXAsBWZNJ5zKO4kwPyZv2oSc6nEzLL8KAB94Q1Nv82ZAQCS5i+zpbHbTvf5fpNtbP
	mMJJsc2xMqldc/Cd9mPlzia26Dh9AiPMepHhNUdliMlq7QbgsskqmtQEOPgh0BI+1IO2Fw
	bGMkgTBhbLbtZB5qJuqzLHds/wf3Y8Y5+NCTwnKF+iTSX0IVT9CH7Prj99WKjoYxejkwcY
	SMILc1EOdcjPert+fHRdQqk3enksSgn6S+403z/fsSARSLTtgMBNQ4dbpa3M1qHbfGJszC
	N9j21C7iAyIYGJAQIcl9hCoAW+iOGyfK1o2ltONo9ozfsVVq0QOOHKdA5bd3+A==
Authentication-Results: mail.delayed.space;
	auth=pass smtp.mailfrom=mroik@delayed.space
From: Mirko Faina <mroik@delayed.space>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>, 
	=?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>, Patrick Steinhardt <ps@pks.im>, Tian Yuchen <cat@malon.dev>, 
	Ben Knoble <ben.knoble@gmail.com>, Mirko Faina <mroik@delayed.space>
Subject: Re: [PATCH v2 1/2] revision.c: implement --reverse=before for walks
Message-ID: <aelQm3cznMc1EkQG@exploit>
References: <20260418164736.2367523-2-mroik@delayed.space>
 <20260422002840.303477-5-mroik@delayed.space>
 <20260422224442.GB110382@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260422224442.GB110382@coredump.intra.peff.net>
X-Spamd-Bar: -

On Wed, Apr 22, 2026 at 06:44:42PM -0400, Jeff King wrote:
> On Wed, Apr 22, 2026 at 02:28:40AM +0200, Mirko Faina wrote:
> 
> > diff --git a/Documentation/rev-list-options.adoc b/Documentation/rev-list-options.adoc
> > index 2d195a1474..7244e85108 100644
> > --- a/Documentation/rev-list-options.adoc
> > +++ b/Documentation/rev-list-options.adoc
> > @@ -914,10 +914,16 @@ With `--topo-order`, they would show 8 6 5 3 7 4 2 1 (or 8 7 4 2 6 5
> >  avoid showing the commits from two parallel development track mixed
> >  together.
> >  
> > -`--reverse`::
> > -	Output the commits chosen to be shown (see 'Commit Limiting'
> > -	section above) in reverse order. Cannot be combined with
> > -	`--walk-reflogs`.
> > +`--[no-]reverse[=(after|before)]`::
> > +	Accepts `after` or `before`. Cannot be combined with
> > +	`--walk-reflogs`. If `after`, output the commits chosen to be
> > +	shown (see 'Commit Limiting' section above) in reverse order. If
> > +	`before`, reverse the commits before filtering with `Commit
> > +	Limiting` options. This option can be used multiple times, last
> > +	one is applied. When the argument for `--reverse` is omitted, if
> > +	the current state is in no reverse, it defaults to `after`. If
> > +	it is in any reversed state, it restores the original ordering
> > +	by removing the reverse state.
> 
> I think this is all correct, but I found the final sentences a bit hard
> to follow (especially the phrase "reversed state"). Let me take a stab
> at it.
> 
>   When multiple `--reverse=` options are given, the final option
>   overrides any previous options. The `--reverse` option (with no
>   specifier) behaves as `--reverse=after`, except that for historical
>   reasons it negates any previous reversed state (so `--reverse
>   --reverse` does nothing, nor does `--reverse=before --reverse`).
> 
> I dunno if that is any better, really. I hoped by mentioning "historical
> reasons" that excuses any weirdness, and readers interested in sane
> behavior can stop reading. ;)
> 
> So anyway, I offer it in case you find it useful or can pick out useful
> bits from it.

Yes, it does read better, thank you.

I'd personally put a "truth table" but that would be very verbose, and I
suspect most would not find it useful :D

Thank you
