Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3593AC433EF
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 06:38:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1406A6112E
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 06:38:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234605AbhIPGjm (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Sep 2021 02:39:42 -0400
Received: from mx1.emlix.com ([136.243.223.33]:34748 "EHLO mx1.emlix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234604AbhIPGjl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Sep 2021 02:39:41 -0400
Received: from mailer.emlix.com (p5098be52.dip0.t-ipconnect.de [80.152.190.82])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.emlix.com (Postfix) with ESMTPS id 325165FFC4;
        Thu, 16 Sep 2021 08:38:18 +0200 (CEST)
From:   Rolf Eike Beer <eb@emlix.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Subject: Re: data loss when doing ls-remote and piped to command
Date:   Thu, 16 Sep 2021 08:38:13 +0200
Message-ID: <2279155.Qy0YqsFniq@devpool47>
Organization: emlix GmbH
In-Reply-To: <xmqqwnnhwvnd.fsf@gitster.g>
References: <6786526.72e2EbofS7@devpool47> <xmqqwnnhwvnd.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart2488331.bbNpWWP0az"; micalg="pgp-sha256"; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--nextPart2488331.bbNpWWP0az
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"; protected-headers="v1"
From: Rolf Eike Beer <eb@emlix.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>
Subject: Re: data loss when doing ls-remote and piped to command
Date: Thu, 16 Sep 2021 08:38:13 +0200
Message-ID: <2279155.Qy0YqsFniq@devpool47>
Organization: emlix GmbH
In-Reply-To: <xmqqwnnhwvnd.fsf@gitster.g>
References: <6786526.72e2EbofS7@devpool47> <xmqqwnnhwvnd.fsf@gitster.g>

Am Mittwoch, 15. September 2021, 20:17:42 CEST schrieb Junio C Hamano:
> Rolf Eike Beer <eb@emlix.com> writes:
> > The given repository is a clone of the vanilla kernel.
> >=20
> > /usr/bin/git --git-dir=3D/home/ebeer/repos/upstream/linux/.git ls-remote
> > origin 2>&1 | less
> >=20
> > And I then see things like this:
> >=20
> > 6f38b5d6cfd43dde3058a10c68baae9cf17af912        refs/tags/v5.0-rc2
> > 1c7fc5cbc33980acd13ae83d0b416db002fe95601e7f97f64b59514d936   =20
> > refs/tags/v5.7-rc2^{} d0709bb6da2ab6d49b11643e98abdf79b1a2817f      =20
> > refs/tags/v5.7-rc3
> Not offering any solution, just an observation of the problem and
> annotating the report.
>=20
> What we see on the second line is the beginning of peeled
> v5.0-rc2^{} up to the "acd13" (that is, the first 19 bytes of the
> line), followed by the full line for peeled v5.7-rc2^{} (which
> begins with "ae83d").  12407 bytes in between are missing, which
> is even more puzzling as it is not a nice round number.
>=20
> I wonder if this is "less" misconfigured and misbehaving.  Did the
> user after seeing v5.7-* tags scroll back with 'b' or something?

To quote myself:

>> This is not bound to less, we originally observed the error on a=20
>> entirely different tool that tried to parse the output of ls-remote.

In fact when less opened I just started to scroll down until I visually=20
noticed an error.

> If the output (including the 2>&1 redirection) is sent to a file and
> then "cat <that-file" is invoked, does the same thing happen?  How
> about "cat <that-file | less"?

The redirection seems to be an important part of it. I now did:

git ... 2>&1 | sha256sum

This gives different results basically on every run. I also noticed that=20
having more tags makes it easier to reproduce, so a stable kernel in contra=
st=20
to vanilla is a better trigger. Doing that without the stderr redirection g=
ave=20
the same result every time I tried.

Regards,

Eike
=2D-=20
Rolf Eike Beer, emlix GmbH, http://www.emlix.com
=46on +49 551 30664-0, Fax +49 551 30664-11
Gothaer Platz 3, 37083 G=C3=B6ttingen, Germany
Sitz der Gesellschaft: G=C3=B6ttingen, Amtsgericht G=C3=B6ttingen HR B 3160
Gesch=C3=A4ftsf=C3=BChrung: Heike Jordan, Dr. Uwe Kracke =E2=80=93 Ust-IdNr=
=2E: DE 205 198 055

emlix - smart embedded open source

--nextPart2488331.bbNpWWP0az
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iLMEAAEIAB0WIQQ/Uctzh31xzAxFCLur5FH7Xu2t/AUCYULmVQAKCRCr5FH7Xu2t
/MMbA/9hduXmVSjI3Ua8HcZ3fj7zZ47/waD9/7DgJxLiPfjRDpQfnVfL7bwlqhEI
WWZV78knGiEq85JIFVJuiJ3xoV7FMojT9Spxd0APNebEOL1+r9+Jf2F8bUGQwbek
D3DjhMW6uSilefOW+zO1XmnuuO4GgtNGTV1E6SsCciTCjBXJPg==
=Tsv0
-----END PGP SIGNATURE-----

--nextPart2488331.bbNpWWP0az--



