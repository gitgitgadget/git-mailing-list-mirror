From: Carlos =?iso-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>
Subject: Re: Infinite loop in cascade_filter_fn()
Date: Mon, 19 Dec 2011 17:42:14 +0100
Message-ID: <20111219164214.GA2160@beez.lab.cmartin.tk>
References: <Pine.GSO.4.63.1111231801580.5099@shipon.roxen.com>
 <20111125153829.GB10417@beez.lab.cmartin.tk>
 <Pine.GSO.4.63.1111251705330.22588@shipon.roxen.com>
 <20111125170219.GD10417@beez.lab.cmartin.tk>
 <7vy5v2wleb.fsf@alter.siamese.dyndns.org>
 <20111128104812.GA2386@beez.lab.cmartin.tk>
 <7viplggoq9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BXVAT5kNtrzKuDFl"
Cc: Henrik =?iso-8859-1?Q?Grubbstr=F6m?= <grubba@roxen.com>,
	Git Mailing list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 19 17:43:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RcgJG-0003Ej-OY
	for gcvg-git-2@lo.gmane.org; Mon, 19 Dec 2011 17:43:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751556Ab1LSQn1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Dec 2011 11:43:27 -0500
Received: from kimmy.cmartin.tk ([91.121.65.165]:58293 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751032Ab1LSQnZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Dec 2011 11:43:25 -0500
Received: from beez.lab.cmartin.tk (52.Red-79-151-197.dynamicIP.rima-tde.net [79.151.197.52])
	by kimmy.cmartin.tk (Postfix) with ESMTPA id C6264461B4;
	Mon, 19 Dec 2011 17:43:18 +0100 (CET)
Received: (nullmailer pid 22447 invoked by uid 1000);
	Mon, 19 Dec 2011 16:42:14 -0000
Mail-Followup-To: Carlos =?iso-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>,
	Junio C Hamano <gitster@pobox.com>,
	Henrik =?iso-8859-1?Q?Grubbstr=F6m?= <grubba@roxen.com>,
	Git Mailing list <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <7viplggoq9.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187457>


--BXVAT5kNtrzKuDFl
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Dec 16, 2011 at 02:01:50PM -0800, Junio C Hamano wrote:
> Carlos Mart=EDn Nieto <cmn@elego.de> writes:
>=20
> > Subject: [PATCHv2] convert: track state in LF-to-CRLF filter
> >
> > There may not be enough space to store CRLF in the output. If we don't
> > fill the buffer, then the filter will keep getting called with the same
> > short buffer and will loop forever.
> >
> > Instead, always store the CR and record whether there's a missing LF
> > if so we store it in the output buffer the next time the function gets
> > called.
> >
> > Reported-by: Henrik Grubbstr=F6m <grubba@roxen.com>
> > Signed-off-by: Carlos Mart=EDn Nieto <cmn@elego.de>
> > ---
> >  convert.c |   50 +++++++++++++++++++++++++++++++++++++-------------
> >  1 files changed, 37 insertions(+), 13 deletions(-)
> >
> > diff --git a/convert.c b/convert.c
> > index 86e9c29..1c91409 100644
> > --- a/convert.c
> > +++ b/convert.c
> > @@ -876,24 +876,39 @@ int is_null_stream_filter(struct stream_filter *f=
ilter)
> >  /*
> >   * LF-to-CRLF filter
> >   */
> > +
> > +struct lf_to_crlf_filter {
> > +	struct stream_filter filter;
> > +	int want_lf;
> > +};
> > +
> >  static int lf_to_crlf_filter_fn(struct stream_filter *filter,
> >  				const char *input, size_t *isize_p,
> >  				char *output, size_t *osize_p)
> >  {
> > -	size_t count;
> > +	size_t count, o =3D 0;
> > +	struct lf_to_crlf_filter *lfcrlf =3D (struct lf_to_crlf_filter *) fil=
ter;
> > +
> > +	/* Output a pending LF if we need to */
> > +	if (lfcrlf->want_lf) {
> > +		output[o++] =3D '\n';
> > +		lfcrlf->want_lf =3D 0;
> > +	}
> > =20
> >  	if (!input)
> > -		return 0; /* we do not keep any states */
> > +		return 0; /* We've already dealt with the state */
> > +
>=20
> Shouldn't we be decrementing *osize_p by 'o' to signal that we used that
> many bytes in the output buffer here before returning to the caller?

Yes we should, thanks for spotting it.

>=20
> >  	count =3D *isize_p;
> >  	if (count) {
> > -		size_t i, o;
> > -		for (i =3D o =3D 0; o < *osize_p && i < count; i++) {
> > +		size_t i;
> > +		for (i =3D 0; o < *osize_p && i < count; i++) {
> >  			char ch =3D input[i];
> >  			if (ch =3D=3D '\n') {
> > -				if (o + 1 < *osize_p)
> > -					output[o++] =3D '\r';
> > -				else
> > -					break;
> > +				output[o++] =3D '\r';
> > +				if (o >=3D *osize_p) {
> > +					lfcrlf->want_lf =3D 1;
> > +					continue; /* We need to increase i */
> > +				}
> >  			}
> >  			output[o++] =3D ch;
> >  		}
>=20

--BXVAT5kNtrzKuDFl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJO72lmAAoJEHKRP1jG7ZzTTCQH/2+4uZHgKf34pxtUKvQBILHx
f02aw41cFS+fca/481zJc1tedLScvVZWvhQ3SHLThmrA7KLmS8SoYCGEpt0OSwOY
05gjRPMUGNIIAn66sNBdPf41x0GatbNqZziJiA10TzwufApS0DGKLTLLbU5K1Ub+
FZ9PQgDaKxW+ekSSFGJKR6Im+NfXID3L+5Wpi0H3Pi67cIBGufWvubwYSI9GYZCS
5WHI0KtFmzqXOp82bqt+TEheH0vy41/CnLkw7NUCnqpviEOHJ94+jyfzcyEFLzNA
JwJdMH8H/cV0csGTO05B8q2S18ekv3r2gbUrDuxaCaAGM5MR9qlBJtcgZH4MP0Y=
=ro67
-----END PGP SIGNATURE-----

--BXVAT5kNtrzKuDFl--
