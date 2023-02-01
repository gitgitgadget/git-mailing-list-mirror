Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13E98C05027
	for <git@archiver.kernel.org>; Wed,  1 Feb 2023 12:28:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231896AbjBAM2v (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Feb 2023 07:28:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbjBAM2t (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Feb 2023 07:28:49 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DA4E521E2
        for <git@vger.kernel.org>; Wed,  1 Feb 2023 04:28:46 -0800 (PST)
Received: (qmail 31725 invoked by uid 109); 1 Feb 2023 12:28:46 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 01 Feb 2023 12:28:46 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 19988 invoked by uid 111); 1 Feb 2023 12:28:45 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 01 Feb 2023 07:28:45 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 1 Feb 2023 07:28:45 -0500
From:   Jeff King <peff@peff.net>
To:     Florian Bezdeka <florian.bezdeka@siemens.com>
Cc:     Jacob Keller <jacob.keller@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "greg.pflaum@pnp-hcl.com" <greg.pflaum@pnp-hcl.com>
Subject: Re: Bug: Cloning git repositories behind a proxy using the git://
 protocol broken since 2.32
Message-ID: <Y9pa/YHnrrMU/ufV@coredump.intra.peff.net>
References: <4831bbeb0ec29ec84f92e0badfc0d628ecc6921d.camel@siemens.com>
 <Y9j1RxKhNq2TnL4U@tapette.crustytoothpaste.net>
 <339359ee8a228ea108109cf852bcb7e145807dcf.camel@siemens.com>
 <CA+P7+xpgJKojMmcN9TuGDw8oduQSQk-5nUtsWc+4Seqa+eVDJQ@mail.gmail.com>
 <840bbd91453529571a9d4f13472a12f6e472d198.camel@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <840bbd91453529571a9d4f13472a12f6e472d198.camel@siemens.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 01, 2023 at 12:19:55AM +0100, Florian Bezdeka wrote:

> > Junio pointed out the excellent analysis from Peff regarding the
> > situation and the fact that socat is wrong here.
> 
> Thanks for pointing me to the old discussion. I was quite sure that I'm
> not the first one facing this problem but couldn't find something.
> 
> It might be that socat is doing something wrong. But git is the
> component that triggers the problem. Did someone talk to the socat
> maintainers yet?

I'm not sure I'd say that socat is wrong. It's a generic tool, and it
doesn't know what type of protocol the two sides are expecting, or how
they'll handle half-duplex shutdowns. The default behavior is to wait
0.5 seconds to see if the other side has anything to say, which is a
reasonable compromise. It's just not enough for use a Git proxy in this
case.

The ideal, of course, would be an option to send the half-duplex
shutdown to the server and then wait for the server to hang up. But I
don't think it has such an option (you can just simulate it with a
really large "-t"). Netcat does, FWIW ("-q -1").

> Peff also mentioned that the half-duplex shutdown of the socket is
> inconsistent between proxy and raw TCP git://. It seems still a valid
> option to skip the half-shutdown for the git:// proxy scenario.

It could be done, but that would reintroduce the "oops, socat died while
we were waiting" that ae1a7eefff was solving. The original motivation
was with ssh, but the same problem exists for proxies. It _doesn't_
exist for raw TCP, because nobody notices the connection died (we just
close() it), and there's no error to propagate.

The raw TCP version does still suffer from leaving the connection open
unnecessarily, so it would benefit from getting the same treatment. I
didn't care enough to implement it (and TBH, I kind of hoped that git://
was on the decline; especially with the v2 protocol, it's pretty much
worse in every way than git-over-http).

> > What value of -t did you try?
> 
> I was playing with -t 10 and -t 60 so far. Both does not work for
> cloning a kernel stable tree. I guess it's hard to find a value that
> works under all circumstances as timings might be different depending
> on server/network speed.

Anything over "5" should be sufficient, because the other side should be
sending keep-alive packets (at the Git protocol level) every 5 seconds.
It might be worth running socat under strace to see what it's seeing and
doing.

Another workaround is to set protocol.version to "0" in your Git config.

-Peff
