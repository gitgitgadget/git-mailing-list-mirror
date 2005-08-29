From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] git-repack-script: Add option to repack all objects
Date: Mon, 29 Aug 2005 09:48:23 -0700
Message-ID: <7vvf1obsfc.fsf@assigned-by-dhcp.cox.net>
References: <43102727.2050206@tuxrocks.com>
	<7vbr3hlqjs.fsf@assigned-by-dhcp.cox.net>
	<4312BC27.9010604@tuxrocks.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Aug 29 18:51:37 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E9mo9-0003g9-2v
	for gcvg-git@gmane.org; Mon, 29 Aug 2005 18:48:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751112AbVH2QsZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 29 Aug 2005 12:48:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751120AbVH2QsZ
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Aug 2005 12:48:25 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:62969 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S1751112AbVH2QsY (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Aug 2005 12:48:24 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050829164824.BYFX12158.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 29 Aug 2005 12:48:24 -0400
To: Frank Sorenson <frank@tuxrocks.com>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7906>

Frank Sorenson <frank@tuxrocks.com> writes:

> It reduces the disk space requirement significantly (linux packs from
> 135MB to 73MB), and I'm seeing speed improvements as well (probably
> because cache-cold operation requires far less seeking, and the caching
> requirements are smaller).
>
> What are the benefits to keeping old packs?

For a private repository where one does development in and does
push to public repositories from, packing everything into one
pack and pruning everything else (including old packs) is always
the optimum thing, if one can afford the time to repack.

There are no benefits to _keeping_ old packs, but there may be
benefits not to pack everything into one huge one when other
people are involved.

Suppose I have currently three packs (one since the beginning of
time to some time ago, one incremental on top of it, another
incremental on top of the other two).  Somebody cloned from my
repository reasonably early in the project timeline (he has only
the first pack), somebody else cloned yesterday (has all three
packs).  And "git count-objects" reports many other objects are
unpacked and I decide it is a time to repack.

At this point I could create everything into one new big pack
and remove old packs.  Or I could create the fourth incremental.
Another possibility, and which is what I currently do by hand,
is to create a pack that is incremental on top of the first two,
and replace the latest incremental with it.

Now these two people want to fetch from my repository while the
third person wants to clone from scratch.  Which repacking
strategy gives the best transfer to these three people?  Having
a single huge pack favors the newcomer and penalizes the old
timers.  Especially, the current http-pull does not have a smart
to pick a better pack when an object is found in more than one
packs, so leaving old packs around would not help.

Leaving the old packs around could help all of them.  In the
above example, I could create the fourth incremental _and_ a
superpack that has everything in it.  The newcomer would slurp
in the superpack, the one with only the first pack can use one
of the second+third+fourth or the superpack, and the one with
all three can use the fourth pack.

Having said that, the packing has an interesting compression
characteristics.  Repacking the three existing packs (from the
example) along with the unpacked objects into one pack would
result in a very small pack, compared to the sum of three
existing packs, depending on how often you repack.  In that
sense, it may not be such a big deal to force everybody to
re-fetch everything even if most of them are already locally
available, by repacking everything into one.

> I disagree about not removing old packs.

I am not saying we should not remove old pack.  I am saying that
repacking, choosing which pack to remove and doing the actual
removing should be kept as separate steps and in separate
commands, perhaps the latter two as part of "git prune".

-jc
