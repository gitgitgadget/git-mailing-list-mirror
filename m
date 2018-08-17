Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2D4261F404
	for <e@80x24.org>; Fri, 17 Aug 2018 06:42:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726316AbeHQJod (ORCPT <rfc822;e@80x24.org>);
        Fri, 17 Aug 2018 05:44:33 -0400
Received: from smtp.gentoo.org ([140.211.166.183]:57012 "EHLO smtp.gentoo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726094AbeHQJoc (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Aug 2018 05:44:32 -0400
Received: from pomiot (d202-252.icpnet.pl [109.173.202.252])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mgorny)
        by smtp.gentoo.org (Postfix) with ESMTPSA id 2DD4D335D0D;
        Fri, 17 Aug 2018 06:42:22 +0000 (UTC)
Message-ID: <1534488137.1262.2.camel@gentoo.org>
Subject: Re: [PATCH] gpg-interface.c: detect and reject multiple signatures
 on commits
From:   =?UTF-8?Q?Micha=C5=82_G=C3=B3rny?= <mgorny@gentoo.org>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <junio@pobox.com>
Date:   Fri, 17 Aug 2018 08:42:17 +0200
In-Reply-To: <20180815213108.GM181377@aiede.svl.corp.google.com>
References: <xmqqbmaa9t8k.fsf@gitster-ct.c.googlers.com>
         <20180814151142.13960-1-mgorny@gentoo.org>
         <20180815213108.GM181377@aiede.svl.corp.google.com>
Organization: Gentoo
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-ruoXI0uTxvT5mExW/sdn"
X-Mailer: Evolution 3.24.6 
Mime-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--=-ruoXI0uTxvT5mExW/sdn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2018-08-15 at 14:31 -0700, Jonathan Nieder wrote:
> Micha=C5=82 G=C3=B3rny wrote:
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
> > ---
>=20
> Thanks for the clear analysis and fix.
>=20
> May we have your sign-off?  See
> https://www.kernel.org/pub/software/scm/git/docs/SubmittingPatches.html#s=
ign-off
> (or the equivalent section of your local copy of
> Documentation/SubmittingPatches) for what this means.

Of course, I'm sorry for missing it in the original submission.

>=20
> >  gpg-interface.c | 38 ++++++++++++++++++++++++++++++--------
> >  1 file changed, 30 insertions(+), 8 deletions(-)
> >=20
> > diff --git a/gpg-interface.c b/gpg-interface.c
> > index 09ddfbc26..4e03aec15 100644
> > --- a/gpg-interface.c
> > +++ b/gpg-interface.c
> > @@ -24,21 +24,23 @@ void signature_check_clear(struct signature_check *=
sigc)
> >  static struct {
> >  	char result;
> >  	const char *check;
> > +	int is_status;
> >  } sigcheck_gpg_status[] =3D {
> > -	{ 'G', "\n[GNUPG:] GOODSIG " },
> > -	{ 'B', "\n[GNUPG:] BADSIG " },
> > -	{ 'U', "\n[GNUPG:] TRUST_NEVER" },
> > -	{ 'U', "\n[GNUPG:] TRUST_UNDEFINED" },
> > -	{ 'E', "\n[GNUPG:] ERRSIG "},
> > -	{ 'X', "\n[GNUPG:] EXPSIG "},
> > -	{ 'Y', "\n[GNUPG:] EXPKEYSIG "},
> > -	{ 'R', "\n[GNUPG:] REVKEYSIG "},
> > +	{ 'G', "\n[GNUPG:] GOODSIG ", 1 },
> > +	{ 'B', "\n[GNUPG:] BADSIG ", 1 },
> > +	{ 'U', "\n[GNUPG:] TRUST_NEVER", 0 },
> > +	{ 'U', "\n[GNUPG:] TRUST_UNDEFINED", 0 },
> > +	{ 'E', "\n[GNUPG:] ERRSIG ", 1},
> > +	{ 'X', "\n[GNUPG:] EXPSIG ", 1},
> > +	{ 'Y', "\n[GNUPG:] EXPKEYSIG ", 1},
> > +	{ 'R', "\n[GNUPG:] REVKEYSIG ", 1},
> >  };
>=20
> nit: I wonder if making is_status into a flag field (like 'option' in
> git.c's cmd_struct) and having an explicit SIGNATURE_STATUS value to
> put there would make this easier to read.

I think that makes sense.

>=20
> It's not clear to me that the name is_status or SIGNATURE_STATUS
> captures what this field represents.  Aren't these all sigcheck
> statuses?  Can you describe briefly what distinguishes the cases where
> this should be 0 versus 1?

Yes, the name really does suck.  Maybe it should be EXCLUSIVE_STATUS
or something like that, to distinguish from things that can occur
simultaneously to them.

>=20
> > =20
> >  static void parse_gpg_output(struct signature_check *sigc)
> >  {
> >  	const char *buf =3D sigc->gpg_status;
> >  	int i;
> > +	int had_status =3D 0;
> > =20
> >  	/* Iterate over all search strings */
> >  	for (i =3D 0; i < ARRAY_SIZE(sigcheck_gpg_status); i++) {
> > @@ -50,6 +52,10 @@ static void parse_gpg_output(struct signature_check =
*sigc)
> >  				continue;
> >  			found +=3D strlen(sigcheck_gpg_status[i].check);
> >  		}
> > +
> > +		if (sigcheck_gpg_status[i].is_status)
> > +			had_status++;
> > +
> >  		sigc->result =3D sigcheck_gpg_status[i].result;
> >  		/* The trust messages are not followed by key/signer information */
> >  		if (sigc->result !=3D 'U') {
> > @@ -62,6 +68,22 @@ static void parse_gpg_output(struct signature_check =
*sigc)
> >  			}
> >  		}
> >  	}
> > +
> > +	/*
> > +	 * GOODSIG, BADSIG etc. can occur only once for each signature.
> > +	 * Therefore, if we had more than one then we're dealing with multipl=
e
> > +	 * signatures.  We don't support them currently, and they're rather
> > +	 * hard to create, so something is likely fishy and we should reject
> > +	 * them altogether.
> > +	 */
> > +	if (had_status > 1) {
> > +		sigc->result =3D 'E';
> > +		/* Clear partial data to avoid confusion */
> > +		if (sigc->signer)
> > +			FREE_AND_NULL(sigc->signer);
> > +		if (sigc->key)
> > +			FREE_AND_NULL(sigc->key);
> > +	}
>=20
> Makes sense to me.
>=20
> >  }
> > =20
> >  int check_signature(const char *payload, size_t plen, const char *sign=
ature,
> > --=20
> > 2.18.0
>=20
> Can we have a test to make sure this behavior doesn't regress?  See
> t/README for an overview of the test framework and "git grep -e gpg t/"
> for some examples.

Will try.  Do I presume correctly that I should include the commit
object with the double signature instead of hacking git to construct it?
;-)

>=20
> The result looks good.  Thanks again for writing it.
>=20
> Sincerely,
> Jonathan

--=20
Best regards,
Micha=C5=82 G=C3=B3rny

--=-ruoXI0uTxvT5mExW/sdn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQKTBAABCgB9FiEEXr8g+Zb7PCLMb8pAur8dX/jIEQoFAlt2bklfFIAAAAAALgAo
aXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5maWZ0aGhvcnNlbWFuLm5ldDVF
QkYyMEY5OTZGQjNDMjJDQzZGQ0E0MEJBQkYxRDVGRjhDODExMEEACgkQur8dX/jI
EQpvlQ/9GtAMuA45lgIgDJYwZKy4dX+XyaxunQR05C/1WNmu921YN6n2pWRsmATh
7bqQURBI0MRcUX6/4jplLv9H7LezfHDypA2boXbT8ybUBtsu+jy08olHzX7Iuf2e
tHHhCAmeyjei7RZuwaiuhVrcT8eVRBAMaWskOI2g3S12fmYhPWcP4TICMWJX2eK3
uMoDxSmUTGwMZK/TSrs2Gj4IE7xK6d+D93gRcmM/VlL2lfTKylEDV6IfXCA3NNZs
ZfC6JL8YARv+t2WKMZ9ecg9zsCgN0LI086M1l9LY8q2XE005l6uNTtTdLPiLRXjH
eYBQX554ntLGXfFadJPAsLl5s4pYXZ/2WQuHfJKibCwUABddtHR7LMYFXhNiI29o
1lcTiySitPEsYsJ4oyLjKaGheSmknRQNOt+eRDw49TmgOPfxzFATLF55zgXZck6X
W6zubYNfFtzKiRLYv/3vrgSNt90al3dZ+J/za5oTGBaHfknWb3xIZgqaxhZ6Ey1d
Er7QtR5xJxTdY+6WOWGoYJejP9zzIx0XA20xnReFdV7w//QSr1r1sNOKdVq8EewC
icpc0Hrlc9CXTbfcPdlwH/j+D3xtQnIvsK+qJsSk04BPukbacbzgihmS2pse8GNd
aSyplN6rIkBXqlhqCCX7WUkK04H6dpYDsdiYjilRH89LAMIYCzg=
=C9el
-----END PGP SIGNATURE-----

--=-ruoXI0uTxvT5mExW/sdn--

