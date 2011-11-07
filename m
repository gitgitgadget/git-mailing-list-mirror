From: Andre Noll <maan@systemlinux.org>
Subject: git fsck: failed to apply delta
Date: Mon, 7 Nov 2011 15:25:37 +0100
Message-ID: <20111107142537.GD13394@systemlinux.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="6WlEvdN9Dv0WHSBl"
Cc: git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Mon Nov 07 15:31:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RNQEE-0005aC-I2
	for gcvg-git-2@lo.gmane.org; Mon, 07 Nov 2011 15:31:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754361Ab1KGObJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Nov 2011 09:31:09 -0500
Received: from systemlinux.org ([79.140.41.46]:52812 "EHLO
	v3-1046.systemlinux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751676Ab1KGObI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Nov 2011 09:31:08 -0500
X-Greylist: delayed 434 seconds by postgrey-1.27 at vger.kernel.org; Mon, 07 Nov 2011 09:31:08 EST
Received: by v3-1046.systemlinux.org (Postfix, from userid 1002)
	id DEB30308444; Mon,  7 Nov 2011 15:25:37 +0100 (CET)
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184985>


--6WlEvdN9Dv0WHSBl
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi

I'm getting this when running git fsck or git repack against a large
(21G) repo which was created from subversion using git svn clone:

	fatal: failed to apply delta

The debugging patch below indicates that this repo fails the sanity
check for the size in patch_delta(). With this patch applied I'm
getting the following additional output

	error: bad delta header size, expected: 236, have 1994568

This is 100% reproducible. I'm using the git master branch as of
today (5ae0f681) but the same problem showed up also with an older
git version.

Does anybody know what's going on here?

Thanks
Andre
---

diff --git a/patch-delta.c b/patch-delta.c
index 56e0a5e..cff4d79 100644
--- a/patch-delta.c
+++ b/patch-delta.c
@@ -28,8 +28,10 @@ void *patch_delta(const void *src_buf, unsigned long src=
_size,
=20
 	/* make sure the orig file size matches what we expect */
 	size =3D get_delta_hdr_size(&data, top);
-	if (size !=3D src_size)
+	if (size !=3D src_size) {
+		error("bad delta header size, expected: %lu, have %lu", src_size, size);
 		return NULL;
+	}
=20
 	/* now the result size */
 	size =3D get_delta_hdr_size(&data, top);
--=20
The only person who always got his work done by Friday was Robinson Crusoe

--6WlEvdN9Dv0WHSBl
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.10 (GNU/Linux)

iEYEARECAAYFAk636mEACgkQWto1QDEAkw8AOgCfdNAoRdDcSwYSwxBsuhQeXPuD
ZsoAoJU0Ka12y5f0j8/3ZYkxnP/NX/mo
=gL1h
-----END PGP SIGNATURE-----

--6WlEvdN9Dv0WHSBl--
