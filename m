From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Git benchmark - comparison with Bazaar, Darcs, Git and Mercurial
Date: Tue, 31 Jul 2007 22:17:52 -0400
Message-ID: <20070801021752.GF20052@spearce.org>
References: <200708010216.59750.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 01 04:18:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IG3mn-0001Ld-VZ
	for gcvg-git@gmane.org; Wed, 01 Aug 2007 04:18:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754626AbXHACSB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Tue, 31 Jul 2007 22:18:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754618AbXHACSB
	(ORCPT <rfc822;git-outgoing>); Tue, 31 Jul 2007 22:18:01 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:51575 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752747AbXHACSA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 31 Jul 2007 22:18:00 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1IG3mR-0001PB-H9; Tue, 31 Jul 2007 22:17:43 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 5F91E20FBAE; Tue, 31 Jul 2007 22:17:53 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <200708010216.59750.jnareb@gmail.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54397>

Jakub Narebski <jnareb@gmail.com> wrote:
> I have lately added new Git speed benchmark, from Bryan Murdock blog.=
=20
> The repository is bit untypical:
>=20
> <quote> =20
>   By performance, I mean that I used the UNIX time command to see how
>   long various basic operations took. Performing the various basic
>   operations gave me some insight into the usability of each as well.
>   For this test I used a directory with 266 MB of files, 258 KB of wh=
ich
>   were text files, with the rest being image files. I know, kind of
>   weird to version all those binary files, but that was the project I
>   was interested in testing this out on. Your mileage may vary and al=
l
>   that. Here=E2=80=99s a table summarizing the real times reported by=
 time(1):
> </quote>
>=20
> If I remember correctly there were some patches to git which tried to=
=20
> better deal with large blobs. In this simple benchmark git was=20
> outperformed by Mercurial and even Bazaar-NG a bit.

Yes.  And we backed them out more recently.  :-(

A while ago someone had issues with large binary blobs being added to
the repository as loose objects (e.g. by git-add/git-update-index).
Repacking that repository (for just git-gc or for transport/clone)
was ugly as the large binary blob had to be deflated then
reinflated to encode it in the packfile.  The solution was the
core.legacyheaders =3D false configuration setting, which used
packfile encoding for loose objects, thereby allowing the packer
to just copy the already compressed data into the output packfile.

Unfortunately we backed that out recently to "simplify the code".
We can still read that loose object format, but we cannot create
it and during packing we don't copy the data (we deflate/inflate
anyway).  So we're back to the horrible deflate/inflate problem.
That probably explains the large clone time seen by the author.

I wonder if hg realizes that the two repositories are on the
same filesystem and automatically uses hardlinks if possible (aka
git clone -l).  That would easily explain how they can clone so
dang fast.  Maybe we should do the same in git-clone, its a pretty
simple thing to do.


I do have to question the author's timing method.  I don't know if
this was hot-cache or not, and he doesn't say.  I don't know if the
system was 100% idle when running these times, or the times were
averaged over a few runs.  Usually the first run of anything can
give inaccurate timings, as for example the executable code may
not be paged in from disk.  One of the tools may have had a bias
as maybe he poked around with that tool first, before starting the
timings, so its executables were still hot in cache.  Etc.

However assuming everything was actually done in a way that the
timings can be accurately relied upon...

Regarding the initial file import it looks like we about broke even
with bzr if you add the "initial file import" and "initial commit"
times together.  Remember we have to hash and compress the data
during git-add; bzr probably delayed their equivilant operation(s)
until the commit operation.  Summing these two times is probably
needed to really compare them.

We were also rather close to hg if you again sum the times up.
But we do appear to be slower, by about 27s.  I guess I find that
hard to believe, but sure, maybe hg somehow has a faster codepath
for their file revision disk IO than we do.  Maybe its because hg
is streaming data and we're loading it all in-core first; maybe the
author's system had to swap get enough virtual memory for git-add.
Maybe it is just because the author's testing methodology was not
very good and one or more of these numbers are just bunk.


Our merge time is pretty respectible giving the competition.
Its probably within the margin of error of the author's testing
methodology.
=20
--=20
Shawn.
