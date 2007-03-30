From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: basics... when reading docs doesn't help
Date: Fri, 30 Mar 2007 11:48:54 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0703301126390.6730@woody.linux-foundation.org>
References: <Pine.LNX.4.60.0703292225100.10351@poirot.grange>
 <20070329211616.GH6143@fieldses.org> <7vabxv3fnx.fsf@assigned-by-dhcp.cox.net>
 <20070329214654.GI6143@fieldses.org> <Pine.LNX.4.60.0703292354100.10351@poirot.grange>
 <Pine.LNX.4.64.0703291531030.6730@woody.linux-foundation.org>
 <Pine.LNX.4.60.0703301855480.4757@poirot.grange>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "J. Bruce Fields" <bfields@fieldses.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
X-From: git-owner@vger.kernel.org Fri Mar 30 20:50:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HXMAm-0006Ch-Ed
	for gcvg-git@gmane.org; Fri, 30 Mar 2007 20:50:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751624AbXC3StQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 30 Mar 2007 14:49:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751696AbXC3StP
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Mar 2007 14:49:15 -0400
Received: from smtp.osdl.org ([65.172.181.24]:47998 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751624AbXC3StN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Mar 2007 14:49:13 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l2UImvrF006123
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 30 Mar 2007 11:48:58 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l2UImsLE002186;
	Fri, 30 Mar 2007 11:48:56 -0700
In-Reply-To: <Pine.LNX.4.60.0703301855480.4757@poirot.grange>
X-Spam-Status: No, hits=-0.463 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Fri, 30 Mar 2007, Guennadi Liakhovetski wrote:
> 
> Installed 1.5.0.6 and its output of "git count-objects" is
> 
> 180932 objects, 1112656 kilobytes

Yeah, that is all the loose objects. That's 1.1GB of stuff as loose 
objects, which also likely means that your tree was not only using up too 
much disk-space, it was probably running about ten times slower than than 
it needs to be for many operations.

Using pack-files ends up speeding up a lot of "big" operations a *lot*. If 
all you do is look at individual commits, you'll probably not notice much, 
but even something as simple as running "gitk" with no parameters (which 
will thus traverse the whole history) should be a *lot* faster after it's 
been all re-packed.

> git gc removed everything (uh?) and then

Well, it will generally remove all loose objects, since they get put into 
the pack-files instead. So it didn't remove "everything", but it does 
remove everything that "git count-objects" normally counts (if you give 
count-objects the "-v" flag for verbose output, it will talk about packed 
objects too).

> linux-2.6$ du -ks .git
> 183040  .git
> 
> cool...

That looks about right. Packing generally uses about a tenth of the 
disk-space of loose objects - both from the use of deltas, and from the 
fact that you don't any disk block fragmentation. And because looking at 
objects then doesn't require any system calls any more (just the initial 
"mmap pack and read index" stuff), it ends up being much faster too, 
despite the added overhead of doing the whole delta-chain thing.

> > > Unpacking 12452 objects
> > >  100% (12452/12452) done
> > > * refs/heads/origin: does not fast forward to branch 'master' of 
> > > git://git.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc;
> > >   not updating.
> > 
> > Sounds like either Paul re-based his tree, or you did some work on your 
> > "origin" branch..
> 
> It must be the former then:-) Did I have a chance to re-synchronize 
> locally to be able to pull normally again or was the only way to re-clone?

You need to mark "refs/heads/origin" as always following the remote 
"master", even if it gets re-based.  You do that by adding a "+" before 
the refspec that describes the remote.

These days, with git-1.5.x, "git clone" will do that for you (and make the 
remotes fall under "refs/remotes/origin/*" instead - they're considered 
separate branches from the local branches these days). However, since you 
created the repository with an older git version, it still uses the 
original format (and even though you upgraded your git binary, it will use 
the old-fashioned branch format for remote branches and for 
configuration).

So in your case, the remote is probably described by the 
.git/remotes/origin file, and it looks something like

	URL: git://git.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc
	Pull: master:origin

and you should just change that "Pull:" line to have a "+" in front of the 
refspec:

	URL: git://git.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc
	Pull: +master:origin

which tells git that the remote "master" branch should now 
*unconditionally* be followed into the local "origin" branch when you 
pull.

(In a more modern setup, you wouldn't have a .git/remotes/origin file at 
all, insead you would have something like this in the .git/config file:

	[remote "origin"]
		url = git://git.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc
		fetch = +refs/heads/*:refs/remotes/origin/*

	[branch "master"]
		remote = origin
		merge = refs/heads/master

which means that there is a remote called "origin", and all of the remote 
heads in that remote ("refs/heads/*") will be fetched into the local 
repository under "refs/remotes/origin/*". And the "+" again means that we 
do this even if it's not a fast-forward, ie we trust the remote 
explicitly.

So "git fetch origin" will fetch *all* branches from "origin" into your 
local repository, but to distinguish them from your *own* branches, they 
will be under .git/refs/remotes/ instead of your "real" local branches 
that are in ".git/refs/heads/. So you can now see the difference between 
your *local* version of a branch X and the remote version of that same 
branch by using "X" and "remotes/origin/X" respectively to describe that 
branch.

Then, the second part of the above config file means that when you're on 
the local "master" branch and do a "git pull", it will fetch it from the 
remote "origin", and merge the remote "refs/heads/master" branch from that 
remote (the same one that will be fetched into refs/remotes/origin/master 
by a "git fetch".

Yeah, this is all a bit complex, and it takes a while to wrap your head 
around it, but I have to say, once you do, the git-1.5.x layout really 
*is* very powerful, and it's actually very natural too (but the "very 
natural" part only comes after you have that "Aaahh!" moment!)

			Linus
