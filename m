Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C4ED01F404
	for <e@80x24.org>; Tue, 23 Jan 2018 00:54:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751307AbeAWAyE (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Jan 2018 19:54:04 -0500
Received: from cloud.peff.net ([104.130.231.41]:54010 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751253AbeAWAyD (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Jan 2018 19:54:03 -0500
Received: (qmail 13868 invoked by uid 109); 23 Jan 2018 00:54:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 23 Jan 2018 00:54:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 12984 invoked by uid 111); 23 Jan 2018 00:54:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 22 Jan 2018 19:54:40 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 22 Jan 2018 19:54:01 -0500
Date:   Mon, 22 Jan 2018 19:54:01 -0500
From:   Jeff King <peff@peff.net>
To:     Lars Schneider <larsxschneider@gmail.com>
Cc:     Simon Ruderich <simon@ruderich.org>, lars.schneider@autodesk.com,
        git@vger.kernel.org, gitster@pobox.com, tboegi@web.de,
        j6t@kdbg.org, sunshine@sunshineco.com, ramsay@ramsayjones.plus.com,
        Johannes.Schindelin@gmx.de
Subject: Re: [PATCH v4 5/6] convert: add 'working-tree-encoding' attribute
Message-ID: <20180123005401.GG26357@sigill.intra.peff.net>
References: <20180120152418.52859-1-lars.schneider@autodesk.com>
 <20180120152418.52859-6-lars.schneider@autodesk.com>
 <20180121142222.GA10248@ruderich.org>
 <05265803-BD74-4667-ABB5-9752E55A5015@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <05265803-BD74-4667-ABB5-9752E55A5015@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 22, 2018 at 01:35:25PM +0100, Lars Schneider wrote:

> >> +	enc = xcalloc(1, sizeof(struct convert_driver));
> > 
> > I think this should be "sizeof(struct encoding)" but I prefer
> > "sizeof(*enc)" which prevents these kind of mistakes.
> 
> Great catch! Thank you!
> 
> Other code paths are at risk of this problem too. Consider this:
> 
> $ git grep 'sizeof(\*' | wc -l
>      303
> $ git grep 'sizeof(struct ' | wc -l
>      208
> 
> E.g. even in the same file (likely where I got the code from):
> https://github.com/git/git/blob/59c276cf4da0705064c32c9dba54baefa282ea55/convert.c#L780
> 
> @Junio: 
> Would you welcome a patch that replaces "struct foo" with "*foo"
> if applicable?

This is part of the reason we've been moving to helpers like
ALLOC_ARRAY(), which make it harder to get this wrong.

We don't have an ALLOC_OBJECT(), which is what you would want here. I'm
not sure if that is helpful or crossing the line of "you're obscuring it
to the point that people familiar with C have trouble reading the code".
The ALLOC_ARRAY() macros have been sort of an experiment there (I tend
to like them, but I also work with Git's code often enough that I am not
likely to be confused by our bespoke macros).

But anyway, that was a bit of a tangent. Certainly the smaller change is
just standardizing on sizeof(*foo), which I think most people agree on
at this point. It might be worth putting in CodingGuidelines.

-Peff
