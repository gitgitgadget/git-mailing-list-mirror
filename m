Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 31B3B2023D
	for <e@80x24.org>; Wed,  1 Mar 2017 21:52:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753438AbdCAVwl (ORCPT <rfc822;e@80x24.org>);
        Wed, 1 Mar 2017 16:52:41 -0500
Received: from cloud.peff.net ([104.130.231.41]:36712 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753369AbdCAVwk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Mar 2017 16:52:40 -0500
Received: (qmail 5428 invoked by uid 109); 1 Mar 2017 19:05:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 01 Mar 2017 19:05:26 +0000
Received: (qmail 6801 invoked by uid 111); 1 Mar 2017 19:05:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 01 Mar 2017 14:05:32 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 01 Mar 2017 14:05:24 -0500
Date:   Wed, 1 Mar 2017 14:05:24 -0500
From:   Jeff King <peff@peff.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Marc Stevens <marc.stevens@cwi.nl>,
        Dan Shumow <danshu@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>,
        Joey Hess <id@joeyh.name>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: SHA1 collisions found
Message-ID: <20170301190524.ocmsi37hv4d22mrc@sigill.intra.peff.net>
References: <20170223195753.ppsat2gwd3jq22by@sigill.intra.peff.net>
 <alpine.LFD.2.20.1702231428540.30435@i7.lan>
 <20170223224302.joti4zqucme3vqr2@sigill.intra.peff.net>
 <20170223230507.kuxjqtg3ghcfskc6@sigill.intra.peff.net>
 <xmqqefyikvin.fsf@gitster.mtv.corp.google.com>
 <xmqq60jukubq.fsf@gitster.mtv.corp.google.com>
 <CA+55aFxTWqsTTiDKo4DBZT-8Z9t80bGMD3uijzKONa_bYEZABQ@mail.gmail.com>
 <CY1PR0301MB21078DDCA8C679983D22821FC4560@CY1PR0301MB2107.namprd03.prod.outlook.com>
 <259cc328-13f7-2d2d-c86f-8b4fc7da8e34@cwi.nl>
 <CA+55aFwjzbhYyFm_MqL=cDZZeKbSjqd-jSeb0yW_bJ_WQTzEpA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+55aFwjzbhYyFm_MqL=cDZZeKbSjqd-jSeb0yW_bJ_WQTzEpA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 28, 2017 at 03:11:32PM -0800, Linus Torvalds wrote:

> > Of course for dedicated code this can be simplified, and some parts
> > could be further optimized.
> 
> So I'd be worried about changing your tested code too much, since the
> only test-cases we have are the two pdf files. If we screw up too
> much, those will no longer show as collisions, but we could get tons
> of false positives that we wouldn't see, so..

I can probably help with collecting data for that part on GitHub.

I don't have an exact count of how many sha1 computations we do in a
day, but it's...a lot. Obviously every pushed object gets its sha1
computed, but read operations also cover every commit and tree via
parse_object() (though I think most of the blob reads do not).

So it would be trivial to start by swapping out the "die()" on collision
with something that writes to a log. This is the slow path that we don't
expect to trigger at all, so log volume shouldn't be a problem.

I've been waiting to see how speedups develop before deploying it in
production.

-Peff
