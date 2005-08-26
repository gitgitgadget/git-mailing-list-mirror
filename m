From: Fredrik Kuivinen <freku045@student.liu.se>
Subject: Re: [RFC, PATCH] A new merge algorithm (EXPERIMENTAL)
Date: Fri, 26 Aug 2005 23:39:00 +0200
Message-ID: <20050826213900.GA18880@c165.ib.student.liu.se>
References: <20050826184731.GA13629@c165.ib.student.liu.se> <Pine.LNX.4.63.0508261558550.23242@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 26 23:40:22 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E8luy-0002zO-FH
	for gcvg-git@gmane.org; Fri, 26 Aug 2005 23:39:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030245AbVHZVjP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 26 Aug 2005 17:39:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965173AbVHZVjP
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Aug 2005 17:39:15 -0400
Received: from [85.8.31.11] ([85.8.31.11]:33197 "EHLO mail6.wasadata.com")
	by vger.kernel.org with ESMTP id S965172AbVHZVjO (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 26 Aug 2005 17:39:14 -0400
Received: from c165 (unknown [85.8.2.189])
	by mail6.wasadata.com (Postfix) with ESMTP
	id BBBA440FD; Fri, 26 Aug 2005 23:43:02 +0200 (CEST)
Received: from ksorim by c165 with local (Exim 3.36 #1 (Debian))
	id 1E8lue-00059o-00; Fri, 26 Aug 2005 23:39:00 +0200
To: Daniel Barkalow <barkalow@iabervon.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0508261558550.23242@iabervon.org>
User-Agent: Mutt/1.5.6+20040907i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7825>

On Fri, Aug 26, 2005 at 04:48:32PM -0400, Daniel Barkalow wrote:
> On Fri, 26 Aug 2005, Fredrik Kuivinen wrote:
> 
> > I will try to describe how the algorithm works. The problem with the
> > usual 3-way merge algorithm is that we sometimes do not have a unique
> > common ancestor. In [1] B and C seems to be equally good. What this
> > algorithm does is to _merge_ the common ancestors, in this case B and
> > C, into a temporary tree lets call it T. It does then use this
> > temporary tree T as the common ancestor for D and E to produce the
> > final merge result. In the case described in [1] this will work out
> > fine and we get a clean merge with the expected result.
> 
> The only problem I can see with this is that it's likely to generate
> conflicts between the shared heads, and the user is going to be confused
> trying to resolve them, because the files with the conflicts will be
> missing all of the more recent changes.

I don't actually think that conflicts between shared heads is a
problem. Given the criss-cross case (we want to merge A and B into M):

 M
 |\
 | \
 A  B
 |\/|
 |/\|
 C  D
 | /
 |/
 E

Lets assume there is a merge conflict if we try to merge C and D
(which are the two shared heads). Then both A and B must resolve this
conflict. If they have done it in the same way we wont get a merge
conflict at M, if they have resolved it differently we will get a
merge conflict. In the first case there is no merge conflict at M, in
the second case the user has to pick which one of the two different
resolutions she wants.

Note that the algorithm will happily write non-clean merge results to
the object database during the "merge shared heads" stage. Hence, when
we are merging C and D "internally" we will _not_ ask the user to
resolve any eventual merge conflicts.

> Other than that, I think it should
> give the right answer, although it will presumably involve a lot of
> ancient history doing the internal merge. (Which would probably be really
> painful if you've got two branches that cross-merge regularly and never
> actually completely sync)

The expensive part is the repeated merging. But as I wrote in my mail
multiple shared heads seems to be pretty uncommon. As far as I can
tell there is no reason for the number of shared heads to increase as
a repository grows larger. However, this do probably depend on usage
patterns.

But it is certainly possible to construct cases with an arbitrary
number of shared heads. In which case the algorithm will be a bit
slow, at least if there are real content merges going on which are
handled by merge(1).

> I'm getting pretty close to having a version of read-tree that does the
> trivial merge portion based comparing the sides against all of the shared
> heads. I think yours will be better for the cases we've identified, giving
> the correct answer for Tony's case rather than reporting a conflict, but
> it's clearly more complicated. I think my changes are worthwhile anyway,
> since they make the merging logic more central, but obviously
> insufficient.
> 
> I've been thinking that could be useful to have read-tree figure out the
> history itself, instead of being passed ancestors, in which case it could
> use your method, except more efficiently (and only look further at the
> history when needed).

It will be interesting to have a look at the code when you are done.
I find the Git architecture with respect to merging to be quite
nice. A core which handles the simple cases _fast_ and let the more
complicated cases be handled by someone else.

- Fredrik
