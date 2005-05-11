From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: [PATCH Cogito] match pathnames in exclude handling
Date: Wed, 11 May 2005 07:25:46 +0200
Message-ID: <20050511052546.GC11192@kiste.smurf.noris.de>
References: <pan.2005.05.10.03.41.15.683163@smurf.noris.de> <428043EB.7010004@didntduck.org> <20050510075227.GA8176@lug-owl.de> <20050510080445.GB8176@lug-owl.de> <7vis1rpi8a.fsf@assigned-by-dhcp.cox.net> <20050510093212.GD8176@lug-owl.de> <20050510093924.GH11221@kiste.smurf.noris.de> <20050510094538.GE8176@lug-owl.de> <20050510095825.GI11221@kiste.smurf.noris.de> <4281281F.6000101@cobite.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="CdrF4e02JqNVZeln"
Cc: Jan-Benedict Glaw <jbglaw@lug-owl.de>,
	Junio C Hamano <junkio@cox.net>,
	Brian Gerst <bgerst@didntduck.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 11 07:19:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DVjcw-0001NW-2i
	for gcvg-git@gmane.org; Wed, 11 May 2005 07:19:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261877AbVEKF0s (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 11 May 2005 01:26:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261881AbVEKF0r
	(ORCPT <rfc822;git-outgoing>); Wed, 11 May 2005 01:26:47 -0400
Received: from run.smurf.noris.de ([192.109.102.41]:60894 "EHLO
	server.smurf.noris.de") by vger.kernel.org with ESMTP
	id S261877AbVEKF0n (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 May 2005 01:26:43 -0400
Received: from kiste.smurf.noris.de ([192.109.102.35] ident=mail)
	by server.smurf.noris.de with smtp (Exim 4.50)
	id 1DVjj9-0000vL-34; Wed, 11 May 2005 07:25:56 +0200
Received: (nullmailer pid 29730 invoked by uid 501);
	Wed, 11 May 2005 05:25:46 -0000
To: David Mansfield <david@cobite.com>
Content-Disposition: inline
In-Reply-To: <4281281F.6000101@cobite.com>
User-Agent: Mutt/1.5.6+20040907i
X-Smurf-Spam-Score: -2.5 (--)
X-Smurf-Whitelist: +relay_from_hosts
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


--CdrF4e02JqNVZeln
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

David Mansfield:
> Is there/will there be support for path matching in the ignore files?
>=20
> If the answer is no, but people like the idea, I could look into it.
>=20
I already did, last week. (I do need to cleanup my changes...)

The idea is that "foo" matches anywhere, "foo/bar" the exact pathname.
As a special case, "./foo" matches in the root directory only.

NB: "*" can cross subdirectory paths, so "*/foo/bar" does match
"a/b/c/foo/bar".

Signed-Off-By: Matthias Urlichs <smurf@smurf.noris.de>

---
Index: ls-files.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- 972d8624458936868e6f392b40858b7c362af8cd/ls-files.c  (mode:100644)
+++ 12deb13b12cdb338fe3fdc2e77a024490d6c39ea/ls-files.c  (mode:100644)
@@ -80,9 +80,17 @@
 	if (nr_excludes) {
 		const char *basename =3D strrchr(pathname, '/');
 		basename =3D (basename) ? basename+1 : pathname;
-		for (i =3D 0; i < nr_excludes; i++)
-			if (fnmatch(excludes[i], basename, 0) =3D=3D 0)
-				return 1;
+		for (i =3D 0; i < nr_excludes; i++) {
+			if (excludes[i][0] !=3D '.' || excludes[i][1] !=3D '/') {
+				if (fnmatch(excludes[i], pathname, 0) =3D=3D 0)
+					return 1;
+				if (basename !=3D pathname && fnmatch(excludes[i], pathname, 0) =3D=3D=
 0)
+					return 1;
+			} else {
+				if (fnmatch(excludes[i]+2, pathname, 0) =3D=3D 0)
+					return 1;
+			}
+		}
 	}
 	return 0;
 }
@@ -129,10 +137,10 @@
=20
 			if (de->d_name[0] =3D=3D '.')
 				continue;
-			if (excluded(de->d_name) !=3D show_ignored)
-				continue;
 			len =3D strlen(de->d_name);
 			memcpy(fullname + baselen, de->d_name, len+1);
+			if (excluded(fullname) !=3D show_ignored)
+				continue;
=20
 			switch (DTYPE(de)) {
 			struct stat st;
--=20
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de

--CdrF4e02JqNVZeln
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.0 (GNU/Linux)

iD8DBQFCgZda8+hUANcKr/kRAk3KAKCVYkXgesDpLQLHvJPws0e7pEjRSgCgoyHU
VS1bSyesq8BVU96++hUK9Us=
=jiYZ
-----END PGP SIGNATURE-----

--CdrF4e02JqNVZeln--
