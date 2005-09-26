From: Junio C Hamano <junkio@cox.net>
Subject: Re: GIT 0.99.7d, and end of week status.
Date: Mon, 26 Sep 2005 13:25:28 -0700
Message-ID: <7vll1jh8zr.fsf@assigned-by-dhcp.cox.net>
References: <7vll1lr1bq.fsf@assigned-by-dhcp.cox.net>
	<7vaci1nfwa.fsf@assigned-by-dhcp.cox.net>
	<87psqwzs3x.fsf@ualberta.net>
	<7v7jd4n22i.fsf@assigned-by-dhcp.cox.net>
	<20050926191037.GD26340@pasky.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tom Prince <tom.prince@ualberta.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 26 22:27:28 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EJzXZ-0000r6-Bj
	for gcvg-git@gmane.org; Mon, 26 Sep 2005 22:25:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932511AbVIZUZa (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 26 Sep 2005 16:25:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932512AbVIZUZa
	(ORCPT <rfc822;git-outgoing>); Mon, 26 Sep 2005 16:25:30 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:10197 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S932511AbVIZUZ3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 26 Sep 2005 16:25:29 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050926202529.BEIW29747.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 26 Sep 2005 16:25:29 -0400
To: Petr Baudis <pasky@suse.cz>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9330>

Petr Baudis <pasky@suse.cz> writes:

> ... Either way, git-pull won't be equivalent to git-fetch &&
> git-merge (or git-resolve or whatever is the core porcelain
> command) anymore.

"pull = fetch + merge" is a reasonable approximation to use when
you explain what they are to somebody, but taking it literally
would harm usefulness.

It is what you have already lived with for a while.  "git pull
.../linux/2.6.git v2.6.11-tree v2.6.12" would fetch both heads
but merges v2.6.12 head only (because v2.6.11-tree is not
something you can merge with).

The typical use cases are:

 - The remote does not have more than one head (majority of the
   kernel.org repositories are single head repositories).  You
   could say "Pull: master:somebody" in .git/remotes/somebody
   and say "git pull somebody" and pull is fetch + merge.  The
   proposed fix does not affect this case.

 - The remote has more than one heads, and they are usually both
   interesting.  Some kernel.org repositories have release and
   test heads and people who are interested in what is happening
   in that subsystem are likely to want to inspect both, so
   fetching both makes a lot of sense (especially given
   multi-head fetch over git-native protocol is more efficieint
   than fetching them separately), but obviously merging both
   into an Octopus does not make any sense most of the time.

   You could say "Pull: release:a/release test:a/test" in
   .git/remotes/subsys and "git fetch subsys" would fetch both
   and store them locally.  "git pull subsys" would fetch both
   but merges only subs/release, which is far more useful than
   attempting to make an Octopus with both heads.  You could
   still say "git pull subsys test" to only fetch and merge
   test, if you needed to do something different from what the
   "merge only the first one by default" rule gives.

 - The remote has 47 different heads, and they are more or less
   independent developments in the same area ("topic branches").
   Jeff's libata-dev repository may be a good example.  "Pull:
   ALL:libata-dev/ALL ncq:libata-dev/ncq
   chs-support:libata-dev/chs-support ..."  would be what one
   would place in .git/remotes/libata-dev.  This list can be a
   subset of the heads that exist at remote but only the heads
   one is interested in.  "git fetch libata-dev" would get all
   the heads in that repository one is interested in, "git pull
   libata-dev" would merge in ALL (which is premerged at the
   remote side) thanks to the "merge only first one by default"
   rule.  If you want to make Octopus with selected heads (not
   the one Jeff made in ALL), you still can say "git pull
   libata-dev ncq chs-support" to do so.
