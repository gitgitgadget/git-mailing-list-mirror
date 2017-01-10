Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 12F4B205C9
	for <e@80x24.org>; Tue, 10 Jan 2017 09:16:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757959AbdAJJPu (ORCPT <rfc822;e@80x24.org>);
        Tue, 10 Jan 2017 04:15:50 -0500
Received: from cloud.peff.net ([104.130.231.41]:37439 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757566AbdAJJOa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jan 2017 04:14:30 -0500
Received: (qmail 29759 invoked by uid 109); 10 Jan 2017 09:14:29 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 10 Jan 2017 09:14:29 +0000
Received: (qmail 12264 invoked by uid 111); 10 Jan 2017 09:15:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 10 Jan 2017 04:15:21 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 10 Jan 2017 04:14:26 -0500
Date:   Tue, 10 Jan 2017 04:14:26 -0500
From:   Jeff King <peff@peff.net>
To:     Martin Fick <mfick@codeaurora.org>
Cc:     repo-discuss@googlegroups.com, jmelvin@codeaurora.org,
        jgit-dev@eclipse.org, git@vger.kernel.org
Subject: Re: Preserve/Prune Old Pack Files
Message-ID: <20170110091426.n6qnh6szgdojp6zw@sigill.intra.peff.net>
References: <24abd0ed58c25ce832014f9bd5bb2090@codeaurora.org>
 <5172470.bsscxDU4yv@mfick1-lnx>
 <20170109062137.zghmurndlbts5x44@sigill.intra.peff.net>
 <1802755.dVE0WDQbpH@mfick1-lnx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1802755.dVE0WDQbpH@mfick1-lnx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 09, 2017 at 09:17:56AM -0700, Martin Fick wrote:

> > I suspect the name-change will break a few tools that you
> > might want to use to look at a preserved pack (like
> > verify-pack).  I know that's not your primary use case,
> > but it seems plausible that somebody may one day want to
> > use a preserved pack to try to recover from corruption. I
> > think "git index-pack --stdin
> > <objects/packs/preserved/pack-123.old-pack" could always
> > be a last-resort for re-admitting the objects to the
> > repository.
> 
> or even a simple manual rename/move back to its orginal 
> place?

Yes, that would work. There's not a tool to do it, but it's a fairly
straightforward transformation.

> [loose objects]
> Where would you suggest we store those?  Maybe under 
> ".git/objects/preserved/<xx>/<sha1>"?  Do they need to be 
> renamed also somehow to avoid a find?

It would make sense to me to have a single "preserved" root, with
"<xx>/<sha1>.old" and "packs/pack-<sha1>.old-pack" together under it.

You could also move the objects out of objects/ entirely. Say, to
".git/preserved-objects" or something. Then you could probably do away
with the filename munging altogether, and "restoring" an object or pack
would be a simple "mv" or "cp" (or you could even add preserved-objects
to $GIT_ALTERNATE_OBJECT_DIRECTORIES if you wanted to do a single
operation looking at both sets).

That's all outside the scope of your original purpose (which I think was
just to keep the files _somewhere_ so that the open descriptor stays
valid on NFS). But maybe it would make other related things more
convenient. I dunno. I'm just speaking off the top of my head.

> > That's _way_ more complicated than your problem, and as I
> > said, I do not have a finished solution. But it seems
> > like they touch on a similar concept (a post-delete
> > holding area for objects). So I thought I'd mention it in
> > case if spurs any brilliance.
> 
> I agree, this is a problem I have wanted to solve also.  I 
> think having a "preserved" directory does open the door to 
> such "recovery" solutions, although I think you would 
> actually want to modify the many read code paths to fall 
> back to looking at the preserved area and performing 
> immediate "recovery" of the pack file if it ends up being 
> needed.

In my (admittedly not very concrete) plan, the read code paths
_wouldn't_ know to look in the preserved area. It would be up to the
repacking process to rollback in case of a race. That does open a period
(between the faux delete and the rollback) where readers may be broken.
But that's much better than the state today, which is that the readers
are broken, and that breakage persists forever.

But there may be other better ways of doing it.  What we're really
talking about is a transactional system where neither side locks (or at
least not for an appreciable amount of time), and one side is capable of
falling back and modifying its operation when there's a relevant race.
There's probably some research in this area and some standard solutions,
but it's not an area I'm overly familiar with (and building any solution
on top of POSIX filesystem semantics adds an extra challenge).

> That's a lot of work, but having the packs (and 
> eventually the loose objects) preserved into a location 
> where no new references will be built to depend on them is 
> likely the first step.  Does the name "preserved" do well for 
> that use case also, or would there be some better name, what 
> would a transactional system call them?

I wasn't going to bikeshed, but since you ask...:)

"preserved" to me sounds like something we'd be keeping forever. These
objects are more in a "pending delete" state, or a purgatory. Maybe
something along those lines would be more appropriate.

-Peff
