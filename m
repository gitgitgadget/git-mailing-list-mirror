From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [BUG] having 'plink' anywhere in the GIT_SSH environment
 variables sets putty = true
Date: Wed, 22 Apr 2015 22:24:55 +0000
Message-ID: <20150422222455.GA274681@vauxhall.crustytoothpaste.net>
References: <2A6FFC1D-5479-4DCA-A5E5-FF92DE0AA552@gmail.com>
 <6c2a6b53e8e6e019b145dddc67a9d2ca@www.dscho.org>
 <F1AB6016-DA88-446C-84E9-1BD42436843D@gmail.com>
 <20150422202910.GB26917@peff.net>
 <20150422211915.GB827497@vauxhall.crustytoothpaste.net>
 <20150422212904.GA32043@peff.net>
 <20150422214445.GC827497@vauxhall.crustytoothpaste.net>
 <20150422220053.GA32268@peff.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="d6Gm4EdcadzBjdND"
Cc: Patrick Sharp <jakanapes@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 23 00:25:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yl34u-0004Dq-J9
	for gcvg-git-2@plane.gmane.org; Thu, 23 Apr 2015 00:25:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752475AbbDVWZC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Apr 2015 18:25:02 -0400
Received: from castro.crustytoothpaste.net ([173.11.243.49]:44680 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753945AbbDVWZB (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Apr 2015 18:25:01 -0400
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:112:d5ce:1b0:b59a])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 0A8FC2808D;
	Wed, 22 Apr 2015 22:24:59 +0000 (UTC)
Mail-Followup-To: "brian m. carlson" <sandals@crustytoothpaste.net>,
	Jeff King <peff@peff.net>, Patrick Sharp <jakanapes@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <20150422220053.GA32268@peff.net>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.16.0-4-amd64)
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Score: -0.272 BAYES_00,RDNS_NONE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267649>


--d6Gm4EdcadzBjdND
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 22, 2015 at 06:00:54PM -0400, Jeff King wrote:
> Yeah, that looks right to me. You might want to represent the "are we
> tortoise" check as a separate flag, though, and reuse it a few lines
> later.

Sounds like a good idea.  I'll send a more formal patch a bit later
today.

> Also, not related to your patch, but I notice the "putty" declaration is
> in a different scope than I would have expected, which made me wonder if
> it gets initialized in all code paths. I think is from the recent
> addition of CONNECT_DIAG_URL, which pushes the bulk of the code into its
> own else clause, even though the first part of the "if" always returns
> early.  I wonder if it would be simpler to read like:
>=20
> diff --git a/connect.c b/connect.c
> index 391d211..749a07b 100644
> --- a/connect.c
> +++ b/connect.c
> @@ -743,28 +743,28 @@ struct child_process *git_connect(int fd[2], const =
char *url,
>  				free(path);
>  				free(conn);
>  				return NULL;
> -			} else {
> -				ssh =3D getenv("GIT_SSH_COMMAND");
> -				if (ssh) {
> -					conn->use_shell =3D 1;
> -					putty =3D 0;
> -				} else {
> -					ssh =3D getenv("GIT_SSH");
> -					if (!ssh)
> -						ssh =3D "ssh";
> -					putty =3D !!strcasestr(ssh, "plink");
> -				}
> -
> -				argv_array_push(&conn->args, ssh);
> -				if (putty && !strcasestr(ssh, "tortoiseplink"))
> -					argv_array_push(&conn->args, "-batch");
> -				if (port) {
> -					/* P is for PuTTY, p is for OpenSSH */
> -					argv_array_push(&conn->args, putty ? "-P" : "-p");
> -					argv_array_push(&conn->args, port);
> -				}
> -				argv_array_push(&conn->args, ssh_host);
>  			}
> +
> +			ssh =3D getenv("GIT_SSH_COMMAND");
> +			if (ssh) {
> +				conn->use_shell =3D 1;
> +				putty =3D 0;
> +			} else {
> +				ssh =3D getenv("GIT_SSH");
> +				if (!ssh)
> +					ssh =3D "ssh";
> +				putty =3D !!strcasestr(ssh, "plink");
> +			}
> +
> +			argv_array_push(&conn->args, ssh);
> +			if (putty && !strcasestr(ssh, "tortoiseplink"))
> +				argv_array_push(&conn->args, "-batch");
> +			if (port) {
> +				/* P is for PuTTY, p is for OpenSSH */
> +				argv_array_push(&conn->args, putty ? "-P" : "-p");
> +				argv_array_push(&conn->args, port);
> +			}
> +			argv_array_push(&conn->args, ssh_host);
>  		} else {
>  			/* remove repo-local variables from the environment */
>  			conn->env =3D local_repo_env;

I can drop this in as a preparatory patch if I can have your sign-off.
--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--d6Gm4EdcadzBjdND
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJVOB+3AAoJEL9TXYEfUvaLLooQAKAbmDdjBm9owxA6Xck4lIZB
bmjX2k0/JtEUxMkkILrva5ao2qL1MvHoth4gaBvSy7oA89+w2xzBDxrO7ZY9z5xK
7i7lFvIt27DWMy2yCcYfrazGYfUXBtfxPb+2QID+s+j6I/WskPpDKyDX+juFB++b
D3e61mmUXIED3CE3wGnF+mnA+oxcJZhGuNMWT1Jxgpq0h7+0AnL88scviFbjGsXk
65QTgZYpCmSUX5D7LggKhknPRZ/opN6j7I3wY5Ag0Jj61JkMpOrpoIqbk9x0mOoG
3thMfd5/ZQ31Farkp0f3JTec/GPxxjw+9hsIB8jPC+wCi2rVdQ6g7x3DGQLt4Uoz
AjLhF4K91CPAqdbo/0Fq9n68h3spY/X3sgPUtzm/tyPmdZ346Uc1PchfG/iIYp4f
WCmK1n+Fs67ZTvvNDs/hG/pmzviU6TyJ19FYZ1Zh5qhLW7xgJxTiRQnqNHPhvtw4
JcMqEMt0fIOFSY0cud6CxFYP3wfVU4pX9Jwq5Jja5Ywgxn3lrN0G1u/Yb0OWJSAX
wTDNZGudQhC14A6N2GRx/Bn4HKvVAwYGU6lyUmLNpXePDiVQDAqhz3LBxFuiQ/gQ
kl8bs7R6XYXRyV3kBlnm0uuRDKTjkaQPLCPgAbu1P+pY9EFSj5eN2333ooZTOy5e
NBzlFGQZvbR9cgwT8aQA
=d5gu
-----END PGP SIGNATURE-----

--d6Gm4EdcadzBjdND--
