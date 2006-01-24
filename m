From: Junio C Hamano <junkio@cox.net>
Subject: Re: Notes on Subproject Support
Date: Mon, 23 Jan 2006 17:50:49 -0800
Message-ID: <7vek2yxukm.fsf@assigned-by-dhcp.cox.net>
References: <7v3bjfafql.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0601222104120.25300@iabervon.org>
	<7v7j8r7e7s.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0601231116550.25300@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 24 02:51:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F1DKm-0002qe-FC
	for gcvg-git@gmane.org; Tue, 24 Jan 2006 02:51:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030282AbWAXBu4 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Jan 2006 20:50:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030291AbWAXBu4
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jan 2006 20:50:56 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:47043 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1030282AbWAXBu4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jan 2006 20:50:56 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060124014941.GBRL20875.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 23 Jan 2006 20:49:41 -0500
To: Daniel Barkalow <barkalow@iabervon.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15089>

Daniel Barkalow <barkalow@iabervon.org> writes:

> I think it would be a lot more fragile if switching branches requires 
> multiple programs interacting with the index file. If things get 
> interrupted after the tree is read but before the bindings are changed, 
> the user will probably generate an inconsistant commit or have to deal 
> with figuring out what's going on. It is a nice property of the current 
> system that the index file never exists under the usual filename without 
> being consistant.

That is certainly an issue, which we have had already for quite
some time, I am afraid.  We can get interrupted during "switch
branches" flow after read-tree -u -m but before updating HEAD.
We can also get interrupted during "commit" flow after writing
the commit object out before updating the ref pointed at by
HEAD.  No?

If we are truly serious about solving the issue of getting
interrupted in the middle, I suspect we have to take the "index
is a staging area for the next commit" approach I digressed into
last night.  It would involve introducing a git-atomic-checkout
command to replace the current "git-rev-parse, git-read-tree,
then git-symbolic-ref" sequence in the checkout flow.  In the
commit flow, we would need git-commit-index command to replace
the current "git-write-tree, git-commit-tree, then
git-update-ref" sequence.

I am not particularly opposed to that, but I suspect it might be
a moderate amount of work for very little gain.  Continuing with
the digression, the updated index file may contain:

  1. list of <blob path, object name>
  2. list of parent commit object names for the next commit
  3. the name of the local branch to create the next commit on
  4. for each bound path:
     list of parent commit object names for that path.

1. is what we have in the current (version 2) index file.

2. contains:
 - 0 commit in an index file before the initial commit
 - 1 commit in an index file after a fresh checkout and records
   the commit object name we checked out (replaces HEAD+heads/$branch)
 - 2 commits in an index file after 3-way read-tree, or more
   during an Octopus merge (replaces HEAD+MERGE_HEAD)

3. may not be needed, but if we did so, it would replace HEAD.

4. is similar to 2 but for bound subprojects.  Usually we have
   one commit per bound path to record the "bind" line commit we
   read from the commit object after a fresh checkout.  During a
   subproject merge, we would:
   - start out with 1 commit read from the "bind" line;
   - merging in another subproject commit would add that commit;
   - when making a new subproject commit, the recorded commits
     are used as its parents.
