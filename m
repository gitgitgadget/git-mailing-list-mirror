From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Re: keeping remote repo checked out?
Date: Tue, 29 Nov 2005 11:28:27 -0800
Message-ID: <7vk6erfe3o.fsf@assigned-by-dhcp.cox.net>
References: <m3k6et9rdw.fsf@lugabout.cloos.reno.nv.us>
	<7vbr051ad1.fsf@assigned-by-dhcp.cox.net>
	<20051128105736.GO22159@pasky.or.cz>
	<7vsltgtvk4.fsf@assigned-by-dhcp.cox.net>
	<20051128212804.GV22159@pasky.or.cz>
	<Pine.LNX.4.64.0511281420390.3263@g5.osdl.org>
	<Pine.LNX.4.64.0511281845280.25300@iabervon.org>
	<Pine.LNX.4.64.0511281637480.3177@g5.osdl.org>
	<Pine.LNX.4.64.0511282027360.25300@iabervon.org>
	<Pine.LNX.4.64.0511281837040.3177@g5.osdl.org>
	<Pine.LNX.4.64.0511282208050.25300@iabervon.org>
	<Pine.LNX.4.64.0511282029290.3177@g5.osdl.org>
	<Pine.LNX.4.64.0511282337170.25300@iabervon.org>
	<7vmzjom00m.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0511290141220.25300@iabervon.org>
	<7v8xv7lwlr.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0511291157260.25300@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Petr Baudis <pasky@suse.cz>,
	Linus Torvalds <torvalds@osdl.org>
X-From: git-owner@vger.kernel.org Tue Nov 29 20:33:09 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EhB9V-0004DC-7r
	for gcvg-git@gmane.org; Tue, 29 Nov 2005 20:28:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751349AbVK2T2a (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 29 Nov 2005 14:28:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751351AbVK2T2a
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Nov 2005 14:28:30 -0500
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:29840 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S1751349AbVK2T23 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Nov 2005 14:28:29 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20051129192743.DPXC20441.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 29 Nov 2005 14:27:43 -0500
To: Daniel Barkalow <barkalow@iabervon.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12952>

Daniel Barkalow <barkalow@iabervon.org> writes:

> This seems maximally inconvenient. If you lose a race, you only find out 
> later, your reception branch is screwed up, and you have no way of finding 
> out in advance that this is going to happen?

I am not sure what you mean by "your reception branch is screwed
up".  We _could_ rewind that reception branch after acceptance
test fails but I did not mention that because I haven't thought
it through.

This was actually designed to reduce the chance of getting a
race in the first place, so I am not sure if it makes things
inconvenient.

Alice and Bob starts out from the central repository commit O
(for origin), and make progress independently.  They have one
commit on top of O each, A and B where A~1 === O and B~1 === O.

Alice pushes first, the central repository has O and accepts
because updating from O to A is a fast forward.  Bob tries to
push, and in the classic CVS-style shared repository setup in
the tutorial, this is prevented because this is not a fast
forward.  Bob needs to first pull and merge A and B to create C
(C^1 === B, C^2 === A) and push that.  This succeeds.

Instead, the approach allows you to choose to do the merge on
the server side unattended, as part of the acceptance check.

Alice pushes, and both her reception branch and the reception
repository master becomes A (fast forward).  When Bob pushes B
to his reception branch, we attempt to pull it into reception
repository master --- we do not have to fail this pull even if
it is not a fast forward (we could choose to fail it). reception
repository master becomes C which is a merge between A and B.
The result of this automerge needs to be checked for sanity, so
before this C (new reception repository master) is pulled into
the deployment repository, there is a validation step (this step
can do things other than validation; e.g. making tarballs for
distribution, automatic tagging).  While all that is happening,
other people can be pushing into their own reception branches,
waiting for their turn.  And we guarantee that what is moved to
the deployment repository has been tested "clean" (depending on
the quality of test, that is).

If the central repository acceptance policy is simple enough,
namely, if it takes whatever an individiual developer with push
access says is good at the face value, then we do not need any
of the above, and a simple "fast forward only" is good enough,
far simpler to explain and understand.

On the other hand, at places where management already has rules
that require any update to the central repository to first pass
a test suite, the acceptance test can take time to complete ---
which enlarges the race window --- and more importantly when a
push that passed a simple "fast forward only" rule fails, we
somehow need to prevent that failed head from leaking out to the
public.  That is cumbersome to arrange if we only use a single
reception branch.

In case it was not obvious, the reception repository is meant to
be push-only, and all the fetching for public consumption are
meant to happen from the deployed repository "master".  Most
importantly, reception branches in reception repository are not
to be pulled by individual developers.
