Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 221371F731
	for <e@80x24.org>; Wed, 31 Jul 2019 04:26:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387480AbfGaE0E (ORCPT <rfc822;e@80x24.org>);
        Wed, 31 Jul 2019 00:26:04 -0400
Received: from cloud.peff.net ([104.130.231.41]:56444 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S2387473AbfGaE0E (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Jul 2019 00:26:04 -0400
Received: (qmail 11250 invoked by uid 109); 31 Jul 2019 04:26:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 31 Jul 2019 04:26:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 13456 invoked by uid 111); 31 Jul 2019 04:27:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 31 Jul 2019 00:27:47 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 31 Jul 2019 00:26:02 -0400
From:   Jeff King <peff@peff.net>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Matt McCutchen <matt@mattmccutchen.net>
Subject: Re: [PATCH 0/4] gc docs: modernize and fix the documentation
Message-ID: <20190731042601.GA26559@sigill.intra.peff.net>
References: <20190318161502.7979-1-avarab@gmail.com>
 <20190318215107.GH29661@sigill.intra.peff.net>
 <87ftrjer8s.fsf@evledraar.gmail.com>
 <20190319001829.GL29661@sigill.intra.peff.net>
 <878svjj4t5.fsf@evledraar.gmail.com>
 <20190507075158.GG28060@sigill.intra.peff.net>
 <8736lnxlig.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8736lnxlig.fsf@evledraar.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 10, 2019 at 01:20:55AM +0200, Ævar Arnfjörð Bjarmason wrote:

> > Michael Haggerty and I have (off-list) discussed variations on that, but
> > it opens up a lot of new issues.  Moving something into quarantine isn't
> > atomic. So you've still corrupted the repo, but now it's recoverable by
> > reaching into the quarantine. Who notices that the repo is corrupt, and
> > how? When do we expire objects from quarantine?
> >
> > I think the heart of the issue is really the lack of atomicity in the
> > operations. You need some way to mark "I am using this now" in a way
> > that cannot race with "looks like nobody is using this, so I'll delete
> > it".
> >
> > And ideally without traversing large bits of the graph on the writing
> > side, and without requiring any stop-the-world locks during pruning.
> 
> I was thinking (but realize now that I didn't articulate) that the "gc
> quarantine" would be another "alternate" implementing a copy-on-write
> "lockless delete-but-be-able-to-rollback scheme" as you put it.
> 
> So "gc" would decide (racily) what's unreachable, but instead of
> unlink()-ing it would "mv" the loose object/pack into the
> "unreferenced-objects" quarantine.
> 
> Then in your example #1 "wants to reference ABCD. It sees that we have
> it." would race on the "other side". I.e. maybe ABCD was *just* moved to
> the quarantine. But in that case we'd move it back, which would bump the
> mtime and thus make it ineligible for expiry.

I think this is basically the same as the current freshening scheme,
though. In general, you can replace "move it back" with "update its
mtime". Neither is atomic with respect to other operations.

It does seem like the twist is that "gc" is supposed to do the "move it
back" step (and it's also the thing expiring, if we assume that there's
only one gc running at a time). But again, how do we know somebody isn't
referencing it _right now_ while we're deciding whether to move it back?

I think there are lots of solutions you can come up with if you have
atomicity. But fundamentally it isn't there in the way we handle updates
now. You could imagine something like a shared/unique lock where anybody
updating a ref takes the "shared" side, and multiple entities can hold
it at once. But somebody pruning takes the "unique" side and excludes
everybody else, stopping ref updates during the prune (which you'd
obviously want to do in a way that you hold the lock for as short as
possible; say, optimistically check reachability without the lock, then
take the lock and check to see if anything has changed).

(By shared/unique I basically mean a reader/writer lock, but I didn't
want to use those terms in the paragraph since both holders are
writing).

It is tricky to find out when to hold the shared lock, though. It's
_not_ just a ref write, for example. When you accept a push, you'd want
to hold the lock while you are checking that you have all of the
necessary objects to write the ref. For something like "git commit" it's
even harder, because we implicitly rely on state created by commands run
over the course of hours or days (e.g., "git add" to put a blob in the
index and maybe create the tree via cache-tree, then a commit to
reference it, and finally the ref write; each step adds state which the
next step relies on).

> Aside from that, I have a hunch that while it's theoretically true that
> you can at any time re-reference some loose blob/tree/commit again, that
> the likelyhood of that in practice goes down as it ages, since a user is
> likely to e.g. re-push or rename some branch they pushed last week, not
> last year.
>
> Hence the mention of creating "unreferenced packs" with some new
> --keep-unreachable mode. Since we'd pack those together they wouldn't
> create the "ref explosion" problem we have with the loose refs, and thus
> you could afford to keep them longer (even though the deltas would be
> shittier).

Yeah, that may make it less likely (and we'd like those unreferenced
packs for other reasons anyway, so it's certainly worth a shot). But the
whole race is kind of unlikely in the first place. If you have enough
repositories, you see it eventually. ;)

-Peff
