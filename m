Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 461561F403
	for <e@80x24.org>; Tue, 19 Jun 2018 16:35:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S966771AbeFSQfJ (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Jun 2018 12:35:09 -0400
Received: from cloud.peff.net ([104.130.231.41]:48514 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S966582AbeFSQfI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jun 2018 12:35:08 -0400
Received: (qmail 31475 invoked by uid 109); 19 Jun 2018 16:35:08 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 19 Jun 2018 16:35:08 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 14391 invoked by uid 111); 19 Jun 2018 16:35:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 19 Jun 2018 12:35:25 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 19 Jun 2018 12:35:06 -0400
Date:   Tue, 19 Jun 2018 12:35:06 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, avarab@gmail.com, gitster@pobox.com
Subject: Re: [PATCH 0/7] grep.c: teach --column to 'git-grep(1)'
Message-ID: <20180619163506.GB22034@sigill.intra.peff.net>
References: <cover.1529365072.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1529365072.git.me@ttaylorr.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 18, 2018 at 06:43:01PM -0500, Taylor Blau wrote:

> Attached is a ``fresh start'' of my series to teach 'git grep --column'.
> Since the last time I sent this, much has changed, notably the semantics
> for deciding which column is the first when given (1) extended
> expressions and (2) --invert.
> 
> Both (1) and (2) are described in-depth in patch 2/7, but I am happy to
> answer more questions should they arise here. Peff and I worked on this
> together off-list, and we are both happy with the semantics, and believe
> that it covers most reasonable cases.

So with the exception of some minor type-quibbling in patch 4, this all
looks good to me. Since we discussed this quite a bit off-list, you can
take that review either with a giant grain of salt (reviewing something
I helped to generate in the first place) or a ringing endorsement (I
thought about it a lot more than I would have for a normal review ;) ).

> The notable case that it does _not_ cover is matching the following
> line:
> 
>   a ... b
> 
> with the following expression
> 
>   git grep --column -e b --or -e a
> 
> This will produce the column for 'b' rather than the column for 'a',
> since we short-circuit an --or when the left child finds a match, in
> this case 'b'. So, we break the semantics for this case, at the benefit
> of not having to do twice the work.
> 
> In the future, I'd like to revisit this, since any performance gains
> that we _do_ make in this area are moot when we rescan all lines in
> show_line() with --color. A path forward, I imagine, would look like a
> list of regmatch_t's, or a set of locations in the expression tree, such
> that we could either enumerate the list or walk the tree in order to
> colorize the line. But, I think for now that is #leftoverbits.

The key thing about this iteration is that it doesn't regress
performance, because we always short-circuit where we used to. The other
obvious route is to stop short-circuiting only when "--column" is in
effect, which would have the same property (at the expense of a little
extra code in match_expr_eval()).

-Peff
