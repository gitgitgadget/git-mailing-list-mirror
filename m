Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DBAF62023D
	for <e@80x24.org>; Fri,  3 Mar 2017 08:56:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751456AbdCCI4U (ORCPT <rfc822;e@80x24.org>);
        Fri, 3 Mar 2017 03:56:20 -0500
Received: from cloud.peff.net ([104.130.231.41]:37804 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751278AbdCCI4S (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Mar 2017 03:56:18 -0500
Received: (qmail 15427 invoked by uid 109); 3 Mar 2017 07:55:37 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 03 Mar 2017 07:55:37 +0000
Received: (qmail 25616 invoked by uid 111); 3 Mar 2017 07:55:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 03 Mar 2017 02:55:44 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 03 Mar 2017 02:55:35 -0500
Date:   Fri, 3 Mar 2017 02:55:35 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "Devin J. Pohly" <djpohly@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Charles Bailey <cbailey32@bloomberg.net>, git@vger.kernel.org
Subject: Re: [PATCH 3/4] filter-branch: fix --prune-empty on parentless
 commits
Message-ID: <20170303075535.rxij4knd7d4ayfev@sigill.intra.peff.net>
References: <20170223082736.31283-1-djpohly@gmail.com>
 <20170223082736.31283-3-djpohly@gmail.com>
 <xmqqbmts7gjm.fsf@gitster.mtv.corp.google.com>
 <20170223213333.GA3490@prospect.localdomain>
 <xmqqshmvbhe5.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqshmvbhe5.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Mar 02, 2017 at 11:36:18AM -0800, Junio C Hamano wrote:

> "Devin J. Pohly" <djpohly@gmail.com> writes:
> 
> > I think your point is interesting too, though.  If a commit is also
> > TREESAME to its parent(s?) in the _pre-filtered_ branch, it seems
> > reasonable that someone might want to leave it in the filtered branch as
> > an empty commit while pruning empt*ied* commits.  I would imagine that
> > as another option (--prune-newly-empty?).
> 
> I was hoping to hear from others who may care about filter-branch to
> comment on this topic to help me decide, but I haven't heard
> anything, so here is my tentative thinking.
> 
> I am leaning to:
> 
>  * Take your series as-is, which would mean --prune-empty will
>    change the behaviour to unconditionally lose the empty root.
> 
>  * Then, people who care deeply about it can add a new option that
>    prunes commits that become empty while keeping the originally
>    empty ones.
> 
> Thoughts?

Sorry, this was on my to-review list but the sha1 stuff has been much
more exciting. :)

The behavior that Devin proposes is what I would have expected to
happen. Between "prune-existing-empty" and "prune-became-empty", I've
never had a use for the distinction. But as I think this is similar to
the way cherry-pick distinguished between "redundant" and "empty", I
guess some people have.

I agree that it should be a new, separate option, as it's orthogonal to
dealing with the root commit (i.e., somebody is equally likely to want
to preserve an already-empty commit from the middle of history).

The change to filter-branch itself looks obviously correct. The only
objectionable thing I noticed in the test additions is that the early
ones should be marked test_expect_failure until the fix from 3/4 flips
them to "success". Otherwise it breaks bisectability.

-Peff
