Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 70A28201A9
	for <e@80x24.org>; Sat, 25 Feb 2017 01:47:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751348AbdBYBrv (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Feb 2017 20:47:51 -0500
Received: from cloud.peff.net ([104.130.231.41]:33827 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750967AbdBYBru (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Feb 2017 20:47:50 -0500
Received: (qmail 30371 invoked by uid 109); 25 Feb 2017 01:47:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 25 Feb 2017 01:47:50 +0000
Received: (qmail 26632 invoked by uid 111); 25 Feb 2017 01:47:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 24 Feb 2017 20:47:54 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 24 Feb 2017 20:47:48 -0500
Date:   Fri, 24 Feb 2017 20:47:48 -0500
From:   Jeff King <peff@peff.net>
To:     David Lang <david@lang.hm>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Ian Jackson <ijackson@chiark.greenend.org.uk>,
        Joey Hess <id@joeyh.name>, git@vger.kernel.org
Subject: Re: SHA1 collisions found
Message-ID: <20170225014747.f36j2ctlszpebpsy@sigill.intra.peff.net>
References: <20170223164306.spg2avxzukkggrpb@kitenet.net>
 <22704.19873.860148.22472@chiark.greenend.org.uk>
 <xmqq60jz5wbm.fsf@gitster.mtv.corp.google.com>
 <20170224233929.p2yckbc6ksyox5nu@sigill.intra.peff.net>
 <nycvar.QRO.7.75.62.1702241656010.6590@qynat-yncgbc>
 <20170225012100.ivfdlwspsqd7bkhf@sigill.intra.peff.net>
 <nycvar.QRO.7.75.62.1702241733250.6590@qynat-yncgbc>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.75.62.1702241733250.6590@qynat-yncgbc>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Feb 24, 2017 at 05:39:43PM -0800, David Lang wrote:

> On Fri, 24 Feb 2017, Jeff King wrote:
> 
> > > what if they are forks of each other? (LEDE and OpenWRT, or just
> > > linux-kernel and linux-kernel-stable)
> > 
> > Once one flips, the other one needs to flip to, or can't interact with
> > them. I know that's harsh, and is likely to create headaches. But in the
> > long run, I think once everything has converged the resulting system is
> > less insane.
> > 
> > For that reason I _wouldn't_ recommend projects like the kernel flip the
> > flag immediately. Ideally we write the code and the new versions
> > permeate the community. Then somebody (per-project) decides that it's
> > time for the community to start switching.
> 
> can you 'un-flip' the flag? or if you have someone who is a developer flip
> their repo (because they heard that sha1 is unsafe, and they want to be
> safe), they can't contribute to the kernel. We don't want to have them loose
> all their work, so how can they convert their local repo back to somthing
> that's compatible?

I don't think it would be too hard to write an un-flipper (it's
basically just rewriting the newhash bit of history using sha1, and
converting your refs back to point at the sha1s).

> how would submodules work if one module flips and another (or the parent)
> doesn't?

That's a good question. It's possible that another exception should be
carved out for referring to a gitlink via sha1 (we _could_ say "no,
point to a newhash version of the submodule", but I think that creates a
lot of hardship for not much gain).

> OpenWRT/LEDE have their core repo, and they pull from many other (unrelated)
> projects into that repo (and then have 'feeds', which is
> sort-of-like-submodules to pull in other software that's maintained
> completely independently)

I think with submodules this should probably still work.  If they are
pulling in with a subtree-ish strategy, then they'd convert the incoming
trees to the newhash format as part of that.

> Microsoft has made lots of money with people being forced to upgrade Word
> because one person got a new version and everyone else needed to upgrade to
> be compatible. There's a LOT of pain during that process. Is that really the
> best way to go?

I think there's going to be a lot of pain regardless. Any attempt to
mitigate that pain and work seamlessly across old and new versions of
git is going cause _ongoing_ pain as people quietly rewrite the same
content back and forth with different hashes. The viral-convergence
strategy is painful once (when you're forced to upgrade), but after that
just works.

If you want to work on a dual-hash strategy, be my guest. I can't
promise I'll be able to find horrific corner cases in it, but I
certainly can't even try to do so until there is a concrete proposal. :)

-Peff
