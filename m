Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 69781201A9
	for <e@80x24.org>; Sat, 25 Feb 2017 01:27:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751507AbdBYB1p (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Feb 2017 20:27:45 -0500
Received: from cloud.peff.net ([104.130.231.41]:33813 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751455AbdBYB1o (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Feb 2017 20:27:44 -0500
Received: (qmail 28691 invoked by uid 109); 25 Feb 2017 01:21:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 25 Feb 2017 01:21:03 +0000
Received: (qmail 19558 invoked by uid 111); 25 Feb 2017 01:21:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 24 Feb 2017 20:21:07 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 24 Feb 2017 20:21:00 -0500
Date:   Fri, 24 Feb 2017 20:21:00 -0500
From:   Jeff King <peff@peff.net>
To:     David Lang <david@lang.hm>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Ian Jackson <ijackson@chiark.greenend.org.uk>,
        Joey Hess <id@joeyh.name>, git@vger.kernel.org
Subject: Re: SHA1 collisions found
Message-ID: <20170225012100.ivfdlwspsqd7bkhf@sigill.intra.peff.net>
References: <20170223164306.spg2avxzukkggrpb@kitenet.net>
 <22704.19873.860148.22472@chiark.greenend.org.uk>
 <xmqq60jz5wbm.fsf@gitster.mtv.corp.google.com>
 <20170224233929.p2yckbc6ksyox5nu@sigill.intra.peff.net>
 <nycvar.QRO.7.75.62.1702241656010.6590@qynat-yncgbc>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.75.62.1702241656010.6590@qynat-yncgbc>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 24, 2017 at 05:00:55PM -0800, David Lang wrote:

> On Fri, 24 Feb 2017, Jeff King wrote:
> 
> > 
> > So I'd much rather see strong rules like:
> > 
> >  1. Once a repo has flag-day switched over to the new hash format[1],
> >     new references are _always_ done with the new hash. Even ones that
> >     point to pre-flag-day objects!
> 
> how do you define when a repo has "switched over" to the new format in a
> distributed environment?

You don't. It's a decision for each local repo, but the rules push
everybody towards upgrading (because you forbid them pulling from or
pushing to people who have upgraded).

So in practice, some centralized distribution point switches, and then
it floods out from there.

> so you have one person working on a project that switches their version of
> git to the new one that uses the new format.

That shouldn't happen when they switch. It should happen when they
decide to move their local clone to the new format. So let's assume they
upgrade _and_ decide to switch.

> But other people they interact with still use older versions of git

Those people get forced to upgrade if they want to continue interacting.

> what happens when you have someone working on two different projects where
> one has switched and the other hasn't?

See above. You only flip the flag on for one of the projects.

> what if they are forks of each other? (LEDE and OpenWRT, or just
> linux-kernel and linux-kernel-stable)

Once one flips, the other one needs to flip to, or can't interact with
them. I know that's harsh, and is likely to create headaches. But in the
long run, I think once everything has converged the resulting system is
less insane.

For that reason I _wouldn't_ recommend projects like the kernel flip the
flag immediately. Ideally we write the code and the new versions
permeate the community. Then somebody (per-project) decides that it's
time for the community to start switching.

> >     The flag-day switch would probably be a repo config flag based on
> >     repositoryformatversion (so old versions would just punt if they
> >     see it). Let's call this flag "newhash" for lack of a better term.
> 
> so how do you interact with someone who only expects the old commit instead
> of the commit-v2?

You ask them to upgrade.

-Peff
