From: "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: Re: [PATCH] push: add remote.pushThin to control thin pack generation
Date: Thu, 11 Dec 2014 00:43:10 +0000
Message-ID: <20141211004310.GB130424@vauxhall.crustytoothpaste.net>
References: <20141210233443.GA130424@vauxhall.crustytoothpaste.net>
 <1418255389-133205-1-git-send-email-sandals@crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="K8nIJk4ghYZn606h"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 11 01:43:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xyrqk-0006mJ-K5
	for gcvg-git-2@plane.gmane.org; Thu, 11 Dec 2014 01:43:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932937AbaLKAnS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Dec 2014 19:43:18 -0500
Received: from castro.crustytoothpaste.net ([173.11.243.49]:55235 "EHLO
	castro.crustytoothpaste.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932822AbaLKAnR (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 10 Dec 2014 19:43:17 -0500
Received: from vauxhall.crustytoothpaste.net (unknown [IPv6:2001:470:1f05:79:6680:99ff:fe4f:73a0])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by castro.crustytoothpaste.net (Postfix) with ESMTPSA id 3CEDA2808F
	for <git@vger.kernel.org>; Thu, 11 Dec 2014 00:43:14 +0000 (UTC)
Mail-Followup-To: git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <1418255389-133205-1-git-send-email-sandals@crustytoothpaste.net>
X-Machine: Running on vauxhall using GNU/Linux on x86_64 (Linux kernel
 3.17.0-trunk-amd64)
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Spam-Score: -0.272 BAYES_00,RDNS_NONE
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261267>


--K8nIJk4ghYZn606h
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Dec 10, 2014 at 11:49:49PM +0000, brian m. carlson wrote:
> From: "brian m. carlson" <brian.carlson@cpanel.net>
>=20
> Thin packs are enabled when pushing by default, but with a large number
> of refs and a fast network, git may spend more time trying to find a
> good delta than it would spend simply sending data over the network.
> Add a per-remote option, pushThin, that controls the default for pushes
> on that remote.

I just realized this patch doesn't apply outside of the particular repo
I was using.  Consider this more of an RFC, since I'd like to avoid
going this route if possible, in favor of a more robust approach.

> Signed-off-by: brian m. carlson <brian.carlson@cpanel.net>
> ---
>  SOURCES/git/Documentation/config.txt | 6 ++++++
>  SOURCES/git/builtin/push.c           | 6 ++++--
>  SOURCES/git/remote.c                 | 3 +++
>  SOURCES/git/remote.h                 | 1 +
>  SOURCES/git/transport.c              | 2 ++
>  5 files changed, 16 insertions(+), 2 deletions(-)
>=20
> diff --git a/SOURCES/git/Documentation/config.txt b/SOURCES/git/Documenta=
tion/config.txt
> index 9220725..7fededd 100644
> --- a/SOURCES/git/Documentation/config.txt
> +++ b/SOURCES/git/Documentation/config.txt
> @@ -2178,6 +2178,12 @@ remote.<name>.push::
>  	The default set of "refspec" for linkgit:git-push[1]. See
>  	linkgit:git-push[1].
> =20
> +remote.<name>.pushThin::
> +	If true (the default), pass the \--thin option to
> +	linkgit:git-pack-objects[1] during push.  This results in a smaller
> +	pack being sent and can improve push time over slow networks.  Over
> +	fast networks, setting this value to false may improve performance.
> +
>  remote.<name>.mirror::
>  	If true, pushing to this remote will automatically behave
>  	as if the `--mirror` option was given on the command line.
> diff --git a/SOURCES/git/builtin/push.c b/SOURCES/git/builtin/push.c
> index a076b19..ae39677 100644
> --- a/SOURCES/git/builtin/push.c
> +++ b/SOURCES/git/builtin/push.c
> @@ -15,7 +15,7 @@ static const char * const push_usage[] =3D {
>  	NULL,
>  };
> =20
> -static int thin =3D 1;
> +static int thin =3D -1;
>  static int deleterefs;
>  static const char *receivepack;
>  static int verbosity;
> @@ -347,7 +347,9 @@ static int push_with_options(struct transport *transp=
ort, int flags)
>  	if (receivepack)
>  		transport_set_option(transport,
>  				     TRANS_OPT_RECEIVEPACK, receivepack);
> -	transport_set_option(transport, TRANS_OPT_THIN, thin ? "yes" : NULL);
> +
> +	if (thin !=3D -1)
> +		transport_set_option(transport, TRANS_OPT_THIN, thin ? "yes" : NULL);
> =20
>  	if (!is_empty_cas(&cas)) {
>  		if (!transport->smart_options)
> diff --git a/SOURCES/git/remote.c b/SOURCES/git/remote.c
> index f624217..54777cb 100644
> --- a/SOURCES/git/remote.c
> +++ b/SOURCES/git/remote.c
> @@ -175,6 +175,7 @@ static struct remote *make_remote(const char *name, i=
nt len)
> =20
>  	ret =3D xcalloc(1, sizeof(struct remote));
>  	ret->prune =3D -1;  /* unspecified */
> +	ret->push_thin =3D 1; /* default on */
>  	ALLOC_GROW(remotes, remotes_nr + 1, remotes_alloc);
>  	remotes[remotes_nr++] =3D ret;
>  	ret->name =3D xstrndup(name, len);
> @@ -445,6 +446,8 @@ static int handle_config(const char *key, const char =
*value, void *cb)
>  		if (git_config_string(&v, key, value))
>  			return -1;
>  		add_push_refspec(remote, v);
> +	} else if (!strcmp(subkey, ".pushthin")) {
> +		remote->push_thin =3D git_config_bool(key, value);
>  	} else if (!strcmp(subkey, ".fetch")) {
>  		const char *v;
>  		if (git_config_string(&v, key, value))
> diff --git a/SOURCES/git/remote.h b/SOURCES/git/remote.h
> index 8b62efd..badf266 100644
> --- a/SOURCES/git/remote.h
> +++ b/SOURCES/git/remote.h
> @@ -46,6 +46,7 @@ struct remote {
>  	int skip_default_update;
>  	int mirror;
>  	int prune;
> +	int push_thin;
> =20
>  	const char *receivepack;
>  	const char *uploadpack;
> diff --git a/SOURCES/git/transport.c b/SOURCES/git/transport.c
> index 70d38e4..2f495fa 100644
> --- a/SOURCES/git/transport.c
> +++ b/SOURCES/git/transport.c
> @@ -987,6 +987,8 @@ struct transport *transport_get(struct remote *remote=
, const char *url)
>  			ret->smart_options->receivepack =3D remote->receivepack;
>  	}
> =20
> +	transport_set_option(ret, TRANS_OPT_THIN, remote->push_thin ? "yes" : N=
ULL);
> +
>  	return ret;
>  }
> =20
> --=20
> 2.2.0
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe git" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--=20
brian m. carlson / brian with sandals: Houston, Texas, US
+1 832 623 2791 | http://www.crustytoothpaste.net/~bmc | My opinion only
OpenPGP: RSA v4 4096b: 88AC E9B2 9196 305B A994 7552 F1BA 225C 0223 B187

--K8nIJk4ghYZn606h
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBCgAGBQJUiOieAAoJEL9TXYEfUvaLdwQP/1Tr2hvAi/n3oUer8OYkVdJr
BNBPfwpSknTrJEzvbM7Bidg8oY51IrHV6aWJk2ST0VBgPzgXiRGvoF95P3zWJENq
xtT1HwjAN8dGNxhoCI7j3yPSzp75PyIXmMOlXZXulekQiFhus74kNq0uYJDZgaDR
pbKyBeFNLVqftOu60GptDO6+7R10w3SeNMtmBzZebQWHhHvCBqNtAYkIMa9uruR2
YPsYtGT7zwI/QM21RNB1qnqoZvm65MgdhtdniMGU6m22TpkF2JmAhlf1tSWajYdP
Y7eqjSWDVN18z9+9vatUy0iQ2b2HaA7OINg/9dpmeLjGQxMLXKU1vYOiiFxW+Q4Q
yrKnX2plwMBvqW9K+ian6N+aILTRVjdMZMI599NwxzxEj3rBXqAuBhqsBzO9EWa7
EOJuatF7cXJCtV1RX4GxIdMUFOKHYzU2v6KzctbgoRoco0L+I2oVUwjC0WMPvwGb
YGiDL6ak4mSnymAE2yGecTYo6w1YbECitP8onf14wBDSWv3XUBoMGGe2qAsnsOwA
x+qRyVfS8Ovh2aMvay0MwnIJhA4KSKdFcoVOu9FgLNGgbp/O2nxSvK6hNUJYPcR6
WwbzP2gciHoX3KlEYw63+n6ZgEygy6Lz4E5Eb0629bxaFcWsyTQjC/gpYgZbAxK0
Exc55KZWSqoUnRUw4uDH
=Jfgg
-----END PGP SIGNATURE-----

--K8nIJk4ghYZn606h--
