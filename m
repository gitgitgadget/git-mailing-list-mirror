From: Theodore Tso <tytso@mit.edu>
Subject: Re: policy and mechanism for less-connected clients
Date: Thu, 26 Jun 2008 07:37:10 -0400
Message-ID: <20080626113710.GD8610@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: David Jeske <jeske@willowmail.com>
X-From: git-owner@vger.kernel.org Thu Jun 26 13:38:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBpo6-0005Mu-0M
	for gcvg-git-2@gmane.org; Thu, 26 Jun 2008 13:38:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754935AbYFZLhe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jun 2008 07:37:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754791AbYFZLhe
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jun 2008 07:37:34 -0400
Received: from www.church-of-our-saviour.ORG ([69.25.196.31]:41655 "EHLO
	thunker.thunk.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754625AbYFZLhc (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jun 2008 07:37:32 -0400
Received: from root (helo=closure.thunk.org)
	by thunker.thunk.org with local-esmtp   (Exim 4.50 #1 (Debian))
	id 1KBpmr-0002Dg-6W; Thu, 26 Jun 2008 07:37:13 -0400
Received: from tytso by closure.thunk.org with local (Exim 4.69)
	(envelope-from <tytso@mit.edu>)
	id 1KBpmo-0004rr-IU; Thu, 26 Jun 2008 07:37:10 -0400
Content-Disposition: inline
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@mit.edu
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86437>

On Thu, Jun 26, 2008 at 06:08:55AM -0000, David Jeske wrote:
> I can be better than cvs with the EXACT same workflow, by checking in their
> local changes (git checkin;) and then doing the "up" (git pull;). If they
> decide they botched their merge, they can get back to where they were before
> the UP because I'm using a richer underlying mechanism to implement their
> workflow.

This is a really good example of the problems involved.  One of the
major problems with CVS is that CVS developers have a tendency to use
"cvs up" *way* too often --- i.e., with a dirty tree.  Why do they
have a dirty tree?  Well, generally because they commit too rarely;
since CVS branches are so awful to use, they generally don't use CVS
branches, and so if they are in the middle of making major changes the
source base, they may not do a CVS checkin for weeks or months, since
they don't want to break the centrally visible branch until their
project actuall is at a stage where it can be checked into the tree
without breaking core functionality.

(I once supervised a programmer who didn't do a CVS checkin for two
months, and then lost two months of work when his local disk died, and
as a result he had a nervous breakdown; you just can't make up some of
the massive, major problems that can result from CVS-inspired
workflows.)

So if you are going to accomodate the broken workflow where people
leave dirty state in their local tree for vast amounts of time, and
thus insist on running "cvs up" all the time, and will try to cover
for it by committing their work under their noses when they do the
equivalent of "cvs up" in a dirty worktree --- what does that mean?
Well, maybe you can make it work, but it breaks other nice features of
git.  For example, it means that "git bisect" can't possibly work,
since there will be huge number of commits where the tree may not even
build!

Accomodating the CVS workflow is basically about the fact that users
don't want to learn about CVS branches, because they were horrible to
use, and even worse to merge.  But that's not true with git branches;
so maybe it's better to teach them how to use git branches instead,
instead of trying to coddle them into letting them use the the same
old broken CVS workflow that was based on branch-avoidance?

I've created and taught a Usenix tutorial which covers the basics of
distributed source code management systems, including branches,
repositories, pushing and pulling between them, for git, hg, AND bzr,
and I did it in half a day.  The concepts really aren't hard.  The
main problem with git is that because the UI grew organically, there
are all sorts of exceptions and non-linearities in its CLI.  

For example, the fact that "git checkout" can be used both to switch
between branches, and revert and editing file.  Or the fact that how
you specify a set of revisions in git-format-patch is different in
terms of what happens when you specify a single commit; it's
documented in the man page now, at least, and people who teach git
after a while learn about the things that you have to teach newbies
that git experts take for granted.  (Just as people who teach English
as a second language learn about all of the exceptions to the language
that you have to point out that are second nature to the natives.)
But really, git *isn't* that hard, once you get past the somewhat
awkard CLI.  (It's no worse, and probably much better, than the Unix
shell/test/awk/sed/head/tail/sort/uniq/comm, etc.  You just have to
get over the learning curve.)

> git's mechanisms are really great for making a hybrid
> central/distributed system which has the simplicity of cvs/perforce
> and several of the benefits of git. The git interface is just too
> complicated to be used for this.  Fortunately, building on git means
> that power users will still be able to use git directly and people
> can distribute the repositories as much as they want.

I'd suggest that you try using git straight for a bit longer, before
you start drawing these conclusions.  Trust me, the concepts of git
really aren't that hard to explain to people; that's not what you need
to hide from people coming from the CVS world.  The hard part is the
fact that git's UI has all sorts of non-linearities and that git's
documentation and introductory tutorials are not as good as it should
be.  (Although it's gotten a LOT better than just a year or two ago.)

Also, if your program when used by CVS refugees to causes the git
repository to be peppered with trash commits which don't build, even
if power users are using git directly, their ability to browse the
repository using "git log" or "gitk", or to try to find problems using
"git bisect", will be horribly, negatively affected.  So I am a bit
worried that the result will end up destroying value for the project
in the long-term, and that the costs will not be matched by the
benefits of simply teaching the CVS refugees a few bits of git and
DSCM core concepts, which I've found is *not* the hard parts of
getting newbies to use git.

> Good question. I'm working on a command-line wrapper for git that does it.
> Digging into the "plumbling" is making it more obvious why I find git's
> porcelain operations hard to understand.

Exactly.  So what I would ask you to consider is that you may find it
personally useful to design this system, but afterwards, before you
inflict it on projects, and deal with some of the attendent side
effects (like all of these trash commits causing "git bisect" to go
down the drain), that you consider whether *now* that you understand
how git works and why it does some of the things it does, and what the
shortcomings of the git porcelain are from a UI perspective, whether
CVS refugees really would be best served by this system you are
designing, or whether a few wrapper scripts to hide some of the more
pointy spikes in git's CLI, plus some better tutorials, might in the
long run be much better for these CVS developers that you are trying
to serve.

						- Ted
