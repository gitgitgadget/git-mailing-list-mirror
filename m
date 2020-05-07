Return-Path: <SRS0=p769=6V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B4E1C38A2A
	for <git@archiver.kernel.org>; Thu,  7 May 2020 18:54:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B4F320575
	for <git@archiver.kernel.org>; Thu,  7 May 2020 18:54:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727826AbgEGSyG (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 May 2020 14:54:06 -0400
Received: from cloud.peff.net ([104.130.231.41]:40686 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1726558AbgEGSyG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 May 2020 14:54:06 -0400
Received: (qmail 1729 invoked by uid 109); 7 May 2020 18:54:06 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 07 May 2020 18:54:06 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 20804 invoked by uid 111); 7 May 2020 18:54:09 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 07 May 2020 14:54:09 -0400
Authentication-Results: peff.net; auth=none
Date:   Thu, 7 May 2020 14:54:05 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, Taylor Blau <me@ttaylorr.com>,
        git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 1/2] CI: limit GitHub Actions to designated branches
Message-ID: <20200507185405.GA23736@coredump.intra.peff.net>
References: <20200505164326.GA64077@coredump.intra.peff.net>
 <xmqqo8r2b6y4.fsf@gitster.c.googlers.com>
 <20200505182418.GA66702@coredump.intra.peff.net>
 <20200505210451.GA645290@coredump.intra.peff.net>
 <20200506004612.GE927@danh.dev>
 <xmqqr1vx90mt.fsf@gitster.c.googlers.com>
 <20200506142500.GA2429@danh.dev>
 <xmqqa72l81pe.fsf@gitster.c.googlers.com>
 <20200507122549.GB3057274@coredump.intra.peff.net>
 <xmqqeerv4n0q.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqeerv4n0q.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, May 07, 2020 at 11:29:09AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Yeah, I agree that all of the mechanisms for dealing with the unrelated
> > history are somewhat awkward. Another issue is that you can't just:
> >
> >   git clone --single-branch -b refs/ci/config my-config
> >
> > to work on it, because "-b" wants only heads or tags (we could address
> > that by putting it in refs/heads/ci-config or similar).
> 
> I somehow don't think that it is such a huge issue, because I expect
> anybody who has legitimate interest in refs/ci/config to have a full
> clone of git.git anyway.  So it is more like defining another
> remote.origin.fetch like this:
> 
> 	 [remote "origin"]
> 	 	url = https://git.kernel.org/pub/scm/git/git.git/
> 	 	fetch = +refs/heads/*:refs/remotes/origin/*
> 	+	fetch = +refs/ci/config:refs/remotes/origin/ci-config
> 
>          [remote "publish"]
> 		url = https://github.com/user/git/
> 
> 
> and then do something like:
>     
> 	$ git worktree add -b ci-config ../git-ci-config origin/ci-config
> 	$ cd ../git-ci-config
> 	... hack hack hack ...
> 	$ git push publish ci-config:refs/ci/config

I dunno. The duality of refs/ci/config and refs/heads/ci-config is
weird. Your two refspecs overlap on their RHS, and once you push up the
refs/heads/ci-config you created with "git worktree add", they'll start
to conflict (which maybe is OK as long as they're the same).

In the patch I sent out a few hours ago I just caved and made
refs/heads/ci-config the magic ref, in order to avoid complexity.

But it also wouldn't be too bad to say "look, you can store this however
you like in refs/heads/ or not at all, but install it into place with
git push <remote> HEAD:refs/ci/config". The audience is git.git
developers (and even advanced ones whose workflows involve tweaking
their CI config), so I'd like to think they could figure it out.

I have a feeling that fewer than 5 people in the world will end up using
this feature either way. ;)

-Peff
