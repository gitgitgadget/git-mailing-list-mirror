From: Junio C Hamano <junkio@cox.net>
Subject: Re: git and time
Date: Fri, 29 Sep 2006 15:27:34 -0700
Message-ID: <7vd59ejokp.fsf@assigned-by-dhcp.cox.net>
References: <20060928022917.29678.qmail@web51011.mail.yahoo.com>
	<Pine.LNX.4.64.0609272232040.9349@xanadu.home>
	<7vfyec63jx.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0609281029300.9349@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Theodore Tso <tytso@mit.edu>, Linus Torvalds <torvalds@osdl.org>,
	Andreas Ericsson <ae@op5.se>,
	Shawn Pearce <spearce@spearce.org>, git@vger.kernel.org,
	Jeff King <peff@peff.net>, Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Sep 30 00:28:03 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GTQpY-0004H7-VL
	for gcvg-git@gmane.org; Sat, 30 Sep 2006 00:27:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932069AbWI2W1h (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Sep 2006 18:27:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932086AbWI2W1h
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Sep 2006 18:27:37 -0400
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:57556 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S932069AbWI2W1g (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Sep 2006 18:27:36 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060929222735.DBRW21457.fed1rmmtao07.cox.net@fed1rmimpo01.cox.net>;
          Fri, 29 Sep 2006 18:27:35 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id UNTW1V00C1kojtg0000000
	Fri, 29 Sep 2006 18:27:31 -0400
To: Nicolas Pitre <nico@cam.org>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/28133>

Nicolas Pitre <nico@cam.org> writes:

> On Wed, 27 Sep 2006, Junio C Hamano wrote:
>
>> Nicolas Pitre <nico@cam.org> writes:
>> 
>> > SYNOPSIS
>> >
>> > 	git-local-arrival <committish>
>> >
>> > DESCRIPTION
>> >
>> > 	The command displays the time when given commit appeared in the 
>> > 	local repository.
>> 
>> This should be certainly doable, but local-arrival may not be
>> interesting if the repository has more than one branches.  Maybe
>> 
>> 	git-local-arrival <committish> [<branch>]
>> 
>> which defaults to the current branch?
>
> Indeed.  I didn't mention it initially because it is really easy to do 
> once you have it working for the current branch.  The technical 
> challenge is about making it efficient to find out which reflog entry 
> with a path to given commit is the oldest.

The more I think about this, if we were to add yet another
command, I think it should be a command that lets us inspect
ref-log.  We do not have an UI other than @{time} syntax to
interact with it right now.

What are the things we would want?  Here is a strawman.

 - List when and how a branch was changed.

   git ref-log --list --type=merge next (when did I merge into my 'next'?)
   git ref-log --list --type=merge (ditto but any branches)
   git ref-log --list next (any changes not just 'merge')

   I expect the output would give timestamp and reason comment;
   in addition the branch name when no branch is specified.
   Type does not have to be a concrete thing -- it could just be
   a substring match in the reason comment string.

   Also we would limit output with -n <limit>.  The output
   should be sorted by the timestamp of ref-log entry -- we are
   talking about a particular repository's ref-log, so its
   timestamp has more sane meaning than in distributed case.
   
 - Find which branches currently contains a commit, and find the
   earliest time that the commit became part of each of them.

   git ref-log $commit next master (when did it enter 'next' and
                                    when did it graduate to 'master'?)
   git ref-log $commit (ditto but any branches)

   I expect the output to be the timestamp and reason comment;
   in addition the branch name when no branch is specified.

Also for a shared repository, the person who made the change
would be a reasonable thing to report.

So for consistency, in all cases we could make the output
format like this:

    branch SP time-and-zone SP name SP email SP reason-comment LF

where time-and-zone is human-readable timestamp as we see in
git-log output.
