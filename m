Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8A023201B0
	for <e@80x24.org>; Tue, 28 Feb 2017 19:28:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751457AbdB1T2Y (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Feb 2017 14:28:24 -0500
Received: from cloud.peff.net ([104.130.231.41]:35839 "EHLO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751099AbdB1T2V (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Feb 2017 14:28:21 -0500
Received: (qmail 16459 invoked by uid 109); 28 Feb 2017 19:20:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 28 Feb 2017 19:20:46 +0000
Received: (qmail 28867 invoked by uid 111); 28 Feb 2017 19:20:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 28 Feb 2017 14:20:52 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 28 Feb 2017 14:20:44 -0500
Date:   Tue, 28 Feb 2017 14:20:44 -0500
From:   Jeff King <peff@peff.net>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Dan Shumow <danshu@microsoft.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Joey Hess <id@joeyh.name>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: SHA1 collisions found
Message-ID: <20170228192044.cn56puazsa3wtlkd@sigill.intra.peff.net>
References: <20170223184637.xr74k42vc6y2pmse@sigill.intra.peff.net>
 <CA+55aFx=0EVfSG2iEKKa78g3hFN_yZ+L_FRm4R749nNAmTGO9w@mail.gmail.com>
 <20170223193210.munuqcjltwbrdy22@sigill.intra.peff.net>
 <CA+55aFxmr6ntWGbJDa8tOyxXDX3H-yd4TQthgV_Tn1u91yyT8w@mail.gmail.com>
 <20170223195753.ppsat2gwd3jq22by@sigill.intra.peff.net>
 <alpine.LFD.2.20.1702231428540.30435@i7.lan>
 <20170223224302.joti4zqucme3vqr2@sigill.intra.peff.net>
 <20170223230507.kuxjqtg3ghcfskc6@sigill.intra.peff.net>
 <xmqqefyikvin.fsf@gitster.mtv.corp.google.com>
 <xmqq60jukubq.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqq60jukubq.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 28, 2017 at 11:07:37AM -0800, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> >>   [1/3]: add collision-detecting sha1 implementation
> >>   [2/3]: sha1dc: adjust header includes for git
> >>   [3/3]: Makefile: add USE_SHA1DC knob
> >
> > I was lazy so I fetched the above and then added this on top before
> > I start to play with it.
> >
> > -- >8 --
> > From: Junio C Hamano <gitster@pobox.com>
> > Date: Tue, 28 Feb 2017 10:39:25 -0800
> > Subject: [PATCH] sha1dc: resurrect LICENSE file
> 
> In a way similar to 8415558f55 ("sha1dc: avoid c99
> declaration-after-statement", 2017-02-24), we would want this on
> top.
> 
> -- >8 --
> Subject: sha1dc: avoid 'for' loop initial decl

Yeah, thanks, I had tweaked both that and the license thing locally but
had not pushed it out yet. Both are obvious improvements.

FWIW, I've been in touch with Dan Shumow, one of the authors, who has
been looking at whether we can speed up the sha1dc implementation, or
integrate the checks into the block-sha1 implementation.

Here are a few notes on the earlier timings I posted that came out in
our conversation:

  - the timings I showed earlier were actually openssl versus sha1dc.
    The block-sha1 timings fall somewhere in the middle:

      [running test-sha1 on a fresh linux.git packfile]
      1.347s openssl
      2.079s block-sha1
      4.983s sha1dc

      [index-pack --verify on a fresh git.git packfile]
       6.919s openssl
       9.003s block-sha1
      17.955s sha1dc

    Those are the operations that show off sha1 performance the most.
    The first one is really not even that interesting; it's raw
    sha1 performance. The second one is an actual operation users might
    notice (though not as --verify exactly, but as "index-pack --stdin"
    when receiving a fetch or a push).

    So there's room for improvement, but the gap between block-sha1
    and sha1dc is not quite as big as I showed earlier.

  - Dan timed the sha1dc implementation with and without the collision
    detection enabled. The sha1 implementation is only 1.33x slower than
    block-sha1 (for raw sha1 time). Adding in the detection makes it
    2.6x slower.

    So there's some potential gain from optimizing the sha1
    implementation, but ultimately we may be looking at a 2x slowdown to
    add in the collision detection.

    It doesn't need to happen for _every_ sha1 we compute, but the
    index-pack case is the one that almost certainly _does_ want it,
    because that's when we're admitting remote objects into the
    repository (ditto you'd probably want it for write_sha1_file(),
    since you could be applying a patch from an untrusted source).

-Peff
