Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 902AE20254
	for <e@80x24.org>; Sun, 26 Feb 2017 21:30:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751299AbdBZVaq (ORCPT <rfc822;e@80x24.org>);
        Sun, 26 Feb 2017 16:30:46 -0500
Received: from cloud.peff.net ([104.130.231.41]:34473 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751292AbdBZVaq (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Feb 2017 16:30:46 -0500
Received: (qmail 6982 invoked by uid 109); 26 Feb 2017 21:30:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 26 Feb 2017 21:30:45 +0000
Received: (qmail 24636 invoked by uid 111); 26 Feb 2017 21:30:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 26 Feb 2017 16:30:50 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 26 Feb 2017 16:30:42 -0500
Date:   Sun, 26 Feb 2017 16:30:42 -0500
From:   Jeff King <peff@peff.net>
To:     Thomas Braun <thomas.braun@virtuell-zuhause.de>
Cc:     Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>,
        Joey Hess <id@joeyh.name>, git@vger.kernel.org
Subject: Re: SHA1 collisions found
Message-ID: <20170226213042.rd55ykgymmr37c7n@sigill.intra.peff.net>
References: <20170223164306.spg2avxzukkggrpb@kitenet.net>
 <9cedbfa5-4095-15d8-639c-0e3b9b98d6b9@gmail.com>
 <20170224230604.nt37uw5y3uehukfd@sigill.intra.peff.net>
 <8e98a9f9-a431-9170-df9d-24ad8ec59ed7@virtuell-zuhause.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <8e98a9f9-a431-9170-df9d-24ad8ec59ed7@virtuell-zuhause.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, Feb 26, 2017 at 07:57:19PM +0100, Thomas Braun wrote:

> While reading about the subject I came across [1]. The author reduced
> the hash size to 4bits and then played around with git.
> 
> Diff taken from the posting (not my code)
> --- git-2.7.0~rc0+next.20151210.orig/block-sha1/sha1.c
> +++ git-2.7.0~rc0+next.20151210/block-sha1/sha1.c
> @@ -246,6 +246,8 @@ void blk_SHA1_Final(unsigned char hashou
>     blk_SHA1_Update(ctx, padlen, 8);
> 
>     /* Output hash */
> -   for (i = 0; i < 5; i++)
> -       put_be32(hashout + i * 4, ctx->H[i]);
> +   for (i = 0; i < 1; i++)
> +       put_be32(hashout + i * 4, (ctx->H[i] & 0xf000000));
> +   for (i = 1; i < 5; i++)
> +       put_be32(hashout + i * 4, 0);
>  }

Yeah, that is a lot more flexible for experimenting. Though I'd think
you'd probably want more than 4 bits just to avoid accidental
collisions. Something like 24 bits gives you some breathing space (you'd
expect a random collision after 4096 objects), but it's still easy to
do a preimage attack if you need to.

-Peff
