Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F591C433EF
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 19:14:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 67ED761029
	for <git@archiver.kernel.org>; Tue, 14 Sep 2021 19:14:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232388AbhINTPd (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Sep 2021 15:15:33 -0400
Received: from cloud.peff.net ([104.130.231.41]:47354 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232202AbhINTPc (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Sep 2021 15:15:32 -0400
Received: (qmail 25313 invoked by uid 109); 14 Sep 2021 19:14:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 14 Sep 2021 19:14:14 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27172 invoked by uid 111); 14 Sep 2021 19:14:14 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 14 Sep 2021 15:14:14 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 14 Sep 2021 15:14:13 -0400
From:   Jeff King <peff@peff.net>
To:     Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH 5/9] serve: provide "receive" function for session-id
 capability
Message-ID: <YUD0hXddD1+BF82a@coredump.intra.peff.net>
References: <YUC/6n1hhUbMJiLw@coredump.intra.peff.net>
 <YUDAtbHcbv6zNFxe@coredump.intra.peff.net>
 <CAN0heSrCibpcU0NXfZfJvb7puRVLPRz2qEbko6+SEh_BcKtgvA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAN0heSrCibpcU0NXfZfJvb7puRVLPRz2qEbko6+SEh_BcKtgvA@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Sep 14, 2021 at 09:02:10PM +0200, Martin Ågren wrote:

> > I had originally dropped has_capability() in a separate patch, to keep
> > this one more readable. That breaks bisectability, but only with
> > -Werror. I'm not sure where we should fall on that spectrum (I generally
> > bisect with -Wno-error just because warnings may come and go when
> > working with different compilers than what was normal at the time).
> >
> > Not that big a deal either way for this patch, but I wonder if people
> > have opinions in general.
> 
> First of all, agreed about the "not that big a deal" part. Just a random
> thought: You could do the opposite of what Elijah sometimes does by
> first adding a "MAYBE_UNUSED" function, then actually using it. You'd
> add "MAYBE_UNUSED" here, then the next commit would drop the whole
> thing. It could be worth it if you're removing many many lines so that
> the "actual" change gets lost in the noise. But this patch isn't near
> any such threshold, IMHO (if there even is such a "threshold").

Yeah, I considered that (because I had seen Elijah do it; I didn't think
of it myself). I don't love it, if only because now the extra
MAYBE_UNUSED is a head-scratcher for somebody reading the patch. I think
it makes sense if the code will exist in that maybe-unused state for a
while, but here it's just going away immediately anyway. I dunno.

> > +static void session_id_receive(struct repository *r,
> > +                              const char *client_sid)
> > +{
> > +       if (!client_sid)
> > +               client_sid = "";
> > +       trace2_data_string("transfer", NULL, "client-sid", client_sid);
> > +}
> 
> Handling NULL. Nice. :)

Otherwise segfault if the client just says "session-id". :)

To be clear, the old code behaved the same way. It's just that
has_capability() returned the empty string for this case instead of
NULL. I changed get_capability() to distinguish the two so that the
later fixes for "command=ls-refs=whatever" could treat them differently.

I didn't add tests for this case (nor for "object-format" without a
value), but we could do that if anybody cares.

-Peff
