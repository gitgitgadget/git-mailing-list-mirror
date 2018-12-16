Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 26857211B3
	for <e@80x24.org>; Sun, 16 Dec 2018 10:25:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729819AbeLPKZr (ORCPT <rfc822;e@80x24.org>);
        Sun, 16 Dec 2018 05:25:47 -0500
Received: from cloud.peff.net ([104.130.231.41]:43220 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726164AbeLPKZr (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Dec 2018 05:25:47 -0500
Received: (qmail 23405 invoked by uid 109); 16 Dec 2018 10:25:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 16 Dec 2018 10:25:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 22258 invoked by uid 111); 16 Dec 2018 10:25:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sun, 16 Dec 2018 05:25:18 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 16 Dec 2018 05:25:45 -0500
Date:   Sun, 16 Dec 2018 05:25:45 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Brandon Williams <bwilliamseng@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH 1/3] serve: pass "config context" through to individual
 commands
Message-ID: <20181216102544.GA13704@sigill.intra.peff.net>
References: <20181211104236.GA6899@sigill.intra.peff.net>
 <20181211104342.GA7233@sigill.intra.peff.net>
 <xmqqo99oeu4u.fsf@gitster-ct.c.googlers.com>
 <20181214082050.GA11777@sigill.intra.peff.net>
 <xmqq5zvvd418.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq5zvvd418.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Dec 15, 2018 at 09:31:15AM +0900, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I actually started by doing that, but "struct serve_options" is not
> > currently known by ls-refs.c, upload-pack.c, etc. So they'd have to
> > start including "serve.h". I don't think that's the end of the world,
> > but it felt like a funny mutual circular to me (my mental model now is
> > that ls-refs, upload-pack, etc are low-level commands, tied together by
> > the "serve" stuff).
> 
> That matches my mental model, too.  I think the difference between
> us is what *_opt struct is.  I viewed that it was like diff_options
> struct where the driving machinery keeps state of the ongoing
> operation performed by lower level routines to fulfill the request
> by the API caller, i.e. holding both wish from the caller, and
> scratchpad data for the mchinery and the lower level routine to
> communicate with each other.
> 
> And the new field feels like the last "scratchpad used by the
> machinery to tell lower-level ls-refs helper what context it is
> operting in".

Yeah, I agree that such a "pass this through" struct full of options and
context would make sense. I just wouldn't tie it to the "serve"
machinery.

Did you read the side-thread between me and Jonathan? Another option
here is to just have ls-refs assume that the client will tell it the
context (and assume uploadpack for now, since that's all that v2
currently does).

That would make this patch go away entirely. :)

-Peff
