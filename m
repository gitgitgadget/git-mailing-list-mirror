From: Dmitry Potapov <dpotapov@gmail.com>
Subject: [PATCH] preserve executable bits in zip archives
Date: Sun, 16 Sep 2007 21:07:38 +0400
Message-ID: <20070916170738.GA30175@potapov>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EeQfGwPcQSOJBaQU"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Sep 16 19:15:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IWxij-0005qJ-5N
	for gcvg-git-2@gmane.org; Sun, 16 Sep 2007 19:15:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753246AbXIPRPk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Sep 2007 13:15:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753185AbXIPRPk
	(ORCPT <rfc822;git-outgoing>); Sun, 16 Sep 2007 13:15:40 -0400
Received: from smtp05.mtu.ru ([62.5.255.52]:56924 "EHLO smtp05.mtu.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753055AbXIPRPj (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Sep 2007 13:15:39 -0400
X-Greylist: delayed 474 seconds by postgrey-1.27 at vger.kernel.org; Sun, 16 Sep 2007 13:15:39 EDT
Received: from potapov.private (ppp85-141-191-134.pppoe.mtu-net.ru [85.141.191.134])
	by smtp05.mtu.ru (Postfix) with ESMTP id 487253BF818
	for <git@vger.kernel.org>; Sun, 16 Sep 2007 21:07:39 +0400 (MSD)
Received: from potapov.private (localhost [127.0.0.1])
	by potapov.private (8.13.8/8.13.8/Debian-3) with ESMTP id l8GH7dMT030280
	for <git@vger.kernel.org>; Sun, 16 Sep 2007 21:07:39 +0400
Received: (from dpotapov@localhost)
	by potapov.private (8.13.8/8.13.8/Submit) id l8GH7cr8030279
	for git@vger.kernel.org; Sun, 16 Sep 2007 21:07:38 +0400
X-Authentication-Warning: potapov.private: dpotapov set sender to dpotapov@gmail.com using -f
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58324>


--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Correct `git-archive --format=3Dzip' command to preserve executable bits in
zip archives.

---
 archive-zip.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/archive-zip.c b/archive-zip.c
index 444e162..5f9b7e6 100644
--- a/archive-zip.c
+++ b/archive-zip.c
@@ -191,7 +191,8 @@ static int write_zip_entry(const unsigned char *sha1,
 		compressed_size =3D 0;
 	} else if (S_ISREG(mode) || S_ISLNK(mode)) {
 		method =3D 0;
-		attr2 =3D S_ISLNK(mode) ? ((mode | 0777) << 16) : 0;
+		attr2 =3D S_ISLNK(mode) ? ((mode | 0777) << 16) :=20
+			(mode & 0111) ? ((mode) << 16) : 0;
 		if (S_ISREG(mode) && zlib_compression_level !=3D 0)
 			method =3D 8;
 		result =3D 0;
@@ -229,7 +230,8 @@ static int write_zip_entry(const unsigned char *sha1,
 	}
=20
 	copy_le32(dirent.magic, 0x02014b50);
-	copy_le16(dirent.creator_version, S_ISLNK(mode) ? 0x0317 : 0);
+	copy_le16(dirent.creator_version,
+		S_ISLNK(mode) || (S_ISREG(mode) && (mode & 0111)) ? 0x0317 : 0);
 	copy_le16(dirent.version, 10);
 	copy_le16(dirent.flags, 0);
 	copy_le16(dirent.compression_method, method);
--=20
1.5.3.1


--EeQfGwPcQSOJBaQU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFG7WLaDZYoqjZ/Cn0RArMiAJ4/Fd4eYlZwrsVpTXsP0ZL7BA3+OwCeJki/
5UOOl1TXh3E/daZkVeuKLJY=
=c+3L
-----END PGP SIGNATURE-----

--EeQfGwPcQSOJBaQU--
