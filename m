Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 866231F597
	for <e@80x24.org>; Mon, 16 Jul 2018 21:22:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728522AbeGPVvP (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Jul 2018 17:51:15 -0400
Received: from cloud.peff.net ([104.130.231.41]:48532 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1728300AbeGPVvO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jul 2018 17:51:14 -0400
Received: (qmail 16499 invoked by uid 109); 16 Jul 2018 21:21:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 16 Jul 2018 21:21:50 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15799 invoked by uid 111); 16 Jul 2018 21:22:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 16 Jul 2018 17:22:04 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 16 Jul 2018 17:21:59 -0400
Date:   Mon, 16 Jul 2018 17:21:59 -0400
From:   Jeff King <peff@peff.net>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] gc: do not warn about too many loose objects
Message-ID: <20180716212159.GH25189@sigill.intra.peff.net>
References: <20180716172717.237373-1-jonathantanmy@google.com>
 <20180716191505.857-1-newren@gmail.com>
 <20180716195226.GB25189@sigill.intra.peff.net>
 <CABPp-BGdzyhPkFYyocqArtMX8=cDKFuV88q3mboeaTDjt275Tw@mail.gmail.com>
 <20180716203847.GE25189@sigill.intra.peff.net>
 <CABPp-BEpCF9FE7eJwZWjY+bMsjDQnnDaSrHO+e3DtDDsR-=7Hg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABPp-BEpCF9FE7eJwZWjY+bMsjDQnnDaSrHO+e3DtDDsR-=7Hg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 16, 2018 at 02:09:43PM -0700, Elijah Newren wrote:

> >> Um, except it doesn't actually do that.  The testcase I provided shows
> >> that it leaves around 10000 objects that are totally deletable and
> >> were only previously referenced by reflog entries -- entries that gc
> >> removed without removing the corresponding objects.
> >
> > What's your definition of "totally deletable"?
> 
> The point of gc is to: expire reflogs, repack referenced objects, and
> delete loose objects that (1) are no longer referenced and (2) are
> "old enough".
> 
> The "old enough" bit is the special part here.  Before the gc, those
> objects were referenced (only by old reflog entries) and were found in
> a pack.  git currently writes those objects out to disk and gives them
> the age of the packfile they are contained in, which I think is the
> source of the bug.  We have a reference for those objects from the
> reflogs, know they aren't referenced anywhere else, so those objects
> to me are the age of those reflog entries: 90 days.  As such, they are
> "old enough" and should be deleted.

OK, I see what you're saying, but...

> I never got around to fixing it properly, though, because 'git prune'
> is such a handy workaround that for now.  Having people nuke all their
> loose objects is a bit risky, but the only other workaround people had
> was to re-clone (waiting the requisite 20+ minutes for the repo to
> download) and throw away their old clone.  (Though some people even
> went that route, IIRC.)

If we were to delete those objects, wouldn't it be exactly the same as
running "git prune"? Or setting your gc.pruneExpire to "now" or even "5
minutes"?  Or are you concerned with taking other objects along for the
ride that weren't part of old reflogs? I think that's a valid concern,
but it's also an issue for objects which were previously referenced in
a reflog, but are part of another current operation.

Also, what do you do if there weren't reflogs in the repo? Or the
reflogs were deleted (e.g., because branch deletion drops the associated
reflog entirely)?

> With big repos, it's easy to get into situations where there are well
> more than 10000 objects satisfying these conditions.  In fact, it's
> not all that rare that the repo has far more loose objects after a git
> gc than before.

Yes, this is definitely a wart and I think is worth addressing.

> I totally agree with your general plan to put unreferenced loose
> objects into a pack.  However, I don't think these objects should be
> part of that pack; they should just be deleted instead.

I assume by "these objects" you mean ones which used to be reachable
from a reflog, but that reflog entry just expired.  I think you'd be
sacrificing some race-safety in that case.

If the objects went into a pack under a race-proof scheme, would that
actually bother you? Is it the 10,000 objects that's a problem, or is it
the horrible I/O from exploding them coupled with the annoying auto-gc
behavior?

-Peff
