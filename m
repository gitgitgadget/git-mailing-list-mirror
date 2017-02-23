Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 712DE2022D
	for <e@80x24.org>; Thu, 23 Feb 2017 19:42:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751220AbdBWTmk (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Feb 2017 14:42:40 -0500
Received: from cloud.peff.net ([104.130.231.41]:60986 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751170AbdBWTmj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2017 14:42:39 -0500
Received: (qmail 12139 invoked by uid 109); 23 Feb 2017 19:42:39 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 23 Feb 2017 19:42:39 +0000
Received: (qmail 6193 invoked by uid 111); 23 Feb 2017 19:42:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 23 Feb 2017 14:42:43 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 23 Feb 2017 14:42:37 -0500
Date:   Thu, 23 Feb 2017 14:42:37 -0500
From:   Jeff King <peff@peff.net>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        David Turner <David.Turner@twosigma.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "sandals@crustytoothpaste.net" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] http(s): automatically try NTLM authentication first
Message-ID: <20170223194237.eckkpiqv7inuz7un@sigill.intra.peff.net>
References: <20170222173936.25016-1-dturner@twosigma.com>
 <xmqqpoiaasgj.fsf@gitster.mtv.corp.google.com>
 <97ab9a812f7b46d7b10d4d06f73259d8@exmbdft7.ad.twosigma.com>
 <xmqq8toyapu6.fsf@gitster.mtv.corp.google.com>
 <20170222213410.iak43asq775tzr42@sigill.intra.peff.net>
 <alpine.DEB.2.20.1702231806340.3767@virtualbox>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.20.1702231806340.3767@virtualbox>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 23, 2017 at 06:08:49PM +0100, Johannes Schindelin wrote:

> > I suspect the patch above could probably be generalized as:
> > 
> >   /* cut out methods we know the server doesn't support */
> >   http_auth_methods &= results.auth_avail;
> > 
> > and let curl figure it out from there.
> 
> Maybe this patch (or a variation thereof) would also be able to fix this
> problem with the patch:
> 
> 	https://github.com/git-for-windows/git/issues/1034
> 
> Short version: for certain servers (that do *not* advertise Negotiate),
> setting emptyauth to true will result in a failed fetch, without letting
> the user type in their credentials.

I suspect it isn't enough to help without 2/2. This will tell curl that
the server does not do Negotiate, so it will skip the probe request. But
Git will still feed curl the bogus empty credential.

That's what 2/2 tries to fix: only kick in the emptyAuth hack when there
is something besides Basic[1] to try. The way it is written adds an
extra "auto" mode to emptyAuth, as I wanted to leave "emptyauth=true" as
a workaround in case the "auto" behavior does not work. And then I
turned on "auto" by default, since that was what the discussion was
shooting for.

But if we are worried about turning on emptyAuth everywhere, the auto
behavior could be tied to emptyauth=true (and have something like
"emptyauth=always" to _really_ force it). I don't have an opinion there.
It sounds like emptyauth has been enabled by default on Windows for a
while. It's not clear to me if that's a security problem or not.

-Peff
