From: "Robin H. Johnson" <robbat2@gentoo.org>
Subject: Re: Performance issue: initial git clone causes massive repack
Date: Sun, 5 Apr 2009 00:04:12 -0700
Message-ID: <20090405070412.GB869@curie-int>
References: <20090404220743.GA869@curie-int> <20090405000536.GA12927@vidovic> <20090405T001239Z@curie.orbis-terrarum.net> <20090405035453.GB12927@vidovic>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="8jNwmpfkpox/fiJK"
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Apr 05 09:06:07 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LqMQU-0000WL-JG
	for gcvg-git-2@gmane.org; Sun, 05 Apr 2009 09:05:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757649AbZDEHEU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 5 Apr 2009 03:04:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757564AbZDEHEU
	(ORCPT <rfc822;git-outgoing>); Sun, 5 Apr 2009 03:04:20 -0400
Received: from b01.ext.isohunt.com ([208.71.112.51]:47927 "EHLO
	mail.isohunt.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755823AbZDEHET (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 5 Apr 2009 03:04:19 -0400
Received: (qmail 22649 invoked from network); 5 Apr 2009 07:04:15 -0000
Received: from tsi-static.orbis-terrarum.net (HELO curie.orbis-terrarum.net) (76.10.188.108)
  (smtp-auth username robbat2@isohunt.com, mechanism login)
  by mail.isohunt.com (qpsmtpd/0.33-dev on beta01) with (AES256-SHA encrypted) ESMTPSA; Sun, 05 Apr 2009 07:04:15 +0000
Received: (qmail 2978 invoked by uid 10000); 5 Apr 2009 00:04:12 -0700
Content-Disposition: inline
In-Reply-To: <20090405035453.GB12927@vidovic>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115636>


--8jNwmpfkpox/fiJK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Before I answer the rest of your post, I'd like to note that the matter
of which choice between single-repo, repo-per-package, repo-per-category
has been flogged to death within Gentoo.

I did not come to the Git mailing list to rehash those choices. I came
here to find a solution to the performance problem. While it shows up
with our repo, I'm certain that we're not the only people with the
problem. The GSoC 2009 ideas contain a potential project for caching the
generated packs, which, while having value in itself, could be partially
avoided by sending suitable pre-built packs (if they exist) without any
repacking.

On Sun, Apr 05, 2009 at 05:54:53AM +0200, Nicolas Sebrecht wrote:
> > That causes incredibly bloat unfortunately.
> >=20
> > I'll summarize why here for the git mailing list. Most our developers
> > have the entire tree checked out, and in informal surveys, would like to
> > continue to do so. There are ~13500 packages right now=20
> Each developer doesn't work on so many packages, right ? From my point
> of view, checkin'out the entire tree is the wrong way on how to do
> things.
Also, I should note that working on the tree isn't the only reason to
have the tree checked out. While the great majority of Gentoo users have
their trees purely from rsync, there is nothing stopping you from using
a tree from CVS (anonCVS for the users, master CVS server for the
developers).

A quick bit of stats run show that while some developers only touch a
few packages, there are at least 200 developers that have done a major
change to 100 or more packages.

> > Without tail packing, the Gentoo tree is presently around 520MiB (you
> > can fit it into ~190MiB with tail packing). This means that
> > repo-per-package would have an overhead in the range of 400%.
> Don't know about the business for Gentoo, but HDD is cheap.
There's no reason to have bloat just for the layout to change.

> Also, I'd like to know how much space you will gain with the CVS to Git >
> migration.  How bigger is a CVS repo against a Git one ?
For the CVS checkouts right now:=20
- ~410MiB of content (w/ 4kb inodes)
- ~240MiB of CVS overhead (w/ 4kb inodes)
(sorry about the earlier 520MiB number, I forgot to exclude a local dir
of stats data on my box when I ran du quickly).

Our experimental Git, with only a single repo for gentoo-x86:
- ~410MiB of content (w/ 4kb inodes)
- 80MiB - 1.6GiB of Git total overhead.

80MiB of overhead is the total overhead with a shallow clone at depth 1.
1.6GiB is with the full history.

And per-package numbers, because we DID do an experimental conversion,
last year, although the packs might not have been optimal:
- ~410MiB of content (w/ 4kb inodes)
- 4.7GiB of Git total overhead, with a breakdown:
  - 1.9GiB in inode waste
  - 2.8GiB in packs

> One repo per category could be a good compromise assuming one seperate
> branch per package, then.
Other downsides to repo-per-category and repo-per-package:
- Raises difficulty in adding a new package/category.=20
  You cannot just do 'mkdir && vi ... && git add && git commit' anymore.
- The name of the directory for both of the category AND the package are not
  specified in the ebuild, as such, unless they are checked out to the right
  location, you will get breakage (definitely in the package name, and
  about 10% of the time with categories).
- You cannot use git-cvsserver with them cleanly and have the correct
  behavior (we DO have developers that want to use the CVS emulation
  layer) - adding a category or a package would NOT trigger the
  addition of a new repo on the server when needed.
- Does NOT present a good base for anybody wanting to branch the entire
  tree themselves.
 =20

> > Additionally, there's a lot of commonality between ebuilds and packages,
> > and having repo-per-package means that the compression algorithms can't
> > make use of it - dictionary algorithms are effective at compression for
> > a reason.
> Please, no. We are in the long term issues. Compression will be
> efficient. It's all about the content of the files and dictionary
> algorithms certainly will do a good job over the ebuilds revisions.
We're already on track to drop the CVS $Header$, and thereafter, some of the
ebuilds are already on track to be smaller. Here's our prototype dev-perl/S=
ub-Name-0.04.
=3D=3D=3D=3D
# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
MODULE_AUTHOR=3DXMATH
inherit perl-module
DESCRIPTION=3D"(re)name a sub"
LICENSE=3D"|| ( Artistic GPL-2 )"
SLOT=3D"0"
KEYWORDS=3D"~amd64 ~x86"
IUSE=3D""
SRC_TEST=3Ddo
=3D=3D=3D=3D

We can have all the CPAN packages from CPAN author XMATH, with changing
only the DESCRIPTION string. KEYWORDS then just changes over the package
lifespan.

--=20
Robin Hugh Johnson
Gentoo Linux Developer & Infra Guy
E-Mail     : robbat2@gentoo.org
GnuPG FP   : 11AC BA4F 4778 E3F6 E4ED  F38E B27B 944E 3488 4E85

--8jNwmpfkpox/fiJK
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.10 (GNU/Linux)
Comment: Robbat2 @ Orbis-Terrarum Networks - The text below is a digital signature. If it doesn't make any sense to you, ignore it.

iEYEARECAAYFAknYV+wACgkQPpIsIjIzwiwy1gCgn2Ct9pOE7jTFHqEzyfLqN/SU
2CkAn2l4x7nu3y6fcnhqo95A+E6aIJn1
=4pMP
-----END PGP SIGNATURE-----

--8jNwmpfkpox/fiJK--
