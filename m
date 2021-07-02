Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D02BC11F68
	for <git@archiver.kernel.org>; Fri,  2 Jul 2021 15:04:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7075461405
	for <git@archiver.kernel.org>; Fri,  2 Jul 2021 15:04:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231753AbhGBPHA (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Jul 2021 11:07:00 -0400
Received: from 82-64-198-250.subs.proxad.net ([82.64.198.250]:34198 "EHLO
        mail.lhuard.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231549AbhGBPG7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jul 2021 11:06:59 -0400
Received: from coruscant.lhuard.fr (unknown [IPv6:2a01:e0a:465:5440:796c:f829:f2b6:ea8e])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.lhuard.fr (Postfix) with ESMTPSA id 01ED94A597D;
        Fri,  2 Jul 2021 17:04:21 +0200 (CEST)
Authentication-Results: mail.lhuard.fr; dmarc=fail (p=quarantine dis=none) header.from=lhuard.fr
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lhuard.fr; s=rpi3;
        t=1625238262; bh=335ctzJb5N8l3+ls83WbbZr+Ff+NjF2z4P+LIuibW80=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=gqceaP/JNlZuvppIlnFE070o5JQdt9CRHCMDIqfD1pPoAxtIW+G3YwDio6m5T4hyX
         q8yEGtoPx3cdlv/p04gQrU3qDfNIQqN+RHtYLOgqxRWrtdILySQCNbpzZXRiM3LfTV
         qBdMILkH0bkRrc2Byy21KmjogIghZmOiLX4pbErk=
From:   =?ISO-8859-1?Q?L=E9na=EFc?= Huard <lenaic@lhuard.fr>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Martin =?ISO-8859-1?Q?=C5gren?= <martin.agren@gmail.com>,
        =?ISO-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH v6 2/3] maintenance: `git maintenance run` learned `--scheduler=<scheduler>`
Date:   Fri, 02 Jul 2021 17:04:10 +0200
Message-ID: <2080051.vtJqlmqO2r@coruscant.lhuard.fr>
In-Reply-To: <CAPig+cSLi7aN=6ahrHwy4fO-7JMBN3pmzfpWe5ZXOcC9j4+e+g@mail.gmail.com>
References: <20210608134000.663398-1-lenaic@lhuard.fr> <20210612165043.165579-3-lenaic@lhuard.fr> <CAPig+cSLi7aN=6ahrHwy4fO-7JMBN3pmzfpWe5ZXOcC9j4+e+g@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Le lundi 14 juin 2021, 06:36:09 CEST Eric Sunshine a =C3=A9crit :

> Thanks. Unfortunately, I haven't been following this series too
> closely since I reviewed v1, so I set aside time to review v6, which I
> have now done.
> =E2=80=A6
> I do, though, have one question (below) about is_crontab_available()
> for which I could not figure out the answer.

Thank you very much for your review.
I=E2=80=99ve just submitted a new re-roll that should address the points yo=
u raised=20
and in particular the `is_crontab_available` unexpected behavior.

=E2=80=A6
> > +static int is_launchctl_available(void)
> > +{
> > +       const char *cmd =3D "launchctl";
> > +       int is_available;
> > +       if (get_schedule_cmd(&cmd, &is_available))
> > +               return is_available;
> > +
> > +#ifdef __APPLE__
> > +       return 1;
> > +#else
> > +       return 0;
> > +#endif
> > +}
>=20
> On this project, we usually frown upon #if conditionals within
> functions since the code often can become unreadable. The usage in
> this function doesn't suffer from that problem, however,
> resolve_auto_scheduler() is somewhat ugly. An alternative would be to
> set up these values outside of all functions, perhaps like this:
>=20
>     #ifdef __APPLE__
>     #define MAINT_SCHEDULER SCHEDULER_LAUNCHCTL
>     #elif GIT_WINDOWS_NATIVE
>     #define MAINT_SCHEDULER SCHEDULER_SCHTASKS
>     #else
>     #define MAINT_SCHEDULER SCHEDULER_CRON
>     #endif
>=20
> and then:
>=20
>     static int is_launchctl_available(void)
>     {
>         if (get_schedule_cmd(...))
>             return is_available;
>         return MAINT_SCHEDULER =3D=3D SCHEDULER_LAUNCHCTL;
>     }
>=20
>     static void resolve_auto_scheduler(enum scheduler *scheduler)
>     {
>         if (*scheduler =3D=3D SCHEDULER_AUTO)
>             *scheduler =3D MAINT_SCHEDULER;
>     }
>=20

This approach would unfortunately work only for the second patch of this=20
series where a single scheduler is available on each platform.
With the third patch of this series, `resolve_auto_scheduler` doesn=E2=80=
=99t return a=20
value that is fully determined at compilation time anymore.
On Linux, both `crontab` and `systemd-timers` are susceptible to be availab=
le=20
and this is checked at runtime.
So, with the third patch of this series, it wouldn=E2=80=99t be possible an=
ymore to=20
define a single value for `MAINT_SCHEDULER` and to base=20
`resolve_auto_scheduler` on it.

=E2=80=A6
> > +                       PARSE_OPT_NONEG, maintenance_opt_scheduler),
> > +               OPT_END()
> > +       };
> > diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
> > @@ -494,8 +494,21 @@ test_expect_success !MINGW 'register and unregister
> > with regex metacharacters' ' +test_expect_success 'start
> > --scheduler=3D<scheduler>' '
> > +       test_expect_code 129 git maintenance start --scheduler=3Dfoo 2>=
err
> > &&
> > +       test_i18ngrep "unrecognized --scheduler argument" err &&
> > +
> > +       test_expect_code 129 git maintenance start --no-scheduler 2>err=
 &&
> > +       test_i18ngrep "unknown option" err &&
> > +
> > +       test_expect_code 128 \
> > +               env
> > GIT_TEST_MAINT_SCHEDULER=3D"launchctl:true,schtasks:true" \ +          =
   =20
> > git maintenance start --scheduler=3Dcrontab 2>err && +       test_i18ng=
rep
> > "fatal: crontab scheduler is not available" err +'
>=20
> Why does this test care about the exact exit codes rather than simply
> using test_must_fail() as is typically done elsewhere in the test
> suite, especially since we're also checking the error message itself?
> Am I missing some non-obvious property of the error codes?

I have no strong opinion on this.
I only mimicked the `help text` test that is at the top of the `t7900-
maintenance.sh` file as it was also testing invalid commands and checking t=
he=20
resulting error message.

> I don't see `auto` being tested anywhere. Do we want such a test? (It
> seems like it should be doable, though perhaps the complexity is too
> high -- I haven't thought it through fully.)

My main problem with the `auto` is that a big part of its logic is determin=
ed=20
at compilation time with `#if` statements based on the platform.
And it seems that the tests are designed so far to test the same things on =
all=20
platforms.
A solution could be to completely get rid of the platform `#if` statements =
and=20
to turn all the detection logic as runtime tests.
But it would mean that, for ex., the git binary for Linux would systematica=
lly=20
check if the MacOS and Windows specific schedulers are available.

Cheers,
L=C3=A9na=C3=AFc.


