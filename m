Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 588351F453
	for <e@80x24.org>; Sun, 21 Oct 2018 07:10:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727118AbeJUPYI (ORCPT <rfc822;e@80x24.org>);
        Sun, 21 Oct 2018 11:24:08 -0400
Received: from smtp.gentoo.org ([140.211.166.183]:46888 "EHLO smtp.gentoo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726975AbeJUPYI (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 21 Oct 2018 11:24:08 -0400
Received: from pomiot (d202-252.icpnet.pl [109.173.202.252])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mgorny)
        by smtp.gentoo.org (Postfix) with ESMTPSA id BBB7B335D0C;
        Sun, 21 Oct 2018 07:10:45 +0000 (UTC)
Message-ID: <1540105841.1174.1.camel@gentoo.org>
Subject: Re: [PATCH v4] gpg-interface.c: detect and reject multiple
 signatures on commits
From:   =?UTF-8?Q?Micha=C5=82_G=C3=B3rny?= <mgorny@gentoo.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Date:   Sun, 21 Oct 2018 09:10:41 +0200
In-Reply-To: <xmqqin1wyxvz.fsf@gitster-ct.c.googlers.com>
References: <20181020193020.28517-1-mgorny@gentoo.org>
         <xmqqin1wyxvz.fsf@gitster-ct.c.googlers.com>
Organization: Gentoo
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-tVN6DuwmjpjRyx+4ViR6"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--=-tVN6DuwmjpjRyx+4ViR6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, 2018-10-21 at 08:57 +0900, Junio C Hamano wrote:
> Micha=C5=82 G=C3=B3rny <mgorny@gentoo.org> writes:
>=20
> > GnuPG supports creating signatures consisting of multiple signature
> > packets.  If such a signature is verified, it outputs all the status
> > messages for each signature separately.  However, git currently does no=
t
> > account for such scenario and gets terribly confused over getting
> > multiple *SIG statuses.
> >=20
> > For example, if a malicious party alters a signed commit and appends
> > a new untrusted signature, git is going to ignore the original bad
> > signature and report untrusted commit instead.  However, %GK and %GS
> > format strings may still expand to the data corresponding
> > to the original signature, potentially tricking the scripts into
> > trusting the malicious commit.
> >=20
> > Given that the use of multiple signatures is quite rare, git does not
> > support creating them without jumping through a few hoops, and finally
> > supporting them properly would require extensive API improvement, it
> > seems reasonable to just reject them at the moment.
> >=20
> > Signed-off-by: Micha=C5=82 G=C3=B3rny <mgorny@gentoo.org>
> > ---
> >  gpg-interface.c          | 90 +++++++++++++++++++++++++++-------------
> >  t/t7510-signed-commit.sh | 26 ++++++++++++
> >  2 files changed, 87 insertions(+), 29 deletions(-)
> >=20
> > Changes in v4:
> > * switched to using skip_prefix(),
> > * renamed the variable to seen_exclusive_status,
> > * made the loop terminate early on first duplicate status seen.
>=20
> Thanks for sticking to the topic and polishing it further.  Looks
> very good. =20
>=20
> Will replace.
>=20
> > +	int seen_exclusive_status =3D 0;
> > +
> > +	/* Iterate over all lines */
> > +	for (line =3D buf; *line; line =3D strchrnul(line+1, '\n')) {
> > +		while (*line =3D=3D '\n')
> > +			line++;
> > +		/* Skip lines that don't start with GNUPG status */
> > +		if (!skip_prefix(line, "[GNUPG:] ", &line))
> > +			continue;
> > +
> > +		/* Iterate over all search strings */
> > +		for (i =3D 0; i < ARRAY_SIZE(sigcheck_gpg_status); i++) {
> > +			if (skip_prefix(line, sigcheck_gpg_status[i].check, &line)) {
> > +				if (sigcheck_gpg_status[i].flags & GPG_STATUS_EXCLUSIVE) {
> > +					if (++seen_exclusive_status > 1)
> > +						goto found_duplicate_status;
>=20
> Very minor point but by not using pre-increment, i.e.
>=20
> 		if (seen_exclusive_status++)
> 			goto found_duplicate_status;
>=20
> you can use the expression as a "have we already seen?" boolean,
> whic may probably be more idiomatic.
>=20
> The patch is good in the way written as-is, and this is so minor
> that it is not worth rerolling to only update this part.
>=20

Sure, thanks.  For the record, I've been taught to use pre-increment
whenever possible to avoid copying the variable but I suppose it doesn't
really matter here.  Just a habit.

I'll start working on my next ideas once this is merged and I rebase.

--=20
Best regards,
Micha=C5=82 G=C3=B3rny

--=-tVN6DuwmjpjRyx+4ViR6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQKTBAABCgB9FiEEXr8g+Zb7PCLMb8pAur8dX/jIEQoFAlvMJnFfFIAAAAAALgAo
aXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5maWZ0aGhvcnNlbWFuLm5ldDVF
QkYyMEY5OTZGQjNDMjJDQzZGQ0E0MEJBQkYxRDVGRjhDODExMEEACgkQur8dX/jI
EQqrQRAA48dMdYg2Nhe1xTMn71OPsfrcb6lA1OvbRZUIkM7EDfQs4/7H2uMQDTR3
++SWBKxCBh5s0wg1TuGLuNh4CLxijuVHCfxauODmg6SKOSVsgBI5/jkh+VMhaji/
ObRTMtkW61GM8qSeMnAiDM9xEMN5GnsC7Lj/kZYvnHOGVLyDUa+uZlM/FzN1w2pP
nef8qMK34L/lcbSIiQKPYND05oEy/USU2QsGAJtjIOSqWYtKaaBlLuMUPFgfpDjO
nlGTceDTzjQ3GacsG/pGWt4CdTte+eZ9HLCopH5VTmyB2zYPUSlfRJoXnQXvlGU1
MJZZ8Zp295zs7w+2HlmVCwAlsClZN1cFRwXrEHJwOazmeVjvTHthVklLoXntwZGC
//7UHPnTYNIRWDByzxwHIkxZSkJ8tTcJuaHq3qe8gAcTfPDRyk7UPpU13R5iq1xz
7/ITMLiLpMO8bD+lmU61IZoeLD0t1xY9Sdx17kh82lTBtxQDzvG/Z1G+xXdtHy1H
JzreV9GDXWLxHZK/minyECGg6T0wM6kGyaNqvw52lIjHFGGW6dJxFKs0khKo5q2R
IAm7ajn9qa3TEdlK6KYxqlPqV9ec1+XZTmwdZtvRbk7WIVKQcmMQ/S1hHmj/2kRj
TH67Odl8E70UeTDiytzb7YsEWcJek9ZrAY6gHe1+WoyBbzRZDkA=
=fmqZ
-----END PGP SIGNATURE-----

--=-tVN6DuwmjpjRyx+4ViR6--

