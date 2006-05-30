From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] git commit --branch
Date: Tue, 30 May 2006 02:12:02 -0700
Message-ID: <7vr72b27x9.fsf@assigned-by-dhcp.cox.net>
References: <20060529202851.GE14325@admingilde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 30 11:12:10 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fl0Gl-00086M-SF
	for gcvg-git@gmane.org; Tue, 30 May 2006 11:12:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932199AbWE3JME (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 30 May 2006 05:12:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932200AbWE3JME
	(ORCPT <rfc822;git-outgoing>); Tue, 30 May 2006 05:12:04 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:2798 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S932199AbWE3JMD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 May 2006 05:12:03 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060530091203.WSMH554.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 30 May 2006 05:12:03 -0400
To: Martin Waitz <tali@admingilde.org>
In-Reply-To: <20060529202851.GE14325@admingilde.org> (Martin Waitz's message
	of "Mon, 29 May 2006 22:28:55 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21026>

Martin Waitz <tali@admingilde.org> writes:

> Allow to commit to another branch and creating a merge in the current branch.
>
> Sometimes it is neccessary to have some local modifications in the tree
> in order to test it and work with it.  With this patch you can have
> one working tree which combines several topic branches in order to
> develop and test your changes.  When your changes are ready, you can
> commit them to the appropriate topic branch.
>
> With the --branch option, the commit will automatically be rebased to
> that branch.  The original tree will then be commited to your working
> branch as a merge.
>
> ---
>
> Perhaps something like this can even be integrated into the extended
> branch configuration which is currently under discussion.
> It may make sense to have one branch which always contains a merge
> of a selected set of other branches and having a default branch
> for new commits.

I think this was discussed in the past and I appreciate what you
are trying to do.  My understanding of the situation your patch
is trying to improve is this:

 - you have done a few topics and you are ready to test;

 - you pulled the topics into your test branch and have found
   problems;

 - you made changes while still on the test branch (otherwise
   you wouldn't be able to test the "fix") and it seems to work
   OK;

 - what now?  

And your approach is to backport the fix to its original topic
and then re-pull the topic onto the test branch.

While I think that is _one_ valid workflow, I am not convinced
that is _the_ best workflow.  What Johannes suggested would
equally work fine, and honestly speaking probably is a better
discipline.  You carry the fix in your working tree back to its
original topic and make a commit, without pulling the topic onto
the test branch immediately.  This has two advantages:

 - With your workflow, you will have a merge commit onto the
   testing branch immediately when you commit this fix to the
   original topic.  But often when I encounter this situation,
   after moving to the topic to backport the fix to it, I find
   myself reviewing what is in the topic and making other
   changes to the topic.  Johannes's workflow feels more natural
   to me from this aspect -- I take the fix I discovered while
   on the testing branch to the relevant topic to fix it.  I may
   or may not make the commit only with that fix (the first
   commit I make after switching the branches from testing to
   the topic may contain more than that fix), and after I make
   one commit, I may keep working on the topic a bit more before
   I decide it is a good time to test the whole thing again (to
   pull the topic into testing).  I do not necessarily want that
   extra merge immediately in the test branch.

 - A topic branch should be testable alone; if the changes near
   the tip of your topic depends on other topic (or more recent
   mainline than where the topic forked), then I think you
   shouldn't hesitate to pull in the other branch into the topic
   to keep it buildable and testable.  And your commit should be
   made after testing your changes; with your workflow, you have
   only tested the change in the context of the testing branch,
   not the topic branch your "primary" commit is on, even though
   that commit will be the source of eventual graduation to the
   mainline.  With Johannes's workflow, you first carry the
   change to the topic, so you have a chance to test it before
   making the commit (if you are not disciplined, you can make
   the commit without testing after switching branches, but the
   point is it gives people an option to test things before they
   make a commit if they wanted to).
