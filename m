Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CFA1A1F597
	for <e@80x24.org>; Tue, 17 Jul 2018 19:41:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730063AbeGQUP6 (ORCPT <rfc822;e@80x24.org>);
        Tue, 17 Jul 2018 16:15:58 -0400
Received: from cloud.peff.net ([104.130.231.41]:50026 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1729863AbeGQUP5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jul 2018 16:15:57 -0400
Received: (qmail 15212 invoked by uid 109); 17 Jul 2018 19:41:40 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Tue, 17 Jul 2018 19:41:40 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25010 invoked by uid 111); 17 Jul 2018 19:41:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Tue, 17 Jul 2018 15:41:54 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 17 Jul 2018 15:41:48 -0400
Date:   Tue, 17 Jul 2018 15:41:48 -0400
From:   Jeff King <peff@peff.net>
To:     Duy Nguyen <pclouds@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        gitgitgadget@gmail.com, Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] repack -ad: prune the list of shallow commits
Message-ID: <20180717194148.GC30594@sigill.intra.peff.net>
References: <pull.9.git.gitgitgadget@gmail.com>
 <b4e01a963fd16f50d12c1f67c6e64bec8b1e9673.1531513093.git.gitgitgadget@gmail.com>
 <20180713203140.GB17670@sigill.intra.peff.net>
 <nycvar.QRO.7.76.6.1807142351100.75@tvgsbejvaqbjf.bet>
 <20180716173636.GA18636@sigill.intra.peff.net>
 <CACsJy8BV3ii3MkYf6UObsX_JdDbT9ovY_K9dCCeYvQ3FWqnRUQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CACsJy8BV3ii3MkYf6UObsX_JdDbT9ovY_K9dCCeYvQ3FWqnRUQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 17, 2018 at 07:28:07PM +0200, Duy Nguyen wrote:

> On Mon, Jul 16, 2018 at 7:38 PM Jeff King <peff@peff.net> wrote:
> > in a user-visible way. And that's really my question: is pruning here
> > going to bite people unexpectedly (not rhetorical -- I really don't
> > know)?
> 
> If shallow points are no longer reachable, removing them should not
> bite anybody, I think.

I slept on this to see if I could brainstorm any other ways.

The only thing I really came up with is that removing shallows is racy
with respect to the reachability check.  For instance, if "prune" runs
at the same as an incoming shallow fetch, we'll compute the reachability
without holding the shallow lock. Somebody else may write an entry for
an object we've never heard of (because it just showed up), and we'd
erase it, making the repository appear corrupt.

But note that I used "prune" in the above example, because this bug
already exists. So probably we're not changing anything material here.
Though if we wanted to fix it, I think it would require holding the
shallow lock during the reachability analysis, which is probably not
something that repack would want to do. Unlike prune, it then does
a lot of other expensive operations, like delta compression and writing
out the pack, before it would get to the shallow prune.

Although even holding the lock for the duration of "prune" is more than
we need. Shallow commits must be commits, so we don't need to do a full
graph walk (and in my experience there's often an order-of-magnitude
difference between the two; even more so if we're using Stolee's
commit-graph cache).

> > I think in the case of git-prune and prune_shallow(), it's a little
> > tricky, though. It looks like prune_shallow() relies on somebody having
> > marked the SEEN flag, which implies doing a full reachability walk.
> 
> Sorry, my bad for hiding this SEEN flag deep in library code like this
> in eab3296c7e (prune: clean .git/shallow after pruning objects -
> 2013-12-05) But in my defense I didn't realize the horror of sharing
> object flags a year later and added the "object flag allocation" in
> object.h

Sort of an aside to the patch under discussion, but I think it may make
sense for prune_shallow() to take a callback function for determining
whether a commit is reachable.

I have an old patch that teaches git-prune to lazily do the reachability
check, since in many cases "git repack" will have just packed all of the
loose objects. But it just occurred to me that this patch is totally
broken with respect to prune_shallow(), because it would not set the
SEEN flag (I've literally been running with it for years, which goes to
show how often I use the shallow feature).

And if we were to have repack do a prune_shallow(), it may want to use a
different method than traversing and marking each object SEEN.

> > So either we have to do a reachability walk (which is expensive), or we
> > have to rely on some other command (like prune) that is doing a
> > reachability walk and reuse that work.
> 
> Since "git prune" took care of loose objects, if we're going to delete
> some redundant packs, we can perform a reasonably cheap "reachability"
> test in repack, I think. We have the list of new packs from
> pack-objects which should contain all reachable objects (and even some
> unreachable ones). If we traverse all of their idx files and mark as
> SEEN, then whatever shallow points that are not marked SEEN _and_ not
> loose objects could be safely removed.

Hmm. I don't immediately see any reason that would not work with the
current code. But I am a little uncomfortable adding these sorts of
subtle dependencies and assumptions. It feels like we're building a
house of cards.

> I don't see any problem with this either, but then I've not worked on
> shallow code for quite some time. The only potential problem is where
> we do this check. If we check (and drop) shallow points when we read
> .git/info/shallow, then when we write it down some time in the future
> we accidentally prune them. Which might be ok but I feel safer when we
> only prune at one place (prune/gc/repack) where we can be more careful
> and can do more testing.
> 
> If we read the shallow list as-is, then just not send "shallow" lines
> in fetch-pack for shallow points that do not exist, I don't see a
> problem, but it may be a bit more work and we could get to some
> confusing state where upload-pack gives us the same shallow point that
> we have but ignore because we don't have objects behind it. Hm...
> actually I might see a problem :)

Yeah, I agree if we were to do this it would definitely be in a
"read-only" way: let the current command skip those grafts for its
operation, but do not impact the on-disk shallow file. Then races or
other assumptions can at worst impact that operation, and not cause a
lasting corruption (and in particular I think we'd be subject to the
race I described at the start of this mail).

-Peff
