From: Sergey Vlasov <vsu@altlinux.ru>
Subject: [PATCH] Plug memory leaks in git-unpack-objects
Date: Wed, 3 Aug 2005 16:11:00 +0400
Message-ID: <20050803121100.GD11605@procyon.home>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="MAH+hnPXVZWQ5cD/"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 03 14:21:36 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E0IDC-00019U-P2
	for gcvg-git@gmane.org; Wed, 03 Aug 2005 14:19:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262264AbVHCMOF (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 3 Aug 2005 08:14:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262262AbVHCMNs
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Aug 2005 08:13:48 -0400
Received: from mail.murom.net ([213.177.124.17]:17870 "EHLO ns1.murom.ru")
	by vger.kernel.org with ESMTP id S262220AbVHCMLi (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 3 Aug 2005 08:11:38 -0400
Received: from [172.17.7.8] (helo=procyon.home)
	by ns1.murom.ru with esmtp (Exim 4.42)
	id 1E0I5r-0006sf-SQ; Wed, 03 Aug 2005 16:11:31 +0400
Received: by procyon.home (Postfix, from userid 500)
	id 30371E49D62; Wed,  3 Aug 2005 16:11:00 +0400 (MSD)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org


--MAH+hnPXVZWQ5cD/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

- Call inflateEnd to release zlib state after use.
- After resolving delta, free base object data.

Signed-off-by: Sergey Vlasov <vsu@altlinux.ru>
---

 unpack-objects.c |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

890ab530c0c0aad5c070690498d3b1254c7a30bc
diff --git a/unpack-objects.c b/unpack-objects.c
--- a/unpack-objects.c
+++ b/unpack-objects.c
@@ -75,6 +75,7 @@ static void *get_data(unsigned long size
 		stream.next_in =3D fill(1);
 		stream.avail_in =3D len;
 	}
+	inflateEnd(&stream);
 	return buf;
 }
=20
@@ -167,6 +168,7 @@ static int unpack_delta_entry(unsigned l
 	unsigned long base_size;
 	char type[20];
 	unsigned char base_sha1[20];
+	int result;
=20
 	memcpy(base_sha1, fill(20), 20);
 	use(20);
@@ -184,7 +186,9 @@ static int unpack_delta_entry(unsigned l
 	base =3D read_sha1_file(base_sha1, type, &base_size);
 	if (!base)
 		die("failed to read delta-pack base object %s", sha1_to_hex(base_sha1));
-	return resolve_delta(type, base, base_size, delta_data, delta_size);
+	result =3D resolve_delta(type, base, base_size, delta_data, delta_size);
+	free(base);
+	return result;
 }
=20
 static void unpack_one(unsigned nr, unsigned total)

--MAH+hnPXVZWQ5cD/
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.5 (GNU/Linux)

iD8DBQFC8LRUW82GfkQfsqIRAulwAJ45AySeV2w2yXC7N0ete5AeU5CJ8QCbB6+A
nHbsaQ9ixdCTlZfJ2y7QN/0=
=gwth
-----END PGP SIGNATURE-----

--MAH+hnPXVZWQ5cD/--
