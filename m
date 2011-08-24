From: Carlos =?ISO-8859-1?Q?Mart=EDn?= Nieto <cmn@elego.de>
Subject: Re: Buggy handling of non-canonical ref names
Date: Wed, 24 Aug 2011 23:32:17 +0200
Message-ID: <1314221553.4325.13.camel@centaur.lab.cmartin.tk>
References: <4E551D70.9080509@alum.mit.edu>
	 <7vaaayps9z.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg="pgp-sha1"; protocol="application/pgp-signature";
	boundary="=-JoBoslAeXLHTK1dmboJB"
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	git discussion list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 24 23:32:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QwL3v-0007CB-BX
	for gcvg-git-2@lo.gmane.org; Wed, 24 Aug 2011 23:32:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753930Ab1HXVce (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Aug 2011 17:32:34 -0400
Received: from kimmy.cmartin.tk ([91.121.65.165]:38876 "EHLO kimmy.cmartin.tk"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753870Ab1HXVcd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Aug 2011 17:32:33 -0400
Received: from [192.168.1.17] (brln-4db9e883.pool.mediaWays.net [77.185.232.131])
	by kimmy.cmartin.tk (Postfix) with ESMTPSA id C819346177;
	Wed, 24 Aug 2011 23:32:18 +0200 (CEST)
In-Reply-To: <7vaaayps9z.fsf@alter.siamese.dyndns.org>
X-Mailer: Evolution 3.0.2- 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180045>


--=-JoBoslAeXLHTK1dmboJB
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2011-08-24 at 11:40 -0700, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
>=20
> > What is the policy about reference names and their canonicalization?
>=20
> The overall policy has been that we care about well-formed input, and
> everything else is "undefined", even though as you found out some of them
> try to work sensibly.
>=20
> >     $ git check-ref-format /foo/bar ; echo $?
> >     0
> >
> >     $ git check-ref-format --print /foo/bar
> >     /foo/bar
>=20
> I think these are bogus. Patches welcome.
>=20

The rules in the manpage don't forbit it, as we assume that $GIT_DIR/ is
going to be put in front. This makes /foo/bar mean the same as foo/bar
(both become would cause git to look at $GIT_DIR/foo/bar), but I agree
that it can be quite confusing.

> > However, creating a reference with such a name is equivalent to creatin=
g
> > a reference without the leading slash:
> >
> >     $ git update-ref /foo/bar HEAD
> >     $ cat .git/foo/bar
> >     ef6cf90ba11dd6205f8b974692d795ea0b1c0bdd
> >     $ git branch /bar/baz
> >     $ git for-each-ref | grep baz
> >     ef6cf90ba11dd6205f8b974692d795ea0b1c0bdd commit refs/heads/bar/baz
>=20
> These are just examples of "undefined being nice to the user as a bonus".

Or not, the user might have expected `git branch /bar/baz` to create a
reference in $GIT_DIR/bar/baz with the SHA of the current branch (yes,
it's probably unlikely, but this is what one might think when giving
references as absolute paths).


Be as it may, allowing /foo/bar is not a good thing, how about this
patch? It doesn't modify the manpage, as I wasn't sure whether this
should become an explicit rule.

-- >8 --
Subject: [PATCH] Don't allow reference names to start with '/'

Being able to name references using absolute filenames is confusing
at best and might give people wrong ideas.

Signed-off-by: Carlos Mart=C3=ADn Nieto <cmn@elego.de>
---
 refs.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/refs.c b/refs.c
index 6f313a9..ab549e4 100644
--- a/refs.c
+++ b/refs.c
@@ -879,6 +879,10 @@ int check_ref_format(const char *ref)
 	int ret =3D CHECK_REF_FORMAT_OK;
 	const char *cp =3D ref;
=20
+	/* we don't want refs expressed as absolute paths */
+	if (*cp =3D=3D '/')
+		return CHECK_REF_FORMAT_ERROR;
+
 	level =3D 0;
 	while (1) {
 		while ((ch =3D *cp++) =3D=3D '/')
--=20
1.7.5.2.354.g349bf



--=-JoBoslAeXLHTK1dmboJB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQEcBAABAgAGBQJOVW3hAAoJEHKRP1jG7ZzTw/0H/06CGXoUy8M80mrcHqD55Jol
ZJFV2gsjiLoCKXPoBwtkKoxlFuu1m+d+jB8k2vb9CdlkWMHjp3obGOkBXiFxkz8H
V8ZAFlRSQApn2kRr+uvcfSd4pBKqtbsIvjDqZPdqtFi6zhUa+Gu72jZVzHOLSYV+
UKYbHYVK5tPBLPcYRTu3CDFfjSD0ngcpxicK3UAUpe1fS8LdgWeTtnd2jzH040wV
g56aptTPtYu6yLlKhX9N83xvtfB/KIJMSeH/TqGxXaruhImi+AHyb3dDAEFazr/z
OpFrq/SXrIs1BItd4Zoe/pVnqwV3cjxhJGBUajnuuZgw9ruUW2GDYZ8Qc/P2TUg=
=jhxA
-----END PGP SIGNATURE-----

--=-JoBoslAeXLHTK1dmboJB--
