Return-Path: <SRS0=7zPC=7J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A9A8C433DF
	for <git@archiver.kernel.org>; Wed, 27 May 2020 06:52:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 202B3207CB
	for <git@archiver.kernel.org>; Wed, 27 May 2020 06:52:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728703AbgE0GwM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 May 2020 02:52:12 -0400
Received: from cloud.peff.net ([104.130.231.41]:57106 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728111AbgE0GwM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 May 2020 02:52:12 -0400
Received: (qmail 20186 invoked by uid 109); 27 May 2020 06:52:12 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 27 May 2020 06:52:12 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 1393 invoked by uid 111); 27 May 2020 06:52:12 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 27 May 2020 02:52:12 -0400
Authentication-Results: peff.net; auth=none
Date:   Wed, 27 May 2020 02:52:10 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        Dana Dahlstrom <dahlstrom@google.com>, git@vger.kernel.org
Subject: Re: 'HEAD' is not a commit (according to git-checkout)
Message-ID: <20200527065210.GC4005121@coredump.intra.peff.net>
References: <CACqwCQiLpZ1HFzgJw0p0KR3jXNsxkhjXmF_huzhv+qkMZmybBQ@mail.gmail.com>
 <20200521191626.GC1308489@coredump.intra.peff.net>
 <9f26099a-e77b-ede4-bee3-27382a5a0875@web.de>
 <20200523162914.GA2178752@coredump.intra.peff.net>
 <ad267e83-eea0-bb78-d88c-a37a28d04dbe@web.de>
 <xmqqimglqpga.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqimglqpga.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sun, May 24, 2020 at 09:15:33AM -0700, Junio C Hamano wrote:

> René Scharfe <l.s.r@web.de> writes:
> 
> > OK, but stepping back a bit and trying to forget what I know about the
> > option --track and pretending to see it for the first time, I have to
> > ask: Why doesn't it take an argument?  If I check out a raw commit, it
> > cannot guess the upstream branch anyway.  So I'd assume this to work:
> >
> >    git checkout -b new-branch --track=upstream start-point
> 
> Assuming that --track option is marked with PARSE_OPT_OPTARG and
> when the option is given, we internally do a rev-parse of both
> upstream and start-point and make sure the tip of the "track" is an
> ancestor of the "start-point", I think it makes sense.  That would
> catch cases like this:
> 
> 	git checkout --detach origin/master
> 	... work work work ...
> 	git checkout -b new-branch --track=origin/master HEAD
> 
> On the other hand, some use case might want to go the other way, e.g.
> 
> 	git checkout --detach origin/master~12
> 	... work to fix an older bug ...
> 	git checkout -b new-branch --track=origin/master HEAD
> 
> in which case the start-point and the current tip of the tracking
> branch has no relation other than they share a common ancestor.

Trying to think back on times I might have used a feature like this,
most of them are like the first case (though I admit I was always
content with "git branch --set-upstream-to" after the fact).

I do hit the other case, too, with something like:

  git checkout next
  ... hack hack hack ...
  # oops, I meant to do this on top of master
  git checkout -b new-branch --track=origin/master HEAD
  git rebase --onto=origin/master HEAD~2

though given the rebase trickery, I tend to instead just do now:

  git checkout -b new-branch origin
  git cherry-pick -2 HEAD@{1}

I don't know if that really goes to show anything. I'm mostly just
thinking out loud.

> So, should we allow a random upstream & start-point combination?  It
> appears to me that as long as they share _some_ common ancestory, it
> may make sense.

But wouldn't just about any two tips in a repository share some common
ancestry? There are obviously funny exceptions like rewriting history,
or storing unrelated branches, but for the most part you'd find _some_
merge base, even if it's a root commit. So it seems like that check is
unlikely to help prevent accidents, would possibly be an impediment to
something clever the user is doing (albeit quite rarely), and makes the
feature slightly harder to describe. That doesn't seem worth it.

-Peff
