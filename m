Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1530C433F5
	for <git@archiver.kernel.org>; Sat, 29 Jan 2022 10:41:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230312AbiA2KlX (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 29 Jan 2022 05:41:23 -0500
Received: from smtp2-g21.free.fr ([212.27.42.2]:12017 "EHLO smtp2-g21.free.fr"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229484AbiA2KlW (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Jan 2022 05:41:22 -0500
Received: from cayenne.localnet (unknown [IPv6:2a01:e0a:d1:f360:14d0:16b1:1c2b:6dc9])
        (Authenticated sender: jn.avila@free.fr)
        by smtp2-g21.free.fr (Postfix) with ESMTPSA id 167A22003E8;
        Sat, 29 Jan 2022 11:41:16 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
        s=smtp-20201208; t=1643452881;
        bh=MSFM1fzuPnKTvC7qzDCgm44YEGuGYB8PxhRKPLECgW8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ddw5ydUKy/G9ZdhpWIY1U8uRTJEMRLmleRMRudRKzomHy9sX8rWZfycfDZOrhJlEw
         StEMI51uUVees/xXzICKcNKLeL0OxndFIglYT58MD7KpXaYH0D1pcwD54z1MptQ53c
         TpRjG4VjgtH5vBdifm8ZY8gdx8SWhHm8+scDXyUrD2tSIMm2lh9ceUbxQJl7Smqlwy
         LMMFF6Cwck5QlzgAzQgBLKYDjtOUTUcvKyztS+/8QDTjvLfSg8jZhqm16MhL3Nfppz
         VpOXgLrTpl12QedXa6EFjtUUFX1QRCEtQPi/7An0nYwcqWYJrcRF1QRRe7veI8dzEp
         9t5Gd1IGNqYjg==
From:   =?ISO-8859-1?Q?Jean=2DNo=EBl?= AVILA <jn.avila@free.fr>
To:     Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>
Cc:     Phillip Wood <phillip.wood123@gmail.com>, git@vger.kernel.org,
        =?ISO-8859-1?Q?Jean=2DNo=EBl?= Avila via GitGitGadget 
        <gitgitgadget@gmail.com>
Subject: Re: [PATCH v2 1/4] i18n: factorize more 'incompatible options' messages
Date:   Sat, 29 Jan 2022 11:41:16 +0100
Message-ID: <8789935.eFtBeim4Pn@cayenne>
In-Reply-To: <f7468ea3-d9f6-96be-168d-de610d535e72@kdbg.org>
References: <pull.1123.git.1642876553.gitgitgadget@gmail.com> <xmqqee4rtnts.fsf@gitster.g> <f7468ea3-d9f6-96be-168d-de610d535e72@kdbg.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Le samedi 29 janvier 2022, 09:08:34 CET Johannes Sixt a =E9crit :
> Am 29.01.22 um 00:58 schrieb Junio C Hamano:
> > Johannes Sixt <j6t@kdbg.org> writes:
> >> A bit of code duplication could be avoided if die_if_incompatible_opt3=
()
> >> forwarded with an additional pair 0, "" to die_if_incompatible_opt4().
> >=20
> > I wondered if a single varargs function
> >=20
> >     void die_if_incompatible_optN(const char *name1, int opt1, ...);
> >=20
> > that takes a name=3DNULL terminated sequence of <name, opt> would
> > work, but
> >=20
> >  (1) it would require the caller to always spell out the terminating
> >      NULL, which may be ugly.
> >=20
> >  (2) it would tempt people to programatically generate message for N
> >      options, which leads to sentence lego, which is the exact
> >      opposite of what this series wants to achieve.

This is the second part of the functions, and they need a finite number of =
args=20
to check in order to use the correct i18n string. This function cannot be m=
ade=20
generic for any number of options to check.


>=20
> The reason I did not suggest a varargs version is because
>=20
>   (3) it is not typesafe.
>=20
> A varargs implementation could be used as an implementation helper, but
> should not be a public interface.
>=20
> > In any case, I do agree with you that the callers of _opt3()
> > variants can just pass (0, "unused") in the 4-th slot.  If this were
> > made varargs, then it only needs to pass NULL at the end, so that
> > might be an improvement, though.

I still prefer to keep a public function signature which is explicit. Using=
=20
varargs for alternating types is really not type safe.

In such case, declaring the functions with less options as inline calls to =
the=20
one with the greatest number is a good balance.

> >=20
> > Also, isn't "if" in the name of the function misleading?  as far as
> > I can tell, this function is not "check if these options are
> > compatible and die if some are incompatible with each other", but
> > the caller is convinced that these options are incompatible before
> > it decides to call this function and there is no "if" in what this
> > function can do.
>=20
> Good point.
>=20

I don't get the point: the function checks if incompatible options are pres=
ent=20
on the command line and dies in such case. The caller does not know whether=
=20
the function will make the program die, it really depends on the result of =
the=20
check performed in the function. In case there's no or only one of the=20
options, the function does nothing.

JN


