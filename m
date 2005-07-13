From: Junio C Hamano <junkio@cox.net>
Subject: Re: How to get a directory filled with v2.6.11?
Date: Wed, 13 Jul 2005 13:37:51 -0700
Message-ID: <7vvf3ewig0.fsf@assigned-by-dhcp.cox.net>
References: <20050712050347.GA10751@buici.com>
	<Pine.LNX.4.58.0507122116280.17536@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 13 22:43:30 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dso42-0007Bw-Up
	for gcvg-git@gmane.org; Wed, 13 Jul 2005 22:42:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262758AbVGMUlz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 13 Jul 2005 16:41:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262792AbVGMUj2
	(ORCPT <rfc822;git-outgoing>); Wed, 13 Jul 2005 16:39:28 -0400
Received: from fed1rmmtao08.cox.net ([68.230.241.31]:24553 "EHLO
	fed1rmmtao08.cox.net") by vger.kernel.org with ESMTP
	id S262757AbVGMUhy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Jul 2005 16:37:54 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao08.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050713203751.GVDB16890.fed1rmmtao08.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 13 Jul 2005 16:37:51 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0507122116280.17536@g5.osdl.org> (Linus Torvalds's message of "Tue, 12 Jul 2005 21:37:06 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> That said, whatever you do you will eventually end up with a series of
> commits that are not related to the "normal" commits in the 2.6.12-rc2+
> chain, and since they don't have a common point, git won't be able to
> merge them for you. Git will be able to _track_ them for you, but at some
> point you'll want to probably try to move them forward to the "rest" of
> the git history.
>
> And I'll warn you that that is not going to be entirely trivial, although
> Junio's "cherrypick" scripts should be useful as a way to automate it at
> least to some degree. This is why it would be so much easier if you could 
> have started with a 2.6.12-rc2 or other "real" commit ;)

I do not think git-cherry would be that useful in this context.
Nobody upstream is merging things into your development trail,
started at the private commit you made based on the 2.6.11 tree.

I was wondering if adding "graft trail" to merge-base command
would help this situation.

    SYNOPSIS
    --------
    'git-merge-base' ( --graft <commit1> <commit2>)* <commit> <commit>

    ...

    OPTIONS
    -------
    <commit>::
            The two heads being merged.

    --graft <commit1> <commit2>::
            Treat as if <commit1> is one of the ancestors of
            <commit2> when computing the commit ancestry chain.
            Can be specified more than once.

Then we could say "--graft v2.6.11 v2.6.12-rc2".

We may want to have a configuration file in .git/ directory (I
think it belongs to .git/objects/ hierarchy, because this is not
per work-tree thing but per project thing) that record this
"graft" relationship.

When we have not-so-stupid [*1*] merge algorithm in place, we
could do even better.  Starting from v2.6.11 tree, we can
rebuild (from BKCVS) the development trail up to v2.6.12-rc2,
which is independent from the current kernel development trail
which started at (a different) v2.6.12-rc2.  Use the former one
as <commit1>, and the latter one as <commit2>, and the "clever"
merge algorithm would be able to follow across the v2.6.12-rc2
discontiguity and trace the development back to v2.6.11.

[Footnote]

*1* <Pine.LNX.4.58.0507052011440.3570@g5.osdl.org>

So if you want to document that the current automatic merge is stupid,
hey, go wild. It _is_ stupid. It's surprisingly effective, but that may be
because of kernel development patterns and may not be true in other
projects.
