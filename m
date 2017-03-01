Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1E9132023D
	for <e@80x24.org>; Wed,  1 Mar 2017 23:20:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752999AbdCAXU5 (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Mar 2017 18:20:57 -0500
Received: from cloud.peff.net ([104.130.231.41]:36809 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751387AbdCAXU4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Mar 2017 18:20:56 -0500
Received: (qmail 21427 invoked by uid 109); 1 Mar 2017 23:19:23 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 01 Mar 2017 23:19:23 +0000
Received: (qmail 11292 invoked by uid 111); 1 Mar 2017 23:19:29 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 01 Mar 2017 18:19:29 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 01 Mar 2017 18:19:21 -0500
Date:   Wed, 1 Mar 2017 18:19:21 -0500
From:   Jeff King <peff@peff.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Marc Stevens <marc.stevens@cwi.nl>,
        Dan Shumow <danshu@microsoft.com>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: [PATCH] Put sha1dc on a diet
Message-ID: <20170301231921.2puf7o7jkrujscwn@sigill.intra.peff.net>
References: <alpine.LFD.2.20.1702281621050.22202@i7.lan>
 <xmqq7f48hm8g.fsf@gitster.mtv.corp.google.com>
 <CA+55aFx1wAS-nHS2awuW2waX=cvig4UoZqmN5H3v93yDE7ukyQ@mail.gmail.com>
 <xmqq37ewhji1.fsf@gitster.mtv.corp.google.com>
 <alpine.DEB.2.20.1703012227010.3767@virtualbox>
 <CA+55aFys5oQ0RySQ+Xv0ZDussr-xZNh4_b3+Upx_d9VPWmpM8Q@mail.gmail.com>
 <alpine.DEB.2.20.1703012334400.3767@virtualbox>
 <CA+55aFy9=jBJT36FC2HiAeabJBssY=jE=zLxwrXWzhpiFkMUXg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+55aFy9=jBJT36FC2HiAeabJBssY=jE=zLxwrXWzhpiFkMUXg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 01, 2017 at 03:05:25PM -0800, Linus Torvalds wrote:

> On Wed, Mar 1, 2017 at 2:51 PM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> >
> > But I think bigger than just developers on Windows OS. There are many
> > developers out there working on large repositories (yes, much larger than
> > Linux). Also using Macs and Linux. I am not at all sure that we want to
> > give them an updated Git they cannot fail to notice to be much slower than
> > before.
> 
> Johannes, have you *tried* the patches?
> 
> I really don't think you have. It is completely unnoticeable in any
> normal situation. The two cases that it's noticeable is:
> 
>  - a full fsck is noticeable slower
> 
>  - a full non-local clone is slower (but not really noticeably so
> since the network traffic dominates).
> 
> In other words, I think you're making shit up. I don't think you
> understand how little the SHA1 performance actually matters. It's
> noticeable in benchmarks. It's not noticeable in any normal operation.
> 
> .. and yes, I've actually been running the patches locally since I
> posted my first version (which apparently didn't go out to the list
> because of list size limits) and now running the version in 'pu'.

You have to remember that some of the Git for Windows users are doing
horrific things like using repositories with 450MB .git/index files, and
the speed to compute the sha1 during an update is noticeable there.

IMHO that is a good sign that the right approach is to switch to an
index format that doesn't require rewriting all 450MB to update one
entry. But obviously that is a much harder problem than just using an
optimized sha1 implementation.

I do think that could argue for turning on the collision detection only
during object-write operations, which is where it matters. It would be
really trivial to flip the "check collisions" bit on sha1dc. But I
suspect you could go faster still by compiling against two separate
implementations: the fast-as-possible one (which could be openssl or
blk-sha1), and the slower-but-careful sha1dc.

-Peff
