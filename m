Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 82B7D1F4C0
	for <e@80x24.org>; Fri, 25 Oct 2019 22:11:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726375AbfJYWLU (ORCPT <rfc822;e@80x24.org>);
        Fri, 25 Oct 2019 18:11:20 -0400
Received: from cloud.peff.net ([104.130.231.41]:58782 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1725801AbfJYWLU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Oct 2019 18:11:20 -0400
Received: (qmail 20550 invoked by uid 109); 25 Oct 2019 22:11:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 25 Oct 2019 22:11:20 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14541 invoked by uid 111); 25 Oct 2019 22:14:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 25 Oct 2019 18:14:27 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 25 Oct 2019 18:11:19 -0400
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>,
        Alexandr Miloslavskiy via GitGitGadget 
        <gitgitgadget@gmail.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 1/1] vreportf: Fix interleaving issues, remove 4096
 limitation
Message-ID: <20191025221118.GA29213@sigill.intra.peff.net>
References: <pull.407.git.1571755147.gitgitgadget@gmail.com>
 <pull.407.v2.git.1571755538.gitgitgadget@gmail.com>
 <54f0d6f6b53dd4fdd6e4129c942de8002459fd88.1571755538.git.gitgitgadget@gmail.com>
 <nycvar.QRO.7.76.6.1910251034110.46@tvgsbejvaqbjf.bet>
 <e7002f76-65d3-607f-3b5a-e242938374f7@syntevo.com>
 <nycvar.QRO.7.76.6.1910251548560.46@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.1910251548560.46@tvgsbejvaqbjf.bet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 25, 2019 at 04:02:36PM +0200, Johannes Schindelin wrote:

> ... and indeed, I verified that this patch fixes the problem:
> 
> -- snip --
> diff --git a/usage.c b/usage.c
> index 2fdb20086bd..7f5bdfb0f40 100644
> --- a/usage.c
> +++ b/usage.c
> @@ -10,13 +10,16 @@ void vreportf(const char *prefix, const char *err, va_list params)
>  {
>  	char msg[4096];
>  	char *p;
> -
> -	vsnprintf(msg, sizeof(msg), err, params);
> +	size_t off = strlcpy(msg, prefix, sizeof(msg));
> +	int ret = vsnprintf(msg + off, sizeof(msg) - off, err, params);
>  	for (p = msg; *p; p++) {
>  		if (iscntrl(*p) && *p != '\t' && *p != '\n')
>  			*p = '?';
>  	}
> -	fprintf(stderr, "%s%s\n", prefix, msg);
> +	if (ret > 0) {
> +		msg[off + ret] = '\n'; /* we no longer need a NUL */
> +		write_in_full(2, msg, off + ret + 1);
> +	}
>  }

Heh. This is quite similar to what I posted in:

  https://public-inbox.org/git/20190828145412.GB14432@sigill.intra.peff.net/

though I missed the cleverness with "we no longer need a NUL" to get an
extra byte. ;)

> > except truncation to 4096. Then I would expect a patch to increase
> > buffer size to 8192 in the next couple years. And if you also try to
> > solve truncation, it will get you very close to my code.
> 
> My point is: I don't want to "fix" truncation. I actually think of it as
> a feature. An error message that is longer than the average news article
> I read is too long, period.

Yeah. As the person responsible for many of the "avoid truncation" works
referenced in the original patch, I have come to the conclusion that it
is not worth the complexity. Even when we do manage to produce a
gigantic error message correctly, it's generally not very readable.

That's basically what I came here to say, and I was pleased to find that
you had already argued for it quite well. So I'll just add my support
for the direction you've taken the conversation.

I _do_ wish we could do the truncation more intelligently. I'd much
rather see:

  error: unable to open 'absurdly-long-file-name...': permission denied

than:

  error: unable to open 'absurdly-long-file-name-that-goes-on-forever-and-ev

But I don't think it's possible without reimplementing snprintf
ourselves.

-Peff
