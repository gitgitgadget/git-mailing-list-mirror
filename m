Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DE59C433F5
	for <git@archiver.kernel.org>; Tue, 19 Oct 2021 21:22:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23FB56134F
	for <git@archiver.kernel.org>; Tue, 19 Oct 2021 21:22:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229533AbhJSVY7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Oct 2021 17:24:59 -0400
Received: from cloud.peff.net ([104.130.231.41]:41970 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229491AbhJSVY7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Oct 2021 17:24:59 -0400
Received: (qmail 7446 invoked by uid 109); 19 Oct 2021 21:22:45 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Tue, 19 Oct 2021 21:22:45 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 15363 invoked by uid 111); 19 Oct 2021 21:22:45 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.3)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 19 Oct 2021 17:22:45 -0400
Authentication-Results: peff.net; auth=none
Date:   Tue, 19 Oct 2021 17:22:44 -0400
From:   Jeff King <peff@peff.net>
To:     Kenneth Arnold <ka37@calvin.edu>
Cc:     Alex Henrie <alexhenrie24@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: "Not possible to fast-forward" when pull.ff=only and new commits
 on remote
Message-ID: <YW83JG9t2JaX92xV@coredump.intra.peff.net>
References: <CH2PR06MB650424B4205102AC6A48F489B1BD9@CH2PR06MB6504.namprd06.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CH2PR06MB650424B4205102AC6A48F489B1BD9@CH2PR06MB6504.namprd06.prod.outlook.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 19, 2021 at 05:23:06PM +0000, Kenneth Arnold wrote:

> After upgrade to 2.33.1, the behavior of `pull.ff=only` has changed in a way that breaks some workflows, notably the default used in VSCode.
> 
> Example (specific repo doesn't matter)
> 
> ```
> $ git clone git@github.com:kcarnold/util.git
> ...
> $ cd util
> $ echo "" > test
> $ git add test
> $ git commit -m "Test"
> $ git -c pull.ff=only pull
> fatal: Not possible to fast-forward, aborting.
> $ git status
> On branch master
> Your branch is ahead of 'origin/master' by 1 commit.
>   (use "git push" to publish your local commits)
> ```
> 
> Previously this pull succeeded without error, which was as expected because no merge was necessary. 

Thanks for reporting, this is an interesting case. I agree that it
probably ought to continue to be a noop. There is nothing to pull, and
so the question of ff-versus-merge should not even enter into it.

It bisects to Alex's (cc'd) 3d5fc24dae (pull: abort if --ff-only is
given and fast-forwarding is impossible, 2021-07-21). I'd guess it's
probably the hunk in pull.cc which checks "can_ff". The solution doesn't
seem entirely obvious to me though (at least in a way that retains what
that commit was trying to do).

-Peff
