From: Junio C Hamano <junkio@cox.net>
Subject: Re: On ref locking
Date: Mon, 25 Sep 2006 21:11:27 -0700
Message-ID: <7virjbw9lc.fsf@assigned-by-dhcp.cox.net>
References: <20060918065429.6f4de06e.chriscool@tuxfamily.org>
	<200609231322.30214.chriscool@tuxfamily.org>
	<7veju2nthl.fsf@assigned-by-dhcp.cox.net>
	<200609240645.54467.chriscool@tuxfamily.org>
	<7vmz8o1em0.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0609251140550.9789@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christian Couder <chriscool@tuxfamily.org>, git@vger.kernel.org,
	Linus Torvalds <torvalds@osdl.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Sep 26 06:12:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GS4IM-000673-13
	for gcvg-git@gmane.org; Tue, 26 Sep 2006 06:11:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750852AbWIZEL3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 26 Sep 2006 00:11:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750847AbWIZEL3
	(ORCPT <rfc822;git-outgoing>); Tue, 26 Sep 2006 00:11:29 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:28092 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1750761AbWIZEL3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Sep 2006 00:11:29 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060926041128.BTZS6235.fed1rmmtao06.cox.net@fed1rmimpo01.cox.net>;
          Tue, 26 Sep 2006 00:11:28 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id SsBR1V00n1kojtg0000000
	Tue, 26 Sep 2006 00:11:26 -0400
To: Daniel Barkalow <barkalow@iabervon.org>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27763>

Daniel Barkalow <barkalow@iabervon.org> writes:

> On Mon, 25 Sep 2006, Junio C Hamano wrote:
>...
>> What the latter means is that an updater:
>> 
>>  (1) first learns the current value of the $ref, without
>>      locking;
>> 
>>  (2) decides based on the knowledge from (1) what the next value
>>      should be;
>> 
>>  (3) gets $ref.lock, makes sure $ref still is the value it
>>      learned in (1), updates it to the desired value and
>>      releases the lock.
>> 
>> The above 3-step sequence prevents updater-updater races with an
>> extremely short critical section.  We only need to hold the lock
>> while we do compare and swap.
>
> I remember having a certain amount of disagreement over whether it's 
> better to actually take the lock in (1), and hold it through (2), or only 
> verify that it didn't change in (3) after taking the lock for real. If 
> there's nothing substantial going on in (2), it doesn't matter. If users 
> are producing content (e.g., git tag), they may want to make sure that 
> nobody else is in the middle of writing something that would conflict.
>
> I think I'd advocated getting the lock early if you're going to want it, 
> and I don't remember what the convincing argument on the other side was 
> for the cases under consideration at the time, beyond it not mattering 
> significantly.
>
> Note that we make sure to remove the lock when aborting due to signals 
> (assuming we get a chance), so the size of the critical section doesn't 
> matter too much to the chance of it getting left locked inappropriately. 
> Of course, this is harder to do with the core code for a shell script than 
> for C code.

I do not recall that arguments on the list but what you say
makes sense.  Taking a lock early makes implementation more
cumbersome on the scripting side but reduces the annoyance
factor.  You will be annoyed if the tool tells you somebody else
did something to the ref you were going to update and your
intended operation is blocked after carefully editing your tag
message or commit log message.

However, I think the distributed nature of git makes it less of
an issue for normal repositories.

Shared distribution point repositories (where everybody pushes
to and fetches from) needs to protect between updaters lest that
we lose commits (fetching a rev older while a push is in
progress is not an error -- re-feching would give you the final
result), and that is what Johannes's recent patch does.  Pushing
into a repository with working tree does have a lot of issues
(e.g. push to update the current branch head while a commit is
in progress) but doing that as the workflow has problems for
other reasons as well (i.e. push to update the current branch
would make the index out of sync even when no commit is in
progress).  It is strongly discouraged to share $GIT_DIR/refs,
just like in any halfway sane development workflow people do not
share working tree files.

So "locking before letting the user spend effort so that we
would not later have to say 'sorry, we cannot let you do that
because somebody else updated the ref in the meanwhile'" is
technically not incorrect, and we should be able to make things
work that way, but I think it pretty much is a "why bother"
issue.  "git tag" checks if the new tag being created does not
exist to reduce the annoyance factor, and the check does not
even attempt to avoid a race.  If we revalidated that the tag is
still not there while storing the tag object name to the ref in
the final step, I think that is good enough, and I think having
"lock during operation" buys us much real-life benefit.

git-commit has the same attitude, and I think it is the right
balance.  It checks if the commit being created is an initial
commit, a single-parent commit or a merge first, prepares "-p"
arguments to the commit-tree that will happen much later, then
lets the user prepare the log message.  Theoretically somebody
else could update the current HEAD in the meantime and the
resulting commit can have ancestors that are different from what
was intended.  We do check and avoid it by making sure that the
HEAD is still where we thought it would be before doing the
final.
