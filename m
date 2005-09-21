From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Unexpected behavior in git-rev-list
Date: Wed, 21 Sep 2005 10:40:42 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0509211022180.2553@g5.osdl.org>
References: <20050918144931.GA9561@ebar091.ebar.dtu.dk>
 <Pine.LNX.4.58.0509181013250.26803@g5.osdl.org> <20050918175847.GA10427@ebar091.ebar.dtu.dk>
 <20050921164948.GB23525@ebar091.ebar.dtu.dk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 21 19:43:03 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EI8aR-0005cz-7I
	for gcvg-git@gmane.org; Wed, 21 Sep 2005 19:40:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751303AbVIURks (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Sep 2005 13:40:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751304AbVIURks
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Sep 2005 13:40:48 -0400
Received: from smtp.osdl.org ([65.172.181.4]:2439 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751303AbVIURkr (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Sep 2005 13:40:47 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j8LHehBo005415
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 21 Sep 2005 10:40:44 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j8LHeg02018062;
	Wed, 21 Sep 2005 10:40:43 -0700
To: Peter Eriksen <s022018@student.dtu.dk>
In-Reply-To: <20050921164948.GB23525@ebar091.ebar.dtu.dk>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.117 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9066>



On Wed, 21 Sep 2005, Peter Eriksen wrote:
> 
> Ok, I have a prototype.  The algorithm has three steps:
> 
> 1) traverse the commit DAG in breadth first order

The thing is, this is _expensive_.

It's very possible to cut down a lot of the costs by having logic to cut 
down the expense of looking at the whole commit dag.

In particular, almost all merges will have the same object in _one_ of the
parents as in the result. And if you just make the rule be that you only 
follow the first parent that matches the result in the merge, you'll 
almost always end up with a nice linear thing, with no need to look at 
multiple parents at all.

Of course, sometimes the merge actually _does_ merge changes from both 
(or more) sides of a commit, and then you need to follow them down and it 
gets nasty and complicated.

Anyway, I've seriously considered adding a mode to "git-rev-list" that
automatically avoids following the parents that aren't relevant for a
certain set of files.

Ie if you did

	git-rev-list rev1 rev2 ^rev3 ^rev4 .. pathname

it would only show the revisions that actually _change_ the pathname.

It's not entirely trivial. The biggest bummer is that we'd have to fake
out the parent info (ie the "parent" would have to be the previous entry
that changes it, not the real one).

I'm convinced that it's all quite possible, though, by just rewriting the
"commit->parents" list (remove parents that don't change the set of files,
and in merges where one parent has zero diffs for that set, just select
_that_ parent, and then continue to prune).

It might be best not being done by git-rev-list, but by a specialized 
program. However, the advantage of doing it in git-rev-list is that then 
things like "git log" and "gitk" would automatically take advantage of it, 
ie you could say

	gitk v2.6.12.. drivers/char/

and it would show a "cut-down" revision tree that only contained the stuff 
that changed anything in drivers/char/.

This would be (a) very useful (b) very powerful and (c) should even be
pretty efficient. Sure, systems that natively do things in a file-specific
way are still a lot more efficient on a single-file basis, but the git
architecture actually lends itself very well to the above kind of "track a
whole subdirectory" (or "track two subdirectories and one filename", or
anything like that).

And a much more efficient "annotate" would fall out automatically out of 
it (although I really think that the "gitk v2.6.12.. drivers/char/" is 
what would be a lot more useful than annotate has ever been).

We already have this in "git-whatchanged", which I personally find very 
very powerful. But we could do it even better.

		Linus
