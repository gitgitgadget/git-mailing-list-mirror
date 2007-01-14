From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 3/3] Allow whole-tree operations to be started from a subdirectory
Date: Sat, 13 Jan 2007 16:50:36 -0800
Message-ID: <7vps9iig83.fsf@assigned-by-dhcp.cox.net>
References: <7v8xg9x8uu.fsf@assigned-by-dhcp.cox.net>
	<7vy7o8rnyw.fsf_-_@assigned-by-dhcp.cox.net>
	<7vac0orml9.fsf_-_@assigned-by-dhcp.cox.net>
	<200701140111.20671.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 14 01:50:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H5ta8-0000vI-FA
	for gcvg-git@gmane.org; Sun, 14 Jan 2007 01:50:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750712AbXANAui (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 13 Jan 2007 19:50:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750726AbXANAui
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Jan 2007 19:50:38 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:43419 "EHLO
	fed1rmmtao02.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750712AbXANAuh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Jan 2007 19:50:37 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070114005036.IRHP97.fed1rmmtao02.cox.net@fed1rmimpo02.cox.net>;
          Sat, 13 Jan 2007 19:50:36 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Aoqs1W00r1kojtg0000000; Sat, 13 Jan 2007 19:50:53 -0500
To: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
In-Reply-To: <200701140111.20671.Josef.Weidendorfer@gmx.de> (Josef
	Weidendorfer's message of "Sun, 14 Jan 2007 01:11:20 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36786>

Josef Weidendorfer <Josef.Weidendorfer@gmx.de> writes:

> On Friday 12 January 2007 21:56, Junio C Hamano wrote:
>> This updates five commands (merge, pull, rebase, revert and cherry-pick)
>> so that they can be started from a subdirectory.
>> 
>> This may not actually be what we want to do.  These commands are
>> inherently whole-tree operations,...
>
> Why not add a general "--top" option to the "git" wrapper,
> to temporarily let git change to the toplevel while running
> the command?
>
> The wish to allow git-fetch from subdirectories is the
> inconvenience to have to cd up, and later down. This is
> avoided by running "git --top fetch", and theses people
> should be happy.

Well, git-fetch does not have anything to do with the working
tree, so it does not matter if you run from a subdirectory.  You
do not even need --top for it (and you don't with v1.5.0-rc1).

If we replace "git-fetch" in what you said with one of the
commands I listed in the message you quoted, what you said
becomes at least internally consistent.  But I do not
necessarily agree with it.

Adding --top and refusing to work without the option gives a
false impression that it is a bug that they do not work from the
top in the current implementation, and someday we might do these
commands limited to the current directory when the user is in a
subdirectory.  But for the above commands, it is definitely not
the case.  They are inherently whole-tree operations and it
ould actually be a bug to limit their operation to a single
subdirectory.

For example, what would a "merge" limited to the current
directory do?  It would probably do the usual 3-way merge for
the current directory and apply the 'ours' strategy for the rest
of the tree.

But that is obviously wrong.  The new commit claims that "I
considered the whole tree states these two commits record, and
came up with this another whole tree this commit records -- it
suits my purpose better than either of these other two trees".
Future merges that involve the resulting commit will take this
statement into account, and will revert the changes the other
branch would have brought in outside the current directory if
your merge result is later merged into somebody else's tree.

Rebasing a series of commits on top of some other branch, but
limiting only to the current directory does not make much sense,
either; it would lose the changes to the other parts of the
tree.  Losing the changes to the other parts of the tree might
sometimes be what the user would want, but for the most cases
that would not be true.  Also what the original log messages say
would not match the set of partial changes limited to the
current directory you are porting forward, so you would need to
reword the logs as well if you are limiting its operation to the
current directory.  In other words, it might be sometimes useful
but that is not a "rebase" anymore -- it is something else.  The
same discussion applies to the last two commands in the list
(revert and cherry-pick).

So for that reason, I think there are only two valid choices.
Either we insist these commands to be run from the top, or we
always automatically run these commands by cd'ing to the top
ourselves.
