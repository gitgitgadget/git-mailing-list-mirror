From: "Robin H. Johnson" <robbat2@gentoo.org>
Subject: Re: Performance issue: initial git clone causes massive repack
Date: Sat, 4 Apr 2009 17:37:53 -0700
Message-ID: <20090405T001239Z@curie.orbis-terrarum.net>
References: <20090404220743.GA869@curie-int> <20090405000536.GA12927@vidovic>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="3VRmKSg17yJg2MZg"
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Apr 05 02:39:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqGOa-00038E-WA
	for gcvg-git-2@gmane.org; Sun, 05 Apr 2009 02:39:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755695AbZDEAiB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 Apr 2009 20:38:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756294AbZDEAiA
	(ORCPT <rfc822;git-outgoing>); Sat, 4 Apr 2009 20:38:00 -0400
Received: from b01.ext.isohunt.com ([208.71.112.51]:58430 "EHLO
	mail.isohunt.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756149AbZDEAh7 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 Apr 2009 20:37:59 -0400
Received: (qmail 4842 invoked from network); 5 Apr 2009 00:37:56 -0000
Received: from tsi-static.orbis-terrarum.net (HELO curie.orbis-terrarum.net) (76.10.188.108)
  (smtp-auth username robbat2@isohunt.com, mechanism login)
  by mail.isohunt.com (qpsmtpd/0.33-dev on beta01) with (AES256-SHA encrypted) ESMTPSA; Sun, 05 Apr 2009 00:37:56 +0000
Received: (qmail 5059 invoked by uid 10000); 4 Apr 2009 17:37:53 -0700
Content-Disposition: inline
In-Reply-To: <20090405000536.GA12927@vidovic>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115611>


--3VRmKSg17yJg2MZg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 05, 2009 at 02:05:36AM +0200, Nicolas Sebrecht wrote:
> > Our full repository conversion is large, even after tuning the
> > repacking, the packed repository is between 1.4 and 1.6GiB. As of Febur=
ary
> > 4th, 2009, it contained 4886949 objects. It is not suitable for
> > splitting into submodules either unfortunately - we have a lot of
> > directory moves that would cause submodule bloat.
> Actually, I'm not sure that a full portage tree repository would be the
> best thing to do. It would not be suitable in the long term and working
> on the repository/history would be a big mess. Why provide a such repo ?
> Or at least, why provide a such readable repo ?
>=20
> IMHO, you should provide a repository per upstream package on the main
> server.
That causes incredibly bloat unfortunately.

I'll summarize why here for the git mailing list. Most our developers
have the entire tree checked out, and in informal surveys, would like to
continue to do so. There are ~13500 packages right now (I'm excluding
eclasses/, profiles/, scripts/), and growing by 15-25 new packages/week.
(~45% of packages also have a files/ directory).

For each package, the .git directory, assuming in a single pack,
consumes at least 36 inodes.  Tail-packing is limited to Reiserfs3 and
JFS, and isn't widely used other than that, so assuming 4KiB inodes,
that's an overhead of at least 144KiB per package. Multiple by the
number of packages, and we get an overhead of 2GiB, before we've added
ANY content.

Without tail packing, the Gentoo tree is presently around 520MiB (you
can fit it into ~190MiB with tail packing). This means that
repo-per-package would have an overhead in the range of 400%.

Additionally, there's a lot of commonality between ebuilds and packages,
and having repo-per-package means that the compression algorithms can't
make use of it - dictionary algorithms are effective at compression for
a reason.

Overhead is the reason that we refused to migrate to SVN as well.
- CVS, per each directory of data, has a constant overhead of 4 inodes
  (CVS/ CVS/Root CVS/Repository CVS/Entries)
- SVN, for each data directory, has another complete copy of the data,
  plus a minimum of 10 other inodes.
- Git costs a minimum 36 inodes per repository. In a fully packed repo,
  the number of inodes tends to stay below 50 in all cases.

> PS: what about cc'ing gentoo-scm list ?
It's not an open-posting list, so anybody here on the git list simply
replying would not get their post on there. The issue has been raised
there, and this mainly meant to find a resolution to that problem.

--=20
Robin Hugh Johnson
Gentoo Linux Developer & Infra Guy
E-Mail     : robbat2@gentoo.org
GnuPG FP   : 11AC BA4F 4778 E3F6 E4ED  F38E B27B 944E 3488 4E85

--3VRmKSg17yJg2MZg
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.10 (GNU/Linux)
Comment: Robbat2 @ Orbis-Terrarum Networks - The text below is a digital signature. If it doesn't make any sense to you, ignore it.

iEYEARECAAYFAknX/WEACgkQPpIsIjIzwiyZhACgtPf9gaKRj647IiP214ZHEqXs
fJQAoIfCd7r631p3UW2nM7zaHXN4P6pK
=91yp
-----END PGP SIGNATURE-----

--3VRmKSg17yJg2MZg--
