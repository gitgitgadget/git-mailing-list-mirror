From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [BUG] having 'plink' anywhere in the GIT_SSH environment
 variables sets putty = true
Date: Wed, 22 Apr 2015 21:19:15 +0000
Message-ID: <20150422211915.GB827497@vauxhall.crustytoothpaste.net>
References: <2A6FFC1D-5479-4DCA-A5E5-FF92DE0AA552@gmail.com>
 <6c2a6b53e8e6e019b145dddc67a9d2ca@www.dscho.org>
 <F1AB6016-DA88-446C-84E9-1BD42436843D@gmail.com>
 <20150422202910.GB26917@peff.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="nVMJ2NtxeReIH9PS"
Cc: Patrick Sharp <jakanapes@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Apr 22 23:19:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yl23M-0001gu-FW
	for gcvg-git-2@plane.gmane.org; Wed, 22 Apr 2015 23:19:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757492AbbDVVTY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Apr 2015 17:19:24 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:44629 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757486AbbDVVTW (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Apr 2015 17:19:22 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:3544:5b75:6b3:b192])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id E09A32808D;
	Wed, 22 Apr 2015 21:19:20 +0000 (UTC)
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>, Patrick Sharp <jakanapes@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20150422202910.GB26917@peff.net>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.16.0-4-amd64)
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Score: -0.272 BAYES_00,RDNS_NONE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267641>


--nVMJ2NtxeReIH9PS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 22, 2015 at 04:29:10PM -0400, Jeff King wrote:
> I think you want something like:
>=20
> diff --git a/connect.c b/connect.c
> index 9ae991a..58aad56 100644
> --- a/connect.c
> +++ b/connect.c
> @@ -568,7 +568,8 @@ struct child_process *git_connect(int fd[2], const ch=
ar *url_orig,
>  	conn->argv =3D arg =3D xcalloc(7, sizeof(*arg));
>  	if (protocol =3D=3D PROTO_SSH) {
>  		const char *ssh =3D getenv("GIT_SSH");
> -		int putty =3D ssh && strcasestr(ssh, "plink");
> +		int putty =3D ssh && (ends_with(ssh, "plink") ||
> +				    ends_with("plink.exe"));
>  		if (!ssh) ssh =3D "ssh";
> =20
>  		*arg++ =3D ssh;
>=20
> though that is not quite enough (we do not have a case-insensitive
> version of "ends_with"). I'm also not sure if matching just "plink" and
> "plink.exe" at the end of the string is enough (I'm just guessing that
> was the original reason for using strstr in the first place).
>=20
> Note that I don't think just switching the strcasestr to look for
> "plink.exe" is right. For one thing, it just punts on the problem (it
> can still happen, it's just less likely to trigger). But for another,
> you can have plink (without ".exe") on Linux systems.

Perhaps it would be worthwhile to check instead if the text "plink" is
the beginning of string or is preceded by a path separator.  That would
give us a bit more confidence that the user is looking for plink, but
would still allow people to use "plink-0.63" if they like.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--nVMJ2NtxeReIH9PS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJVOBBTAAoJEL9TXYEfUvaLvVUP/jvHNpeuZcAmnACpS/lXakxZ
IIfJLD4y4fgxCWCey4n09/PIXjsJECxLvhWFLWiZRulAl7k3KkUwlKVXaqPylTpP
nFwcPB9+Odir0e5GA312VXTAkGH32+X01vI1eOIfEcU3orlNpvycsLxhvIQvJwOw
fCjmQP0o1K6vXfXeJx8suI4TXu2BHfkW3R+WB9/cxhegG/fFiTowAoKZ1rQw7wyd
EJ2B6WNoRXoSSz1x2MTLY0x6Qss62Y+FkXU9Dj25ulq2OjaRVGIz640OTgPFxNYn
6+9LQKF8Zl4EQsDCmIEYt4jPcy9CZ9vYVC57f+UDxOaWyKSManuwV0ijo2sMYICe
qPDWsnpFgWCKrljAFP8A/kpSLp4eyJlCmehcYTVGq8+GanG1y4SRKapKKbp4CZJr
VNjEsTwGzjJ6IvdDtkfT3HHcQp1FHV5NsDaWucd8pzc/MQ7cc0AjnP0y2N8k1N++
LhvAvg+2mYXx5mdjZ5vnMZsmCGtrqQhNQWE8kAnp7jujN2VTfj7g2nbm+iOHQods
Y5cM9HTQbNhUKGCyezsppXDdAHER5qyp/47Y13zDAMLIWeu2c/gpIteSa906tOHa
nR022GDpek529ycqRIriLvyPySN6fhFio4fm+xvYt+QnoWrRqQLt2EL0QlJfAsRh
1ednMtnPEPv835YK9NM0
=BNo+
-----END PGP SIGNATURE-----

--nVMJ2NtxeReIH9PS--
