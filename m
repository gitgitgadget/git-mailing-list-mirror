From: Junio C Hamano <junkio@cox.net>
Subject: Re: More gitweb queries..
Date: Mon, 30 May 2005 10:54:59 -0700
Message-ID: <7v3bs438gc.fsf@assigned-by-dhcp.cox.net>
References: <20050529231053.GD12290@cip.informatik.uni-erlangen.de>
	<20050529231621.GE12290@cip.informatik.uni-erlangen.de>
	<20050529234606.GF12290@cip.informatik.uni-erlangen.de>
	<20050529235630.GG12290@cip.informatik.uni-erlangen.de>
	<7vsm05bkps.fsf@assigned-by-dhcp.cox.net>
	<20050530013056.GH12290@cip.informatik.uni-erlangen.de>
	<7vmzqd4041.fsf@assigned-by-dhcp.cox.net>
	<20050530083653.GL12290@cip.informatik.uni-erlangen.de>
	<20050530092140.GQ12290@cip.informatik.uni-erlangen.de>
	<7vhdgl2ext.fsf@assigned-by-dhcp.cox.net>
	<20050530121100.GS12290@cip.informatik.uni-erlangen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@osdl.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon May 30 19:53:01 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DcoRT-0000BB-Fw
	for gcvg-git@gmane.org; Mon, 30 May 2005 19:52:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261657AbVE3RzP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 30 May 2005 13:55:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261658AbVE3RzP
	(ORCPT <rfc822;git-outgoing>); Mon, 30 May 2005 13:55:15 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:24806 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S261657AbVE3RzB (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 May 2005 13:55:01 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050530175501.PLIK16890.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 30 May 2005 13:55:01 -0400
To: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>
In-Reply-To: <20050530121100.GS12290@cip.informatik.uni-erlangen.de> (Thomas
 Glanzmann's message of "Mon, 30 May 2005 14:11:00 +0200")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "TG" == Thomas Glanzmann <sithglan@stud.uni-erlangen.de> writes:

Disregard my last MB(A,A)===A thing.  I really was not thinking,
but in N-way merge I think rev-tree is your friend.  Unlike
merge-base which always does two heads at a time, rev-tree works
N-way.  You should be able to give many heads to it and have it
help you figure out the ancestory relationship across them.

TG> But I still don't know how to handle the following scenario:

TG>     /----- A
TG>    /
TG> -GCA#1---GCA#2--- B
TG>             \---- C

TG> MERGES_HEAD = (A B C). I think the best way would be introduce a
TG> temporary commit object otherwise  C into AB merge would have merge_base
TG> on the first GCA which is suboptimal and maybe wrong isn't it?

I think you can run the same algorithm for those pairwise
ancestors and favor the less common ones.  In the above drawing,
you would first find out the three common pair-wise ancestors.

In your drawing,

    GCA(A,B) = GCA#1
    GCA(B,C) = GCA#2
    GCA(C,A) = GCA#1
    GCA(GCA#1,GCA#2) = GCA#1

Then you notice that GCA#2 is less common than GCA#1 (indeed
GCA#1 is contained in GCA#2).  So favoring the GCA#2, you do the
merge pair that uses it as the merge base, namely B and C,
first.

You scan the pairwise list again and find the pair that have not
merged and uses the least common GCA as merge base and keep
going.  For the definition of less common, in many cases those
GCA#n would not be related at all and cannot be compared by
topology only, so you would probably need to come up with a
heuristics to break such ties.  Off the top of my head, you
could compare commit timestamps (prefer younger), sum of commit
chain length from GCA#n to its two head pairs (prefer shorter),
sum of number of changed files from GCA#n to its two head pairs
(prefer smaller).

TG>     /----- A -------D---E
TG>    /               /   /
TG> -GCA------GCA---- B   /
TG>             \------- C

TG> Where D is a temporary COMMIT obeject to use the second GCA to merge C
TG> with D and gets E.

Yes, if you ended up merging A and B first you would have
something like that.  I think you should not do that in the
first place, and try to merge the "most recently diverged" pair
first, like this:

         /----- A -----------Y
        /                   / 
     -GCA#1---GCA#2--- B --X
                 \---- C -/

If we are still talking about Octopus (Tripus in this case), you
would not want to actually make a commit X.  When you merge B
and C, you consider that such a resulting tree resides at GCA#2
(merge base of B and C) for the purposes of further merge
computation.  Then you merge that resulting tree with A, using
GCA#1.

