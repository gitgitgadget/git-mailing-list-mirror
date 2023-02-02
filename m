Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50796C05027
	for <git@archiver.kernel.org>; Thu,  2 Feb 2023 00:07:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbjBBAHi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Feb 2023 19:07:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjBBAHg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Feb 2023 19:07:36 -0500
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C77644A23F
        for <git@vger.kernel.org>; Wed,  1 Feb 2023 16:07:35 -0800 (PST)
Received: (qmail 7075 invoked by uid 109); 2 Feb 2023 00:07:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 02 Feb 2023 00:07:35 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 25981 invoked by uid 111); 2 Feb 2023 00:07:34 -0000
Received: from coredump.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 01 Feb 2023 19:07:34 -0500
Authentication-Results: peff.net; auth=none
Date:   Wed, 1 Feb 2023 19:07:34 -0500
From:   Jeff King <peff@peff.net>
To:     Florian Bezdeka <florian.bezdeka@siemens.com>
Cc:     Jacob Keller <jacob.keller@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "greg.pflaum@pnp-hcl.com" <greg.pflaum@pnp-hcl.com>,
        Gerhard Rieger <gerhard@dest-unreach.org>
Subject: Re: Bug: Cloning git repositories behind a proxy using the git://
 protocol broken since 2.32
Message-ID: <Y9r+xm8/LbVBLIZ4@coredump.intra.peff.net>
References: <4831bbeb0ec29ec84f92e0badfc0d628ecc6921d.camel@siemens.com>
 <Y9j1RxKhNq2TnL4U@tapette.crustytoothpaste.net>
 <339359ee8a228ea108109cf852bcb7e145807dcf.camel@siemens.com>
 <CA+P7+xpgJKojMmcN9TuGDw8oduQSQk-5nUtsWc+4Seqa+eVDJQ@mail.gmail.com>
 <840bbd91453529571a9d4f13472a12f6e472d198.camel@siemens.com>
 <Y9pa/YHnrrMU/ufV@coredump.intra.peff.net>
 <494ac71b378b1afb4349a4fb86767f7f77e781b3.camel@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <494ac71b378b1afb4349a4fb86767f7f77e781b3.camel@siemens.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 01, 2023 at 01:53:34PM +0100, Florian Bezdeka wrote:

> > The ideal, of course, would be an option to send the half-duplex
> > shutdown to the server and then wait for the server to hang up. But I
> > don't think it has such an option (you can just simulate it with a
> > really large "-t"). Netcat does, FWIW ("-q -1").
> 
> -t doesn't help here. With massive help from the socat maintainer
> (thanks Gerhard!, now in CC) I was able to get the following log out of
> socat:
> 
> 2023/02/01 11:06:29.960194 socat[18916] D read(0, 0x56111c858000, 8192)
> 2023/02/01 11:06:29.960208 socat[18916] D read -> 0
> 
> stdin had EOF. Socat half closes the socket:
> 
> 2023/02/01 11:06:29.960231 socat[18916] I shutdown(6, 1)
> 
> And then, within less than 0.2s, the peer (proxy?) closes the other
> channel:
> 
> 2023/02/01 11:06:30.118216 socat[18916] D read(6, 0x56111c858000, 8192)
> 2023/02/01 11:06:30.118238 socat[18916] D read -> 0
> 
> It's quite clear now that the remote peer (proxy or server) closes the
> complete connection after receiving the partial shutdown. That's
> nothing that is under my control.
>
> With privoxy and the infrastructure at work (zscaler based) there are
> at least two proxy implementations showing this behavior.

OK, so the problem is that socat is not terminating at git-daemon, but
rather at some other random infrastructure that also does not handle
half-duplex shutdowns in a reasonable way. <sigh>

So if we took socat out of the loop entirely, and if raw git-over-tcp
did the half-duplex shutdown for the v2 protocol (which it really ought
to be doing), then those proxies would presumably similarly break.

I dunno. I am sympathetic that this thing used to work, and now doesn't.
But really the issue is in the v2 protocol, which has no way to signal
"I'm done" short of closing the socket. Combining that with raw
git-over-tcp and over-zealous proxies is going to be a problem.

> Switching to ncat --no-shutdown qualifies as workaround for now, but so
> far I didn't manage to get socat back into the game. Downgrading git is
> the other possibility.

Did you try setting protocol.version to 0? I expect that would also
work.

IMHO the best option, if possible, is to use git-over-http. It's more
secure and generally more tested than git-over-tcp.

-Peff
