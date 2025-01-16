Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E429224A7C0
	for <git@vger.kernel.org>; Thu, 16 Jan 2025 10:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=104.130.231.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737024142; cv=none; b=mnzPBEAc2YWM07Y15+UsRIuH8pcRPNSTk/U4D8D3Vsa0ucvGHFUQRaLwFPW+xoyKRV7HqpNQI9/QIUD5IhMBkewhcbUJPXnJBWDDMuJnSIIBN+XQrOe6N5vEB8o5pqLS5AltQMDK6NPTDyzT0SmAoVqhJPxsfC1kdWtpehbPfa4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737024142; c=relaxed/simple;
	bh=ActTVz7e5w123M2yrhMrbGO5jsifIzWw11kgs8I4R/M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pvqM7GiZrVPWHgIT92iItjUMki6b7iC31Su+A5rjx7wOgfYHdbZv5ZjhmlpAgc6rt6TqROkbpANCLiT43yMkvRR4D55dWPsHtnaXJJF57kpSxbG+9UiwSuseHNcSFr2wELc01mQaHao9drGoGBpThvrw4yRP5hmda4qP8Z+3b2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net; spf=pass smtp.mailfrom=peff.net; dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b=JxK1cexM; arc=none smtp.client-ip=104.130.231.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peff.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peff.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=peff.net header.i=@peff.net header.b="JxK1cexM"
Received: (qmail 12340 invoked by uid 109); 16 Jan 2025 10:42:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=peff.net; h=date:from:to:cc:subject:message-id:references:mime-version:content-type:in-reply-to; s=20240930; bh=ActTVz7e5w123M2yrhMrbGO5jsifIzWw11kgs8I4R/M=; b=JxK1cexMSBao55vZKfEUvu38lkgvMJsoLDlTwlHGkEq8XxjRXpN0B6/WTzxiLtlxP1votDy73CbNN2E4SxV5O116beGD8eHlTDvVP5k83H32jxynRsij0zOg17MkfHhMkr+AKzz9DzanpnCVUpdAP95ecHVDUQ/9whV5Vg8OjDF8qk4cquCoH2z1hfRe7KWRqKWj6ZQ/gs7/zD6+Ui76QbIK91DybZFEhC22R5AYxscR7GIFLM8sl0Gj7T/4TVftvOmTQP8B2B3T5LzaR8Wu/ygqpO7FPanCwq2DWvEEHC5xtEHCXywQQQytuTeVwc9TGNJe1/Z+ta1oZf3AWy/fag==
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 16 Jan 2025 10:42:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 24150 invoked by uid 111); 16 Jan 2025 10:42:24 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 16 Jan 2025 05:42:24 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 16 Jan 2025 05:42:19 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v3 5/6] oddballs: send usage() help text to standard
 output
Message-ID: <20250116104219.GC773990@coredump.intra.peff.net>
References: <20250116012524.1557441-1-gitster@pobox.com>
 <20250116012524.1557441-6-gitster@pobox.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250116012524.1557441-6-gitster@pobox.com>

On Wed, Jan 15, 2025 at 05:25:22PM -0800, Junio C Hamano wrote:

> Using the show_usage_and_exit_if_asked() helper we introduced
> earlier, fix callers of usage() that want to show the help text when
> explicitly asked by the end-user.  The help text now goes to the
> standard output stream for them.
> 
> The callers in this step are oddballs in that their invocations of
> usage() are *not* guarded by
> 
> 	if (argc == 2 && !strcmp(argv[1], "-h")
> 		usage(...);
> 
> They are (unnecessarily) being clever and do things like
> 
> 	if (argc != 2 || !strcmp(argv[1], "-h")
> 		usage(...);
> 
> to say "I know I take only one argument, so argc != 2 is always an
> error regardless of what is in argv[].  Ah, by the way, even if argc
> is 2, "-h" is a request for usage text, so we do the same".  Some
> just do not treat "-h" any specially, and let it take the same error
> code paths as a parameter error.

As the author of at least one of these, I feel judged. :)

But yes, untangling this is obviously good (especially if we change the
exit code later!). And pulling these into their own commit made
reviewing much easier.

> diff --git a/builtin/var.c b/builtin/var.c
> index 1449656cc9..6a09c1c39a 100644
> --- a/builtin/var.c
> +++ b/builtin/var.c
> @@ -221,6 +221,7 @@ int cmd_var(int argc,
>  	const struct git_var *git_var;
>  	char *val;
>  
> +	show_usage_and_exit_if_asked(argc, argv, var_usage);
>  	if (argc != 2)
>  		usage(var_usage);

Hmm, what's going on in this one? It does not check "-h" at all.

Ah, I see. It simply hits the get_git_var() call, sees there is no var
called "-h", and exits with an error. So checking for "-h" up front is
correct. It is an oddball, though not quite the same as the others (the
oddest ball?).

-Peff
