Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 43A1E1F667
	for <e@80x24.org>; Thu, 10 Aug 2017 23:09:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752890AbdHJXJE (ORCPT <rfc822;e@80x24.org>);
        Thu, 10 Aug 2017 19:09:04 -0400
Received: from cloud.peff.net ([104.130.231.41]:35530 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1752440AbdHJXJE (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Aug 2017 19:09:04 -0400
Received: (qmail 1679 invoked by uid 109); 10 Aug 2017 23:09:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 10 Aug 2017 23:09:04 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 11544 invoked by uid 111); 10 Aug 2017 23:09:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with SMTP; Thu, 10 Aug 2017 19:09:27 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 10 Aug 2017 19:09:02 -0400
Date:   Thu, 10 Aug 2017 19:09:02 -0400
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: [PATCH 0/4] dropping support for older curl
Message-ID: <20170810230902.wnzoiaxdaus74a5i@sigill.intra.peff.net>
References: <20170809120024.7phdjzjv54uv5dpz@sigill.intra.peff.net>
 <alpine.DEB.2.21.1.1708092337350.11175@virtualbox>
 <20170809214758.p77fqrwxanb4zn5a@sigill.intra.peff.net>
 <alpine.DEB.2.21.1.1708101111080.11175@virtualbox>
 <20170810213348.g4lue3j4uz6qapal@sigill.intra.peff.net>
 <xmqqshgz1319.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqshgz1319.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 10, 2017 at 03:17:06PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > On Thu, Aug 10, 2017 at 11:36:41AM +0200, Johannes Schindelin wrote:
> >
> >> Hopefully I had better luck expressing my concerns this time?
> >
> > I understand your argument much better now. I'm still not sure I agree.
> >
> > -Peff
> 
> I do not think "there are a dozen #ifdefs and I don't know whether
> they still work. I don't know whether anybody (who most likely has
> better things to do than read the Git mailing list) is still using
> those.  So let's just remove them." was why you were suggesting to
> clean up the (apparent) support of older curl in the code, though.
> 
> Isn't the reason why your series simplifies these #ifdefs away
> because we by accident started using some features that require a
> version that is even newer than any of these #ifdef's try to cater
> to and yet nobody complained?  That is a lot more similar to the
> removal of rsync transport that happened in a not so distant past,
> where the reason for removal was "We have been shipping code that
> couldn't have possibly worked for some time and nobody complained
> ---we know nobody is depending on it."

I think there are two questions to be asked, and their answers come from
different lines of reasoning.

The first is "should we eventually drop support for antiquated versions
of dependencies?". And the argument in favor is the one I was making
here: besides lowering maintenance cost, it is more honest to our users
about what to expect[1].

The second is "how far back should we keep support?".

And there are two lines of thought there.

One is to do it by date and what dependencies are in long-term OS
releases, and then compare that to the benefit. Requiring curl 7.11.1
still keeps us working back to rhel4, which was already end-of-lifed
completely after a 12 year run. Bumping to 7.16.0 drops rhel4 and rhel5,
the latter of which is in its final "barely supported" phase after 10
years. But it gives us a bit more bang for our buck by making CURL_MULTI
uconditional[2].  Requiring 7.19.4 actually doesn't drop any more rhel
releases. So by that metric, we might as well go there.

And the second line of thought is: it was already broken and nobody
reported it or offered up a fix. And that's where the "similar to rsync"
thing comes in. Though in this case we do have some evidence that people
(at least Tom) was patching and distributing behind the scenes. And our
breakage period was much shorter (since v2.12.0, but that's only months
or so).

-Peff
