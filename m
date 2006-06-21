From: Andre Noll <maan@systemlinux.org>
Subject: Re: Odd behavior with git and cairo-devel repo
Date: Wed, 21 Jun 2006 04:46:05 +0200
Message-ID: <20060621024605.GO11245@skl-net.de>
References: <20060621010030.GP2820@artsapartment.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="wwtQuX191/I956S7"
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 21 04:46:38 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fssjk-0007f4-FS
	for gcvg-git@gmane.org; Wed, 21 Jun 2006 04:46:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751940AbWFUCqc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 20 Jun 2006 22:46:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750884AbWFUCqc
	(ORCPT <rfc822;git-outgoing>); Tue, 20 Jun 2006 22:46:32 -0400
Received: from systemlinux.org ([83.151.29.59]:43460 "EHLO m18s25.vlinux.de")
	by vger.kernel.org with ESMTP id S1751941AbWFUCqa (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 20 Jun 2006 22:46:30 -0400
Received: from maan by m18s25.vlinux.de with local (Exim 3.36 #1 (Debian))
	id 1FssjF-0003vA-00; Wed, 21 Jun 2006 04:46:05 +0200
To: Art Haas <ahaas@airmail.net>
Content-Disposition: inline
In-Reply-To: <20060621010030.GP2820@artsapartment.org>
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22234>


--wwtQuX191/I956S7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 20:00, Art Haas wrote:

> $ git clone git://git.cairographics.org/git/cairo cairo
> [ ... git clones the repo without problem ... ]
> $ cd cairo
> $ git fsck-objects
> Floating point exception

This is due to refs_hash_size being zero in mark_reachable().
Both "git fsck-objects --full" and "git repack -a -d" seem to work
fine with the patch below (tested by cloning your repo).

---
Currently, we don't check refs_hash_size size and happily call
lookup_object_refs() even if refs_hash_size is zero which leads to
a division by zero in hash_obj().

Signed-off-by: Andre Noll <maan@systemlinux.org>
---
diff --git a/object-refs.c b/object-refs.c
index 8afa227..a7d49c6 100644
--- a/object-refs.c
+++ b/object-refs.c
@@ -127,6 +127,9 @@ void mark_reachable(struct object *obj,=20
=20
 	if (!track_object_refs)
 		die("cannot do reachability with object refs turned off");
+	/* nothing to lookup */
+	if (!refs_hash_size)
+		return;
 	/* If we've been here already, don't bother */
 	if (obj->flags & mask)
 		return;
--=20
The only person who always got his work done by Friday was Robinson Crusoe

--wwtQuX191/I956S7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.1 (GNU/Linux)

iD8DBQFEmLLtWto1QDEAkw8RApTKAJ9r5XiDeGo2YQHeuNkxvzzFDxkEiQCfdcJA
LmnrYtcgYDkhwHJb+UlGO3M=
=+Rlo
-----END PGP SIGNATURE-----

--wwtQuX191/I956S7--
