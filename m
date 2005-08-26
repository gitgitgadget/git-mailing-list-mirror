From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [RFC] Looking at multiple ancestors in merge
Date: Fri, 26 Aug 2005 11:47:29 -0400 (EDT)
Message-ID: <Pine.LNX.4.63.0508261123150.23242@iabervon.org>
References: <Pine.LNX.4.63.0508242249030.23242@iabervon.org>
 <Pine.LNX.4.63.0508260108290.23242@iabervon.org> <7vwtm9f3me.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 26 17:45:29 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E8gN1-0001G6-H9
	for gcvg-git@gmane.org; Fri, 26 Aug 2005 17:43:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965084AbVHZPnx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 26 Aug 2005 11:43:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965085AbVHZPnw
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Aug 2005 11:43:52 -0400
Received: from iabervon.org ([66.92.72.58]:11792 "EHLO iabervon.org")
	by vger.kernel.org with ESMTP id S965084AbVHZPnw (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Aug 2005 11:43:52 -0400
Received: (qmail 24019 invoked by uid 1000); 26 Aug 2005 11:47:29 -0400
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 26 Aug 2005 11:47:29 -0400
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vwtm9f3me.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7814>

On Fri, 26 Aug 2005, Junio C Hamano wrote:

> Daniel Barkalow <barkalow@iabervon.org> writes:
>
> > I've started this, and have gotten as far as having read-tree accept > 3
> > trees and ignore everything but the last 3. Am I correct in assuming that
> > if I break read-tree in any way, some test will fail?
>
> If some test fails you would know you broke it, but the inverse
> is probably not always true.
>
> I think the current read-tree test suite has reasonably wide
> coverage of all the interesting cases.  But the definition of
> "interesting" was derived from the current world order (IOW, the
> test suite was designed around the way we do things right now as
> a whitebox test, not a blackbox test).  I would not be surprised
> if some of them did not catch breakage you may introduce during
> the development.

Okay; I think the only thing that I'm going to change with respect to how
it makes decisions will be with 4+ trees, and those will obviously need
new tests,

> I wonder however if extending the current way of doing things in
> the cache is the right thing.  Right now we use two bits out of
> the top four bits for recording stage, one bit for the update
> bit, so you have only one extra bit to extend the number of
> stages, which means you could hold at most 7 trees at once.
>
> You "ignore things but the last 3", so this may not be too much
> of a problem, but I am a bit puzzled what you meant by it
> though.  Are you talking about reading more than 3 trees and
> keeping only the 3 to be merged, discarding the rest, doing the
> selection per path?

For each path, I intend to look at all the entries and make trivial merge
judgements on them, but then only leave the usual stage 2 and stage 3, and
a chosen stage 1. The way I'm writing the changes is:

In the argument parsing loop, just form a list of the tree objects, and
actually read them after the whole list is ready. If there are more than
3, ignore all but the last 3. This lets you give an arbitary number of
common ancestors to read-tree, and it won't mess up, but it will only use
one of them. I've done this.

Next, scan through the tree entry lists for all the trees together, and
generate cache entries for the same path in the different trees at the
same time. I've written this, but I've got a few bugs, and the 3way merge
tests are dutifully failing.

Then, I'll do the trivial merge on tree entries rather than cache
entries.

Finally, I'll extend the trivial merge to use the extra ancestors.

Since merge(1) doesn't handle multiple common ancestors, having more than
3 stages in the cache after the trivial merge isn't going to be useful for
now.

	-Daniel
*This .sig left intentionally blank*
