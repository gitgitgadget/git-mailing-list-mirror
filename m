From: =?iso-8859-1?Q?J=F6rg?= Sommer <joerg@alea.gnuu.de>
Subject: git doesn't finds the parent of a commit (was: How to fetch
	missing pack)
Date: Sun, 27 Apr 2008 12:47:04 +0200
Message-ID: <20080427104704.GA11784@alea.gnuu.de>
References: <slrng019fg.nd8.joerg@alea.gnuu.de> <20080413094131.GA9437@xp.machine.xx> <slrng0v8h8.ujv.joerg@alea.gnuu.de> <200804240801.13674.chriscool@tuxfamily.org> <20080424060857.GX29771@spearce.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="a8Wt8u1KmwUX3Y2C"
Cc: Christian Couder <chriscool@tuxfamily.org>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Apr 27 12:50:14 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jq4SU-0004Jl-7L
	for gcvg-git-2@gmane.org; Sun, 27 Apr 2008 12:50:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753272AbYD0Kt1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Apr 2008 06:49:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753232AbYD0Kt0
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Apr 2008 06:49:26 -0400
Received: from banki.eumelnet.de ([83.246.114.63]:3221 "EHLO uucp.gnuu.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752863AbYD0Kt0 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Apr 2008 06:49:26 -0400
Received: by uucp.gnuu.de (Postfix, from userid 10)
	id 40A40488064; Sun, 27 Apr 2008 12:49:24 +0200 (CEST)
Received: from ibook.localnet ([192.168.0.5] helo=alea.gnuu.de)
	by alea.gnuu.de with esmtp (Exim 4.63)
	(envelope-from <joerg@alea.gnuu.de>)
	id 1Jq4PQ-0007Uj-9g; Sun, 27 Apr 2008 12:47:04 +0200
Received: from joerg by alea.gnuu.de with local (Exim 4.69)
	(envelope-from <joerg@alea.gnuu.de>)
	id 1Jq4PQ-00034M-BX; Sun, 27 Apr 2008 12:47:04 +0200
Content-Disposition: inline
In-Reply-To: <20080424060857.GX29771@spearce.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80438>


--a8Wt8u1KmwUX3Y2C
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

Shawn O. Pearce schrieb am Thu 24. Apr, 02:08 (-0400):
> If you know the name of the objects you are missing, you can
> make a temporary pack to transfer the list of objects:
>=20
> 	# at good repo
> 	#
> 	git pack-objects --stdout <object.list >save.pack
>=20
> 	# at bad repo
> 	#
> 	git index-pack --stdin <save.pack

I didn't know the list of objects I'm missing, but I used this little
script do find them:

anchor=3D7cb192eab0251911e2ca77d4ecceb621dd2d34f5
while true
do
    outp=3D$(git log --pretty=3Draw --raw $anchor 2>&1 >/dev/null)
    echo $outp
    [ $#outp -eq 0 ] && break
    cmt=3D${${outp##* \(}%\)}
    git cat-file -t $cmt >/dev/null 2>&1 && \
      cmt=3D$(git cat-file commit $cmt |grep '^tree ')
    echo ${cmt##* } | ssh server cd git\; git pack-objects --stdout | \
      git index-pack --stdin >/dev/null
done

Maybe it helps someone else. :)

But now, there's something else broken.

% git cat-file commit b63e99500137c913bd801a2f22b6cf88c63b95c5
tree 68a58fb97935f35c6fb7bcbcfed73b1697db000a
parent 3f061887c562b20d3ed3d1f764462cf986a1ad12
author Wincent Colaiuta <win@wincent.com> 1195996542 +0100
committer Junio C Hamano <gitster@pobox.com> 1196019475 -0800

Add "--patch" option to git-add--interactive

When the "--patch" option is supplied, the patch_update_cmd() function is
=E2=80=A6

% git cat-file commit 3f061887c562b20d3ed3d1f764462cf986a1ad12
tree 636a0f9c085aac7ba539ef2ace03b3081481891a
parent 324ccbd6a09816af830b22b02bbeb06349141849
author Junio C Hamano <gitster@pobox.com> 1196014210 -0800
committer Junio C Hamano <gitster@pobox.com> 1196014993 -0800

add -i: Fix running from a subdirectory

This fixes the pathspec interactive_add() passes to the underlying
=E2=80=A6

% git rev-parse b63e99500137c913bd801a2f22b6cf88c63b95c5~1
b63e99500137c913bd801a2f22b6cf88c63b95c5~1
fatal: ambiguous argument 'b63e99500137c913bd801a2f22b6cf88c63b95c5~1': unk=
nown revision or path not in the working tree.
Use '--' to separate paths from revisions

Can someone tell me what I'm doing wrong?

> Note that you may need to do this several times; e.g. if you are
> missing a tree you won't know what blobs you are missing until
> you load the tree and run fsck --full again to parse the tree and
> discover the missing blobs.

fsck --full reports only dangling objects, no breakage.

Bye, J=C3=B6rg.
--=20
Die zehn Gebote Gottes enthalten 172 W=C3=B6rter, die amerikanische
Unabh=C3=A4ngigkeitserkl=C3=A4rung 300 W=C3=B6rter, die Verordnung der euro=
p=C3=A4ischen
Gemeinschaft =C3=BCber den Import von Karamelbonbons exakt 25911 W=C3=B6rte=
r.

--a8Wt8u1KmwUX3Y2C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature http://en.wikipedia.org/wiki/OpenPGP
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFIFFmowe0mZwH1VIARAqUZAKDAZKDjQ+jnB1PZ5H0tJ4H4Y1MuFQCeKnyp
v/oOMwyVRZNwquTrkJKjdXI=
=NyP8
-----END PGP SIGNATURE-----

--a8Wt8u1KmwUX3Y2C--
