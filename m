From: Junio C Hamano <junkio@cox.net>
Subject: Re: What's cooking in git.git (topics)
Date: Sat, 27 Jan 2007 14:00:51 -0800
Message-ID: <7vhcuci0z0.fsf@assigned-by-dhcp.cox.net>
References: <7vps90lvoh.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0701271415280.3021@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Sat Jan 27 23:01:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HAvbf-0006io-L1
	for gcvg-git@gmane.org; Sat, 27 Jan 2007 23:01:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751862AbXA0WAz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 27 Jan 2007 17:00:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751779AbXA0WAx
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Jan 2007 17:00:53 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:61302 "EHLO
	fed1rmmtao10.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751796AbXA0WAw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Jan 2007 17:00:52 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070127220052.EDUB20715.fed1rmmtao10.cox.net@fed1rmimpo01.cox.net>;
          Sat, 27 Jan 2007 17:00:52 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id GMzt1W0111kojtg0000000; Sat, 27 Jan 2007 16:59:54 -0500
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38002>

Nicolas Pitre <nico@cam.org> writes:

> On Sat, 27 Jan 2007, Junio C Hamano wrote:
>
>> * np/dreflog (Fri Jan 26 17:26:11 2007 -0500) 8 commits
>
> I might be partial of course, but I think it is preferable to merge it 
> before 1.5.0 since this causes a behavior change.  Currently HEAD@{n} 
> inherits the reflog of the branch HEAD is currently on.  With this patch 
> serie HEAD@{n} is the true reflog for HEAD regardless of where it is now 
> and where it has been independently of the current branch.  Of course I 
> consider the later behavior to be more sensible and it might be a good 
> idea to give it to 1.5.0 users at the same time as the detached head 
> support rather than creating a behavior change later on when reflogs are 
> more popular.

My understanding of the situation after your patch (disregarding
the problem that prune and friends may happily break the logs
for detached HEAD), is that if you say "git show HEAD@{...}",
while on a branch, it looks at the log of the current branch but
while on a detached HEAD it shows the log from .git/logs/HEAD.
I have a feeling that this would be confusing.  Ideally, while
on a branch, say 'master', these two should behave differently:

	$ git show 'master@{5.minutes.ago}'
        $ git show 'HEAD@{5.minutes.ago}'

The former talks only about where the tip of that particular
branch were while the latter also should tell you on which
branch you were on.

But then that raises two new problems:

 - We always said: 'HEAD' means the same thing as your current branch.
   This is not true anymore.

 - You do not record which branch you were on in the log for
   HEAD itself (it is merely a dup), so while the latter would
   report which commit you were at, you cannot tell which branch
   you were on (or if your head was detached).

While I am sure that prune problem is solvable, I have a feeling
that it would take some time to iron out the semantic issues
like the above (and I suspect there might be even more).
