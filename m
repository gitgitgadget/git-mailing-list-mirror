From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Revisiting metadata storage
Date: Fri, 16 Dec 2011 18:48:41 -0600
Message-ID: <20111217004841.GB5709@elie.hsd1.il.comcast.net>
References: <CAD77+gQB+0zJG62jrtPn_MwLLR7zgH=5gBtkvPxrKgiLPZsbsw@mail.gmail.com>
 <87sjkx8gll.fsf@an-dro.info.enstb.org>
 <CAD77+gR=SjU0Ne9jort91pdHDA=RjkTJUJmnqKBipqoGUmoL_A@mail.gmail.com>
 <CAE1pOi2TGWmFErcKhQu-a37JjLh22O1zFYoBaVRyfBDFjOTE9Q@mail.gmail.com>
 <20111216075251.GA4048@elie.hsd1.il.comcast.net>
 <CAE1pOi2GW=3o7QgTEcUYbjif3WokpVdgL6UdKXu9x0yKH-vrGw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Richard Hartmann <richih.mailinglist@gmail.com>,
	Ronan Keryell <Ronan.Keryell@hpc-project.com>,
	Git List <git@vger.kernel.org>,
	Martin von Zweigbergk <martin.von.zweigbergk@gmail.com>
To: Hilco Wijbenga <hilco.wijbenga@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 17 01:48:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RbiSK-0004K5-1t
	for gcvg-git-2@lo.gmane.org; Sat, 17 Dec 2011 01:48:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752727Ab1LQAsr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Dec 2011 19:48:47 -0500
Received: from mail-yw0-f46.google.com ([209.85.213.46]:65012 "EHLO
	mail-yw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751625Ab1LQAsq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Dec 2011 19:48:46 -0500
Received: by yhr47 with SMTP id 47so3288482yhr.19
        for <git@vger.kernel.org>; Fri, 16 Dec 2011 16:48:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=P6DpYlZL4JhzJ4JAvC4+cMZnF1ZQtazfgbaYbExGWkE=;
        b=v747dwIU7U6HXTej35BG0TodK4cbiZ9FXwDyHvPEhegWCHUQeNUuY8zLjE3SPwnRD1
         smKnbo8zXEHrIPbytj+QB7X8wvkpWwJjgrnz1xvu2THP4eQ0hSYATj8ez5AS8o6SGe+8
         EeRxmskQ0UcKBqppAjLi0G3B05XgSx3vr4k8U=
Received: by 10.236.116.9 with SMTP id f9mr16132888yhh.0.1324082926124;
        Fri, 16 Dec 2011 16:48:46 -0800 (PST)
Received: from elie.hsd1.il.comcast.net (c-24-1-56-9.hsd1.il.comcast.net. [24.1.56.9])
        by mx.google.com with ESMTPS id n64sm16876147yhk.4.2011.12.16.16.48.44
        (version=SSLv3 cipher=OTHER);
        Fri, 16 Dec 2011 16:48:45 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <CAE1pOi2GW=3o7QgTEcUYbjif3WokpVdgL6UdKXu9x0yKH-vrGw@mail.gmail.com>
User-Agent: Mutt/1.5.21+51 (9e756d1adb76) (2011-07-01)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187340>

(+cc: Martin, who has been doing excellent work on "git rebase", just
 in case he's curious)
Hi again,

Hilco Wijbenga wrote:

> Yes, I guess the problem is that it uses the worktree as its workspace.

That's a comfort.  Thanks for explaining.

> (I know others disagree but to me it's a bug that Git touches files
> that it doesn't actually change.)

No, I somewhat agree.  If a command is touching more files than it needs
to, then that is likely to be a bug, or at least an opportunity for
improvement.

Where we might disagree is in how many files "git rebase" needs to
touch.  So let's consider your use case.

[...]
> I usually rebase in the morning to get an up-to-date tree. Is that
> considered too often? Perhaps it's my Subversion background but I'm
> not comfortable diverging too much. Is that too paranoid? :-)
>
> So IIUC, I can do "git rebase master" even after multiple "git merge master"s?

The second question is easy --- the answer is "yes".

Your first question is more a matter of opinion.  I will just say a
little about "git rebase", to help you decide for yourself.

The original and still-primary purpose of "git rebase" is to refresh and
clean up a short patch series that is going to be submitted by email
to some project, by making the series apply to a newer basis version.
You can imitate what it does fairly simply by hand:

	# on master
	git checkout -b master-rebased new-upstream
	git cherry-pick HEAD..master; # [*]
	git branch -M master

That is, we check out the new basis version and apply any "local"
changes on top of it one at a time, using human help to resolve
conflicts as necessary.

This procedure has the nice property that it is dead simple.  It also
is easily tweaked to produce an "interactive" variant that reorders
the patches or runs other commands in between applying patches (for
example, you can ask git to run the test suite after each commit when
rebasing by adding "exec make test" after each "pick" line in the
editor shown by "git rebase -i").  And in the end you have a nice
patch series that applies without fuzz and doesn't require people
reading your patches to think about the older code base they were
originally written against.

However, rebasing has a few downsides.

The most important one is that each time you rebase, you are making
new, untested commits.  When you rebase the 300-patch series that
you have been debugging in collaboration with other people, you
can no longer say "these changes have been in use and being tested
for a few months now; chances are we have already ironed out most
of the obvious bugs".  The usual heuristic that patches towards the
beginning of the series most likely work better and are less likely to
have introduced that new crash that makes your program not work at all
no longer applies, since when you rebase, you can easily introduce
a mistake in conflict resolution.  All "local" code is new code.

In the history

  A --- o --- o --- B [upstream]
   \
    P --- Q --- R [master]

after rebasing

  A --- o --- o --- B --- P' --- Q' --- R' [master]

it is even tempting for people to not test the intermediate commits P'
and Q' before publishing their work, resulting in a history where
intermediate commits involved in telling the story do not even build.
So building and testing old versions to track down a change in
behavior (e.g., with "git bisect") becomes hard.  The history is not
actual history.

That is easy to mitigate by only rebasing your small, _private_ patch
series that is not part of meaningful history.  When asking others to
incorporate the changes into permanent history, the contributor
hopefully carefully checks over them for sanity and checks each
intermediate version before they can be applied.  And history on a
large, public scale is still stable.

For similar reasons, rebasing can make life difficult for people
trying to write patches based on your patches.  The section RECOVERING
FROM UPSTREAM REBASE in the git-rebase(1) manual page has more on
that.

If you want to incorporate changes into your branch and preserve the
history of well-tested commits (for example, if you are the upstream
maintainer, pulling in changes from other people), a command to do
this is git-merge(1).  It does not have to rewind or rewrite anything;
it just uses a 3-way merge algorithm to apply the new changes and
writes a commit indicating it has done so and with pointers to the two
parent commits so history consumers can see the full story.

Another consideration.

When using Subversion and working against the trunk, I find myself
using "svn update" every day and right before commiting.  Otherwise, I
may be forced to deal with a painful conflict resolution, or worse,
commit a change to one file that uses an API that has been removed in
another file.

However, when using git, I do not find myself needing to do that.
Instead, most work pertaining to a particular goal happens on a branch
specific to that topic, I pick one version to develop against, and I
mostly stick to it.  This way, I am not distracted by irrelevant
breakage or other changes introduced in areas orthogonal to my topic.

"But how do you make sure your changes work with the current
codebase?" you might ask.  Here:

	# on branch "topic"

	# switch to working on an anonymous branch, or rather no
	# branch at all
	git checkout --detach
	# grab latest changes to test against
	git merge origin/master
	# test!
	make test

The "git merge" step does not present me with the same conflicts it
did yesterday thanks to the "git rerere" facility (since I have
[rerere] enabled set to true).  If my topic needs some nontrivial
reconciliation with the wider changes in the project (if there is an
API change, say), I might use "git merge" when on branch topic (i.e.,
_not_ detached) to record the resolution and use the commit message to
describe what happened.  Or I might just rebase.

Because of the nature of patches applied by mail, before sending the
patches out, I either rebase one last time or very loudly mention
which old version of the codebase the patch series applies to.
Usually the former.  But this step would not be necessary if asking
people to pull from me using a protocol that transfers the actual
objects.

Hope that helps,
Jonathan

[*] Actually, "git rebase" is a little smarter than that, in that it
notices and skips patches that have already been applied in
new-upstream.  A better imitation would be to use

	git cherry-pick --cherry-pick --right-only HEAD...master

Even better is to look at git-rebase.sh to see what it actually does.
:)
