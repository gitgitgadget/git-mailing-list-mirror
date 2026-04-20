Received: from cloud.peff.net (cloud.peff.net [217.216.95.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A581C28E
	for <git@vger.kernel.org>; Mon, 20 Apr 2026 00:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.216.95.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776643490; cv=none; b=Tq3HH/ldXJENhTcQt3YE27q83xSXMA2D7PUEu+gKRHjXRwBEPpsr3kxSfqyGmO6DyG+pdObSC2NY8EbruiPSTEwdFjTsk25pktQISXQ5SiV3msCJ2yw/BxXfWg5mdPvh2PeE/KTx4UrWJfZAGJfwF5yvug6rNAQVVWu7O0g0cOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776643490; c=relaxed/simple;
	bh=zsr83gtlUplyIF7M2HTlo2OWANoGRAcLkP0u4RgR/w0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V3+HzL5bHZAuC/nWwtof1NtEPov08VReUFkXcMhE3aeVadLoTzOfaWMTAbKlBnLFB6825RpOA5PDhiNSshEfw9+oqJ6m4jlCLV+sHBQ3j637viIJrZr7G+LKdPQAsQcgSKoCAnz/OXrIvq6r03WE/dDS+TK11sJOqXmwYaoa9yk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=WML3SOJN; arc=none smtp.client-ip=217.216.95.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="WML3SOJN"
Received: (qmail 402129 invoked by uid 106); 20 Apr 2026 00:04:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=zsr83gtlUplyIF7M2HTlo2OWANoGRAcLkP0u4RgR/w0=; b=WML3SOJNwLqzHJZo7rUhncKXlkfn8e4xrSs7WtEeGBlp8IAJCzqXFCS+7mxBawSOTjlvtOT/mZxAxfHvpnSm3YWJl2QRfMsUCyvm4Q3zkcIcaFf6pWNW6D5rerRl64v+TCjyQKzsN4RpSO3nyxiZx9vvsVx4qPfYXZQtm41cf40IfHdreqLp2tA+ZFtO8Gj/KeHGQ+/1R4VWg6Kg/28vfXEyLRoIEoNLuLN+DyOMZWTWHDunU8JvBFWj/oa2fe2lmAJVDopDltgyeOd4WriIxKCQlBqeJCCwfcQI4Ai8JbZKMtxnjKi5IwRRedTtk5v1fshC9gAPANx1hM0L9EVDCg==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Mon, 20 Apr 2026 00:04:41 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 916294 invoked by uid 111); 20 Apr 2026 00:04:40 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Sun, 19 Apr 2026 20:04:40 -0400
Authentication-Results: peff.net; auth=none
Date: Sun, 19 Apr 2026 20:04:40 -0400
From: Jeff King <peff@peff.net>
To: Mirko Faina <mroik@delayed.space>
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Patrick Steinhardt <ps@pks.im>,
	=?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>
Subject: Re: [PATCH] revision.c: implement --reverse=before for walks
Message-ID: <20260420000440.GA1238475@coredump.intra.peff.net>
References: <20260418164736.2367523-2-mroik@delayed.space>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260418164736.2367523-2-mroik@delayed.space>

On Sat, Apr 18, 2026 at 06:47:35PM +0200, Mirko Faina wrote:

> @@ -2685,8 +2685,26 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
>  		else
>  			git_log_output_encoding = xstrdup("");
>  		return argcount;
> -	} else if (!strcmp(arg, "--reverse")) {
> -		revs->reverse ^= 1;
> +	} else if (starts_with(arg, "--reverse")) {
> +		if (!skip_prefix(arg, "--reverse=", &optarg)) {
> +			if (argc < 2) {
> +				revs->reverse = 1;
> +				return 1;
> +			} else {
> +				optarg = argv[1];
> +			}
> +		}

It looks like you're trying to support "--reverse after" here, but don't
do that. Flags with optional arguments must use the "stuck" form,
"--reverse=after", which is covered in the "gitcli" manpage.

That's to prevent "--reverse --foo" from being ambiguous. It looks like
you try to limit that with the final "else" here:

> +
> +		if (!strcmp(optarg, "after")) {
> +			revs->reverse = 1;
> +		} else if (!strcmp(optarg, "before")) {
> +			revs->reverse = 2;
> +		} else {
> +			revs->reverse = 1;
> +			return 1;
> +		}

but that just makes things more complicated:

  - doing "git log --reverse=bogus" is silently accepted

  - trying to show a branch named "after" with "git log --reverse after"
    has changed meanings

So I think you really just want to handle "--reverse=" separately from
"--reverse", and the latter should behave as it always has.

-Peff
