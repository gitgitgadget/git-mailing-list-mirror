From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: timestamps not git-cloned
Date: Sat, 29 Nov 2008 11:16:58 +0100
Message-ID: <200811291117.01655.trast@student.ethz.ch>
References: <e3f230850811271908g1be6b3f9t3e678081088de06b@mail.gmail.com> <20081129085406.GA20428@foursquare.net> <20081129092231.GA32630@cuci.nl>
Mime-Version: 1.0
Content-Type: multipart/signed;
  boundary="nextPart1702267.0NnmXASpcZ";
  protocol="application/pgp-signature";
  micalg=pgp-sha1
Content-Transfer-Encoding: 7bit
Cc: Chris Frey <cdfrey@foursquare.net>, jidanni@jidanni.org,
	dhruvakm@gmail.com, git@vger.kernel.org
To: "Stephen R. van den Berg" <srb@cuci.nl>
X-From: git-owner@vger.kernel.org Sat Nov 29 11:18:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L6Mty-0001fh-Ay
	for gcvg-git-2@gmane.org; Sat, 29 Nov 2008 11:18:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751082AbYK2KQ5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Nov 2008 05:16:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751101AbYK2KQ5
	(ORCPT <rfc822;git-outgoing>); Sat, 29 Nov 2008 05:16:57 -0500
Received: from xsmtp0.ethz.ch ([82.130.70.14]:56755 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751041AbYK2KQ4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Nov 2008 05:16:56 -0500
Received: from xfe2.d.ethz.ch ([82.130.124.42]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 29 Nov 2008 11:16:54 +0100
Received: from [192.168.0.4] ([84.75.157.245]) by xfe2.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 29 Nov 2008 11:16:54 +0100
User-Agent: KMail/1.9.9
In-Reply-To: <20081129092231.GA32630@cuci.nl>
X-OriginalArrivalTime: 29 Nov 2008 10:16:54.0409 (UTC) FILETIME=[9A541790:01C9520B]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101902>

--nextPart1702267.0NnmXASpcZ
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Stephen R. van den Berg wrote:
> Chris Frey wrote:
> >If this is the important bit, perhaps git-archive could be changed
> >to create tarballs with file timestamps based on their commit dates.
>=20
> Based on the principle of least surprise, I'd consider this a rather good
> idea.

Unless I'm missing something, this would make git-archive rather more
expensive than it is now: Tree objects do not record any timestamps,
so figuring out the last commit that changed a file requires a full
history walk in the worst case[*].  (This is another side-effect of
not versioning files.)  On the other hand, current git-archive's
running time depends only on the size of the tree-ish given, including
all subtrees and blobs.

My unscientific guesstimates on how much work this would be, in a
random (old) linux-2.6 clone:

  $ git rev-parse HEAD
  e013e13bf605b9e6b702adffbe2853cfc60e7806
  $ time git ls-tree -r -t $(git rev-list HEAD~5000..HEAD) >/dev/null

  real    0m1.385s
  user    0m1.164s
  sys     0m0.220s
  $ git rev-list HEAD | wc -l
  117812

So reading (and dumping) all those trees and subtrees incurs a penalty
on the order of 30 seconds.  Compare to the current running time of
git-archive:

  $ time git archive --format=3Dtar HEAD >/dev/null

  real    0m2.790s
  user    0m2.684s
  sys     0m0.072s

Of course, the ratio will keep getting worse as history gets longer.

=2D Thomas

[*] I think to really have a "worst case" here, you need at least one
file in every leaf directory that has not changed since the root
commit, and another that changes in every commit to force the search
to really read every subtree.

=2D-=20
Thomas Rast
trast@{inf,student}.ethz.ch




--nextPart1702267.0NnmXASpcZ
Content-Type: application/pgp-signature; name=signature.asc 
Content-Description: This is a digitally signed message part.

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)

iEYEABECAAYFAkkxFp0ACgkQqUud07tmzP05/ACdGfUkLcObu1GvW/HBKZkfQc87
S14AnAsnfNVkRwBLkUYObIKEmXIzgTVP
=Q3e0
-----END PGP SIGNATURE-----

--nextPart1702267.0NnmXASpcZ--
