From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-http-pull broken in latest git
Date: Thu, 11 Aug 2005 16:57:04 -0700
Message-ID: <7voe84c9in.fsf@assigned-by-dhcp.cox.net>
References: <42F8D472.3080404@de.bosch.com>
	<20050811223349.GI25280@pasky.ji.cz>
	<7v4q9wf4ad.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 12 01:58:30 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E3MvC-0004BP-8E
	for gcvg-git@gmane.org; Fri, 12 Aug 2005 01:57:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932244AbVHKX5I (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 11 Aug 2005 19:57:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932251AbVHKX5H
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Aug 2005 19:57:07 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:416 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S932244AbVHKX5G (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Aug 2005 19:57:06 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050811235706.ISZE19494.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 11 Aug 2005 19:57:06 -0400
To: Petr Baudis <pasky@suse.cz>
In-Reply-To: <7v4q9wf4ad.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Thu, 11 Aug 2005 16:21:46 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <junkio@cox.net> writes:

> Last time I checked, git-http-pull did not utilize the pack
> dependency information, which indeed is wrong.  When it decides
> to fetch a pack instead of an asked-for object, it should check
> which commits the pack expects to have in your local repository
> and add them to its list of things to slurp.

Oh, well, the above makes it sound as if I am blaming Daniel for
this, but the blame lies on me who did not document properly
what is going on, in except the comments in the source.  So here
is an explanation.

A $GIT_DIR/objects/info/packs file looks like this:

    P pack-3c5133604508466855453f3e609428f4bbba9131.pack
    P pack-37cba29d3df65b160afabe769470f7857f98d729.pack
    D 0
    D 1 0
    T 0 c1c774e7965ba08061c3fc7bc57aebc7eeb6b40f commit
    T 0 d6602ec5194c87b0fc87103ca4d67251c76f233a tag
    T 1 0918385dbd9656cab0d1d81ba7453d49bbc16250 tag
    T 1 7ceca275d047c90c0c7d5afb13ab97efdf51bd6e tag
    T 1 b3e9704ecdf48869f635f0aa99ddfb513f885aff tag
    T 1 c5db5456ae3b0873fc659c19fafdde22313cc441 tag
    T 1 f25a265a342aed6041ab0cc484224d9ca54b6f41 tag

P lines are list of packs, and they are implicitly numbered
starting from #0.  3c5133 pack is pack #0 and 37cba2 pack is
pack #1 in the above example.

D lines are pack dependencies.  "D 0" says pack #0 does not
depend on any, "D 1 0" says pack #1 depends on pack #0.

T lines are what I call "pack edges".  They are objects that are
not reachable from any other object contained in the same pack.
What this means is that if you have all of the listed objects
for a pack, downloading that pack is useless for you.  This of
course requires that your local repository is not partial.

A D line says that pack #1 depends on pack #0.  So if you decide
to slurp pack #1 because you wanted to have one object that is
not available as a plain file under objects/??/, you had better
make sure that you have all the objects available in pack #0.

One way to do so is to look at T lines for pack #0 and make sure
you have those "pack edge" objects in the local repository.  If
you discover you do not have them, you either need to slurp pack
#0 as well, or start walking the commits from these pack edges.
If http-pull slurped pack #0, which does not depend on anything
else, this would obviously complete the process.  However, even
if http-pull chose to walk the commits, if the remote repository
is fully packed, it would end up slurping pack #0.  So either
way would work fine in theory, and the choice of which approach
to take really depends on "which one is more efficient".

The only case when walking the commits from pack edges could be
a win is when your local repository have most but not all of the
objects that are in pack #0 on the remote side, and the remote
side has those needed objects lying around unpacked, in addition
to having them in the pack #0.  This is very unlikely because
(1) the remote side says pack #1 depends on pack #0, which means
pack #0 is older than pack #1, and (2) we ended up slurping pack
#1, which means objects in pack #1 have already been removed by
"git prune-packed" on the remote side.  These two makes it very
likely that objects in pack #0 are already prune-packed on the
remote side.  So my recommendation is to just slurp the depended
on pack, pack #0, in this case instead of adding the pack edge
objects to "to be commit-walked" list.
