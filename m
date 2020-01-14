Return-Path: <SRS0=o1/V=3D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7E04C33C9E
	for <git@archiver.kernel.org>; Tue, 14 Jan 2020 21:16:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B6E4A24672
	for <git@archiver.kernel.org>; Tue, 14 Jan 2020 21:16:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728779AbgANVQy (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Jan 2020 16:16:54 -0500
Received: from cloud.peff.net ([104.130.231.41]:36542 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727285AbgANVQy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Jan 2020 16:16:54 -0500
Received: (qmail 10176 invoked by uid 109); 14 Jan 2020 21:16:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 14 Jan 2020 21:16:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25328 invoked by uid 111); 14 Jan 2020 21:23:08 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 14 Jan 2020 16:23:08 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 14 Jan 2020 16:16:53 -0500
From:   Jeff King <peff@peff.net>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, me@ttaylorr.com, newren@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 4/8] sparse-checkout: cone mode does not recognize "**"
Message-ID: <20200114211653.GB3949560@coredump.intra.peff.net>
References: <pull.513.git.1579029962.gitgitgadget@gmail.com>
 <dfa7e204449c8958d35cc01261d2dc8099d7ce0c.1579029963.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <dfa7e204449c8958d35cc01261d2dc8099d7ce0c.1579029963.git.gitgitgadget@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 14, 2020 at 07:25:58PM +0000, Derrick Stolee via GitGitGadget wrote:

> From: Derrick Stolee <dstolee@microsoft.com>
> 
> When core.sparseCheckoutCone is enabled, the 'git sparse-checkout set'
> command creates a restricted set of possible patterns that are used
> by a custom algorithm to quickly match those patterns.
> 
> If a user manually edits the sparse-checkout file, then they could
> create patterns that do not match these expectations. The cone-mode
> matching algorithm can return incorrect results. The solution is to
> detect these incorrect patterns, warn that we do not recognize them,
> and revert to the standard algorithm.
> 
> Check each pattern for the "**" substring, and revert to the old
> logic if seen. While technically a "/<dir>/**" pattern matches
> the meaning of "/<dir>/", it is not one that would be written by
> the sparse-checkout builtin in cone mode. Attempting to accept that
> pattern change complicates the logic and instead we punt and do
> not accept any instance of "**".

That all makes sense.

> diff --git a/dir.c b/dir.c
> index 22d08e61c2..f8e350dda2 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -651,6 +651,13 @@ static void add_pattern_to_hashsets(struct pattern_list *pl, struct path_pattern
>  		return;
>  	}
>  
> +	if (strstr(given->pattern, "**")) {
> +		/* Not a cone pattern. */
> +		pl->use_cone_patterns = 0;
> +		warning(_("unrecognized pattern: '%s'"), given->pattern);
> +		goto clear_hashmaps;
> +	}

The clear_hashmaps label already unsets pl->use_cone_patterns, so the
first line is redundant (the same is true of existing goto jumps, as
well, though).

I wondered whether this warning could be triggered accidentally by
somebody who just happened to add such a pattern. But we'd exit
immediately from add_pattern_to_hashsets() immediately unless the user
has set core.sparseCheckoutCone. And if that's set, then warning is
definitely the right thing to do.

-Peff
