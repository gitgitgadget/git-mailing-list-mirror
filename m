From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Huge win, compressing a window of delta runs as a unit
Date: Mon, 21 Aug 2006 02:46:59 -0400
Message-ID: <20060821064659.GB24054@spearce.org>
References: <9e4733910608161020s6855140bs68aaab6e1bbd3bad@mail.gmail.com> <Pine.LNX.4.64.0608172323520.11359@localhost.localdomain> <9e4733910608180553r34fa7b25he0bf910ef804630f@mail.gmail.com> <Pine.LNX.4.64.0608181226460.11359@localhost.localdomain> <9e4733910608180956n64e3362fm5c72d652e6b6243a@mail.gmail.com> <Pine.LNX.4.64.0608202257020.3682@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jon Smirl <jonsmirl@gmail.com>, git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Aug 21 08:47:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GF3Z9-0000YO-GO
	for gcvg-git@gmane.org; Mon, 21 Aug 2006 08:47:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030266AbWHUGrQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 21 Aug 2006 02:47:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030278AbWHUGrQ
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Aug 2006 02:47:16 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:35559 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1030266AbWHUGrP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Aug 2006 02:47:15 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GF3Yw-0001Eq-1F; Mon, 21 Aug 2006 02:47:06 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id E771D20FB7D; Mon, 21 Aug 2006 02:46:59 -0400 (EDT)
To: Nicolas Pitre <nico@cam.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0608202257020.3682@localhost.localdomain>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25781>

Nicolas Pitre <nico@cam.org> wrote:
> I looked at it too and the code looks OK.

Based on the stats Jon provided me it appeared as though the code
skipped about 9% of the objects, and at the time I thought I new
why but looking at it again right now I'm not sure why.  :-)

Assuming the objects were roughly the same size (probably a bad
assumption, but lets use it anyway) we're talking about approx. 9%
increase, bringing the size to around 360 MB.

Since that is still only blobs and lacks trees&commits, and you were
able to get a pack from the earlier import attempts down to 430 MB
(including trees&commits) everything you pointed out with regards
to delta base selection not being optimal is probably the major
culprit here.
 
> So I think that trying to make fastimport too clever is wrong.  It 
> should instead focus on creating an initial pack as fast as possible and 
> then rely on a final git-repack pass to produce the shrinked pack.  I 
> really doubt the import code could ever make a better job than 
> git-pack-objects does.

I'm mixed on that.

My goal with fast-import was to construct a pack as cheaply as
possible in such a way that IO is relatively minimized during
pack construction and later during an initial repacking, as well
as to avoid all fork'ing costs associated with many update-index
and repack calls.

fast-import is assuming the front end driving it is being somewhat
nice by feeding revisions in newest-oldest order, one file at a time.
If this assumption is false it will produce a pack but one that is
so large the IO to repack it will be horrible (but probably would
still be better than if these were all loose objects).

fast-import is also assuming that pack construction speed and memory
usage required to build that pack are more important than subsequent
reads of the resulting pack.

Why?

Because I fully expected the pack to undergo a `git-repack -a -d -f`
with a rather large delta depth before it really got used by
clients which cared about performance or disk space.  :-)

Whether or not git-repack can handle such a large pack is another
story.  Apparently it can already take a ~600 MB pack and do
something useful to it in a reasonable time span so I'm putting
any limits that might be in there off for now.


But the more I work with Jon on this Mozilla import process the more
I'm realizing that:

 - fast-import.c's other name is "GIT in 1325 lines of C code, all
   of which more or less already exists elsewhere in a form that
   wasn't useful in this context without refactoring it in major
   ways so I got lazy and rewrote it in another equally useless way";

 - the strategy of how I'm slamming a very large number of objects
   into a pack may be useful in situations other than a foreign
   SCM import process.  I can see someone wanting to create a
   large commit with a lot of modified objects.  Doing this with
   update-index and write-tree into loose objects would be far
   slower than just generating a new pack if the number of objects
   you are writing exceeds about 100 on Windows or ~1k on UNIX;

 - Jon has lots of CPU time to spare and possibly even some memory.
   fast-import is barely using CPU and barely uses memory (its quite
   lightweight!) but its definately producing a suboptimal pack
   as a result.  Just doing slightly better delta selection before
   committing an object to the output pack may prevent the need to
   use -f during git-repack and produce something almost as optimal.

Right now fast-import is only lacking the following major features,
at which point it *should* be able to process the entire Mozilla
repository, assuming Jon can get his symbol closing problem in
cvs2svn solved:

  - reload a branch which has been swapped out (requires reading
    the pack that is currently being constructed back into memory,
    which since its not really a valid pack yet and lacks an index
    reusing the code in sha1_file.c is slightly interesting);

  - generate a tag object into the pack;

  - track association ID numbers to SHA1 IDs (needed to properly
    create a branch from a prior commit or a tag from a prior commit
    as the prior commit's SHA ID isn't known to the front end);

Working on the multiple objects in one zlib stream code over the
weekend also showed me how to use sha1_file.c to perform the first
of the three (I think) and the remaining two are trivial.  So my
weekend wasn't a total loss.  :-)

I plan on getting that code finished up in the next day or so and
get a new draft of it off to Jon.  Maybe by then he'll also have
something coming out of cvs2svn's pass 9.

> > As comparison, I just tar/zipped the Mozilla CVS repo and it is 541MB.
> > The 295MB git pack number does not have commits and trees in it, it is
> > revisions only.
> 
> Running git-repack -a -f from a recent GIT on the Mozilla repo converted 
> through cvsps and friends produces a pack smaller than 500MB.  I even 
> brought it down to 430MB by using non default delta window and depth.

I'd still like to find a way to beat that 430 MB current
best-yet-still-valid size.  :-)

I think we'll get there.  Shaving off 4-5% with a pack specific
dictionary may be worthwhile on such large packs, especially ones
that are considered "historical" and probably will never get repacked
again.  Folding objects into a single zlib stream may also be worth
it, but for now I'm going to wait and see what mileage we can get
from the existing repack code and the existing pack file format.

-- 
Shawn.
