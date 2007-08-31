From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: repo.or.cz wishes?
Date: Fri, 31 Aug 2007 17:09:39 -0400
Message-ID: <20070831210938.GC18160@spearce.org>
References: <20070826235944.GM1219@pasky.or.cz> <Pine.LNX.4.64.0708270933450.28586@racer.site> <20070828041059.GK18160@spearce.org> <20070828111913.GA31120@thunk.org> <20070829041523.GS18160@spearce.org> <20070829111345.GD29615@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Fri Aug 31 23:09:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IRDkT-0007PF-Pf
	for gcvg-git@gmane.org; Fri, 31 Aug 2007 23:09:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761017AbXHaVJq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 31 Aug 2007 17:09:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760438AbXHaVJq
	(ORCPT <rfc822;git-outgoing>); Fri, 31 Aug 2007 17:09:46 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:49248 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759927AbXHaVJp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Aug 2007 17:09:45 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1IRDkC-00068U-Io; Fri, 31 Aug 2007 17:09:32 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 84C8520FBAE; Fri, 31 Aug 2007 17:09:39 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20070829111345.GD29615@thunk.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57210>

Theodore Tso <tytso@mit.edu> wrote:
> On Wed, Aug 29, 2007 at 12:15:23AM -0400, Shawn O. Pearce wrote:
> > > 
> > > git --git-dir=A gc
> > > ln A/.git/objects/pack/* B/.git/objects/pack
> > > git --git-dir=B gc --prune
> > > git --git-dir=A prune
> > 
> > No, it won't work.
> > 
> > The problem is that during the first `git --git-dir=A gc` call
> > you are deleting packfiles that may contain objects that B needs.
> > *poof*.  
> 
> But "git-gc" without the --prune doesn't delete any objects.

Yes, it does delete objects.  Even without --prune.  That is
because git-gc is running `git-repack -a -d -l`.  repack -a means
repack all objects reachable from the current refs.  The -d means
delete the packfiles that existed when the repack started, as it
is assumed that all needed (reachable) objects were copied into
the new output packfile(s).  The -d also means delete any loose
objects that are now packed (git-prune-packed).

Yet there may be objects in A that A cannot reach anymore (deleted
or rewound branch) but that B needs and B does not have a copy of.
If these objects were in one of the prior packfiles of A and is
not in the new packfile(s) of A then those objects are gone.  *poof*.

> So it
> should always be safe to use git-gc even if there are repositories
> that are relying on that repo's ODB.  It's only if you use git-gc
> --prune that you could get in troudble.  It might delete some
> packfiles containing objects needed by B, but only after consolidating
> all of the objects into a single packfile that contains all of the
> objects that had always been in A's ODB.

But when we repack we don't repack everything in A's ODB, we only
repack the things that A can reach.  If A cannot reach something
because a branch was rewound or deleted it won't survive the repack.
Then the repack is behaving like at least partially like gc --prune.
 
> So I don't see why this wouldn't work.

It only works if A cannot delete a branch or rewind a branch.
In other words, once an object is stored in A's ODB it must always
be reachable from A's refs.

-- 
Shawn.
