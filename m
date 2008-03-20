From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [SoC RFC] libsvn-fs-git: A git backend for the subversion filesystem
Date: Thu, 20 Mar 2008 00:56:32 -0400
Message-ID: <20080320045632.GB8410@spearce.org>
References: <3e8340490803182108y40a9aec2q8e5bcb78b907bbb5@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Bryan Donlan <bdonlan@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 20 05:57:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JcCq5-0001UU-Lb
	for gcvg-git-2@gmane.org; Thu, 20 Mar 2008 05:57:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751500AbYCTE4g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 20 Mar 2008 00:56:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751437AbYCTE4g
	(ORCPT <rfc822;git-outgoing>); Thu, 20 Mar 2008 00:56:36 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:43952 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751383AbYCTE4f (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 20 Mar 2008 00:56:35 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JcCpN-0007un-Ja; Thu, 20 Mar 2008 00:56:33 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id E75D920FBAE; Thu, 20 Mar 2008 00:56:32 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <3e8340490803182108y40a9aec2q8e5bcb78b907bbb5@mail.gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77628>

Bryan Donlan <bdonlan@gmail.com> wrote:
> I'm planning to apply for the git summer of code project. My proposal
> is based on the project idea of a subversion gateway for git,
> implemented with a new subversion filesystem layer. A draft of my
> proposal follows; I'd appreciate any comments/questions on it before
> the application period proper begins.

Very cool.  Have you had a chance to look at the prototype python
implementation of an SVN server that Julian Phillips started?

  http://git.q42.co.uk/w/git_svn_server.git

I'm just curious what your take is regarding this approach.  Why
would you choose to construct libsvn-fs-git over a standalone server?
There are several advantages and drawbacks to both approaches.
I am not advocating over the other, but want to make sure you have
thought it through for yourself.
 
> I intend to support the following:
> * Full or near full (possibly forbidding modification of the toplevel
> trunk/ branches/ tags/ structure) read/write access from subversion

That's probably the only sane way to go about it; disallow read/write
on the top level, map whatever branch "HEAD" points to in Git to the
trunk/, put the other branches in branches/ and the tags under tags/.
Block everything else.

> * Support for syncing svn:executable with git file mode information
> * Representation of git merge data using svk:merge and/or svn:mergeinfo
> * Syncing .gitignore and svn:ignore data

These are gravy.  Sure they are going to be difficult to make work,
but people can limp by without them.  Most users who want an SVN
client to speak to a Git repository are trying to do so from a
platform that does not honor executable bits (hi Windows!) and
telling users to edit the funny ".gitignore" file to alter ignore
lists is something they can work around without too much trouble
if they are already able to modify and commit files.

Though their clients won't provide the proper ignore support out
of the box.  *sigh*
 
> As both subversion and git are written in C, this driver will also be in C.

I think you may have underestimated the challenges associated with
linking "libgit.a" (which is _not_ a library) with SVN.  Critical
routines within libgit that you want to be able to invoke will do
not so nice things like leak massive amounts of memory or cause
your process to terminate if the function is fed an invalid input.

Most of the C code of Git is designed for single-shot execution.
We leak memory like mad because it is more efficient to load up what
we need, exit, and let the OS just return the pages to the free pool.
Long running processes have simply not been something we do.
 
> My current plan for storing the additional information the subversion side will
> need (fileprops, revprops, copyfrom information...) is to create an additional
> branch on the git repository (possibly .git-svn or similar) to hold the
> necessary metadata. Configuration, including author maps, branch/tag maps,
> etc, would be on another branch (git-svn-config or similar).
> 
> The layout might look like this:
> 
> /tree/{trunk/,branches/,tags/} - the tree as svn currently sees it

I don't think you'd want to put a copy of the tree inside of a tree,
as this can then get out of sync with changes made directly through
git, plus you run into issues about connecting the two histories
together in a meaningful way.

I would suggest having the root directory of the SVN tree be built
on the fly based upon the list of available branches and tags in
the Git repository (aka the output of git-show-ref).

> /props/{trunk/,branches/,tags/} - file properties; props on directories will be
>   represented with a reserved filename (._GIT-SVN-DIRPROPS perhaps)
>   copyfrom information might be in /props, or in a seperate tree

How critical are file properties to an SVN client for proper
functioning?  Given the challenges already in front of you for this
project I would almost encourage you to avoid dealing with file
level properties.  Its hard enough to make something that speaks SVN
on the wire but reads/writes Git on disk, not to mention you have
to somehow "flatten" the Git DAG down into a sequential revision
namespace to make the SVN clients happy.  So deferring property
support until later may be wise.

> /revprops/NNN - revision properties for the given revision number

Ditto.  Aside from the special merge properties you mentioned,
I wonder if you can simply avoid implementing support for these
early on.

> /revmap/NNN - a reference to the commit hash in the .git-svn branch
>   corresponding to the given subversion revision number

How about using a simple flat file interface?  To initially prime
the file you can do something like:

	git rev-list --topo-order --date-order --reverse --all >.git/svn-map

and then number the revisions by the line number that they appear on.
Locating a Git SHA-1 for a specific SVN revision would be a simple
case of lseek(fd, 41 * rev, SEEK_SET).  Going the other direction
would be more of a challenge, but is still doable.

Updating the file should just require appending new commits; if
the SVN client wants a new commit you append on and return the
line number.  If Git has caused new commits not in this file you
need to rebuild the log.  This would have to be done incrementally,
to prevent changing a prior SVN revision number that clients may
already know about.
 
-- 
Shawn.
