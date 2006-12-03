X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Junio C Hamano <junkio@cox.net>
Subject: Re: Some advanced index playing
Date: Sun, 03 Dec 2006 12:26:49 -0800
Message-ID: <7v1wngwws6.fsf@assigned-by-dhcp.cox.net>
References: <200612031701.15594.alan@chandlerfamily.org.uk>
	<Pine.LNX.4.64.0612031024480.3476@woody.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Sun, 3 Dec 2006 20:26:55 +0000 (UTC)
Cc: git@vger.kernel.org, Alan Chandler <alan@chandlerfamily.org.uk>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-Reply-To: <Pine.LNX.4.64.0612031024480.3476@woody.osdl.org> (Linus
	Torvalds's message of "Sun, 3 Dec 2006 10:34:40 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/33138>
Received: from vger.kernel.org ([209.132.176.167]) by dough.gmane.org with
 esmtp (Exim 4.50) id 1GqxvJ-0003RN-UU for gcvg-git@gmane.org; Sun, 03 Dec
 2006 21:26:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1760070AbWLCU0v (ORCPT <rfc822;gcvg-git@m.gmane.org>); Sun, 3 Dec 2006
 15:26:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760075AbWLCU0v
 (ORCPT <rfc822;git-outgoing>); Sun, 3 Dec 2006 15:26:51 -0500
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:49536 "EHLO
 fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP id S1760070AbWLCU0u
 (ORCPT <rfc822;git@vger.kernel.org>); Sun, 3 Dec 2006 15:26:50 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71]) by fed1rmmtao06.cox.net
 (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP id
 <20061203202650.VAQN5465.fed1rmmtao06.cox.net@fed1rmimpo01.cox.net>; Sun, 3
 Dec 2006 15:26:50 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80]) by
 fed1rmimpo01.cox.net with bizsmtp id uLSF1V00F1kojtg0000000; Sun, 03 Dec 2006
 15:26:15 -0500
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> So "git reset" is generally your friend whenever something goes wrong. If 
> you also want to reset your checked-out files (which you did NOT want to 
> do in this case, of course), you would have added the "--hard" flag to git 
> reset.
>
> And that (finally) concludes this particularly boring "git usage 101" 
> session.
>
> 			Linus

One observation about git, made in a relatively distant past,
was "git is not a usable system yet; there is no 'git undo'".  I
think it was on the kernel list (I think it was from Alan who
seems to have lost his last name from his From: line lately, but
I may be mistaken).

It left a deep psychological trauma in me, not because it was
stated in a brutal way (it wasn't) but because I fully agreed
with that statement from the end user point of view, but I did
not see a good solution to the problem (and I from the beginning
kept saying "I do not do Porcelains" and kept calling what is
shipped with core "Porcelain-ish").

"git reset" is one part of "undo".  For example, undoing a
commit can be approximated with "reset HEAD^" or "reset --hard
HEAD^"; undoing a conflicted and unfinished merge can be
approximated with "reset HEAD" or "reset --hard HEAD".

But for one thing, these are only "approximations" (the working
tree files after these two forms of reset are different from the
state you had before running "commit" or "merge").  And for
another thing, "reset" is only one part of "undo".  "reset"
would not help "undo"-ing a botched "git bisect good", for
example; you need "git bisect reset".  Similarly, "git rebase"
in the middle can be undone with its own --abort option.  But
the user has to know about them.  Another twist is that once
completed, "rebase --abort" obviously would not mean "undo the
last rebase".

I think one cause of the "problem" (if not having a general
"undo" is a problem, and I think it is to some extent) is that
git Porcelain-ish commands try to stay stateless to allow mixing
and matching of different commands to leave the door open to the
end user to be flexible, but they go too far.  Some of the
commands do leave its state (e.g. MERGE_HEAD is a sign of a
merge in progress, and git-commit notices it), and some of the
commands know about state markers from the other commands
(e.g. "git reset" removes MERGE_HEAD).  However, I think we do
not do enough of inter-command coordination.  Although I haven't
checked, I would be very surprised if we already prevented "git
bisect" from running, while a merge is in progress, for example.

While I do not think we need to supply "git undo" for a command
that already ran successfully to its completion (e.g. I think
the answer to "how would I undo a commit I just made" can be
left as "use one of the reset, or --amend, depending on what you
want"), it might be a worthwhile thing to aim for to give a
unified "git oops" command that recovers from a "unusual" state
your git working tree may be left in.

For UI-usability minded people, it might be a good thing to
enumerate the possible 'states' a working tree can be in, draw a
state transition diagram among them, with possible and forbidden
transitions.  After that, we can annotate the allowed
transitions with "use this command to make this transtion
happen".

The following list may be a starter; it is not comprehensive,
and does not list the transitions, though.

 - the base state

 - bisect in progress

 - conflicted merge in progress (or --no-commit given)

 - immediately after "merge --squash" is run but not yet committed

 - conflicted git am/git applymbox in progress.

 - conflicted git rebase in progress (this actually has two
   separate states depending on --merge was used or not).

 - conflicted git revert/cherry-pick (I list this separately
   from 'merge in progress' because this is an example of
   command leaving too little state).

 - conflicted 'git checkout -m' (although this is almost the
   same as the base state, it has higher stages in the index).
