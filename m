From: Junio C Hamano <junkio@cox.net>
Subject: Re: bad git pull
Date: Sat, 17 Dec 2005 01:28:37 -0800
Message-ID: <7v4q582htm.fsf@assigned-by-dhcp.cox.net>
References: <68948ca0512151537v2d8f22c8x962c55bd507af8cf@mail.gmail.com>
	<7vzmn2kjw1.fsf@assigned-by-dhcp.cox.net>
	<7vu0d9lxx9.fsf@assigned-by-dhcp.cox.net>
	<118833cc0512161007k38fdd15w2dcdf0c93f26d29e@mail.gmail.com>
	<7vfyoshmp6.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0512161347490.3698@g5.osdl.org>
	<118833cc0512161637v1d180f9fh66a7dc6d3fe11d2b@mail.gmail.com>
	<Pine.LNX.4.64.0512161701400.3698@g5.osdl.org>
	<7vy82kbiho.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0512162342010.3698@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Dec 17 10:29:31 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EnYN9-0001bs-G8
	for gcvg-git@gmane.org; Sat, 17 Dec 2005 10:28:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932233AbVLQJ2j (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 17 Dec 2005 04:28:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932255AbVLQJ2j
	(ORCPT <rfc822;git-outgoing>); Sat, 17 Dec 2005 04:28:39 -0500
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:245 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S932233AbVLQJ2i (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 17 Dec 2005 04:28:38 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051217092756.LBUJ15695.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 17 Dec 2005 04:27:56 -0500
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0512162342010.3698@g5.osdl.org> (Linus Torvalds's
	message of "Fri, 16 Dec 2005 23:44:02 -0800 (PST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/13774>

Linus Torvalds <torvalds@osdl.org> writes:

> That said, I think a lot of newbies might want to have a "git undo", and 
> not because of any BK history. Even if it just ends up being nothing but 
> shorthand for "git reset --hard ORIG_HEAD".

I agree to this in principle, but I am afraid "git undo" is too
generic and fuzzy a term.  Things you might possibly want to
undo depends on what you did last [*1*].  In most undoable
cases, "reset --hard" is almost right but most likely would
result in information loss.

If we want to really newbie-proof the "undo" command, I think
the hard ones are not the ones that can be approximated with
reset ORIG_HEAD, but other "No way to undo" ones and "Nothing to
undo" ones.

Earlier on the list I gave an overview on merge for an unnamed
person with only an e-mail address, and one thing struck me as
quite hard to explain was that there are two kinds of "merge
failures" --- ones that did not even start the merge and ones
that failed in the middle due to conflicts.  Somebody totally
new to git, after seeing "git pull" to fail in the first kind,
would get scared and type "git undo".  We could prevent doing
damage by making sure we remove ORIG_HEAD in "Nothing to undo"
situations, but if we say "Nothing to undo" when the user types
"git undo" in such a situation, we will surely hear "what do you
mean?  the command said failed to pull and I wanted to recover
from that!".

It also is not clear if it is wise to clear ORIG_HEAD for "No
way to undo" ones.  Doing so would rob useful undo information
from people who know git and expect "No way to undo" ones do not
muck with the existing ORIG_HEAD.

Even for the ones that we would do "reset --hard ORIG_HEAD",
many lose information, and "undo" to me implies "undo only what
the last command messed up", which is not what actually happens.

The word "reset" does not have that connotation -- it takes you
to some defined state, which may be close to what you had before
but may not be exactly the same if you had local changes in your
tree.  HEAD, ORIG_HEAD, and HEAD^ are such defined states you
can go, and the user gives where he wants to go explicitly.
"undo" does not really say where to go and hides halfway what we
do, without doing exactly what the user would expect (and cannot
be implemented fully unless we are willing to take a snapshot of
working tree, I suspect).

[Appendix]

*1* List of commands that a user might want to undo.

A merge or non-merge commit, cherry-pick, and revert::
	reset --hard HEAD^ ;# this can be helped by leaving ORIG_HEAD
                            # but "--hard" is not quite right;
                            # your working tree could have been
                            # dirty at irrelevant paths

A fetch fast-forwarding non-current branch::
	No way to undo -- we do not keep the old information.

A merge, that was fast-forward::
	reset ORIG_HEAD ;# never "--hard" -- your working tree could
                         # have been dirty and in this case
                         # there is no information loss.

A merge attempt, conflicted::
	reset --hard ORIG_HEAD
                         # again, "--hard" is not quite right --
			 # your working tree could have been
                         # dirty at irrelevant paths.

A merge attempt, did not even start because index or tree was dirty::
	Nothing to undo.

A successful checkout (switch branch)::
	No way to undo -- we do not keep the old information.

git-update-index and git-add::
	No way to really undo -- we do not keep the old
	information.  The closest is "git reset" but it reverts
	more than the last operation.

rebase::
	reset --hard ORIG_HEAD

am/applymbox::
        No way to undo -- we do not keep the old information.
			;# this can be helped by leaving ORIG_HEAD
