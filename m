From: "George Spelvin" <linux@horizon.com>
Subject: RE: git  --  how to revert build to as-originally-cloned?
Date: 20 May 2011 12:25:02 -0400
Message-ID: <20110520162502.7854.qmail@science.horizon.com>
Cc: linux@horizon.com
To: git@vger.kernel.org, johnlumby@hotmail.com, timmazid@hotmail.com
X-From: git-owner@vger.kernel.org Fri May 20 18:25:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QNSVq-0006hx-AL
	for gcvg-git-2@lo.gmane.org; Fri, 20 May 2011 18:25:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935167Ab1ETQZH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 May 2011 12:25:07 -0400
Received: from science.horizon.com ([71.41.210.146]:28899 "HELO
	science.horizon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S934305Ab1ETQZE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 May 2011 12:25:04 -0400
Received: (qmail 7855 invoked by uid 1000); 20 May 2011 12:25:02 -0400
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174064>

Ah - I should have said that I selected only merges in my git log 
command  -
git log --merges
(With no qualifier, git log returns about 3.8 million lines /  150 MBytes,
hard to work with)

> And,  based on what the command now returns,  it seems that the first two
> that I listed before (which are no longer present) were as a result of my
> (single) merge command,  i.e. my merge resulted in merging :
>     .  two merges that were done by someone else in the master that I 
> cloned into my /b filesystem,
>      .  maybe some other non-merge commits that I did not query before 
> and now don't know

Er, no.  One "git merge" command produces (at most) one commit.
It may be that the head of the branch you merged in was already
a merge commit, but tha

You may find "gitk" useful for for visualizing all of this.


> You've lost me here.  If a merge can consist of many commits,
> including other merges (see above), then how can one commit be a merge?
> Note that in my original git log --merges output that I posted in my
> earlier post, i.e. the one before I reset, there was *no* record of *my*
> merge command itself, only of the sub-merges that my merge dragged along.
> I think this is the crucial (to me) point - git did not record what I did,
> only the effects of what I did.  Not saying this is wrong or right,
> but significant.

Okay, here's the basic confusion.  Commits have pointers to other commits,
and are organized into a linked list.  (Actually, a directed acyclic graph,
since a commit can have more than one ancestor pointer.)
Thus, a commit identifies *both* a single snapshot *and* a complete
development history.  We tend to talk about a "commit" when describing
the former, and "branch" when talking about the latter, but they're
actually the same object.

A merge *is* exactly one commit.  A "merge commit" is just a commit with
more than one ancestor.  Now, that merge can *point to* lots of other
commits, but it doesn't exactly "consist of" them.

The other thing is that the ancestors of a merge are symmetrical.
They are numbered for reference, but the practical results of "merge
A with B" and "merge B with A" are identical.  Every commit points
to the full development history that produced it.


Now, what might have happened to you was a "fast forward" merge.
If you have a history like this:

o--o--o--a--b--c--d

And you ask git to merge a and d together, the result will be simply d.
Git, by default, avoids creating useless merges in such a case.  So if
you merge in someone else's work, and you haven't done anything locally
since their branch split off from your HEAD, the result will not include
a merge commit at all.  (A NEW merge commit; they branch might include
merge commits.)

Since the top merges in your example are by Dave Miller (and not by you),
it looks like that's what happened in this case.
