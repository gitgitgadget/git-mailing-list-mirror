From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Switching from CVS to GIT
Date: Mon, 15 Oct 2007 20:45:02 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0710151859590.7638@iabervon.org>
References: <1192293466.17584.95.camel@homebase.localnet> <uy7e6keyv.fsf@gnu.org>
 <1192381040.4908.57.camel@homebase.localnet> <1773C6F0-87BE-4F3C-B68A-171E1F32E242@lrde.epita.fr>
 <47125F74.9050600@op5.se> <Pine.LNX.4.64.0710141934310.25221@racer.site>
 <47126957.1020204@op5.se> <Pine.LNX.4.64.0710142112540.25221@racer.site>
 <20071014221446.GC2776@steel.home> <u7ilpjp3x.fsf@gnu.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Alex Riesen <raa.lkml@gmail.com>, Johannes.Schindelin@gmx.de,
	ae@op5.se, tsuna@lrde.epita.fr, git@vger.kernel.org,
	make-w32@gnu.org
To: Eli Zaretskii <eliz@gnu.org>
X-From: git-owner@vger.kernel.org Tue Oct 16 02:46:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IhaYg-0007id-Cc
	for gcvg-git-2@gmane.org; Tue, 16 Oct 2007 02:45:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757001AbXJPApG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Oct 2007 20:45:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754125AbXJPApG
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Oct 2007 20:45:06 -0400
Received: from iabervon.org ([66.92.72.58]:56255 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756822AbXJPApE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Oct 2007 20:45:04 -0400
Received: (qmail 3439 invoked by uid 1000); 16 Oct 2007 00:45:02 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 16 Oct 2007 00:45:02 -0000
In-Reply-To: <u7ilpjp3x.fsf@gnu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61058>

Responding only to those portions where I think Windows experience and a 
Windows perspective would be helpful...

On Mon, 15 Oct 2007, Eli Zaretskii wrote:

> > - no proper filename semantics (case-insensitivity and stupid rules for
> >   allowed characters in filenames, like ":" in filenames in
> >   cross-platform projects)
> 
> There's a flag on Windows to open files case-sensitively, if you need
> that.  In any case, I don't see how this can be of any real relevance
> to porting GIT.  As for ":" in file names, simply don't use it, like
> you don't use white space or characters below 32 decimal: it's
> inconvenient, even if it's allowed.

I believe the hassle is that readdir doesn't necessarily report a README in 
a directory which is supposed to have a README, when it has a readme 
instead. I think we want O(n) comparison of sorted lists, which doesn't 
work if equivalent names don't sort the same.

> > - no acceptable level of performance in filesystem and VFS (readdir,
> >   stat, open and read/write are annoyingly slow)
> 
> With what libraries?  Native `stat' and `readdir' are quite fast.
> Perhaps you mean the ported glibc (libgw32c), where `readdir' is
> indeed painfully slow, but then you don't need to use it.

We want getting stat info, using readdir to figure out what files exist, 
for 106083 files in 1603 directories with a hot cache to take under 1s; 
otherwise "git status" takes a noticeable amount of time with a medium-big 
project, and we want people to be able to get info on what's changed 
effectively instantly. My impression is that Windows' native stat and 
readdir are plenty fast for what normal Windows programs want, but we 
actually expect reasonable performance on an unreasonably-big 
metadata-heavy input. AFAICT, nothing but Linux is optimized for this, but 
we're used to being able to find out if there's any change to a large 
directory structure in practically no time. On the other hand, we really 
just want to beat users' expectations for this operation, not our own 
expectations, so this may only be a problem for people benchmarking 
Windows git against Linux git.

> > - no real "mmap" (which kills perfomance and complicates code)
> 
> You only need mmap because you are accustomed to use it on GNU/Linux.

I believe the need here is quick setup and fast access to sparse portions 
of several 100M files. It's hard to beat a page fault for read speed.

We also expect to be able to make a sequence of file system operations 
such that programs starting at any time see the same database as the files 
containing the database get restructured. My impression is that this is 
very hard or impossible with Windows, and also that it doesn't matter for 
Windows users, because they'll only have one program at a time accessing 
the repository. A lot of our filesystem demands are about making a wide 
variety of race conditions give the same result regardless of how the race 
goes, and we're just being overly careful for a Windows environment 
(although not necessarily for users with a UNIX background using Windows 
only because they have to).

> > - it has only one argument (limited in size) passed to started
> >   programs, which means that there is no possible way to safely pass
> >   file and text arguments on command line (more than one, that is)
> 
> Not enough context, so I cannot talk intelligently about this.  Why do
> you need interprocess communication in the first place? why not simply
> give birth to a subsidiary process and pass it a command line (which
> can be up to 32KB)?

A unixy pipeline was convenient, given what else we had already written. 
It's getting converted to single tasks, but it's not a top priority for 
most developers, since streaming 100M from one program to the next under 
most of our environments is trivial.

	-Daniel
*This .sig left intentionally blank*
