From: Pierre Habouzit <madcoder@debian.org>
Subject: Re: [PATCH] git-revert is one of the most misunderstood command in git, help users out.
Date: Mon, 05 Nov 2007 20:04:11 +0100
Message-ID: <20071105190411.GG6205@artemis.corp>
References: <1194289301-7800-1-git-send-email-madcoder@debian.org>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="OFj+1YLvsEfSXdCH";
	protocol="application/pgp-signature"; micalg=SHA1
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Nov 05 20:04:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ip7FV-0006rN-Kf
	for gcvg-git-2@gmane.org; Mon, 05 Nov 2007 20:04:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754758AbXKETEQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Nov 2007 14:04:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754733AbXKETEP
	(ORCPT <rfc822;git-outgoing>); Mon, 5 Nov 2007 14:04:15 -0500
Received: from pan.madism.org ([88.191.52.104]:58925 "EHLO hermes.madism.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752096AbXKETEM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Nov 2007 14:04:12 -0500
Received: from madism.org (unknown [81.57.219.236])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "artemis.madism.org", Issuer "madism.org" (not verified))
	by hermes.madism.org (Postfix) with ESMTP id A36C12894C;
	Mon,  5 Nov 2007 20:04:11 +0100 (CET)
Received: by madism.org (Postfix, from userid 1000)
	id 5754920E809; Mon,  5 Nov 2007 20:04:11 +0100 (CET)
Mail-Followup-To: Pierre Habouzit <madcoder@debian.org>, gitster@pobox.com,
	git@vger.kernel.org
Content-Disposition: inline
In-Reply-To: <1194289301-7800-1-git-send-email-madcoder@debian.org>
X-Face: $(^e[V4D-[`f2EmMGz@fgWK!e.B~2g.{08lKPU(nc1J~z\4B>*JEVq:E]7G-\6$Ycr4<;Z!|VY6Grt]+RsS$IMV)f>2)M="tY:ZPcU;&%it2D81X^kNya0=L]"vZmLP+UmKhgq+u*\.dJ8G!N&=EvlD
User-Agent: Madmutt/devel (Linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/63535>


--OFj+1YLvsEfSXdCH
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 05, 2007 at 07:01:41PM +0000, Pierre Habouzit wrote:
> When git-revert has a file argument then redirect the user to what he
> probably meant.
>=20
> Signed-off-by: Pierre Habouzit <madcoder@debian.org>
> ---
>  builtin-revert.c |   24 +++++++++++++++++-------
>  gitk             |    2 +-
>  2 files changed, 18 insertions(+), 8 deletions(-)
>=20
> diff --git a/builtin-revert.c b/builtin-revert.c
> index 62ab1fa..9660048 100644
> --- a/builtin-revert.c
> +++ b/builtin-revert.c
> @@ -38,7 +38,7 @@ static const char *me;
> =20
>  #define GIT_REFLOG_ACTION "GIT_REFLOG_ACTION"
> =20
> -static void parse_args(int argc, const char **argv)
> +static void parse_args(int argc, const char **argv, const char *prefix)
>  {
>  	const char * const * usage_str =3D
>  		action =3D=3D REVERT ?  revert_usage : cherry_pick_usage;
> @@ -58,8 +58,18 @@ static void parse_args(int argc, const char **argv)
>  		usage_with_options(usage_str, options);
>  	arg =3D argv[0];
> =20
> -	if (get_sha1(arg, sha1))
> -		die ("Cannot find '%s'", arg);
> +	if (get_sha1(arg, sha1)) {
> +		struct stat st;
> +		const char *name;
> +
> +		name =3D prefix ? prefix_filename(prefix, strlen(prefix), arg) : arg;
> +		if (!lstat(name, &st)) {
> +			die("Cannot find commit '%s', did you meant: "
> +				"git checkout HEAD -- '%s'", arg, arg);
> +		} else {
> +			die("Cannot find commit '%s'", arg);
> +		}
> +	}
>  	commit =3D (struct commit *)parse_object(sha1);
>  	if (!commit)
>  		die ("Could not find %s", sha1_to_hex(sha1));
> @@ -225,7 +235,7 @@ static int merge_recursive(const char *base_sha1,
>  	return run_command_v_opt(argv, RUN_COMMAND_NO_STDIN | RUN_GIT_CMD);
>  }
> =20
> -static int revert_or_cherry_pick(int argc, const char **argv)
> +static int revert_or_cherry_pick(int argc, const char **argv, const char=
 *prefix)
>  {
>  	unsigned char head[20];
>  	struct commit *base, *next, *parent;
> @@ -237,7 +247,7 @@ static int revert_or_cherry_pick(int argc, const char=
 **argv)
>  	git_config(git_default_config);
>  	me =3D action =3D=3D REVERT ? "revert" : "cherry-pick";
>  	setenv(GIT_REFLOG_ACTION, me, 0);
> -	parse_args(argc, argv);
> +	parse_args(argc, argv, prefix);
> =20
>  	/* this is copied from the shell script, but it's never triggered... */
>  	if (action =3D=3D REVERT && !no_replay)
> @@ -405,12 +415,12 @@ int cmd_revert(int argc, const char **argv, const c=
har *prefix)
>  		edit =3D 1;
>  	no_replay =3D 1;
>  	action =3D REVERT;
> -	return revert_or_cherry_pick(argc, argv);
> +	return revert_or_cherry_pick(argc, argv, prefix);
>  }
> =20
>  int cmd_cherry_pick(int argc, const char **argv, const char *prefix)
>  {
>  	no_replay =3D 0;
>  	action =3D CHERRY_PICK;
> -	return revert_or_cherry_pick(argc, argv);
> +	return revert_or_cherry_pick(argc, argv, prefix);
>  }




> diff --git a/gitk b/gitk
> index 1da0b0a..ab8bab2 100755
> --- a/gitk
> +++ b/gitk
> @@ -1,6 +1,6 @@
>  #!/bin/sh
>  # Tcl ignores the next line -*- tcl -*- \
> -exec wish "$0" -- "$@"
> +exec wish8.5 "$0" -- "$@"
> =20
>  # Copyright (C) 2005-2006 Paul Mackerras.  All rights reserved.
>  # This program is free software; it may be used, copied, modified
> --=20
> 1.5.3.5.1541.gd2b5c-dirty

  F*CK this chunk is obviously spurious.

--=20
=C2=B7O=C2=B7  Pierre Habouzit
=C2=B7=C2=B7O                                                madcoder@debia=
n.org
OOO                                                http://www.madism.org

--OFj+1YLvsEfSXdCH
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHL2krvGr7W6HudhwRAjJVAJ466ta9G0uZDSWdhmeY+Ui22PkmGACgkT2e
GaljP/9GK32hnvfZtzTHwZU=
=PruK
-----END PGP SIGNATURE-----

--OFj+1YLvsEfSXdCH--
