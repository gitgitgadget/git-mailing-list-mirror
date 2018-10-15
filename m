Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7B1AA1F453
	for <e@80x24.org>; Mon, 15 Oct 2018 20:44:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726067AbeJPEb1 (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 Oct 2018 00:31:27 -0400
Received: from smtp.gentoo.org ([140.211.166.183]:53288 "EHLO smtp.gentoo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725917AbeJPEb1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Oct 2018 00:31:27 -0400
Received: from pomiot (d202-252.icpnet.pl [109.173.202.252])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mgorny)
        by smtp.gentoo.org (Postfix) with ESMTPSA id 9410D335CE4;
        Mon, 15 Oct 2018 20:44:31 +0000 (UTC)
Message-ID: <1539636266.1014.6.camel@gentoo.org>
Subject: Re: [PATCH v3] gpg-interface.c: detect and reject multiple
 signatures on commits
From:   =?UTF-8?Q?Micha=C5=82_G=C3=B3rny?= <mgorny@gentoo.org>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Date:   Mon, 15 Oct 2018 22:44:26 +0200
In-Reply-To: <xmqqva636g2t.fsf@gitster-ct.c.googlers.com>
References: <20181012210928.18033-1-mgorny@gentoo.org>
         <xmqqva636g2t.fsf@gitster-ct.c.googlers.com>
Organization: Gentoo
Content-Type: multipart/signed; micalg="pgp-sha512";
        protocol="application/pgp-signature"; boundary="=-YHiNT8enCusSlAqh/oar"
X-Mailer: Evolution 3.26.6 
Mime-Version: 1.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--=-YHiNT8enCusSlAqh/oar
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2018-10-15 at 12:31 +0900, Junio C Hamano wrote:
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
> >  gpg-interface.c          | 94 +++++++++++++++++++++++++++-------------
> >  t/t7510-signed-commit.sh | 26 +++++++++++
> >  2 files changed, 91 insertions(+), 29 deletions(-)
> >=20
> > Changes in v3: reworked the whole loop to iterate over lines rather
> > than scanning the whole buffer, as requested.  Now it also catches
> > duplicate instances of the same status.
> >=20
> > diff --git a/gpg-interface.c b/gpg-interface.c
> > index db17d65f8..480aab4ee 100644
> > --- a/gpg-interface.c
> > +++ b/gpg-interface.c
> > @@ -75,48 +75,84 @@ void signature_check_clear(struct signature_check *=
sigc)
> >  	FREE_AND_NULL(sigc->key);
> >  }
> > =20
> > +/* An exclusive status -- only one of them can appear in output */
> > +#define GPG_STATUS_EXCLUSIVE	(1<<0)
> > +
> >  static struct {
> >  	char result;
> >  	const char *check;
> > +	unsigned int flags;
> >  } sigcheck_gpg_status[] =3D {
> > -	{ 'G', "\n[GNUPG:] GOODSIG " },
> > -	{ 'B', "\n[GNUPG:] BADSIG " },
> > -	{ 'U', "\n[GNUPG:] TRUST_NEVER" },
> > -	{ 'U', "\n[GNUPG:] TRUST_UNDEFINED" },
> > -	{ 'E', "\n[GNUPG:] ERRSIG "},
> > -	{ 'X', "\n[GNUPG:] EXPSIG "},
> > -	{ 'Y', "\n[GNUPG:] EXPKEYSIG "},
> > -	{ 'R', "\n[GNUPG:] REVKEYSIG "},
> > +	{ 'G', "GOODSIG ", GPG_STATUS_EXCLUSIVE },
> > +	{ 'B', "BADSIG ", GPG_STATUS_EXCLUSIVE },
> > +	{ 'U', "TRUST_NEVER", 0 },
> > +	{ 'U', "TRUST_UNDEFINED", 0 },
> > +	{ 'E', "ERRSIG ", GPG_STATUS_EXCLUSIVE },
> > +	{ 'X', "EXPSIG ", GPG_STATUS_EXCLUSIVE },
> > +	{ 'Y', "EXPKEYSIG ", GPG_STATUS_EXCLUSIVE },
> > +	{ 'R', "REVKEYSIG ", GPG_STATUS_EXCLUSIVE },
> >  };
> > =20
> >  static void parse_gpg_output(struct signature_check *sigc)
> >  {
> >  	const char *buf =3D sigc->gpg_status;
> > +	const char *line, *next;
> >  	int i;
> > -
> > -	/* Iterate over all search strings */
> > -	for (i =3D 0; i < ARRAY_SIZE(sigcheck_gpg_status); i++) {
> > -		const char *found, *next;
> > -
> > -		if (!skip_prefix(buf, sigcheck_gpg_status[i].check + 1, &found)) {
> > -			found =3D strstr(buf, sigcheck_gpg_status[i].check);
> > -			if (!found)
> > -				continue;
> > -			found +=3D strlen(sigcheck_gpg_status[i].check);
> > -		}
> > -		sigc->result =3D sigcheck_gpg_status[i].result;
> > -		/* The trust messages are not followed by key/signer information */
> > -		if (sigc->result !=3D 'U') {
> > -			next =3D strchrnul(found, ' ');
> > -			sigc->key =3D xmemdupz(found, next - found);
> > -			/* The ERRSIG message is not followed by signer information */
> > -			if (*next && sigc-> result !=3D 'E') {
> > -				found =3D next + 1;
> > -				next =3D strchrnul(found, '\n');
> > -				sigc->signer =3D xmemdupz(found, next - found);
> > +	int had_exclusive_status =3D 0;
> > +
> > +	/* Iterate over all lines */
> > +	for (line =3D buf; *line; line =3D strchrnul(line+1, '\n')) {
> > +		while (*line =3D=3D '\n')
> > +			line++;
> > +		/* Skip lines that don't start with GNUPG status */
> > +		if (strncmp(line, "[GNUPG:] ", 9))
> > +			continue;
> > +		line +=3D 9;
>=20
> You do not want to count to 9 yourself.  Instead
>=20
> 	if (!skip_prefix(line, "[GNUPG:] ", &line))
> 		continue;
>=20
>=20
> > +		/* Iterate over all search strings */
> > +		for (i =3D 0; i < ARRAY_SIZE(sigcheck_gpg_status); i++) {
> > +			if (!strncmp(line, sigcheck_gpg_status[i].check,
> > +					strlen(sigcheck_gpg_status[i].check))) {
> > +				line +=3D strlen(sigcheck_gpg_status[i].check);
>=20
> Likewise.

Both done.

>=20
> > +				if (sigcheck_gpg_status[i].flags & GPG_STATUS_EXCLUSIVE)
> > +					had_exclusive_status++;
>=20
> "has" is fine, but I think existing code elsewhere we use "seen" for
> things like this.
>=20
> > +				sigc->result =3D sigcheck_gpg_status[i].result;
> > +				/* The trust messages are not followed by key/signer information *=
/
> > +				if (sigc->result !=3D 'U') {
> > +					next =3D strchrnul(line, ' ');
> > +					free(sigc->key);
> > +					sigc->key =3D xmemdupz(line, next - line);
> > +					/* The ERRSIG message is not followed by signer information */
> > +					if (*next && sigc->result !=3D 'E') {
> > +						line =3D next + 1;
> > +						next =3D strchrnul(line, '\n');
> > +						free(sigc->signer);
> > +						sigc->signer =3D xmemdupz(line, next - line);
> > +					}
> > +				}
> > +				break;
> >  			}
> >  		}
> >  	}
>=20
> So unless U/E, we expect to see a key, and unless E, we also expect
> there is a signer; we keep the last value we see in the sequence in
> sigc.  Because all of these that are not U are marked exclusive, if
> we check if sigc->key already has value at the point you free the
> sigc->key field above, we can see if there is a duplicate record
> that are of "exclusive" type?  I am not suggesting to lose the
> addition of "flags =3D GPG_STATUS_EXCLUSIVE|0" field, but trying to
> see if I am getting the logic right.
>=20
> For gpg_status that is !GPG_STATUS_EXCLUSIVE (i.e. "U"), we do not
> do any replacement of already seen .key/.signer, and all the cases
> that we do the replacement are GPG_STATUS_EXCLUSIVE, which we know
> will become an error in the code below when we do see twice.  So it
> is fine not to check if .key/.signer we see twice are the same or
> different.  It is an error even if we see the same .key/.signer
> twice---having two records is already wrong no matter whose key/sign
> it is.
>=20
> OK, so the whole thing makes sense to me.
>=20
> Having said that, if we wanted to short-circuit, I think
>=20
>                 for (each line) {
>                         for (each sigcheck_gpg_status[]) {
>                                 if (not the one on line)
>                                         continue;
>                                 if (sigc->result !=3D 'U') {
>                                         if (sigc->key)
>                                                 goto found_dup;
>                                         sigc->key =3D make a copy;
>                                         if (*next && sigc->result !=3D 'E=
') {
>                                                 if (sigc->signer)
>                                                         goto found_dup;
>                                                 sigc->signer =3D make a c=
opy;
>                                         }
>                                 }
>                                 break;
>                         }
>                 }
>                 return;
>=20
>         found_dup:
>                 sigc->result =3D 'E';
>                 FREE_AND_NULL(sigc->signer);
>                 FREE_AND_NULL(sigc->key);
>                 return;
> 	=09
> would also be fine.

Do I understand correctly that you mean to take advantage that 'seen
exclusive status' cases match 'seen key' cases?  I think this would be
a little less readable.

That said, I was planning on next patch that replaced the "!=3D 'U'" test
with explicit flags for whether a particular status includes key
and UID.  If you'd agree with this direction, I think having this one
separate as well would make sense.

> > +
> > +	/*
> > +	 * GOODSIG, BADSIG etc. can occur only once for each signature.
> > +	 * Therefore, if we had more than one then we're dealing with multipl=
e
> > +	 * signatures.  We don't support them currently, and they're rather
> > +	 * hard to create, so something is likely fishy and we should reject
> > +	 * them altogether.
> > +	 */
> > +	if (had_exclusive_status > 1) {
> > +		sigc->result =3D 'E';
> > +		/* Clear partial data to avoid confusion */
> > +		if (sigc->signer)
> > +			FREE_AND_NULL(sigc->signer);
> > +		if (sigc->key)
> > +			FREE_AND_NULL(sigc->key);
>=20
> I think it is OK to use FREE_AND_NULL() unconditionally (just like
> we can use free(x) on x=3D=3DNULL).

Done as well.

>=20
> > +	}
> >  }
>=20
>=20

--=20
Best regards,
Micha=C5=82 G=C3=B3rny

--=-YHiNT8enCusSlAqh/oar
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQKTBAABCgB9FiEEXr8g+Zb7PCLMb8pAur8dX/jIEQoFAlvE/CtfFIAAAAAALgAo
aXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5maWZ0aGhvcnNlbWFuLm5ldDVF
QkYyMEY5OTZGQjNDMjJDQzZGQ0E0MEJBQkYxRDVGRjhDODExMEEACgkQur8dX/jI
EQqSuhAAqJ9wtgJZ50Bt4ThYUciO7bR8Uk5foQ9Baiij0GV8lWuv24XyAn1WIIlH
c1LA1/UVvuMEEPYQCPZbRC/+YrdWiZJfrfoF6qTLmFoINhn1LEo4VwaEfrcVprRW
wJxOfa5/jzrqDV1MbMI/4RpuTk/t3T8hfR81aZy6nQgasCf6JPGrEtWAIjajJnTv
gVklrkucO66qaa0axbBTii6ry5JgxKPSkynIGIAyvN2qrpo1/tFGpYHvFiK5JE5P
JWXHqUtYV2+r3pm3RZt2FL1iPW+GYcC2Ihp5799qS/ddPHSYwimQc1xMy44lYJvp
f6lMeF7ci4C/B+oGZmDUF1a0bdN2r9esXfKRK54juIVI6Rt+ZNX4qLzddT5UgGXp
5esnHfXQ/2GncfW7TqthA2ThVMn/LVpmPzHr3RN71pKc7+6dnmcfDiIUAncl4CSQ
HEgjxZ9iF07w8CywyHD6eH+T7uHrAGzR9h4HdLeJR/+B8wEV42NIh/SigRGbHB0B
v6R1jB9X72HavFuf1GD/Hvol/JC0OJ/L95zqSnMHJOxuZ+Xml/nr16xw0Wx/1tST
QvFJXXgjkE4FebbT+dNfEu8nz2XkzkEWJ01/6LBmpiBwiWCjbNf+6xaFhkPJD5BM
cOFCRcFB/a6QK8LzbiWMyo2pnFr7nNg+CgxFnsh1ef7wtU6Jjkg=
=wtaq
-----END PGP SIGNATURE-----

--=-YHiNT8enCusSlAqh/oar--

