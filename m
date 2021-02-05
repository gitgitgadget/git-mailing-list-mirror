Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40D55C433DB
	for <git@archiver.kernel.org>; Fri,  5 Feb 2021 10:16:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F1F9964FE8
	for <git@archiver.kernel.org>; Fri,  5 Feb 2021 10:16:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231251AbhBEKPE (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Feb 2021 05:15:04 -0500
Received: from cloud.peff.net ([104.130.231.41]:51446 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229793AbhBEKMl (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Feb 2021 05:12:41 -0500
Received: (qmail 16620 invoked by uid 109); 5 Feb 2021 10:11:49 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 05 Feb 2021 10:11:49 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28997 invoked by uid 111); 5 Feb 2021 10:11:49 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 05 Feb 2021 05:11:49 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 5 Feb 2021 05:11:48 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 0/6] Optionally restrict range-diff output to "left" or
 "right" range only
Message-ID: <YB0Z5JXbe22ko2Mj@coredump.intra.peff.net>
References: <pull.869.git.1612469275.gitgitgadget@gmail.com>
 <xmqqtuqr4frw.fsf@gitster.c.googlers.com>
 <YBx5rmVsg1LJhSKN@nand.local>
 <xmqqtuqr2uz3.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqtuqr2uz3.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 04, 2021 at 04:56:16PM -0800, Junio C Hamano wrote:

> > As an aside: I am curious if I'm missing something when you say the
> > "only way" is to ask for a 'git range-diff ...@{u}'. IIUC what you're
> > describing, I often resort to using 'git cherry' for that exact thing.
> > But, I may not be quite understanding your use-case (and why git-cherry
> > doesn't do what you want already).
> >
> > My latter question is purely for satisfying my own curiosity; I don't
> > have any problem with a '--{left,right}-only' option in range-diff. From
> > my quick read of the patches, it all looks pretty sane to me.
> 
> The question is addressed to Dscho, and I am also somewhat curious.
> Perhaps the reason would be that the output from cherry is not as
> easy to read as range-diff, without any post-processing.

I had the same curiosity; I'd use git-cherry (or rev-list --cherry) for
this.

I suspect the big difference is the quality of the matching. git-cherry
is purely looking at patch-ids. So it is quite likely to say "this was
not applied upstream" when what got applied differed slightly (e.g.,
fixups upstream, applied to a different base, etc). Whereas range-diff
has some cost heuristics for deciding that two patches are basically the
same thing.  So it would find more cases (and as a bonus, give you the
diff to see what tweaks were made upstream).

It does make me wonder if it would be useful for rev-list, etc to have
an option to make "--cherry" use the more clever heuristics instead of
just a patch-id. It would never show the same diff output as range-diff,
but maybe more scripts would find the advanced heuristic useful.

I know it would probably make rebase's "ignore if in upstream" feature
less clunky when I rebase topics. But it would also make it more
dangerous! E.g., right now I see any upstream tweaks as potential
conflicts when I rebase, and I manually review them for sanity.

-Peff
