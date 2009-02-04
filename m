From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: retrospective move
Date: Wed, 4 Feb 2009 10:17:45 +0100
Message-ID: <200902041017.47564.trast@student.ethz.ch>
References: <21826423.post@talk.nabble.com>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1614071.HxBug8X8X7";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: jemmyw <jeremy@boost.co.nz>
X-From: git-owner@vger.kernel.org Wed Feb 04 10:19:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUduy-0004Nl-IA
	for gcvg-git-2@gmane.org; Wed, 04 Feb 2009 10:19:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752061AbZBDJSK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Feb 2009 04:18:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751268AbZBDJSJ
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Feb 2009 04:18:09 -0500
Received: from xsmtp1.ethz.ch ([82.130.70.13]:9012 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751577AbZBDJSI (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Feb 2009 04:18:08 -0500
Received: from xfe2.d.ethz.ch ([82.130.124.42]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 4 Feb 2009 10:18:04 +0100
Received: from thomas.localnet ([129.132.153.233]) by xfe2.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Wed, 4 Feb 2009 10:18:04 +0100
User-Agent: KMail/1.11.0 (Linux/2.6.25.20-0.1-default; KDE/4.2.0; x86_64; ; )
In-Reply-To: <21826423.post@talk.nabble.com>
X-OriginalArrivalTime: 04 Feb 2009 09:18:04.0246 (UTC) FILETIME=[7BDD3760:01C986A9]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108321>

--nextPart1614071.HxBug8X8X7
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

jemmyw wrote:
>=20
> Hi. Awhile ago I copied some files in my local repo then commited. In ano=
ther
> commit I deleted the original files, so essentially I did a mv that git
> doesn't know about. Now I'm trying to merge from another branch where
> changes have happened to the files in their original locations, and it's
> making the merge somewhat difficult. Is there a way to ease this?

Git never "knows" about a move, it only detects them after the fact.
A corollary of this is that 'git mv a b' is more or less the same as
'cp a b; git rm a; git add b'.

Now since you have a copy followed by a removal in two separate
commits, the merge logic won't treat this as a rename.  Some ideas for
possible solutions:

* If your cp&rm commits are strictly local, you could squash them into
  a single commit.  See man git-rebase(1), especially the -i flag.
  That way, the merge logic will recognise it as a rename.

* You can use an extra line of history that has a "real" one-step mv.
  Suppose you currently have

     *---*---*---*---*      upstream
      \
       \
        +--C--o--R--o--o    local

  where C is the copy and R is the removal.  Then you can introduce an
  extra "gateway" branch that does just the move:

     *---*---*---*---*      upstream
     |\
     | \
     |  +--M                gateway
     |
      \
       \
        +--C--o--R--o--o    local

  Now merge gateway to local (i.e. git checkout local && git merge
  gateway), and resolve all resulting conflicts.  I think you can
  actually use '-s ours' in that merge, but be sure to check the
  results.

     *---*---*---*---*      upstream
     |\
     | \
     |  +--M                gateway
     |      \
      \      +----------+
       \                 \
        +--C--o--R--o--o--1    local

  Finally, you can use the gateway branch to "do the rename" on all
  incoming new changes, by first merging upstream to gateway and later
  again gateway to local, like so:
 =20
     *---*---*---*---*.      upstream
     |\                \
     | \                \
     |  +--M-------------2       gateway
     |      \             \
      \      +----------+  \
       \                 \  \
        +--C--o--R--o--o--1--3   local

  It won't be very pretty history, but it should only give (rename
  related) merge conflicts at M.

HTH :-)

=2D-=20
Thomas Rast
trast@{inf,student}.ethz.ch

--nextPart1614071.HxBug8X8X7
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkmJXTsACgkQqUud07tmzP0otgCdEM/pU2DJZbBElh15tYTsFqRE
SJUAmwbRQwVnQXhjLD4ycJpxuidi/3lk
=Qy5O
-----END PGP SIGNATURE-----

--nextPart1614071.HxBug8X8X7--
