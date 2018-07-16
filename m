Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E06E1F597
	for <e@80x24.org>; Mon, 16 Jul 2018 22:55:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729593AbeGPXYy (ORCPT <rfc822;e@80x24.org>);
        Mon, 16 Jul 2018 19:24:54 -0400
Received: from cloud.peff.net ([104.130.231.41]:48806 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1729466AbeGPXYy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jul 2018 19:24:54 -0400
Received: (qmail 20918 invoked by uid 109); 16 Jul 2018 22:55:11 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 16 Jul 2018 22:55:11 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 16786 invoked by uid 111); 16 Jul 2018 22:55:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 16 Jul 2018 18:55:25 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 16 Jul 2018 18:55:20 -0400
Date:   Mon, 16 Jul 2018 18:55:20 -0400
From:   Jeff King <peff@peff.net>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] gc: do not warn about too many loose objects
Message-ID: <20180716225520.GC12482@sigill.intra.peff.net>
References: <20180716172717.237373-1-jonathantanmy@google.com>
 <20180716191505.857-1-newren@gmail.com>
 <20180716195226.GB25189@sigill.intra.peff.net>
 <CABPp-BGdzyhPkFYyocqArtMX8=cDKFuV88q3mboeaTDjt275Tw@mail.gmail.com>
 <20180716203847.GE25189@sigill.intra.peff.net>
 <CABPp-BEpCF9FE7eJwZWjY+bMsjDQnnDaSrHO+e3DtDDsR-=7Hg@mail.gmail.com>
 <20180716212159.GH25189@sigill.intra.peff.net>
 <CABPp-BHFinoE1=1bOhiwOrYpLB+kB3yAKbNg77K9kqKDH_1JLA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABPp-BHFinoE1=1bOhiwOrYpLB+kB3yAKbNg77K9kqKDH_1JLA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jul 16, 2018 at 03:07:34PM -0700, Elijah Newren wrote:

> > If we were to delete those objects, wouldn't it be exactly the same as
> > running "git prune"? Or setting your gc.pruneExpire to "now" or even "5
> > minutes"?  Or are you concerned with taking other objects along for the
> > ride that weren't part of old reflogs? I think that's a valid concern,
> 
> Yes, I was worried about taking other objects along for the ride that
> weren't part of old reflogs.
> 
> > but it's also an issue for objects which were previously referenced in
> > a reflog, but are part of another current operation.
> 
> I'm not certain what you're referring to here.

I mean that an ongoing operation could refer to a blob that just
recently became unreachable via reflog pruning. And then we would delete
it, leaving the repository corrupt.

One of the protections we have against that is that if I ask to write
blob XYZ and we find that we already have the object, Git will freshen
the mtime of the loose object or pack that contains it, protecting it
from pruning. But with your suggestion, we'd delete it immediately,
regardless of the mtime of the containing pack.

Another way to think of it is this: a reflog mentioning an object does
not mean it is the exclusive user of that object. So when we expire it,
that does not mean that it is OK to delete it immediately; there may be
other users.

> > Also, what do you do if there weren't reflogs in the repo? Or the
> > reflogs were deleted (e.g., because branch deletion drops the associated
> > reflog entirely)?
> 
> Yes, there are issues this rule won't help with, but in my experience
> it was a primary (if not sole) actual cause in practice.  (I believe I
> even said elsewhere in this thread that I knew there were unreachable
> objects for other reasons and they might also become large in number).
> At $DAYJOB we've had multiple people including myself hit the "too
> many unreachable loose objects" nasty loop issue (some of us multiple
> different times), and as far as I can tell, most (perhaps even all) of
> them would have been avoided by just "properly" deleting garbage as
> per my object-age-is-reflog-age-if-not-otherwise-referenced rule.

I agree with you that this is a frequent cause, and probably even the
primary one. But my concern is that your loosening increases the risk of
corruption for other cases.

> > I assume by "these objects" you mean ones which used to be reachable
> > from a reflog, but that reflog entry just expired.  I think you'd be
> > sacrificing some race-safety in that case.
> 
> Is that inherently any more race unsafe than 'git prune
> --expire=2.weeks.ago'?  I thought it'd be racy in the same ways, and
> thus a tradeoff folks are already accepting (at least implicitly) when
> running git-gc.  Since these objects are actually 90 days old rather
> than a mere two weeks, it actually seemed more safe to me.  But maybe
> I'm overlooking something with the pack->loose transition that makes
> it more racy?

I think it's worse in terms of race-safety because you're losing one of
the signals that users of the objects can provide to git-prune to tell
it the object is useful: updating the mtime. So yes, you think of the
objects as "90 days old", but we don't know if there are other users.
Has somebody else been accessing them in the meantime?

To be honest, I'm not sure how meaningful that distinction is in
practice. The current scheme is still racy, even if the windows are
shorter in some circumstances. But it seems like cruft packfiles are
a similar amount of work to your scheme, cover more cases, and are
slightly safer. And possibly even give us a long-term route to true
race-free pruning (via the "garbage pack" mark that Jonathan mentioned).

Assuming you buy into the idea that objects in a cruft-pack are not
hurting anything aside from a little wasted storage for up to 2 weeks
(which it sounds like you're at least partially on board with ;) ).

-Peff
