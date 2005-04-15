From: Martin Schlemmer <azarah@nosferatu.za.org>
Subject: Re: [patch pasky 1/2] fix various issues in gitapply.sh (basically
	did not handle add/del/cm at all)
Date: Fri, 15 Apr 2005 11:31:38 +0200
Message-ID: <1113557498.23299.167.camel@nosferatu.lan>
References: <1113557318.23299.165.camel@nosferatu.lan>
Reply-To: azarah@nosferatu.za.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-ZqQQopft9VGT9E082q4g"
Content-Transfer-Encoding: 8bit
Cc: Petr Baudis <pasky@ucw.cz>
X-From: git-owner@vger.kernel.org Fri Apr 15 11:25:45 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMN4T-0003Dd-2Y
	for gcvg-git@gmane.org; Fri, 15 Apr 2005 11:25:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261780AbVDOJ2c (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 15 Apr 2005 05:28:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261781AbVDOJ2c
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Apr 2005 05:28:32 -0400
Received: from ctb-mesg7.saix.net ([196.25.240.79]:11501 "EHLO
	ctb-mesg7.saix.net") by vger.kernel.org with ESMTP id S261780AbVDOJ2S
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Apr 2005 05:28:18 -0400
Received: from gateway.lan (wblv-146-239-208.telkomadsl.co.za [165.146.239.208])
	by ctb-mesg7.saix.net (Postfix) with ESMTP id 7E1C316B67;
	Fri, 15 Apr 2005 11:27:48 +0200 (SAST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by gateway.lan (Postfix) with ESMTP id CF32C3A26DB;
	Fri, 15 Apr 2005 11:33:54 +0200 (SAST)
Received: from gateway.lan ([127.0.0.1])
 by localhost (gateway.lan [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 02503-05; Fri, 15 Apr 2005 11:33:49 +0200 (SAST)
Received: from nosferatu.lan (nosferatu.lan [192.168.0.2])
	(using TLSv1 with cipher IDEA-CBC-SHA (128/128 bits))
	(No client certificate requested)
	by gateway.lan (Postfix) with ESMTP id BC6743A26DA;
	Fri, 15 Apr 2005 11:33:49 +0200 (SAST)
To: GIT Mailing Lists <git@vger.kernel.org>
In-Reply-To: <1113557318.23299.165.camel@nosferatu.lan>
X-Mailer: Evolution 2.2.1.1 
X-Virus-Scanned: by amavisd-new using ClamAV at nosferatu.za.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


--=-ZqQQopft9VGT9E082q4g
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

PS: forget the '1/2' in the topic, i did it slightly different which
required changes to gettrack.sh, etc, but to got getmerge.sh, and saw my
short sightedness.

On Fri, 2005-04-15 at 11:28 +0200, Martin Schlemmer wrote:
> Hi,
>=20
> The egrep regex should not escape the '{' and '}', and also add a check
> for ' \t' so that we do not pickup stuff like '+----', etc.  Fix typo in
> assignment.  Check if file exists in new tree before adding/removing
> (might add support for this lowlevel to increase speed?).  Fix typo in
> line removing temp files.
>=20
> Signed-off-by: Martin Schlemmer <azarah@gentoo.org>
>=20
> gitapply.sh:  47b9346d2679b1bf34220fe4502f15c7d0737b0c
> --- 47b9346d2679b1bf34220fe4502f15c7d0737b0c/gitapply.sh
> +++ uncommitted/gitapply.sh
> @@ -19,15 +19,22 @@
>  # just handle it all ourselves.
>  patch -p1 -N <$patchfifo &
>=20
> -tee $patchfifo | egrep '^[+-]\{3\}' | {
> +exits_in_cache() {
> +       for x in $(ls-tree "$1"); do
> +               [ "$x" =3D "$2" ] && return 0
> +       done
> +       return 1
> +}
> +
> +tee $patchfifo | egrep '^[+-]{3}[ \t]' | {
>         victim=3D
>         origmode=3D
>=20
>         while read sign file attrs; do
> -               echo $sign $file $attrs ... >&2
> +#              echo $sign $file $attrs ... >&2
>                 case $sign in
>                 "---")
> -                       victim=3Dfile
> +                       victim=3D$file
>                         mode=3D$(echo $attrs | sed 's/.*mode:[0-7]*\([0-7=
]\{3\}\).*/\1/')
>                         origmode=3D
>                         [ "$mode" !=3D "$attrs" ] && origmode=3D$mode
> @@ -35,14 +42,19 @@
>                 "+++")
>                         if [ "$file" =3D "/dev/null" ]; then
>                                 torm=3D$(echo "$victim" | sed 's/[^\/]*\/=
//') #-p1
> -                               echo -ne "rm\0$torm\0"
> +                               tree=3D$(echo $attrs | sed 's/.*tree:\([0=
-9a-f]\{40\}\).*/\1/')
> +                               exits_in_cache "$tree" "$torm" && echo -n=
e "rm\0$torm\0"
>                                 continue
>                         elif [ "$victim" =3D "/dev/null" ]; then
> -                               echo -ne "add\0$file\0"
> +                               toadd=3D$(echo "$file" | sed 's/[^\/]*\//=
/') #-p1
> +                               tree=3D$(echo "$file" | sed -e 's/\([^\/]=
*\)\/.*/\1/')
> +                               exits_in_cache "$tree" "$toadd" || echo -=
ne "add\0$toadd\0"
>                         fi
>                         mode=3D$(echo $attrs | sed 's/.*mode:[0-7]*\([0-7=
]\{3\}\).*/\1/')
>                         if [ "$mode" ] && [ "$mode" !=3D "$attrs" ] && [ =
"$origmode" !=3D "$mode" ]; then
> -                               echo -ne "cm\0$mode\0$file\0"
> +                               tochmod=3D$(echo "$file" | sed 's/[^\/]*\=
///') #-p1
> +                               # need a space else numbers gets converte=
d
> +                               echo -ne "cm\0 $mode\0$tochmod\0"
>                         fi
>                         ;;
>                 *)
> @@ -74,4 +86,4 @@
>  done
>  ' padding
>=20
> -rm $pathfifo $todo $gonefile
> +rm $patchfifo $todo $gonefile
>=20
>=20
--=20
Martin Schlemmer


--=-ZqQQopft9VGT9E082q4g
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQBCX4n6qburzKaJYLYRAvVWAJ4z8uhZi68q6WjvDk0w+C+kB+lsNACgndI7
IKYONU9BvRM0fU82HFyavnU=
=XGkr
-----END PGP SIGNATURE-----

--=-ZqQQopft9VGT9E082q4g--

