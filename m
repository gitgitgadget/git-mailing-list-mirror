From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Odd merge behaviour involving reverts
Date: Fri, 19 Dec 2008 00:24:01 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0812182353490.19665@iabervon.org>
References: <alpine.LFD.2.00.0812181534310.14014@localhost.localdomain> <1229642734.5770.25.camel@rotwang.fnordora.org> <20081219124452.6117@nanako3.lavabit.com> <alpine.LFD.2.00.0812181949450.14014@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Nanako Shiraishi <nanako3@lavabit.com>, Alan <alan@clueserver.org>,
	git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Dec 19 06:25:25 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LDXrY-0003I1-13
	for gcvg-git-2@gmane.org; Fri, 19 Dec 2008 06:25:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751139AbYLSFYG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Dec 2008 00:24:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751111AbYLSFYF
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Dec 2008 00:24:05 -0500
Received: from iabervon.org ([66.92.72.58]:41300 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751014AbYLSFYE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Dec 2008 00:24:04 -0500
Received: (qmail 6462 invoked by uid 1000); 19 Dec 2008 05:24:01 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 19 Dec 2008 05:24:01 -0000
In-Reply-To: <alpine.LFD.2.00.0812181949450.14014@localhost.localdomain>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103545>

On Thu, 18 Dec 2008, Linus Torvalds wrote:

> On Fri, 19 Dec 2008, Nanako Shiraishi wrote:
> > 
> > If you revert the revert on the branch before merging, doesn't it mean 
> > that you will be merging what the older version of the branch did (that 
> > is in the revert of the revert as a single huge patch) and what the 
> > updated version of the branch wants to do?  Wouldn't that lead to a mess 
> > with huge conflicts?
> 
> Actually, the reverse is likely true. If the branch you are merging is 
> actually doing something branch-specific - ie it's a "topic branch", then 
> it's likely that the new stuff that is on that branch depends on the 
> previous stuff on the branch.
> 
> And thats' the thing that got reverted - so with just a revert, it's quite 
> likely that you'll get conflicts. But if you revert the revert, now the 
> new stuff you're merging actually makes more sense, and is less likely to 
> conflict.
> 
> Another way of looking at it is that a merge is something that can be done 
> both ways: think of the _other_ branch merging yours. The original revert 
> ends up being a big change-patch that undoes everything that other branch 
> did, so now if that other branch were to merge the main branch, you'd be 
> merging a lot of changes. But reverting the revert will undo all those 
> changes, so again, it's more likely that the merge will succeed.
> 
> So revertign a revert is usually going to make subsequent merges easier 
> rather than the reverse. 
> 
> The _big_ problem with reverting a whole merge is that it effectively 
> becomes one commit that does a big change. That's how _normal_ merges tend 
> to look like in CVS or SVN (ie the "merge" is really just another commit 
> that brings in a lot of changes), and it's a total and utter f*cking 
> disaster!

Another option is to do the big revert on the master branch, and on the 
side branch merge the parent of the revert (normally), and then merge the 
revert but take the side branch tree.

That last merge puts the revert in the branch's history, but rejects its 
effects. Now merging the branch again will find the revert to be the 
common ancestor, and see the full change of the side branch as the 
contribution of that side. Also, blame will come down the side branch, 
ignore the merge (on the side branch, the merge contributed no content 
changes), and go into the original side branch commits.

You can also think of it as the side branch saying, "I noticed that you 
reverted my changes, but I'm keeping them anyway". When the final merge 
comes, git will see that the revert isn't new information to the side 
branch, and nullify its effect. (Of course, the side branch needs to merge 
the parent of the revert so that it isn't rejecting the other changes made 
on the main branch before the revert)

	-Daniel
*This .sig left intentionally blank*
