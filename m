From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Document git-stash
Date: Sun, 01 Jul 2007 14:39:56 -0700
Message-ID: <7vps3b4xcj.fsf@assigned-by-dhcp.cox.net>
References: <20070701080757.GA6093@coredump.intra.peff.net>
	<200707010910.l619A23c027837@mi0.bluebottle.com>
	<20070701091905.GA13559@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?44GX44KJ44GE44GX44Gq44Gq44GT?= <nanako3@bluebottle.com>,
	GIT <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Jul 01 23:40:19 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I579T-0002yF-SC
	for gcvg-git@gmane.org; Sun, 01 Jul 2007 23:40:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751019AbXGAVj7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 1 Jul 2007 17:39:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750889AbXGAVj7
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Jul 2007 17:39:59 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:53043 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750738AbXGAVj6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 1 Jul 2007 17:39:58 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070701213958.OMRW1204.fed1rmmtao102.cox.net@fed1rmimpo01.cox.net>;
          Sun, 1 Jul 2007 17:39:58 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id JMfw1X00G1kojtg0000000; Sun, 01 Jul 2007 17:39:57 -0400
In-Reply-To: <20070701091905.GA13559@coredump.intra.peff.net> (Jeff King's
	message of "Sun, 1 Jul 2007 05:19:05 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51323>

Jeff King <peff@peff.net> writes:

> On Sun, Jul 01, 2007 at 06:06:29PM +0900, =E3=81=97=E3=82=89=E3=81=84=
=E3=81=97=E3=81=AA=E3=81=AA=E3=81=93 wrote:
>
>> I don't understand myself anymore, either (^_^;) I just tried to fol=
low
>> Jnio's earlier suggestion in his message.  He said this.
>
> OK, we will wait for Junio to clarify tomorrow. :)

Jeez.  I tried to stay lazy and have all the work done by
somebody else (and taking the credit at the end, as I was
mentored by you-know-who ;-), but you guys managed to suck me
into this.

There are a few issues when you replay a stash on a state that
is different from the state the stash was created on.

Stash records the then-current HEAD, index and the working tree
(I'll call them H, I and W for brevity from now on).  Ideally,
we would want to have the difference between the resulting index
and working tree to be similar to the difference between I and
W.

Replaying the stash is done on a clean working tree.  That is,
we require that at least the index and working tree match (we
could also require that the index and HEAD match, but I do not
think it changes anything in this discussion).  And we apply the
change between H and W with three-way merge.

=46or paths that are cleanly merged with this three-way merge,
merge-recursive updates the working tree and the index.  That
means if you do "git diff", you would not see the local changes
that were carried forward would not be visible, and you would
need "git diff HEAD" to view them.  I found it confusing, and
that was the suggestion I sent was about.  Nana's "3rd try", which
I applied and pushed to 'next', addresses this issue by running
"read-tree --reset $c_tree" (where $c_tree is the contents of
the index before replaying the stash).

This is not ideal.  We would want to see "git diff" for such a
path show difference similar to difference between I and W.

There is a little glitch, though.  Such an operation can also be
done with a three-way merge (git-merge-file would most likely be
useful), but what would we do when this second merge conflicts?
If we insist on making the "git diff" output to match the diff
between I and W for the path, somebody needs to resolve the
conflict and put the result in the index, but if git-merge-file
couldn't, the user is left to do that.  I strongly suspect that
we would not want that aggravation (besides, the working tree
cannot be used anymore as it contains what we would want to
leave there as the result of unstashing).  The second best thing
is probably to leave the index as it was before the stash was
applied for such a path (in other words, for such a path, we
discard the difference between I and W, favoring to use W).

We could still attempt to carry the difference between I and W
for paths that the second merge cleanly resolves, but then "git
diff" will show full diff between H and W for some paths (that
is, the ones the second merge did not cleanly resolve) while
diff between I and W for others (the ones that resolved
cleanly).  That is not what the current code does, though.

I am hoping that the "best effort" would make it more convenient
to use, but I also suspect that it might make things more
confusing to the end user and certainly more difficult to explain.

So that's about the cleanly-merged case.

What we should do about the paths that the first merge (i.e. the
one that updates the working tree) does not resolve cleanly?  We
would want to keep the index the way merge-recursive left, for
conflicting paths at least.  We would have higher stages for
them, so that the user will not accidentally commit things that
have not been merged, and can use usual conflict resolution
techniques like "git diff" to view the combined diff between
three versions.
