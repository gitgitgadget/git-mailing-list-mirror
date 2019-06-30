Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9C2271F461
	for <e@80x24.org>; Sun, 30 Jun 2019 06:54:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726559AbfF3GyB (ORCPT <rfc822;e@80x24.org>);
        Sun, 30 Jun 2019 02:54:01 -0400
Received: from cloud.peff.net ([104.130.231.41]:55218 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726513AbfF3GyB (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Jun 2019 02:54:01 -0400
Received: (qmail 22801 invoked by uid 109); 30 Jun 2019 06:54:00 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Sun, 30 Jun 2019 06:54:00 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 28875 invoked by uid 111); 30 Jun 2019 06:54:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Sun, 30 Jun 2019 02:54:52 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 30 Jun 2019 02:53:59 -0400
Date:   Sun, 30 Jun 2019 02:53:59 -0400
From:   Jeff King <peff@peff.net>
To:     Edmundo Carmona Antoranz <eantoranz@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC/PATCH 1/2] rebuash - squash/rebase in a single step
Message-ID: <20190630065358.GB31264@sigill.intra.peff.net>
References: <20190630051816.8814-1-eantoranz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190630051816.8814-1-eantoranz@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jun 29, 2019 at 11:18:15PM -0600, Edmundo Carmona Antoranz wrote:

> Rebuash allows us to do squash/rebase without having to resort
> to use rebase.
> 
> Consider the case where we have feature branches with merges in history:
> 
> Rx: revisions in main branch
> Fx: Revisions in feature branch
> Mx: Merge revisions (some of them with conflicts)
> 
> ------------
> 	R1---R2---R3---R4---R5---R6---R7
> 	 \         \              \
> 	  F1---F2---M1---F3---F4---M2---F5
> ------------
> 
> If on M1 there were conflicts, it's more than likely that if we tried to
> cherry-pick R1..F2 on top of R7, we will have to deal with a conflict. But that
> conflict has already been taken care of on M1. So, in order to leverage that
> work that has already been done, instead of looking back, we look forward.
> 
> First, we create a (temporary) merge commit of both branches (M3)
> 
> ------------
> 	R1---R2---R3---R4---R5---R6---R7---M3
> 	 \         \              \       /
> 	  F1---F2---M1---F3---F4---M2---F5
> ------------
> 
> At this point, all differences between M3 and R7 are the changes related to the
> feature branch, so we can run git reset --soft from M3 to R7 to put all those
> differeces in index, and then we create single revision that is both
> squashed/rebased for our feature branch.

So if I understand correctly, our goal is:

  R1--R2--...--R7--R8

where R8 has the same tree as M3?

Wouldn't doing "git merge --squash" do the same thing?

If I set up that scenario like so:

  git init repo
  cd repo

  commit() {
    for i in "$@"; do echo $i >file && git add file && git commit -m $i; done
  }

  commit R1 R2 R3
  git checkout -b feature HEAD~2
  commit F1 F2
  git merge master
  commit M1
  git checkout master
  commit R4 R5 R6
  git checkout feature
  commit F3 F4
  git merge master
  commit M2 F5
  git checkout master
  commit R7

and then do:

  git merge --squash feature

I get the same merge that rebuash is doing (with R6 as the merge base,
so we see F5 and R7 conflicting with each other). And then when I finish
it with "git commit", the result is a linear strand with M3 at the tip
(and its commit message is even auto-populated with information from the
squashed commits).

-Peff
