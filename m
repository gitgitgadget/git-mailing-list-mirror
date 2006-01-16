From: Junio C Hamano <junkio@cox.net>
Subject: Re: Question on empty commit
Date: Mon, 16 Jan 2006 14:58:53 -0800
Message-ID: <7vy81fok42.fsf@assigned-by-dhcp.cox.net>
References: <7vmzhx7ref.fsf@assigned-by-dhcp.cox.net>
	<20060116215856.6618.qmail@web31805.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 16 23:59:27 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EydJR-0003n3-G6
	for gcvg-git@gmane.org; Mon, 16 Jan 2006 23:58:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751251AbWAPW6z (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Jan 2006 17:58:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751254AbWAPW6z
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jan 2006 17:58:55 -0500
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:61092 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S1751251AbWAPW6y (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jan 2006 17:58:54 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060116225659.VVOY17006.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 16 Jan 2006 17:56:59 -0500
To: ltuikov@yahoo.com
In-Reply-To: <20060116215856.6618.qmail@web31805.mail.mud.yahoo.com> (Luben
	Tuikov's message of "Mon, 16 Jan 2006 13:58:56 -0800 (PST)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14765>

Luben Tuikov <ltuikov@yahoo.com> writes:

>> I do not quite follow you, but immediately before the "empty
>> commit" (I presume you mean the last "git merge" that merges
>> treeA head in treeB), you say "the treeA and treeB had been in
>> sync".
>
> Meaning that merging Tree A into Tree B would introduce 0 changes
> to Tree B.

You had two separate development tracks treeA and treeB, and the
entire merge result is taken from treeB because it had all the
changes from the common upstream already and there was no
development in treeA on its own:

          treeB ---------o--o--o--*--o--o---*--o..?
                                 /         /     .
                                /         /     .
          common upstream ---- / --o--o--o--o  .
                              /           \   . 
                             /             \ .
          treeA ------o--o--o---------------*
                                    ^
                                    |
                     No commit on this segment.

                o are commits, * are merge commits.

and we are trying to merge the last commit on treeA line into
the tip of treeB.  The last merge commit on the treeB line of
development would introduce zero change from treeB's point of
view, because there is nothing new treeB would get by merging
with treeA.

Before the '?' mergepoint, what is known about treeA and treeB
was that treeB contained everything up to the third from the
left 'o' commit on treeA line.  We now noticed that treeA has
some changes since then (i.e. all the good stuff from the common
upstream), and merge even has noticed that these changes happen
to be already what treeB already had and you did not have to
hand resolve (or you might have had to; I dunno).  Making a
commit for '?' merge records the fact that these two tips are in
sync.  IOW, earlier treeB did not know about the merge commit at
the tip of treeA; now it does.

After this sync, if you try to merge again with treeA, no merge
commit would be made, of course.  Now you are truly up-to-date.

When git talks about a branch being up-to-date wrt another
branch, it is not about "all of the patches that the other line
has have been applied to our tree" (we are not a patchset based
system like darcs).  It is about commit ancestry, IOW, "in the
past we have merged with them, and all the commits that line has
right now are what we have already examined when we made that
merge" is what we mean by us being up-to-date wrt them.

Fast-forward is the other way around but the principle is the
same.  We are fast-forward to them not because we have applied
all the patches they have and we have more.  We are fast-forward
because we have seen all of their commits in the past and
recorded in our commit ancestry chain that fact as a merge, and
in addition we have one or more commits on top of that merge
commit.  That is when we are fast-forward wrt to them.
