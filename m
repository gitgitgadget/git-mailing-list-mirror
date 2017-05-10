Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7A38E2018D
	for <e@80x24.org>; Wed, 10 May 2017 05:26:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751081AbdEJF0g (ORCPT <rfc822;e@80x24.org>);
        Wed, 10 May 2017 01:26:36 -0400
Received: from ns332406.ip-37-187-123.eu ([37.187.123.207]:51594 "EHLO
        glandium.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750780AbdEJF0f (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 May 2017 01:26:35 -0400
X-Greylist: delayed 2400 seconds by postgrey-1.27 at vger.kernel.org; Wed, 10 May 2017 01:26:34 EDT
Received: from glandium by mitsuha.glandium.org with local (Exim 4.89)
        (envelope-from <mh@glandium.org>)
        id 1d8JW6-0008B0-U8; Wed, 10 May 2017 13:46:26 +0900
Date:   Wed, 10 May 2017 13:46:26 +0900
From:   Mike Hommey <mh@glandium.org>
To:     Jeff King <peff@peff.net>
Cc:     Shawn Pearce <spearce@spearce.org>,
        Jonathan Tan <jonathantanmy@google.com>,
        git <git@vger.kernel.org>
Subject: Re: [PATCH] fetch-pack: always allow fetching of literal SHA1s
Message-ID: <20170510044626.g4dwcujfr7vhv55d@glandium.org>
References: <20170509182042.28389-1-jonathantanmy@google.com>
 <20170509221629.3z35qcz36oiix3kh@sigill.intra.peff.net>
 <CAJo=hJvAg2WqpiuykpbHcB5vgQiHJ74CZ8Y4qudkYqZrmd30zg@mail.gmail.com>
 <20170510043343.mgb7heqzu2etcgvf@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170510043343.mgb7heqzu2etcgvf@sigill.intra.peff.net>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: NeoMutt/20170306 (1.8.0)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 10, 2017 at 12:33:44AM -0400, Jeff King wrote:
> On Tue, May 09, 2017 at 09:22:11PM -0700, Shawn Pearce wrote:
> 
> > > Hmm. That makes sense generally, as the request should succeed. But it
> > > seems like we're creating a client that will sometimes succeed and
> > > sometimes fail, and the reasoning will be somewhat opaque to the user.
> > > I have a feeling I'm missing some context on when you'd expect this to
> > > kick in.
> > 
> > Specifically, someone I know was looking at building an application
> > that is passed only a SHA-1 for the tip of a ref on a popular hosting
> > site[1]. They wanted to run `git fetch URL SHA1`, but this failed
> > because the site doesn't have upload.allowtipsha1inwant enabled.
> > However the SHA1 was clearly in the output of git ls-remote.
> 
> OK. So this is basically a case where we expect that the user knows what
> they're doing.
> 
> > For various reasons they expected this to work, because it works
> > against other sites that do have upload.allowtipsha1inwant enabled.
> > And I personally just expected it to work because the fetch client
> > accepts SHA-1s, and the wire protocol uses "want SHA1" not "want ref",
> > and the SHA-1 passed on the command line was currently in the
> > advertisement when the connection opened, so its certainly something
> > the server is currently willing to serve.
> 
> Right, makes sense.  I wondered if GitHub should be turning on
> allowTipSHA1InWant, but it really doesn't make sense to. We _do_ hide
> some internal refs[1], and they're things that users wouldn't want to
> fetch. The problem for your case really is just on the client side, and
> this patch fixes it.

More broadly, I think it is desirable that any commit that can be
reached from public refs can be fetched by an explicit sha1 without
allowTipSHA1InWant.

Mike
