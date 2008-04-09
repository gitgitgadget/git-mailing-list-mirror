From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: git annoyances
Date: Wed, 9 Apr 2008 15:21:04 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0804091442190.19665@iabervon.org>
References: <20080409101428.GA2637@elte.hu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Ingo Molnar <mingo@elte.hu>
X-From: git-owner@vger.kernel.org Wed Apr 09 21:22:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jjfs9-0004Ql-3n
	for gcvg-git-2@gmane.org; Wed, 09 Apr 2008 21:22:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756526AbYDITVI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 9 Apr 2008 15:21:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756241AbYDITVH
	(ORCPT <rfc822;git-outgoing>); Wed, 9 Apr 2008 15:21:07 -0400
Received: from iabervon.org ([66.92.72.58]:40003 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756011AbYDITVG (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Apr 2008 15:21:06 -0400
Received: (qmail 7986 invoked by uid 1000); 9 Apr 2008 19:21:04 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 9 Apr 2008 19:21:04 -0000
In-Reply-To: <20080409101428.GA2637@elte.hu>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79123>

On Wed, 9 Apr 2008, Ingo Molnar wrote:

> 
> i just had a rather annoying session with git - here's the dump and 
> commentary, in case anyone is interested in usability fineprint.
> 
> it was with git-core-1.5.4.3-2.fc8 - so if it's all fixed/improved in 
> 1.5.5, or if this is blatant user error for which i deserve to be 
> punished then my apologies!
> 
> usually i just have a single git repo that tracks everything 
> interesting, but this time i did something i rarely do: i tried to merge 
> one local tree of mine into another local tree of mine. So i had no 
> commands (or even concepts) cached in my short-term memory that would 
> achieve this goal, i just tried the commands that i thought to be 
> 'obvious', without applying much (or any) IQ to those commands:
> 
>  $ cd linux-2.6-sched-devel.git
> 
>  $ git-remote add ~/linux-2.6-x86.git
> 
>  $ git-remote show x86
>   * remote x86
>     URL: /home/mingo/linux-2.6-x86.git
>   New remote branches (next fetch will store in remotes/x86)
>   base for-akpm for-linus latest master testing

Good so far.

>  $ git-merge x86/latest
>  x86/latest - not something we can merge

Git is missing the fact that, while refs/remotes/x86/latest doesn't exist, 
there is a fetch rule that would create it. It should suggest "git fetch 
x86" or "git fetch x86 latest". This is a bit tricky, because you've used 
a shorthand for something that doesn't exist, so there isn't a unique 
answer for which full name you're looking for, but there is a unique 
solution (in this case) for which one could be created by a pattern you 
have.

>  #
>  # ho hum. Not something 'we' can merge. Do i care? :-) There's no 
>  # actionable reference given to the user about how to resolve this 
>  # problem. So i kept on trying:
>  #
> 
>  $ git-fetch x86/latest
>  fatal: 'x86/latest': unable to chdir or not a git archive
>  fatal: The remote end hung up unexpectedly

The right error message here would probably be:

/home/mingo/linux-2.6-sched-devel.git/x86/latest: No such file or directory

That should at least tell you what git thinks, incorrectly, that you want 
it to do, and why it doesn't work.

> what got me going after experimenting around some more was this exact 
> command:
> 
>  $ git-pull x86 latest
> 
> (that fetch+merge went problem-free.)
> 
> but it was a PITA and all of git's messages about the problem were not 
> only unhelpful, they confused me into looking for problems where there 
> were none IMO. I was starting to wonder whether i have to have some git 
> daemon running on that box for example. But in retrospect IMO it was 
> rather clear from the outset what i wanted git to do (merge the tip of 
> my other tree into the tip of this tree, on the local box, no frills), i 
> just didnt figure out the exact command to do it.
> 
> another (minor) usability annoyance: one of the first things i tried was 
> to verify the remote setup, via:
> 
> $ git-remote show
> 
> which gave me this answer:
> 
>  Usage: git remote show <remote>
> 
> then i tried git-remote show -a (to list all repositories, etc.) - what 
> i didnt figure out was to show all repositories is to do a simple 
> "git-remote". I think "git-remote show" should output all repositories, 
> or at least indicate it in its help line what to do to get such a list. 
> (for us poor sobs forgetting commandline details ;)
> 
> also, the first natural thing i did was to just type:
> 
>  $ git-merge ~/linux-2.6-x86.git/
> 
> which i naively assumed would sort things out for me and provide some 
> reasonable default behavior - but instead it just gave an annoyingly 
> unhelpful error message:
> 
>  /home/mingo/linux-2.6-x86.git/ - not something we can merge
> 
> there should really be a consciously established "route of failure 
> resolution" - directing people towards relevant sources of information 
> or commands when the git command-line utilities return some error due to 
> user incompetence. Otherwise users just guess around and get frustrated.

I'm not sure we can figure out what the user actually meant in this case; 
there's just too much overlap in namespaces to determine reliably that you 
were giving it a remote repository on the local filesystem rather than 
anything else.

	-Daniel
*This .sig left intentionally blank*
