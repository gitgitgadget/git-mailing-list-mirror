Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B8DFE1F403
	for <e@80x24.org>; Tue, 19 Jun 2018 17:48:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1030335AbeFSRst (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Jun 2018 13:48:49 -0400
Received: from cloud.peff.net ([104.130.231.41]:48680 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1030303AbeFSRst (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jun 2018 13:48:49 -0400
Received: (qmail 1925 invoked by uid 109); 19 Jun 2018 17:48:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 19 Jun 2018 17:48:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15220 invoked by uid 111); 19 Jun 2018 17:49:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 19 Jun 2018 13:49:06 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 19 Jun 2018 13:48:47 -0400
Date:   Tue, 19 Jun 2018 13:48:47 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        avarab@gmail.com, gitster@pobox.com
Subject: Re: [PATCH 0/7] grep.c: teach --column to 'git-grep(1)'
Message-ID: <20180619174846.GA27820@sigill.intra.peff.net>
References: <cover.1529365072.git.me@ttaylorr.com>
 <20180619163506.GB22034@sigill.intra.peff.net>
 <5282e3bb-bf7a-ab3a-98dc-d29ff1c37468@web.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5282e3bb-bf7a-ab3a-98dc-d29ff1c37468@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 19, 2018 at 07:33:39PM +0200, René Scharfe wrote:

> > The key thing about this iteration is that it doesn't regress
> > performance, because we always short-circuit where we used to. The other
> > obvious route is to stop short-circuiting only when "--column" is in
> > effect, which would have the same property (at the expense of a little
> > extra code in match_expr_eval()).
> 
> The performance impact of the exhaustive search for --color scales with
> the number of shown lines, while it would scale with the total number of
> lines for --column.  Coloring the results of highly selective patterns
> is relatively cheap, short-circuiting them still helps significantly.

I thought that at first, too, but I think we'd still scale with the
number of shown lines. We're talking about short-circuiting OR, so by
definition we stop the short-circuit because we matched the first half
of the OR.

If you stop short-circuiting AND, then yes, you incur a penalty for
every line. But I don't think --column would need to do that.

Although there are interesting cases around inversion. For example:

  git grep --not \( --not -e a --and --not -e b \)

is equivalent to:

  git grep -e a --or -e b

Do people care if we actually hunt down the exact column where we
_didn't_ match "b" in the first case?  The two are equivalent, but I
have to wonder if somebody writing the first one really cares.

> Disabling that optimization for --column wouldn't be a regression since
> it's a new option..  Picking a random result (based on the order of
> evaluation) seems sloppy and is probably going to surprise users.

I don't see it as a random result; short-circuiting logic is well
understood and we follow the user's ordering.

I think the place where it's _most_ ugly is "--column --color", where we
may color the short-circuited value in the second pass.

> We could add an optimizer pass to reduce the number of regular
> expressions in certain cases if that is really too slow.  E.g. this:

Yes, we actually discussed this kind of transformation. I think it's way
out of scope for this patch series, though. If we do anything more, I
think it should be to disable short-circuiting when --column is in use.

-Peff
