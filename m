Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0047A1F51C
	for <e@80x24.org>; Mon, 21 May 2018 21:50:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932182AbeEUVuu (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 May 2018 17:50:50 -0400
Received: from cloud.peff.net ([104.130.231.41]:48432 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S932418AbeEUVus (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 May 2018 17:50:48 -0400
Received: (qmail 32643 invoked by uid 109); 21 May 2018 21:50:48 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Mon, 21 May 2018 21:50:48 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 32049 invoked by uid 111); 21 May 2018 21:50:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Mon, 21 May 2018 17:50:56 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 21 May 2018 17:50:46 -0400
Date:   Mon, 21 May 2018 17:50:46 -0400
From:   Jeff King <peff@peff.net>
To:     Elijah Newren <newren@gmail.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>
Subject: Re: commit-graph: change in "best" merge-base when ambiguous
Message-ID: <20180521215046.GA16623@sigill.intra.peff.net>
References: <e78a115a-a5ea-3c0a-5437-51ba0bcc56e1@gmail.com>
 <CABPp-BFEd+fK_i3qoYWudYS5mhWE1jsXR_xcSCZoJ=4Vd61LAQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABPp-BFEd+fK_i3qoYWudYS5mhWE1jsXR_xcSCZoJ=4Vd61LAQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, May 21, 2018 at 11:33:11AM -0700, Elijah Newren wrote:

> > In t6024-recursive-merge.sh, we have the following commit structure:
> >
> >     # 1 - A - D - F
> >     #   \   X   /
> >     #     B   X
> >     #       X   \
> >     # 2 - C - E - G
> >
> > When merging F to G, there are two "best" merge-bases, A and C. With
> > core.commitGraph=false, 'git merge-base F G' returns A, while it returns C
> > when core.commitGraph=true. This is due to the new walk order when using
> > generation numbers, although I have not dug deep into the code to point out
> > exactly where the choice between A and C is made. Likely it's just whatever
> > order they are inserted into a list.
>
> Ooh, interesting.
> 
> Just a guess, but could it be related to relative ordering of
> committer timestamps?  Ordering of committer timestamps apparently
> affects order of merge-bases returned to merge-recursive, and although
> that shouldn't have mattered, a few bugs meant that it did and the
> order ended up determining what contents a successful merge would
> have.  See this recent post:
> 
> https://public-inbox.org/git/CABPp-BFc1OLYKzS5rauOehvEugPc0oGMJp-NMEAmVMW7QR=4Eg@mail.gmail.com/
> 
> The fact that the merge was successful for both orderings of merge
> bases was the real bug, though; it should have detected and reported a
> conflict both ways.

Traditionally we've inserted commits into the walk queue in commit-date
ordering, but with identical dates it may depend on the order in which
you reach the commits. Many of the tests are particularly bad for
showing this off because they do not use test_tick, and so you end up
with a bunch of commits with identical timestamps.

If we're just using generation numbers for queue ordering, we're even
more likely to hit these cases, since they're expected to increase along
parallel branches at roughly the same rate. It's probably a good idea to
have some tie-breakers to make things more deterministic (walk order
shouldn't matter, but it can be confusing if we sometimes use one order
and sometimes the other).

Even ordering by {generation, timestamp} isn't quite enough, since you
could still tie there. Perhaps {generation, timestamp, hash} would be a
sensible ordering?

As for this specific case, even with the current code asking for `git
merge-base G F` will return the other answer. This is clearly a case
with multiple merge bases, and I'd expect "merge-base --all" to return
both (and actually it shows "B" as well, which makes sense). In the
non-all case, there is no "best", so we're free to show any.

-Peff
