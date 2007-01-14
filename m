From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 3/3] Allow whole-tree operations to be started from a subdirectory
Date: Sat, 13 Jan 2007 17:37:41 -0800
Message-ID: <7virfaie1m.fsf@assigned-by-dhcp.cox.net>
References: <7v8xg9x8uu.fsf@assigned-by-dhcp.cox.net>
	<7vy7o8rnyw.fsf_-_@assigned-by-dhcp.cox.net>
	<7vac0orml9.fsf_-_@assigned-by-dhcp.cox.net>
	<200701140111.20671.Josef.Weidendorfer@gmx.de>
	<45A97EC5.10401@midwinter.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>,
	Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 14 02:37:54 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H5uJi-0002K3-H3
	for gcvg-git@gmane.org; Sun, 14 Jan 2007 02:37:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751014AbXANBhn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 13 Jan 2007 20:37:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751025AbXANBhn
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Jan 2007 20:37:43 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:52200 "EHLO
	fed1rmmtao02.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750913AbXANBhm (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Jan 2007 20:37:42 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070114013742.JRCB97.fed1rmmtao02.cox.net@fed1rmimpo02.cox.net>;
          Sat, 13 Jan 2007 20:37:42 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Apdy1W0021kojtg0000000; Sat, 13 Jan 2007 20:37:58 -0500
To: Steven Grimm <koreth@midwinter.com>
In-Reply-To: <45A97EC5.10401@midwinter.com> (Steven Grimm's message of "Sat,
	13 Jan 2007 16:52:21 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36788>

Steven Grimm <koreth@midwinter.com> writes:

> Josef Weidendorfer wrote:
>> Why not add a general "--top" option to the "git" wrapper,
>> to temporarily let git change to the toplevel while running
>> the command?
>>
>
> If I can add a config entry so --top is the default, then that's
> acceptable, but IMO it should be the default and we should, at most,
> spit out a warning if a command is run in a subdirectory and there's a
> chance of confusion.
>
> When I run one of the commands that currently can't run in a
> subdirectory and it spits out its error message, I NEVER react to that
> by saying, "Oops, forgot I was in a subdirectory, guess I didn't want
> to run that after all." (Have any of you said that, even once?)

I agree with you 90% -- the other 10% are:

 - when these whole-tree operations fail in conflicts, I need to
   cd to the top to deal with "the other parts" of the tree
   anyway.

 - the result of merging other tree may make the current
   directory disappear (say, I haven't changed anything in the
   current directory and the other branch moved it to somewhere
   else, so it cleanly merged but now the current directory
   should not be there).

These worries are only small percentage because most of the
merges (or merge-like operations) are clean and directory
removal is rare.

I would understand why somebody might want to fetch from others
while working in subdirectory -- to see what other people might
be doing in the same area as you are currently working on.

I consider that being in a subdirectory means the user is in the
middle of actively working on something in that area.  Honestly
I do not understand why anybody would want to run the five
whole-tree commands under discussion (merge, pull, rebase,
revert and cherry-pick) in the middle of doing something, so
from the theoretical point of view I would agree that it makes
sense for the commands to internally cd-up to do their work, I
am not sure how much practical value it would add.

> ... I
> react by grimacing and typing "cd" so the command will do what I told
> it to do. I have done that every single time I've gotten the
> in-a-subdirectory error. And muttering under my breath something along
> the lines of, "The code knows everything it needs to know to do what I
> just told it to, but it's making me take seconds to do by hand what it
> could have done on its own in nanoseconds."

I do understand that you would want to cuss --- I probably would
if that happened to me, too.

However, I am somewhat doubtful to put me in that situation in
the first place, because running these five commands would be
something I would do when my work-in-progress is somewhat in a
stable state (perhaps after creating a temporary commit with
"git-commit -a -m WIP" on the current topic branch), and am
switching my attention to do something else.  Doing one of these
five commands (say "rebase") would be the first action of the
next stage of my work, but that would most likely be preceded by
cd'ing to the top; I am unlikely to stay in the "current
subdirectory" when running the "rebase".

I most likely am missing something, some obvious thing in your
workflow that is not mine.
