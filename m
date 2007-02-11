From: Junio C Hamano <junkio@cox.net>
Subject: Re: 'git status' is not read-only fs friendly
Date: Sat, 10 Feb 2007 22:33:46 -0800
Message-ID: <7vtzxtdwz9.fsf@assigned-by-dhcp.cox.net>
References: <e5bfff550702091125j202620cfqb2450a3ee69ed421@mail.gmail.com>
	<Pine.LNX.4.63.0702101517360.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<e5bfff550702100631w1b6243e7i44039ceaa8d3fe93@mail.gmail.com>
	<Pine.LNX.4.63.0702101536090.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<e5bfff550702100648p6db5fc67vb5e4a04d40771922@mail.gmail.com>
	<Pine.LNX.4.63.0702101554170.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	<Pine.LNX.4.64.0702101049480.1757@xanadu.home>
	<7vr6syj7uw.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0702101131070.1757@xanadu.home>
	<Pine.LNX.4.64.0702100913020.8424@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Marco Costalba <mcostalba@gmail.com>,
	GIT list <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sun Feb 11 07:33:55 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HG8HX-0002vG-Gy
	for gcvg-git@gmane.org; Sun, 11 Feb 2007 07:33:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753112AbXBKGds (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 11 Feb 2007 01:33:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753116AbXBKGds
	(ORCPT <rfc822;git-outgoing>); Sun, 11 Feb 2007 01:33:48 -0500
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:45136 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753112AbXBKGdr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 11 Feb 2007 01:33:47 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070211063348.RZFG21668.fed1rmmtao102.cox.net@fed1rmimpo01.cox.net>;
          Sun, 11 Feb 2007 01:33:48 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id N6Zm1W0061kojtg0000000; Sun, 11 Feb 2007 01:33:47 -0500
In-Reply-To: <Pine.LNX.4.64.0702100913020.8424@woody.linux-foundation.org>
	(Linus Torvalds's message of "Sat, 10 Feb 2007 09:37:58 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39274>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Sat, 10 Feb 2007, Nicolas Pitre wrote:
>> > >
>> > > Because git-status itself is conceptually a read-only operation, and 
>> > > having it barf on a read-only file system is justifiably a bug.
>> > 
>> > I do not 100% agree that it is conceptually a read-only operation.
>> 
>> It is.
>
> It really isn't. 
>
> It's not even a "technical issue". It's a fundamental optimization. Sure, 
> you can call optimizations just "technical issues", but the fact is, it's
> one of the things that makes git so _usable_ on large archives. At some 
> point, an "optimization" is no longer just about making things slightly 
> faster, it's about something much bigger, and has real semantic meaning.
> ...
> THIS IS NOT "JUST A TECHNICAL ISSUE". 
> ...
> And the index is what makes it so. 
>
> And that's why it's important to keep the index up-to-date.

I think a one paragraph summary of your argument is:

 - index is a good thing -- it is what makes the difference
   between usable and unusable.

 - git-status needs to refresh the index in order to do its
   thing efficiently and usably _anyway_, so once it spends
   cycles to do so, it is senseless not to write the refreshed
   index out when it can.

I do not think anybody disputes that in a repository with 20k+
paths, it is sensible to leave the index stat-dirty for all
paths.  But I think your example

	read-tree HEAD

misses the point by stressing the importance of index too much.
Index is important for the usability and I do not think anybody
is disputing it.

The thing is, nobody switches the index that way without running
"update-index --refresh" afterwards.  Normal people would use
git-reset to switch to a different tree object, and the command
does that for you.  If you are a hardcore, you would know to use
"read-tree -m HEAD" at least to avoid making paths unnecessarily
stat-dirty.  Your example, while it is valid and demonstrates
why the index is a good thing very well, is simply not part of
a normal workflow and not very relevant when discussing the
performance ramifications of what state "git-status" should
leave the index in.

When I said "calling 'update-index --refresh' in git-status
loses stat-dirtiness information", I was certainly _NOT_ talking
about losing the information that 20k+ paths used to be
stat-dirty because the user did "read-tree HEAD" earlier.

At least for me, it is very normal to do something like this.

 * start from a clean index.

 * edit cache.h, diff.h, and diff-lib.c.

 * stop, think, and realize that my earlier edit to change one
   function prototype in diff.h was not needed, and revert the
   change to that line still in the editor.

 * fix things up further by editing other files.

And then, I would run "git diff" to see where I am.  I still
remember that I touched diff.h and I also remember that I once
changed a function prototype but then decided the change was not
necessary after all, but I do not remember if I changed anything
else in the file.  It is _very_ assuring to see the emptiness
that follows "git diff --git" header for diff.h in such a case.
Seeing the path to be stat-dirty is a very good thing for me,
because otherwise I might lose a few seconds thinking that what
I thought I touched might have been cache.h and not diff.h.

To me, running "git status" is "wrapping things up" step.  I do
not need that stat-dirty assurance "git diff" gave me at that
point.  Not seeing diff.h in "modified but updated" list is a
good thing.  And in my workflow, after that 'wrapping things up"
step, I do not need that stat-dirty assurance _anymore_.

I think Nico is correct to point out that "not _anymore_" part
of the above reasoning of mine assumes _my_ workflow and
preference, and I think that is a valid point.  Not saving the
refreshed index would make the stat-dirtiness for diff.h to come
back, which would be inconvenient and annoying to me.

But the user might want to keep it stat-dirty after running
"git-status".  People in "not _anymore_" camp like me can throw
the stat-dirtiness away by "update-index --refresh".  I do not
think he (or anybody) is advocating to keep 20k+ paths in
stat-dirty state (arguably, "artificially" due to use of
"read-tree HEAD"), so your example using "read-tree HEAD" only
confuses the discussion.

Having said all that, I do agree with you that git-status should
throw that stat-dirtiness information away by saving the
refreshed index.  Doing otherwise is annoying to me as I already
said, and I do not think of a valid reason for the user to want
to keep stat-dirtiness information after running "git-status",
because to me the whole point of running "git-status" is to
start wrapping things up.
