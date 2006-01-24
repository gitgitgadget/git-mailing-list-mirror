From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Notes on Subproject Support
Date: Mon, 23 Jan 2006 23:22:41 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0601232220570.25300@iabervon.org>
References: <7v3bjfafql.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0601222104120.25300@iabervon.org> <7v7j8r7e7s.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0601231116550.25300@iabervon.org> <7vek2yxukm.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 24 05:20:56 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F1Ffr-00017Y-KS
	for gcvg-git@gmane.org; Tue, 24 Jan 2006 05:20:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932318AbWAXEUi (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Jan 2006 23:20:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932435AbWAXEUi
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jan 2006 23:20:38 -0500
Received: from iabervon.org ([66.92.72.58]:5645 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S932318AbWAXEUi (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Jan 2006 23:20:38 -0500
Received: (qmail 2601 invoked by uid 1000); 23 Jan 2006 23:22:41 -0500
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 23 Jan 2006 23:22:41 -0500
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vek2yxukm.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15093>

On Mon, 23 Jan 2006, Junio C Hamano wrote:

> Daniel Barkalow <barkalow@iabervon.org> writes:
> 
> > I think it would be a lot more fragile if switching branches requires 
> > multiple programs interacting with the index file. If things get 
> > interrupted after the tree is read but before the bindings are changed, 
> > the user will probably generate an inconsistant commit or have to deal 
> > with figuring out what's going on. It is a nice property of the current 
> > system that the index file never exists under the usual filename without 
> > being consistant.
> 
> That is certainly an issue, which we have had already for quite
> some time, I am afraid.  We can get interrupted during "switch
> branches" flow after read-tree -u -m but before updating HEAD.
> We can also get interrupted during "commit" flow after writing
> the commit object out before updating the ref pointed at by
> HEAD.  No?

The switch branches one is accurate, but I think that, if we get 
interrupted before updating the ref, the index will still be the same, and 
we'll just have a dangling object (which, if we commit the same thing 
again, will be the same object we generate).

I suppose the existing branch switching isn't much less bad than the new 
one would be, though. I sort of worry that rewriting the index file is 
more likely to be interrupted than updating a ref, but that's probably not 
really a significant difference.

> If we are truly serious about solving the issue of getting
> interrupted in the middle, I suspect we have to take the "index
> is a staging area for the next commit" approach I digressed into
> last night.  It would involve introducing a git-atomic-checkout
> command to replace the current "git-rev-parse, git-read-tree,
> then git-symbolic-ref" sequence in the checkout flow. 

Well, if the value of HEAD were in the index file, that would be 
sufficient to prevent anything actually bad from happening in the checkout 
path; if it gets interrupted, the index file's "current commit" field 
would then not match the ref and it would be clear that the system was in 
an intermediate state. (It would appear like if you'd fetched into the 
current branch without it doing the fast-forward.)

> In the commit flow, we would need git-commit-index command to replace
> the current "git-write-tree, git-commit-tree, then
> git-update-ref" sequence.

I don't think there's an issue here, anyway.

> I am not particularly opposed to that, but I suspect it might be
> a moderate amount of work for very little gain.  Continuing with
> the digression, the updated index file may contain:
> 
>   1. list of <blob path, object name>
>   2. list of parent commit object names for the next commit
>   3. the name of the local branch to create the next commit on
>   4. for each bound path:
>      list of parent commit object names for that path.
> 
> 1. is what we have in the current (version 2) index file.
> 
> 2. contains:
>  - 0 commit in an index file before the initial commit
>  - 1 commit in an index file after a fresh checkout and records
>    the commit object name we checked out (replaces HEAD+heads/$branch)
>  - 2 commits in an index file after 3-way read-tree, or more
>    during an Octopus merge (replaces HEAD+MERGE_HEAD)
> 
> 3. may not be needed, but if we did so, it would replace HEAD.

I don't think it would be needed; it could certainly be passed in. 
Actually not having HEAD would complicate a lot of programs that use HEAD 
but don't currently read the index (and don't actually care about whether 
you have the branch that you consider current actually checked out).

> 4. is similar to 2 but for bound subprojects.  Usually we have
>    one commit per bound path to record the "bind" line commit we
>    read from the commit object after a fresh checkout.  During a
>    subproject merge, we would:
>    - start out with 1 commit read from the "bind" line;
>    - merging in another subproject commit would add that commit;
>    - when making a new subproject commit, the recorded commits
>      are used as its parents.

Right.

	-Daniel
*This .sig left intentionally blank*
