From: Junio C Hamano <junkio@cox.net>
Subject: Re: git rebase behaviour changed?
Date: Tue, 17 Jan 2006 00:11:50 -0800
Message-ID: <7v8xtfclyx.fsf@assigned-by-dhcp.cox.net>
References: <43CC695E.2020506@codeweavers.com>
	<7vslrnh080.fsf@assigned-by-dhcp.cox.net>
	<43CC89DC.5060201@codeweavers.com>
	<46a038f90601162252y7e2d9227p4eb4091b653d5c6d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Mike McCormack <mike@codeweavers.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 17 09:12:04 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EylwZ-0005c1-1K
	for gcvg-git@gmane.org; Tue, 17 Jan 2006 09:11:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751341AbWAQILw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Jan 2006 03:11:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751345AbWAQILw
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Jan 2006 03:11:52 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:57247 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1751341AbWAQILw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Jan 2006 03:11:52 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060117081059.TSHE3131.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 17 Jan 2006 03:10:59 -0500
To: Martin Langhoff <martin.langhoff@gmail.com>
In-Reply-To: <46a038f90601162252y7e2d9227p4eb4091b653d5c6d@mail.gmail.com>
	(Martin Langhoff's message of "Tue, 17 Jan 2006 19:52:32 +1300")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/14786>

Martin Langhoff <martin.langhoff@gmail.com> writes:

> Now, I have realised that a simple mistake (merging from origin in you
> scenario) would lead git-rebase to discard earlier patches during the
> rebase. If you had a single commit *after* the merge, git-rebase would
> have rebased that single patch, and dropped earlier patches.

It may not necessarily be a mistake.

> git-rebase should refuse to run in the above scenario. Is there a
> straightforward way to ask if the merge base is "shared"?
>
> <thinking>
>...
> </thinking>

Sorry I am always slow but I am a bit slower than I usually am
tonight, and do not understand this part without an
illustration:

        master    1---2---3---4---5---A
                 /           /
	origin  0---6---7---B


                A = master head
                B = origin head == merge base

	rev-list B..A = 1 2 3 4 5
        rev-list A..B = 6 7

The first rev-list is "what we have but they do not".  They are
the candidates to be fed upstream.  The latter is "what they
have but we do not".  Potentially some of them are commit that
represent patches we submitted earlier upstream.

Among the first list of commit, there is #4 which is a merge.
So we reject.  Is that what you meant?  Which makes sense in
this picture (but I am a bit tired and maybe this may not apply
in a different picture).


By the way, the longer I think about this, the more I agree with
the conclusion of the earlier thread: "if you rebase, do not
merge; if you merge, do not rebase".  It is really about picking
the right workflow.

Let's say you submitted #1, #2, #3 earlier, and #3 was accepted
upstream and came back as #7, and let's further assume that we
are lucky enough that patch-id gives the same answer for
"diff-tree #2" and "diff-tree #7".  So the set of commits left
are #1, #3, and #5 (#4 is just a merge so we will not re-apply).

Now, what is the shape of the final "rebased" ancestry graph we
would want?


        master                1'--3'--5'--A'
                             /
	origin  0---6---7---B

If this is what we want, why did we make #4 merge in the first
place, I wonder.  If the workflow is based on rebase [*1*],
instead of making a merge at #4, the developer *should* have
done fetch and rebase, not merge:

        master    1---2---3
                 /
	origin  0---6---7---B

        ==>

        master                1'--3'
                             /
	origin  0---6---7---B

This would have been easier to manage at the point we discovered
#6, #7, and #B, than creating #4 merge only to discard it later.

And #5 and #A can be built on top of #3'.

        master                1'--3'--5---A
                             /
	origin  0---6---7---B


[Footnote]

*1* That is certainly easier to manage for an individual
developer than a merge based workflow.  I know it because I
operated that way for a long time back when Linus was managing
git)
