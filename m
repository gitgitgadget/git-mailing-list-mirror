Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D23E320248
	for <e@80x24.org>; Tue,  2 Apr 2019 14:27:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728448AbfDBO1D (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 Apr 2019 10:27:03 -0400
Received: from cloud.peff.net ([104.130.231.41]:44284 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726436AbfDBO1D (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Apr 2019 10:27:03 -0400
Received: (qmail 29777 invoked by uid 109); 2 Apr 2019 14:27:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 02 Apr 2019 14:27:02 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 23600 invoked by uid 111); 2 Apr 2019 14:27:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 02 Apr 2019 10:27:28 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 02 Apr 2019 10:27:00 -0400
Date:   Tue, 2 Apr 2019 10:27:00 -0400
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Duy Nguyen <pclouds@gmail.com>,
        Luke Mewburn <luke@mewburn.net>, git@vger.kernel.org
Subject: Re: [PATCH v2 3/4] progress: clear previous progress update
 dynamically
Message-ID: <20190402142700.GA10564@sigill.intra.peff.net>
References: <20190325103844.26749-1-szeder.dev@gmail.com>
 <20190401115217.3423-1-szeder.dev@gmail.com>
 <20190401115217.3423-4-szeder.dev@gmail.com>
 <20190401132959.GB11664@sigill.intra.peff.net>
 <20190401141542.GJ32732@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190401141542.GJ32732@szeder.dev>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 01, 2019 at 04:15:42PM +0200, SZEDER Gábor wrote:

> > I don't think it could matter here, as these are meant to be smallish
> > strings, but I think we should get into the habit of using size_t
> > consistently to hold string lengths.
> > 
> > It makes auditing for integer overflow problems much simpler (this is on
> > my mind as I happen to be tracing some bugs around this the past few
> > days).
> > 
> > (There are a few instances in the next patch, too. Other than this nit,
> > though, your series looks good to me).
> 
> I started with using size_t, but then switched to int, because:
> 
>   - After a bit of arithmetic I had to compare to term_columns()'s int
>     return value anyway (in the next patch).
> 
>   - The second hunk in this patch adds these lines:
> 
>         int clear_len = counters_sb->len < last_count_len ?
>                         last_count_len - counters_sb->len : 0;
>         fprintf(stderr, "%s: %s%-*s", progress->title,
>                 counters_sb->buf, clear_len, eol);
> 
>     Here 'clear_len' has to be int, because the printf() format "%-*s"
>     expects an int, and otherwise -Werror=format= errors ensue.  OK,
>     it could be size_t, but then it must be casted to an int upon
>     passing it to fprintf(), and after the next patch there will be
>     three such calls.
> 
> I could resend using size_t.  Should I resend using size_t? :)

IMHO it's better to keep it as a size_t for as long as possible, and
then cast when we pass to printf, for a few reasons:

  1. The cast is made explicitly, so it calls attention to it.

  2. We know that a cast to int there can at worst produce truncated
     output, and not lead to any kind of memory error. (And if we really
     care about that, it's easy to convert it to an fwrite() at that
     point, though I would not bother in this case).

I think the comparison to "cols" is OK, because we are just checking
whether cols is smaller than us. If we assume that size_t is at least as
big as an int (which I think is a reasonable assumption to make, and
certainly holds true for all platforms I know) then there's no
possibility of logic errors.

I wouldn't even bother with a cast there. Probably -Wsign-compare would
complain, but we are pretty far from enabling that. And I think the
right solution is for term_columns() to return an unsigned, anyway. ;)

I admit all of this is academic enough that I can live with it either
way (there are definitely places where it is _not_ academic, so I am
mostly just trying to encourage a general style).

-Peff
