From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [RFC] Stgit - patch history / add extra parents
Date: Mon, 22 Aug 2005 18:10:02 -0400 (EDT)
Message-ID: <Pine.LNX.4.63.0508221707520.23242@iabervon.org>
References: <20050818195753.GA9066@fanta> <tnx64u2p81k.fsf@arm.com>
 <20050819194832.GA8562@fanta> <1124572356.7512.21.camel@localhost.localdomain>
 <20050821094059.GA5453@fanta>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Catalin Marinas <catalin.marinas@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Aug 23 00:07:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E7KRC-0003Rf-TW
	for gcvg-git@gmane.org; Tue, 23 Aug 2005 00:06:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750988AbVHVWGc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 22 Aug 2005 18:06:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750994AbVHVWGc
	(ORCPT <rfc822;git-outgoing>); Mon, 22 Aug 2005 18:06:32 -0400
Received: from iabervon.org ([66.92.72.58]:64772 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S1750911AbVHVWGb (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 22 Aug 2005 18:06:31 -0400
Received: (qmail 6016 invoked by uid 1000); 22 Aug 2005 18:10:02 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 22 Aug 2005 18:10:02 -0400
To: Jan Veldeman <jan.veldeman@gmail.com>
In-Reply-To: <20050821094059.GA5453@fanta>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sun, 21 Aug 2005, Jan Veldeman wrote:

> Catalin Marinas wrote:
>
> > > So for example, you only tag (freeze) the history when exporting the
> > > patches.  When an error is being reported on that version, it's easy to view
> > > it and also view the progress that was already been made on those patches.
> >
> > I agree that it is a useful feature to be able to individually tag the
> > patches. The problem is how to do this best. Your approach looks to me
> > like it's not following the GIT DAG structure recommendation. Maybe the
> > GIT designers could further comment on this but a commit object with
> > multiple parents should be a result of a merge operation. A commit with
> > a single parent should represent a transition of the tree from one state
> > to another. With the freeze command you proposed, a commit with multiple
> > parents is no longer a result of a merge operation, but just a
> > convenience for tracking the patch history with gitk.
>
> My interpretation of parents is broader than only merges, and reading the
> README file, I believe it also the intension to do so (snippet from README
> file):
>
> A "commit" object ties such directory hierarchies together into
> a DAG of revisions - each "commit" is associated with exactly one tree
> (the directory hierarchy at the time of the commit). In addition, a
> "commit" refers to one or more "parent" commit objects that describe the
> history of how we arrived at that directory hierarchy.

One factor not mentioned there is that, as things move upstream, we often
want to discard a lot of history; if someone commits constantly to deal
with editor malfunction or something, we don't really want to take all of
this junk into the project history when it is cleaned up and accepted.

So the point is that there are things which are, in fact, parents, but we
don't want to list them, because it's not desired information.

Probably the right thing is to have two views of the stack: the internal
view, showing what actually happened, and the external view, showing what
would have happened if the developers had done everything right the first
time. When you make changes to the series, this adds to the internal view
and entirely replaces the external view.

I think that users will also want to discard the commits from the stack
before rebasing in favor of the commits after, because (a) rebasing isn't
all that interesting, especially if there's minimal merging, and (b)
otherwise you'd get a ton of boring commits that obscure the interesting
ones.

I think that the best rule would be that, when you modify a patch, the
previous version is the new version's parent, and when you rebase a
series, you include as a parent any parent of the input that isn't also in
the input (but never include the input itself as a parent of the output;
the point of rebasing is to pretend that it was the newer mainline that
you modified). This should mean that the internal history of a patch
consists of the present version, based on each version that was replaced
due to changing the patch rather than rebasing it.

Of course, there's an interesting situation with the commits earlier in a
series from a patch that was changed not being ancestors of the newer
versions of those patches (because they weren't interesting in the
development of those patches) but accessible as the commits that an
interesting patch was based on.

A possible solution is just to consider the revision of any patch a
significant event in the history of the whole stack, causing all of the
patches to get a new retained version.

	-Daniel
*This .sig left intentionally blank*
