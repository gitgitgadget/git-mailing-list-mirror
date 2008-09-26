From: Miklos Vajna <vmiklos@frugalware.org>
Subject: Re: [PATCH] builtin-commit: avoid using reduce_heads()
Date: Fri, 26 Sep 2008 21:31:22 +0200
Message-ID: <20080926193122.GW23137@genesis.frugalware.org>
References: <20080925235029.GA15837@neumann> <1222389359-22191-1-git-send-email-vmiklos@frugalware.org> <20080926010312.GE6816@neumann> <20080926151517.GV23137@genesis.frugalware.org> <m37i8y3mqt.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="l3ej7W/Jb2pB3qL2"
Cc: SZEDER =?iso-8859-1?Q?G=E1bor?= <szeder@ira.uka.de>,
	git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Johannes.Schindelin@gmx.de
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Sep 26 21:33:05 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KjJ3K-0008Ub-Jb
	for gcvg-git-2@gmane.org; Fri, 26 Sep 2008 21:32:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752862AbYIZTbZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Sep 2008 15:31:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752821AbYIZTbY
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Sep 2008 15:31:24 -0400
Received: from virgo.iok.hu ([193.202.89.103]:36774 "EHLO virgo.iok.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751927AbYIZTbY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Sep 2008 15:31:24 -0400
Received: from kag.elte.hu (kag.elte.hu [157.181.177.1])
	by virgo.iok.hu (Postfix) with ESMTP id E3D8358070;
	Fri, 26 Sep 2008 21:31:22 +0200 (CEST)
Received: from genesis.frugalware.org (frugalware.elte.hu [157.181.177.34])
	by kag.elte.hu (Postfix) with ESMTP id CA9F24465E;
	Fri, 26 Sep 2008 21:31:22 +0200 (CEST)
Received: by genesis.frugalware.org (Postfix, from userid 1000)
	id B3AC311901A1; Fri, 26 Sep 2008 21:31:22 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <m37i8y3mqt.fsf@localhost.localdomain>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96885>


--l3ej7W/Jb2pB3qL2
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 26, 2008 at 09:17:39AM -0700, Jakub Narebski <jnareb@gmail.com>=
 wrote:
> 1. As proposed above save git-merge options, for example in MERGE_MODE
>    or MERGE_OPTS file, so git-commit knows what options to use if it
>    was invoked to finish a merge.

First, thank you for the detailed description, I'm really bad in them.
:)

ACK, that's why I implemented this one.

> 2. git-merge saves _reduced_ heads in MERGE_HEAD, and git-commit
>    reduces only HEAD, unless it is in MERGE_HEAD.  This means that
>    git-commit uses the following pseudo-code
>=20
>      if (resolve_ref(HEAD) =3D=3D MERGE_HEAD[0]) {
>         /* non fast-forward case */
>         merge HEAD + MERGE_HEAD
>      } else {
>         reduce_HEAD_maybe()
>         merge [HEAD] + MERGE_HEAD
>      }
>=20
>    This has the advantage that it doesn't change MERGE_HEAD semantic
>    for simple merge which did not began as octopus

This is wrong IMHO. You can write the reduced heads to MERGE_HEAD but
you can't know if you can omit the HEAD in case it is reachable already
=66rom one of the heads or not. That depends on if the user used --no-ff
or not.

> 3. Remove reduce_heads() from git-commit entirely, and record in
>    MERGE_HEAD (or rather now MERGE_HEADS) _all_ _reduced_ heads.
>    _All_ means that HEAD is included in MERGE_HEAD if it is not
>    reduced, _reduced_ means that only non-dependent heads are in
>    MERGE_HEAD.  This for example means that for simple non-octopus
>    merge case MERGE_HEAD/MERGE_HEADS now contain _all_ parents,
>    and not only other side of merge.
>=20
>    This solution has the advantage of being clear solution, clarifying
>    semantic of MERGE_HEAD (currently HEAD is used both as target, i.e.
>    where merge is to be recorded, and as one of heads to merge/to
>    consider), and making it possible to separate layers: git-merge
>    is about merging, git-commit doesn't need to know anything about
>    merging.
>=20
>    The disadvantage is that it changes format (well, semantic) of
>    MERGE_HEAD, possibly breaking users' scripts; perhaps some of
>    git commands like "git log --merge" or "git diff --merge" should
>    be updated on such change.

Actually I think this would be ugly. MERGE_HEAD is about you can see
what will be merged once you commit the merge, but once you include HEAD
there, you can't easily check that. Maybe it's just me who sometimes
have a look at that file myself directly... :-)

--l3ej7W/Jb2pB3qL2
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkjdOIoACgkQe81tAgORUJZPSwCdHlApb3WvUaeecnaqXgAG6EGA
4OEAn1iZA2PlToJd2Glkavk/Xfh1JdiJ
=LK6q
-----END PGP SIGNATURE-----

--l3ej7W/Jb2pB3qL2--
