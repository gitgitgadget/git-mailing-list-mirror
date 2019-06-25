Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E17F31F461
	for <e@80x24.org>; Tue, 25 Jun 2019 04:53:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726994AbfFYExH (ORCPT <rfc822;e@80x24.org>);
        Tue, 25 Jun 2019 00:53:07 -0400
Received: from cloud.peff.net ([104.130.231.41]:49366 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726781AbfFYExG (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Jun 2019 00:53:06 -0400
Received: (qmail 26672 invoked by uid 109); 25 Jun 2019 04:53:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 25 Jun 2019 04:53:07 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16620 invoked by uid 111); 25 Jun 2019 04:53:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 25 Jun 2019 00:53:57 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 25 Jun 2019 00:53:04 -0400
Date:   Tue, 25 Jun 2019 00:53:04 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Christian Couder <christian.couder@gmail.com>,
        Pedro Larroy <pedro.larroy.lists@gmail.com>,
        git@vger.kernel.org
Subject: Re: git bisect should return 1 when the first bad commit is found
Message-ID: <20190625045304.GA7626@sigill.intra.peff.net>
References: <CAC_CU1iWBCTt5jLQ0Zp2HoyA0oFgG3shDB2rLfOsmC+x67NdAw@mail.gmail.com>
 <xmqq5zp9wdjb.fsf@gitster-ct.c.googlers.com>
 <CAC_CU1hHK5n4GcETbWFLBeqT_Y9LV6N32Rv0F0+OCXH2G0qg8Q@mail.gmail.com>
 <20190623224935.GD1100@sigill.intra.peff.net>
 <xmqqo92mhlla.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqo92mhlla.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jun 24, 2019 at 11:41:53AM -0700, Junio C Hamano wrote:

> > I think it might be nice for Git to write a well-known refname (like
> > BISECT_RESULT or similar) so that you can refer to that instead of
> > having to read stdout (whether by machine or by a user
> > cutting-and-pasting). And I cannot offhand think of a particular reason
> > why that could not just be HEAD (instead of something bisect-specific)
> > after the bisect finishes.
> 
> As Christian downthread reminds us, that is what the bisect/bad ref
> is (which I totally forgot when I gave the earlier response).  I do
> not think we need a new ref, but I do not think it is so bad to add
> an option "git bisect --exit-code ( --good | --bad ) [<commit-ish>]"
> that makes the command usually exit with non-zero status.  Unless we
> have found the final answer successfully, that is, and in that case
> the command would exit with 0 status to signall "all done".
> 
> But that should be an option.

Ah, right, I forgot that we already have such a ref. So that does seem
like a reasonable way to access it (and as Christian notes, it's
documented as well).  And I agree with you that any exit-code magic
should require the user to ask for it explicitly.

I do think that accessing the bisect/bad ref is a little intimate with
the implementation (i.e., it implies knowing that there is only a single
"bad" that we are moving around, unlike "good", where we may mark many
such tips).

So another option is to put the result in a new ref (bisect/result,
perhaps), but with one twist: delete it at the beginning of a bisection,
so its presence can be used as a marker that the bisection is complete.
I.e., you could do "git rev-parse --verify refs/bisect/result" as an
alternative to "--exit-code". That gives you the added flexibility of
asking "is the bisection done" separately from "do this next bisection
step".

-Peff
