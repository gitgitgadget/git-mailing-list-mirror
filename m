Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B148820437
	for <e@80x24.org>; Fri, 13 Oct 2017 17:20:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752349AbdJMRUX (ORCPT <rfc822;e@80x24.org>);
        Fri, 13 Oct 2017 13:20:23 -0400
Received: from cloud.peff.net ([104.130.231.41]:52340 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1751138AbdJMRUW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Oct 2017 13:20:22 -0400
Received: (qmail 31201 invoked by uid 109); 13 Oct 2017 17:20:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Fri, 13 Oct 2017 17:20:22 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 27217 invoked by uid 111); 13 Oct 2017 17:20:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Fri, 13 Oct 2017 13:20:25 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 13 Oct 2017 13:20:20 -0400
Date:   Fri, 13 Oct 2017 13:20:20 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
Subject: [PATCH 0/4] peeling back color.ui=always hacks
Message-ID: <20171013172020.adc2fkddgp3g2ses@sigill.intra.peff.net>
References: <xmqqr2uao2vy.fsf@gitster.mtv.corp.google.com>
 <20171012021007.7441-1-gitster@pobox.com>
 <20171012021007.7441-2-gitster@pobox.com>
 <20171012123153.i265nun6pklw7kjg@sigill.intra.peff.net>
 <xmqqinfjykm2.fsf@gitster.mtv.corp.google.com>
 <20171013014721.d4vesqv4v5j7tmk2@sigill.intra.peff.net>
 <xmqqzi8vvht6.fsf@gitster.mtv.corp.google.com>
 <20171013130638.dgc6kawy5mvrbasz@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20171013130638.dgc6kawy5mvrbasz@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 13, 2017 at 09:06:38AM -0400, Jeff King wrote:

> > I think that it is too late, regardless of our release cycle.
> > 
> > "Plumbing never looks at color.ui" implies that "plumbing must not
> > get color.ui=auto from 4c7f1819", but given that 4c7f1819 is from
> > 2013, I'd be surprised if we stopped coloring output from plumbing
> > without getting any complaints from third-party script writers.
> 
> I agree that 4c7f1819 is the root of things. But there also weren't a
> lot of people complaining about it. I only noticed it as part of other
> work I was doing, and (perhaps foolishly) tried to clean it up.
> 
> All of the regressions people have actually _noticed_ stem from my
> 136c8c8b8f in v2.14.2. So I think it is a viable option to try to go
> back to the pre-v2.14.2 state. I.e.:
> 
>   1. Revert my 20120618c1 (color: downgrade "always" to "auto" only for
>      on-disk configuration, 2017-10-10) and the test changes that came
>      with it.
> 
>   2. Teach for-each-ref and tag to use git_color_default_config(). These
>      are the two I _know_ need this treatment as part of the series that
>      contained 136c8c8b8f. As you've noted there may be others, but I'd
>      be surprised if there are many. There hasn't been a lot of color
>      work in the last few months besides what I've done.
> 
>   3. Revert 136c8c8b8f.
> 
> That takes us back to the pre-regression state. The ancient bug from
> 4c7f1819 still exists, but that would be OK for v2.15. We'd probably
> want to bump the -rc cycle a bit to give more confidence that (2) caught
> everything.

Here's a series which does that. I'm torn on the correct direction, but
I took the time to prepare these patches because I wanted to have two
concrete alternatives to examine, not hand-waving about what one of the
solutions would look like.

I'm adding Jonathan back to the cc as somebody who was interested in the
whole sequence (I think these patches should stand alone as explaining
their reasoning, but you may want to look back in the thread a little
for context).

  [1/4]: Revert "color: make "always" the same as "auto" in config"
  [2/4]: Revert "t6006: drop "always" color config tests"
  [3/4]: Revert "color: check color.ui in git_default_config()"
  [4/4]: tag: respect color.ui config

 Documentation/config.txt   | 35 ++++++++++++++++++-----------------
 builtin/branch.c           |  2 +-
 builtin/clean.c            |  3 ++-
 builtin/grep.c             |  2 +-
 builtin/show-branch.c      |  2 +-
 builtin/tag.c              |  2 +-
 color.c                    | 10 +++++++++-
 config.c                   |  4 ----
 diff.c                     |  3 +++
 t/t6006-rev-list-format.sh | 20 +++++++++++++++-----
 t/t6300-for-each-ref.sh    |  5 +++++
 t/t7004-tag.sh             |  6 ++++++
 12 files changed, 62 insertions(+), 32 deletions(-)

-Peff
