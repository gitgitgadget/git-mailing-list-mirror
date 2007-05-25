From: Junio C Hamano <junkio@cox.net>
Subject: Re: Pulling from refs/remotes/ ?
Date: Thu, 24 May 2007 20:06:43 -0700
Message-ID: <7vwsyxsit8.fsf@assigned-by-dhcp.cox.net>
References: <f35d9n$21e$1@sea.gmane.org>
	<7v7iqxvgx8.fsf@assigned-by-dhcp.cox.net> <46563D55.3070607@xs4all.nl>
	<7v3b1lvfc5.fsf@assigned-by-dhcp.cox.net> <465648EA.8070608@xs4all.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: hanwen@xs4all.nl
X-From: git-owner@vger.kernel.org Fri May 25 05:06:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HrQ8e-0001cU-1G
	for gcvg-git@gmane.org; Fri, 25 May 2007 05:06:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750927AbXEYDGo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 24 May 2007 23:06:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751033AbXEYDGo
	(ORCPT <rfc822;git-outgoing>); Thu, 24 May 2007 23:06:44 -0400
Received: from fed1rmmtao105.cox.net ([68.230.241.41]:42610 "EHLO
	fed1rmmtao105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750927AbXEYDGo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 May 2007 23:06:44 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao105.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070525030643.CIKF22040.fed1rmmtao105.cox.net@fed1rmimpo02.cox.net>;
          Thu, 24 May 2007 23:06:43 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 3F6j1X00B1kojtg0000000; Thu, 24 May 2007 23:06:43 -0400
In-Reply-To: <465648EA.8070608@xs4all.nl> (Han-Wen Nienhuys's message of "Thu,
	24 May 2007 23:24:42 -0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48340>

Han-Wen Nienhuys <hanwen@xs4all.nl> writes:

>> If somebody else (or yourself) did:
>> 
>> 	$ git pull $dir LOCAL-BRANCH
>> 
>> (replace $dir with the `pwd` you would get in your repository),
>> that would work.  Why shouldn't it work for yourself?
>  
> Because
>
> "You are treating your local repository as if it is a remote
> repository somewhere else, namely, '.' (current repository)."
>
> that was the justification for not being able to pull in a remote
> branch.  This justification (which I disagree with) applies to this
> case as well.

Ah, so "forbidding a pull of local branch" was tongue-in-cheek
comment, and what you really wanted was to allow pulling remote
tracking branch with pull, either inside or outside of a
repository, like...

	$ git pull $somebody_elses_repo remotes/origin/master

without having to say "remotes/"?

That one comes from a different design issue.  refs/remotes/
hierarchy is local to your repository, and is not subject to
remote operation.

> I understand that we don't want people committing to
> remotes, because fetches will then later fail, but other than 
> that, why should there be limitations on using a remote?

My stance on this is that what I track as my upstream to
maintain my repository is none of other people's business.  I
have remote tracking branches because I use them to track
others; I do not necessarily have them with an intention to
publish them.

You could pull from my remote tracking branches using the fuller
refspec ("remotes/origin/master" in the example above) if you
really wanted to, and ls-remote lets you take a peek at them, so
the above "none of your business" is not in the sense of being
secretive, but is to reduce clutter and to avoid potential
confusion.

But this is an ancient design choice, and I am open to
suggestions loosening it, as long as we are aware of
implications.

One thing that comes to mind if we allow it is if a clone should
have refs/remotes/origin/remotes/origin/* that keeps track of
the remote that is being tracked by your origin.

I think it is insane to do so, but if somebody says "git pull
somewhere-else origin/master", we would not know if he meant
remotes/origin/master or remotes/origin/remotes/origin/master.

And the reason it is "insane" is the same as why we currently do
not interpret "git pull $repo origin/master" as a request to
pull from remotes/origin/master.  It really is none of your
business what kind of remote branches the other end is
interacting with.
