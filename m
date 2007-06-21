From: Yann Dirson <ydirson@altern.org>
Subject: Re: [StGIT RFC] Changing patch@branch syntax
Date: Fri, 22 Jun 2007 01:02:07 +0200
Message-ID: <20070621230207.GD7730@nan92-1-81-57-214-146.fbx.proxad.net>
References: <20070515220310.GJ16903@nan92-1-81-57-214-146.fbx.proxad.net> <b0943d9e0705220527x5d4c3d0fw2d0d66b37aab3f97@mail.gmail.com> <20070522210020.GV19253@nan92-1-81-57-214-146.fbx.proxad.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: GIT list <git@vger.kernel.org>
To: Catalin Marinas <catalin.marinas@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jun 22 01:02:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I1Vfs-0007Aq-CR
	for gcvg-git@gmane.org; Fri, 22 Jun 2007 01:02:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752566AbXFUXCR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 21 Jun 2007 19:02:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751138AbXFUXCQ
	(ORCPT <rfc822;git-outgoing>); Thu, 21 Jun 2007 19:02:16 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:42377 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752526AbXFUXCO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 21 Jun 2007 19:02:14 -0400
Received: from gandelf.nowhere.earth (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 90D937A1C;
	Fri, 22 Jun 2007 01:02:12 +0200 (CEST)
Received: by gandelf.nowhere.earth (Postfix, from userid 1000)
	id D61F91F151; Fri, 22 Jun 2007 01:02:07 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20070522210020.GV19253@nan92-1-81-57-214-146.fbx.proxad.net>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/50658>

Working in the implementation of hydras/pools, as well as discussing
of their future, led me to the following thoughts, quite related to
how we should select a new syntax for patches.

First, as a foreword, a bit if refactoring: I think we should use some
sort of Stackable (maybe pick a better name) class as a parent for
Patch and PatchSet.  Instances of a Stackable would be candidates to
be members of a PatchSet.  That means we can have stacks within a
stack, as well as stacks members of a pool.  But we also need a syntax
to name stacks-(in-a-stack)*, and patches within them.

Second, but not least, we currently have an ambiguity in syntax: "foo"
can mean "patch foo in current branch" or "branch foo", depending on
the context, and that is *really* bad.  What's more, my former
proposal (quoted below) does not improve this issue.  And my previous
proposal, which suggested using a prefix like "/stack/patch" for a
fully qualified patch and "patch" for a relative one does not solve
that problem either, and brings the additional annoyance of
introducing a syntax that is incompatible with git-core.

So here is a new proposal, which I believe would address all current
issues, at the expense of changing stgit syntax.  The idea is to use a
single separator for all levels of Stackable objects, with an optional
"patch id" (eg. //top) at the end when meaningful.  Only names would
be possible to omit, separators would be mandatory to specify the
nesting level.  That gives a syntax of:

	[patchset]([:stackable]+(//id)?)*

Examples:

	<stack>			the named branch (git-compatible)
	<stack>:<patch>		named patch in named stack
	:<patch>		named patch in current patchset (currently just "<patch>")
	<stack>:		current (top) patch in named patchset
	<pool>:<stack>:<patch>	fully-qualified patch in a named hydra
	::			top patch of the current stack of an hydra
	:<stack>://bottom.old	previous bottom of the top patch in the named stack of current pool


How does that feel ?


On Tue, May 22, 2007 at 11:00:20PM +0200, Yann Dirson wrote:
> Following the "stg pick" example above, would we also want to allow
> picking from a remote repo ?  Then the URL fragment notation could be
> suited, and we could have something like:
> 
> 	http://full/path/to/repo#my/branch:my/patch//top
> 
> That is, a formal syntax of:
> 
> 	[[[repo#]branch:]patch][//modifier]
> 
> Going further, since specifying a repo without a branch probably has
> no meaning (unless we want to default to the HEAD branch), we could
> simplify to the following:
> 
> 	[[[repo#]branch#]patch][//modifier]
> 
> I don't think we really want to allow "repo#patch", meaning that patch
> on the current branch, as this gets easily confused by branch switching.
