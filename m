From: Eli Zaretskii <eliz@gnu.org>
Subject: Re: Switching from CVS to GIT
Date: Tue, 16 Oct 2007 02:25:21 -0400
Message-ID: <E1Ihfrl-0007w1-3I@fencepost.gnu.org>
References: <1192293466.17584.95.camel@homebase.localnet> <uy7e6keyv.fsf@gnu.org> <1192381040.4908.57.camel@homebase.localnet> <1773C6F0-87BE-4F3C-B68A-171E1F32E242@lrde.epita.fr> <47125F74.9050600@op5.se> <Pine.LNX.4.64.0710141934310.25221@racer.site> <47126957.1020204@op5.se> <Pine.LNX.4.64.0710142112540.25221@racer.site> <20071014221446.GC2776@steel.home> <u7ilpjp3x.fsf@gnu.org> <Pine.LNX.4.64.0710151859590.7638@iabervon.org> <uodezisvg.fsf@gnu.org> <471448D0.6080200@op5.se>
Reply-To: Eli Zaretskii <eliz@gnu.org>
Cc: barkalow@iabervon.org, raa.lkml@gmail.com,
	Johannes.Schindelin@gmx.de, tsuna@lrde.epita.fr,
	git@vger.kernel.org, make-w32@gnu.org
To: Andreas Ericsson <ae@op5.se>
X-From: git-owner@vger.kernel.org Tue Oct 16 08:25:44 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ihfs6-0003EL-4S
	for gcvg-git-2@gmane.org; Tue, 16 Oct 2007 08:25:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761034AbXJPGZX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2007 02:25:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760838AbXJPGZX
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 02:25:23 -0400
Received: from fencepost.gnu.org ([140.186.70.10]:52928 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1760337AbXJPGZV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2007 02:25:21 -0400
Received: from eliz by fencepost.gnu.org with local (Exim 4.60)
	(envelope-from <eliz@gnu.org>)
	id 1Ihfrl-0007w1-3I; Tue, 16 Oct 2007 02:25:21 -0400
In-reply-to: <471448D0.6080200@op5.se> (message from Andreas Ericsson on Tue,
	16 Oct 2007 07:14:56 +0200)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61092>

> Date: Tue, 16 Oct 2007 07:14:56 +0200
> From: Andreas Ericsson <ae@op5.se>
> CC: Daniel Barkalow <barkalow@iabervon.org>,  raa.lkml@gmail.com, 
>  Johannes.Schindelin@gmx.de,  tsuna@lrde.epita.fr,  git@vger.kernel.org, 
>  make-w32@gnu.org
> 
> > Sorry I'm asking potentially stupid questions out of ignorance: why
> > would you want readdir to return `README' when you have `readme'?
> > 
> 
> Because it might have been checked in as README, and since git is case
> sensitive that is what it'll think should be there when it reads the
> directories. If it's not, users get to see
> 
> 	removed: README
> 	untracked: readme

This is a non-issue, then: Windows filesystems are case-preserving, so
if `README' became `readme', someone deliberately renamed it, in which
case it's okay for git to react as above.

> could be an intentional rename, but we don't know for sure.

It _must_ have been an intentional rename.  While years ago there used
to be old DOS programs that could cause such a rename as a side effect
of modifying a file, that time is long gone.  There's no longer a need
to cater to such programs, as even DOS programs can support
case-preserving APIs on Windows.

> To be honest though, there are so many places which do the readdir+stat
> that I don't think it'd be worth factoring it out

Something for Windows users to decide, I guess.  It's not hard to
refactor this, it just needs a motivated volunteer.

> especially since it
> *works* on windows. It's just slow, and only slow compared to various
> unices.

I think only the Linux filesystem is as fast as you say.  But I may be
wrong (did someone compare with *BSD, say?).

> I *think* (correct me if I'm wrong) that git is still faster
> than a whole bunch of other scm's on windows, but to one who's used to
> its performance on Linux that waiting several seconds to scan 10k files
> just feels wrong.

Unless that 10K is a typo and you really meant 100K, I don't think 10K
files should take several seconds to scan on Windows.  I just tried
"find -print" on a directory with 32K files in 4K subdirectories, and
it took 8 sec elapsed with a hot cache.  So 10K files should take at
most 2 seconds, even without optimizing file traversal code.  Doing
the same with native Windows system calls ("dir /s") brings that down
to 4 seconds for 32K files.

On the other hand, what packages have 100K files?  If there's only one
-- the Linux kernel -- then I think this kind of performance is for
all practical purposes unimportant on Windows, because while it is
reasonable to assume that someone would like to use git on Windows,
assuming that someone will develop the Linux kernel on Windows is --
how should I put it -- _really_ far-fetched ;-)

As for speed of file ops ``just feeling wrong'': it's not limited to
git in any way.  You will see the same with "tar -x", with "find" and
even with "cp -r", when you compare Linux filesystems, especially on a
fast 64-bit machine, with comparable Windows operations.  A Windows
user who occasionally works on GNU/Linux already knows that, so seeing
the same in git will not come as a surprise.  Again, I wonder how this
compares with other free OSes, like FreeBSD (unless they use the same
filesystem), and with proprietary Unices, like AIX and Solaris.
