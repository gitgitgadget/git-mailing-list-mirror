From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH] Re: keeping remote repo checked out?
Date: Tue, 29 Nov 2005 12:22:21 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0511291157260.25300@iabervon.org>
References: <m3k6et9rdw.fsf@lugabout.cloos.reno.nv.us>
 <7vbr051ad1.fsf@assigned-by-dhcp.cox.net> <20051128105736.GO22159@pasky.or.cz>
 <7vsltgtvk4.fsf@assigned-by-dhcp.cox.net> <20051128212804.GV22159@pasky.or.cz>
 <Pine.LNX.4.64.0511281420390.3263@g5.osdl.org> <Pine.LNX.4.64.0511281845280.25300@iabervon.org>
 <Pine.LNX.4.64.0511281637480.3177@g5.osdl.org> <Pine.LNX.4.64.0511282027360.25300@iabervon.org>
 <Pine.LNX.4.64.0511281837040.3177@g5.osdl.org> <Pine.LNX.4.64.0511282208050.25300@iabervon.org>
 <Pine.LNX.4.64.0511282029290.3177@g5.osdl.org> <Pine.LNX.4.64.0511282337170.25300@iabervon.org>
 <7vmzjom00m.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0511290141220.25300@iabervon.org>
 <7v8xv7lwlr.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Petr Baudis <pasky@suse.cz>,
	Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Tue Nov 29 18:31:18 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eh9BX-0005QW-ES
	for gcvg-git@gmane.org; Tue, 29 Nov 2005 18:22:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932102AbVK2RVx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 29 Nov 2005 12:21:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932245AbVK2RVx
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Nov 2005 12:21:53 -0500
Received: from iabervon.org ([66.92.72.58]:21006 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S932102AbVK2RVw (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Nov 2005 12:21:52 -0500
Received: (qmail 23787 invoked by uid 1000); 29 Nov 2005 12:22:21 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 29 Nov 2005 12:22:21 -0500
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7v8xv7lwlr.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12948>

On Mon, 28 Nov 2005, Junio C Hamano wrote:

> Daniel Barkalow <barkalow@iabervon.org> writes:
> 
> >>     server$ git checkout production
> >>     work$ git checkout master
> >>     work$ git pull server production ;# merge into work's master
> >>     work$ git push server master:receive_from_work
> >>     server$ git pull . receive_from_work ;# merge into server's production
> >> 
> >> and you make sure receive_from_work is not checked out on server
> >> (or production is never pushed into) and always do fast forward
> >> and nothing else.
> >
> > That's what I'm doing currently, actually (with work pushing to 
> > "production", but server having checked out "deploy"), and I find it 
> > annoying to have to do the pull each time and have a separate head. It 
> > also means that, if the stuff on the server is set up as a hook, it'll 
> > have to do the locking against concurrent changes to the working tree in 
> > pull, which is much more complicated than checkout.
> 
> This depends on what is on the checked-out working tree and how
> it is used, but one use pattern I was imagining was actually
> much more elaborate.  I would set up two non-naked repositories
> on the server; let's call them treeR and treeP (reception and
> publish).

This is quite elaborate.

> Each work machine push into its own reception branch of treeR
> repository (so you have N reception branches for N workers).  On
> the server machine, a daemon monitors the reception branch heads
> (inotify or idle poll loop looking at mtime; the details do not
> matter), and run the git pull into "master" of treeR.  My daemon
> might want to forbid anything but fast forward for this pull, or
> might allow any clean merge. It compiles and runs testsuites
> next.  If anything fails during the above process, the owner of
> the reception branch is notified about the failure; I might even
> want to forcibly rewind her reception branch in this case to
> "master" when this happens.

This seems maximally inconvenient. If you lose a race, you only find out 
later, your reception branch is screwed up, and you have no way of finding 
out in advance that this is going to happen? It's much nicer to have 
people all push to a single branch, and tell them if they lose (i.e., the 
change wouldn't be a fast-forward).

> When everything goes well, the daemon goes to treeP and pulls
> from treeR's master into "deploy", which is checked out.  This
> procedure is the only thing that touches treeP, so this pull is
> guaranteed to be a fast forward.
> 
> The serialization happens by having a single such daemon
> running; no need to worry about locking anymore.

I'm not sure what the big deal about locking is. We do locking for 
updating everything else; I don't see a problem with having a lock for 
when git updates the working tree, so long as it doesn't need to hold some 
other lock as well at the same time (in which case we'd have to think 
about lock ordering).

(Actually, adding CHECKED_OUT would also allow pulling the current branch 
cleanly without all the special-casing in get-fetch.sh and git-pull.sh; it 
would have the predictable effect of leaving your working tree not up to 
date, but the ref it follows up to date, and the usual two-way merge in a 
pull would obviously do the right thing. Or you could just fetch, find out 
what will change with "git diff", and get the changes with "git 
checkout". In general, it would fix aliasing problems between 
refs/heads/* and HEAD.)
