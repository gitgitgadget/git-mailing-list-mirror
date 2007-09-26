From: Jeff King <peff@peff.net>
Subject: Re: Workflow question
Date: Tue, 25 Sep 2007 20:47:34 -0400
Message-ID: <20070926004734.GA22617@segfault.peff.net>
References: <46F93A99.5080707@gmail.com> <46F95CCC.4080209@op5.se> <46F96493.8000607@gmail.com> <20070925201717.GB19549@segfault.peff.net> <46F97618.9010207@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Russ Brown <pickscrape@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 26 02:47:47 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IaL43-0006hF-Th
	for gcvg-git-2@gmane.org; Wed, 26 Sep 2007 02:47:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750887AbXIZArh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Sep 2007 20:47:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750918AbXIZArh
	(ORCPT <rfc822;git-outgoing>); Tue, 25 Sep 2007 20:47:37 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2802 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750878AbXIZArh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Sep 2007 20:47:37 -0400
Received: (qmail 22623 invoked by uid 1000); 26 Sep 2007 00:47:34 -0000
Content-Disposition: inline
In-Reply-To: <46F97618.9010207@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59202>

On Tue, Sep 25, 2007 at 03:56:56PM -0500, Russ Brown wrote:

> I keep reading things similar to this and bit by bit I'm starting to get
> it. :) I suppose this is one case in which it's definitely a
> disadvantage to have a good understanding of svn before coming to git...
> 
> <yoda>You must unlearn what you have learned</yoda>

I prefer to think of it like a war movie, where I keep having
nightmarish flashbacks to CVS.

But yes, from the outside git _looks_ a lot like other SCMs you may have
used, and so it's tempting to keep their mental models. But that can
easily end up being confusing, as you have found. Personally, I think it
pays to learn a little about what's going on under the hood, and then
all of the commands Just Make Sense.

There are several explanations floating around; this is a pretty concise
one:

  http://eagain.net/articles/git-for-computer-scientists/

> If you delete a branch that has commits on it that aren't referenced by
> any other branches, will those commits be removed by something like git
> pack or git gc?

The 'git-prune' command will do this, though it is not run as part of
git-gc unless you specify --prune.

> I suppose what has me the most confused is how a developer works with a
> remote branch: I've come to understand that a developer should never
> check out and work on a remote branch, and always create a local one and
> work on that. If he does that using the above hierarchy, there then
> becomes main->projectX->featureY->jeff_local_branch_of_featureY. Or is
> is possible for a developer to work directory on a remote branch?

As Junio noted, you can't, because they're remote. What you have in your
local repository is a remote _tracking branch_, which is a local ref
that tracks your idea of what the remote's branches are. And git will
feel free to overwrite the contents of that tracking branch whenever you
do a fetch or pull. So if you make commits on it, they are subject to
being overwritten (and we note this property of the refs by putting them
in the refs/remotes hierarchy, rather than refs/heads).

So in the case of our developer Jeff, his local repository will have a
"projectX/featureY" branch that he works on. And he will also have a
remote tracking branch "origin/projectX/featureY" which indicates where
his local repo thinks the remote repo points. And the remote repo will
have a "projectX/featureY" branch, of course.

> Ah,I see... The light is beginning to come on somewhat here, though it's
> dimmed somewhat by the remote/local branch confusion I mention above,
> which tends to imply that rebase is only really useful in local branches
> since it is always the outer-most branch (assuming that my understanding
> on that is correct, which it may well not be).

Yes, although the important distinction is not so much "this is a local
branch" but rather "this is a _published_ branch" which implies that
other people are looking at (and possibly basing work on) it.

> I actually quite like the idea of the freezing before re-basing in the
> sub-branches. However, to answer the question of which merge strategy
> would work best for us I think I need to actually set this up and have a
> play with it to see how it all pans out using the various options available.

Yes, it is easy to get into academic discussions of setups, but in
practice you need to find a workflow that is smooth for your team.

On one web-based project I work on, we have a setup like this (which is
very centralized):

  - a central repo resides on a development server with two branches,
    "master" and "production"
  - each developer clones the repo with a working tree
  - some developers develop directly on 'master' if they have small
    changes, or only work on one thing at a time; other developers use
    topic branches to work on simultaneous changes
  - any developer can push to master; it is expected that your code is
    in a reasonable state, since it will now be consumed by other
    developers. Anything that has made it into master is considered
    published and should not be rebased. It is up to developers whether
    they want to rebase their work before publishing or to simply merge.
  - some developers communicate directly with each other: "hey, check
    out branch 'foo' in my repo" or "what do you think of this patch?"
  - The live site has a repo cloned from the central repo, pointing at
    "production".
  - there is a test site with a repo cloned from the master.
    Occasionally the master branch is pulled and tested. If it passes,
    it is pushed to the "production" branch. In addition, small
    immediate fixes can go onto "production", tested, and then pushed to
    the central repo's "production"

So this is not necessarily using the distributed nature of that much,
but it allows those developers who aren't very comfortable with SCMs to
stick to a "pull, hack, push" workflow. And those who want to can do
more interesting things if it helps them.

-Peff
