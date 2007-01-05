From: Junio C Hamano <junkio@cox.net>
Subject: a few remaining issues...
Date: Fri, 05 Jan 2007 03:06:46 -0800
Message-ID: <7v7iw1hgvt.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-From: git-owner@vger.kernel.org Fri Jan 05 12:06:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H2muQ-0008Q6-Vp
	for gcvg-git@gmane.org; Fri, 05 Jan 2007 12:06:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161035AbXAELGs (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 5 Jan 2007 06:06:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161058AbXAELGr
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Jan 2007 06:06:47 -0500
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:50248 "EHLO
	fed1rmmtao11.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161035AbXAELGq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jan 2007 06:06:46 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.06.03 201-2131-130-104-20060516) with ESMTP
          id <20070105110646.QUFD25875.fed1rmmtao11.cox.net@fed1rmimpo02.cox.net>;
          Fri, 5 Jan 2007 06:06:46 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 7P711W00B1kojtg0000000; Fri, 05 Jan 2007 06:07:01 -0500
To: git@vger.kernel.org
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/35993>

This is not meant to be an exhaustive list, and I probably will
change my mind after I sleep on them, but before I go to bed,
here are a handful of glitches I think are worth fixing.

* Bare repository.

We have a heuristic to determine bareness and change our
behaviour (albeit slightly) based on it.  The heuristic is not
perfect, but the intent is to avoid things that are undesirable
for bare repository when we know (or guess) it is one, and allow
the repository owner to override if we guessed wrong.  Currently
the only such "undesirable thing" is the use of reflog even when
core.logallrefupdates is not set, but we have an RFC patch
floating around to forbid working-tree operations in a bare
repository to prevent accidents from happening.  I think at that
point it may be prudent to also give users a way to mark a bare
repository explicitly as such, say, with "core.bare = true".
Repository creation by init-db and clone with --bare option can
automatically set this, so adding this should not be too painful
for the users.

* Packed refs.

'git-pack-refs --all' leaves heads/ unpacked because they are
expected to change often, but it packs remotes/.  This does not
make any sense (it is another fallout from "separate remote"
layout that many people pushed, even though I was mildly against
it and mostly uninterested in it, and in the retrospect I think
they did not know about or knew but did not tell me about issues
like this, which makes me somewhat unhappy X-<).  I'd like to
change the command not to pack anything but tags/ hierarchy.
This keeps bases/ used by StGIT unpacked, which makes a lot of
sense -- the hierarchy is even more volatile than heads/.

'git-pack-refs' should default to --prune.  There is no point
not to, really.

'git-pack-refs' should probably learn how to unpack, although
there is no real need for it.

* Remote management.

I pushed out 'git-remote' in 'next' tonight, but as I said, I
think it does very limited things it should do in the current
shape.  What it involves is just scripting and requires no deep
core knowledge, so it might be a good project to enhance on for
new people.

Often people suggest "git checkout -b next origin/next" to add
branch.next.remote = origin and branch.next.merge = refs/heads/next.

I do not think it should be the default, but I do understand why
people would want this (what I mean is that I do not think -b
does not imply you would want to keep tracking and merging from
there for almost all the time -- rather I would suspect it would
be 50:50 thing), so I am not opposed to add an easy way to ask
for these two variables to be set up when the new branch is
made.  Perhaps "git checkout -B"?

* Handling paths that are unknown to the index.

I sent out patches tonight to teach "git reset <tree> -- <path>"
to restore the absense of path in the index from the tree
tonight.  There was another one recently brought up on the list:
"git commit -- <path>" for path that is no longer known to the
index.  While jumping the index is a practice I particularly do
not want to encourage by extending git to support it, we already
have support for most of the cases, so I think it makes sense to
do this for consistency.  I haven't thought about the necessary
changes yet, so people can beat me if they want to.  My vague
idea is to check HEAD to see if <path> exists and if so refrain
from complaining.

* Detached HEAD.

You've seen an experimental patch, discussion, and a few
follow-up patches, all in 'pu'.  I'm not actively looking at
this right now.

* Reflogs.

'git reflog show' needs to be done -- and preferrably in a way
that does not add too much code.

After rebasing a huge series, you need to know that N patches
were involved and have to say HEAD@{N}, instead of HEAD@{1}.
This is unfortunate --- we might want to find a way to make the
reflog's recording granularity match the user operation
granularity better.  But this is probably a fairly intrusive
change we would not want right now.

* Misconfigured "tracking branch" refspecs.

There is a special hack in git-pull that passes --update-head-ok
to git-fetch.  This is a workaround for a case where underlying
git-fetch is told to update the current branch that is also used
as a tracking branch.  This can happen either because the user
misconfigured "Pull: refs/heads/master:refs/heads/master", or
the user checked out a tracking branch to take a peek, and
forgot he was on such a branch and issued "git pull".  Both are
much less likely to happen in the separate remote layout, and I
think we should deprecate both --update-head-ok flag in
git-fetch and support for this situation in git-pull.

Instead, we should unconditionally allow fetching into the
current branch for bare repositories.

The reason we should not allow fetching into the current branch
for a repository with a working tree is that allowing so will
make the index and working tree useless.  Such a fetch updates
the value of HEAD, and after that happens the old value of HEAD
is lost and, there is no way to even run a 3-way merge between
the (old) HEAD, index and the working tree.  Even if the old
value of HEAD is kept somewhere before the fetch happens (which
is what --update-head-ok code allows git-pull to do), the
difference between old HEAD and HEAD needs to be propagated to
both index and the working tree separately, so it involves two
3-way merges, which is way complicated than it is really worth.

* Topic management.

In 'todo' branch there is a git-topic script I use to generate
the "What's cooking" messages.  Although the script in its
current form is probably too specific to my workflow (which has
one baseline with two development branches, and names topics in
certain ways -- the latter is customizable from the command
line), I think something like that may be useful for people who
need to manage multiple topic branches.
