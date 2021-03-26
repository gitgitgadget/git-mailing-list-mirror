Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64207C433DB
	for <git@archiver.kernel.org>; Fri, 26 Mar 2021 07:44:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F289F61992
	for <git@archiver.kernel.org>; Fri, 26 Mar 2021 07:44:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229589AbhCZHnq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 26 Mar 2021 03:43:46 -0400
Received: from cloud.peff.net ([104.130.231.41]:49614 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229671AbhCZHno (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 26 Mar 2021 03:43:44 -0400
Received: (qmail 28933 invoked by uid 109); 26 Mar 2021 07:43:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 26 Mar 2021 07:43:43 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 8821 invoked by uid 111); 26 Mar 2021 07:43:45 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 26 Mar 2021 03:43:45 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 26 Mar 2021 03:43:43 -0400
From:   Jeff King <peff@peff.net>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     git <git@vger.kernel.org>
Subject: Re: Distinguishing FF vs non-FF updates in the reflog?
Message-ID: <YF2Qr/ClD4a3jCUQ@coredump.intra.peff.net>
References: <CAFQ2z_MefCwiWdhs0buJv5Zok+nsgaOvUCcsSnfm_PP0WozZKA@mail.gmail.com>
 <YFOuT6L0dsrCGTBk@coredump.intra.peff.net>
 <CAFQ2z_N8tCMZG62rNSY=HoRGuKnfk1W-Y_GOXz3SeaZO6=cWWA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFQ2z_N8tCMZG62rNSY=HoRGuKnfk1W-Y_GOXz3SeaZO6=cWWA@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 22, 2021 at 03:40:46PM +0100, Han-Wen Nienhuys wrote:

> > I left some numbers in another part of the thread, but IMHO performance
> > isn't that compelling a reason to do this these days, if you are using
> > commit-graphs.
> >
> > Just walking the reflog might be _slightly_ faster, though not
> > necessarily (it depends on whether the depth of the object graph or the
> > depth of the reflog chain is deeper). It might matter more if you are
> > using a more exotic storage scheme, where switching from accessing
> > reflogs to objects implies extra round-trips to a server (e.g., custom
> > storage backends with JGit; I don't know the state of the art in what
> > Google is doing there).
> 
> JGit doesn't currently support commit-graph, so it's hard to predict
> what performance will be like, but isn't commit-graph is keyed by
> SHA1? That makes it hard to do caching, especially when considering
> large repositories.

Yes, it's keyed by sha1. It's essentially replacing "inflate the commit
object and parse it" with "here are the parsed values as mmap-able
32-bit integer fields" (there's some other stuff with generation
numbers, too, but the main speedup is simply that accessing each commit
is orders of magnitude cheaper).

It caches well, because those properties of the commit are immutable.
But if you meant "when pulling data from the commit-graph file, is it
friendly to block cache", then no, it's not linear. You'd binary search
within it to find each commit, just as you would a pack .idx (and just
like a .idx, I'd expect a system that is pulling data from a network
source to want to grab the whole commit-graph file. They tend to be much
smaller than the main .idx for a given repo).

> AFAIU, commit-graph would help speed up reachability checks, by being
> able to shortcut cases where the commit number proves that some commit
> is not ancestor of the other, but you still have to do a revwalk to
> conclusively prove reachability.

Right. You'll still walk a lot of the commits, but you'll do so much
faster (the generation numbers can also help prune some uninteresting
side paths, but again, I think the main value for this operation is just
getting the parent info much faster).

-Peff
