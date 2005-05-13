From: Matt Mackall <mpm@selenic.com>
Subject: Re: Mercurial 0.4e vs git network pull
Date: Thu, 12 May 2005 19:44:27 -0700
Message-ID: <20050513024427.GL5914@waste.org>
References: <20050513011149.GK5914@waste.org> <Pine.LNX.4.21.0505122148480.30848-100000@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@ucw.cz>,
	linux-kernel <linux-kernel@vger.kernel.org>, git@vger.kernel.org,
	mercurial@selenic.com, Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Fri May 13 04:37:27 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DWQ3F-0003ZL-Sr
	for gcvg-git@gmane.org; Fri, 13 May 2005 04:37:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262213AbVEMCo6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 May 2005 22:44:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262210AbVEMCo6
	(ORCPT <rfc822;git-outgoing>); Thu, 12 May 2005 22:44:58 -0400
Received: from waste.org ([216.27.176.166]:64992 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S262192AbVEMCof (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 12 May 2005 22:44:35 -0400
Received: from waste.org (localhost [127.0.0.1])
	by waste.org (8.13.4/8.13.4/Debian-1) with ESMTP id j4D2iRIf013182
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 12 May 2005 21:44:27 -0500
Received: (from oxymoron@localhost)
	by waste.org (8.13.4/8.13.4/Submit) id j4D2iRTl013179;
	Thu, 12 May 2005 21:44:27 -0500
To: Daniel Barkalow <barkalow@iabervon.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.21.0505122148480.30848-100000@iabervon.org>
User-Agent: Mutt/1.5.9i
X-Virus-Scanned: by amavisd-new
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Thu, May 12, 2005 at 10:23:01PM -0400, Daniel Barkalow wrote:
> On Thu, 12 May 2005, Matt Mackall wrote:
> 
> > On Thu, May 12, 2005 at 08:33:56PM -0400, Daniel Barkalow wrote:
> >
> > > Yes, although that also includes pulling the commits, and may be
> > > interleaved with pulling the trees and objects to cover the
> > > latency. (I.e., one round trip gets the new head hash; the second gets
> > > that commit; on the third the tree and the parent(s) can be requested at
> > > once; on the fouth the contents of the tree and the grandparents, at
> > > which point the bandwidth will probably be the limiting factor for the
> > > rest of the operation.)
> > 
> > What if a changeset is smaller than the bandwidth-delay product of
> > your link? As an extreme example, Mercurial is currently at a point
> > where its -entire repo- changegroup (set of all changesets) can be in
> > flight on the wire on a typical link.
> 
> If this is common for the repository in question, then it will be forced
> to wait for the parent to come in, true. If you have a number of merges,
> however, you start using more total bandwidth relative to latency while
> tracking them in parallel.

No, you're missing my point. If you can request all the files in a
changeset in less than a round-trip time, you have a pipeline stall.
Let's say a changeset is 10k and round trip time is 100ms. That means
you'll stall on any pipe with more than 100k/s. You won't know what
changeset to request next as it'll still be in flight.
 
> > > I must be misunderstanding your numbers, because 6 HTTP responses is more
> > > than 1K, ignoring any actual content from the server, and 1K for 800
> > > commits is less than 2 bytes per commit.
> > 
> > 1k of application-level data, sorry. And my whole point is that I
> > don't send those 800 commit identifiers (which are 40 bytes each as
> > hex). I send about 30 or so. It's basically a negotiation to find the
> > earliest commits not known to the client with a minimum of round trips
> > and data exchange.
> 
> Does this rely on the history being entirely linear? I suppose that
> requesting a rev-list from the server (which could have it as a static
> file generated when a new head was pushed) could jumpstart the
> process. The client could request all of the commits it doesn't have in
> rapid succession, and then request trees as the commits started coming
> in. Of course, this would get inefficient if you were, for example,
> pulling a merge with a branch with a long history, since you'd get a ton
> of old mainline (which you already have) interleaved with occasional new
> things.

I don't depend on history being linear (I'm not reinventing CVS here)
and I don't grab a list of all revisions (the point is to be
scalable). In fact, I do something fairly clever, and something I
don't think will work with git, because, yet again, it lacks the
metadata.

> > > I'm also worried about testing on 800 linear commits, since the projects
> > > under consideration tend to have very non-linear histories. 
> > 
> > Not true at all. Dumps from Andrew to Linus via patch bombs will
> > result in runs of hundreds of linear commits on a regular basis.
> > Linear patch series are the preferred way to make changes and series
> > of 30 or 40 small patches are not at all uncommon.
> 
> It has sounded like Andrew had some interest in using git, and a number of
> other developers are using it already. If this becomes still more common,
> it may be the case that, instead of sending patch bombs, Andrew will point
> Linus at authors' original series, in which case the mainline would be
> merges of a hundred linear series of various lengths. I had the
> impression, although I never looked carefully, that this was happening on
> a smaller scale with BK, where work by BK users got included using BK,
> rather than as patches applied out of a bomb.

Andrew already uses git, in a manner much like he used BK. He does a
pull from a repo, generates a patch of that repo vs mainline, and puts
that in -mm. And never passes that stuff on to Linus.

-- 
Mathematics is the supreme nostalgia of our time.
