From: Thomas Rast <trast@student.ethz.ch>
Subject: [BUG?] rebase -i -p leaves index changed
Date: Tue, 12 Aug 2008 11:16:39 +0200
Message-ID: <200808121116.41535.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1224283.K3RXXnPsSE";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 12 11:17:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KSq0X-0004PU-GN
	for gcvg-git-2@gmane.org; Tue, 12 Aug 2008 11:17:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752165AbYHLJQg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Aug 2008 05:16:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752159AbYHLJQg
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Aug 2008 05:16:36 -0400
Received: from xsmtp1.ethz.ch ([82.130.70.13]:49498 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752103AbYHLJQe (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Aug 2008 05:16:34 -0400
Received: from xfe2.d.ethz.ch ([82.130.124.42]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 12 Aug 2008 11:16:33 +0200
Received: from cx-public-docking-1-043.ethz.ch ([129.132.149.43]) by xfe2.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Tue, 12 Aug 2008 11:16:32 +0200
User-Agent: KMail/1.9.9
X-OriginalArrivalTime: 12 Aug 2008 09:16:32.0864 (UTC) FILETIME=[1CB16E00:01C8FC5C]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92086>

--nextPart1224283.K3RXXnPsSE
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

'rebase -i -p' appears to be a bit confused about what it is doing.
Try a history like this:

  O -- A -- M -- B
   \       /
    \- C -/

built by:

  git init
  touch foo
  git add foo
  git ci -m initial
  git tag root
  git co -b side
  echo blah > other
  git add other
  git ci -m other
  git co master
  echo a >> foo
  git add foo
  git ci -m a
  git add foo
  git merge side
  echo b >> foo
  git add foo
  git ci -m 'b: depends on side'

=46irst try this:

  GIT_EDITOR=3Dtrue git rebase -i -p root
  git diff --cached

resulting in

  diff --git a/foo b/foo
  index 422c2b7..e69de29 100644
  --- a/foo
  +++ b/foo
  @@ -1,2 +0,0 @@
  -a
  -b
  diff --git a/other b/other
  deleted file mode 100644
  index 907b308..0000000
  --- a/other
  +++ /dev/null
  @@ -1 +0,0 @@
  -blah

Second, 'edit' is also a bit suspicious:

  git reset --hard
  GIT_EDITOR=3D'perl -i -pe "s/pick 096/edit 096/"' git rebase -i -p root

Despite claiming "Stopped at 096[...] a", a quick 'git show' tells us
that it is actually stuck at 'initial'.  (At least 'git rebase
=2D-continue' then ends up with the same result as the first test.)

Granted, I'm not entirely sure what it _should_ do.  In my use case
(relating to the filter-branch topic), C was a commit from elsewhere
that B depended on.  So I kind of hoped 'rebase -i -p' would let me
edit A, then rebuild M and B on top, while leaving C alone.

=2D Thomas

=2D-=20
Thomas Rast
trast@student.ethz.ch






--nextPart1224283.K3RXXnPsSE
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkihVPkACgkQqUud07tmzP163QCfVbhc1x5wJW/SYKuXNUqeE2Fk
l94AniHBCESi1GEf7QtIVrwtbSbu8ae0
=dQla
-----END PGP SIGNATURE-----

--nextPart1224283.K3RXXnPsSE--
