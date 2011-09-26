From: Carlos =?ISO-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>
Subject: Re: [BUG?] git fetch -p -t prunes all non-tag refs
Date: Tue, 27 Sep 2011 01:11:03 +0200
Message-ID: <1317078667.5579.13.camel@centaur.lab.cmartin.tk>
References: <20110926184739.GA11745@erythro.kitwarein.com>
	 <7vehz30wdy.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-CMcvEecqaktcwNmyiBaR"
Cc: mathstuf@gmail.com, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 27 01:11:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R8KKO-0008Ag-Gr
	for gcvg-git-2@lo.gmane.org; Tue, 27 Sep 2011 01:11:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752841Ab1IZXLI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 26 Sep 2011 19:11:08 -0400
Received: from kimmy.cmartin.tk ([91.121.65.165]:45379 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750884Ab1IZXLH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Sep 2011 19:11:07 -0400
Received: from [192.168.1.17] (brln-4db9fe34.pool.mediaWays.net [77.185.254.52])
	by kimmy.cmartin.tk (Postfix) with ESMTPSA id 3F4E146180;
	Tue, 27 Sep 2011 01:10:44 +0200 (CEST)
In-Reply-To: <7vehz30wdy.fsf@alter.siamese.dyndns.org>
X-Mailer: Evolution 3.0.3- 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182183>


--=-CMcvEecqaktcwNmyiBaR
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, 2011-09-26 at 15:30 -0700, Junio C Hamano wrote:
> Ben Boeckel <mathstuf@gmail.com> writes:
>=20
> > When the --prune and --tags options are given to git fetch together, al=
l
> > non-tag refs are pruned because only tags are looked at and when prunin=
g
> > it appears as if the branches have disappeared and are therefore delete=
d
> > locally.
>=20
> I would call that a bug, and it is not limited to the use of "--tags". Fo=
r
> example, I suspect that
>=20
>     $ git fetch --prune origin refs/heads/master:refs/remotes/origin/mast=
er
>=20
> would prune remote tracking branches for "origin" other than "master".

This should fix it (in a way). Let's agree that it's a bad idea and
complain to the user. Looking at the surrounding code, I can't find
anything obvious that would break, and `git fetch --prune --multiple a
b` is allowed.

Patch on top of maint.

--- 8< ---
Subject: [PATCH] fetch: disallow --prune in combination with tags or refspe=
cs

Pruning shouldn't be used when other options limit the references that
should be taken into account. For example

    git fetch --prune --tags origin
    git fetch --prune origin refs/heads/*:refs/remotes/*

Both these commands would remove references which do still exist in
the remote.

Print an error and exit if prune is selected at the same time as
either tags are selected or a refspec is given.

Signed-off-by: Carlos Mart=C3=ADn Nieto <cmn@elego.de>
---
 builtin/fetch.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index e422ced..158b20a 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -967,6 +967,9 @@ int cmd_fetch(int argc, const char **argv, const char *=
prefix)
 			if (!add_remote_or_group(argv[i], &list))
 				die(_("No such remote or remote group: %s"), argv[i]);
 		result =3D fetch_multiple(&list);
+	} else if (prune && (argc =3D=3D 2 || tags !=3D TAGS_DEFAULT)) {
+		/* The if (multiple) is above so we don't report multiple remotes as an =
error */
+		die(_("Pruning and limiting refs is not compatible"));
 	} else {
 		/* Single remote or group */
 		(void) add_remote_or_group(argv[0], &list);
--=20
1.7.5.2.354.g349bf




--=-CMcvEecqaktcwNmyiBaR
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAABAgAGBQJOgQaHAAoJEHKRP1jG7ZzTb/oH+wYTtzUPPxVuw/JibeJ5hihU
yGH2g6ns1jgmb0j9wW8EkG/CM3IHHRAI8bmd0nTPUI1ekN/BLgmrILFpktct5hJz
lPp1/cAKIgrU6XHrUmZflPiGcgiTz0xLYJjQlH2vobVzuKY8Ba9j/39rsOM+uUxY
yqTaNvP/27Wokt3+kYXAQe0u0t8uTQz/EU6sHI3LJtOfMMgn6uGBPqa/3XXl8ciS
hj6Kkay5E6zMHtxuHrA/ucedFiJx3Hpx67fYx+FB6uWBVdSQvHmgBGmfmFJUThde
8OBLDz263D+bZkiuOrOiIS9piBAFwJWq5yPHaf5CElz143v8w3mYkr+E2uICuiE=
=L2Qf
-----END PGP SIGNATURE-----

--=-CMcvEecqaktcwNmyiBaR--
