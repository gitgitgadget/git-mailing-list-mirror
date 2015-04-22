From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [BUG] having 'plink' anywhere in the GIT_SSH environment
 variables sets putty = true
Date: Wed, 22 Apr 2015 21:44:45 +0000
Message-ID: <20150422214445.GC827497@vauxhall.crustytoothpaste.net>
References: <2A6FFC1D-5479-4DCA-A5E5-FF92DE0AA552@gmail.com>
 <6c2a6b53e8e6e019b145dddc67a9d2ca@www.dscho.org>
 <F1AB6016-DA88-446C-84E9-1BD42436843D@gmail.com>
 <20150422202910.GB26917@peff.net>
 <20150422211915.GB827497@vauxhall.crustytoothpaste.net>
 <20150422212904.GA32043@peff.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="f0KYrhQ4vYSV2aJu"
Cc: Patrick Sharp <jakanapes@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Apr 22 23:44:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yl2Rz-0006IG-P4
	for gcvg-git-2@plane.gmane.org; Wed, 22 Apr 2015 23:44:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757938AbbDVVov (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Apr 2015 17:44:51 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:44650 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757969AbbDVVou (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Apr 2015 17:44:50 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:3544:5b75:6b3:b192])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id ADC772808D;
	Wed, 22 Apr 2015 21:44:48 +0000 (UTC)
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>, Patrick Sharp <jakanapes@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20150422212904.GA32043@peff.net>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.16.0-4-amd64)
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Score: -0.272 BAYES_00,RDNS_NONE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267645>


--f0KYrhQ4vYSV2aJu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 22, 2015 at 05:29:04PM -0400, Jeff King wrote:
> > Perhaps it would be worthwhile to check instead if the text "plink" is
> > the beginning of string or is preceded by a path separator.  That would
> > give us a bit more confidence that the user is looking for plink, but
> > would still allow people to use "plink-0.63" if they like.
>=20
> Yeah, I think that is a reasonable approach. Note that it needs to
> handle the "tortoiseplink" case from below, too (you can still use your
> strategy, you just need to look for either string).

So maybe something like this?

diff --git a/connect.c b/connect.c
index 391d211..ba3ab34 100644
--- a/connect.c
+++ b/connect.c
@@ -749,10 +749,15 @@ struct child_process *git_connect(int fd[2], const ch=
ar *url,
 					conn->use_shell =3D 1;
 					putty =3D 0;
 				} else {
+					char *plink, *tplink;
+
 					ssh =3D getenv("GIT_SSH");
 					if (!ssh)
 						ssh =3D "ssh";
-					putty =3D !!strcasestr(ssh, "plink");
+					plink =3D strcasestr(ssh, "plink");
+					tplink =3D strcasestr(ssh, "tortoiseplink");
+					putty =3D plink =3D=3D ssh || (plink && is_dir_sep(plink[-1])) ||
+						tplink =3D=3D ssh || (tplink && is_dir_sep(tplink[-1]));
 				}
=20
 				argv_array_push(&conn->args, ssh);
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--f0KYrhQ4vYSV2aJu
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJVOBZNAAoJEL9TXYEfUvaL9okQAKoJp4omPJEB7EzErXUm1R98
XQicyixw3GQGOZoIogLmOg1hXYcv+b9c41iFT5mOEGq3Tsr/hAGXNfxwK8CKRK5k
f0MUr0X1fCMLdTvtoFP3qePRpS6scVWMkXDe9cZ7szeUJ4OJ5gMluDkDuPeqAoOP
LhwDkoGvZ5EVyGOx5Wxk7y3i7zkv4S8hxmPexkE+x1xEYJsvgnXtQZ60DG49J6Hp
R7tlHH1oRQ1LJmaBi2uib29WvED4qx8m+G0zc4w2HVs2TSD7fekWNcaz80j5yUVN
tx5cvayacOV5CzlUcUCuRqyPurSOK55c4iBknprmq7VS8uz6VDRmylXBr/Dp9Ukw
8hAQ244UceBInyAwFjULb+AAzoNOcxtgMmbHfTFQ/dMna9mUirbxBYuxCPzDmQ3S
e4UvQcHrcHhEgPgd1e4Z15ZbGLLEj2kq4HaF5Md6nXE9UMC5N0OzrDWjIi7766IM
cdczZVSE5n3USI0txSpP3jYhVULUZcQ+I1K8gML9o6uLRRcfKe1X/y6b2rlGQiOy
SrJmeyT0nav78tDFANb7EbvkUKpkKdB552DEMVCW2IzEdchAYQyRbBCiYqChx77e
4bt0atqm0Lfvz/LBJfE63wL+79fmNbWwWaDsUI5Yp7xVbyuMcJ7vTschhiBp5CZE
paAIGn4/lBAusY5wq7os
=tVa0
-----END PGP SIGNATURE-----

--f0KYrhQ4vYSV2aJu--
