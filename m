From: Jan Hudec <bulb@ucw.cz>
Subject: Re: [PATCH] add simple install replacement
Date: Fri, 12 Oct 2007 16:06:47 +0200
Message-ID: <20071012140647.GC7865@efreet.light.src>
References: <20071011215237.GI20753@schiele.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="w7PDEPdKQumQfZlR"
Cc: git@vger.kernel.org, gitster@pobox.com
To: Robert Schiele <rschiele@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 12 16:18:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IgLAU-0002DA-N5
	for gcvg-git-2@gmane.org; Fri, 12 Oct 2007 16:07:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753858AbXJLOHB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Oct 2007 10:07:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753578AbXJLOHB
	(ORCPT <rfc822;git-outgoing>); Fri, 12 Oct 2007 10:07:01 -0400
Received: from ns1.bluetone.cz ([212.158.128.13]:33526 "EHLO ns1.bluetone.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753331AbXJLOG7 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Oct 2007 10:06:59 -0400
Received: from localhost (spamhole.bluetone.cz [192.168.13.2])
	by ns1.bluetone.cz (Postfix) with ESMTP id 98E8E57285;
	Fri, 12 Oct 2007 16:06:58 +0200 (CEST)
Received: from ns1.bluetone.cz ([192.168.13.1])
	by localhost (spamhole.bluetone.cz [192.168.13.2]) (amavisd-new, port 10026)
	with ESMTP id 8dwoYujaIG8F; Fri, 12 Oct 2007 16:06:55 +0200 (CEST)
Received: from efreet.light.src (145-119-207-85.strcechy.adsl-llu.static.bluetone.cz [85.207.119.145])
	by ns1.bluetone.cz (Postfix) with ESMTP id 8C05C57338;
	Fri, 12 Oct 2007 16:06:54 +0200 (CEST)
Received: from bulb by efreet.light.src with local (Exim 4.68)
	(envelope-from <bulb@ucw.cz>)
	id 1IgLA7-0003yL-Ew; Fri, 12 Oct 2007 16:06:47 +0200
Content-Disposition: inline
In-Reply-To: <20071011215237.GI20753@schiele.dyndns.org>
User-Agent: Mutt/1.5.16 (2007-06-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/60689>


--w7PDEPdKQumQfZlR
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 11, 2007 at 23:52:37 +0200, Robert Schiele wrote:
> This patch adds a very simple install replacement script to git.
> This allows more easy installation on systems that don't have a
> compatible install.

Do you have a particular case where you need it?

> Signed-off-by: Robert Schiele <rschiele@gmail.com>
> ---
>  gitinstall |   35 +++++++++++++++++++++++++++++++++++
>  1 files changed, 35 insertions(+), 0 deletions(-)
>  create mode 100755 gitinstall
>=20
> diff --git a/gitinstall b/gitinstall
> new file mode 100755
> index 0000000..8b346d6
> --- /dev/null
> +++ b/gitinstall
> @@ -0,0 +1,35 @@
> +#!/bin/sh
> +
> +MKDIRMODE=3D0
> +MODE=3D755
> +while getopts 'dm:' FLAG; do

No such thing here:
zsh$ /bin/sh
$ which getopts
$

Yes, bash and zsh do have that, but my (and I suspect many git users')
/bin/sh is neither of those. Git scripts should use just POSIX shell
features for portability.

Which is particularly important when you are trying to replace a common
utility, because the systems that won't have it are likely to not have bash
either.

You may want to have a look at /usr/share/automake-1.9/install-sh (or
/usr/share/automake<something>/install-sh). It shows how to portably process
options in shell and since it's in fact covered by the MIT/X license (and F=
SF
changes are public domain), git could just use it if necessary.

> +    case "$FLAG" in
> +        d) MKDIRMODE=3D1;;
> +        m) MODE=3D"$OPTARG";;
> +	*) exit 1;;
> +    esac
> +done
> +if test "$OPTIND" !=3D 1; then
> +    shift `expr $OPTIND - 1`
> +fi
> +if test $MKDIRMODE =3D 1; then
> +    mkdir -p "$@"
> +    chmod "$MODE" "$@"
> +else
> +    if test $# =3D 2 && ! test -d "$2"; then
> +	rm -rf "$2"

Are you sure reall install would do this? The maual (install(1)) states
following usage variants:

    install [OPTION]... [-T] SOURCE DEST
    install [OPTION]... SOURCE... DIRECTORY
    install [OPTION]... -t DIRECTORY SOURCE...
    install [OPTION]... -d DIRECTORY...

Now however there is nothing saying that SOURCE... is at least two, so is

    install git /usr/bin

a case of the first or second usage? I would say the second, but your code
would:

    rm -rf /usr/bin
    cp git /usr/bin

> +	cp "$1" "$2"
> +	chmod "$MODE" "$2"
> +    else
> +	FILES=3D
> +	while test $# !=3D 1; do
> +	    FILES=3D"$FILES $1"
> +	    shift
> +	done
> +	for i in $FILES; do

    touch "foo*bar" "a b c"
    ./gitinstall "b*c" "a b c" /tmp

=2E.. will copy a lot of files to /tmp (presuming we are in git source
directory, where tons of files are called builtin-<something>.c) and compla=
in
that there is no 'a', no 'b' and no 'c'.

> +	    rm -rf "$1/"`basename "$i"`
> +	    cp "$i" "$1"
> +	    chmod "$MODE" "$1/"`basename "$i"`
> +	done
> +    fi
> +fi

--=20
						 Jan 'Bulb' Hudec <bulb@ucw.cz>

--w7PDEPdKQumQfZlR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFHD393Rel1vVwhjGURAvaLAJ4lJVWb/2jdS+4YvXOn6X4uHstTlQCfbNwu
nok5dhIdmVJZG56fmi43UGg=
=Qu4w
-----END PGP SIGNATURE-----

--w7PDEPdKQumQfZlR--
