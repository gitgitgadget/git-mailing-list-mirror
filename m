From: Eli Zaretskii <eliz@gnu.org>
Subject: Re: Switching from CVS to GIT
Date: Tue, 16 Oct 2007 06:30:11 +0200
Message-ID: <uodezisvg.fsf@gnu.org>
References: <1192293466.17584.95.camel@homebase.localnet> <uy7e6keyv.fsf@gnu.org>
 <1192381040.4908.57.camel@homebase.localnet> <1773C6F0-87BE-4F3C-B68A-171E1F32E242@lrde.epita.fr>
 <47125F74.9050600@op5.se> <Pine.LNX.4.64.0710141934310.25221@racer.site>
 <47126957.1020204@op5.se> <Pine.LNX.4.64.0710142112540.25221@racer.site>
 <20071014221446.GC2776@steel.home> <u7ilpjp3x.fsf@gnu.org> <Pine.LNX.4.64.0710151859590.7638@iabervon.org>
Reply-To: Eli Zaretskii <eliz@gnu.org>
Cc: raa.lkml@gmail.com, Johannes.Schindelin@gmx.de, ae@op5.se,
	tsuna@lrde.epita.fr, git@vger.kernel.org, make-w32@gnu.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Tue Oct 16 06:30:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ihe4d-0004ot-NL
	for gcvg-git-2@gmane.org; Tue, 16 Oct 2007 06:30:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753889AbXJPEaU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2007 00:30:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753840AbXJPEaT
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Oct 2007 00:30:19 -0400
Received: from romy.inter.net.il ([213.8.233.24]:26290 "EHLO romy.inter.net.il"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753340AbXJPEaS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Oct 2007 00:30:18 -0400
Received: from HOME-C4E4A596F7 (IGLD-84-229-211-164.inter.net.il [84.229.211.164])
	by romy.inter.net.il (MOS 3.7.3-GA)
	with ESMTP id JDA79309 (AUTH halo1);
	Tue, 16 Oct 2007 06:30:00 +0200 (IST)
In-reply-to: <Pine.LNX.4.64.0710151859590.7638@iabervon.org> (message from
	Daniel Barkalow on Mon, 15 Oct 2007 20:45:02 -0400 (EDT))
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/61073>

> Date: Mon, 15 Oct 2007 20:45:02 -0400 (EDT)
> From: Daniel Barkalow <barkalow@iabervon.org>
> cc: Alex Riesen <raa.lkml@gmail.com>, Johannes.Schindelin@gmx.de, ae@op5.se, 
>     tsuna@lrde.epita.fr, git@vger.kernel.org, make-w32@gnu.org
> 
> I believe the hassle is that readdir doesn't necessarily report a README in 
> a directory which is supposed to have a README, when it has a readme 
> instead.

Sorry I'm asking potentially stupid questions out of ignorance: why
would you want readdir to return `README' when you have `readme'?

> I think we want O(n) comparison of sorted lists, which doesn't 
> work if equivalent names don't sort the same.

You comparison function should be case-insensitive on Windows, or am I
missing something?

> > > - no acceptable level of performance in filesystem and VFS (readdir,
> > >   stat, open and read/write are annoyingly slow)
> > 
> > With what libraries?  Native `stat' and `readdir' are quite fast.
> > Perhaps you mean the ported glibc (libgw32c), where `readdir' is
> > indeed painfully slow, but then you don't need to use it.
> 
> We want getting stat info, using readdir to figure out what files exist, 
> for 106083 files in 1603 directories with a hot cache to take under 1s; 
> otherwise "git status" takes a noticeable amount of time with a medium-big 
> project, and we want people to be able to get info on what's changed 
> effectively instantly. My impression is that Windows' native stat and 
> readdir are plenty fast for what normal Windows programs want, but we 
> actually expect reasonable performance on an unreasonably-big 
> metadata-heavy input.

If that's the issue, then it's not a good idea to call `stat' and
`readdir' on Windows at all.  `stat' is a single system call on Posix
systems, while on Windows it usually needs to go out of its way
calling half a dozen system services to gather the `struct stat' info.
You need to call something like FindFirstFile, which can do the job of
`stat' and `readdir' together (and of `fnmatch', if you need to filter
only some files) in one go.  I don't know whether this will scan 100K
files under one second (maybe I will try it one of these days), but it
will definitely be faster than `readdir'+`stat' by maybe as much as an
order of magnitude.

> > > - no real "mmap" (which kills perfomance and complicates code)
> > 
> > You only need mmap because you are accustomed to use it on GNU/Linux.
> 
> I believe the need here is quick setup and fast access to sparse portions 
> of several 100M files. It's hard to beat a page fault for read speed.

If you need memory-mapped files, they are available on Windows.  I
thought the original comment about `mmap' was because it was used to
allocate memory, not read files into memory.

> We also expect to be able to make a sequence of file system operations 
> such that programs starting at any time see the same database as the files 
> containing the database get restructured.

Sorry, I don't understand this; please tell more about the operations,
``the same database'' issue (what database?) and what do you mean by
``the files containing the database get restructured''.

> A unixy pipeline was convenient

Windows supports pipelines with almost 100% the same functionality as
Posix.  Again, perhaps I'm missing something.
