From: Carlos =?iso-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>
Subject: Re: Infinite loop in cascade_filter_fn()
Date: Mon, 28 Nov 2011 11:48:12 +0100
Message-ID: <20111128104812.GA2386@beez.lab.cmartin.tk>
References: <Pine.GSO.4.63.1111231801580.5099@shipon.roxen.com>
 <20111125153829.GB10417@beez.lab.cmartin.tk>
 <Pine.GSO.4.63.1111251705330.22588@shipon.roxen.com>
 <20111125170219.GD10417@beez.lab.cmartin.tk>
 <7vy5v2wleb.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="M9NhX3UHpAaciwkO"
Cc: Henrik =?iso-8859-1?Q?Grubbstr=F6m?= <grubba@roxen.com>,
	Git Mailing list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 28 11:48:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RUyld-0003uO-R5
	for gcvg-git-2@lo.gmane.org; Mon, 28 Nov 2011 11:48:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752143Ab1K1Ksx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Nov 2011 05:48:53 -0500
Received: from kimmy.cmartin.tk ([91.121.65.165]:49128 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751801Ab1K1Ksx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Nov 2011 05:48:53 -0500
Received: from beez.lab.cmartin.tk (i59F7870A.versanet.de [89.247.135.10])
	by kimmy.cmartin.tk (Postfix) with ESMTPA id 9B881461A5;
	Mon, 28 Nov 2011 11:48:11 +0100 (CET)
Received: (nullmailer pid 2814 invoked by uid 1000);
	Mon, 28 Nov 2011 10:48:12 -0000
Mail-Followup-To: Carlos =?iso-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>,
	Junio C Hamano <gitster@pobox.com>,
	Henrik =?iso-8859-1?Q?Grubbstr=F6m?= <grubba@roxen.com>,
	Git Mailing list <git@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <7vy5v2wleb.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186010>


--M9NhX3UHpAaciwkO
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Nov 26, 2011 at 02:48:12PM -0800, Junio C Hamano wrote:
> Carlos Mart=EDn Nieto <cmn@elego.de> writes:
>=20
> > diff --git a/convert.c b/convert.c
> > index 86e9c29..c050b86 100644
> > --- a/convert.c
> > +++ b/convert.c
> > @@ -880,20 +880,29 @@ static int lf_to_crlf_filter_fn(struct stream_fil=
ter *filter,
> >  				const char *input, size_t *isize_p,
> >  				char *output, size_t *osize_p)
> >  {
> > -	size_t count;
> > +	size_t count, o =3D 0;
> > +	static int want_lf =3D 0;
>=20
> I do not think we want function scope static state anywhere in the cascade
> filter chain, as it will forbid us from running more than one output chain
> at the same time in the future. I think the correct way to structure it
> would be to create lf_to_crlf_filter as a proper subclass of stream_filter
> (see how cascade_filter_fn() casts its filter argument down to an instance
> of the cascade_filter class and uses it to keep track of its state) and
> keep this variable as its own filter state [*1*].

Good point, here's a patch that does that.

   cmn

--- 8< ---
Subject: [PATCHv2] convert: track state in LF-to-CRLF filter

There may not be enough space to store CRLF in the output. If we don't
fill the buffer, then the filter will keep getting called with the same
short buffer and will loop forever.

Instead, always store the CR and record whether there's a missing LF
if so we store it in the output buffer the next time the function gets
called.

Reported-by: Henrik Grubbstr=F6m <grubba@roxen.com>
Signed-off-by: Carlos Mart=EDn Nieto <cmn@elego.de>
---
 convert.c |   50 +++++++++++++++++++++++++++++++++++++-------------
 1 files changed, 37 insertions(+), 13 deletions(-)

diff --git a/convert.c b/convert.c
index 86e9c29..1c91409 100644
--- a/convert.c
+++ b/convert.c
@@ -876,24 +876,39 @@ int is_null_stream_filter(struct stream_filter *filte=
r)
 /*
  * LF-to-CRLF filter
  */
+
+struct lf_to_crlf_filter {
+	struct stream_filter filter;
+	int want_lf;
+};
+
 static int lf_to_crlf_filter_fn(struct stream_filter *filter,
 				const char *input, size_t *isize_p,
 				char *output, size_t *osize_p)
 {
-	size_t count;
+	size_t count, o =3D 0;
+	struct lf_to_crlf_filter *lfcrlf =3D (struct lf_to_crlf_filter *) filter;
+
+	/* Output a pending LF if we need to */
+	if (lfcrlf->want_lf) {
+		output[o++] =3D '\n';
+		lfcrlf->want_lf =3D 0;
+	}
=20
 	if (!input)
-		return 0; /* we do not keep any states */
+		return 0; /* We've already dealt with the state */
+
 	count =3D *isize_p;
 	if (count) {
-		size_t i, o;
-		for (i =3D o =3D 0; o < *osize_p && i < count; i++) {
+		size_t i;
+		for (i =3D 0; o < *osize_p && i < count; i++) {
 			char ch =3D input[i];
 			if (ch =3D=3D '\n') {
-				if (o + 1 < *osize_p)
-					output[o++] =3D '\r';
-				else
-					break;
+				output[o++] =3D '\r';
+				if (o >=3D *osize_p) {
+					lfcrlf->want_lf =3D 1;
+					continue; /* We need to increase i */
+				}
 			}
 			output[o++] =3D ch;
 		}
@@ -904,15 +919,24 @@ static int lf_to_crlf_filter_fn(struct stream_filter =
*filter,
 	return 0;
 }
=20
+static void lf_to_crlf_free_fn(struct stream_filter *filter)
+{
+	free(filter);
+}
+
 static struct stream_filter_vtbl lf_to_crlf_vtbl =3D {
 	lf_to_crlf_filter_fn,
-	null_free_fn,
+	lf_to_crlf_free_fn,
 };
=20
-static struct stream_filter lf_to_crlf_filter_singleton =3D {
-	&lf_to_crlf_vtbl,
-};
+static struct stream_filter *lf_to_crlf_filter(void)
+{
+	struct lf_to_crlf_filter *lfcrlf =3D xmalloc(sizeof(*lfcrlf));
=20
+	lfcrlf->filter.vtbl =3D &lf_to_crlf_vtbl;
+	lfcrlf->want_lf =3D 0;
+	return (struct stream_filter *)lfcrlf;
+}
=20
 /*
  * Cascade filter
@@ -1194,7 +1218,7 @@ struct stream_filter *get_stream_filter(const char *p=
ath, const unsigned char *s
=20
 	else if (output_eol(crlf_action) =3D=3D EOL_CRLF &&
 		 !(crlf_action =3D=3D CRLF_AUTO || crlf_action =3D=3D CRLF_GUESS))
-		filter =3D cascade_filter(filter, &lf_to_crlf_filter_singleton);
+		filter =3D cascade_filter(filter, lf_to_crlf_filter());
=20
 	return filter;
 }
--=20
1.7.8.rc3.31.g017d1



--M9NhX3UHpAaciwkO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJO02bsAAoJEHKRP1jG7ZzTKYQH/1qN8Mkc54mOkt3N+M6M/nR9
kF3/a9GXHM5SsciZT+U4V1AqH7eWq6lJt21vnj0XJBrnNoXfGliCW5T5Us75Lel8
NHCF++CMw/xmCLcfyRLYBXO61R/Ad0bT5yjRrSid8kqLKQxPnLHNbjS3ztoiGO2D
GqBQ1S5SmW51kcJ3iCE4LzZvPhkrVdwxaH3mI50EeNp3TfWZqDtF3cRxL3uOXTue
gTJcOpsgiJX+TBFWk7eYYxQxbs0h643J+k1XhE9vPqinVe1cnK4M5k+1oDRgwecA
yT+p0jFRd+R3BMHP7SCnQmn4RKa7mZnrdop/IHY2lXXu8dTqMJtn+zIAE0QLiYE=
=L33O
-----END PGP SIGNATURE-----

--M9NhX3UHpAaciwkO--
