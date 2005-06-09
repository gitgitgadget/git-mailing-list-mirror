From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 3/3] read-tree -m 3-way: handle more trivial merges
 internally
Date: Thu, 09 Jun 2005 13:35:06 -0700
Message-ID: <7vaclzclqd.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.58.0506081336080.2286@ppc970.osdl.org>
	<7vis0o30sc.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0506081629370.2286@ppc970.osdl.org>
	<7voeagrp11.fsf_-_@assigned-by-dhcp.cox.net>
	<7v64woroui.fsf_-_@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0506090800580.2286@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 09 22:32:33 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DgThG-0006ha-W1
	for gcvg-git@gmane.org; Thu, 09 Jun 2005 22:32:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262266AbVFIUgE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Jun 2005 16:36:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262465AbVFIUgE
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Jun 2005 16:36:04 -0400
Received: from fed1rmmtao02.cox.net ([68.230.241.37]:61433 "EHLO
	fed1rmmtao02.cox.net") by vger.kernel.org with ESMTP
	id S262266AbVFIUfL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jun 2005 16:35:11 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao02.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050609203507.WEHG22430.fed1rmmtao02.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 9 Jun 2005 16:35:07 -0400
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "LT" == Linus Torvalds <torvalds@osdl.org> writes:

LT> Namely that read-tree doesn't have a frigging clue about renames, and 
LT> shouldn't have.

LT> But a real merge program _could_ have a frigging clue, and might notice 
LT> patterns like

LT>  - file got modified in one branch, removed in the other
LT>  - a file got added in the other branch
LT>  - "Hey, that added file looks like the removed one!"
LT>  - Let's merge the modifications from the first branch into the move of 
LT>    the second branch!

LT> Now, you can (validly) argue that you could still just look at the
LT> original trees ("git-diff-tree -C $O $M") and grep for copies/movement and
LT> do it by hand _there_ instead of looking at the result of the read-tree, 
LT> and you may well be right. So again, this is not a _fundamental_ problem, 
LT> although it's a bit more fundamental than the first one. 

My knee-jerk reaction was "No, I would refuse to make that
argument, because making the merge mechanism to examine trees
itself would take us full-circle back to where we started
[*1*]".

I agree we can, as the zeroth order approximation, run two
"diff-tree -B --find-copies-harder -C" [*3*, *4*] on (O,A) and
(O,B) pairs, and compare their output to cover the rename case
[*2*] you described.  I think we also can write a simple program
that reads an unmerged index file and do the equivalent of these
two diff-tree commands.

However, what I suspect to happen in practice is that the lines
of development leading to A and B may have so much modification
to those renamed or copied files since they forked at O that we
may not recognize renames or copies as such by only looking at
(O,A) and (O,B).  In order to do a reasonable job while merging,
we may end up needing to run "diff-tree --stdin -B -C" on the
output of "rev-list O A" to fully follow the rename/copy trail
[*5*].

What all this means is that the simple three-stage information
read-tree -m gives us, which is about only three trees, might
not be enough to handle renames and copies intelligently, when
we need to deal with a pair of trees that have diverged for too
long.

Once we go down this path, arguing against making "read-tree -m"
results useless for such an intelligent merge logic (because it
forces the merge logic to look at the trees and commits
involved) ceases to make much sense, because such an intelligent
merge logic needs to look at more than three trees _anyway_.

What "read-tree -m" gives us, while being very efficient,
elegant and effective in "merge small and merge often" use
pattern we recommend, may not be so useful to implement such an
intelligent merge logic, and instead we would do better if we
did it the hard way by inspecting individual commits.  I do not
have problem with that approach.  It would be a much longer-term
project, though.

So, yes I ended up arguing that the intelligent merge logic
could and probably needs to look at the trees involved ;-).


Among the three-way cases, the only case I think that may make a
practical difference is the case #5ALT, which deals with "a file
added identically in both branches" case.  This is what happens
when a widely accepted patch has been applied independently to
both trees recently (eh, "since they forked").  New files tend
to get updated more often, and allowing the file to be locally
modified, instead of failing the merge in read-tree phase, would
help the workflow.  If the file were modified in the user's
repository, and checked in, then the current 3-way merge code
cannot help the user that much, because we would be in !O && A
&& B && A!=B situation.  I have a suspicion that we could
probably help this case by looking at not just merge base but
the edge commits as well.

I consider #14ALT an improvement, but at the same time I doubt
that particular one would make much practical difference.  It is
more or less "while we are at it" kind of change.  All others,
including the "remove" cases (I botched -u but as you point out
it is correctable), do not contribute to loosening the index
requirements, but I suspect they might help me later unify
two-way fast forward and three-way merge.  Yes, I am still
looking at "read-tree -m H I-mixed-with-H M" that emulates
"read-tree H M".


[Footnotes]

*1* Remember merge-trees Perl script, which I did before you
invented the multi-stage read-tree?  Boy it feels like it was so
distant past...

*2* A casual reader may notice that we are arguing about renames
after both of us publicly stated that "renames do not matter".
Here is a clarification.  We both consider "recording renames at
commit time" does not matter, but we do take "tracking and
handling the renames" seriously.  There is a difference.

*3* Oops.  There is not --find-copies-harder yet ;-).

*4* This would be further helped if we had a --show-rename-only
diffcore filter.  The operation is similar to the pickaxe, but
it would prune changesets down only to renames and copies.  I
actually wrote and threw away such a filter back when I was
trying to find good test cases in linux-2.6 repository.

*5* And the development line leading to A or B may not even be
linear, in which case it may be easier to first decompose the
chain between O and A into individual epochs.  Jon Seymour's
"rev-list --merge-order O A" would be very handy for this.

