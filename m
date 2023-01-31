Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 534A4C38142
	for <git@archiver.kernel.org>; Tue, 31 Jan 2023 23:21:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231730AbjAaXVK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Jan 2023 18:21:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230414AbjAaXVI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jan 2023 18:21:08 -0500
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 31 Jan 2023 15:21:01 PST
Received: from mta-64-228.siemens.flowmailer.net (mta-64-228.siemens.flowmailer.net [185.136.64.228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 675E510261
        for <git@vger.kernel.org>; Tue, 31 Jan 2023 15:21:01 -0800 (PST)
Received: by mta-64-228.siemens.flowmailer.net with ESMTPSA id 2023013123195669c78550d22b7f7082
        for <git@vger.kernel.org>;
        Wed, 01 Feb 2023 00:19:56 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=tQqeIEKlRVgqK0jtcHd6mnrMButbbM1jaT4egd3zQhs=;
 b=iaqZvlvxzj2KahcGomHCo3AbS8YAtLApCUp4GBugwWG1Nl+Xn+YKV1CIvV6pzC6OG3sFDn
 FkD11/mCQ6dKPLWT22XjVg7hSAjaodViEA6ydTkx5la6uJWq8NaBeY3eBLlVozk3KX+PcsuF
 b4/2FzjBkGx6cwICYO5tr00tujDYE=;
Message-ID: <840bbd91453529571a9d4f13472a12f6e472d198.camel@siemens.com>
Subject: Re: Bug: Cloning git repositories behind a proxy using the git://
 protocol broken since 2.32
From:   Florian Bezdeka <florian.bezdeka@siemens.com>
To:     Jacob Keller <jacob.keller@gmail.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        "git@vger.kernel.org" <git@vger.kernel.org>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "greg.pflaum@pnp-hcl.com" <greg.pflaum@pnp-hcl.com>,
        "peff@peff.net" <peff@peff.net>
Date:   Wed, 01 Feb 2023 00:19:55 +0100
In-Reply-To: <CA+P7+xpgJKojMmcN9TuGDw8oduQSQk-5nUtsWc+4Seqa+eVDJQ@mail.gmail.com>
References: <4831bbeb0ec29ec84f92e0badfc0d628ecc6921d.camel@siemens.com>
         <Y9j1RxKhNq2TnL4U@tapette.crustytoothpaste.net>
         <339359ee8a228ea108109cf852bcb7e145807dcf.camel@siemens.com>
         <CA+P7+xpgJKojMmcN9TuGDw8oduQSQk-5nUtsWc+4Seqa+eVDJQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 2023-01-31 at 12:31 -0800, Jacob Keller wrote:
> On Tue, Jan 31, 2023 at 4:17 AM Florian Bezdeka
> <florian.bezdeka@siemens.com> wrote:
> > Thanks for the super fast response, highly appreciated!
> >=20
> > I was able to get it running by switching to ncat using the --no-
> > shutdown option, but I failed to bring back socat support so far.
> >=20
> > For me this is still a regression. We have to change our
> > infrastructure/environment because we have a new requirement
> > (independent handling of stdin/out) after updating git now. I would
> > expect some noise from the yocto/OE community in the future where oe-
> > git-proxy is heavily used.
> >=20
> > I guess proxy support was forgotten when the referenced change was
> > made. Any chance we can avoid closing stdout when running "in proxy
> > mode" to restore backward compatibility?
> >=20
> > Thanks a lot!
>=20
> I had this issue in the past and i got it working with socat using "-t
> 10". You need a timeout that is larger than the keep alive value of 5
> seconds which is sent by the git protocol.
>=20
> Junio pointed out the excellent analysis from Peff regarding the
> situation and the fact that socat is wrong here.

Thanks for pointing me to the old discussion. I was quite sure that I'm
not the first one facing this problem but couldn't find something.

It might be that socat is doing something wrong. But git is the
component that triggers the problem. Did someone talk to the socat
maintainers yet?

Peff also mentioned that the half-duplex shutdown of the socket is
inconsistent between proxy and raw TCP git://. It seems still a valid
option to skip the half-shutdown for the git:// proxy scenario.

>=20
> What value of -t did you try?

I was playing with -t 10 and -t 60 so far. Both does not work for
cloning a kernel stable tree. I guess it's hard to find a value that
works under all circumstances as timings might be different depending
on server/network speed.

