From: Keith Packard <keithp@keithp.com>
Subject: [PATCH] Must not modify the_index.cache as it may be passed to
	realloc at some point.
Date: Tue, 02 Oct 2007 22:44:15 -0700
Message-ID: <1191390255.16292.2.camel@koto.keithp.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-OdHA507jmKX1EnStEeqK"
Cc: keithp@keithp.com
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Oct 03 07:45:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Icx2w-0006wF-NG
	for gcvg-git-2@gmane.org; Wed, 03 Oct 2007 07:45:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751826AbXJCFpP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Oct 2007 01:45:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751857AbXJCFpO
	(ORCPT <rfc822;git-outgoing>); Wed, 3 Oct 2007 01:45:14 -0400
Received: from home.keithp.com ([63.227.221.253]:3434 "EHLO keithp.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751705AbXJCFpN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Oct 2007 01:45:13 -0400
Received: from localhost (localhost [127.0.0.1])
	by keithp.com (Postfix) with ESMTP id 996BA114205
	for <git@vger.kernel.org>; Tue,  2 Oct 2007 22:45:11 -0700 (PDT)
X-Virus-Scanned: Debian amavisd-new at keithp.com
Received: from keithp.com ([127.0.0.1])
	by localhost (keithp.com [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id 2E03B83aSIuA; Tue,  2 Oct 2007 22:45:08 -0700 (PDT)
Received: by keithp.com (Postfix, from userid 1033)
	id 80A5C114204; Tue,  2 Oct 2007 22:45:08 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
	by keithp.com (Postfix) with ESMTP id 6D6051141F7;
	Tue,  2 Oct 2007 22:45:08 -0700 (PDT)
X-Mailer: Evolution 2.12.0 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59791>


--=-OdHA507jmKX1EnStEeqK
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

The index cache is not static, growing as new entries are added. If entries
are added after prune_cache is called, cache will no longer point at the
base of the allocation, and realloc will not be happy.

I verified that this was the only place in the current source which modifie=
d
any index_state.cache elements aside from the alloc/realloc calls in read-c=
ache by
changing the type of the element to 'struct cache_entry ** const cache' and
recompiling.

A more efficient patch would create a separate 'cache_base' value to track
the allocation and then fix things up when reallocation was necessary,
instead of the brute-force memmove used here.
---
 builtin-ls-files.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin-ls-files.c b/builtin-ls-files.c
index 6c1db86..0028b8a 100644
--- a/builtin-ls-files.c
+++ b/builtin-ls-files.c
@@ -280,7 +280,7 @@ static void prune_cache(const char *prefix)
=20
        if (pos < 0)
                pos =3D -pos-1;
-       active_cache +=3D pos;
+       memmove (active_cache, active_cache + pos, (active_nr - pos) * size=
of (struct cache_entry *));
        active_nr -=3D pos;
        first =3D 0;
        last =3D active_nr;
--=20
1.5.3.3.131.g34c6d-dirty

--=20
keith.packard@intel.com

--=-OdHA507jmKX1EnStEeqK
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBHAywuQp8BWwlsTdMRAvswAKDPCUlgA0otRI49sDtGN0S/a+dZdgCfTPJ2
9uleBKhvPG9pR6xBb1OU574=
=ZW8n
-----END PGP SIGNATURE-----

--=-OdHA507jmKX1EnStEeqK--
