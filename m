Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A85AE2022D
	for <e@80x24.org>; Thu, 23 Feb 2017 23:05:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751377AbdBWXFM (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Feb 2017 18:05:12 -0500
Received: from cloud.peff.net ([104.130.231.41]:32949 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751361AbdBWXFK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2017 18:05:10 -0500
Received: (qmail 25996 invoked by uid 109); 23 Feb 2017 23:05:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 23 Feb 2017 23:05:10 +0000
Received: (qmail 3321 invoked by uid 111); 23 Feb 2017 23:05:13 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 23 Feb 2017 18:05:13 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 23 Feb 2017 18:05:07 -0500
Date:   Thu, 23 Feb 2017 18:05:07 -0500
From:   Jeff King <peff@peff.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Joey Hess <id@joeyh.name>, Git Mailing List <git@vger.kernel.org>
Subject: Re: SHA1 collisions found
Message-ID: <20170223230507.kuxjqtg3ghcfskc6@sigill.intra.peff.net>
References: <CA+55aFzFEpi1crykZ33r9f7BsvLt_kiB-CHXOkuCAX=fd4BU-w@mail.gmail.com>
 <20170223182147.hbsyxsmyijgkqu75@kitenet.net>
 <CA+55aFxckeEW1ePcebrgG4iN4Lp62A2vU6tA=xnSDC_BnKQiCQ@mail.gmail.com>
 <20170223184637.xr74k42vc6y2pmse@sigill.intra.peff.net>
 <CA+55aFx=0EVfSG2iEKKa78g3hFN_yZ+L_FRm4R749nNAmTGO9w@mail.gmail.com>
 <20170223193210.munuqcjltwbrdy22@sigill.intra.peff.net>
 <CA+55aFxmr6ntWGbJDa8tOyxXDX3H-yd4TQthgV_Tn1u91yyT8w@mail.gmail.com>
 <20170223195753.ppsat2gwd3jq22by@sigill.intra.peff.net>
 <alpine.LFD.2.20.1702231428540.30435@i7.lan>
 <20170223224302.joti4zqucme3vqr2@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170223224302.joti4zqucme3vqr2@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 23, 2017 at 05:43:02PM -0500, Jeff King wrote:

> On Thu, Feb 23, 2017 at 02:38:29PM -0800, Linus Torvalds wrote:
> 
> > > Thanks, I hadn't seen that yet. That doesn't look like it should be hard
> > > to integrate into Git.
> > 
> > Here's a *very* ugly patch that is absolutely disgusting and should not be 
> > used. But it does kind of work (I tested it with a faked-up extra patch 
> > that made git accept the broken pdf as a loose object).
> > 
> > What do I mean by "kind of work"? It uses that ugly and slow checking 
> > SHA1 routine from the collision detection project for the SHA1 object 
> > verification, and it means that "git fsck" ends up being about twice as 
> > slow as it used to be.
> 
> Heh. I was just putting the finishing touches on a similar patch. Mine
> is much less gross, in that it actually just adds a new USE_SHA1DC knob
> (instead of, say, BLK_SHA1).

Here's my patches. They _might_ be worth including if only because they
shouldn't bother anybody unless they enable USE_SHA1DC. So it makes it a
bit more accessible for people to experiment with (or be paranoid with
if they like).

The first one is 98K. Mail headers may bump it over vger's 100K barrier.
It's actually the _least_ interesting patch of the 3, because it just
imports the code wholesale from the other project. But if it doesn't
make it, you can fetch the whole series from:

  https://github.com/peff/git jk/sha1dc

(By the way, I don't see your version on the list, Linus, which probably
means it was eaten by the 100K filter).

  [1/3]: add collision-detecting sha1 implementation
  [2/3]: sha1dc: adjust header includes for git
  [3/3]: Makefile: add USE_SHA1DC knob

 Makefile           |   10 +
 sha1dc/sha1.c      | 1165 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 sha1dc/sha1.h      |  108 +++++
 sha1dc/ubc_check.c |  361 ++++++++++++++++
 sha1dc/ubc_check.h |   33 ++
 5 files changed, 1677 insertions(+)
 create mode 100644 sha1dc/sha1.c
 create mode 100644 sha1dc/sha1.h
 create mode 100644 sha1dc/ubc_check.c
 create mode 100644 sha1dc/ubc_check.h

-Peff
