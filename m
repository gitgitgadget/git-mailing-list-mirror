From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Subject: Re: basics... when reading docs doesn't help
Date: Fri, 30 Mar 2007 21:49:20 +0200 (CEST)
Message-ID: <Pine.LNX.4.60.0703302135590.10784@poirot.grange>
References: <Pine.LNX.4.60.0703292225100.10351@poirot.grange>
 <20070329211616.GH6143@fieldses.org> <7vabxv3fnx.fsf@assigned-by-dhcp.cox.net>
 <20070329214654.GI6143@fieldses.org> <Pine.LNX.4.60.0703292354100.10351@poirot.grange>
 <Pine.LNX.4.64.0703291531030.6730@woody.linux-foundation.org>
 <Pine.LNX.4.60.0703301855480.4757@poirot.grange>
 <Pine.LNX.4.64.0703301126390.6730@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "J. Bruce Fields" <bfields@fieldses.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Mar 30 21:49:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HXN6G-0001qO-7T
	for gcvg-git@gmane.org; Fri, 30 Mar 2007 21:49:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752775AbXC3TtZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 30 Mar 2007 15:49:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752803AbXC3TtZ
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Mar 2007 15:49:25 -0400
Received: from mail.gmx.net ([213.165.64.20]:35262 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752775AbXC3TtY (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Mar 2007 15:49:24 -0400
Received: (qmail invoked by alias); 30 Mar 2007 19:49:21 -0000
Received: from dynamic-unidsl-85-197-31-110.westend.de (EHLO poirot.grange) [85.197.31.110]
  by mail.gmx.net (mp041) with SMTP; 30 Mar 2007 21:49:21 +0200
X-Authenticated: #20450766
X-Provags-ID: V01U2FsdGVkX19mc1xjVKlmK+BeHT2DHBf4JhxWJKGAvsUyahLcuq
	7b5uHV2ayr4snV
Received: from lyakh (helo=localhost)
	by poirot.grange with local-esmtp (Exim 3.36 #1 (Debian))
	id 1HXN68-0003UT-00; Fri, 30 Mar 2007 21:49:20 +0200
In-Reply-To: <Pine.LNX.4.64.0703301126390.6730@woody.linux-foundation.org>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Fri, 30 Mar 2007, Linus Torvalds wrote:
> 
> You need to mark "refs/heads/origin" as always following the remote 
> "master", even if it gets re-based.  You do that by adding a "+" before 
> the refspec that describes the remote.
> 
> These days, with git-1.5.x, "git clone" will do that for you (and make the 
> remotes fall under "refs/remotes/origin/*" instead - they're considered 
> separate branches from the local branches these days). However, since you 
> created the repository with an older git version, it still uses the 
> original format (and even though you upgraded your git binary, it will use 
> the old-fashioned branch format for remote branches and for 
> configuration).
> 
> So in your case, the remote is probably described by the 
> .git/remotes/origin file, and it looks something like
> 
> 	URL: git://git.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc
> 	Pull: master:origin
> 
> and you should just change that "Pull:" line to have a "+" in front of the 
> refspec:
> 
> 	URL: git://git.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc
> 	Pull: +master:origin
> 
> which tells git that the remote "master" branch should now 
> *unconditionally* be followed into the local "origin" branch when you 
> pull.
> 
> (In a more modern setup, you wouldn't have a .git/remotes/origin file at 
> all, insead you would have something like this in the .git/config file:
> 
> 	[remote "origin"]
> 		url = git://git.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc
> 		fetch = +refs/heads/*:refs/remotes/origin/*
> 
> 	[branch "master"]
> 		remote = origin
> 		merge = refs/heads/master
> 
> which means that there is a remote called "origin", and all of the remote 
> heads in that remote ("refs/heads/*") will be fetched into the local 
> repository under "refs/remotes/origin/*". And the "+" again means that we 
> do this even if it's not a fast-forward, ie we trust the remote 
> explicitly.
> 
> So "git fetch origin" will fetch *all* branches from "origin" into your 
> local repository, but to distinguish them from your *own* branches, they 
> will be under .git/refs/remotes/ instead of your "real" local branches 
> that are in ".git/refs/heads/. So you can now see the difference between 
> your *local* version of a branch X and the remote version of that same 
> branch by using "X" and "remotes/origin/X" respectively to describe that 
> branch.
> 
> Then, the second part of the above config file means that when you're on 
> the local "master" branch and do a "git pull", it will fetch it from the 
> remote "origin", and merge the remote "refs/heads/master" branch from that 
> remote (the same one that will be fetched into refs/remotes/origin/master 
> by a "git fetch".
> 
> Yeah, this is all a bit complex, and it takes a while to wrap your head 
> around it, but I have to say, once you do, the git-1.5.x layout really 
> *is* very powerful, and it's actually very natural too (but the "very 
> natural" part only comes after you have that "Aaahh!" moment!)

Aha, so, that's how it is then! Why hasn't anybody explained this to me 
strait away?!:-))))

Yeah, hopefully, I'll learn to at least use this thing efficiently enough. 
Someone has to write a book on it though...

And, so, it's a pity I cloned Paul's tree yesterday with the "old" git. 
And from your answer above it seems like some features of the "new" git 
will not be available with this tree, like equally named local and remote 
branches, etc. There isn't a way to convert such a "old style" tree to the 
"new style", is there? Not a big deal, will re-clone at some point, maybe 
when we get local git mirrors...

Many thanks for taking your time to answer, Linus!
Guennadi
---
Guennadi Liakhovetski
