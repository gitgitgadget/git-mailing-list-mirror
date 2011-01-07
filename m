From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: Resumable clone/Gittorrent (again) - stable packs?
Date: Thu, 06 Jan 2011 23:33:51 -0500 (EST)
Message-ID: <alpine.LFD.2.00.1101062221480.22191@xanadu.home>
References: <AANLkTikv+L5Da7A5VM7BAgnue=m0O_-nHmHchJzfGxJa@mail.gmail.com>
 <alpine.LFD.2.00.1101061552580.22191@xanadu.home>
 <AANLkTikgzqoG2cymNJ0NN03RsTRJi22R9M+0LFJ8U2yB@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="Boundary_(ID_I1Oht3+7w2/51e6GYTu8Xg)"
Cc: git@vger.kernel.org
To: Zenaan Harkness <zen@freedbms.net>
X-From: git-owner@vger.kernel.org Fri Jan 07 05:33:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pb41W-0004Zw-Dp
	for gcvg-git-2@lo.gmane.org; Fri, 07 Jan 2011 05:33:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754823Ab1AGEdw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Jan 2011 23:33:52 -0500
Received: from relais.videotron.ca ([24.201.245.36]:49713 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752957Ab1AGEdw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Jan 2011 23:33:52 -0500
Received: from xanadu.home ([66.130.28.92]) by vl-mh-mrz21.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0LEM00B4GXZWR1C0@vl-mh-mrz21.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 06 Jan 2011 23:33:32 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <AANLkTikgzqoG2cymNJ0NN03RsTRJi22R9M+0LFJ8U2yB@mail.gmail.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164699>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--Boundary_(ID_I1Oht3+7w2/51e6GYTu8Xg)
Content-type: TEXT/PLAIN; charset=ISO-8859-1
Content-transfer-encoding: 8BIT

On Fri, 7 Jan 2011, Zenaan Harkness wrote:

> On Fri, Jan 7, 2011 at 08:09, Nicolas Pitre <nico@fluxnic.net> wrote:
> > On Thu, 6 Jan 2011, Zenaan Harkness wrote:
> >
> >> Bittorrent requires some stability around torrent files.
> >>
> >> Can packs be generated deterministically?
> >
> > They _could_, but we do _not_ want to do that.
> >
> > The only thing which is stable in Git is the canonical representation of
> > objects, and the objects they depend on, expressed by their SHA1
> > signature.  Any BitTorrent-alike design for Git must be based on that
> > property and not the packed representation of those objects which is not
> > meant to be stable.
> >
> > If you don't want to design anything and simply reuse current BitTorrent
> > codebase then simply create a Git bundle from some release version and
> > seed that bundle for a sufficiently long period to be worth it.  Then
> > falling back to git fetch in order to bring the repo up to date with the
> > very latest commits should be small and quick.  When that clone gets too
> > big then it's time to start seeding another more up-to-date bundle.
> 
> Thanks guys for the explanations.
> 
> So, we don't _want_ to generate packs deterministically.
> BUT, we _can_ reliably unpack a pack (duh).

Of course.

> So if my configured "canonical upstream" decides on a particular
> compression etc, I (my git client) doesn't care what has been chosen
> by my upstream.

Indeed.  This is like saying: I'm sending you the value 52, but I chose 
to use the representation "24 + 28", while someone else might decide to 
encode that value as "13 * 4" instead.  You still are able to decode it 
to the same result in both cases.

> What is important for torrent-able packs though is stability over some
> time period, no matter what the format.

Hence my suggestion to simply seed a Git bundle over BitTorrent. Bundles 
are files which are designed to be used by completely ad hoc transports 
and you can fetch from them just like if they were a remote repository.

> There's been much talk of caching, invalidating of caches, overlapping
> torrent-packs etc.

And in my humble opinion this is just all crap.  All those suggestions 
are fragile, create administrative issues, eat up server resources, and 
they all are suboptimal in the end. No one ever implemented a working 
prototype so far either.

We don't want caches.  Fundamentally, we do not need any cache.  Caches 
are a pain to administrate on a busy server anyway as they eat disk 
space and they also represent a much bigger security risk compared to a 
read-only operation.

Furthermore, a cache is good only for the common case that everyone 
want.  but with Git, you cannot presume that everyone is at the same 
version locally.  So either you do a custom transfer for each client to 
minimize transfers and caching the result in that case might not benefit 
that many people, or you make the cached data bigger so to cover more 
cases while making the transfer suboptimal.

Finally, we do have a cache already, and that's the existing packs 
themselves.  During a clone, the vast majority of the transferred data 
is streamed without further processing straight of those existing packs 
as we try to reuse as much data as possible from those packs so not to 
recompute/recompress that data all the time.

> In every case, for torrents to work, the P2P'd files must have some
> stability over some time period.
> (If this assumption is incorrect, please clarify, not counting
> every-file-is-a-torrent and every-commit-is-a-torrent.)
> 
> So, torrentable options:
> - torrent per commit
> - torrent per pack
> - torrent per torrent-archive - new file format
> 
> Torrent per commit - too small, too many torrents; we need larger
> p2p-able sizes in general.
> 
> Torrent per pack - packs non-deterministically created, both between
> hosts and even intra-host (libz upgrade, nr_threads change, git pack
> algorithm optimization).
> 
> A new torrent format, if "close enough" to current git pack
> performance (cpu load, threadability, size) is potential for new
> version of git pack file format - we don't want to store two sets of
> pack files on disk, if sensible to not do so; unlikely to happen - I
> can't conceive that a torrentable format would be anything but worse
> than pack files and therefore would be rejected from git master.
> 
> Can we can relax the perceived requirement to deterministically create
> pack files?
> Well, over what time period are pack files stable in a particular git?
> Over what time period do we require stable files for torrenting?
> 
> Can we simply configure our local git to keep specified pack files for
> specified time period?
> And use those for torrent-packs?
> Perhaps the torrent file could have a UseBy date?

Again, this is just too much complexity for so little gain.

Here's what I suggest:

	cd my_project
	BUNDLENAME=my_project_$(date "+%s").gitbundle
	git bundle create $BUNDLENAME --all
	maketorrent-console your_favorite_tracker $BUNDLENAME

Then start seeding that bundle, and upload $BUNDLENAME.torrent as 
bundle.torrent inside my_project.git on your server.

Now... Git clients could be improved to first check for the availability 
of the file "bundle.torrent" on the remote side, either directly in 
my_project.git, or through some Git protocol extension.  Or even better, 
the torrent hash could be stored in a Git ref, such as 
refs/bittorrent/bundle and the client could use that to retrieve the 
bundle.torrent file through some other means.

When the bundle.torrent file is retrieved, then just pull the torrent 
content (and seed it some more to be nice).  Then simply run "git clone" 
using the original arguments but with the obtained bundle instead of the 
original URL.  Then replace the remote URL in .git/config with the 
actual remote URL instead of the bundle file path.  And finally perform 
a "git pull" to bring the new commits that were added to the remote 
repository since the bundle was created.  That final pull will be small 
and quick.

After a while, that final pull will get bigger as the difference between 
the bundled version and the current tip in the remote repository will 
grow.  So every so often, say 3 months, it might be a good idea to 
create a new bundle so that the latest commits are included into it in 
order to make that final pull small and quick again.

Isn't that sufficient?


Nicolas

--Boundary_(ID_I1Oht3+7w2/51e6GYTu8Xg)--
