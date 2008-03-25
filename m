From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: faster egit history page and a pure java "gitk"
Date: Tue, 25 Mar 2008 01:10:40 -0400
Message-ID: <20080325051040.GC4759@spearce.org>
References: <20080324092726.GQ8410@spearce.org> <200803241406.54759.robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "Roger C. Soares" <rogersoares@intelinet.com.br>,
	git@vger.kernel.org
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Tue Mar 25 06:11:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Je1RZ-0006nE-Np
	for gcvg-git-2@gmane.org; Tue, 25 Mar 2008 06:11:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754094AbYCYFKr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Mar 2008 01:10:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754054AbYCYFKr
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Mar 2008 01:10:47 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:38675 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752095AbYCYFKq (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2008 01:10:46 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1Je1Qn-0004ju-U4; Tue, 25 Mar 2008 01:10:42 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 9CA8520FBAE; Tue, 25 Mar 2008 01:10:40 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <200803241406.54759.robin.rosenberg@dewire.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78146>

Robin Rosenberg <robin.rosenberg@dewire.com> wrote:
> Den Monday 24 March 2008 09.27.26 skrev Shawn O. Pearce:
> >   git://repo.or.cz/egit/spearce.git plotter
> >
> > The history page has been completely replaced.
>
> The page was very messy. It was my first attempt at anything ui in
> Eclipse at all. Like a child drawing his first picture of a person :)

It was pretty good.  I actually learned from your work before
replacing it.  My motivation wasn't about the look, but about
the speed of it.  :)
 
> > There are huge benefits to this infrastructure:
> >
> >  * Fast as snot.  We are literally just 10-20 ms slower than C Git
> >    on the same hardware, same repository, for the same tree.  That
> >    is pretty damn good, given that we are in Java.
> 
> On what repo is that measured?

git.git, starting from 0e545f75169e2c260dfb4445203c23cafdfc76ef, which
is dated Dec 22 2007, so its a bit dated, but not too far back to be
completely useless.

git.git is a toy compared to other projects, yes, but its what I
had on hand in my egit work area.  I haven't tried larger projects
(like say linux-2.6 or OOo).

> As for Java speed, it is some two to three times slower than C on array 
> intensive stuff. On just about anything else the difference is less.

During this work I've found that even with Java 6's HotSpot the way
you write the code in Java affects how the JIT optimizes it.  In some
cases hand-unrolling loops (like say a 20 byte SHA-1 compare routine)
makes a big impact.  Using "p + 1", "p + 2", "p + 3" to access into the
array can be faster than "p++", "p++', "p++".
 
> The "Micro-optimize pack index v2 findOffset routine" commit suprises me
> a little.

Me too.  I assumed the compiler+JIT would be able to figure out that
"a * 5" can be rewritten as "a << 2 + a", but alas they didn't.  The
rewriting I did there was part of the boost I got.

> The rearranged ObjectId layout does not. Could we do even better
> using two long's and one int?

I actually started with the two long and one int layout but it was
quite a bit slower than the five int case.  Keep in mind this was
on a 32 bit Windows system; on an x86-64 or SPARC the two longs may
be faster due to the 64 bit registers being available to the JIT.
 
> >  * Lower memory usage.  By massive amounts.  I can't even begin to
> >    tell you how much different it is.  Histories that we could not
> >    show before can now be shown in <20M.  Our memory usage is much
> >    lower than that of gitk.
>
> This probably is related to speed too because the gc got to do a lot
> of work.

Yup.  The massive memory usage of the prior history view is actually
what drove me to do this work.  I was watching the memory meter on
the workbench while trying to open the history of my git.git clone
(HEAD is just pegged on the commit above) and realized something was
really wrong if we were spiking up through 150M and onward just to
pull up the history.  It also took several minutes.  :-|
 
> >  * Multiple path limiters.  You can select more than one resource
> >    (or directory!) at once and get the combined history for
> >    all of them at once.  This is basically the same path limiter
> >    algorithm that C Git/gitk rely upon for the same sort of query.
> >    It is still limited to a single-repository, but I think we could
> >    easily extend it to allow multiple-repository unions.  :-)
>
> You mean submodules, real and "virtual" ?

Yes.  Or if projects are in different repositories and the user
selects files in both and asks for history we could (in theory) show
a combined graph showing the commits from both repositories.  If they
have no sort of connected history you'll still get interleaved
timestamps, but there will be at least two lanes running down the
entire graph.

Most of the abstractions are there.  It shouldn't be difficult to
change RevWalk and TreeWalk to take some sort of new interface
instead of the Repository, where that interface can delegate
to either one Repository, or search through a set of packfiles
from multiple repositories, and then search through their loose
objects.  That's really all that should be needed to union together
repositories.
 
> >  * Common AWT and SWT drawing.  Most of the UI visualization code
> >    is implemented in shared code that has no AWT or SWT specifics
> >    about it.  This makes the renderer completely portable.  I have
> >    both an AWT and an SWT implementation running (compare from the
> >    command line "jgit glog HEAD" to the history view in Eclipse).
>
> Sweet. Needs some polishing though. At least under Linux and small screens
> with lots of pixels.

Yea, I agree.  I tried drawing it with 3 pixel wide rectangles
today but it looked like c**p^H^H^H^Hnot the best thing I have
ever written.  But it is more readable, so we'll have to come back
to that and see if we can't do better.
 
-- 
Shawn.
