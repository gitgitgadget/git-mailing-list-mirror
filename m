Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D5C921F404
	for <e@80x24.org>; Thu,  5 Apr 2018 21:51:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752552AbeDEVvj (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Apr 2018 17:51:39 -0400
Received: from cloud.peff.net ([104.130.231.41]:55072 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752463AbeDEVvi (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Apr 2018 17:51:38 -0400
Received: (qmail 8315 invoked by uid 109); 5 Apr 2018 21:51:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 05 Apr 2018 21:51:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19612 invoked by uid 111); 5 Apr 2018 21:52:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 05 Apr 2018 17:52:39 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 05 Apr 2018 17:51:36 -0400
Date:   Thu, 5 Apr 2018 17:51:36 -0400
From:   Jeff King <peff@peff.net>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
Subject: Re: [PATCH v3 1/2] builtin/config.c: treat type specifiers singularly
Message-ID: <20180405215136.GA29117@sigill.intra.peff.net>
References: <20180328234719.595-1-me@ttaylorr.com>
 <20180404060743.39278-1-me@ttaylorr.com>
 <20180404060743.39278-2-me@ttaylorr.com>
 <CAPig+cRNSYz_guBS9yNEXdAbfG+FWtvnzwsWRu0DRe0N_VkiOQ@mail.gmail.com>
 <20180405015304.GB4671@syl.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180405015304.GB4671@syl.local>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 04, 2018 at 06:53:04PM -0700, Taylor Blau wrote:

> > I understand that you're doing this to avoid complaining about "--int
> > --type=int", but exactly how that case is supported should be an
> > implementation detail; it doesn't need to bleed into the UI as an
> > unnecessary and not-well-justified loosening of an age-old
> > restriction. There are other ways to support "--int --type=int"
> > without "last wins". Also, do we really need to support "--int
> > --type=int"? Is that an expected use-case?
> 
> This is a fair concern, though I view the problem slightly differently.
> I see this change as being motivated by the fact that we are adding
> "--type", not removing an age-old restriction.
> 
> Peff's motivation for this--as I understand it--is that "--type=int"
> should be a _true_ synonym for "--int". Adopting the old-style
> "OPT_SET_BIT" for this purpose makes "--type=int" and "--int" _mostly_ a
> synonym for one another, except that "--type=bool --type=int" will not
> complain, whereas "--bool --int" would.
> 
> Loosening this restriction, in my view, brings us closer (1) to the new
> semantics of multiple "--type"'s, and (2) to the existing semantics of
> "--verbose=1 --verbose=2" as you mentioned above.
> 
> I would like to hear Peff's take on this as well, since he suggested the
> patch originally, and would likely provide the clearest insight into
> this.

I think you've captured it fairly well.  The options _are_ semantically
linked, in that they are all mutually-exclusive types. Obviously we
could continue to flag errors, and even catch "--type=int --type=bool"
in the same way if we really wanted to (by using a custom parse-options
callback).

So I think the primary value here is in the code cleanup. Even without
the new "--type" option, avoiding the bitset makes the code clearer
(IMHO).

I do agree that a user saying "--int --bool" is almost certainly an
error, and they'd be just as happy to see an error message as to get the
last-one-wins behavior. But I also doubt that it comes up very much
either way.

-Peff
