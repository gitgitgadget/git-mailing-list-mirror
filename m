From: Max Horn <max@quendi.de>
Subject: Re: [PATCH v3] commit.c: use skip_prefix() instead of starts_with()
Date: Tue, 4 Mar 2014 20:16:47 +0100
Message-ID: <8CB399B0-6781-4702-9EC5-0D0A0CCC3450@quendi.de>
References: <1393922540-13156-1-git-send-email-tanayabh@gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Content-Type: multipart/signed; boundary="Apple-Mail=_EBF286A4-0DA2-4261-BB98-F6BD79A2BA8B"; protocol="application/pgp-signature"; micalg=pgp-sha256
Cc: git@vger.kernel.org, mhagger@alum.mit.edu, gitster@pobox.com
To: Tanay Abhra <tanayabh@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 04 20:17:12 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKuq0-0007Gn-2S
	for gcvg-git-2@plane.gmane.org; Tue, 04 Mar 2014 20:17:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756119AbaCDTRC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Mar 2014 14:17:02 -0500
Received: from wp256.webpack.hosteurope.de ([80.237.133.25]:59650 "EHLO
	wp256.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1755730AbaCDTQ7 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Mar 2014 14:16:59 -0500
Received: from hsi-kbw-46-223-222-244.hsi.kabel-badenwuerttemberg.de ([46.223.222.244] helo=[192.168.50.136]); authenticated
	by wp256.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	id 1WKupf-0002Ci-IE; Tue, 04 Mar 2014 20:16:51 +0100
In-Reply-To: <1393922540-13156-1-git-send-email-tanayabh@gmail.com>
X-Mailer: Apple Mail (2.1510)
X-bounce-key: webpack.hosteurope.de;max@quendi.de;1393960619;fa51eebf;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243371>


--Apple-Mail=_EBF286A4-0DA2-4261-BB98-F6BD79A2BA8B
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii


On 04.03.2014, at 09:42, Tanay Abhra <tanayabh@gmail.com> wrote:

[...]

> commit.c | 17 +++++++++--------
> 1 file changed, 9 insertions(+), 8 deletions(-)
>=20
> diff --git a/commit.c b/commit.c
> index 6bf4fe0..6c92acb 100644
> --- a/commit.c
> +++ b/commit.c

[...]

> @@ -566,14 +566,16 @@ static void record_author_date(struct =
author_date_slab *author_date,
> 	     buf;
> 	     buf =3D line_end + 1) {
> 		line_end =3D strchrnul(buf, '\n');
> -		if (!starts_with(buf, "author ")) {
> +		ident_line =3D skip_prefix(buf, "author ");
> +		if (!ident_line) {
> 			if (!line_end[0] || line_end[1] =3D=3D '\n')
> 				return; /* end of header */
> 			continue;
> 		}
> +		buf =3D ident_line;
> 		if (split_ident_line(&ident,
> -				     buf + strlen("author "),
> -				     line_end - (buf + strlen("author =
"))) ||
> +				     buf,
> +				     line_end - buf) ||
> 		    !ident.date_begin || !ident.date_end)
> 			goto fail_exit; /* malformed "author" line */
> 		break;

Why not get rid of that assignment to "buf", and use ident_line instead =
of buf below? That seems like it would be more readable, wouldn't it?


> @@ -1193,10 +1195,9 @@ static void parse_gpg_output(struct =
signature_check *sigc)
> 	for (i =3D 0; i < ARRAY_SIZE(sigcheck_gpg_status); i++) {
> 		const char *found, *next;
>=20
> -		if (starts_with(buf, sigcheck_gpg_status[i].check + 1)) =
{
> -			/* At the very beginning of the buffer */
> -			found =3D buf + =
strlen(sigcheck_gpg_status[i].check + 1);
> -		} else {
> +		found =3D skip_prefix(buf, sigcheck_gpg_status[i].check =
+ 1);
> +		/* At the very beginning of the buffer */

Do we really need that comment, and in that spot? The code seemed clear =
enough to me without it. But if you think keeping is better, perhaps =
move it to *before* the skip_prefix, and add a trailing "?"

> +		if(!found) {
> 			found =3D strstr(buf, =
sigcheck_gpg_status[i].check);
> 			if (!found)
> 				continue;



--Apple-Mail=_EBF286A4-0DA2-4261-BB98-F6BD79A2BA8B
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP using GPGMail

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iF4EAREIAAYFAlMWJqMACgkQIpJVslrhe1mEkQD/a/jmVIZrw9mNlfpDDqANUZ68
RH3Y2hqZZ9Bzcui1zF8A/3mDec+2M1JcEWXfRWdwKb27/Oe5cvXD/J6sk6/GfkqM
=HB+i
-----END PGP SIGNATURE-----

--Apple-Mail=_EBF286A4-0DA2-4261-BB98-F6BD79A2BA8B--
