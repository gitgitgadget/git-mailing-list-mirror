Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18999C433B4
	for <git@archiver.kernel.org>; Sun,  9 May 2021 22:34:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCE8161006
	for <git@archiver.kernel.org>; Sun,  9 May 2021 22:34:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbhEIWfq (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 9 May 2021 18:35:46 -0400
Received: from 82-64-198-250.subs.proxad.net ([82.64.198.250]:48644 "EHLO
        mail.lhuard.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229815AbhEIWfq (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 9 May 2021 18:35:46 -0400
Received: from coruscant.lhuard.fr (unknown [IPv6:2a0d:e487:11f:fd59:c265:f799:b7d8:2f59])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.lhuard.fr (Postfix) with ESMTPSA id 394A945FF53;
        Mon, 10 May 2021 00:34:40 +0200 (CEST)
Authentication-Results: mail.lhuard.fr; dmarc=fail (p=quarantine dis=none) header.from=lhuard.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lhuard.fr; s=rpi3;
        t=1620599680; bh=+xhx+BuzT7otjACvG+EnaVaiM73Vw9p2Pf/LSTFSsmI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=YZkQ6+9zQ5qZzVvqnobCUhP8ZtROydhvnpDvGjntLSDKqV0nn/ys9Dap5s2xQkYQC
         TNu6CTKMYedtHaGXQ7oVelAZgwNRC1/3TjL4xTohLXz1Bic6DEHCwBCjZ8WCYyYd3Y
         w0i+3J5vwI2q6moyczeF1gcERVzh5n6feakOznNM=
From:   =?ISO-8859-1?Q?L=E9na=EFc?= Huard <lenaic@lhuard.fr>
To:     Eric Sunshine <sunshine@sunshineco.com>,
        =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] maintenance: use systemd timers on Linux
Date:   Mon, 10 May 2021 00:34:24 +0200
Message-ID: <2224656.qFoTrlakfJ@coruscant.lhuard.fr>
In-Reply-To: <871ralwfo8.fsf@evledraar.gmail.com>
References: <20210501145220.2082670-1-lenaic@lhuard.fr> <CAPig+cQks0_nL1J4YUbEUjmWYLKrhuHX-f8PkWM2zFE4gybWMw@mail.gmail.com> <871ralwfo8.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Le mercredi 5 mai 2021, 14:01:25 CEST =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmaso=
n a =C3=A9crit :
> On Sun, May 02 2021, Eric Sunshine wrote:
> > On Sat, May 1, 2021 at 10:59 AM L=C3=A9na=C3=AFc Huard <lenaic@lhuard.f=
r> wrote:
> >> +       strvec_push(&child.args, "--now");
> >> +       strvec_pushf(&child.args, "git-maintenance@%s.timer", frequenc=
y);
> >> +
> >> +       if (start_command(&child))
> >> +               die(_("failed to run systemctl"));
> >> +       return finish_command(&child);
> >> +}
> >> +static int systemd_timer_write_unit_templates(const char *exec_path)
> >> +{
> >> +       unit =3D "[Unit]\n"
> >> +              "Description=3DOptimize Git repositories data\n"
> >> +              "\n"
> >> +              "[Service]\n"
> >> +              "Type=3Doneshot\n"
> >> +              "ExecStart=3D\"%1$s/git\" --exec-path=3D\"%1$s\" for-ea=
ch-repo
> >> --config=3Dmaintenance.repo maintenance run --schedule=3D%%i\n">=20
> > I see that it's in POSIX, but do we use this `%n$s` directive
> > elsewhere in the Git source code? If not, I'd be cautious of
> > introducing it here. Maybe it's better to just use plain `%s` twice...
>=20
> We use it in po/, so for sprintf() on systems that don't have
> NO_GETTEXT=3DY we already test it in the wild.
>=20
> But no, I don't think anything in the main source uses it, FWIW I have a
> WIP series in my own fork that I've cooked for a while that uses this, I
> haven't run into any issues with it in either GitHub's CI
> (e.g. Windows), or on the systems I myself test on.
>=20
> I think it would be a useful canary to just take a change like this, we
> can always change it to the form you suggest if it doesn't work out.

Based on this latest comment, I left the `%n$s` directive in the v2 of the=
=20
patch.

Let me know if that=E2=80=99s still OK. Otherwise, I=E2=80=99d be happy to =
implement Eric=E2=80=99s=20
suggestion.

Note however that this would be a =E2=80=9Cpoor=E2=80=9D canary to check if=
 that directive is=20
supported on all the platforms on which git has been ported.
Indeed, this code is executed only on systemd platforms, which means quite=
=20
recent Linux systems.
Should this directive not be supported, I suppose it would be on more exoti=
c=20
systems.


