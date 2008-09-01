From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH 00/12] Towards a better merge resolution support
Date: Mon, 1 Sep 2008 14:20:58 +0200
Message-ID: <200809011421.20175.trast@student.ethz.ch>
References: <1220056963-2352-1-git-send-email-gitster@pobox.com> <20080901094412.GB3993@blimp.local> <20080901095008.GB6555@toroid.org>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1801958.fYsbYbeGy7";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: Alex Riesen <raa.lkml@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Abhijit Menon-Sen" <ams@toroid.org>
X-From: git-owner@vger.kernel.org Mon Sep 01 14:22:32 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ka8QM-0002qK-7e
	for gcvg-git-2@gmane.org; Mon, 01 Sep 2008 14:22:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754363AbYIAMVU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Sep 2008 08:21:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754262AbYIAMVU
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Sep 2008 08:21:20 -0400
Received: from xsmtp1.ethz.ch ([82.130.70.13]:31894 "EHLO xsmtp1.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754162AbYIAMVT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Sep 2008 08:21:19 -0400
Received: from xfe2.d.ethz.ch ([82.130.124.42]) by xsmtp1.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 1 Sep 2008 14:21:19 +0200
Received: from cx-public-docking-1-043.ethz.ch ([129.132.149.43]) by xfe2.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 1 Sep 2008 14:21:17 +0200
User-Agent: KMail/1.9.9
In-Reply-To: <20080901095008.GB6555@toroid.org>
X-OriginalArrivalTime: 01 Sep 2008 12:21:18.0014 (UTC) FILETIME=[3C3815E0:01C90C2D]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94577>

--nextPart1801958.fYsbYbeGy7
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Abhijit Menon-Sen wrote:
> At 2008-09-01 11:44:12 +0200, raa.lkml@gmail.com wrote:
> >
> > IOW, copy the commit resolution from some other merge commit. Maybe
> > can be a way to use rerere mechanism with that?
>=20
> That's what I'm trying to implement on Dscho's suggestion. I'm still
> just trying to understand the code, so any suggestions about how to
> do this are very welcome.

Random idea: you could use a script that just replays the merges
present in history and lets rerere record them.  Like so:

=2D- 8< --
#!/bin/sh

=2E "$(git --exec-path)/git-sh-setup"

require_work_tree
git update-index --refresh || die "can't run with dirty index"

git rev-list --parents "$@" |
grep '.* .* .*' |
while read merge firstparent otherparents
do
	git checkout $firstparent >/dev/null 2>/dev/null
	git merge $otherparents >/dev/null
	if test -z "$(git ls-files -u)"; then
		echo -n 'no conflicts: '
		git --no-pager log -1 --pretty=3Doneline --abbrev-commit $merge
		continue
	fi
	git rerere
	git ls-files -t | grep ^M | cut -c 3- | xargs git checkout $merge --
	git rerere
	git reset --hard >/dev/null 2>/dev/null
	echo -n 'recorded:     '
	git --no-pager log -1 --pretty=3Doneline --abbrev-commit $merge
done
=2D- >8 --

The intended usage is like

  ./rerereimport.sh v1.6.0..origin/next

to import all resolutions in the specified range.  Granted, it's
probably not as good and definitely not as fast as an automatic
feature integrated with the merge machinery.

=2D Thomas

=2D-=20
Thomas Rast
trast@student.ethz.ch



--nextPart1801958.fYsbYbeGy7
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAki73kAACgkQqUud07tmzP1K4QCgkVIH0d5IYm2cgJ2ZNpdQynYr
If8AnAxbByA1tD+UQmhw2HvDu7XPci5d
=CFhS
-----END PGP SIGNATURE-----

--nextPart1801958.fYsbYbeGy7--
