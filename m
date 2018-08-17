Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CB0341F954
	for <e@80x24.org>; Fri, 17 Aug 2018 17:33:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727467AbeHQUhY (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Aug 2018 16:37:24 -0400
Received: from cloud.peff.net ([104.130.231.41]:58912 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727365AbeHQUhY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Aug 2018 16:37:24 -0400
Received: (qmail 1033 invoked by uid 109); 17 Aug 2018 17:33:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 17 Aug 2018 17:33:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 26146 invoked by uid 111); 17 Aug 2018 17:33:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 17 Aug 2018 13:33:14 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 17 Aug 2018 13:33:08 -0400
Date:   Fri, 17 Aug 2018 13:33:08 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        =?utf-8?B?TWljaGHFgiBHw7Nybnk=?= <mgorny@gentoo.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] refactor various if (x) FREE_AND_NULL(x) to just
 FREE_AND_NULL(x)
Message-ID: <20180817173308.GA9111@sigill.intra.peff.net>
References: <1534498806.1262.8.camel@gentoo.org>
 <20180817130250.20354-1-avarab@gmail.com>
 <CACsJy8DH2tESV4xkCYutH=Ye37zGwifGdJhdnNOsRd+JusdOwg@mail.gmail.com>
 <20180817151012.GA20262@duynguyen.home>
 <xmqqpnyhaq93.fsf@gitster-ct.c.googlers.com>
 <xmqqlg94c46f.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqlg94c46f.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 17, 2018 at 10:07:36AM -0700, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > It is a bit sad that
> >
> > 	- if (E)
> > 	  FREE_AND_NULL(E);
> >
> > is not sufficient to catch it.  Shouldn't we be doing the same for
> > regular free(E) as well?  IOW, like the attached patch.
> > ...
> 
> And revised even more to also spell "E" as "E != NULL" (and "!E" as
> "E == NULL"), which seems to make a difference, which is even more
> sad.  I do not want to wonder if I have to also add "NULL == E" and
> other variants, so I'll stop here.

I think it makes sense that these are all distinct if you're using
coccinelle to do stylistic transformations between them (e.g., enforcing
curly braces even around one-liners).

I wonder if there is a way to "relax" a pattern where these semantically
equivalent cases can all be covered automatically. I don't know enough
about the tool to say.

I guess one way to do it would be to normalize the style in one rule
(e.g., always "!E" instead of "E == NULL"), and then you only have to
write the FREE_AND_NULL rule for the normalized form. For a single case
like this, the end result is about the same number of rules, but in the
long term it saves us work when we have a similar transformation.

-Peff
