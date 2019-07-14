Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D0C691F461
	for <e@80x24.org>; Sun, 14 Jul 2019 00:57:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728095AbfGNAvc (ORCPT <rfc822;e@80x24.org>);
        Sat, 13 Jul 2019 20:51:32 -0400
Received: from cloud.peff.net ([104.130.231.41]:35766 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728026AbfGNAvb (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 13 Jul 2019 20:51:31 -0400
Received: (qmail 2176 invoked by uid 109); 14 Jul 2019 00:51:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 14 Jul 2019 00:51:31 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13457 invoked by uid 111); 14 Jul 2019 00:52:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sat, 13 Jul 2019 20:52:27 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 13 Jul 2019 20:51:29 -0400
Date:   Sat, 13 Jul 2019 20:51:29 -0400
From:   Jeff King <peff@peff.net>
To:     Carlo Arenas <carenas@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        GIT Mailing-list <git@vger.kernel.org>
Subject: Re: [PATCH] range-diff: fix some 'hdr-check' and sparse warnings
Message-ID: <20190714005129.GA4525@sigill.intra.peff.net>
References: <e6796c60-a870-e761-3b07-b680f934c537@ramsayjones.plus.com>
 <41a60e60-d2c0-7d54-5456-e44d106548a4@kdbg.org>
 <xmqqy313p5hn.fsf@gitster-ct.c.googlers.com>
 <ec635d0d-00ca-2419-3c1a-9b0343b46daa@kdbg.org>
 <xmqq1rytpqse.fsf@gitster-ct.c.googlers.com>
 <CAPUEspgD8E02FcNvBx96neGEejdqMDWoH8NgpsHyGPo_KM09FA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPUEspgD8E02FcNvBx96neGEejdqMDWoH8NgpsHyGPo_KM09FA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jul 13, 2019 at 03:22:03PM -0700, Carlo Arenas wrote:

> On Sat, Jul 13, 2019 at 2:29 PM Junio C Hamano <gitster@pobox.com> wrote:
> >
> > I wish if we could say
> >
> >         struct patch patch = {};
> 
> that is actually a GNU extension that is supported by gcc and clang (at least)
> and that sparse also recognizes as valid; it is also valid C++ so it might be
> even supported by MSVC.
> 
> it will obviously trigger warnings if using pedantic mode and is IMHO not worth
> the hassle to maintain in a portable codebase like git, but also wish could be
> added to C2X

I wonder if we could come up with a definition of INIT_ZERO such that:

  struct foo bar = { INIT_ZERO };

worked everywhere. IMHO that is more readable than "{}" anyway. In
GNU-compatible compilers, it is just:

  #define INIT_ZERO

Unfortunately I can't think of a fallback that would work universally.
It cannot just be "0", as we run into the NULL thing (not to mention
when the first member is itself a struct). It does not help us to
add an explicit cast, because the type of the cast is dependent on the
context in which the macro is used. Nor do I think typeof() could save
us (if we could even assume it exists everywhere we need the fallback,
which we almost certainly can't).

But it does seem a real shame there is no way to say "zero-initialize
this struct" in C without providing at least a single member value.
Ordering struct definitions to put an arithmetic type at the start is an
OK workaround (to just let "0" work everywhere). But it does fall down
when the first element _has_ to be a struct (like, say, any user of our
hashmap.[ch] interface).

-Peff
