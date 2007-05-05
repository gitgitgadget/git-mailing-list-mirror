From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH 4/5] Add --remote option to send-pack
Date: Sat, 5 May 2007 13:56:58 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0705051307080.28708@iabervon.org>
References: <Pine.LNX.4.64.0704281304360.28708@iabervon.org>
 <7vtzuzg26l.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0704290152410.28708@iabervon.org>
 <7vejm3g0dg.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0705022330460.28708@iabervon.org>
 <7virba31wd.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0705030137520.28708@iabervon.org>
 <7vejly305u.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0705050115270.28708@iabervon.org>
 <7vr6pvn5k0.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0705050235210.28708@iabervon.org>
 <7vr6pvln89.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat May 05 19:57:08 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HkOVI-0000JZ-2E
	for gcvg-git@gmane.org; Sat, 05 May 2007 19:57:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934140AbXEER5B (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 5 May 2007 13:57:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934171AbXEER5B
	(ORCPT <rfc822;git-outgoing>); Sat, 5 May 2007 13:57:01 -0400
Received: from iabervon.org ([66.92.72.58]:3508 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934140AbXEER5A (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 May 2007 13:57:00 -0400
Received: (qmail 1675 invoked by uid 1000); 5 May 2007 17:56:58 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 5 May 2007 17:56:58 -0000
In-Reply-To: <7vr6pvln89.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46277>

On Sat, 5 May 2007, Junio C Hamano wrote:

> Daniel Barkalow <barkalow@iabervon.org> writes:
> 
> > Wouldn't it be better to to this as:
> >
> > [remote "origin"]
> > 	url = git.kernel.org:/pub/scm/git/git.git/
> > [branch "master"]
> > 	remote = origin
> > 	merge = refs/heads/master
> 
> As I am likely to pull from other people, and I happen to expect
> the old fashioned "git pull gfi" without explicit refspec on the
> command line to get the first Pull: line from remotes file to
> tell which one to merge from, I am in favor of _not_ having that
> [branch "master"] stuff in my repository.
> 
> remote.*.fetch is about what remote branches are fetched;
> tracking may or may not happen as a side effect.  What I do with
> the resulting .git/FETCH_HEAD is my business and branch.*.merge
> should _not_ be the only way to access it.

Ah, okay. So FETCH_HEAD gets: (1) if something is specified on the 
command line, that; (2) if there is a branch.*.merge, that; (3) the first 
refspec (without a *?) listed in remote.*.fetch. Right?

> There are a few improvements we probably would want.
> 
> One is the interaction between the config "fetch =..." refspecs
> and the command line ones.  Currently the rule is:
> 
>  - If you do not say refspecs on the command line, fetch config
>    (or Pull: lines from remotes/* file) are used.
> 
>  - If you do have refspecs on the command line, fetch config are
>    not used (they are ignored).
> 
> Which is fine when we talk about "git fetch", but if you _are_
> using remote tracking, and if you are running "git fetch" as an
> implementation detail of running "git pull" (IOW, you said "git
> pull origin next"), it is less than optimum.  Instead of "only
> fetch 'next' without tracking and then merge it", we would
> certainly want "fetch to track everything as usual, and then
> merge 'next' instead of what is usually merged".

I think that might be confusing; I'd expect that the tracking for next 
would be updated, but the tracking for other heads wouldn't. I'm not sure 
I'd ever actually complain about origin/master being more up-to-date than 
can be intuitively explained, but I don't think a "git pull origin next" 
would make me expect origin/master to be up-to-date right after. So I'd 
say, "only fetch 'next'; if you track 'next' normally, update that."

On the other hand, I've been doing a lot of "git diff origin all-my-work" 
and removing hunks I don't want to send, and this makes the implicit 
assumption that origin == merge_base(origin, all-my-work), which is true 
only because I merge origin whenever I fetch it.

> Another thing is that which branch is merged into the current
> branch should not be a function of the current branch, as the
> current configuration mechanism suggests.  The current way maps
> the current branch to "which repository's which branch".  In
> addition to that, I think it should be a function of ("current
> branch", "remote repository") pair.  IOW, allow you to say "If I
> pull from this remote without saying which one to merge, merge
> that branch.  If I pull from this other remote, merge that other
> branch".  Something like:
> 
>         [branch "master"]
>                 ; Use this when "git pull" did not say which remote
>                 remote = origin
> 
>                 ; Use this when "git pull origin" did not say which
>                 ; branch(es) to merge
>                 merge = refs/heads/master
>                 ; the above should be a synonym for
> 		; merge = refs/heads/master for origin
> 
>                 ; "git pull fast-import" while on my "master"
>                 ; would merge 'for-junio' branch there.
>                 merge = refs/heads/for-junio for fast-import
> 
>                 ; similarly, but use subtree strategy.
>                 merge = refs/heads/for-junio with subtree for git-gui
> 
>         [remote "origin"]
>                 url = git://git.kernel.org/pub/scm/git/git.git/
>                 fetch = refs/heads/*:remotes/origin/*
>         [remote "fast-import"]
>                 url = git://repo.or.cz/git/fastimport.git/
>                 fetch = refs/heads/*:remotes/gfi/*
>         [remote "git-gui"]
>                 url = git://repo.or.cz/git-gui.git/
>                 fetch = refs/heads/*:refs/remotes/git-gui/*

I think this is a good feature, but maybe the syntax should be:

 merge = fast-import refs/heads/for-junio

since the remote name is user-chosen, arbitrary, and has to be typed on 
the command line, and therefore people won't put in spaces, and "git fetch 
fast-import refs/heads/for-junio" is what you'd type on the command line 
that this abbreviates, so it's intuitive.

	-Daniel
*This .sig left intentionally blank*
