Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A85C9C25B0E
	for <git@archiver.kernel.org>; Sat, 13 Aug 2022 03:46:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234725AbiHMDqJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Aug 2022 23:46:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbiHMDqG (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Aug 2022 23:46:06 -0400
X-Greylist: delayed 192 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 12 Aug 2022 20:46:03 PDT
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7D011EC77
        for <git@vger.kernel.org>; Fri, 12 Aug 2022 20:46:03 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 99D0B1BAF1C;
        Fri, 12 Aug 2022 23:42:50 -0400 (EDT)
        (envelope-from tmz@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=date:from
        :to:cc:subject:message-id:references:mime-version:content-type
        :in-reply-to:content-transfer-encoding; s=sasl; bh=OsoXXn1DCtbeD
        RI8FX2UOunp7/NFSQ5UaISSOV4Gogk=; b=D5cynL0zQ5Wz1unxXqzvYOSQHHfGt
        LsqDBWgoCwkiSjeIAg/W7HeDYxR00FzIVYAP+jj8jmzR51phLX8QbrTisicWdN+4
        F8lcE1gldRv54TGDXoEkOr7sJ1S/R28oa3M8pwLOUEOIKQKpPBY7Ou7Bqrs99s2x
        8Vdu7IsoNs5RJU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 930DB1BAF1B;
        Fri, 12 Aug 2022 23:42:50 -0400 (EDT)
        (envelope-from tmz@pobox.com)
Received: from pobox.com (unknown [71.254.192.78])
        (using TLSv1.2 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 055551BAF1A;
        Fri, 12 Aug 2022 23:42:45 -0400 (EDT)
        (envelope-from tmz@pobox.com)
Date:   Fri, 12 Aug 2022 23:42:42 -0400
From:   Todd Zullinger <tmz@pobox.com>
To:     =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Cc:     Renato Botelho <garga@freebsd.org>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: git maintenance broken on FreeBSD
Message-ID: <YvcdskzUkocUv/d7@pobox.com>
References: <226317ba-a78f-216c-764c-52f4e393bd35@FreeBSD.org>
 <YvZnQFVMZZmz9TIX@danh.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YvZnQFVMZZmz9TIX@danh.dev>
X-Pobox-Relay-ID: FEB0BD5C-1AB9-11ED-8446-C85A9F429DF0-09356542!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4ng Danh wrote:
> On 2022-08-12 10:51:03-0300, Renato Botelho <garga@FreeBSD.org> wrote:
>> As reported at [1], git maintenance is not working on FreeBSD.  I didn=
't
>> find the time to dig into it but it seems like it's calling crontab us=
ing
>> parameters not supported on FreeBSD.
>>=20
>> [1] https://bugs.freebsd.org/bugzilla/show_bug.cgi?id=3D260746
>=20
> It seems like FreeBSD's cron is vixie-cron which requires <file>
> passed to crontab(1).
>=20
>      The crontab command conforms to IEEE Std 1003.2 (=E2=80=9CPOSIX.2=E2=
=80=9D) with the
>      exception that the dangerous variant of calling crontab without a =
file
>      name in the first form of the command is not allowed by this
>      implementation.  The pseudo-filename =E2=80=98-=E2=80=99 must be s=
pecified to read from
>      standard input.  The new command syntax differs from previous vers=
ions of
>      Vixie Cron, as well as from the classic SVR3 syntax.
>=20
> I think other crontab implementation also accept "-" as filename for st=
din.
> At least cronie, fcron, dcron, and busybox's crontab both supports "-" =
as stdin.

A similar issue was noted in Fedora with cronie shortly
after the git maintenance command was released:

    https://bugzilla.redhat.com/show_bug.cgi?id=3D1939930#c1

I noted that a patch just like the one below would suffice,
but I was concerned that it wouldn't be welcome here because
the behavior of crontab was specified by POSIX (even though
it's very unfriendly and, apparently, supported by fewer and
fewer implementations).

If a change like this is made, aren't we trading one group
of broken users for another?  It would fix users of newer
systems at the expense of those on older systems, I would
suspect.

> I think this patch can fix FreeBSD's problem:
>=20
> ---- 8< -----
> diff --git a/builtin/gc.c b/builtin/gc.c
> index eeff2b760e..45d908def3 100644
> --- a/builtin/gc.c
> +++ b/builtin/gc.c
> @@ -2087,6 +2087,7 @@ static int crontab_update_schedule(int run_mainte=
nance, int fd)
>  	rewind(cron_list);
> =20
>  	strvec_split(&crontab_edit.args, cmd);
> +	strvec_push(&crontab_edit.args, "-");
>  	crontab_edit.in =3D -1;
>  	crontab_edit.git_cmd =3D 0;
> =20
> ---- 8< ---------

In the end, cronie adjusted it's behavior, which was similar
to that of the newer vixie-cron, in 8b0241f (Partially
revert the behavior of crontab command without arguments,
2021-03-17)=C2=B9.  It now behaves as required by POSIX if stdin
is not a TTY.  That seems like a reasonable compromise and
perhaps vixie-cron would be willing to do the same?

=C2=B9 https://github.com/cronie-crond/cronie/commit/8b0241f

--=20
Todd
