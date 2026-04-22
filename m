Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EFC23644DE
	for <git@vger.kernel.org>; Wed, 22 Apr 2026 22:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776897886; cv=none; b=AdS81F7dsqHQ0oJqQNGu4rNSPhyrCIQHkhxFu8rbSeehjFRbnDbI9JM8JolaQznTVBqp4U9vjjCboeKeAFI3fQNwG1PYhFLh0FHRBBvpeB1vGcdatz9s8YY9Ozz8zY6KbTaHNr1TOl5vUJ3lPLOk0leYArcosGyq0DgnEGzRmEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776897886; c=relaxed/simple;
	bh=5Th4uH7vQ+AYS45OPeVDPidp465V039YmqQ4Ef4bLQU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LV+mUZnFYpSXd6TaIaI2rS2GEBJVTtDucJz7kAYfYzlX4BLzaQesvURQ0Zs7XYutmB+W/LEMvcmU6LUY3iLv0RTpb7vlFCOsi2NFAS73CE6MJVrWCDSNCM9GHpQl2r1hCrO1Wr4iqB88164EYVXWKRoYsC58HCtoippNfFh9oHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=G/YUX/uC; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="G/YUX/uC"
Received: (qmail 428586 invoked by uid 106); 22 Apr 2026 22:44:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=5Th4uH7vQ+AYS45OPeVDPidp465V039YmqQ4Ef4bLQU=; b=G/YUX/uC39ASM0syzrMxDbKE+s+fRsY2+CLJ16SQlekHyzEOvaDnZDe46vwb/R1SuDMf4CxHu+lNIp7bFcRktSCqoO5oRH04YRHEWuoruiFGZNPz1oPVj4IW8+JbXyCbN8eI0WnfmY2/fExrF+jQZc9rWbOAVto0vdwC+PT1BxSyHvFQmII4S+tjSYwU3fedmKoJm6qAw4ufsDnPBGmh5ytUj2I0EELLYbYT9su5dA0lnA79LEKV7AV6qVHDjgWrpKz2mIkynJfwHIrHID6Q/SBQw719tDQVK1TWhOEfp3b9exSQnz7MGZraJMLmNpBjWVEZFkKmaMzHYJY2SI31FQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 22 Apr 2026 22:44:43 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 977624 invoked by uid 111); 22 Apr 2026 22:44:43 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 22 Apr 2026 18:44:43 -0400
Authentication-Results: peff.net; auth=none
Date: Wed, 22 Apr 2026 18:44:42 -0400
From: Jeff King <peff@peff.net>
To: Mirko Faina <mroik@delayed.space>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
	Patrick Steinhardt <ps@pks.im>, Tian Yuchen <cat@malon.dev>,
	Ben Knoble <ben.knoble@gmail.com>
Subject: Re: [PATCH v2 1/2] revision.c: implement --reverse=before for walks
Message-ID: <20260422224442.GB110382@coredump.intra.peff.net>
References: <20260418164736.2367523-2-mroik@delayed.space>
 <20260422002840.303477-5-mroik@delayed.space>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260422002840.303477-5-mroik@delayed.space>

On Wed, Apr 22, 2026 at 02:28:40AM +0200, Mirko Faina wrote:

> diff --git a/Documentation/rev-list-options.adoc b/Documentation/rev-list-options.adoc
> index 2d195a1474..7244e85108 100644
> --- a/Documentation/rev-list-options.adoc
> +++ b/Documentation/rev-list-options.adoc
> @@ -914,10 +914,16 @@ With `--topo-order`, they would show 8 6 5 3 7 4 2 1 (or 8 7 4 2 6 5
>  avoid showing the commits from two parallel development track mixed
>  together.
>  
> -`--reverse`::
> -	Output the commits chosen to be shown (see 'Commit Limiting'
> -	section above) in reverse order. Cannot be combined with
> -	`--walk-reflogs`.
> +`--[no-]reverse[=(after|before)]`::
> +	Accepts `after` or `before`. Cannot be combined with
> +	`--walk-reflogs`. If `after`, output the commits chosen to be
> +	shown (see 'Commit Limiting' section above) in reverse order. If
> +	`before`, reverse the commits before filtering with `Commit
> +	Limiting` options. This option can be used multiple times, last
> +	one is applied. When the argument for `--reverse` is omitted, if
> +	the current state is in no reverse, it defaults to `after`. If
> +	it is in any reversed state, it restores the original ordering
> +	by removing the reverse state.

I think this is all correct, but I found the final sentences a bit hard
to follow (especially the phrase "reversed state"). Let me take a stab
at it.

  When multiple `--reverse=` options are given, the final option
  overrides any previous options. The `--reverse` option (with no
  specifier) behaves as `--reverse=after`, except that for historical
  reasons it negates any previous reversed state (so `--reverse
  --reverse` does nothing, nor does `--reverse=before --reverse`).

I dunno if that is any better, really. I hoped by mentioning "historical
reasons" that excuses any weirdness, and readers interested in sane
behavior can stop reading. ;)

So anyway, I offer it in case you find it useful or can pick out useful
bits from it.

-Peff
