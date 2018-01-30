Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.4 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7B7351F404
	for <e@80x24.org>; Tue, 30 Jan 2018 16:41:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752628AbeA3Qlw (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Jan 2018 11:41:52 -0500
Received: from cloud.peff.net ([104.130.231.41]:34126 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751410AbeA3Qlv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Jan 2018 11:41:51 -0500
Received: (qmail 22997 invoked by uid 109); 30 Jan 2018 16:41:51 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 30 Jan 2018 16:41:51 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16255 invoked by uid 111); 30 Jan 2018 16:42:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 30 Jan 2018 11:42:30 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 30 Jan 2018 11:41:49 -0500
Date:   Tue, 30 Jan 2018 11:41:48 -0500
From:   Jeff King <peff@peff.net>
To:     Patryk Obara <patryk.obara@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Johannes.Schindelin@gmx.de, sbeller@google.com,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH v2 1/1] setup: recognise extensions.objectFormat
Message-ID: <20180130164148.GA5053@sigill.intra.peff.net>
References: <cover.1517098675.git.patryk.obara@gmail.com>
 <e430ad029facdd6209927d352f0e7545cdd0e435.1517098675.git.patryk.obara@gmail.com>
 <20180130013759.GA27694@sigill.intra.peff.net>
 <e3c203f8-7971-40ce-8d9e-2dfe35f51a8a@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e3c203f8-7971-40ce-8d9e-2dfe35f51a8a@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 30, 2018 at 05:30:04PM +0100, Patryk Obara wrote:

> > I don't have a strong opinion on this, but it does feel a little funny
> > to add this extension now, before we quite know what the code that uses
> > it is going to look like (or maybe we're farther along there than I
> > realize).
> 
> Code using this is already in master - in the result of overwriting
> data->hash_algo, every piece of code, that was modernised starts using
> the selected hash algorithm (through the_hash_algo) instead of hardcoded
> sha-1.

Right, that part seems pretty simple. But in the long run, is that going
to be enough for the hash transition? My impression is that the
transition document is going to require a more nuanced view than "this
is the hash algorithm for this repo".

Putting code in master is OK; we can always refactor it. But once we
add and document a user-facing config option like this, we have to
support it forever. So that's really the step I was wondering about: are
we sure this is what the user-facing config is going to look like?

> > What do we gain by doing this now as opposed to later? By the design of
> > the extension code, we should complain on older versions anyway. And by
> > doing it now we carry a small risk that it might not give us the
> > interface we want, and it will be slightly harder to paper over this
> > failed direction.
> 
> Mostly convenience for developers, who want to work on transition. There's
> no need to re-compile only for changing default hashing algorithm (which is
> useful for testing and debugging). I could carry this patch around to every
> NewHash-related branch, that I work on but it's annoying me already ;)

OK, that makes some sense to me. Even if we may end up with a more
nuanced config later, this is useful for getting the first step done:
just making a standalone NewHash repo without worrying about
interoperation with existing history.

> > I originally wrote it the other way out of an abundance of
> > backward-compatibility. After all "extension.*" doesn't mean anything in
> > format 0, and somebody _could_ have added such a config key for their
> > own purposes. But that's a pretty weak argument, and if we are going to
> > start marking some extensions as forbidden there, we might as well do
> > them all.
> 
> What about users, who are using new version of Git, but have it
> misconfigured with preciousObjects and repo format 0? That's why I decided
> to make repo format check specific to objectFormat extension (initially I
> made it generic to all extensions).

But that's sort of my point. It appears to be working, but the
prior-version safety they think they have is not there. I think we're
better off erring on the side of caution here, and letting them know
forcefully that their config is bogus.

> At the same time... there's extension.partialclone in pu and it does not
> have check on repo format.

IMHO it should (and we should just do it by enforcing it for all
extensions automatically).

-Peff
