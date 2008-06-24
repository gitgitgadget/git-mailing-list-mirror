From: Jeff King <peff@peff.net>
Subject: Re: why is git destructive by default? (i suggest it not be!)
Date: Tue, 24 Jun 2008 03:24:55 -0400
Message-ID: <20080624072455.GF19224@sigill.intra.peff.net>
References: <32541b130806232220r292d691cn5bf5f9976126aa29@mail.gmail.com> <willow-jeske-01l5izRzFEDjCdyL>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Avery Pennarun <apenwarr@gmail.com>, Nicolas Pitre <nico@cam.org>,
	git@vger.kernel.org
To: David Jeske <jeske@google.com>
X-From: git-owner@vger.kernel.org Tue Jun 24 09:26:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KB2up-0004Mm-R7
	for gcvg-git-2@gmane.org; Tue, 24 Jun 2008 09:26:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752705AbYFXHZA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2008 03:25:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751745AbYFXHZA
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 03:25:00 -0400
Received: from peff.net ([208.65.91.99]:4268 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752526AbYFXHY7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2008 03:24:59 -0400
Received: (qmail 636 invoked by uid 111); 24 Jun 2008 07:24:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Tue, 24 Jun 2008 03:24:56 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 24 Jun 2008 03:24:55 -0400
Content-Disposition: inline
In-Reply-To: <willow-jeske-01l5izRzFEDjCdyL>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86001>

On Tue, Jun 24, 2008 at 06:35:16AM -0000, David Jeske wrote:

> If branches are "temporary tags" how do I see the actual code they had
> working in their branch before they merged it?

You look at the shape of the history. But if it is really an important
event for you to say "this was the state right before some merge of
interest", then by all means, tag it with a real tag. Or don't delete
the branch.

Have you tried running gitk on the kernel or git repositories?

> I'm reading about rebase, and it sounds like something I would want to
> forever disallow on my git repository, because it looks like it
> rewrites history and makes it impossible to get to the state of the
> tree they actually had working before the merge. However, something
> you say below both clarifies and confuses this.

It does throw away the state before the rebase (well, there is no longer
a pointer to it; it is still recoverable via the reflog). But for most
push/pull collaboration, you probably want to be using merge. Rebase is
more useful for people who are more accustomed to a patch-based
workflow.

> > The end result is that even if you delete the source branch after
> > doing a merge, nothing is actually lost.
> 
> ..and what if you never merge? That branch-pointer points to useful
> information about a development attempt, but it was never merged.
> (imagine a different development path was taken) They never created a
> tag because it's not clear when that work was "done" (unlike a
> release, which is much more well understood). What prevents someone
> from deleting the branch-pointer or moving it to a different part of
> the tree, causing that set of changes to be a dangling ref lost in a
> sea of refs. Later when someone goes back looking for it, how would
> they ever find it in a sea of tens of thousands of checkins?

If it's not merged, then don't delete the branch pointer! And "git
branch -d" will even refuse to do the deletion, unless you force it with
"git branch -D".

And keep in mind that when you clone repos, you clone the branch
pointer. So if you have a centralized server that your developers push
and pull from, a stray "git branch -D" from one developer _doesn't_ ruin
it for the rest of them. All that does is delete the branch from their
local repo, but it still exists in the central repo and for all of the
other developers. But it's not clear to me what sort of developer
topology you're interested in.

> Before I set the GC times to "100 years", there was a HUGE reason for git to
> make those branch-pointers impossible to lose, because by default if you lose
> them git actually garbage collects them and throws the diffs away after 90
> days!

I think most people are comfortable with "if I have an unmerged branch,
it stays forever. If I accidentally delete my branch, I have 30 days to
pull the tip out of my reflog". Sure, it's _possible_ to lose work. But
you could also accidentally "rm -rf" your .git directory. If you want an
extra layer of protection, push your work periodically to a backup repo.

> That's sort of helpful, and sort of confusing. I think of git's branches as
> "branch pointers to the head of a linked-list of states of the tree".

More or less true (they aren't linked-list, but arbitrary DAGs --
commits can have more than one parent (i.e., a merge) and can have many
children (i.e., many people build off in different directions from one
spot)).

> If I'm understanding all that right, it's exactly the kind of
> functionality I want -- the ability to reproduce the state of all
> working history, exactly as it was when the code was actually working
> in someone's client a long time ago, before they merged it to the
> mainline. Except the standard model seems to be to let the system
> "garbage collect" all that history, and toss it away as unimportant --
> and in some cases it seems to even provide developers with ways to
> more aggressively assure garbage collection makes it disappear.

I think you are confusing two aspects of history.

There is the commit DAG, which says "at some time T, the files were at
some state S, and the commit message by author A was M". And those
commits form a chain so you can see how the state of the files
progressed. And anything that is reachable through that history will
always be kept by git, and you can always go back to any point.

But we also give particular names to some points, like "this is tag
v1.0" or "this is the head of the experimental line of development". We
call those refs.  Git remembers those names until you ask it not to (by
deleting the ref).  And there is a history to those names, like
"experimental was at some commit C1. Then somebody committed and it was
at C2. And then they did a git-reset and it was at C3". And that history
is encapsulated in the reflog, and is purely local to each repository
(since git is distributed, it makes no sense to talk about "where the
experimental name pointed" without talking about a specific repo).

And the ref history is what gets garbage collected. Most people are fine
with that, because they care about the actual commit history, and the
reflog is just a convenient way of saying "oops, what was happening
yesterday?" But if you really care, then by all means, set the reflog
expiration much higher.

> Am I expecting too much out of git? It doesn't really feel like a
> source control system for an organization that wants to save
> everything, forever, even when those people and trees and home
> directories disappear. It feels like a distributed patch manager that
> is much more automatic than sending around diffs, but isn't overly
> concerned with providing access to old history. (which, duh, is no
> surprise given that's what I expect it's doing for linux kernel)

Git _will_ remember content forever, _if_ you put into git. So if you
are saying "git won't remember work that employee X did after he is
gone", that isn't true. X's work will be part of the commit DAG and will
be a part of everybody's repo. If you are saying "I blew away employee
X's home directory, and he had a git repo in it, why didn't git save
that data?" then the problem is that you deleted the repo! If you are
concerned about that situation, have employee X push his work to a repo
that doesn't get deleted.

-Peff
