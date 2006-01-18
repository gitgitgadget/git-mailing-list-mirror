From: Junio C Hamano <junkio@cox.net>
Subject: Re: RFC: Subprojects
Date: Tue, 17 Jan 2006 19:49:12 -0800
Message-ID: <7vy81eyz47.fsf@assigned-by-dhcp.cox.net>
References: <43C52B1F.8020706@hogyros.de>
	<Pine.LNX.4.64.0601141055210.13339@g5.osdl.org>
	<7vek3ah8f9.fsf@assigned-by-dhcp.cox.net>
	<200601161144.48245.Josef.Weidendorfer@gmx.de>
	<7vek37rj83.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0601170001130.25300@iabervon.org>
	<7vfynnfkc8.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0601171150050.25300@iabervon.org>
	<7vpsmq2tyb.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 18 04:50:42 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ez4LJ-00040z-7n
	for gcvg-git@gmane.org; Wed, 18 Jan 2006 04:50:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964896AbWARDtT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Jan 2006 22:49:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964903AbWARDtT
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jan 2006 22:49:19 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:53133 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S964896AbWARDtS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jan 2006 22:49:18 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060118034918.JVWM25099.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 17 Jan 2006 22:49:18 -0500
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <7vpsmq2tyb.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Tue, 17 Jan 2006 17:41:48 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14810>

Junio C Hamano <junkio@cox.net> writes:

> Daniel Barkalow <barkalow@iabervon.org> writes:
>
>>> Reading such a commit is easy:
>>> 
>>> 	$ git-read-tree $tree ;# ;-)
>>> 
>>> But that is cheating.  
>>
>> This is for backwards compatibility, I assume?
>
> This is done more for not having to touch *anything* that does
> "index vs working file", "tree vs index" and "tree vs working
> file via index".  It also is the easiest way to keep the "a
> commit object name can be used in place of the tree object name
> of the tree it contains" invariant.  Also I suspect this
> organization might help recursive subprojects, but if it is the
> case, that is just a byproduct, not a design goal.

I started this "bind" design as a thought experiment, but I
started to like it more and more.

One interesting outcome of keeping the whole tree in the index
and the tree object recorded in the commit object of the
toplevel project is that a merge in the toplevel project "just
works".

To preserve our sanity, let's say we refuse to merge two commits
that have different sets of subprojects.  That is, they must
have the "bind" lines for the same set of subdirectories.  The
commits bound at these subdirectories do not need to match.

Before starting a merge, we require that the index is in sync
with the tree object recorded in the top commit, just like we do
for a normal merge[*1*].  Then we use the current merge
machinery that does not know anything about "bind" to perform
the merge, using the merge base of the toplevel project and
usual three-way merge.  From the mechanism point of view, there
is no need to look at commits on "bind" line of either side to
come up with the resulting tree.

We could notice that the commit bound at linux-2.6/ subdirectory
of one side is v2.6.15 and the other side is v2.6.16-rc1, and
because one is a fast-forward of the other, choose to pick the
tree associated with v2.6.16-rc1 commit without actually doing
the 3-way resolve of linux-2.6/ subtree part, but that is purely
a performance optimization [*2*].

When writing out the merge result as a commit, we would create
(this is the fun part) a commit for linux-2.6/ part that has two
parents: the commits bound to linux-2.6/ tree from the two
toplevel commits being merged are the parents of such a
subproject commit.  And the resulting toplevel merge commit
would have that commit object name on its "bind" line.
Obviously, when the bound subproject head of one side is a
fast-forwad of the other, we do not create such a merge commit
for the subproject; instead, we just record the one that is
ahead on the "bind" line of the resulting toplevel merge commit.


[Footnote]

*1* As a side effect, this also ensures the index is in sync
with the bound commits of the subprojects.  As an additional
requirement, we may want to enforce that the bound commits must
match the branch heads that keep track of subprojects.

*2* Of course, from the usability, safety and confusion
avoidance point of view, it _might_ make sense to require that
bound commits are in such fast-forward relationship.  But that
is a policy issue; at the mechanism level, there is no need to
impose such a requirement.
