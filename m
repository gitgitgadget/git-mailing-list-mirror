From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 07/16] git-read-tree: take --submodules option
Date: Fri, 18 May 2007 20:59:48 -0700
Message-ID: <7vd50x1n0r.fsf@assigned-by-dhcp.cox.net>
References: <11795163053812-git-send-email-skimo@liacs.nl>
	<11795163061588-git-send-email-skimo@liacs.nl>
	<20070518215312.GB10475@steel.home>
	<20070518220826.GM942MdfPADPa@greensroom.kotnet.org>
	<20070518224209.GG10475@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: skimo@liacs.nl, git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 19 06:00:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HpG6m-0005aW-HM
	for gcvg-git@gmane.org; Sat, 19 May 2007 05:59:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755085AbXESD7v (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 May 2007 23:59:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755016AbXESD7v
	(ORCPT <rfc822;git-outgoing>); Fri, 18 May 2007 23:59:51 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:42524 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754761AbXESD7u (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 May 2007 23:59:50 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070519035951.EOLV13995.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Fri, 18 May 2007 23:59:51 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 0rzo1X00C1kojtg0000000; Fri, 18 May 2007 23:59:49 -0400
In-Reply-To: <20070518224209.GG10475@steel.home> (Alex Riesen's message of
	"Sat, 19 May 2007 00:42:09 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47708>

Alex Riesen <raa.lkml@gmail.com> writes:

> Sven Verdoolaege, Sat, May 19, 2007 00:08:26 +0200:
> ...
>> The reason for not putting this in shouldn't be that someone doesn't
>> think it is useful; the reason should be that my code is crap.
>
> The code is not a problem. It can be also discarded because you
> implemented something no one wants.

More specifically, at the very high level, what you do and what
people want to happen might share the description (e.g. "this
allows checkout of subprojects", or "this implements clone of
superproject to recurse") but with semantics that may be
different from what people would want (I am not saying that is
the case, as I do not think the current discussion concluded
yet).  The _first_ implementation that goes in the mainline
pretty much sets the _semantics_ so we would need to be extra
careful, all the more so as this is a feature many people seem
to want.

> I just meant to say, that even if no one wants your subproject cloning
> code, _I_ support your checkout effort and I am asking for it to be
> put in.
>
> "First", as the cloning discussion does not seem to be finished (and,
> as I said, I am not interested in cloning anyway).

It was partly my fault that I mentioned "clone" example in the
original message, and then let the discussion drifted to a
tangent of the clone topic, namely, how the URL would be
determined to clone the subproject from.

I would agree that checkout is a more fundamental operation, and
I wanted to make that clear in my message, but checkout and
clone has certain chicken-and-egg factor between them.  After
the clone of superproject, checking it out recursively would
need cloning the subprojects.  Also after a clone of
superproject without the recursive behaviour, when the user
explicitly asks a subproject to be checked out, somebody needs
to do a clone before the subject can be checked out.

Having said that, let's throw out an strawman for checkout
proper and then merge.

The user may or may not want to deal with subprojects, and for
something truly large like the KDE case, which is where the
superproject support is really needed, a large On/Off switch
where an option --subproject makes everything checked out and no
subproject is checked out without it is not a usable option.
I've already outlined how the .git/config file can be used to
define which subprojects are of interested so that the Porcelain
layer can decide which ones to recurse into and which ones to
leave alone.  The design is NOT the only possible/sensible one,
and I am sure other people will come up with much nicer
organization, but I would consider that is just the matter of
details.

Now, suppose "git checkout" needs to recurse into one
subdirectory that is to have a subproject.  There are three
cases:

 (1) There is no git repository yet (the plumbing layer already
     makes sure there is a directory, but does not do anything
     else).

 (2) There already is a git repository there, which is the
     correct repository (perhaps determined by .gitmodules and
     .git/config in the superproject, or presense of the commit
     that is recorded in the superproject's index).

 (3) There is a git repository but it is not the correct one.

We've discussed in the other thread about what to do in case
(1) to some degree.

For case (2), I think what should happen there is an equivalent
of this:

	$ commit=$(git-rev-parse :subproject)
        $ cd subproject
	$ git-rev-parse --verify $commit || git fetch || barf
        $ git checkout $commit

That is,

 - figure out what commit should be checked out from
   superproject index;

 - make sure the named commit exists, or fetch to make it exist.

 - go there and check out that commit; this implies two things:

   1. if there are local changes, it will be carried along and we
      checkout the named commit;

   2. the repository's HEAD becomes detached;

It is entirely possible that the repository is the _correct_ one
but not quite up to date, and you haven't fetched $commit.  This
is really a variant of (1) -- before being able to check out,
somebody has to clone the subproject.  Before being able to
check out to update the latest, somebody has to fetch in the
subproject.

If there are local changes, we would not at least lose them.  If
you want to get to a clean slate, you can cd there and perform
"git reset --hard".  If you want to mark that commit in the
subproject, you may want to do "git checkout -b branch" after
the recursive checkout from the superproject detached the HEAD
to the commit.

There is another variant that has already been suggested.  The
superproject tree and index could record 0{40} object name for
the subproject, and say "whatever commit happens to be at the
tip of the branch of subproject" (and most likely that URL and
branch information would come from .gitmodules and confirmed in
the .git/config file).  In such a case, the above outline would
be adjusted _BUT_ I think what would be checked out will not be
the named branch (e.g. refs/heads/master) itself, but the remote
branch that tracks it (e.g. refs/remotes/origin/master).

While I am at it, let me think aloud as to what I _think_ should
happen in a superproject merge.

 - Carry out the tree-level 3-way merge.  If it trivially
   resolves at the tree-level, we are happy.

 - There could be a case where the commit fetched/merged branch
   has and what the current branch has are different.  If one is
   a fast forward of the other, take it.

 - All other cases will leave the superproject index unmerged.

When the merge is cleanly done, the resulting commit is what we
should check out in the subproject directory (if we are
recursing into it, of course).

It is likely that in some cases you would want go to the
subproject directory and merge the commits at the subproject
from our branch and their branch in the superproject's index,
and make the resulting commit as the result of the merge for
that subproject path in the superproject, but I do not think it
is the only valid solution.
