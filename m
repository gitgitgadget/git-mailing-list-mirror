Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.7 required=3.0 tests=BAYES_00,DATE_IN_PAST_12_24,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D78DC47095
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 06:39:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E7E561185
	for <git@archiver.kernel.org>; Wed,  9 Jun 2021 06:39:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236805AbhFIGlS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Jun 2021 02:41:18 -0400
Received: from 82-64-198-250.subs.proxad.net ([82.64.198.250]:45660 "EHLO
        mail.lhuard.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236795AbhFIGlQ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Jun 2021 02:41:16 -0400
Received: from coruscant.lhuard.fr (unknown [IPv6:2a01:e0a:465:5440:7bea:9345:5cb6:1f04])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.lhuard.fr (Postfix) with ESMTPSA id 3502548846F;
        Wed,  9 Jun 2021 08:39:20 +0200 (CEST)
Authentication-Results: mail.lhuard.fr; dmarc=fail (p=quarantine dis=none) header.from=lhuard.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lhuard.fr; s=rpi3;
        t=1623220760; bh=cE0peeJ4c5tXoucS/im+TBQ7uIDWq7o/rKSLhuX4UqA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=S3bfow+6Fr3Nc2g0lF1h01e7ES7fTs2MgGC4SQeZC3YEba588n1URwe6e0FgfEh1v
         AiBhVaEooXYUYaDW41uvw6iea7qbVGNLpT4N1W+zNv+gyw1MV0G5Zu+TXvuOjq/VGI
         iBhES7nAH5eIiB8Bv5GS61MdKxtss8VzO2q54E6M=
From:   =?ISO-8859-1?Q?L=E9na=EFc?= Huard <lenaic@lhuard.fr>
To:     git@vger.kernel.org, phillip.wood@dunelm.org.uk
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>,
        =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v2 1/1] maintenance: use systemd timers on Linux
Date:   Tue, 08 Jun 2021 16:55:29 +0200
Message-ID: <13530009.9cuodmXfNX@coruscant.lhuard.fr>
In-Reply-To: <3fd17223-8667-24be-2e65-f1970d411bdf@gmail.com>
References: <20210501145220.2082670-1-lenaic@lhuard.fr> <20210509213217.449489-2-lenaic@lhuard.fr> <3fd17223-8667-24be-2e65-f1970d411bdf@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Phillip,

Le lundi 10 mai 2021, 20:03:58 CEST Phillip Wood a =C3=A9crit :
> > +	unit =3D "# This file was created and is maintained by Git.\n"
> > +	       "# Any edits made in this file might be replaced in the=20
future\n"
> > +	       "# by a Git command.\n"
> > +	       "\n"
> > +	       "[Unit]\n"
> > +	       "Description=3DOptimize Git repositories data\n"
> > +	       "\n"
> > +	       "[Service]\n"
> > +	       "Type=3Doneshot\n"
> > +	       "ExecStart=3D\"%1$s/git\" --exec-path=3D\"%1$s\" for-each-repo
> > --config=3Dmaintenance.repo maintenance run --schedule=3D%%i\n" +	     =
=20
> > "LockPersonality=3Dyes\n"
> > +	       "MemoryDenyWriteExecute=3Dyes\n"
> > +	       "NoNewPrivileges=3Dyes\n"
> > +	       "RestrictAddressFamilies=3DAF_UNIX AF_INET AF_INET6\n"
> > +	       "RestrictNamespaces=3Dyes\n"
> > +	       "RestrictRealtime=3Dyes\n"
> > +	       "RestrictSUIDSGID=3Dyes\n"
>=20
> After a quick read of the systemd.exec man page it is unclear to me if
> these Restrict... lines are needed as we already have
> NoNewPrivileges=3Dyes - maybe they have some effect if `git maintence` is
> run as root?

I think that the only thing that `NoNewPrivileges=3Dyes` do is to set the n=
o new=20
privileges flag described in [1] on the process.

The `Restrict=E2=80=A6` options are enabling some other sandboxing features=
 by=20
blocking some syscalls through a seccomp profile.

My understanding of the systemd.exec man page is the other way round, i.e.:=
 as=20
soon as there=E2=80=99s a `Restrict=E2=80=A6` option, the `NoNewPrivileges=
=3Dyes` is implied.

So, I would say that strictly speaking `NoNewPrivileges=3Dyes` isn=E2=80=99=
t needed.
But `NoNewPrivileges=3Dyes` doesn=E2=80=99t imply the `Restrict=E2=80=A6` o=
ptions.

But I thought that, from a security point of view, it=E2=80=99s better to s=
et as many=20
sandboxing options as possible and be as explicit as possible.

[1] https://www.kernel.org/doc/html/latest/userspace-api/no_new_privs.html



