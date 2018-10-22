Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EAE0E1F453
	for <e@80x24.org>; Mon, 22 Oct 2018 15:25:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728276AbeJVXoH (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 Oct 2018 19:44:07 -0400
Received: from smtp.gentoo.org ([140.211.166.183]:49224 "EHLO smtp.gentoo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727669AbeJVXoH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Oct 2018 19:44:07 -0400
Received: from pomiot (d202-252.icpnet.pl [109.173.202.252])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mgorny)
        by smtp.gentoo.org (Postfix) with ESMTPSA id 8C496335C8C;
        Mon, 22 Oct 2018 15:25:06 +0000 (UTC)
Message-ID: <1540221901.1299.4.camel@gentoo.org>
Subject: Re: [PATCH v4] gpg-interface.c: detect and reject multiple
 signatures on commits
From:   =?UTF-8?Q?Micha=C5=82_G=C3=B3rny?= <mgorny@gentoo.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Date:   Mon, 22 Oct 2018 17:25:01 +0200
In-Reply-To: <7C705597-7AA9-4C4E-904B-CE8C4F01AD24@gentoo.org>
References: <20181020193020.28517-1-mgorny@gentoo.org>
         <xmqqin1wyxvz.fsf@gitster-ct.c.googlers.com>
         <7C705597-7AA9-4C4E-904B-CE8C4F01AD24@gentoo.org>
Organization: Gentoo
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-7IqbfH18CBB4pE4uyUH+"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--=-7IqbfH18CBB4pE4uyUH+
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2018-10-22 at 08:04 +0000, Micha=C5=82 G=C3=B3rny wrote:
> Dnia October 20, 2018 11:57:36 PM UTC, Junio C Hamano <gitster@pobox.com>=
 napisa=C5=82(a):
> > Micha=C5=82 G=C3=B3rny <mgorny@gentoo.org> writes:
> >=20
> > > GnuPG supports creating signatures consisting of multiple signature
> > > packets.  If such a signature is verified, it outputs all the status
> > > messages for each signature separately.  However, git currently does
> >=20
> > not
> > > account for such scenario and gets terribly confused over getting
> > > multiple *SIG statuses.
> > >=20
> > > For example, if a malicious party alters a signed commit and appends
> > > a new untrusted signature, git is going to ignore the original bad
> > > signature and report untrusted commit instead.  However, %GK and %GS
> > > format strings may still expand to the data corresponding
> > > to the original signature, potentially tricking the scripts into
> > > trusting the malicious commit.
> > >=20
> > > Given that the use of multiple signatures is quite rare, git does not
> > > support creating them without jumping through a few hoops, and
> >=20
> > finally
> > > supporting them properly would require extensive API improvement, it
> > > seems reasonable to just reject them at the moment.
> > >=20
> > > Signed-off-by: Micha=C5=82 G=C3=B3rny <mgorny@gentoo.org>
> > > ---
> > >  gpg-interface.c          | 90
> >=20
> > +++++++++++++++++++++++++++-------------
> > >  t/t7510-signed-commit.sh | 26 ++++++++++++
> > >  2 files changed, 87 insertions(+), 29 deletions(-)
> > >=20
> > > Changes in v4:
> > > * switched to using skip_prefix(),
> > > * renamed the variable to seen_exclusive_status,
> > > * made the loop terminate early on first duplicate status seen.
> >=20
> > Thanks for sticking to the topic and polishing it further.  Looks
> > very good. =20
> >=20
> > Will replace.
> >=20
> > > +	int seen_exclusive_status =3D 0;
> > > +
> > > +	/* Iterate over all lines */
> > > +	for (line =3D buf; *line; line =3D strchrnul(line+1, '\n')) {
> > > +		while (*line =3D=3D '\n')
> > > +			line++;
> > > +		/* Skip lines that don't start with GNUPG status */
> > > +		if (!skip_prefix(line, "[GNUPG:] ", &line))
> > > +			continue;
> > > +
> > > +		/* Iterate over all search strings */
> > > +		for (i =3D 0; i < ARRAY_SIZE(sigcheck_gpg_status); i++) {
> > > +			if (skip_prefix(line, sigcheck_gpg_status[i].check, &line)) {
> > > +				if (sigcheck_gpg_status[i].flags & GPG_STATUS_EXCLUSIVE) {
> > > +					if (++seen_exclusive_status > 1)
> > > +						goto found_duplicate_status;
> >=20
> > Very minor point but by not using pre-increment, i.e.
> >=20
> > 		if (seen_exclusive_status++)
> > 			goto found_duplicate_status;
> >=20
> > you can use the expression as a "have we already seen?" boolean,
> > whic may probably be more idiomatic.
> >=20
> > The patch is good in the way written as-is, and this is so minor
> > that it is not worth rerolling to only update this part.
>=20
> Please don't merge it yet. I gave it some more thought and I think the lo=
op refactoring may cause TRUST_* to override BADSIG (i.e. upgrade from 'bad=
' to 'untrusted'). I'm going to verify this when I get home.
>=20

I was wrong.  I'm sorry about the noise.  I've reverified the logic,
and it correct.  That is:

1) for trusted signature, only GOODSIG is emitted and 'G' is returned
correctly,

2) for untrusted signature, GOODSIG is followed by TRUST_* messages,
so line-wise TRUST_* check replaces the 'G' with 'U',

3) for bad signature, only BADSIG is emitted without TRUST_* messages.

Furthermore, GnuPG documentation confirms that TRUST_* is only emitted
for good signatures [1].

[1]:https://github.com/gpg/gnupg/blob/master/doc/DETAILS#trust_

--=20
Best regards,
Micha=C5=82 G=C3=B3rny

--=-7IqbfH18CBB4pE4uyUH+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQKTBAABCgB9FiEEXr8g+Zb7PCLMb8pAur8dX/jIEQoFAlvN685fFIAAAAAALgAo
aXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5maWZ0aGhvcnNlbWFuLm5ldDVF
QkYyMEY5OTZGQjNDMjJDQzZGQ0E0MEJBQkYxRDVGRjhDODExMEEACgkQur8dX/jI
EQoTqQ/+LylFQTISgx6NpWexKPAhXXFszRJ+NtiToQuYcLftmNp1gaPApjdjVOfm
fCvFo0KxfE5BZ1mgC4f8r+6mk6tYSAZgox9Rpfnsbt3XsLOA1KOVYykUSV0Q5/Qd
jRHG0DOIHccWnb9m8cReRWzmyVcTdek7TYzOl0Tuox9OPkyYRo9Tg7RzdBWH7DjA
6vCvEkXA3TRygf+3ZowSx4d2OdLJfa5ctc//ouBTi3Xsv6EveYW+WmcaqaV7Zr4z
IjHDBybhN1uJ2fhisJPxmMMGjF/ggbsdET07iREgHtyomdwdet/AkXTzQ9JjAUIW
qwkwBXzYpDoCX6A2sbQZBqM2pLbb/tnMchTcOMgLofDkO+kI4iGpOHNWA9GJu3zS
61zUTiAqSDYETvHaDZcAaan95t4OgZk0vq3lNVq2hQRwwtNSrLSJHuN5Vna6VlLb
I0nhfu/4l1sizSIMwV0K5sPaEhHuOqqn6VkOJpGXIqhHs0zvjCJO7o0aCRZDulh9
CmGzTDRiAYlclh7N+L6ulbXjd+FOZyJQx1VrcGWuI6hF9xXhpHjHWbMPE/YvRpl1
vjjuCRJ0DvpgH8QZp0D4gFEBwKE81q5311HYXFJPmp8js4NUhFe4Pvs9nStHusXH
czp9ypiSMpUs/W3j6XLXqg+ZQLklyQLQIT+vrxJ4dpeHC1Ge7Ts=
=F4VD
-----END PGP SIGNATURE-----

--=-7IqbfH18CBB4pE4uyUH+--

