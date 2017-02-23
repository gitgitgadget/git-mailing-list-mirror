Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6E2292022D
	for <e@80x24.org>; Thu, 23 Feb 2017 20:48:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751279AbdBWUsR (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Feb 2017 15:48:17 -0500
Received: from cloud.peff.net ([104.130.231.41]:32847 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751259AbdBWUsQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Feb 2017 15:48:16 -0500
Received: (qmail 16657 invoked by uid 109); 23 Feb 2017 20:48:07 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 23 Feb 2017 20:48:07 +0000
Received: (qmail 15817 invoked by uid 111); 23 Feb 2017 20:48:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 23 Feb 2017 15:48:10 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 23 Feb 2017 15:48:04 -0500
Date:   Thu, 23 Feb 2017 15:48:04 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        David Turner <David.Turner@twosigma.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "sandals@crustytoothpaste.net" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] http(s): automatically try NTLM authentication first
Message-ID: <20170223204804.syj6tgjdrgmqdzna@sigill.intra.peff.net>
References: <20170222173936.25016-1-dturner@twosigma.com>
 <xmqqpoiaasgj.fsf@gitster.mtv.corp.google.com>
 <97ab9a812f7b46d7b10d4d06f73259d8@exmbdft7.ad.twosigma.com>
 <xmqq8toyapu6.fsf@gitster.mtv.corp.google.com>
 <20170222213410.iak43asq775tzr42@sigill.intra.peff.net>
 <alpine.DEB.2.20.1702231806340.3767@virtualbox>
 <20170223194237.eckkpiqv7inuz7un@sigill.intra.peff.net>
 <xmqqlgsw7iey.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqlgsw7iey.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 23, 2017 at 12:37:25PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > I suspect it isn't enough to help without 2/2. This will tell curl that
> > the server does not do Negotiate, so it will skip the probe request. But
> > Git will still feed curl the bogus empty credential.
> >
> > That's what 2/2 tries to fix: only kick in the emptyAuth hack when there
> > is something besides Basic[1] to try. The way it is written adds an
> 
> In your [1] you wanted to mention that Digest would have the same
> property as Basic, or something like that?

Oops, yeah. What I was going to say is that we may want a list of auth
types where we _do_ want the hack on, rather than ones where we know it
does not work. People are more likely to notice when the list is wrong,
then.

> > But if we are worried about turning on emptyAuth everywhere, the auto
> > behavior could be tied to emptyauth=true (and have something like
> > "emptyauth=always" to _really_ force it). I don't have an opinion there.
> 
> I do not have a strong opinion, either, but it sounds like that even
> the "disable emptyAuth hack if the server is Basic only" variant
> would be much better than setting emptyAuth on by default.  At least
> the user whose issue was reported in Dscho's message would be fixed
> by such a variant, I would think (i.e. talking to a server with no
> Negotiate and emptyAuth set to true results in no attempt to give
> the user a chance to tell who s/he is --- your 2/2 will turn
> emptyAuth off in that case).

Yes, I agree that the "auto" behavior is better than defaulting to
"true". I am speaking from the perspective of git.git, which is
currently defaulting to "false". It is not clear to me if "auto" is
better than "false" because of the security implications.

For Git for Windows, it seems like the auto behavior would be a strict
improvement over the "true" default they've been shipping.

-Peff
