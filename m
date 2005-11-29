From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH] Re: keeping remote repo checked out?
Date: Tue, 29 Nov 2005 01:02:07 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0511282337170.25300@iabervon.org>
References: <m3k6et9rdw.fsf@lugabout.cloos.reno.nv.us>
 <7vbr051ad1.fsf@assigned-by-dhcp.cox.net> <20051128105736.GO22159@pasky.or.cz>
 <7vsltgtvk4.fsf@assigned-by-dhcp.cox.net> <20051128212804.GV22159@pasky.or.cz>
 <Pine.LNX.4.64.0511281420390.3263@g5.osdl.org> <Pine.LNX.4.64.0511281845280.25300@iabervon.org>
 <Pine.LNX.4.64.0511281637480.3177@g5.osdl.org> <Pine.LNX.4.64.0511282027360.25300@iabervon.org>
 <Pine.LNX.4.64.0511281837040.3177@g5.osdl.org> <Pine.LNX.4.64.0511282208050.25300@iabervon.org>
 <Pine.LNX.4.64.0511282029290.3177@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Petr Baudis <pasky@suse.cz>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 29 07:11:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EgyYg-0004Io-SC
	for gcvg-git@gmane.org; Tue, 29 Nov 2005 07:01:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751262AbVK2GBk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 29 Nov 2005 01:01:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751266AbVK2GBk
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Nov 2005 01:01:40 -0500
Received: from iabervon.org ([66.92.72.58]:39432 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S1751262AbVK2GBj (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Nov 2005 01:01:39 -0500
Received: (qmail 4682 invoked by uid 1000); 29 Nov 2005 01:02:07 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 29 Nov 2005 01:02:07 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0511282029290.3177@g5.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12920>

On Mon, 28 Nov 2005, Linus Torvalds wrote:

> On Mon, 28 Nov 2005, Daniel Barkalow wrote:
> > 
> > I was planning to keep it in .git (instead of .git/refs/...), because it's 
> > information about the working tree, not properly part of the repository. 
> > It's like MERGE_HEAD in being about what the user is in the middle of.
> 
> That's fine.
> 
> However, your patch isn't.
> 
> Your patch just creates this eternal confusion of "why is HEAD different 
> from CHECKED_OUT". 
> 
> It's really easy to do what you want to do _without_ any tool changes:
> 
> 	git-rev-parse HEAD > .git/CHECKED_OUT
> 	rm .git/HEAD
> 	ln -s refs/heads/../../CHECKED_OUT .git/HEAD
> 
> and you're done. No tool changes necessary.
> 
> Now "HEAD" always points to the checked-out thing, but a "git clone" won't 
> ever actually clone your CHECKED_OUT branch.

But CHECKED_OUT isn't a branch. The whole point of it is that you stay on 
some real branch, so you can actually use the tools to affect the 
repository (i.e., the things under refs/). The reason to keep CHECKED_OUT 
is so that you can tell if the branch you're on changes out from under 
you.

For example, I want to have a repository where I push into the 
"production" branch, and I want to be able to get these changes in the 
working tree that the repository is in. If I have HEAD point to 
refs/heads/production, git doesn't know any more what's in the working 
tree, so it can't do the two-way merge. If I have HEAD point to 
CHECKED_OUT, git doesn't know any more what I want to get, so it can't do 
the two-way merge. That is, what I want to have work is:

  server$ git checkout production
  work$ git push server:production
  server$ git checkout

and this should leave the working tree on server with the changes pushed 
from work. Currently, I have to make sure server *isn't* tracking the 
branch I care about when the push happens, so that it doesn't lose track 
of its state, and then switch to the branch to get the changes, and copy 
the branch to a new branch, and switch to that so the next branch won't 
mess up the state.

HEAD is a symbolic ref to the ref in the repository that is the current 
branch. CHECKED_OUT is a ref to the hash that's in the working tree. 
Usually they match, because usually nothing is changing current branch 
without changing the working tree (or making the current branch match 
changes in the working tree), but the point of the patch is to respond 
sensibly to cases where this stops being true, because those can actually 
be part of desirable usage patterns.

	-Daniel
*This .sig left intentionally blank*
