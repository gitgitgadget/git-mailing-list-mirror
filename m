Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3DF2C4361A
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 21:00:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85EF822CF6
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 21:00:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbgLDVAp (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Dec 2020 16:00:45 -0500
Received: from cloud.peff.net ([104.130.231.41]:52300 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726021AbgLDVAp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Dec 2020 16:00:45 -0500
Received: (qmail 865 invoked by uid 109); 4 Dec 2020 21:00:05 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 04 Dec 2020 21:00:05 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16641 invoked by uid 111); 4 Dec 2020 21:00:04 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 04 Dec 2020 16:00:04 -0500
Authentication-Results: peff.net; auth=none
Date:   Fri, 4 Dec 2020 16:00:04 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Ben Denhartog <ben@sudoforge.com>, git@vger.kernel.org
Subject: Re: Unexpected behavior with branch.*.{remote,pushremote,merge}
Message-ID: <X8qjVAGlrYJWO5fc@coredump.intra.peff.net>
References: <a4ae4e1a-b457-4b35-878c-2714ebfc415f@www.fastmail.com>
 <X8oL190Vl03B0cQ/@coredump.intra.peff.net>
 <112958f6-0eca-453d-86f3-52e7054a88f9@www.fastmail.com>
 <xmqq360lfios.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq360lfios.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Dec 04, 2020 at 11:57:23AM -0800, Junio C Hamano wrote:

> > * Refactor away from usage of FETCH_HEAD
> 
> Yes, "fetch --all" is about updating the remote-tracking branches
> and in retrospect, perhaps we might have avoided confusion if we
> made it not to touch FETCH_HEAD, but it is not going to change now.

I think its behavior of appending all of the entries is sensible (or at
least is the least-surprising thing). The only weird part is that it
does not keep the "make sure heads for merging come before not-for-merge
entries" property that individual ones have.

It could take a final pass after all of the sub-fetches have run and do
that. I don't have any plans to work on it, but I'm tempted to call it a
#leftoverbits candidate.

> > * Set `remote.pushdefault = origin`
> > * Set `push.default = current` (instead of `simple`, and is what
> > my global config sets this to)
> 
> I have a feeling that simple vs current does not make a difference
> if you are pusing main to main, and if so, push.default could be
> left to the default settings of 'simple'.  But the key to successful
> use of the triangular workflow is to configure so that "fetch/pull"
> goes to one place (i.e. your upstream) and "push" goes to another
> (i.e. your publishing repository), and "remote.pushdefault" is a
> good ingredient to do so.

I think my advice is just out-of-date (by quite a lot). In the early
days, I remember being bitten by (or at least confused by) simple and
how its use of upstream could work with multiple remotes. But we long
ago fixed that, with ed2b18292b (push: change `simple` to accommodate
triangular workflows, 2013-06-19), and these days it is explicitly
documented to work the same as "current" when pushing to another remote.

> It is however more common to use 'origin' as the name of your
> upstream repository (so that "git fetch" and "git pull" would grab
> things from there by default) and set remote.pushdefault to the
> remote you push into, though (iow, I found remote.pushdefault
> pointing at 'origin' a bit unusual).  Doing so may make your
> triangular workflow work smoother.

Yeah, I wasn't going to nitpick his remote names, but that's the same
convention I use. :) If people have custom forks of a repository that I
access, I usually just name the remote for them after their username
(including my own).

-Peff
