Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0541320357
	for <e@80x24.org>; Fri, 14 Jul 2017 12:24:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753609AbdGNMYE (ORCPT <rfc822;e@80x24.org>);
        Fri, 14 Jul 2017 08:24:04 -0400
Received: from cloud.peff.net ([104.130.231.41]:40544 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1753557AbdGNMYE (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jul 2017 08:24:04 -0400
Received: (qmail 16411 invoked by uid 109); 14 Jul 2017 12:24:03 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 14 Jul 2017 12:24:03 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 10418 invoked by uid 111); 14 Jul 2017 12:24:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Fri, 14 Jul 2017 08:24:16 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 14 Jul 2017 08:24:01 -0400
Date:   Fri, 14 Jul 2017 08:24:01 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        Git Users <git@vger.kernel.org>
Subject: Re: Reducing redundant build at Travis?
Message-ID: <20170714122401.uahk2fzvcjj3nwve@sigill.intra.peff.net>
References: <xmqqeftlz0dv.fsf@gitster.mtv.corp.google.com>
 <CADJMNYmGR8Ti0S77y2ykPdSZB68DrBb8O0wfX6PaezV1+j2bnw@mail.gmail.com>
 <xmqqiniwt35e.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqiniwt35e.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 13, 2017 at 02:53:17PM -0700, Junio C Hamano wrote:

> >> Unfortunately, https://travis-ci.org/git/git/builds/ shows that it
> >> does not care if it spawned a job to build the tip of 'maint' and
> >> another for 'v2.13.3' that point at the same thing.
> >
> > That is indeed suprising and wasteful. Looks like other people
> > did run into the same issue. How about something like this?
> > https://github.com/mockito/mockito/blob/release/2.x/.travis.yml#L26-L29
> 
> That unfortunately is exactly what I wanted to avoid.
> 
> We'd want to test tagged releases, and we'd want to test usual
> updates to integration branches.  It just is that sometimes the tips
> of integration branches happen to be at the tagged release, so I'd
> prefer to always build tags but skip a branch build if it happens to
> be also tagged.  After all, none of the integration branches may
> directly point at a tagged release when the tag is pushed out.

Right, I think the right solution is some amount of peeling. Recognizing
that the commit sha1 is the same, or better yet, not bothering to retest
trees which have already been tested.

We used a hacked-up copy of Jenkins for our in-house CI, and it skips
already-tested trees.  Besides the discussed cases, this also saves time
when pushing noop rebases (e.g., when you just changed commit messages)
and noop merges (e.g., if you already back-merged master to your topic,
tested it, and now do a "merge --no-ff" to merge the topic in). I don't
think either of those are common in our workflows, though.

If we had some kind of persistent storage, we could do a quick:

  tree=$(git rev-parse HEAD^{tree})
  if test "$(get_from_storage status-$tree)" = "good"
  then
	echo "Already tested $tree, skipping"
	exit 0
  fi
  ... run actual tests ...
  put_into_storage status-$tree good

The "git test" script[1] uses this strategy with git-notes as the
storage, and I've found it quite useful. I don't think we can rely on
git-notes, but I think Travis gives us some storage options. Even just a
best-effort cache directory would probably be sufficient (this is an
optimization, after all).

-Peff

[1] https://github.com/mhagger/git-test
