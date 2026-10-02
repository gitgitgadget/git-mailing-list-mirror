Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDF64547071
	for <git@vger.kernel.org>; Fri,  2 Oct 2026 23:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790983532; cv=none; b=SvhMHVpsaHeJ1tn0QIZCNc6cOBHVG40s8kvuXwr+3Takz6YieHWSNukjK9DO6uNzEibGuh2OD7NypN0HjIui5eUrECNVVGaNVDtjIAcSTiu/S4A/glmQAwclYminppebKIkS9o5j5Tlsh+nt36RSH8njpd3QcG3YMqd0Vfl9UM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790983532; c=relaxed/simple;
	bh=zw1ssRqRG7aXfyNt3iKalnbbhd2ekofXT6L/LVavvF0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cKJSooYj0t3VD/rOWF+nq6xY9++vPNlWhRCPkmV8RUvw+ZTbyZJ2pwQPWJi1AcA5w6fzDyNKWzv4x+5LrkZfPK6aQj0Sut8UfUXw9f7NeO0ruLnj0HvmmljX1jOSN2fCjZG9Nsebb8hn2VA1IuW/FuVOjiHf5s4nkQyjEQDsr6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=FXGdh/Vm; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="FXGdh/Vm"
Received: (qmail 16842 invoked by uid 106); 2 Oct 2026 23:25:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=zw1ssRqRG7aXfyNt3iKalnbbhd2ekofXT6L/LVavvF0=; b=FXGdh/Vm6qciodUutR72AioOa4zfPap3kYUi20N9y76StakzoKUkzo9ZmilGaIDuHE/cB3yQ0utIbSJnS84TNW+0mWEZsbMxH3FxVm2ykX/ckEepHytuJj9YTVAKryif50Ap/B+TspQUoP+6+rs83djoqxBZZIHjltaJoHBUS8Wy1U+BPKKyIt0MB7KDU435A3LjzeDdHluZpTgxyd8J337o8tzn20/ex6OoqZ6PxrzQ6zjWJnIl8P+0Vuvl21V4nW71OMjB88MpwmnP724wb3Bx5SggJ2VKZzJmsoG//Cf1u8HIpLnZ/KQECQmuZqGnI3CaB+Y/pxVN3QBvscEKSQ==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 02 Oct 2026 23:25:29 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 49316 invoked by uid 111); 2 Oct 2026 23:25:32 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 02 Oct 2026 19:25:32 -0400
Authentication-Results: peff.net; auth=none
Date: Fri, 2 Oct 2026 19:25:29 -0400
From: Jeff King <peff@peff.net>
To: Taylor Blau <ttaylorr@openai.com>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Ted Nyman <tnyman@openai.com>, Elijah Newren <newren@github.com>
Subject: Re: [PATCH v2 5/8] repack: follow kept packs when omitting cruft
 from the MIDX
Message-ID: <20261002232529.GD834759@coredump.intra.peff.net>
References: <cover.1790731662.git.me@ttaylorr.com>
 <cover.1790827875.git.me@ttaylorr.com>
 <51e20444dac1223f0e0485dc5799ed6d592f7614.1790827875.git.me@ttaylorr.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <51e20444dac1223f0e0485dc5799ed6d592f7614.1790827875.git.me@ttaylorr.com>

On Wed, Sep 30, 2026 at 11:11:51PM -0500, Taylor Blau wrote:

> diff --git a/builtin/repack.c b/builtin/repack.c
> index 88b05e96b5b..27d6668a4ab 100644
> --- a/builtin/repack.c
> +++ b/builtin/repack.c
> @@ -476,9 +476,11 @@ int cmd_repack(int argc,
>  	show_progress = !po_args.quiet && isatty(2);
>  
>  	strvec_push(&cmd.args, "--keep-true-parents");
> -	for (i = 0; i < keep_pack_list.nr; i++)
> -		strvec_pushf(&cmd.args, "--keep-pack=%s",
> -			     keep_pack_list.items[i].string);
> +	/* Geometric follow walks exclude these packs through stdin instead. */
> +	if (!(geometry.split_factor && !midx_must_contain_cruft))
> +		for (i = 0; i < keep_pack_list.nr; i++)
> +			strvec_pushf(&cmd.args, "--keep-pack=%s",
> +				     keep_pack_list.items[i].string);

This conditional makes my head hurt because of the double-negation. By
De Morgan's it is just:

  if (!geometry.split_factor || midx_must_contain_cruft)

which at least untangles it. The comment makes sense to say "we do not
need to do this in geometric" mode, which matches the first half. But
why does midx_must_contain_cruft trigger it? I guess it is "we do not
need to bother doing the "^"-exclusion later in that mode", but I wonder
if there is any advantage to suppressing it. I don't remember enough of
the details here about why we were treating keep packs specially in the
first place.

> @@ -593,6 +595,29 @@ int cmd_repack(int argc,
>  
>  			fprintf(in, "%c%s\n", marker, basename);
>  		}
> +		if (!midx_must_contain_cruft) {

OK, and this is the flip side of the earlier conditional. We are in
geometric mode if we get here, and we kick in only in non-midx-cruft
mode.

IMHO the De Morgan untangling above makes it more clear, but you could
probably even further with:

  /* explanatory comment here */
  int handle_keep_packs_via_follow = geometry.split_factor && !midx_must_contain_cruft;

And then use that in both spots. That might be overkill, though (and the
name I proposed certainly sucks).

-Peff
