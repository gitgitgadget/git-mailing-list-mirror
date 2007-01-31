From: Junio C Hamano <junkio@cox.net>
Subject: Re: Difficulties in advertising a new branch to git newbies
Date: Tue, 30 Jan 2007 17:34:07 -0800
Message-ID: <7vzm80vv1s.fsf@assigned-by-dhcp.cox.net>
References: <87odognuhl.wl%cworth@cworth.org>
	<20070130231015.GB10075@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jan 31 02:34:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HC4Mz-0003mu-1g
	for gcvg-git@gmane.org; Wed, 31 Jan 2007 02:34:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932344AbXAaBeL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 30 Jan 2007 20:34:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932333AbXAaBeK
	(ORCPT <rfc822;git-outgoing>); Tue, 30 Jan 2007 20:34:10 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:47743 "EHLO
	fed1rmmtao03.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932344AbXAaBeJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Jan 2007 20:34:09 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070131013408.HREN29122.fed1rmmtao03.cox.net@fed1rmimpo01.cox.net>;
          Tue, 30 Jan 2007 20:34:08 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Hda71W00P1kojtg0000000; Tue, 30 Jan 2007 20:34:08 -0500
In-Reply-To: <20070130231015.GB10075@coredump.intra.peff.net> (Jeff King's
	message of "Tue, 30 Jan 2007 18:10:15 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38218>

Jeff King <peff@peff.net> writes:

> On Tue, Jan 30, 2007 at 12:13:26PM -0800, Carl Worth wrote:
>
>> Also, if I'm willing to assume (or insist) that users have git 1.5 or
>> newer, it'd be nice to be able to drop the "-b build" thing thanks to
>> the new detached HEAD support. But if I suggest doing just:
>> 
>> 		git checkout origin/proposed-fix
>> 
>> the user is presented with the following message which is much more
>> scary than useful in this situation:
>> 
>> 	warning: you are not on ANY branch anymore.
>> 	If you meant to create a new branch from the commit, you need -b to
>> 	associate a new branch with the wanted checkout.  Example:
>> 	  git checkout -b <new_branch_name> origin/proposed-fix
>
> I don't see any reason why we can't scare the user when making a commit,
> instead of just checkout out to look around. Something like the patch
> below. It needs a few things:
>   - remove the old checkout message
>   - we wrap the colorization over the multi-line message. Probably a
>     color_printf_lines() function should be added
>   - if colorization is enabled, print it using color.status.warning
>     (default to red).
>
> I'm happy to make all those happen if there is interest (Junio, please
> comment).

That does not protect anything other than interactive "git
commit".  People often do "git commit -m" or "git commit -C".
In addition, rebasing a detached HEAD, merging into a detached
HEAD, cherry-picking onto a detached HEAD or running reset on a
detached HEAD to move to a particular state you want to look at
are all useful and valid operations, and you wouldn't get any
warning when you do so.

I do not think warning at every step that you are "in a funny
state" does not help productivity, so I'd prefer warning upfront
once and be silent afterwards, until you try to come back with
"git checkout <existing branch>", potentially losing your state,
which is what we currently do.

Having said that, I think making "git checkout -f" not to issue
the warning might be enough.  Actually, I would even say it
would make perfect sense.

For situations like Carl's intstruction where a user, who is
purely a sightseer, uses the detached HEAD to go-and-look a
particular state, the fact that "-f" loses the previous local
modifications is not an issue at all.  On the other hand, if the
user is a developer who uses git, the warning upfront (if we
want to keep it for educational purposes, to make people aware
of what is happening) is useful without "-f", and when a user
who is using git to manage his own development, he hopefully
knows what "git checkout -f" means to his local modifications
already.
