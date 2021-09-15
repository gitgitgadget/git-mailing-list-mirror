Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B87FCC433EF
	for <git@archiver.kernel.org>; Wed, 15 Sep 2021 12:52:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F73D60555
	for <git@archiver.kernel.org>; Wed, 15 Sep 2021 12:52:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233768AbhIOMxd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Sep 2021 08:53:33 -0400
Received: from mx1.emlix.com ([136.243.223.33]:60116 "EHLO mx1.emlix.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233897AbhIOMxd (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Sep 2021 08:53:33 -0400
X-Greylist: delayed 538 seconds by postgrey-1.27 at vger.kernel.org; Wed, 15 Sep 2021 08:53:32 EDT
Received: from mailer.emlix.com (unknown [81.20.119.6])
        (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.emlix.com (Postfix) with ESMTPS id 1A688601FF
        for <git@vger.kernel.org>; Wed, 15 Sep 2021 14:43:15 +0200 (CEST)
From:   Rolf Eike Beer <eb@emlix.com>
To:     git@vger.kernel.org
Subject: data loss when doing ls-remote and piped to command
Date:   Wed, 15 Sep 2021 14:43:10 +0200
Message-ID: <6786526.72e2EbofS7@devpool47>
Organization: emlix GmbH
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1814964.PYBbvgHSvh"; micalg="pgp-sha256"; protocol="application/pgp-signature"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--nextPart1814964.PYBbvgHSvh
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"; protected-headers="v1"
From: Rolf Eike Beer <eb@emlix.com>
To: git@vger.kernel.org
Subject: data loss when doing ls-remote and piped to command
Date: Wed, 15 Sep 2021 14:43:10 +0200
Message-ID: <6786526.72e2EbofS7@devpool47>
Organization: emlix GmbH

The given repository is a clone of the vanilla kernel.

/usr/bin/git --git-dir=3D/home/ebeer/repos/upstream/linux/.git ls-remote or=
igin 2>&1 | less

And I then see things like this:

6f38b5d6cfd43dde3058a10c68baae9cf17af912        refs/tags/v5.0-rc2
1c7fc5cbc33980acd13ae83d0b416db002fe95601e7f97f64b59514d936     refs/tags/v=
5.7-rc2^{}
d0709bb6da2ab6d49b11643e98abdf79b1a2817f        refs/tags/v5.7-rc3

This also happens when I cd into the repository and just run "git ls-remote=
"=20
on some of my repositories, but much less often.

The remainder of the overly long line is the correct id for that tag. The=20
error does not happen on every run, and on some of my repositories it also=
=20
differs from run to run on which tag that happens. Here it seems that it is=
=20
quite stable to happening on this tag. However, a different user on the sam=
e=20
machine running the very same command had it happen on v5.7-rc3.

I have the same on my laptop, both run on Opensuse Tumbleweed, updated at t=
he=20
same time this morning. This seems to be quite fragile regarding latency or=
=20
such: I can reproduce it with our internal git server, but not with=20
kernel.org. This is not bound to less, we originally observed the error on =
a=20
entirely different tool that tried to parse the output of ls-remote.

Given that there are quite a lot of tags missing I suspect it may be that t=
he=20
pipe handling is somewhere broken, i.e. too much data is written to a pipe=
=20
that is already full. I have not been able to provoke that using pv by rate=
=20
limiting the output so far.

[System Info]
git Version:
git version 2.33.0
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Linux 5.14.1-1-default #1 SMP Sat Sep 4 08:22:51 UTC 2021 (67af907) =
x86_64
Compiler Info: gnuc: 11.2
libc Info: glibc: 2.33
$SHELL (typically, interactive shell): /bin/bash

[no hooks]

=2D-=20
Rolf Eike Beer, emlix GmbH, http://www.emlix.com
=46on +49 551 30664-0, Fax +49 551 30664-11
Gothaer Platz 3, 37083 G=C3=B6ttingen, Germany
Sitz der Gesellschaft: G=C3=B6ttingen, Amtsgericht G=C3=B6ttingen HR B 3160
Gesch=C3=A4ftsf=C3=BChrung: Heike Jordan, Dr. Uwe Kracke =E2=80=93 Ust-IdNr=
=2E: DE 205 198 055

emlix - smart embedded open source

--nextPart1814964.PYBbvgHSvh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----

iLMEAAEIAB0WIQQ/Uctzh31xzAxFCLur5FH7Xu2t/AUCYUHqXgAKCRCr5FH7Xu2t
/L0WA/484m3FGfNkXZaPHHS5dgFoaXbyYm8Y0he/7eZDYbi6hbE4VL4El/GsPP26
rJt86d/Cm4TuKItTlSECBdJ9MOI0mz+9UemEwkgpnbhiEAhFI9D+0PjTtJ9/WyxB
UfGaIG0A6zsnbRleC9HQyGMEbqNpmklmQ3hqsftuF2gp3l6ntA==
=yZLs
-----END PGP SIGNATURE-----

--nextPart1814964.PYBbvgHSvh--



