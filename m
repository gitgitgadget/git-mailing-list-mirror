From: Carl Baldwin <cnb@fc.hp.com>
Subject: Re: Making note, in the repository, of push/pull relationships
Date: Tue, 16 Aug 2005 11:11:42 -0600
Organization: Hewlett Packard
Message-ID: <20050816171142.GB20016@hpsvcnb.fc.hp.com>
References: <20050815162519.GB9719@hpsvcnb.fc.hp.com> <7vzmrispi4.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Carl Baldwin <cnb@fc.hp.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 16 19:12:47 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E54z3-0006bi-Lj
	for gcvg-git@gmane.org; Tue, 16 Aug 2005 19:12:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030253AbVHPRMO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 16 Aug 2005 13:12:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030254AbVHPRMO
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Aug 2005 13:12:14 -0400
Received: from atlrel6.hp.com ([156.153.255.205]:19932 "EHLO atlrel6.hp.com")
	by vger.kernel.org with ESMTP id S1030253AbVHPRMN (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Aug 2005 13:12:13 -0400
Received: from smtp2.fc.hp.com (smtp.fc.hp.com [15.15.136.253])
	by atlrel6.hp.com (Postfix) with ESMTP id C4CC5B1B2;
	Tue, 16 Aug 2005 13:12:12 -0400 (EDT)
Received: from hpsvcnb.fc.hp.com (hpsvcnb.fc.hp.com [15.6.94.42])
	by smtp2.fc.hp.com (Postfix) with ESMTP
	id 8425241FD3F; Tue, 16 Aug 2005 17:12:12 +0000 (UTC)
Received: by hpsvcnb.fc.hp.com (Postfix, from userid 21523)
	id 56FFD5D1A; Tue, 16 Aug 2005 11:11:42 -0600 (MDT)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vzmrispi4.fsf@assigned-by-dhcp.cox.net>
X-Origin: hpescnb.fc.hp.com
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Mon, Aug 15, 2005 at 05:18:43PM -0700, Junio C Hamano wrote:
> If you are referring to what I said about the user having some
> control over both ends hence it should be possible to arrange to
> use the same name on both ends to reduce mental burden, Pasky
> and others convinced me otherwise during later discussions, and
> the current core knows how to do renaming pushes.

I wasn't referring to any particular post just a general idea that came
up in the thread. I wanted a starting point to present my thoughts. :-)

>     $ cat .git/remotes/ko
>     URL: master.kernel.org:/pub/scm/git/git.git/
>     Push: master pu rc
>     Pull: master:ko-master pu:ko-pu rc:ko-rc

This is very close to what I was getting at.  It records each branch
involved and wether the relationship is push or pull (or possibly both).

If I may, let me give an example of something I think could serve the
purpose a little more simply and generically.

Let's say I start with the following:
% ls .git/refs/heads
master
mylocalbranch
myremotebranch
ko-master
% cat .git/branches/ko-master
master.kernel.org:/pub/scm/git/git.git

I would add something like this:  (I didn't put much thought into the
actual directory and file names, forgive me.  ;-)

% cat .git/branches/relationships
pull:ko-master:master
pull:master:mylocalbranch # The next two document my flow locally
pull:mylocalbranch:master
push:master:myremotebranch # I push my master to a remote that I control

_OR_

% ls .git/relationships/*
pull:ko-master:master
pull:master:mylocalbranch
pull:mylocalbranch:master
push:master:myremotebranch

I think this is flexible and could easily support the workflow that you
present below.  You could do the following as a convenience in using
fetch in addition to what I suggest above.

% cat .git/remotes/ko
push: master:ko-master pu:ko-pu rc:ko-rc
pull: ko-master:master ko-pu:pu ko-rc:rc

I might argue that this is now a job for a porcelain script or
something.

With the addition of the simple relationships file a complete graph of
your workflow could derived.  There is no assumption on what the
workflow is nor if the branches are local or remote.  This work flow can
be arbitrarily simple or complex but further complexity can and should
be handled in the porcelains.

> The expected workflow with the above example "remotes" file is
> for me to be able to do this:
> 
>  (1) fetch from master.kernel.org (that is the source of the
>      mirroring for everybody to see on {www,rsync}.kernel.org)
>      before starting my day.  The current "git fetch" does not
>      do this, but make it:
> 
>      $ git fetch ko

This is still doable.  As is this...

>  (2) after doing work in my private repository, push to
>      master.kernel.org with:
> 
>      $ git push ko
>
> Note that I am _not_ expecting for "git push/pull/fetch"
> commands to dynamically update .git/remotes/ file whenever it

So, with the way I suggest splitting up refspecs and 'relationships' I
_would_ suggest dynamically adding to (but not deleting from) the
relationships file.  But, I agree with you about the refspec.  I think
this should be 100% supplied by the user or porcelain.

Adding relationships dynamically will be a good way to document whatever
flow is being used.  Also, the savy user can periodically check the file
(or a porcelain with a pretty interface could do something intelligent
with it) to see how his work flow has evolved.  He can also
delete relationships that are no longer needed if he is a clean-freak
like me ;-)

I really think there is some good common ground here.  Let's keep going
with this.  I actually have an idea brewing up for a porcelain to handle
work-flow in a tightly-knit corporate type development environment.

Hey, I've enjoyed the discussion.  I hope to make a valuable
contribution to git.  I think it has incredible potential.

Cheers,
Carl

> would not push usual "master pu rc" but create a new "testing"
> branch there, starting at the commit which is the head commit of
> the local "pu" branch.  This is a one-shot override, so next
> time around, "git push ko" will do the usual three heads that is
> recorded in the .git/remotes/ko file.
> 
> 

-- 
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
 Carl Baldwin                        Systems VLSI Laboratory
 Hewlett Packard Company
 MS 88                               work: 970 898-1523
 3404 E. Harmony Rd.                 work: Carl.N.Baldwin@hp.com
 Fort Collins, CO 80525              home: Carl@ecBaldwin.net
- - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
