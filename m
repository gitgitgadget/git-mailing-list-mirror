From: Yann Dirson <ydirson@altern.org>
Subject: Re: [RFC] Applying a graft to a tree and "rippling" the changes through
Date: Sat, 19 Nov 2005 18:09:29 +0100
Message-ID: <20051119170929.GF3393@nowhere.earth>
References: <20051117230723.GD26122@nowhere.earth> <Pine.LNX.4.63.0511180026080.18775@wbgn013.biozentrum.uni-wuerzburg.de> <20051119140404.GD3393@nowhere.earth> <20051119141341.GE3393@nowhere.earth> <Pine.LNX.4.63.0511191612350.4895@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ryan Anderson <ryan@michonline.com>
X-From: git-owner@vger.kernel.org Sat Nov 19 18:10:02 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EdWCL-0003Yr-VG
	for gcvg-git@gmane.org; Sat, 19 Nov 2005 18:08:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750713AbVKSRID (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 19 Nov 2005 12:08:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750714AbVKSRID
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Nov 2005 12:08:03 -0500
Received: from smtp5-g19.free.fr ([212.27.42.35]:45277 "EHLO smtp5-g19.free.fr")
	by vger.kernel.org with ESMTP id S1750713AbVKSRIC (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 19 Nov 2005 12:08:02 -0500
Received: from nan92-1-81-57-214-146 (nan92-1-81-57-214-146.fbx.proxad.net [81.57.214.146])
	by smtp5-g19.free.fr (Postfix) with ESMTP id CF46F96BF;
	Sat, 19 Nov 2005 18:08:00 +0100 (CET)
Received: from dwitch by nan92-1-81-57-214-146 with local (Exim 4.54)
	id 1EdWDR-0007Ho-TT; Sat, 19 Nov 2005 18:09:29 +0100
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0511191612350.4895@wbgn013.biozentrum.uni-wuerzburg.de>
User-Agent: Mutt/1.5.11
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12343>

Hi,

On Sat, Nov 19, 2005 at 04:27:12PM +0100, Johannes Schindelin wrote:
> On Sat, 19 Nov 2005, Yann Dirson wrote:
> > - 1st level describes states that existed
> > - 2nd level describes events that occured, causing the state to change
> > - 3rd level describes the succession of events
> 
> But using git's approach you have these levels. Only that you do not 
> strictly record them as such:
> 
> 	- 1st level is trees, agreed.
> 
> 	- 2nd level is inside the commits, i.e. if you look at the tree(s)
> 	  of the parent commit(s), you can extract that tree->tree change.
> 
> 	- 3rd level is not just the succession of events: commit->commit
> 	  is much stronger.

I think we do agree on this too - it's just the usual problem with
written discussions.

> By the last, I mean that in the commit, by referencing the parent(s) 
> (which itself references its parent(s)) you have the whole history. And by 
> validating the commit object by its SHA1, you have the history immutable, 
> too.

Right.  But the 2nd and 3rd levels are not currently distinct in git.
See below.


> Now, the original purpose of this thread was to discuss a way to un-graft 
> some commit objects, i.e. to re-record a history which was not recorded as 
> such.
> 
> This may be nice for completeness purposes, but it contradicts the main 
> idea behind git: You want to be certain about things. By signing off on 
> some commit (together with the meta information about its parent(s) and 
> the tree), you state that you actually placed your work on *that* 
> particular history. And if you based your work on a commit I have, I can 
> be certain that we agree.

My proposal only introduces an additional level.  You will still be
able to sign history lines, and they will still be immutable.

This proposal is only meant to add some flexibility.  With the current
model, if I take Linus' 2.6 tree, I only have the 2.6 history back to
2.6.12rc2.  I would first like to note that any signed commit in this
tree can assert nothing prior to that version: we are only able to
check part of the history.

Now let's suppose that I am interested in adding some prior history,
say 2.6.11->2.6.12rc2.  I can add the tree and commit objects for that
range, and I now want to graft to current tree.  That is, I will add a
new history line, which will have to duplicate all subsequent commits
from the current tree.  That includes for example duplicating
comments, whereas in my model they would belong to the level below,
and would not need duplicating: the new history line will just
reference the lower-level commits, which do contain
comment/date/author information.  The history-level objects will
probably just need to contain the following information:

- commit to describe
- previous history
- history commiter, which may be distinct from the commiter of the
  change
- date of the record of the history object, which will be distinct
  from the commit date, except usually for the history line on which
  the change author works

We can then note that:

- to provide the same level of information with current objects, the
commits on the new history line would have to also point to their
counterpart in the original history line, adding information that
belongs to the 4th level (how our view of history evolves with time)

- the number of history objects could be made much less than the
number of commits, by using a single one to describe the full path
between two branchpoints of that history line:

parent: xxxxxx
parent: yyyyyy
commit: zzzzzz
commit: aaaaaa
commit: bbbbbb
committer: ...
date: ...

> The proposed rewriting of the history is very lax about that:
> 
> Say, you introduce a history line, where you start with -- say -- some 
> obsolete proprietary code from some telephone company, and then change -- 
> say, by a primitive algorithm -- the code to match git-0.99.8, all the 
> time committing with some random commit message.
> 
> Then you make a graft which says git-0.99.8 was derived from that history 
> , too. Now, you ungraft the tree. It looks like other developers and I 
> signed off on working on a "derivative" of some obscure, copyrighted code.

No, the grafted commits should not be accessible from a
previously-signed history line.  The operation you describe will
produce a different history line, and I can already do the same with
git now :)

Best regards,
-- 
Yann Dirson    <ydirson@altern.org> |
Debian-related: <dirson@debian.org> |   Support Debian GNU/Linux:
                                    |  Freedom, Power, Stability, Gratis
     http://ydirson.free.fr/        | Check <http://www.debian.org/>
