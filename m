X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Sergey Vlasov <vsu@altlinux.ru>
Subject: Re: [PATCH] git-mv: search more precisely for source directory in index
Date: Sun, 3 Dec 2006 23:04:18 +0300
Message-ID: <20061203200418.GC7971@procyon.home>
References: <20061203135725.GA7971@procyon.home> <Pine.LNX.4.63.0612032036030.28348@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="YD3LsXFS42OYHhNZ"
NNTP-Posting-Date: Sun, 3 Dec 2006 20:05:03 +0000 (UTC)
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0612032036030.28348@wbgn013.biozentrum.uni-wuerzburg.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33135>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GqxZy-0001Rs-Uj for gcvg-git@gmane.org; Sun, 03 Dec
 2006 21:04:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1760053AbWLCUEr (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 3 Dec 2006
 15:04:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760055AbWLCUEr
 (ORCPT <rfc822;git-outgoing>); Sun, 3 Dec 2006 15:04:47 -0500
Received: from master.altlinux.org ([62.118.250.235]:3603 "EHLO
 master.altlinux.org") by vger.kernel.org with ESMTP id S1760053AbWLCUEr
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 3 Dec 2006 15:04:47 -0500
Received: by master.altlinux.org (Postfix, from userid 584) id B9655E3999;
 Sun,  3 Dec 2006 23:04:45 +0300 (MSK)
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Sender: git-owner@vger.kernel.org


--YD3LsXFS42OYHhNZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Dec 03, 2006 at 08:42:47PM +0100, Johannes Schindelin wrote:
>=20
> A move of a directory should find the entries in the index by
> searching for the name _including_ the slash. Otherwise, the
> directory can be shadowed by a file when it matches the prefix
> and is lexicographically smaller, e.g. "ab.c" shadows "ab/".

Thanks - seems to work now, and the existing tests are not broken.

> Noticed by Sergey Vlasov.
>=20
> Signed-off-by: Johannes Schindelin <Johannes.Schindelin@gmx.de>
> ---
>=20
> 	Good catch. Thanks!
>=20
>  builtin-mv.c |   11 +++++++----
>  1 files changed, 7 insertions(+), 4 deletions(-)
>=20
> diff --git a/builtin-mv.c b/builtin-mv.c
> index 54dd3bf..d14a4a7 100644
> --- a/builtin-mv.c
> +++ b/builtin-mv.c
> @@ -146,21 +146,24 @@ int cmd_mv(int argc, const char **argv, const char =
*prefix)
>  				&& lstat(dst, &st) =3D=3D 0)
>  			bad =3D "cannot move directory over file";
>  		else if (src_is_dir) {
> +			const char *src_w_slash =3D add_slash(src);
> +			int len_w_slash =3D length + 1;
>  			int first, last;
> =20
>  			modes[i] =3D WORKING_DIRECTORY;
> =20
> -			first =3D cache_name_pos(src, length);
> +			first =3D cache_name_pos(src_w_slash, len_w_slash);
>  			if (first >=3D 0)
> -				die ("Huh? %s/ is in index?", src);
> +				die ("Huh? %.*s is in index?",
> +						len_w_slash, src_w_slash);
> =20
>  			first =3D -1 - first;
>  			for (last =3D first; last < active_nr; last++) {
>  				const char *path =3D active_cache[last]->name;
> -				if (strncmp(path, src, length)
> -						|| path[length] !=3D '/')
> +				if (strncmp(path, src_w_slash, len_w_slash))
>  					break;
>  			}
> +			free((char *)src_w_slash);
> =20
>  			if (last - first < 1)
>  				bad =3D "source directory is empty";

--YD3LsXFS42OYHhNZ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD8DBQFFcy3CW82GfkQfsqIRAiC8AKCTzfTu+PzDnOfKVGJP9e2FsKVargCfb6Y6
WrMXmMmbF/i7fku6QkrWYNc=
=gtEY
-----END PGP SIGNATURE-----

