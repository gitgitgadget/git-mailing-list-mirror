From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: keeping remote repo checked out?
Date: Mon, 28 Nov 2005 19:19:05 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0511281845280.25300@iabervon.org>
References: <m3k6et9rdw.fsf@lugabout.cloos.reno.nv.us>
 <7vbr051ad1.fsf@assigned-by-dhcp.cox.net> <20051128105736.GO22159@pasky.or.cz>
 <7vsltgtvk4.fsf@assigned-by-dhcp.cox.net> <20051128212804.GV22159@pasky.or.cz>
 <Pine.LNX.4.64.0511281420390.3263@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Petr Baudis <pasky@suse.cz>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 29 01:19:51 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EgtCi-0002yf-KJ
	for gcvg-git@gmane.org; Tue, 29 Nov 2005 01:18:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932277AbVK2ASh (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 28 Nov 2005 19:18:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932285AbVK2ASh
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Nov 2005 19:18:37 -0500
Received: from iabervon.org ([66.92.72.58]:61701 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S932277AbVK2ASh (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Nov 2005 19:18:37 -0500
Received: (qmail 29219 invoked by uid 1000); 28 Nov 2005 19:19:05 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 28 Nov 2005 19:19:05 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0511281420390.3263@g5.osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12911>

On Mon, 28 Nov 2005, Linus Torvalds wrote:

> On Mon, 28 Nov 2005, Petr Baudis wrote:
> > 
> > >  - should it do 'git-checkout', 'git-reset --hard HEAD', or
> > >    'git-pull . branch_to_push_into'?  The former two pretty much
> > >    assumes no development happens on the server repository and
> > >    git push is used primarily as an installation mechanism.
> > 
> > Files should be removed properly, which pretty much excludes the former
> > two, I think.
> 
> There are major locking issues with two people pushing at the same time.
> 
> The git logic does the right thing for a non-checked-out branch, but it 
> can do the right thing exactly _because_ it's not checked out. It can 
> create all the new objects whether the actual push succeeds or not, and it 
> can do the final switch-over as a single atomic file operation.
> 
> The same is most emphatically _not_ true of "git checkout".
> 
> In other words, you need to add your very own locking for the shared 
> checked-out tree, and you need to (_within_ that lock) separately remember 
> what the _previous_ tree was that was checked out, because you can't just 
> rely on the previous head as reported by git, because that will have been 
> done ourside your "checked out lock".

We really ought to keep track of what the current checked out tree is, 
independant of the head that it's supposed to match. Then it would be safe 
to push to a head that's checked out (it wouldn't update it, but the 
system would understand what's going on).

The rest should be easy from there, just by locking on that file, since 
you probably don't care about the race between checking out the head and 
updating the head. (You would want to have the case for not getting the 
lock loop until it can get the lock, rather than aborting, however, so 
that the last version does get checked out even if checkout wins with push 
but the hook runs before checkout completes.)

	-Daniel
*This .sig left intentionally blank*
