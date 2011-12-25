From: Joey Hess <joey@kitenet.net>
Subject: FETCH_HEAD documentation vs reality
Date: Sun, 25 Dec 2011 13:39:01 -0400
Message-ID: <20111225173901.GA668@gnu.kitenet.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="+pHx0qQiF2pBVqBT"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Dec 25 18:39:34 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Res2n-00018T-QD
	for gcvg-git-2@lo.gmane.org; Sun, 25 Dec 2011 18:39:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753486Ab1LYRjL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 25 Dec 2011 12:39:11 -0500
Received: from wren.kitenet.net ([80.68.85.49]:53498 "EHLO kitenet.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752168Ab1LYRjK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Dec 2011 12:39:10 -0500
Received: from gnu.kitenet.net (dialup-4.153.2.217.Dial1.Atlanta1.Level3.net [4.153.2.217])
	(using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "gnu", Issuer "Joey Hess" (verified OK))
	by kitenet.net (Postfix) with ESMTPS id 94A091180EC
	for <git@vger.kernel.org>; Sun, 25 Dec 2011 12:39:06 -0500 (EST)
Received: by gnu.kitenet.net (Postfix, from userid 1000)
	id 8BD9D44992; Sun, 25 Dec 2011 12:39:01 -0500 (EST)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187683>


--+pHx0qQiF2pBVqBT
Content-Type: multipart/mixed; boundary="IJpNTDwzlM2Ie8A6"
Content-Disposition: inline


--IJpNTDwzlM2Ie8A6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

While trying to find some documentation of the format of .git/FETCH_HEAD,
I found this example in git-read-tree.txt, which I think will no longer
work. Probably when this was written, .git/FETCH_HEAD contained only a sing=
le
SHA; it's much more complicated now.

        $ JC=3D`git rev-parse --verify "HEAD^0"`
        $ git checkout-index -f -u -a $JC
        ...
        $ git fetch git://.... linus
        $ LT=3D`cat .git/FETCH_HEAD`
        ...
        $ git read-tree -m -u `git merge-base $JC $LT` $JC $LT

It's also common for the first line of .git/FETCH_HEAD to be an
arbitrary branch that was fetched (as part of an unqualified "git
pull"), marked not-for-merge. So using "FETCH_HEAD" as a refname will
refer to such a branch unintentionally. There are several places in the
docs that seem to expect FETCH_HEAD to always refer to the one that was
fetched and will be merged (ie, master):

revisions.txt:

	'FETCH_HEAD' records the branch which you fetched from a remote repository
	with your last `git fetch` invocation.

git-pull.txt:

	In its default mode, `git pull` is shorthand for
	`git fetch` followed by `git merge FETCH_HEAD`.

gittutorial.txt:

	alice$ git log -p HEAD..FETCH_HEAD
	$ gitk HEAD..FETCH_HEAD

howto/rebase-from-internal-branch.txt:

	You fetch from upstream, but not merge.
=09
	    $ git fetch upstream
=09
	This leaves the updated upstream head in .git/FETCH_HEAD but
	does not touch your .git/HEAD nor .git/refs/heads/master.
	You run "git rebase" now.
=09
	    $ git rebase FETCH_HEAD master

All this documentation could be changed, or resolve_ref_unsafe in refs.c
could be changed to have a special case parser for .git/FETCH_HEAD,
that finds the first branch that is marked for merge, where it now has
this minor special case for it:

        /* Please note that FETCH_HEAD has a second line containing other d=
ata. */
        if (get_sha1_hex(buffer, sha1) || (buffer[40] !=3D '\0' && !isspace=
(buffer[40]))) {

Or yet another way to fix it would be to make git fetch always write the
intended FETCH_HEAD first into .git/FETCH_HEAD. (When not in --append mode.)
This seems like perhaps the best fix, although it does mean that if a
fetch is done of only not-for-merge refs, without --append, FETCH_HEAD
will still refer to one of them.=20

I've attached a minimal proof-of-concept patch implementing this last
option.

--=20
see shy jo

--IJpNTDwzlM2Ie8A6
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch
Content-Transfer-Encoding: quoted-printable

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 33ad3aa..e2f2c69 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -376,6 +376,7 @@ static int store_updated_refs(const char *raw_url, cons=
t char *remote_name,
 	struct strbuf note =3D STRBUF_INIT;
 	const char *what, *kind;
 	struct ref *rm;
+	int top =3D 1;
 	char *url, *filename =3D dry_run ? "/dev/null" : git_path("FETCH_HEAD");
=20
 	fp =3D fopen(filename, "a");
@@ -393,6 +394,7 @@ static int store_updated_refs(const char *raw_url, cons=
t char *remote_name,
 		goto abort;
 	}
=20
+ write:
 	for (rm =3D ref_map; rm; rm =3D rm->next) {
 		struct ref *ref =3D NULL;
=20
@@ -408,6 +410,9 @@ static int store_updated_refs(const char *raw_url, cons=
t char *remote_name,
 		if (!commit)
 			rm->merge =3D 0;
=20
+		if (top !=3D rm->merge)
+			continue;
+
 		if (!strcmp(rm->name, "HEAD")) {
 			kind =3D "";
 			what =3D "";
@@ -474,6 +479,11 @@ static int store_updated_refs(const char *raw_url, con=
st char *remote_name,
 		}
 	}
=20
+	if (top) {
+		top =3D 0;
+		goto write;
+	}
+
 	if (rc & STORE_REF_ERROR_DF_CONFLICT)
 		error(_("some local refs could not be updated; try running\n"
 		      " 'git remote prune %s' to remove any old, conflicting "

--IJpNTDwzlM2Ie8A6--

--+pHx0qQiF2pBVqBT
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIVAwUBTvdfsskQ2SIlEuPHAQj9bg//bdYL31vnLQ4IroIJOCfKbH4BlwGRbvSs
xF02Lhw++Hrv6CYuOEHbyp3kevDG3y3JwcPSHn12HATXjKBGY6n5a+rPT9M2AYat
ID/SiomIho/7HcXSb1TZYmt5WgMvqZmbJzo1/ntOqrErgatrlQ2RJ1b+jZDtTlXu
agyIpF68Xqmcb31Qc/UQH8f9/ip/zZ7G+1L4WaAU6aGmhmCkpXdZ59nCoBme5lGM
E+w17B/LZmZfkmiZX2V7s7W7SAcbMISb7RF062bCnfbcu1SV54bcu1d2YSQePBhw
R6lbtA6Aiu4KXRdpwvE4XteRrUmfpft7VrA0RBeI9llqwU4kNHDd4ZMkA7w+xb8p
U1yOCejatj1O6Fgim42G/F3R3qB1EIDb8HIvHMGB7AifSrP4MkBDq8caXuegMWVN
ue52AV7BzoTI+KSUJFZKif146EvhpyeNSqZZjqlFjGI4Uh0Uhyd2dNwgSF8f4BrX
93UMOZarKVS6v7RrC349kjuKc4LjSPVYHdHVj/Bx0zzhbdmuA1mXUlWAMJwRdGUv
mOLMQ7rEY/GhgvzXBrgJhVZYZkW7UeF0RwBTt0akZvIoG+oesvglGUrqqJXfa9nt
GrUgclOgSG5PKAg0FUOMcyWwuiFpA+c5GpRiEPyDbpbKEVN5Io/y40w/BIR5Qmfw
4uIGlKkK+zQ=
=UR8R
-----END PGP SIGNATURE-----

--+pHx0qQiF2pBVqBT--
