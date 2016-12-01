Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3E92C1FF6D
	for <e@80x24.org>; Thu,  1 Dec 2016 22:30:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757961AbcLAWaT (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Dec 2016 17:30:19 -0500
Received: from cloud.peff.net ([104.130.231.41]:50302 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752152AbcLAWaS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2016 17:30:18 -0500
Received: (qmail 22190 invoked by uid 109); 1 Dec 2016 22:30:18 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 01 Dec 2016 22:30:18 +0000
Received: (qmail 5303 invoked by uid 111); 1 Dec 2016 22:30:54 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 01 Dec 2016 17:30:54 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 01 Dec 2016 17:30:16 -0500
Date:   Thu, 1 Dec 2016 17:30:16 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [RFC/PATCH] add diff-pairs tool
Message-ID: <20161201223016.vzxpzxxnqwq7n4fi@sigill.intra.peff.net>
References: <20161201204042.6yslbyrg7l6ghhww@sigill.intra.peff.net>
 <xmqqbmwv8j9m.fsf@gitster.mtv.corp.google.com>
 <20161201205504.flgaf7dwv3b3dkkd@sigill.intra.peff.net>
 <xmqq7f7j8iz6.fsf@gitster.mtv.corp.google.com>
 <20161201213019.qfkqd324ommikym2@sigill.intra.peff.net>
 <xmqqtwan70i0.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqtwan70i0.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Dec 01, 2016 at 02:22:47PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> >> It took me a while to dig it up because the topic is so old, but
> >> 
> >> https://public-inbox.org/git/Pine.LNX.4.58.0504251832480.18901@ppc970.osdl.org/
> >> 
> >> is the thread I had in mind.  The idea of rename detection followed
> >> soon afterwards.
> >
> > Thanks for an interesting read. Your diff-tree-helper patch is very
> > similar to what I wrote.
> >
> > I do think the right decision was made back then. The single-process
> > model is much more efficient, and it was over 10 years until somebody
> > actually wanted to expose the functionality to a script (and even now,
> > I'm not convinced enough people want it to even merit inclusion).
> 
> Well, 10 years ago the person in the thread who argued "who cares
> about producing patches?  each step in plumbing should do one thing
> and one thing only and do so well" was Linus, so your coming up with
> the diff-tree-helper again may indicate that we may want to step
> back and retry the experiment again, perhaps?

I think there are two questions, looking historically.

One is whether the functionality should be exposed to scripts at all.

The second is, assuming it should be exposed, in which order to do it.
You can write a series of small scripts, and then tie them together. Or
you can write tie it all together in C, and then make specific helpers
to expose the various bits.

The advantage of the first technique is that the tools are used
consistently by all parts of the system, so you know they don't grow
weird bugs or fail to handle corner cases. The advantage of the second
is that most people want the "tied-together" functionality, and it can
run a lot faster in-process.

So mostly I was suggesting that the right decision 10 years ago was to
optimize for speed in the common case, and let people worry later about
whether they wanted to expose the functionality in more flexible ways.
And that brings us to today.

It sounds like you are in favor of adding diff-pairs (and certainly it
shouldn't _hurt_ anybody if they are not interested in using it; you'll
notice the patch didn't need to touch the diff code at all).

-Peff
