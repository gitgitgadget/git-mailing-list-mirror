Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 792C31FC43
	for <e@80x24.org>; Mon, 13 Mar 2017 12:30:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751759AbdCMM35 (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Mar 2017 08:29:57 -0400
Received: from kolab.intevation.de ([212.95.107.133]:40480 "EHLO
        kolab.intevation.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751095AbdCMM3z (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Mar 2017 08:29:55 -0400
Received: from localhost (localhost [127.0.0.1])
        by kolab.intevation.de (Postfix) with ESMTP id 2D337626F5
        for <git@vger.kernel.org>; Mon, 13 Mar 2017 13:29:53 +0100 (CET)
X-Virus-Scanned: by amavisd-new at intevation.de
Received: from kolab.intevation.de ([127.0.0.1])
        by localhost (kolab.intevation.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id L83DbaT1RHzf for <git@vger.kernel.org>;
        Mon, 13 Mar 2017 13:29:52 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by kolab.intevation.de (Postfix) with ESMTP id E935962759
        for <git@vger.kernel.org>; Mon, 13 Mar 2017 13:29:50 +0100 (CET)
Received: from ploto.hq.intevation.de (ploto.hq.intevation.de [192.168.11.18])
        (Authenticated sender: bernhard.reiter@intevation.de)
        by kolab.intevation.de (Postfix) with ESMTPSA id B8FBF625D2;
        Mon, 13 Mar 2017 13:29:50 +0100 (CET)
From:   "Bernhard E. Reiter" <bernhard.reiter@intevation.de>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: Stable GnuPG interface, git should use GPGME
Date:   Mon, 13 Mar 2017 13:29:40 +0100
User-Agent: KMail/1.9.10 (enterprise35 20150610.75555ff)
Cc:     git@vger.kernel.org, gnupg-devel@gnupg.org
References: <201703101100.15214.bernhard.reiter@intevation.de> <20170311001031.f5534omsrzkrzfzb@genre.crustytoothpaste.net>
In-Reply-To: <20170311001031.f5534omsrzkrzfzb@genre.crustytoothpaste.net>
X-KMail-QuotePrefix: > 
MIME-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart2620745.3g5TkDR0uG";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Message-Id: <201703131329.50322.bernhard.reiter@intevation.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

--nextPart2620745.3g5TkDR0uG
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Am Samstag 11 M=C3=A4rz 2017 01:10:31 schrieb brian m. carlson:
> On Fri, Mar 10, 2017 at 11:00:07AM +0100, Bernhard E. Reiter wrote:
> >  but even better would be to move to libgpgme. >:)
>
> There are a couple potential problems I see with this approach.  First,
> I'd want to know whether gpgme supports gpgsm, which I know some people
> use to sign commits and tags.

Yes, gpgme supports gpgsm.
https://www.gnupg.org/documentation/manuals/gpgme/Cryptographic-Message-Syn=
tax.html
"CMS is implemented by GpgSM, the S/MIME implementation for GnuPG."

> Another issue is what happens to the git verify-* --raw output.  Some
> people want the ability to script signature verification.  This can be
> really important when you have automated systems verifying tags and
> commits.
>
> For example, running the following commands, we can determine that Junio
> signs his tags with SHA-1 (algorithm 2), while I sign my commits with
> SHA-512 (algorithm 10).
>
> genre ok % git verify-tag --raw v2.12.0 2>&1 | grep VALIDSIG
> [GNUPG:] VALIDSIG E1F036B1FEE7221FC778ECEFB0B5E88696AFE6CB 2017-02-24
> 1487962205 0 4 0 1 2 00 96E07AF25771955980DAD10020D04E5A713660A7 genre ok=
 %
> git verify-commit --raw object-id-part10 2>&1 | grep VALIDSIG [GNUPG:]
> VALIDSIG 5FC3A781776B26DF87F70C37BF535D811F52F68B 2017-03-06 1488760639 0=
 4
> 0 1 10 00 88ACE9B29196305BA9947552F1BA225C0223B187
>
> There's literally no other way to get this information at the moment
> (which is why I added the --raw option).  A gpgme implementation would
> need to expose this same information, at which point, we might as well
> have used gpg directly.

I'm quite optimistic that the use case can be covered implementing the=20
git --raw option using gpgme, but I don't know the best way right away.
(I also wonder what would happen if someone manages to put in two or more=20
signatures in the object you are verifying.)

> Because the amount of the gpg API we actually use is very small, a user
> who wants to use a custom signature program (say, OpenBSD's signify),
> can actually write a simple wrapper that mimics it and use that instead.

I agree that this can be a use case against using libgpgme.

> Finally, I work on a development system where work is done both as an
> unprivileged user and as root.  Because I use the same socket for both,
> GnuPG screams bloody murder that the permissions are wrong.  I know this
> is secure in my scenario, but without a custom wrapper, I have to deal
> with GnuPG polluting my terminal every time I sign a commit or a tag.  A
> gpgme implementation would need to honor the same wrapper script or
> otherwise not scream to the terminal.

I don't understand  the scenario well enought to advise. Using the same soc=
ket=20
sounds strange at the onset. In general libgpgme allows someone to use othe=
r=20
binaries (see my answer to Linus) and offers quite a number of possibilitie=
s.=20
However there may be special cases that are not covered as good as using=20
everything raw and manually. Libgpgme has to be this way and offering some=
=20
standard default otherwise it would use some of its merits. On the other ha=
nd
the code doing special things or calling gpg directly can have defects as w=
ell
which is a significant drawback.

Regards,
Bernhard
=2D-=20
www.intevation.de/~bernhard (CEO)     +49 541 33 508 3-3
Intevation GmbH, Osnabr=C3=BCck, Germany; Amtsgericht Osnabr=C3=BCck, HRB 1=
8998
Owned and run by Frank Koormann, Bernhard Reiter, Dr. Jan-Oliver Wagner

--nextPart2620745.3g5TkDR0uG
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAABCAAGBQJYxpC0AAoJEDxD9Mjv9dQqjpwH/0m1Pamb3MZ0GqdfQ2oCZzLP
Gxf4m8Xnb9ft10fuo+kGlyiEeBcedqqqcHe11R7gsM9KJKZBNaF4uRPJvaLbrCeI
JjQr337SmnspdgpXQ6bCDgL73la5jA2drXSbi77eh569DVnufTmwKAiGOGaQp+Bk
a9S/Av61tlxhv+fMYAQC9gJ/R+itq9oqVYdWmi2Cl5+RAS9Y8mKUZDuoJJ6cf7LU
2Hs/PrGWZX6GZCrORi44YdwLbnN/pctZscHmUex2urWa63og65v73BDde3rPCnpM
hhxs8+cuRGnLvyeSTTWPdXYbT7wYiybuacG1jC+fUDAo+E2u3o4S78j3USgwLTY=
=eWVL
-----END PGP SIGNATURE-----

--nextPart2620745.3g5TkDR0uG--
