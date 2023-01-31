Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CE24C38142
	for <git@archiver.kernel.org>; Tue, 31 Jan 2023 12:08:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230244AbjAaMIs (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 31 Jan 2023 07:08:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbjAaMIr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 31 Jan 2023 07:08:47 -0500
Received: from mta-65-225.siemens.flowmailer.net (mta-65-225.siemens.flowmailer.net [185.136.65.225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D74A824CB7
        for <git@vger.kernel.org>; Tue, 31 Jan 2023 04:08:44 -0800 (PST)
Received: by mta-65-225.siemens.flowmailer.net with ESMTPSA id 202301311208419b6d203f51ae650dd0
        for <git@vger.kernel.org>;
        Tue, 31 Jan 2023 13:08:42 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm1;
 d=siemens.com; i=florian.bezdeka@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc:References:In-Reply-To;
 bh=dXACgoDxXsfH5rp3EQFjxtmjezhmzZ1JCnzsvsJ7kRU=;
 b=U3SJrrEwRItQO1Z9q7jDlTg92HFlh0JVSM7d4iQAMGwky6lViActypnZk0wzz9L5N3J4+8
 xrLKztNr6elmbLZetZ2dpduUejh5x0Vi3+ieNXNt8bfR6CPWHqKc+vmcXekaMQNg0K2fzO29
 KC/g/wymxjSVn4K67uy42IBjtEM1E=;
Message-ID: <339359ee8a228ea108109cf852bcb7e145807dcf.camel@siemens.com>
Subject: Re: Bug: Cloning git repositories behind a proxy using the git://
 protocol broken since 2.32
From:   Florian Bezdeka <florian.bezdeka@siemens.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>,
        "gitster@pobox.com" <gitster@pobox.com>,
        "greg.pflaum@pnp-hcl.com" <greg.pflaum@pnp-hcl.com>,
        "peff@peff.net" <peff@peff.net>
Date:   Tue, 31 Jan 2023 13:08:40 +0100
In-Reply-To: <Y9j1RxKhNq2TnL4U@tapette.crustytoothpaste.net>
References: <4831bbeb0ec29ec84f92e0badfc0d628ecc6921d.camel@siemens.com>
         <Y9j1RxKhNq2TnL4U@tapette.crustytoothpaste.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-68982:519-21489:flowmailer
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, 2023-01-31 at 11:02 +0000, brian m. carlson wrote:
> On 2023-01-31 at 10:52:47, Bezdeka, Florian wrote:
> > Hi all,
>=20
> Hey,
>=20
> > I just updated from git 2.30.2 (from Debian 11) to 2.39.0 (from Debian
> > testing) and realized that I can no longer clone repositories using the
> > git:// protocol.
> >=20
> > There is one specialty in my setup: I'm located behind a proxy, so
> > GIT_PROXY_COMMAND is set. I'm usiung the oe-git-proxy script [1] here.
> > My environment provides the http_proxy variable and privoxy [2] is
> > running on the server side. That information should be sufficient to
> > reproduce.
> >=20
> > I tried the following two repositories for testing:
> >  - git clone git://git.code.sf.net/p/linuxptp/code linuxptp
> >  - git clone git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux=
.git
> >=20
> > The result is:
> > Cloning into 'linuxptp'...
> > fetch-pack: unexpected disconnect while reading sideband packet
> > fatal: early EOF
> > fatal: fetch-pack: invalid index-pack output
> >=20
> > I was able to "git bisect" it to the following commit:
> > ae1a7eefffe6 ("fetch-pack: signal v2 server that we are done making req=
uests")
> >=20
> > Reverting this commit on top of the master branch fixes my issue.
> > All people involved in this commit should be in CC.
> >=20
> > Looking at the TCP byte stream shows that the socket is closed after
> > the client received the first "part" of the packfile.
> >=20
> > ...
> > 0032want ec3f28a0ac13df805278164f2c72e69676d13134
> > 0032want 57caf5d94876e8329be65d2dc29d3c528b149724
> > 0009done
> > 0000000dpackfile
> >=20
> > Let me know if you need further information. Hopefully this was the
> > correct way of submitting a bug to git...
>=20
> I think this may have come up before, and I think the rule is that you
> need a proxy where closing standard input doesn't close standard output.
> Since that script is using socat, I believe you need the -t option to
> make this work, or some other approach where standard input and standard
> output can be closed independently.

Thanks for the super fast response, highly appreciated!

I was able to get it running by switching to ncat using the --no-
shutdown option, but I failed to bring back socat support so far.

For me this is still a regression. We have to change our
infrastructure/environment because we have a new requirement
(independent handling of stdin/out) after updating git now. I would
expect some noise from the yocto/OE community in the future where oe-
git-proxy is heavily used.

I guess proxy support was forgotten when the referenced change was
made. Any chance we can avoid closing stdout when running "in proxy
mode" to restore backward compatibility?

Thanks a lot!

Florian


