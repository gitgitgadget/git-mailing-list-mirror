Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 25E8E1FC44
	for <e@80x24.org>; Thu, 16 Feb 2017 17:14:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932193AbdBPROx (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Feb 2017 12:14:53 -0500
Received: from cloud.peff.net ([104.130.231.41]:56515 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932254AbdBPROw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Feb 2017 12:14:52 -0500
Received: (qmail 7421 invoked by uid 109); 16 Feb 2017 17:14:52 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 16 Feb 2017 17:14:52 +0000
Received: (qmail 25053 invoked by uid 111); 16 Feb 2017 17:14:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 16 Feb 2017 12:14:53 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 16 Feb 2017 12:14:50 -0500
Date:   Thu, 16 Feb 2017 12:14:50 -0500
From:   Jeff King <peff@peff.net>
To:     Maxim Moseychuk <franchesko.salias.hudro.pedros@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 2/3] bisect_next_all: convert xsnprintf to git_psprintf
Message-ID: <20170216171449.rfn2o2t5ngv7ugxt@sigill.intra.peff.net>
References: <20170216112829.18079-1-franchesko.salias.hudro.pedros@gmail.com>
 <20170216112829.18079-3-franchesko.salias.hudro.pedros@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170216112829.18079-3-franchesko.salias.hudro.pedros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 16, 2017 at 02:28:28PM +0300, Maxim Moseychuk wrote:

> Git can't run bisect between 2048+ commits if use russian translation.
> Reproduce "LANG=ru_RU.UTF8 git bisect start v4.9 v4.8" on linux sources.
> 
> Dummy solution: just increase buffer size but is not safe.
> Size gettext string is a runtime value.

Hmm. I wondered if this used to work (because xsnprintf operated on a
fixed-size fmt) and was broken in the translation. And as a consequence,
if we needed to be searching for other cases with similar bugs.

But no, in this case the fixed-size buffer was actually introduced
during the i18n step from 14dc4899e (i18n: bisect: mark strings for
translation, 2016-06-17).

I guess the other type of bug could still exist, though.

> diff --git a/bisect.c b/bisect.c
> index 21bc6daa4..8670cc97a 100644
> --- a/bisect.c
> +++ b/bisect.c
> @@ -940,7 +940,7 @@ int bisect_next_all(const char *prefix, int no_checkout)
>  	struct commit_list *tried;
>  	int reaches = 0, all = 0, nr, steps;
>  	const unsigned char *bisect_rev;
> -	char steps_msg[32];
> +	char *steps_msg;

So one solution would be to just bump the "32" higher here. The format
comes from the translation, so in practice it only needs to be large
enough to fit any of our translations.

That feels pretty hacky, though. In practice the set of translations is
contained, but it doesn't have to be (and certainly nobody would notice
if a new translation was added with a longer name until a user
complained).

> @@ -990,14 +990,15 @@ int bisect_next_all(const char *prefix, int no_checkout)
>  
>  	nr = all - reaches - 1;
>  	steps = estimate_bisect_steps(all);
> -	xsnprintf(steps_msg, sizeof(steps_msg),
> -		  Q_("(roughly %d step)", "(roughly %d steps)", steps),
> -		  steps);
> +
> +	steps_msg = git_psprintf(Q_("(roughly %d step)", "(roughly %d steps)",
> +		  steps), steps);
>  	/* TRANSLATORS: the last %s will be replaced with
>  	   "(roughly %d steps)" translation */
>  	printf(Q_("Bisecting: %d revision left to test after this %s\n",
>  		  "Bisecting: %d revisions left to test after this %s\n",
>  		  nr), nr, steps_msg);
> +	free(steps_msg);

I wondered if a viable solution would be to make the whole thing one
single translatable string. It would avoid the need for the TRANSLATORS
comment. But I guess we have two "Q_" invocations here, and they might
need to be handled separately (e.g., "2 revisions", "1 step").

I also wondered if we could just make this into two printf statements
("revisions left to test", followed by "roughly N steps").  But the
commit message for 14dc4899e mentions RTL languages. So I think we
really do need to build it up block by block and let the translators
adjust the ordering.

So I think your solution is the best we can do.

It's probably worth outlining these alternatives in the commit message.

-Peff
