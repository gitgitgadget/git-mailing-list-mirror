From: Junio C Hamano <junkio@cox.net>
Subject: Re: [Census] So who uses git?
Date: Wed, 01 Feb 2006 00:26:25 -0800
Message-ID: <7virrzfpse.fsf@assigned-by-dhcp.cox.net>
References: <46a038f90601251810m1086d353ne8c7147edee4962a@mail.gmail.com>
	<Pine.LNX.4.64.0601272345540.2909@evo.osdl.org>
	<46a038f90601272133o53438987ka6b97c21d0cdf921@mail.gmail.com>
	<1138446030.9919.112.camel@evo.keithp.com>
	<7vzmlgt5zt.fsf@assigned-by-dhcp.cox.net>
	<20060130185822.GA24487@hpsvcnb.fc.hp.com>
	<Pine.LNX.4.63.0601311127250.25248@wbgn013.biozentrum.uni-wuerzburg.de>
	<Pine.LNX.4.64.0601311750270.25300@iabervon.org>
	<7vek2oot7z.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0601311623240.7301@g5.osdl.org>
	<7v4q3jlgw2.fsf@assigned-by-dhcp.cox.net>
	<87vevzpmql.wl%cworth@cworth.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 01 09:27:01 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F4DJy-00026s-Bl
	for gcvg-git@gmane.org; Wed, 01 Feb 2006 09:26:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750912AbWBAI03 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Feb 2006 03:26:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751089AbWBAI03
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Feb 2006 03:26:29 -0500
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:58102 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1750912AbWBAI03 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Feb 2006 03:26:29 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060201082631.HOQH25099.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 1 Feb 2006 03:26:31 -0500
To: Carl Worth <cworth@cworth.org>
In-Reply-To: <87vevzpmql.wl%cworth@cworth.org> (Carl Worth's message of "Tue,
	31 Jan 2006 23:22:10 -0800")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15393>

Carl Worth <cworth@cworth.org> writes:

> ... it seems it should be possible to have a class of
> "novice ready" tools that provide for common use cases and that never
> require any mention of the index in their documentation. If so, that
> seems to me a useful goal to work toward and a useful guide in this
> discussion.

I agree it is a worthy goal.  Unfortunately I lost my git
virginity long time ago, so a fresh perspective is really
appreciated in this discussion.

> ... Could you explain what the danger is here?

As Linus mentioned in an earlier message in this thread, one of
the important task for him is to take other peoples' trees and
merge it into his mainline.  The workflow goes like this:

	$ git pull from-somewhere
        ... oops there are conflicts
        $ edit conflicted/file
        $ edit more/conflicted/file
        ... maybe compile test ...
	$ git diff -c ;# final sanity check
        $ git update-index conflicted/file
        $ git update-index more/conflicted/file
        $ git commit

He does *not* want to do "git commit -a" here, because he
usually has unrelated changes in his working tree he has not
done update-index on and does _not_ want to commit [*1*].  "git
commit" to imply "git commit -a" increases the risk of
accidentally committing those unrelated changes mixed in the
merge (eh, actually makes the risk 100%).

We _could_ detect that we were in the middle of a merge,
enumerate the paths touched by the merged branches.  Then we can
say paths that are different between the index and the working
tree and not in the paths touched by the merge are his unrelated
changes.  But it is conceivable he may need to modify a file
neither branch touches in order to _logically_ resolve the
merge, even when the merge phisically does not conflict in
textual diff basis, so while that heuristics may work pretty
well most of the time, doing so might make things even less
easier to explain to other people.


[Footnotes]

*1* The reason he has unrelated changes while doing a merge is
because he works on things himself (I am speculating about
this), and for these modified paths he never runs git-add nor
git-update-index until he is ready to commit his changes (I am
not speculating about this).  As long as he knows what he is
pulling in from outside does not overlap with what he has been
working on, he can merge and commit the result without worrying
about his own unrelated changes, and git is careful not to touch
anything in his working tree to cause information loss when the
changes do overlap [*2*].

He is committing something that he never tested himself in his
working tree as a whole.  The tree resulting from the merge
never existed outside his index file, so there is no way he
could have even compile tested it properly.  But for somebody
who is playing an integrator's role, it is not his primary job
to examine and test every change he merges in as a whole at
nitty-gritty level -- that is what the originator of the change
should have done.  So having uncommitted changes in the working
tree for an integrator person is not a sign of bad discipline at
all, and supporting this workflow _is_ important for git.

The primary reason I first got involved in git was because I
wanted to help the workflow of the kernel people, especially
Linus and the subsystem maintainers.  To be honest, I personally
still consider the kernel people the first tier customers for
me, and I stop and try to think twice when thinking about a
change or a new feature that may help individual developers and
newcomers, to make sure such a change does not make life less
convenient for the 'integrator' people.  Helping integrators to
be more efficient is important because they can become
bottlenecks.

*2* I once got yelled at by Linus when I carelessly broke this
feature and changed 'git-merge' to require a clean working tree
without changes before starting a merge; it was quickly
reverted.
