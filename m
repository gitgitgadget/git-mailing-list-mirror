From: "Robin H. Johnson" <robbat2@gentoo.org>
Subject: Re: Performance issue: initial git clone causes massive repack
Date: Mon, 6 Apr 2009 07:20:55 -0700
Message-ID: <20090406T140441Z@curie.orbis-terrarum.net>
References: <20090404220743.GA869@curie-int> <20090405195714.GA4716@coredump.intra.peff.net> <20090405T230552Z@curie.orbis-terrarum.net> <alpine.LFD.2.00.0904052336260.6741@xanadu.home>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="aTCJOP0qgkSGqHWA"
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Apr 06 16:22:42 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lqpij-0000iY-Qt
	for gcvg-git-2@gmane.org; Mon, 06 Apr 2009 16:22:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756633AbZDFOVF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Apr 2009 10:21:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756240AbZDFOVE
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Apr 2009 10:21:04 -0400
Received: from b01.ext.isohunt.com ([208.71.112.51]:39682 "EHLO
	mail.isohunt.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756520AbZDFOVD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Apr 2009 10:21:03 -0400
Received: (qmail 32494 invoked from network); 6 Apr 2009 14:20:58 -0000
Received: from tsi-static.orbis-terrarum.net (HELO curie.orbis-terrarum.net) (76.10.188.108)
  (smtp-auth username robbat2@isohunt.com, mechanism login)
  by mail.isohunt.com (qpsmtpd/0.33-dev on beta01) with (AES256-SHA encrypted) ESMTPSA; Mon, 06 Apr 2009 14:20:58 +0000
Received: (qmail 12738 invoked by uid 10000); 6 Apr 2009 07:20:55 -0700
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.0904052336260.6741@xanadu.home>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/115836>


--aTCJOP0qgkSGqHWA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Again, I'm about to leave on a trip for a few days (back late Thursday),
but just wanted to comment in on the thread.

On Mon, Apr 06, 2009 at 12:06:00AM -0400, Nicolas Pitre wrote:
> > While my current pack setup has multiple packs of not more than 100MiB
> > each, that was simply for ease of resume with rsync+http tests. Even
> > when I already had a single pack, with every object reachable,
> > pack-objects was redoing the packing.
> In that case it shouldn't have.
I'll retest that part on my return, but I'm pretty sure I did see the
same excess cputime usage.

> > Also, I did another trace, using some other hardware, in a LAN setting,=
 and
> > noticed that git-upload-pack/pack-objects only seems to start output to=
 the
> > network after it reaches 100% in 'remote: Compressing objects:'.
> That's to be expected.  Delta compression matches objects which are not=
=20
> in the stream order at all.  Therefore it is not possible to start=20
> outputting pack data until this pass is done.  Still, this pass should=20
> not be invoked if your repository is already fully packed into one pack. =
=20
So it's seeking around the existing packs before sending?

> Can you confirm this is actually the case?
The most recent tests were with the 15(+ one partial) packs limited to a
max of 100MiB each, because that made resume for rsync/http during the
tests much cleaner.

> > Relatedly, throwing more RAM (6GiB total, vs. the previous 2GiB) at=20
> > the server in this case cut the 200 wallclock minutes before any=20
> > sending too place down to 5 minutes.
> Well... here's a wild guess.  In the source repository serving clone=20
> requests, please do:
> 	git config pack.deltaCacheSize 1
> 	git config pack.deltaCacheLimit 0
> and try cloning again with a fully packed repository.
I did the multiple pack case quickly, and found that it does still take
a long time in the low memory case. I'll do the test with a single pack
on my return.

> The caching pack project is to address a different issue: mainly to=20
> bypass the object enumeration cost.  In other words, it could allow for=
=20
> skipping the "Counting objects" pass, and a tiny bit more.  At least in=
=20
> theory that's about the main difference.  This has many drawbacks as=20
> well though.
Relatedly, would it be possible to keep a cache of enumerated objects
that was trivially updatable during pushes?

--=20
Robin Hugh Johnson
Gentoo Linux Developer & Infra Guy
E-Mail     : robbat2@gentoo.org
GnuPG FP   : 11AC BA4F 4778 E3F6 E4ED  F38E B27B 944E 3488 4E85

--aTCJOP0qgkSGqHWA
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.10 (GNU/Linux)
Comment: Robbat2 @ Orbis-Terrarum Networks - The text below is a digital signature. If it doesn't make any sense to you, ignore it.

iEYEARECAAYFAknaD8cACgkQPpIsIjIzwixDqgCg2a9b330ShuFs1sdEw7PvDg+V
UOEAoJdi8q0wOtfJ1Wd+R7bH8zOwLqjM
=Q96T
-----END PGP SIGNATURE-----

--aTCJOP0qgkSGqHWA--
