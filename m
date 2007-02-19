From: Yann Dirson <ydirson@altern.org>
Subject: Re: StGIT discards local commits on "stg pull"
Date: Mon, 19 Feb 2007 21:47:23 +0100
Message-ID: <20070219204723.GA4314@nan92-1-81-57-214-146.fbx.proxad.net>
References: <20070212022625.rvyyo0kc0wowgogc@webmail.spamcop.net> <b0943d9e0702120131r528fb29ete143b8ce5a0a99e9@mail.gmail.com> <1171326011.2326.30.camel@dv> <b0943d9e0702131448x360018b3w6d1790a84f201710@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pavel Roskin <proski@gnu.org>, git@vger.kernel.org
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 20 01:26:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HJIpv-0006Cb-Tq
	for gcvg-git@gmane.org; Tue, 20 Feb 2007 01:26:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965698AbXBTAYA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Feb 2007 19:24:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965660AbXBTAT6
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Feb 2007 19:19:58 -0500
Received: from smtp8-g19.free.fr ([212.27.42.65]:42671 "EHLO smtp8-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965615AbXBTASU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Feb 2007 19:18:20 -0500
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp8-g19.free.fr (Postfix) with ESMTP id 9BAD61554A;
	Mon, 19 Feb 2007 22:19:43 +0100 (CET)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000)
	id 8CA931F084; Mon, 19 Feb 2007 21:47:23 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <b0943d9e0702131448x360018b3w6d1790a84f201710@mail.gmail.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40173>

On Tue, Feb 13, 2007 at 10:48:11PM +0000, Catalin Marinas wrote:
> On 13/02/07, Pavel Roskin <proski@gnu.org> wrote:
> >On Mon, 2007-02-12 at 09:31 +0000, Catalin Marinas wrote:
> >> On 12/02/07, Pavel Roskin <proski@gnu.org> wrote:
> >
> >> > The example below shows that git-pull keeps my commit, but "stg pull"
> >> > discards it by rebasing back to the remote ID.
> >>
> >> I think this is a "feature" but we should've probably leave the
> >> original behaviour as the default. Maybe we should also have this
> >> per-branch rather than per-repository.
> >
> >I don't know the original motivation behind effectively reimplementing
> >"git pull" in StGIT, but it's clear that the StGIT's own implementation
> >needs some polish.

The primary motivation was to allow some sort of distributed handling
of a stack.  That is, I publish an stgit-managed branch, you "stg
clone" it, you create your own patches on top of that, and when I
refresh my stack, you can just "stg pull" it as you would do if my
published work was a standard non-rewinding git branch.


> >I think it's always wrong to lose local commits.  I think StGIT should
> >refuse to rebase if a merge would be needed

Right, we should make it so losing local commits cannot be done by
error.  However, we cannot rely on the branch topology at the time
we're rebasing.  Consider those 2 use cases:

- my stack forks off a non-rewinding branch, and I "stg commit" part
of it, then "stg pull"

- my stack forks off a rewinding branch, and I use "git fetch" to look
at what's new upstream, then I decide it's a good time to rebase, and
run "stg pull" (or preferably "stg rebase" to avoid fetching more
recent commits by error)

In the 2 cases "git pull" would do a merge.  One crucial thing
distinguishes the 2 cases, is that in the 1st case we have "manually"
messed with the stack base.  By "manually", I mean we changed the
stack base by other means than pulling/rebasing, but this notion
possibly needs some tuning.  "stg commit" is an example, "stg
uncommit" is another, and both would cause "git pull" to do a merge
*because rebasing would not be what you want*, whereas in the
rewinding-branch use-case *what you is precisely rebasing*.

What we could do then, is having "rebase" and "pull" record an
orig-base ref as a "backup copy" of the the new base, and first refuse
to do the job (unless --force'd) if the base does not match its backup
(that is, if the user used "commit" or "uncommit").

> >or the rebase would go back in history (in other words, if
> >git-pull would not go to the remote revision).

I'm less sure about the use-case you're trying to address here.  Could
you please give more details ?  The only case I can think of would be
that of a rewinding branch that would have been just that, rewinded,
so it should be handled differently than when any new commit would
exist on top of this ancestor commit.


> >If we look at it from the user standpoint, the branches could be
> >distinguished by the use model:
> >
> >1) Tracking branch: pull is OK, commit is not OK, push is not OK.  All
> >development is done in StGIT patches and sent to others.
> >
> >2) Development branch: commit is OK, push is OK, pull is OK but no
> >merges by default.

Right, those ones are probably the most used.

> >3) Merge branch: pull is OK, even with automatic merge, commit is OK,
> >merge is OK.

This one I'm not sure to understand well.  Could you please describe
it in more details, perhaps in terms of the relation with other repos,
and of the most distinctive local operations ?

> I probably have another situation - a branch managed partially with
> StGIT but GIT commits (or 'stg commit') used and pulling would lead to
> a merge of the base, followed by patch pushing. This would work if we
> use git-pull rather than git-fetch.

You mean, a branch to which possibly several devs would commit (or to
which you want to commit multiple topic branches yourself), and where
you want to keep track of merges between these branches (as opposed to
rebasing), while still using stgit locally ?


> >> The solution would be to define the following in your gitconfig file
> >> (either ~/.gitconfig or .git/config; a full example in StGIT's
> >> examples/gitconfig):
> >>
> >> [stgit]
> >>       pullcmd = git-pull
> >>       pull-does-rebase = no
> >>
> >> The last line would tell StGIT not to do the rebasing and let git-pull
> >> handle it.
> >
> >It's actually my deliberate choice to subject myself to the pains of the
> >default configuration.  I don't want to live in backwards compatible
> >environment until it rots away.  I'll rather eat the dogfood we are
> >offering to others :)
> 
> I don't consider this as a backward-compatibility feature. It simply
> targets a different workflow and it would be even better if we have it
> per-branch. The default should be the current fetch+rebase (as the
> most common case would be to use StGIT commands only) but with a
> warning if stack base fast-forwarding is not possible.

One way to handle different workflows could be to define a particular
workflow with a set of settings such as pullcmd and pull-does-rebase.
That way, we could say eg. "stg branch --workflow=<id>" to set the
vars in one run.

Best regards,
-- 
Yann.
