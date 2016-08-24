Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 225B01F6C1
	for <e@80x24.org>; Wed, 24 Aug 2016 23:02:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756682AbcHXXCK (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Aug 2016 19:02:10 -0400
Received: from cloud.peff.net ([104.130.231.41]:60832 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1755523AbcHXXCJ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Aug 2016 19:02:09 -0400
Received: (qmail 517 invoked by uid 109); 24 Aug 2016 23:01:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 24 Aug 2016 23:01:19 +0000
Received: (qmail 8116 invoked by uid 111); 24 Aug 2016 23:01:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 24 Aug 2016 19:01:22 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 24 Aug 2016 19:01:16 -0400
Date:   Wed, 24 Aug 2016 19:01:16 -0400
From:   Jeff King <peff@peff.net>
To:     Stefan Beller <sbeller@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        Heiko Voigt <hvoigt@hvoigt.net>,
        Jens Lehmann <Jens.Lehmann@web.de>,
        Fredrik Gustafsson <iveqy@iveqy.com>,
        Leandro Lucarella <leandro.lucarella@sociomantic.com>
Subject: Re: [PATCHv2] push: change submodule default to check
Message-ID: <20160824230115.jhmcr4r7wobj5ejb@sigill.intra.peff.net>
References: <20160824173017.24782-1-sbeller@google.com>
 <20160824183112.ceekegpzavnbybxp@sigill.intra.peff.net>
 <xmqqh9aaot49.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kYOBqQ0FF4J-+KbefSD8HRrUeMqpO27m_jprhm93aB+LA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGZ79kYOBqQ0FF4J-+KbefSD8HRrUeMqpO27m_jprhm93aB+LA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Aug 24, 2016 at 03:37:29PM -0700, Stefan Beller wrote:

> > That sounds massively ... broken.  So before even thinking about
> > flipping it to default, this needs to be fixed first.
> 
> I agree. That sounds bad.
> 
> However having the --auto-check feels like papering over the
> actual problem which to me sounds like a design problem.
> However this may be a viable short term solution.

Sort of...

I may not have been clear, but there are really a few things going on.

One is that the design of find_unpushed_submodules() is just brain-dead.
It does one traversal per updated ref, which means a from-scratch mirror
is O(nr_of_refs * nr_of_commits). That's just silly, and can easily be
fixed behind the scenes to be O(nr_of_commits).

And I _suspect_ it is what made Junio's earlier push so awful; he
probably pushed up the same commits as part of many different branches,
so he did the same diffs over and over.

So clearing that up seems like an obvious first step, and dulls the pain
to "if submodule recursion is on, the worst case is that you walk all
the new objects you are sending". That's still _a_ traversal, but it's
one we have to do anyway in pack-objects, so it's the same order of
magnitude as the rest of the push[1].

Then you've got two cases: the repo is using submodules at all, or they
are not. The former is an easy case, if we can identify it; we can avoid
the traversal at all, and people who do not use submodules are not
regressed at all.

That leaves people who _are_ using submodules with paying the extra
traversal cost. Not great, but only really a pain when you have a really
big chunk of history to push. It may be lost in the noise for such a
push in more normal circumstances (where bandwidth to push up the
objects dominates, though it is unfortunate that we do not even start
utilizing the bandwidth, the critical resource, until we are done with
the submodule check).

[1] Of course with reachability bitmaps the pack-objects traversal goes
    away, but the same cannot be accomplished here (because they do not
    store the gitlink sha1s at all, because they do not imply
    reachability).

> We need to answer the question: Which submodule commits
> are referenced by a given set of superproject commits.
> 
> This question is advancing a very similar question that we'd
> have to ask in git-gc. In gc we would end up without having to
> worry about a specific set, but rather the all reachable commits
> of the superproject are in the given set.
> 
> So we could solve two issues at the same time if we had a quick
> way to answer this question quickly.
> [...]

I snipped here because your solutions sound complicated (which isn't to
say they're wrong, but that I am not willing to give them a lot of
thought at this time in the evening ;) ).

One opposite approach which appeals to me is not to remove the need for
the traversal, but to make it much faster. E.g., by storing commits in a
form that can be traversed more quickly, and possibly keeping a bitmap
cache of which paths are touched in each commit (I have posted patches
to the list for the former, but have only been considering experimenting
with the latter).

That's _also_ complicated, but it applies to way more things. Including
normal log traversals, path-limiting for diffs, the "counting" traversal
done by pack-object, etc.

And while it is complicated in some ways, it's conceptually simple at
the git data model layer. It's returning the same old answers about
commits and trees, just faster.

Anyway, food for thought.

-Peff
