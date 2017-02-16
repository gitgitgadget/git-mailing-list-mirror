Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 33F681FC44
	for <e@80x24.org>; Thu, 16 Feb 2017 17:26:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932704AbdBPR0m (ORCPT <rfc822;e@80x24.org>);
        Thu, 16 Feb 2017 12:26:42 -0500
Received: from cloud.peff.net ([104.130.231.41]:56519 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932465AbdBPR0l (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Feb 2017 12:26:41 -0500
Received: (qmail 8404 invoked by uid 109); 16 Feb 2017 17:26:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 16 Feb 2017 17:26:40 +0000
Received: (qmail 25088 invoked by uid 111); 16 Feb 2017 17:26:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 16 Feb 2017 12:26:42 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 16 Feb 2017 12:26:38 -0500
Date:   Thu, 16 Feb 2017 12:26:38 -0500
From:   Jeff King <peff@peff.net>
To:     Maxim Moseychuk <franchesko.salias.hudro.pedros@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 3/3] stop_progress_msg: convert xsnprintf to git_psprintf
Message-ID: <20170216172638.m6obbuca2nqpudeo@sigill.intra.peff.net>
References: <20170216112829.18079-1-franchesko.salias.hudro.pedros@gmail.com>
 <20170216112829.18079-4-franchesko.salias.hudro.pedros@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170216112829.18079-4-franchesko.salias.hudro.pedros@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 16, 2017 at 02:28:29PM +0300, Maxim Moseychuk wrote:

> Replace local safe string buffer allocation by git_psprintf.

Hmm. Is this one actually broken in practice?

I see:

> @@ -243,21 +243,18 @@ void stop_progress_msg(struct progress **p_progress, const char *msg)
>  	*p_progress = NULL;
>  	if (progress->last_value != -1) {
>  		/* Force the last update */
> -		char buf[128], *bufp;
> -		size_t len = strlen(msg) + 5;
> +		char *bufp;

We have a fixed-size buffer here, but...

>  		struct throughput *tp = progress->throughput;
>  
> -		bufp = (len < sizeof(buf)) ? buf : xmallocz(len);

If it's not big enough we allocate a new one. So this works for any size
of translated string. It just tries to skip the allocation in the
"short" case.

If this were in the normal progress code, I might care more about trying
to skip an allocation for performance. But since this is just in
stop_progress_msg(), I don't think the complexity is worth it.  I'm
especially happy to see the magic "5" above go away.

So I think this is worth doing, but the motivation is a simplification,
not a bugfix.

>  		if (tp) {
>  			unsigned int rate = !tp->avg_misecs ? 0 :
>  					tp->avg_bytes / tp->avg_misecs;
>  			throughput_string(&tp->display, tp->curr_total, rate);
>  		}
>  		progress_update = 1;
> -		xsnprintf(bufp, len + 1, ", %s.\n", msg);
> +		bufp = git_psprintf(", %s.\n", msg);
>  		display(progress, progress->last_value, bufp);
> -		if (buf != bufp)
> -			free(bufp);
> +		free(bufp);

This parts looks good (modulo using xstrfmt). It's probably worth
renaming "bufp" to the more usual "buf", I would think.

I do wonder if the punctuation here will give translators headaches.
E.g., in a RTL language you probably wouldn't want that period at the
end. I don't know enough to say, so I'm willing to punt on that for now.
But I suspect in the long run we may need to just take the whole
translated message, punctuation included, from the caller. There are
only two callers that actually provide a string.

-Peff
