From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Switching from CVS to GIT
Date: Tue, 16 Oct 2007 03:07:12 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0710160229520.7638@iabervon.org>
References: <1192293466.17584.95.camel@homebase.localnet> <uy7e6keyv.fsf@gnu.org>
 <1192381040.4908.57.camel@homebase.localnet> <1773C6F0-87BE-4F3C-B68A-171E1F32E242@lrde.epita.fr>
 <47125F74.9050600@op5.se> <Pine.LNX.4.64.0710141934310.25221@racer.site>
 <47126957.1020204@op5.se> <Pine.LNX.4.64.0710142112540.25221@racer.site>
 <20071014221446.GC2776@steel.home> <u7ilpjp3x.fsf@gnu.org>
 <Pine.LNX.4.64.0710151859590.7638@iabervon.org> <uodezisvg.fsf@gnu.org>
 <471448D0.6080200@op5.se> <E1Ihfrl-0007w1-3I@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Andreas Ericsson <ae@op5.se>, raa.lkml@gmail.com,
	Johannes.Schindelin@gmx.de, tsuna@lrde.epita.fr,
	git@vger.kernel.org, make-w32@gnu.org
To: Eli Zaretskii <eliz@gnu.org>
X-From: git-owner@vger.kernel.org Tue Oct 16 09:07:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhgWW-0000pK-Cx
	for gcvg-git-2@gmane.org; Tue, 16 Oct 2007 09:07:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755510AbXJPHHP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2007 03:07:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755167AbXJPHHP
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 03:07:15 -0400
Received: from iabervon.org ([66.92.72.58]:36973 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754626AbXJPHHO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2007 03:07:14 -0400
Received: (qmail 16477 invoked by uid 1000); 16 Oct 2007 07:07:12 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 16 Oct 2007 07:07:12 -0000
In-Reply-To: <E1Ihfrl-0007w1-3I@fencepost.gnu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61098>

On Tue, 16 Oct 2007, Eli Zaretskii wrote:

> > Date: Tue, 16 Oct 2007 07:14:56 +0200
> > From: Andreas Ericsson <ae@op5.se>
> > CC: Daniel Barkalow <barkalow@iabervon.org>,  raa.lkml@gmail.com, 
> >  Johannes.Schindelin@gmx.de,  tsuna@lrde.epita.fr,  git@vger.kernel.org, 
> >  make-w32@gnu.org
> > 
> > > Sorry I'm asking potentially stupid questions out of ignorance: why
> > > would you want readdir to return `README' when you have `readme'?
> > > 
> > 
> > Because it might have been checked in as README, and since git is case
> > sensitive that is what it'll think should be there when it reads the
> > directories. If it's not, users get to see
> > 
> > 	removed: README
> > 	untracked: readme
> 
> This is a non-issue, then: Windows filesystems are case-preserving, so
> if `README' became `readme', someone deliberately renamed it, in which
> case it's okay for git to react as above.
> 
> > could be an intentional rename, but we don't know for sure.
> 
> It _must_ have been an intentional rename.  While years ago there used
> to be old DOS programs that could cause such a rename as a side effect
> of modifying a file, that time is long gone.  There's no longer a need
> to cater to such programs, as even DOS programs can support
> case-preserving APIs on Windows.

I'm partially worried about cases where checking out a "README" fails to 
replace the name of an existing "readme", or something of that sort.

> > To be honest though, there are so many places which do the readdir+stat
> > that I don't think it'd be worth factoring it out
> 
> Something for Windows users to decide, I guess.  It's not hard to
> refactor this, it just needs a motivated volunteer.
> 
> > especially since it
> > *works* on windows. It's just slow, and only slow compared to various
> > unices.
> 
> I think only the Linux filesystem is as fast as you say.  But I may be
> wrong (did someone compare with *BSD, say?).

I think you're right (nothing else can compete with Linux for doing half a 
million trivial syscalls), but other unixes aren't terrible, either. 
IIRC, on OS X, we had problems when we were doing 4 times as many syscalls 
as necessary, but was fine with that fixed.

> > I *think* (correct me if I'm wrong) that git is still faster
> > than a whole bunch of other scm's on windows, but to one who's used to
> > its performance on Linux that waiting several seconds to scan 10k files
> > just feels wrong.
> 
> Unless that 10K is a typo and you really meant 100K, I don't think 10K
> files should take several seconds to scan on Windows.  I just tried
> "find -print" on a directory with 32K files in 4K subdirectories, and
> it took 8 sec elapsed with a hot cache.  So 10K files should take at
> most 2 seconds, even without optimizing file traversal code.  Doing
> the same with native Windows system calls ("dir /s") brings that down
> to 4 seconds for 32K files.
> 
> On the other hand, what packages have 100K files?  If there's only one
> -- the Linux kernel -- then I think this kind of performance is for
> all practical purposes unimportant on Windows, because while it is
> reasonable to assume that someone would like to use git on Windows,
> assuming that someone will develop the Linux kernel on Windows is --
> how should I put it -- _really_ far-fetched ;-)

Actually, there are a number of projects much bigger than the Linux 
kernel; I think KDE was considering using git, and wanted Windows support, 
and KDE is insanely huge, mostly as a result of having one big repository 
for everything.

> As for speed of file ops ``just feeling wrong'': it's not limited to
> git in any way.  You will see the same with "tar -x", with "find" and
> even with "cp -r", when you compare Linux filesystems, especially on a
> fast 64-bit machine, with comparable Windows operations.  A Windows
> user who occasionally works on GNU/Linux already knows that, so seeing
> the same in git will not come as a surprise.  Again, I wonder how this
> compares with other free OSes, like FreeBSD (unless they use the same
> filesystem), and with proprietary Unices, like AIX and Solaris.

For most things, Unix filesystems are fast enough that the bulk of the 
time is spent elsewhere. "git status" without any changes and a hot cache 
is unusual in being both a common operation and entirely trivial syscalls 
if the filesystem makes it efficient.

The problem we've had is that Linux users who occasionally work on Windows 
say git seems impossibly slow on Windows.

	-Daniel
*This .sig left intentionally blank*
