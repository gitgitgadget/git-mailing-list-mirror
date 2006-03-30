From: Junio C Hamano <junkio@cox.net>
Subject: Re: How to switch kernel customizations from 2.6.15.6 to 2.6.16?
Date: Wed, 29 Mar 2006 19:15:58 -0800
Message-ID: <7v7j6c62s1.fsf@assigned-by-dhcp.cox.net>
References: <1143596622.2481.10.camel@mattlaptop.metaesthetics.net>
	<Pine.LNX.4.64.0603281749060.15714@g5.osdl.org>
	<7vlkutc36w.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0603291102440.15714@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 30 05:16:30 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FOne8-0003Xb-UL
	for gcvg-git@gmane.org; Thu, 30 Mar 2006 05:16:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751241AbWC3DQE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 29 Mar 2006 22:16:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751260AbWC3DQE
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Mar 2006 22:16:04 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:28642 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1751241AbWC3DQB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Mar 2006 22:16:01 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060330031600.NWDZ6244.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 29 Mar 2006 22:16:00 -0500
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18187>

Linus Torvalds <torvalds@osdl.org> writes:

> For example, in the most trivial format, doing a
>
> 	git rebase <branchname>
>
> the _logical_ thing (from just reading the command) to believe the above 
> does is to think that it rebases the named branch. I pretty much guarantee 
> that that is what any native English speaker would think it does, if they 
> thought about it.

Not really.  Most of the commands in git suite operate on the
current branch.

After thinking about it a bit more, I still agree with you that
things are not as easy to explain as they should be, but I do
not think rebase is so broken anymore.

> In contrast, here's an alternate workflow that is much easier to explain, 
> and doesn't involve "rebase" at all:
>
> 	git checkout his
> 	git cherry-pick origin..mine

This is _easy_ to explain, yes.  However, I do not necessarily
agree with what you said here:

> In particular, what do you think happens when a patch in the series 
> doesn't apply under the two circumstances? Which workflow has the 
> "intuitive" way of recovering, and which does not?
>
> Right. The second one has a very intuitive way to recover. In fact, it's 
> so intuitive that the answer may be "ok, I'll skip that one commit 
> entirely because I don't know how to resolve it, and instead cherry-pick 
> the rest, and ask the original author to cherry-pick it for me later". And 
> doing so is as easy as
>
> 	git reset --hard	# undo the mess from the failed one,
> 				# the same way we always do for all
> 				# other failed things
>
> 	git cherry-pick next..mine	# do the rest

It is not so easy to figure out what the next should be.  If we
limit ourselves to the simplest case that origin is an ancestor
of mine, yes, but in general, no.  We are rebasing presumably
because upstream made independent progress so "origin" would not
be an ancestor of mine anymore; and you are talking about the
generic rev-list syntax next..mine === ^next mine.

"reset --hard" to stop cherry picking is easy.  I do not think
continuing is as easy as you made it sound like.

There was a nontrivial amount of thought went into making the
"rebase" restartable.  Actually, that thought was really for
making the "am" restartable, and the hope was once the user
becomes familiar with how to restart "am", restarting "rebase"
is just as easy because you restart them the same way.  You have
it fall back to 3-way merge (and in the case of rebase, it _can_
fall back to 3-way when the patch does not apply, because all
the blob object names recorded in the intermediate patch format
are from your local repository), you resolve and prepare the
index to be committed, and say "git am --resolved".  We _could_
make "git rebase --resolved" a synonym for "git am --resolved",
because "rebase" being tied to "am" only because the former is
implemented in terms of the latter behind the user _is_
unintiutive.

> See? That's a very logical thing to do. It's different from "git rebase", 
> but it's different in a _good_ way.

As I said, yes, the part to punt is easy.  But that is different
from being able to continue smoothly.  And if you want to punt
during "rebase", you could just as easily do "git reset --hard
ORIG_HEAD", just like you would punt a failed merge with "git
reset --hard ORIG_HEAD".

The non-English (and no natural language I presume) syntax
rebase takes is a mistake from understandability point of view.
I fully agree with that.  Let me think aloud how we could
rephrase them better.

(1) git rebase origin

         A---B---C master (HEAD)
        /
    ---o---o---o---o origin

    I started building on tip of his but while I was woking on
    it he made independent progress.  I want to rebuild my
    branch as if I started at the tip of his current branch.

                     A---B---C master (HEAD)
                    /
    ---o---o---o---o origin

(2) git rebase --onto origin A..C

         A---B---C master (HEAD)
        /
    ---o---o---o---o origin

    I started building on tip of his but while I was woking on
    it he made independent progress.  I want to rebuild my
    branch as if I started at the tip of his current branch, but
    come to think of it I do not need A anymore.

                     B---C master (HEAD)
                    /
    ---o---o---o---o origin

    I personally feel _this_ form is the most logical, and form
    (1) for the sake of consistency could be spelled as:

        $ git rebase --onto origin origin..master

    So you could think of (1) a convenient shorthand for this
    spelled-out form.

(3) git rebase --onto origin A..C topic

               B---C topic
              /
         .---A---. master (HEAD)
        /
    ---o---o---o---o origin

    I have a topic that interferes with what he did in his
    latest updates, and I'd like to resolve the conflicts
    early.  Currently I am not on that branch so first let me
    switch to it.

         .---A---. master
        /
    ---o---o---o---o origin
                    \
                     B---C topic (HEAD)

    This form was done only as a shorthand to save typing "git
    checkout topic" at the beginning, just like "git checkout -b
    newbranch" can be used to save typing "git branch newbranch"
    before the checkout, but I agree it may have made things
    more confusing.  We _could_ deprecate this form and require
    the user to always switch branches before starting the
    rebase.
