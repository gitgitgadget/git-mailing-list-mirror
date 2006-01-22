From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [RFC] Reverting "git push logic change"?
Date: Sun, 22 Jan 2006 14:09:50 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0601221311530.25300@iabervon.org>
References: <20060120225336.GA29206@kroah.com> <7vlkxa30rd.fsf@assigned-by-dhcp.cox.net>
 <20060121001547.GA30712@kroah.com> <7vfynivx9s.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Greg KH <greg@kroah.com>
X-From: git-owner@vger.kernel.org Sun Jan 22 20:08:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F0kZb-0000vM-AC
	for gcvg-git@gmane.org; Sun, 22 Jan 2006 20:08:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750773AbWAVTHu (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 22 Jan 2006 14:07:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751316AbWAVTHt
	(ORCPT <rfc822;git-outgoing>); Sun, 22 Jan 2006 14:07:49 -0500
Received: from iabervon.org ([66.92.72.58]:60172 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S1750773AbWAVTHt (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 22 Jan 2006 14:07:49 -0500
Received: (qmail 4797 invoked by uid 1000); 22 Jan 2006 14:09:50 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 22 Jan 2006 14:09:50 -0500
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vfynivx9s.fsf_-_@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15057>

On Fri, 20 Jan 2006, Junio C Hamano wrote:

> The change introduced by 9e9b267 commit broke "correct" usage of
> git push to push matching refs, to work around a problem
> observed in a usage pattern on a shared repository.
> 
> I think I made a bad judgement in evaluating the scenario, and
> made a bad change to "fix" a problem that did not exist.  I
> apologize for having caused this confusion.
> 
> My conclusion after thinking about the problem again is that we
> would be better of if we reverted that commit.  This message is
> to make my intention clear, and solicit objections or comments
> from the list.
> 
> The use case that prompted this change was this:
> 
>  - A shared repository is created by cloning Linus repository.
>    This repository gets "origin" (then-current Linus master) and
>    "master" (the same).
> 
> 	$ git clone --naked \
>           git://git.kernel.org/.../linux-2.6.git/ project.git
> 
>  - Two developers use this as their shared repository.  They
>    first start out by cloning from it, do their development in
>    their "master" branch and pushing back to the "master" branch
>    of the shared repository.  Their workflow is:
> 
> 	0. Clone it (once per developer):
>         $ git clone ssh://pub.example.com/project.git/ work
> 
> 	1. To make sure the developers are in sync:
> 	$ git pull ssh://pub.example.com/project.git/ ;# (a) or
> 	$ git pull origin			      ;# (b)
> 
>         2. His own development:
> 	$ edit;compile;test;git commit
> 
> 	3. Pull from upstream, to avoid conflicts with it (only when needed):
> 	$ git pull git://git.kernel.org/.../linux-2.6.git/
> 
> 	4. Push back the result to shared repository:
>         $ git push ssh://pub.example.com/project.git/
> 
> With this workflow, in the two developer repositories, "origin"
> branch is not really well maintained.  If "git pull origin" was
> used with the remotes/origin file "git clone" initially gave
> him, it would have kept track of the latest push into the shared
> "master" closely, but if the explicit URL was used, "origin" of
> the developer repository would have been left behind.
> 
> This is not problem as far as the correctness of the "master"
> branch is concerned.  The fast-forward check when pushing into
> the shared repository "master" branch prevents the two
> developers from losing commits.  In other words, either way to
> pull from the shared repository is legal/valid.
> 
> However, the push done in step 4. triggers the default "push all
> matching refs" behaviour.  All three repositories have "origin"
> and "master", which means this results in "origin" being updated
> in the shared repository.  But one developer repository has a
> stale "origin" while the other developer has an up-to-date
> "origin".  This triggers a "not a fast forward" error, which
> does not cause the push of "master" to fail, but still looks
> worrisome.

I think there are a number of good solutions:

 - Make the case of a pure rewind (i.e., pushing something that would be a 
   fast-forward in the other direction) have no effect and give a more 
   positive message like 'Remote "origin" is already ahead of your 
   version.' I expect that something of that sort would comfort the users 
   and distinguish branches that you're not actively using and have fallen 
   behind on from branches that you are using, but someone else is also 
   using. This seems like a good idea even if we do other stuff.
 - Have a command to write, report, and modify remotes files, so Greg can 
   tell it exactly what he actually wants without mucking around with the 
   files by hand. Also generally nice.
 - Require --all in push, but, if none are given, produce a summary of 
   what you could specify instead of assuming you mean to push nothing. 
   Then Greg would see master:master as the obvious thing, and do that.
 - Maybe "git clone" should add "Push: master:master" by default if the 
   URL permits pushing?

I think that having it default to matching branches isn't really ideal, 
since that seems to me to work for practically everybody only by 
coincidence: master:master is by far the most common case; then 
there are some people who use multiple branches, but they must have done 
something other than the default to create this situation, anyway; then 
there's the case where "master" isn't a head on both sides, but (at least 
in my experience), master:master is still what the user means (case 
happens when pushing a first commit from a clone of an empty repository). 

Maybe the default should be master:master? It seems to fit the general 
pattern of defaulting to master. Or maybe (what HEAD points to):(matching 
branch), or (but I'm not too comfortable with this one) HEAD:master.

	-Daniel
*This .sig left intentionally blank*
