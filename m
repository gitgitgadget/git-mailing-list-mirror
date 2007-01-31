From: Nicolas Pitre <nico@cam.org>
Subject: Re: Difficulties in advertising a new branch to git newbies
Date: Wed, 31 Jan 2007 13:25:20 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0701311247510.3021@xanadu.home>
References: <87odognuhl.wl%cworth@cworth.org>
 <Pine.LNX.4.64.0701301853300.20138@iabervon.org>
 <Pine.LNX.4.64.0701302052230.3021@xanadu.home>
 <Pine.LNX.4.64.0701302331440.20138@iabervon.org>
 <Pine.LNX.4.64.0701310923010.3021@xanadu.home>
 <Pine.LNX.4.64.0701311102300.20138@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Carl Worth <cworth@cworth.org>, git@vger.kernel.org
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Wed Jan 31 19:25:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCK97-0006cO-Ud
	for gcvg-git@gmane.org; Wed, 31 Jan 2007 19:25:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030503AbXAaSZX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 31 Jan 2007 13:25:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030505AbXAaSZX
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Jan 2007 13:25:23 -0500
Received: from relais.videotron.ca ([24.201.245.36]:60232 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030503AbXAaSZW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Jan 2007 13:25:22 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MO-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JCQ00EKNWI8D090@VL-MO-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 31 Jan 2007 13:25:21 -0500 (EST)
In-reply-to: <Pine.LNX.4.64.0701311102300.20138@iabervon.org>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38283>

On Wed, 31 Jan 2007, Daniel Barkalow wrote:

> On Wed, 31 Jan 2007, Nicolas Pitre wrote:
> 
> > Giving a warning at commit time is not the place where the user has to 
> > be aware of the issue since it is indeed not the place where there is 
> > any issue to worry about.
> 
> At commit time, the user is reasonably likely to be doing something 
> unintended (at least, it's more likely that the user is doing something 
> unintended by committing with a detatched head than that the user is doing 
> something unintended by detatching the head). Certainly the only time 
> there's any danger of losing work is when the head is detatched and a 
> commit has been made since it was set, because otherwise there's either no 
> work to lose, or no commits could be becoming unreachable.

There is protection against losing a commit made on top of a detached 
head already.  And when reflog of detached head can be completed then 
there won't be any ways to lose them regardless.  Preventing or making 
it difficult or annoying to commit on top of a detached head 1) makes no 
technical sense and 2) doesn't address the real issue.

> I suspect that there will be people from other SCMs who will assume 
> they're back on a local branch if the system lets them commit, because 
> they would be prohibited from committing on top of an anonymous checkout 
> or a historical commit.

I don't follow you here.

Why would you be prevented from performing a commit on top of an 
historical commit?  That is the whole point of a detached head: making 
things to a checkout that usually should remain read-only.  This is why 
you can fetch and merge tracking branches, diff against taged commits or 
tracking branches, etc.  But if you _checkout_ a read-only branch/tag 
then either we checkout every file read-only to inforce that face and 
piss off users, or let them do as much as they wish _including_ commits 
but have a safety gate for the only operation that could otherwise 
actualy lose work.

And since the commit template already mention "Not currently on any 
branch" I think the user is reminded already that she's still not on a 
local branch.

> Of course, they can cherry-pick the misplaced 
> commit, so it's not a big deal, but I think it's where a naive user would 
> be getting into a state they don't understand.

That's why the warning when detaching head is important:

|warning: you are not on ANY branch anymore.
|If you meant to create a new branch from this checkout, you may still do
|so (now or later) by using -b with the checkout command again.  Example:
|  git checkout -b <new_branch_name>

The "now or later" is there exactly to tone down the warning.  And 
actually we could do s/warning/note" to make it even less frightening.  

But I think it is important to tell the user up front about that fact. 
Then, when the user tries to commit and sees "Not currently on any 
branch" then she'll go "oh sure it told me so before" and maybe even 
"that's so cool I can perform commits even in this case!".  But if the 
user sees that "Not currently on any branch" line without having been 
notified at the moment it happened then she'll only think "WTF did I do 
to get here".

But if a user did work, even unexpectedly, on top of a detached head 
then the worst thing you can trow at her face is :"sorry, you cannot 
commit your work here" or "committing on a detached head risk losing 
your work" because those are technically untrue and really unfriendly.

When it is really possible to lose change unexpectedly is when 
performing another checkout.  And currently you simply won't be able to 
do it.  You'll get this instead:

|You are not on any branch and switching to branch 'master'
|may lose your changes.  At this point, you can do one of two things:
| (1) Decide it is Ok and say 'git checkout -f master';
| (2) Start a new branch from the current commit, by saying
|     'git checkout -b <branch-name>'.
|Leaving your HEAD detached; not switching to branch 'master'.

There is no way the user might still be confused here. Any commit time 
warning is useless and redundent when you have this message when it 
really matters.

This is flexibility and safety together and I think this is really 
powerful.


Nicolas
