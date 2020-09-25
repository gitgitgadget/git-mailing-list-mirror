Return-Path: <SRS0=RFRG=DC=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53D0AC4363D
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 17:47:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0379E221EC
	for <git@archiver.kernel.org>; Fri, 25 Sep 2020 17:47:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727290AbgIYRrT (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Sep 2020 13:47:19 -0400
Received: from cloud.peff.net ([104.130.231.41]:41158 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726368AbgIYRrT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Sep 2020 13:47:19 -0400
Received: (qmail 15444 invoked by uid 109); 25 Sep 2020 17:47:19 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Fri, 25 Sep 2020 17:47:19 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21397 invoked by uid 111); 25 Sep 2020 17:47:19 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Fri, 25 Sep 2020 13:47:19 -0400
Authentication-Results: peff.net; auth=none
Date:   Fri, 25 Sep 2020 13:47:18 -0400
From:   Jeff King <peff@peff.net>
To:     Rich <forums@artfulrobot.uk>
Cc:     git@vger.kernel.org
Subject: Re: Segfault during fsck and spreading brokenness
Message-ID: <20200925174718.GA70005@coredump.intra.peff.net>
References: <2aa62ff7-0780-8e20-e87d-387152524971@artfulrobot.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2aa62ff7-0780-8e20-e87d-387152524971@artfulrobot.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 25, 2020 at 04:48:39PM +0100, Rich wrote:

> I was encouraged by a couple of people on stackoverflow to post to this
> list. Apols in advance if it's not the right place.
>
> I encountered a Segfault during fsck on a damaged bare repo (probably due to
> a powercut. Possibly during an operation, although not sure):

Thanks for the report. This is definitely the right place.

> git --version
> git version 2.11.0
> 
> git fsck --full -v
> Checking HEAD link
> Checking object directory
> Checking tree 11bbc847cf1b4422b3e37830a9eac2e7af6559de
> Checking tree 11be4abeb20314de6145dfc0e6180807a74c03dc
> --->8 snip 8<---------------------------------------------------------------
> Checking tree 14a4423e86f06c7ad75bf391d138e0cf7790508f
> Checking tree 147aeaec72b2f29bf1813494c942fbce497be679
> zsh: segmentation fault  git fsck --full -v

It's tough to say from this where the problem might be. If you still
have the broken repo and can reproduce, two things that might help:

  - trying with a more recent version of Git; we've fixed quite a few
    segfaults around corrupted data in the past few years

  - getting a backtrace; if you can build Git from source, the simplest
    thing is just running "gdb --args /path/to/your/git fsck --full -v",
    waiting for it to crash, and then running "bt" in the debugger

> I learnt about the damage while trying to `git push`  from my dev working
> tree. I think I did a `git pull` when the `git push` failed. The result of
> this was that my *local* repo was also damaged: there was an empty file
> created that would stop git operations and on deleting that I got a page
> full of errors.

That's concerning; push/pull generally try hard not to let corruption
spread. What transport do you use between the two servers? The usual
git-over-ssh and git-over-http protocols should be pretty resilient, but
I would not be surprised if the old dumb-http protocol, which just
downloads remote files wholesale, would be confused by a zero-length
loose object file or similar.

-Peff
