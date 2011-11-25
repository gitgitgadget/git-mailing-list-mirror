From: Carlos =?iso-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>
Subject: Re: Infinite loop in cascade_filter_fn()
Date: Fri, 25 Nov 2011 18:02:19 +0100
Message-ID: <20111125170219.GD10417@beez.lab.cmartin.tk>
References: <Pine.GSO.4.63.1111231801580.5099@shipon.roxen.com>
 <20111125153829.GB10417@beez.lab.cmartin.tk>
 <Pine.GSO.4.63.1111251705330.22588@shipon.roxen.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="d01dLTUuW90fS44H"
Cc: Git Mailing list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Henrik =?iso-8859-1?Q?Grubbstr=F6m?= <grubba@roxen.com>
X-From: git-owner@vger.kernel.org Fri Nov 25 18:03:03 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RTzB0-0001ya-IZ
	for gcvg-git-2@lo.gmane.org; Fri, 25 Nov 2011 18:03:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752092Ab1KYRC5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Nov 2011 12:02:57 -0500
Received: from kimmy.cmartin.tk ([91.121.65.165]:60135 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751496Ab1KYRC5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Nov 2011 12:02:57 -0500
Received: from beez.lab.cmartin.tk (i59F7870A.versanet.de [89.247.135.10])
	by kimmy.cmartin.tk (Postfix) with ESMTPA id 5D8144619B;
	Fri, 25 Nov 2011 18:02:15 +0100 (CET)
Received: (nullmailer pid 4571 invoked by uid 1000);
	Fri, 25 Nov 2011 17:02:19 -0000
Mail-Followup-To: Carlos =?iso-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>,
	Henrik =?iso-8859-1?Q?Grubbstr=F6m?= <grubba@roxen.com>,
	Git Mailing list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.63.1111251705330.22588@shipon.roxen.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185940>


--d01dLTUuW90fS44H
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 25, 2011 at 05:14:17PM +0100, Henrik Grubbstr=F6m wrote:
> On Fri, 25 Nov 2011, Carlos Mart=EDn Nieto wrote:
>=20
> >This patch fixes this, but I think it would still break if the LF is
> >at the end of the file. Changing the `if (!input)` to put the LF in
> >the output buffer may or may not be the right soulution. I feel like
> >this should be handled by cascade_filter_fn rather than the actual
> >filter somehow, but Junio's comment (4ae66704 'stream filter: add "no
> >more input" to the filters') suggests otherwise.
> >
> >I'm working on a cleaner patch that takes care of a bit of state, but
> >this is the general idea.
>=20
> Looks good to me (and seems to work in my case).

That patch would give wrong output if the same happened at the end of
a file. The attached patch should also cover this case.

> Typo in the commit subject though.
>=20
> >  cmn
> >--- 8< ---
> >Subject: [PATCH] convert: don't loop indefintely if at LF-to-CRLF stream=
ing
>                                        ^^^^^^^^^^^
> This should be either "infinitely", or "indefinitely", but since we
> know that the loop won't terminate "infinitely" is to be preferred.

Thanks for noticing. I went with a different title in the end. Junio,
could you consider this one for inclusion in the next RC?

--- 8< ---
Subject: [PATCH] convert: track state in LF-to-CRLF filter

There may not be enough space to store CRLF in the output. If we don't
fill the buffer, then the filter will keep getting called with the same
short buffer and will loop forever.

Instead, always store the CR and record there's a missing LF if
necessary it so we store it in the output buffer the next time the
function gets called.

Reported-by: Henrik Grubbstr=F6m <grubba@roxen.com>
Signed-off-by: Carlos Mart=EDn Nieto <cmn@elego.de>
---
 convert.c |   23 ++++++++++++++++-------
 1 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/convert.c b/convert.c
index 86e9c29..c050b86 100644
--- a/convert.c
+++ b/convert.c
@@ -880,20 +880,29 @@ static int lf_to_crlf_filter_fn(struct stream_filter =
*filter,
 				const char *input, size_t *isize_p,
 				char *output, size_t *osize_p)
 {
-	size_t count;
+	size_t count, o =3D 0;
+	static int want_lf =3D 0;
+
+	/* Output a pending LF if we need to */
+	if (want_lf) {
+		output[o++] =3D '\n';
+		want_lf =3D 0;
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
+				output[o++] =3D '\r';
+				if (o >=3D *osize_p) {
+					want_lf =3D 1;
 					break;
+				}
 			}
 			output[o++] =3D ch;
 		}
--=20
1.7.8.rc3.31.g017d1



--d01dLTUuW90fS44H
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJOz8obAAoJEHKRP1jG7ZzTd+0H/0HtI8xRzI7pB5XrNBnY+Hzb
htG9t79RzRWKY16VJRZ1dBl2OVNaO35LdVQwnQ1wez36Wx2pAp+u/rBBvuMv7WBy
M5LFhxBEHJq6zjp7sL5w5B4hI5DHbvgvwnvfJSQyu01LH7ygACo5b0VoFKdJjSjn
+gd0Z/h/ytdndPxcGEsg/BORhc3Z3EQX0D0ILGxTGrI7ylNXlSFEd9KuW5gNyl/V
q8oTq7MGHtMJIrUJ5/qDxTJu3evubDCz2znIPA0zH9Gq25A/ppJoAjzA4tVHQKUh
CRrjbTYE11B90YDYIhUFx+ioDzvE/1kuzCpY4SEY3mhybe1QYxeDGY0BxDLAXtc=
=V1tx
-----END PGP SIGNATURE-----

--d01dLTUuW90fS44H--
