From: Carlos =?iso-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>
Subject: Re: Infinite loop in cascade_filter_fn()
Date: Fri, 25 Nov 2011 16:38:29 +0100
Message-ID: <20111125153829.GB10417@beez.lab.cmartin.tk>
References: <Pine.GSO.4.63.1111231801580.5099@shipon.roxen.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GRPZ8SYKNexpdSJ7"
Cc: Git Mailing list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Henrik =?iso-8859-1?Q?Grubbstr=F6m?= <grubba@grubba.org>
X-From: git-owner@vger.kernel.org Fri Nov 25 16:39:15 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RTxru-0004Rl-Jb
	for gcvg-git-2@lo.gmane.org; Fri, 25 Nov 2011 16:39:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752374Ab1KYPjI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Nov 2011 10:39:08 -0500
Received: from kimmy.cmartin.tk ([91.121.65.165]:59118 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752177Ab1KYPjH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Nov 2011 10:39:07 -0500
Received: from beez.lab.cmartin.tk (i59F7870A.versanet.de [89.247.135.10])
	by kimmy.cmartin.tk (Postfix) with ESMTPA id 227734619B;
	Fri, 25 Nov 2011 16:38:25 +0100 (CET)
Received: (nullmailer pid 27576 invoked by uid 1000);
	Fri, 25 Nov 2011 15:38:29 -0000
Mail-Followup-To: Carlos =?iso-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>,
	Henrik =?iso-8859-1?Q?Grubbstr=F6m?= <grubba@grubba.org>,
	Git Mailing list <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
Content-Disposition: inline
In-Reply-To: <Pine.GSO.4.63.1111231801580.5099@shipon.roxen.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185933>


--GRPZ8SYKNexpdSJ7
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Nov 23, 2011 at 06:40:47PM +0100, Henrik Grubbstr=F6m wrote:
> Hi.
>=20
> My git repository walker just got bitten by what seems to be a
> reasonably new bug in convert.c:cascade_filter_fn() (git 1.7.8.rc3
> (gentoo)).
>=20
> How to reproduce:
>=20
>   git clone git@github.com:pikelang/Pike.git
>=20
>   git checkout -f 0e2080f838c6f0bc7d670ac7549676a353451dca^
>=20
>   git checkout -f 0e2080f838c6f0bc7d670ac7549676a353451dca
>=20
> The first two commands complete as expected, while the last hangs forever.
> Performing the same with git 1.7.6.4 works as expected.
>=20
> The problematic file seems to be
> /src/modules/_Crypto/rijndael_ecb_vt.txt which has the attributes:
> text ident eol=3Dcrlf

It looks like you won the lottery. The problem was that the output
buffer only has one byte available when we see a LF. We check whether
there is enough space (two bytes) to store CRLF in the output buffer,
see that there isn't and return. cascade_filter_fn sees that the
buffer hasn't been written fully and calls lf_to_crlf_filter_fn with
the same output buffer, which we still can't fill, because it's too
short.

This patch fixes this, but I think it would still break if the LF is
at the end of the file. Changing the `if (!input)` to put the LF in
the output buffer may or may not be the right soulution. I feel like
this should be handled by cascade_filter_fn rather than the actual
filter somehow, but Junio's comment (4ae66704 'stream filter: add "no
more input" to the filters') suggests otherwise.

I'm working on a cleaner patch that takes care of a bit of state, but
this is the general idea.

   cmn
--- 8< ---
Subject: [PATCH] convert: don't loop indefintely if at LF-to-CRLF streaming

If we find a LF when the output buffer is only has one byte remaining,
cascade_filter_fn won't notice that we need more input and won't drain
the output buffer.

In such a case, store whether we've outputted the CR so we can retake
it from there.

Signed-off-by: Carlos Mart=EDn Nieto <cmn@elego.de>
---
 convert.c |   11 ++++++++---
 1 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/convert.c b/convert.c
index 86e9c29..4218f40 100644
--- a/convert.c
+++ b/convert.c
@@ -881,6 +881,7 @@ static int lf_to_crlf_filter_fn(struct stream_filter *f=
ilter,
 				char *output, size_t *osize_p)
 {
 	size_t count;
+	static int put_cr =3D 0;
=20
 	if (!input)
 		return 0; /* we do not keep any states */
@@ -890,10 +891,14 @@ static int lf_to_crlf_filter_fn(struct stream_filter =
*filter,
 		for (i =3D o =3D 0; o < *osize_p && i < count; i++) {
 			char ch =3D input[i];
 			if (ch =3D=3D '\n') {
-				if (o + 1 < *osize_p)
+				if (put_cr) {
+					put_cr =3D 0;
+				} else {
 					output[o++] =3D '\r';
-				else
-					break;
+					put_cr =3D 1;
+					i--;
+					continue;
+				}
 			}
 			output[o++] =3D ch;
 		}
--=20
1.7.8.rc3.31.g017d1


--GRPZ8SYKNexpdSJ7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAEBAgAGBQJOz7Z1AAoJEHKRP1jG7ZzTEDIH/3C6hXKrWN3fwFcl8gdCxmxS
h+TszAfuJtlhweS5gdz1nKadI+OVN/HRC6lRnaoAp75YlkwAl75YmW5RX8HDBW80
K7vr+TAEi6VPiFaspJHo2t2xPKViyl9Xn1WuK25kKdX4LoonRq1yKNrLmkrFa4/K
LdX0+U6Utu8ftlUWWoxLJwTDLQcPl2XMBmOADecxKTcgSnyIlqcanmVScH23Bnfh
6f2QG89SsdfcujKthb6bE2IxVarzYdAX+rE8D7sTZvNrje9kM7Smh58T9FfEi3Kz
tZcqjr1Ec+kCtIWIx82f+wcOoUJC3cB4QfXzEQNk8LVfqJv4d4+VWPbu/jqlHwQ=
=ouCo
-----END PGP SIGNATURE-----

--GRPZ8SYKNexpdSJ7--
