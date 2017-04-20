Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3D0191FE90
	for <e@80x24.org>; Thu, 20 Apr 2017 06:17:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S941409AbdDTGRC (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Apr 2017 02:17:02 -0400
Received: from cloud.peff.net ([104.130.231.41]:36609 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S939329AbdDTGRA (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Apr 2017 02:17:00 -0400
Received: (qmail 13783 invoked by uid 109); 20 Apr 2017 06:16:56 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 20 Apr 2017 06:16:56 +0000
Received: (qmail 32393 invoked by uid 111); 20 Apr 2017 06:17:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 20 Apr 2017 02:17:19 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 20 Apr 2017 02:16:53 -0400
Date:   Thu, 20 Apr 2017 02:16:53 -0400
From:   Jeff King <peff@peff.net>
To:     Stephen Kent <smkent@smkent.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] Add color slots for branch names in "git status --short
 --branch"
Message-ID: <20170420061653.y3bhdzw6sx5zavfc@sigill.intra.peff.net>
References: <201704556286334.8b7dc718029e6dd189dadb3703bfa@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <201704556286334.8b7dc718029e6dd189dadb3703bfa@localhost>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Overall this looks good. A few minor nits:

On Wed, Apr 19, 2017 at 10:57:08PM -0700, Stephen Kent wrote:

> Subject: Re: [PATCH] Add color slots for branch names in "git status --short

We usually try to use "subsystem: blah" for our subjects, which makes
them easy to parse when you're looking through a oneline. So probably:

  status: add color config slots for branch names

or something.

> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 475e874..96e9cf8 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -1137,7 +1137,10 @@ color.status.<slot>::
>  	`untracked` (files which are not tracked by Git),
>  	`branch` (the current branch),
>  	`nobranch` (the color the 'no branch' warning is shown in, defaulting
> -	to red), or
> +	to red),
> +	`localBranch` or `remoteBranch` (the local and remote branch names,
> +	respectively, when branch and tracking information is displayed in the
> +	status short-format), or

I wondered if this "short-format" was accurate. But indeed, we do not
seem to color the local/remote branch specially in long-format mode, so
it really is only the short format that is affected.

> diff --git a/builtin/commit.c b/builtin/commit.c
> index 4e288bc..43846d5 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -1263,6 +1263,10 @@ static int parse_status_slot(const char *slot)
>  		return WT_STATUS_NOBRANCH;
>  	if (!strcasecmp(slot, "unmerged"))
>  		return WT_STATUS_UNMERGED;
> +	if (!strcasecmp(slot, "localBranch"))
> +		return WT_STATUS_LOCAL_BRANCH;
> +	if (!strcasecmp(slot, "remoteBranch"))
> +		return WT_STATUS_REMOTE_BRANCH;

Normally we match config names in the code as all lowercase, since the
key names we get from the config parser will be normalized. Here it
works with your mixed-case because you're using strcasecmp(). Obviously
that was picked up from the surrounding code, but I think those existing
strcasecmp() calls could (and perhaps should) just be strcmp().

I don't know if it's worth converting them or not. If we leave them all
as strcasecmp(), I don't mind your camelCase names, for readability.

-Peff
