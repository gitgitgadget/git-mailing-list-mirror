Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 608F4202AC
	for <e@80x24.org>; Fri,  7 Jul 2017 09:32:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750904AbdGGJcD (ORCPT <rfc822;e@80x24.org>);
        Fri, 7 Jul 2017 05:32:03 -0400
Received: from dd28836.kasserver.com ([85.13.147.76]:54909 "EHLO
        dd28836.kasserver.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750882AbdGGJcC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jul 2017 05:32:02 -0400
X-Greylist: delayed 466 seconds by postgrey-1.27 at vger.kernel.org; Fri, 07 Jul 2017 05:32:02 EDT
Received: from [192.168.42.152] (dslb-178-008-096-147.178.008.pools.vodafone-ip.de [178.8.96.147])
        by dd28836.kasserver.com (Postfix) with ESMTPSA id 7067930024D;
        Fri,  7 Jul 2017 11:24:15 +0200 (CEST)
To:     gitster@pobox.com (Junio C Hamano), git@vger.kernel.org (git)
Cc:     avarab@gmail.com (=?ISO-8859-1?Q?=C6var_Arnfj=F6r=3F_Bjarmason?=),
        peff@peff.net (Jeff King),
        matt@mattmccutchen.net (Matt McCutchen),
        jacob.keller@gmail.com (Jacob Keller),
        rappazzo@gmail.com (Mike Rappazzo),
        f@mazzo.li (Francesco Mazzoli)
In-Reply-To: <xmqq37a9fl8a.fsf_-_@gitster.mtv.corp.google.com>
Subject: Re: [PATCH] push: disable lazy --force-with-lease by default
From:   lists@haller-berlin.de (Stefan Haller)
Date:   Fri, 7 Jul 2017 11:24:15 +0200
Message-ID: <1n8sh3u.1lsabkd1pislrwM%lists@haller-berlin.de>
User-Agent: MacSOUP/2.8.6b1 (Mac OS 10.12.5)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> wrote:

> It turns out that some people use third-party tools that fetch from
> remote and update the remote-tracking branches behind users' back,
> defeating the safety relying on the stability of the remote-tracking
> branches.

Third-party tools are not the only problem. They may make the problem
more likely to occur, but it can also happen without them. (See below.)

> Let's disable the form that relies on the stability of remote-tracking
> branches by default, and allow users who _know_ their remote-tracking
> branches are stable to enable it with a configuration variable.

I'm wondering if people who claim they know they are safe really do.
Elsewhere in the other thread somebody said "I only ever explicitly
fetch, so I know I'm safe". Are you sure?

Consider this example:

$ git checkout the-branch-i-am-collaborating-on-with-my-collegue
$ git pull # make sure I have their latest work
$ git rebase -i ... # do some history rewriting
# OK, so as we need to force-push anyway, let's take the opportunity and
# rebase onto the latest master:
$ git fetch # get latest master
$ git rebase origin/master
$ git push --force-with-lease

This is a very common thing to do at my workplace. And it's unsafe,
because the git fetch may move the remote-tracking branch of the branch
I'm working on.

To make this safe, I guess you'd have to replace "git fetch" with
something like
$ git fetch refs/heads/master:refs/remotes/origin/master

Personally I have never used this form of fetch myself, and I'd be
surprised if any of my coworkers even know it exists.

So know you could decide that _any_ fetch is unsafe, and never use it;
only use git pull. You are still not safe:

$ git checkout the-branch-i-am-collaborating-on-with-my-collegue
$ git pull
$ git rebase -i
# Now another collegue walks in and asks me to look at the regression
# they just introduced on some other branch, so I do
$ git checkout that-other-branch
$ git pull
$ <try to debug their problem>
$ <can't find it either, giving up, shrug>
# go back to what I was doing:
$ git checkout the-branch-i-am-collaborating-on-with-my-collegue
$ git push --force-with-lease

Again, the git pull may have moved the remote-tracking branch of the
branch that I want to force-push. Again, it could be solved by given an
explicit refspec to git pull, but few people ever do this in my
experience, and I certainly never want to.

What I'm getting at is that there's a lot of things that you have to
remember to not do in order to make --force-with-lease without parameter
a useful tool.


-- 
Stefan Haller
Berlin, Germany
http://www.haller-berlin.de/
