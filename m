From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: simple cvs-like git wrapper
Date: Wed, 30 Jan 2008 23:08:39 -0500
Message-ID: <20080131040839.GW24004@spearce.org>
References: <20080129204048.GA9612@venus> <m3hcgw8dz7.fsf@localhost.localdomain> <20080130021050.GB9612@venus> <20080130040002.GM24004@spearce.org> <20080130225254.GC9612@venus>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: "Ed S. Peschko" <esp5@pge.com>
X-From: git-owner@vger.kernel.org Thu Jan 31 05:09:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JKQjm-0003WF-PI
	for gcvg-git-2@gmane.org; Thu, 31 Jan 2008 05:09:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756199AbYAaEIq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jan 2008 23:08:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755586AbYAaEIq
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Jan 2008 23:08:46 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:48361 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754756AbYAaEIp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jan 2008 23:08:45 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JKQiz-00018E-I3; Wed, 30 Jan 2008 23:08:29 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id F22A420FBAE; Wed, 30 Jan 2008 23:08:39 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <20080130225254.GC9612@venus>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72099>

"Ed S. Peschko" <esp5@pge.com> wrote:
> On Tue, Jan 29, 2008 at 11:00:02PM -0500, Shawn O. Pearce wrote:
> 
> well, no, but I'd say 80-90% of the changes we have are ones that we
> want to instantly share with everybody. I was thinking that ones that
> we didn't would be prefixed, as in:
> 
> 	git-branch exp-<change_name>
> 
> and those would need to be renamed explicitly to become 'mainline'
> branches before they were merged..

OK, that's sensible.
 
> You've got some good points, and my original intent was to
> answer them point-by-point, but suffice to say:
> 
> 	1. I was hoping to make each branch correspond to a work request,
> 	   that would be tracked for SOX. We also need to track the changes
> 	   in mercury interactive, not git, so I've got some challenges
> 	   there in making a wrapper to handle this.

Yea, that's not a bad idea, because then if a dev wants to make
multiple small changes before saying they are finished with a
particular request they can.

I've got a script I use at final "intergration" point between
developers and the testing team that scans through all of the commit
messages for all changes since the last integration and updates
our issue database automatically to mark those items in some way.
Rather short Perl script, except for the 1300 lines of hideous C
code to speak to the vendor's tracking software.  We find it works
well to hold off on updating external non-git records until near
the very end.

You do realize that in Git once a branch has been merged you can
delete that branch, and the history of all of those changes remains?
Git itself has probably been built from thousands of individual
branches over the years, yet I'm positive Junio only has a small
handful (25-30) in his working repository that he uses to maintain
Git.  This branches are only the "live" ones that are still being
actively worked on and aren't ready for release.

Yup, there were 1,756 branches that lead up to v1.5.4-rc5:

	$ git rev-list --parents v1.5.4-rc5 \
	  | perl -ne 'print if /.* .* .*/' \
	  | wc -l
    1756

that of course was since the beginning of time.  Since v1.5.3 we
have had about 240:

	$ git rev-list --parents v1.5.3..v1.5.4-rc5 \
	  | perl -ne 'print if /.* .* .*/' \
	  | wc -l
    1756

> 	2. A single, linear history on the remote end wouldn't be easy for
> 	   reporting purposes.
>   3. A single linear history on the remote end wouldn't support 
> 	   the rare cases where I *do* want a single change.

So by this it sounds like you don't want to ever use rebase?
And instead encourage your team to always use git-merge or
git-pull (without its rebase flag).

> I guess my scheme's workability depends on how effective git is at 
> doing merges from branch to branch, and how good it is at fixing
> conflicts in a way that is simple for the user. In CVS, I get: 
> 
>     >>>>>
>     ...
>     =====
>     ...
>     <<<<<
> 
> when a conflict occurs, and you need to resolve that conflict before
> re-committing again. Does git do a similar thing?

Yes.  Git also tries harder to keep you from committing a file that
has an unresolved conflict in it.  Git's merging is a lot smarter
than CVS's ever was, as Git does automatic merge base detection
during each merge, so you don't have to keep track of this yourself.

> Also, with git-ls-remote - is there a way to see more information 
> about the remote branch rather than just its name, ie: can you say:
> 
>     git-ls-remote -l --heads origin
> 
> to get a list of changes in the order they were made? And is there a 
> command that does what I want, ie:

Nope.  To really see anything further you need access to the objects.
That means either executing a tool like git-log directly on the
server, using gitweb through your webbrowser, or fetching the
objects down to your local repository with git-fetch, where you
can then browse them with any git log viewing tool (git-log, gitk,
rev-list, etc.).

> 	git pull origin --all 
> 
> Which pulls all branches from origin and merges them into the current
> branch in an intelligent way, ie: by order in which the branches were 
> committed, or even:

Merging all branches on the remote named "origin" is simply not an
intelligent thing to do.  Nobody blindly merges everything available
from a remote, and nobody has ever asked for such a function before
in Git.  I still think its nuts, but I don't know all details of
your situation so I'll just shut up now and hope you know what you
are really asking for.
 
> 	git pull origin --re: '^(?!exp)'
> 
> which pulls in all branches matching a given regular expression (in this
> case, not matching 'exp' at the beginning..

You can do something like this, but I *really* think this is a
horribly bad idea:

	#!/bin/sh

	# Download all new branches, remove any now deleted branches.
	#
	git fetch || exit
	git remote prune origin || exit

	# Loop through all non-exp branches and merge them
	#
	for b in $(git for-each-ref --format=%(refname) refs/remotes/origin)
	do
		case $b in
		refs/remotes/origin/exp-*)
			: do not merge
			;;
		*)
			echo "==> Merging ${b##refs/remotes/origin/} ..."
			if git merge $b
			then
				: good merge
			else
				echo >&2
				echo >&2 error: Fix conflicts, commit, rerun $0
				exit 1
			fi
		esac
	done

This is going to be slow as you are running git-merge for each
and every branch available to you.  You can do a lot better by
loading the branch DAG into memory in Perl/C/Python and doing a
graph coloring algorithm to see if a merge is necessary or not,
as if you are merging everything all of the time almost everything
is going to be always merged to everything else.  Which as I said
earlier is nuts.

-- 
Shawn.
