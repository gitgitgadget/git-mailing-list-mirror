Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 763632018D
	for <e@80x24.org>; Wed, 10 May 2017 04:33:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752033AbdEJEdu (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 May 2017 00:33:50 -0400
Received: from cloud.peff.net ([104.130.231.41]:48585 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751955AbdEJEdu (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 May 2017 00:33:50 -0400
Received: (qmail 14799 invoked by uid 109); 10 May 2017 04:33:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 10 May 2017 04:33:46 +0000
Received: (qmail 32055 invoked by uid 111); 10 May 2017 04:34:17 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 10 May 2017 00:34:17 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 10 May 2017 00:33:44 -0400
Date:   Wed, 10 May 2017 00:33:44 -0400
From:   Jeff King <peff@peff.net>
To:     Shawn Pearce <spearce@spearce.org>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git <git@vger.kernel.org>
Subject: Re: [PATCH] fetch-pack: always allow fetching of literal SHA1s
Message-ID: <20170510043343.mgb7heqzu2etcgvf@sigill.intra.peff.net>
References: <20170509182042.28389-1-jonathantanmy@google.com>
 <20170509221629.3z35qcz36oiix3kh@sigill.intra.peff.net>
 <CAJo=hJvAg2WqpiuykpbHcB5vgQiHJ74CZ8Y4qudkYqZrmd30zg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJo=hJvAg2WqpiuykpbHcB5vgQiHJ74CZ8Y4qudkYqZrmd30zg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 09, 2017 at 09:22:11PM -0700, Shawn Pearce wrote:

> > Hmm. That makes sense generally, as the request should succeed. But it
> > seems like we're creating a client that will sometimes succeed and
> > sometimes fail, and the reasoning will be somewhat opaque to the user.
> > I have a feeling I'm missing some context on when you'd expect this to
> > kick in.
> 
> Specifically, someone I know was looking at building an application
> that is passed only a SHA-1 for the tip of a ref on a popular hosting
> site[1]. They wanted to run `git fetch URL SHA1`, but this failed
> because the site doesn't have upload.allowtipsha1inwant enabled.
> However the SHA1 was clearly in the output of git ls-remote.

OK. So this is basically a case where we expect that the user knows what
they're doing.

> For various reasons they expected this to work, because it works
> against other sites that do have upload.allowtipsha1inwant enabled.
> And I personally just expected it to work because the fetch client
> accepts SHA-1s, and the wire protocol uses "want SHA1" not "want ref",
> and the SHA-1 passed on the command line was currently in the
> advertisement when the connection opened, so its certainly something
> the server is currently willing to serve.

Right, makes sense.  I wondered if GitHub should be turning on
allowTipSHA1InWant, but it really doesn't make sense to. We _do_ hide
some internal refs[1], and they're things that users wouldn't want to
fetch. The problem for your case really is just on the client side, and
this patch fixes it.

Some of this context might be useful in the commit message.

-Peff

[1] The reachability checks from upload-pack don't actually do much on
    GitHub, because you can generally access the objects via the API or
    the web site anyway. So I'm not really opposed to turning on
    allowTipSHA1InWant if it would be useful for users, but after
    Jonathan's patch I don't see how it would be.
