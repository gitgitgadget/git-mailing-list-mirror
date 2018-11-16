Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 927701F87F
	for <e@80x24.org>; Fri, 16 Nov 2018 08:56:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727584AbeKPTH1 (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Nov 2018 14:07:27 -0500
Received: from cloud.peff.net ([104.130.231.41]:41858 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727398AbeKPTH1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Nov 2018 14:07:27 -0500
Received: (qmail 29508 invoked by uid 109); 16 Nov 2018 08:56:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 16 Nov 2018 08:56:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25381 invoked by uid 111); 16 Nov 2018 08:55:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Fri, 16 Nov 2018 03:55:26 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 16 Nov 2018 03:56:03 -0500
Date:   Fri, 16 Nov 2018 03:56:03 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        git@vger.kernel.org, "H . Merijn Brand" <h.m.brand@xs4all.nl>,
        Harald Nordgren <haraldnordgren@gmail.com>,
        Olga Telezhnaia <olyatelezhnaya@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH] ref-filter: don't look for objects when outside of a
 repository
Message-ID: <20181116085602.GB20828@sigill.intra.peff.net>
References: <xmqq5zytpa65.fsf@gitster-ct.c.googlers.com>
 <20181114122725.18659-1-szeder.dev@gmail.com>
 <20181115093844.GA14218@sigill.intra.peff.net>
 <20181115094320.GA18790@sigill.intra.peff.net>
 <xmqq36s1libw.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq36s1libw.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 16, 2018 at 02:09:07PM +0900, Junio C Hamano wrote:

> >> I see problems in both directions:
> >> 
> >>  - sorting by "objectname" works now, but it's marked with SOURCE_OBJ,
> >>    and would be forbidden with your patch.  I'm actually not sure if
> >>    SOURCE_OBJ is accurate; we shouldn't need to access the object to
> >>    show it (and we are probably wasting effort loading the full contents
> >>    for tools like for-each-ref).
> >> 
> >>    However, that's not the full story. For objectname:short, it _does_ call
> >>    find_unique_abbrev(). So we expect to have an object directory.
> >
> > Oops, I'm apparently bad at reading. It is in fact SOURCE_OTHER, which
> > makes sense (outside of this whole "--sort outside a repo thing").
> >
> > But we'd ideally distinguish between "objectname" (which should be OK
> > outside a repo) and "objectname:short" (which currently segfaults).
> 
> Arguably, use of ref-filter machinery in ls-remote, whether it is
> given from inside or outside a repo, was a mistake in 1fb20dfd
> ("ls-remote: create '--sort' option", 2018-04-09), as the whole
> point of "ls-remote" is to peek the list of refs and it is perfectly
> normal that the objects listed are not available.

I think it's conceptually reasonable to use the ref-filter machinery.
It's just that it was underprepared to handle this out-of-repo case. I
think we're not too far off, though.

> "ls-remote --sort=authorname" that is run in a repository may not
> segfault on a ref that points at a yet-to-be-fetched commit, but it
> cannot be doing anything sensible.  Is it still better to silently
> produce a nonsense result than refusing to --sort no matter what the
> sort keys are, whether we are inside or outside a repository?

I don't think we produce silent nonsense in the current code (or after
any of the discussed solutions), either in a repo or out. We say "fatal:
missing object ..." inside a repo if the request cannot be fulfilled.
That's not incredibly illuminating, perhaps, but it means we fulfill
whatever we _can_ on behalf of the user's request, and bail otherwise.

If you are arguing that even in a repo we should reject "authorname"
early (just as we would outside of a repo), I could buy that.
Technically we can make it work sometimes (if we happen to have fetched
everything the other side has), but behaving consistently (and with a
decent error message) may trump that.

-Peff
