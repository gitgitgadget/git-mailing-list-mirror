From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Odd merge behaviour involving reverts
Date: Thu, 18 Dec 2008 20:01:48 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0812181949450.14014@localhost.localdomain>
References: <alpine.LFD.2.00.0812181534310.14014@localhost.localdomain> <1229642734.5770.25.camel@rotwang.fnordora.org> <20081219124452.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Alan <alan@clueserver.org>, git@vger.kernel.org
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Fri Dec 19 05:03:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LDWaO-0003oR-B0
	for gcvg-git-2@gmane.org; Fri, 19 Dec 2008 05:03:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752224AbYLSECQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Dec 2008 23:02:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752047AbYLSECQ
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Dec 2008 23:02:16 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:48297 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751412AbYLSECP (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 18 Dec 2008 23:02:15 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id mBJ41nGe013791
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 18 Dec 2008 20:01:50 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id mBJ41mal009176;
	Thu, 18 Dec 2008 20:01:48 -0800
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <20081219124452.6117@nanako3.lavabit.com>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
X-Spam-Status: No, hits=-3.423 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103541>



On Fri, 19 Dec 2008, Nanako Shiraishi wrote:
> 
> If you revert the revert on the branch before merging, doesn't it mean 
> that you will be merging what the older version of the branch did (that 
> is in the revert of the revert as a single huge patch) and what the 
> updated version of the branch wants to do?  Wouldn't that lead to a mess 
> with huge conflicts?

Actually, the reverse is likely true. If the branch you are merging is 
actually doing something branch-specific - ie it's a "topic branch", then 
it's likely that the new stuff that is on that branch depends on the 
previous stuff on the branch.

And thats' the thing that got reverted - so with just a revert, it's quite 
likely that you'll get conflicts. But if you revert the revert, now the 
new stuff you're merging actually makes more sense, and is less likely to 
conflict.

Another way of looking at it is that a merge is something that can be done 
both ways: think of the _other_ branch merging yours. The original revert 
ends up being a big change-patch that undoes everything that other branch 
did, so now if that other branch were to merge the main branch, you'd be 
merging a lot of changes. But reverting the revert will undo all those 
changes, so again, it's more likely that the merge will succeed.

So revertign a revert is usually going to make subsequent merges easier 
rather than the reverse. 

The _big_ problem with reverting a whole merge is that it effectively 
becomes one commit that does a big change. That's how _normal_ merges tend 
to look like in CVS or SVN (ie the "merge" is really just another commit 
that brings in a lot of changes), and it's a total and utter f*cking 
disaster!

But don't get me wrong - it's not something you can't work with. I'm just 
trying to say that it's absolutely not a "good model". It's workable, but 
it has all these painful issues.

For example, think about what reverting a merge (and then reverting the 
revert) does to bisectability. Ignore the fact that the revert of a revert 
is undoing it - just think of it as a "single commit that does a lot". 
Because that is what it does.

When you have a problem you are chasing down, and you hit a "revert this 
merge", what you're hitting is essentially a single commit that contains 
all the changes (but obviously in reverse) of all the commits that got 
merged. So it's debugging hell, because now you don't have lots of small 
changes that you can try to pinpoint which _part_ of it changes.

But does it all work? Sure it does. You can revert a merge, and from a 
purely technical angle, git did it very naturally and had no real 
troubles. It just considered it a change from "state before merge" to 
"state after merge", and that was it. Nothing complicated, nothing odd, 
nothing really dangerous. Git will do it without even thinking about it.

So from a technical angle, there's nothing wrong with reverting a merge, 
but from a workflow angle it's something that you generally should try to 
avoid. 

If at all possible, for example, if you find a problem that got merged 
into the main tree, rather than revert the merge, try _really_ hard to 
bisect the problem down into the branch you merged, and just fix it, or 
try to revert the individual commit that caused it.

Yes, it's more complex, and no, it's not always going to work (sometimes 
the answer is: "oops, I really shouldn't have merged it, because it wasn't 
ready yet, and I really need to undo _all_ of the merge"). So then you 
really should revert the merge, but when you want to re-do the merge, you 
now need to do it by reverting the revert.

		Linus
