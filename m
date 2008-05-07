From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: Re: git-checkout sometimes silently fails
Date: Wed, 7 May 2008 03:32:40 +0200
Message-ID: <20080507013240.GA13661@atjola.homenet>
References: <20080506122256.04ca7d77.akpm@linux-foundation.org> <20080506215049.GC4647@steel.home> <20080506171052.340d643e.akpm@linux-foundation.org> <20080507001919.GA8633@sigill.intra.peff.net> <20080506175442.845ca8fa.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, Alex Riesen <raa.lkml@gmail.com>,
	git@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed May 07 03:33:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JtYXL-00079l-1d
	for gcvg-git-2@gmane.org; Wed, 07 May 2008 03:33:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754080AbYEGBcr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 6 May 2008 21:32:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754601AbYEGBcr
	(ORCPT <rfc822;git-outgoing>); Tue, 6 May 2008 21:32:47 -0400
Received: from mail.gmx.net ([213.165.64.20]:45290 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751691AbYEGBcp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 May 2008 21:32:45 -0400
Received: (qmail invoked by alias); 07 May 2008 01:32:43 -0000
Received: from i577BA259.versanet.de (EHLO atjola.local) [87.123.162.89]
  by mail.gmx.net (mp009) with SMTP; 07 May 2008 03:32:43 +0200
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1+eKP9bFj6esBgrP81wk+wV/tS0lDivf2oatKyMMW
	lXMgwkj95CHysB
Content-Disposition: inline
In-Reply-To: <20080506175442.845ca8fa.akpm@linux-foundation.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81398>

On 2008.05.06 17:54:42 -0700, Andrew Morton wrote:
> On Tue, 6 May 2008 20:19:19 -0400 Jeff King <peff@peff.net> wrote:
>=20
> > On Tue, May 06, 2008 at 05:10:52PM -0700, Andrew Morton wrote:
> >=20
> > > > > y:/usr/src/git26> git-checkout master
> > > > > Switched to branch "master"
> > > > > y:/usr/src/git26> cat kernel/*.c|sum
> > > > > 34439  2057
> > > > > y:/usr/src/git26> git-checkout linux-next
> > > > > Switched to branch "linux-next"
> > > > > y:/usr/src/git26> cat kernel/*.c|sum    =20
> > > > > 34439  2057
> > > >=20
> > > > This is not a good indication of a failed checkout (they could =
point
> > > > to the same commit, for one).
> > >=20
> > > How could they?  linux-next includes a directory called ./Next an=
d a file
> > > in that directory called ./Next/Trees, and that is not present af=
ter the
> > > `git-checkout linux-next'.
> >=20
> > But you don't show us that in your example. There is nothing in you=
r
> > example to indicate that they are not simply pointing at the same
> > commit...
> >=20
> > > > Try "gitk master...linux-next" (or "git
> > > > log master..linux-next", "git diff master linux-next")
> > >=20
> > > These come up empty.  But there is a 12.4MB diff between mainline=
 and
> > > linux-next.
> >=20
> > And if these all come up empty, then they _are_ pointing to the sam=
e
> > commit. When you say "but there is a 12.4MB diff..." do you mean "t=
here
> > _should_ be such a diff?" In that case, it seems that your linux-ne=
xt
> > ref is pointing to an unexpected commit.
> >=20
> > So the problem is not with git-checkout, but rather that you are no=
t
> > checking out what you think you are checking out.
>=20
> That sounds a decent theory.
>=20
> > And so we need to
> > figure out how you got into that state.
>=20
> Well it happens pretty regularly.  I have now lost that state but I'l=
l save
> it next time.  I'm not able to pinpoint exactly what causes it to occ=
ur.
>=20
> > What command did you use to create the linux-next branch?
>=20
> I edited=20
>=20
> y:/usr/src/git26> cat .git/branches/linux-next=20
> git+ssh://master.kernel.org/pub/scm/linux/kernel/git/sfr/linux-next.g=
it
>=20
> and did git-fetch once per day, approx.
>=20
> > Have you used
> > git-reset to move the branch tip around?
>=20
> My git-fetching script does that:
>=20
> doit()
> {
> 	tree=3D$1
> 	upstream=3D$2
>=20
> 	cd $GIT_TREE
> 	git reset --hard "$upstream"
> 	git fetch "$tree" || exit 1
> 	git merge --no-commit 'test merge' HEAD FETCH_HEAD > /dev/null
>=20
> 	{
> 		git_header "$tree"
> 		git log --no-merges ORIG_HEAD..FETCH_HEAD
> 		git diff --patch-with-stat ORIG_HEAD
> 	} >$PULL/$tree.patch
> 	{
> 		echo DESC
> 		echo $tree.patch
> 		echo EDESC
> 		git_header "$tree"
> 		git log --no-merges ORIG_HEAD..FETCH_HEAD
> 	} >$PULL/$tree.txt
> 	git reset --hard "$upstream"
> }
>=20
> (Linus suggested an updated version of this but afaict that won't cha=
nge
> anything)
>=20
> But, as I say, usually this script leaves the tree in a sane state.  =
But
> sometimes it leaves it in a i-cant-check-stuff-out state.  It's not
> specific to linux-next, either: I've seen this for a long time, on an=
d off.
> Prior to linux-next's existence.

Hm, that very much looks like it would mess things up whenever you're
not on the upstream branch already.

While this should do no harm:
git checkout master
doit linux-next master

This will make your linux-next branch point to the same commit as
master:
git checkout linux-next
doit linux-next master

Adding a '"git checkout "$upstream"' (maybe with -f?) before the first
reset --hard should avoid that then.

Bj=F6rn
