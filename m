From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 07/16] git-read-tree: take --submodules option
Date: Sat, 19 May 2007 00:27:57 -0400
Message-ID: <20070519042757.GD3141@spearce.org>
References: <11795163053812-git-send-email-skimo@liacs.nl> <11795163061588-git-send-email-skimo@liacs.nl> <20070518215312.GB10475@steel.home> <20070518220826.GM942MdfPADPa@greensroom.kotnet.org> <20070518224209.GG10475@steel.home> <7vd50x1n0r.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alex Riesen <raa.lkml@gmail.com>, skimo@liacs.nl,
	git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat May 19 06:28:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HpGYH-0000FR-DL
	for gcvg-git@gmane.org; Sat, 19 May 2007 06:28:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755321AbXESE2J (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 19 May 2007 00:28:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755437AbXESE2I
	(ORCPT <rfc822;git-outgoing>); Sat, 19 May 2007 00:28:08 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:57824 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755321AbXESE2H (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 May 2007 00:28:07 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HpGXw-0003X4-U6; Sat, 19 May 2007 00:28:01 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 711FF20FBAE; Sat, 19 May 2007 00:27:58 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <7vd50x1n0r.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/47711>

Junio C Hamano <junkio@cox.net> wrote:
> Now, suppose "git checkout" needs to recurse into one
> subdirectory that is to have a subproject.  There are three
> cases:

So I've implemented my own Git subproject support in a Java based
tool we use internally.  Its actually driving the Git plumbing (as
JGit isn't complete enough to do the job) but applies quite a bit
to this discussion as it is a working system that implements this
"checkout in superproject and recurse into subproject".

First I don't use the subproject support in the core plumbing,
because that came along from Linus about 2 days after I wrote
this implementation.  Our data file looks like:

	use-component: subproject1 >=df8cfac815...
	use-component: subproject2 >=af9b543820...

Or really anything that is a valid commit-ish, and often these are
actually just annotated tag names.

>  (1) There is no git repository yet (the plumbing layer already
>      makes sure there is a directory, but does not do anything
>      else).

During our build process we scan the root project's data file,
and clone by the relative URL anything we cannot find locally:

	$(git config remote.origin.url)/../component-links/subproject1.git

to get the subproject repository.  We don't require that the
subproject1 directory actually be called subproject1 in the
superproject, its just a recommendation.  That data file is also
our build-system driver and the build system driver is pretty darn
smart about guessing what is going on.  ;-)

You'll notice however that we (more or less) have a very flat
structure.  The component-links directory is really just a set of
symlinks pointing back up a level, as sometimes a component is not
stored in a repository named the component name, but the component
name matters to the build system.

>  (2) There already is a git repository there, which is the
>      correct repository (perhaps determined by .gitmodules and
>      .git/config in the superproject, or presense of the commit
>      that is recorded in the superproject's index).
> 
>  (3) There is a git repository but it is not the correct one.
> 
> For case (2), I think what should happen there is an equivalent
> of this:
> 
> 	$ commit=$(git-rev-parse :subproject)
>         $ cd subproject
> 	$ git-rev-parse --verify $commit || git fetch || barf
>         $ git checkout $commit

Yes.  Except we do a few things differently:

 - Only update the subproject if its a strict fast-forward.

 - Abort on a dirty working directory in the subproject or if a merge
 would be required to keep the current commit and the new commit.
 Yes, we don't really support going "backwards".

 - The merge aborting thing is probably wrong for some users,
 but blindly switching to the target commit feels somewhat wrong
 in our own uses.  Sometimes you need the current version of the
 subproject to help you debug an older version of the superproject,
 or sibling subproject.

 - You can't just checkout $commit if you can rev-parse it.
 You need to verify it and its entire reachable object set exists.
 See the local fetch fast-path thing you did recently in e3c6f240fd.

 - We update the user's current branch.  Because we are doing
 a strict fast-forward we're also assuming the user wants the
 current branch to stay correlated to the superproject branch.  Why?
 Most of our users keep the same branch name in all repositories.

-- 
Shawn.
