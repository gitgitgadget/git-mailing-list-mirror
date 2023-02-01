Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E555C636CD
	for <git@archiver.kernel.org>; Wed,  1 Feb 2023 12:54:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbjBAMyo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Feb 2023 07:54:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbjBAMyn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Feb 2023 07:54:43 -0500
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 01 Feb 2023 04:54:40 PST
Received: from mta-65-226.siemens.flowmailer.net (mta-65-226.siemens.flowmailer.net [185.136.65.226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 566892D63
        for <git@vger.kernel.org>; Wed,  1 Feb 2023 04:54:40 -0800 (PST)
Received: by mta-65-226.siemens.flowmailer.net with ESMTPSA id 20230201125335589f7e3dddc1a13ba7
        for <git@vger.kernel.org>;
        Wed, 01 Feb 2023 13:53:35 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=+FPQP2lrA4BpaS1TJdbtggsuJ6uc3QZSeY6QZi0gAEw=;
 b=g/eXnZGm2SvY9uVbMZnmyOrL/9KK4leDqQTcCD2Eh2qkD73hSBYNQq2iTSxc/RfW9CfP64
 LXtZj5w0eeE3iqrF5BGFjgtSgglW02ik53ElkjKWWt+pXEs6bXGCuBe9OSZ3ZFuPEqMzqie+
 8Zm7qQpP03PJPvgJ9Bjl47h+W6HEg=;
Message-ID: <494ac71b378b1afb4349a4fb86767f7f77e781b3.camel@siemens.com>
Subject: Re: Bug: Cloning git repositories behind a proxy using the git://
 protocol broken since 2.32
From:   Florian Bezdeka <florian.bezdeka@siemens.com>
To:     Jeff King <peff@peff.net>
Cc:     Jacob Keller <jacob.keller@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "greg.pflaum@pnp-hcl.com" <greg.pflaum@pnp-hcl.com>,
        Gerhard Rieger <gerhard@dest-unreach.org>
Date:   Wed, 01 Feb 2023 13:53:34 +0100
In-Reply-To: <Y9pa/YHnrrMU/ufV@coredump.intra.peff.net>
References: <4831bbeb0ec29ec84f92e0badfc0d628ecc6921d.camel@siemens.com>
         <Y9j1RxKhNq2TnL4U@tapette.crustytoothpaste.net>
         <339359ee8a228ea108109cf852bcb7e145807dcf.camel@siemens.com>
         <CA+P7+xpgJKojMmcN9TuGDw8oduQSQk-5nUtsWc+4Seqa+eVDJQ@mail.gmail.com>
         <840bbd91453529571a9d4f13472a12f6e472d198.camel@siemens.com>
         <Y9pa/YHnrrMU/ufV@coredump.intra.peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, 2023-02-01 at 07:28 -0500, Jeff King wrote:
> On Wed, Feb 01, 2023 at 12:19:55AM +0100, Florian Bezdeka wrote:
>=20
> > > Junio pointed out the excellent analysis from Peff regarding the
> > > situation and the fact that socat is wrong here.
> >=20
> > Thanks for pointing me to the old discussion. I was quite sure that I'm
> > not the first one facing this problem but couldn't find something.
> >=20
> > It might be that socat is doing something wrong. But git is the
> > component that triggers the problem. Did someone talk to the socat
> > maintainers yet?
>=20
> I'm not sure I'd say that socat is wrong. It's a generic tool, and it
> doesn't know what type of protocol the two sides are expecting, or how
> they'll handle half-duplex shutdowns. The default behavior is to wait
> 0.5 seconds to see if the other side has anything to say, which is a
> reasonable compromise. It's just not enough for use a Git proxy in this
> case.
>=20
> The ideal, of course, would be an option to send the half-duplex
> shutdown to the server and then wait for the server to hang up. But I
> don't think it has such an option (you can just simulate it with a
> really large "-t"). Netcat does, FWIW ("-q -1").

-t doesn't help here. With massive help from the socat maintainer
(thanks Gerhard!, now in CC) I was able to get the following log out of
socat:

2023/02/01 11:06:29.960194 socat[18916] D read(0, 0x56111c858000, 8192)
2023/02/01 11:06:29.960208 socat[18916] D read -> 0

stdin had EOF. Socat half closes the socket:

2023/02/01 11:06:29.960231 socat[18916] I shutdown(6, 1)

And then, within less than 0.2s, the peer (proxy?) closes the other
channel:

2023/02/01 11:06:30.118216 socat[18916] D read(6, 0x56111c858000, 8192)
2023/02/01 11:06:30.118238 socat[18916] D read -> 0

It's quite clear now that the remote peer (proxy or server) closes the
complete connection after receiving the partial shutdown. That's
nothing that is under my control.

With privoxy and the infrastructure at work (zscaler based) there are
at least two proxy implementations showing this behavior.=20

Switching to ncat --no-shutdown qualifies as workaround for now, but so
far I didn't manage to get socat back into the game. Downgrading git is
the other possibility.

>=20
> > Peff also mentioned that the half-duplex shutdown of the socket is
> > inconsistent between proxy and raw TCP git://. It seems still a valid
> > option to skip the half-shutdown for the git:// proxy scenario.
>=20
> It could be done, but that would reintroduce the "oops, socat died while
> we were waiting" that ae1a7eefff was solving. The original motivation
> was with ssh, but the same problem exists for proxies. It _doesn't_
> exist for raw TCP, because nobody notices the connection died (we just
> close() it), and there's no error to propagate.
>=20
> The raw TCP version does still suffer from leaving the connection open
> unnecessarily, so it would benefit from getting the same treatment. I
> didn't care enough to implement it (and TBH, I kind of hoped that git://
> was on the decline; especially with the v2 protocol, it's pretty much
> worse in every way than git-over-http).
>=20
> > > What value of -t did you try?
> >=20
> > I was playing with -t 10 and -t 60 so far. Both does not work for
> > cloning a kernel stable tree. I guess it's hard to find a value that
> > works under all circumstances as timings might be different depending
> > on server/network speed.
>=20
> Anything over "5" should be sufficient, because the other side should be
> sending keep-alive packets (at the Git protocol level) every 5 seconds.
> It might be worth running socat under strace to see what it's seeing and
> doing.
>=20
> Another workaround is to set protocol.version to "0" in your Git config.
>=20
> -Peff

