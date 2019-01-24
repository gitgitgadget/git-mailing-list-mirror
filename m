Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B00F91F453
	for <e@80x24.org>; Thu, 24 Jan 2019 21:26:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727720AbfAXV0K (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Jan 2019 16:26:10 -0500
Received: from cloud.peff.net ([104.130.231.41]:48088 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726095AbfAXV0K (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Jan 2019 16:26:10 -0500
Received: (qmail 15629 invoked by uid 109); 24 Jan 2019 21:26:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 24 Jan 2019 21:26:10 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32767 invoked by uid 111); 24 Jan 2019 21:26:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 24 Jan 2019 16:26:14 -0500
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 Jan 2019 16:26:08 -0500
Date:   Thu, 24 Jan 2019 16:26:08 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Nickolai Belakovski <nbelakovski@gmail.com>, git@vger.kernel.org,
        Rafael =?utf-8?B?QXNjZW5zw6Nv?= <rafa.almas@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v6 1/3] ref-filter: add worktreepath atom
Message-ID: <20190124212608.GD16114@sigill.intra.peff.net>
References: <20190122232301.95971-1-nbelakovski@gmail.com>
 <CAC05386q2iGoiJ_fRgwoOTF23exEN2D1+oh4VjajEvYQ58O1TQ@mail.gmail.com>
 <20190122232301.95971-2-nbelakovski@gmail.com>
 <xmqq36pjcicw.fsf@gitster-ct.c.googlers.com>
 <CAC05384+KjC=4_ZF9BrxweMUjwpkaGXNqRNSnwif6yci6TxMMw@mail.gmail.com>
 <xmqq5zud52ut.fsf@gitster-ct.c.googlers.com>
 <20190124183235.GA16580@sigill.intra.peff.net>
 <xmqqd0olj1kj.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqd0olj1kj.fsf@gitster-ct.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 24, 2019 at 11:30:20AM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > What if you have other atoms that need worktrees? E.g., does
> > %(worktreepath:foo) use the same used_atom slot? What if we have another
> > worktree-related atom?
> > ...
> > And that one is a good example where we _do_ need the global, because we
> > already have multiple atoms pulling from it.
> 
> I guess that we broke the original atom design by mistake when we
> added ":<modifiers>" support.  There should have been one layer of
> indirection that binds the instances of the same atom with different
> modifiers together---I agree with you that we cannot avoid globals
> without fixing that mistake first.

Yes, that's one way to fix it.

I actually think the biggest mistake is having that used_atoms list in
the first place, as we iterate over it several times asking "can we fill
this in yet?". The way pretty.c does it is just to incrementally parse
the commit, saving intermediate results. And in cat-file.c, we figure
out what we need ahead of time in a single pass, and then just fill it
in for each object (which sort of works out the same, but doesn't
require that the parsing needed for item X is a strict superset of item
Y).

So I'd much rather see us parse the format into a real tree of nodes,
and figure out (once) which properties of each object are required to
fulfill that. Then for each object, we grab those properties, and then
walk the tree to generate the output string.

-Peff
