From: Junio C Hamano <junkio@cox.net>
Subject: Re: git rebase chokes on directory -> symlink -> directory
Date: Thu, 10 May 2007 23:04:05 -0700
Message-ID: <7v8xbvew16.fsf@assigned-by-dhcp.cox.net>
References: <463FCD7C.4020009@zytor.com> <20070508215009.GA2670@steel.home>
	<46413565.3090503@zytor.com>
	<81b0412b0705090050i644a18c2g12c74462ab88163a@mail.gmail.com>
	<4641FDAF.3090608@zytor.com> <20070509213902.GA2593@steel.home>
	<46424ECC.6030907@zytor.com> <7vmz0dmb2u.fsf@assigned-by-dhcp.cox.net>
	<20070510220418.GK3141@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "H. Peter Anvin" <hpa@zytor.com>, Alex Riesen <raa.lkml@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Linus Torvalds <torvalds@linux-foundation.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri May 11 08:04:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HmOEe-0004D7-M1
	for gcvg-git@gmane.org; Fri, 11 May 2007 08:04:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754888AbXEKGEJ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 11 May 2007 02:04:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754925AbXEKGEJ
	(ORCPT <rfc822;git-outgoing>); Fri, 11 May 2007 02:04:09 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:53861 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754888AbXEKGEI (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 May 2007 02:04:08 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070511060406.OMDC2758.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>;
          Fri, 11 May 2007 02:04:06 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id xi451W01E1kojtg0000000; Fri, 11 May 2007 02:04:07 -0400
In-Reply-To: <20070510220418.GK3141@spearce.org> (Shawn O. Pearce's message of
	"Thu, 10 May 2007 18:04:18 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46938>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Junio C Hamano <junkio@cox.net> wrote:
>>  * git-rebase with -m is dog slow.  There were people who
>>    advocated to make it the default, but they probably are
>>    either working in a very small project, or working on a
>>    filesystem that even git-apply is slow that the speed
>>    difference does not matter to them.
> ...
> But that's not the situation everyone else has, so its reasonable
> that -m ain't the default.  ;-)

Well, that is not the conclusion you should be drawing from
this. If rebase -m is 10x slower than without -m in cases where
the rename handling does not matter, there is something wrong.

And what is wrong in this case is that the unpack-trees tree
merging code, which is used everywhere in git to do branch
switching and merges, is way too inefficient.

When merge-recursive is instructed to merge another tree with
the current tree using an ancestor, while taking the index into
account, it basically does the three-way tree-level merge one
path at a time, even when subdirectory at quite high level
matches identically across three trees.

The situation is the same for switching branches.  If two
branches of the kernel project (22k files spread across 1300
directories) differ at a file at the toplevel (e.g. v2.6.21
which changes only Makefile), we still read the index, the
current tree, and the other branch, and match all 22k files one
by one to compute the resulting index entry, by first removing
the current index entry and then stuffing the result entry in
the index, all the while trashing the cache-tree.  Then we
recompute all 1300 tree objects and write them out, even though
we should be able to notice that none of the toplevel 17
subdirectories have changed, and all we have to do is to rehash
one blob and recompute only one tree object at the toplevel.  We
boast how lightweight git branches are and how fast switching
between two branches is, but that's a serious lie.  If done
properly, we should be able to switch branches in a time roughly
proportional to the number of paths different between the
branches.  Currently, the time is proportional to the size of
the tree, no matter how small the change between trees are.

git-apply, which is used by rebase without -m, is optimized to
make it proportional to the size of the change.  It obviously
knows to only touch the affected paths (because the patch does
not talk about unaffected paths) and leave the others intact,
but also avoids expensive tree recomputation for unaffected
directories, by properly maintaining the cache-tree data in the
index.

IIRC, Linus said unpack-trees was beyond repair several months
ago, and I tend to agree with him.  Currently the first thing
unpack-trees does is to discard cache-tree from the index,
because the code does not properly invalidate affected paths,
and it is probably way too cumbersome to add it to various
places the code modifies the index (I haven't looked at it
recently, so maybe somebody can try it and prove me wrong).

My gut feeling is that we may be better off redoing the tree
level merge infrastructure from scratch, and make a new one that
is optimized for trees with small differences.  There is a
prototype code called test-para in 'pu' that implements such a
multi-tree walk, and also we've had its precursor (by Linus)
called git-merge-tree in 'master' for quite a long time, but
unfortunately neither has recently seen any activity.
