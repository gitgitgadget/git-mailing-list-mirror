From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: Returning error message from custom smart http server
Date: Fri, 16 May 2014 23:01:16 +0000
Message-ID: <20140516230116.GC180798@vauxhall.crustytoothpaste.net>
References: <5371CC4F.80602@intland.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="GPJrCs/72TxItFYR"
Cc: git@vger.kernel.org
To: =?utf-8?B?IsOBa29zLCBUYWp0aSI=?= <akos.tajti@intland.com>
X-From: git-owner@vger.kernel.org Sat May 17 01:01:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WlR83-0003C5-1Y
	for gcvg-git-2@plane.gmane.org; Sat, 17 May 2014 01:01:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754941AbaEPXBW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 May 2014 19:01:22 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:47790 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752864AbaEPXBV (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 May 2014 19:01:21 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:c1bd:3a45:42c8:45a6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 6588E28087;
	Fri, 16 May 2014 23:01:20 +0000 (UTC)
Mail-Followup-To: =?utf-8?B?IsOBa29zLCBUYWp0aSI=?= <akos.tajti@intland.com>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <5371CC4F.80602@intland.com>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.14-trunk-rt-amd64)
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Score: -0.272 () BAYES_00,RDNS_NONE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249430>


--GPJrCs/72TxItFYR
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 13, 2014 at 09:39:59AM +0200, "=C3=81kos, Tajti" wrote:
> Dear List,
>=20
> we implemented our own git smart http server to be able to check permissi=
ons
> and other thing before pushes. It works fine, however, the error messages=
 we
> generate on the server side are not displayed by the command line client.=
 On
> the server we generate error messages like this:
>=20
>         response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
>         response.getWriter().write(msg);
>=20
> On the command line we get this:
>=20
> Total 0 (delta 0), reused 0 (delta 0)
> POST git-receive-pack (290 bytes)
> efrror: RPC failed; result=3D22, HTTP code =3D 401
> atal: The remote end hung up unexpectedly
> fatal: The remote end hung up unexpectedly
>=20
> The server message is completely missing. Is there a solution for this?

It does look that way.  Does the following patch work for you?

-- >8 --
Subject: [PATCH] http: provide server's error message on RPC failure

The server might provide a custom error message that is useful to the user.
Provide this message to the user if HTTP RPC fails.

Signed-off-by: brian m. carlson <sandals@crustytoothpaste.net>
---
 remote-curl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/remote-curl.c b/remote-curl.c
index 52c2d96..5984d35 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -426,8 +426,8 @@ static int run_slot(struct active_request_slot *slot,
 	err =3D run_one_slot(slot, results);
=20
 	if (err !=3D HTTP_OK && err !=3D HTTP_REAUTH) {
-		error("RPC failed; result=3D%d, HTTP code =3D %ld",
-		      results->curl_result, results->http_code);
+		error("RPC failed; result=3D%d, HTTP code =3D %ld (%s)",
+		      results->curl_result, results->http_code, curl_errorstr);
 	}
=20
 	return err;
-- >8 --

--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--GPJrCs/72TxItFYR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJTdpi8AAoJEL9TXYEfUvaLBvoQAJe1ctkRK9gpJjUAlXKIQDrk
mk6qCBBextWLPjRrnrBEObmqhTJNbKYp+0GkXrpHtKrTUIAUzc4947rYzxXffdqK
ST1CX/R+cNBs2wfmp9Sp3wjFLPQZwj2DgBxX6FRnL+8ePovpXNAMc+VsaoAG/rEh
rNOfA26WyUVd6c6GmcCDROSZy1vTtMpMokfjW/Kdg9COHqBSexjR6NOducY10MNM
NFuqf/kauL6gjffHGAFKQLG6jCOlLSGXANm7NrzykQPkYoJOycF9Al/VIx5xU2rG
Gu/VJcCyBvwuUIVgG4Jcj/ub9tmizJlOM1np7uzY1JwCDjkrkZJyX5+D95O52Itf
qYaFtVBCtK4GfiYoPNZ7Ww2CG+rPeusj1jgzAqQwV7Lw/kKhQYZaIu8VcxNNHMOn
SlxWPbXusMVnCW8+5PQ03adcPlWsviwCatGVR8eDjG+EmU2LsWayeFu2kIE2TgKK
o5U7PKsxNny6sm8gSifuyq2rbUXi6nFCg4DcbGI0gN+avZ02ruL809Z8xbG5ZZZi
8K1kakvQRqd8xrPk75Y6xLXqHzZfVEMpLFG0J8e5/YY/qlJZIBb0jbRBdlumSDll
e9D7xUQB0ELVXkM8uCA30GxUaCsnWUGgVlGknRJFktsEWeJp37IQUWnr6zvzlbIq
Oy6PeOAvHWa/dsykDTE0
=Q8AC
-----END PGP SIGNATURE-----

--GPJrCs/72TxItFYR--
