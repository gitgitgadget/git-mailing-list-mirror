From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-http-push and hooks
Date: Tue, 07 Feb 2006 15:26:28 -0800
Message-ID: <7vpslysqcb.fsf@assigned-by-dhcp.cox.net>
References: <20060206205203.GA20973@guybrush.melee>
	<20060206232231.GK3873@reactrix.com>
	<20060207195458.GA7217@c165.ib.student.liu.se>
	<20060207202351.GA3833@reactrix.com>
	<7vwtg6uaw6.fsf@assigned-by-dhcp.cox.net>
	<20060207224551.GB3833@reactrix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 08 00:26:47 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F6cEK-0002u4-38
	for gcvg-git@gmane.org; Wed, 08 Feb 2006 00:26:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030265AbWBGX0e (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 7 Feb 2006 18:26:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030261AbWBGX0d
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Feb 2006 18:26:33 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:4505 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1030265AbWBGX0c (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Feb 2006 18:26:32 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060207232635.QXRH25099.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 7 Feb 2006 18:26:35 -0500
To: Nick Hengeveld <nickh@reactrix.com>
In-Reply-To: <20060207224551.GB3833@reactrix.com> (Nick Hengeveld's message of
	"Tue, 7 Feb 2006 14:45:51 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15722>

Nick Hengeveld <nickh@reactrix.com> writes:

> What happens if someone else updates a ref and it no longer
> matches your local ref?  Should the push scan the remote
> versions of all local refs and update whatever doesn't match?

If I and you clone from a shared repository at the same time, I
did my development while you did your own on top of that same
commit without pulling from the repository further, and I
uploaded my changes to update the ref, what should happen to you
once you are ready to push?

Is that what being asked?

If so, I think the sensible thing to do is to reject your push
and suggest you to pull first, just like the git native protocol
push does.  That pull would end up first merging my changes to
your work in your repository, and then you can push the result
back to the shared repository.  Otherwise you would lose my
changes.

The criteria to allow a push is obviously not "no longer
matches" because in the above scenario what both you and I
fetched from the shared repository is something that is an
ancestor of what each of us is trying to push.  The first one
should succeed -- it is pushing a new commit that is a
descendant of what is currently the head of the shared
repository.  The latter one fails because at that time the head
of the shared repository is not an ancestor of what you are
trying to push.

If you are asking about a race, yes there is a race condition
and you have to be careful.  The native protocol does it like
so (receive-pack.c):

 1. At the shared repository grab the current head;

 2. Examine what is being pushed.  Is it a descendant of the one
    we grabbed in the previous step?  If not, reject.

 3. Lock the ref, grab the current head again, make sure it is
    still the same as what we got in the first step, update it
    with what was pushed, and then unlock.

I think you may be able to do a similar check on the client
side, if DAV allows locking resources at least for a brief
period.

If you are asking about updating local tracking branch for the
remote ref after a successful push, I think that is an optional
feature and is entirely up to you.  For example, if your
workflow is to fetch from the shared repository into origin,
merge that into master, work on master, and then push the result
to the master branch of the shared repository, you could update
your origin with the commit you just pushed.  This lets you
pretend as if you fetched from there immediately after your
successful push.

I think Cogito does it that way, but I personally found leaving
the tracing ref as-is after a push more useful, so I left
git-push not to do so.  For example, leaving when to update
"origin" up to me allows me do run "git log origin..master" to
write the "what's new in git.git" message after I push.  Of
course the same thing can be done by running the git log before
I push, so there is not much practical difference either way.
