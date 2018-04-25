Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CD4551F404
	for <e@80x24.org>; Wed, 25 Apr 2018 07:13:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751300AbeDYHNl (ORCPT <rfc822;e@80x24.org>);
        Wed, 25 Apr 2018 03:13:41 -0400
Received: from smtp.gentoo.org ([140.211.166.183]:48026 "EHLO smtp.gentoo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751332AbeDYHNk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Apr 2018 03:13:40 -0400
Received: from grubbs.orbis-terrarum.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by smtp.gentoo.org (Postfix) with ESMTPS id 31260335C0A
        for <git@vger.kernel.org>; Wed, 25 Apr 2018 07:13:40 +0000 (UTC)
Received: (qmail 8143 invoked by uid 10000); 25 Apr 2018 07:13:38 -0000
Date:   Wed, 25 Apr 2018 07:13:38 +0000
From:   "Robin H. Johnson" <robbat2@gentoo.org>
To:     Junio C Hamano <gitster@pobox.com>,
        Git Mailing List <git@vger.kernel.org>
Cc:     "Robin H. Johnson" <robbat2@gentoo.org>,
        =?utf-8?B?TWljaGHFgiBHw7Nybnk=?= <mgorny@gentoo.org>,
        Jeff King <peff@peff.net>,
        Lars Schneider <larsxschneider@gmail.com>,
        Marc Branchaud <marcnarc@xiplink.com>
Subject: Re: [RFC PATCH] checkout: Force matching mtime between files
Message-ID: <robbat2-20180425T060717-325652820Z@orbis-terrarum.net>
References: <20180413170129.15310-1-mgorny@gentoo.org>
 <robbat2-20180423T200557-844830385Z@orbis-terrarum.net>
 <xmqqtvs18p9o.fsf@gitster-ct.c.googlers.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="GPT5DIEyVHz5yXBV"
Content-Disposition: inline
In-Reply-To: <xmqqtvs18p9o.fsf@gitster-ct.c.googlers.com>
User-Agent: Mutt/1.8.2 (2017-04-18)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--GPT5DIEyVHz5yXBV
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 24, 2018 at 08:41:07AM +0900, Junio C Hamano wrote:
> "Robin H. Johnson" <robbat2@gentoo.org> writes:
>=20
> > On Fri, Apr 13, 2018 at 07:01:29PM +0200, Micha=C5=82 G=C3=B3rny wrote:
> >> Currently git does not control mtimes of files being checked out.  This
> >> means that the only assumption you could make is that all files created
> >> or modified within a single checkout action will have mtime between
> >> start time and end time of this checkout.  The relations between mtimes
> >> of different files depend on the order in which they are checked out,
> >> filesystem speed and timestamp precision.
> >> ...
> > Junio: ping for review or inclusion of this patch?
>=20
> I personally did not think this is a good idea and not worth any
> code contamination with calls to utime().  Is there anybody sane who
> thought this was a good idea in the discussion thread?
Nobody responded to the original message until after I pinged about it
again.

Since that, one person DID respond, stating that it fixed an issue they
had previously reported 6 years ago.

In the thread from 6 years ago, you asked about tar's behavior for
mtimes. 'tar xf' restores mtimes from the tar archive, so relative
ordering after restore would be the same, and would only rebuild if the
original source happened to be dirty.

This behavior is already non-deterministic in Git, and would be improved
by the patch.

On a machine with high resolution timestamps or large enough repo that
checkout takes a long time, an initial checkout of multiple files does
not guarantee the ordering of mtimes of those files. Checking out (A,B)
could wind up with them having a different relative mtimes.

For this example, we are doing a checkout of two files A,B being written
(either due to initial checkout, or both have changed for some reason).

The example system has this as a property:
- "touch A B" =3D> mtime(A) < mtime(B)
- "touch B A" =3D> mtime(A) > mtime(B)
[touch should not re-order arguments, nor apply the same mtime to all
files. Linux touch at this point makes the syscall of 'utimensat(0,
NULL, NULL, 0)' on each file descriptor]

Existing behavior:
mtime(A), mtime(B) are independent of each other, and depend on the
exact order of file checkout, along with the resolution of timestamps
and how much other work is taking place. If the filesystem has low
resolution of timestamps, or the checkout is sufficiently small/fast,
the mtimes are likely to be identical already.

New behavior:
Strictly mtime(A) =3D=3D mtime(B)

Example makefile rule:
B: A

Human explanation of makefile rule:
file B depends on file A

If the build system triggers on:

* mtime(A) > mtime(B): [strictly greater]
** Old Behavior: It will depend on the exact checkout order. Sometimes
   it will already not rebuild.
** New Behavior: always rebuild, as mtime(A) =3D=3D mtime(B)

* mtime(A) >=3D mtime(B): [greater or equal]
** Old Behavior: it will depend on the exact checkout order. Sometimes it
   will, sometimes it won't.
** New Behavior: will not rebuild, as mtime(A) =3D=3D mtime(B)

--=20
Robin Hugh Johnson
Gentoo Linux: Dev, Infra Lead, Foundation Treasurer
E-Mail   : robbat2@gentoo.org
GnuPG FP : 11ACBA4F 4778E3F6 E4EDF38E B27B944E 34884E85
GnuPG FP : 7D0B3CEB E9B85B1F 825BCECF EE05E6F6 A48F6136

--GPT5DIEyVHz5yXBV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Robbat2 @ Orbis-Terrarum Networks - The text below is a digital signature. If it doesn't make any sense to you, ignore it.

iQKTBAEBCgB9FiEEveu2pS8Vb98xaNkRGTlfI8WIJsQFAlrgKqFfFIAAAAAALgAo
aXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5maWZ0aGhvcnNlbWFuLm5ldEJE
RUJCNkE1MkYxNTZGREYzMTY4RDkxMTE5Mzk1RjIzQzU4ODI2QzQACgkQGTlfI8WI
JsRPGw//SIqTzPCqP2tBhqomz4HnnNKA0km7Jcmsm72zsRMpfmtxwi8my6r0CuVo
y9wUgmMFqniFpFWCB59tOJnRy1BpvWj+JND+9iQELSmCm3iZ0tS79mQEP++QOX5+
dYfo3x4Bb8xoo0vIc8vzAGinzrY3Couc2NvqcLIoAC4U19ENVBqmhgQGGWn3jLOu
9VFDcn8Qqiyf8eetgPZzEEBvdKmwjiWwoypvo/A4pSgvL6zTbyYeUKMdwHMXKEab
21Kb9OwSVFTbrTVy+LkeKwDpk1wHjUpEnh8ggtoRrOu+Oca/5xbus6A9wIeByaeS
E+RdbdX/ikPYeVv8EwEpcRvUxheIN3PRiHJ1i5X67GHDRS1OQnXkoIyt1pOJnznG
oVU5wZ4Z7+D8XnI9mt8r8O6ac5EFJqCghyNbQE1ZHNE+Cw4YqAAfkFldi9mNN1bx
gu6Vg7IC/4j5Ey70xCKmD+bncMXN2QlArLYpw6sysSezDPmaZWfrg5frtRgQlRpQ
gMFJKyjXX85pfXYIjfKsJPoFDd0ruUKWWTECh1AkA3ZZm1TSL+Q4uiBYaz2ZdDM8
leZx1KBHqmiHmB3leU13sIcSKMq8D4GGTp3KTgzc68V2a1Uv9N97COZe6NpOV3xA
4NID6Qgs1PpkdBicbX/gEPOMDGYnWqabCgc5Ku0wI+Cw8ZuwJEc=
=TZDW
-----END PGP SIGNATURE-----

--GPT5DIEyVHz5yXBV--
