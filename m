From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC] Design for http-pull on repo with packs
Date: Mon, 11 Jul 2005 16:30:48 -0700
Message-ID: <7vu0j0ncnr.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.21.0507101226011.30848-100000@iabervon.org>
	<42D17D89.9080808@innehallsbolaget.se>
	<7v4qb2ni73.fsf@assigned-by-dhcp.cox.net> <42D2960E.3050008@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>, torvalds@osdl.org,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 12 01:37:28 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Ds7pu-0006QW-QQ
	for gcvg-git@gmane.org; Tue, 12 Jul 2005 01:37:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262297AbVGKXgk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 11 Jul 2005 19:36:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262277AbVGKXbo
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Jul 2005 19:31:44 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:23797 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S262280AbVGKXav (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jul 2005 19:30:51 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050711233048.TEVW15197.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 11 Jul 2005 19:30:48 -0400
To: Dan Holmsand <holmsand@gmail.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Dan Holmsand <holmsand@gmail.com> writes:

> I did a little experiment. I cloned Linus' current tree, and git
> repacked everything (that's 63M + 3.3M worth of pack files). Then I
> got something like 25 or so of Jeff's branches. That's 6.9M of object
> files, and 1.4M packed. Total size: 70M for the entire
> .git/objects/pack directory.
>
> Repacking all of that to a single pack file gives, somewhat
> surprisingly, a pack size of 62M (+ 1.3M index). In other words, the
> cost of getting all those branches, and all of the new stuff from
> Linus, turns out to be *negative* (probably due to some strange
> deltification coincidence).

We do _not_ want to optimize for initial slurps into empty
repositories.  Quite the opposite.  We want to optimize for
allowing quick updates of reasonably up-to-date developer repos.
If initial slurps are _also_ efficient then that is an added
bonus; that is something the baseline big pack (60M Linus pack)
would give us already.  So repacking everything into a single
pack nightly is _not_ what we want to do, even though that would
give the maximum compression ;-).  I know you understand this,
but just stating the second of the above paragraphs would give
casual readers a wrong impression.

> I think that this shows that (at least in this case), having many
> branches isn't particularly wasteful (1.4M in this case with one
> incremental pack).

> And that fewer packs beats many packs quite handily.

You are correct.  For somebody like Jeff, having the Linus
baseline pack with one pack of all of his head (incremental that
excludes what is already in the Linus baseline pack) would help
pullers.

> The big problem, however, comes when Jeff (or anyone else) decides to
> repack. Then, if you fetch both his repo and Linus', you might end up
> with several really big pack files, that mostly overlap. That could
> easily mean storing most objects many times, if you don't do some
> smart selective un/repacking when fetching.

Indeed.  Overlapping packs is a possibility, but my gut feeling
is that it would not be too bad, if things are arranged so that
packs are expanded-and-then-repacked _very_ rarely if ever.
Instead, at least for your public repository, if you only repack
incrementally I think you would be OK.
