From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Why doesn't git-rerere automatically commit a resolution?
Date: Tue, 11 Jul 2006 09:29:50 -0400
Message-ID: <20060711132950.GA5856@spearce.org>
References: <20060711061626.GB11822@spearce.org> <7v8xn06310.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 11 15:30:12 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G0IJK-0007Qi-Rq
	for gcvg-git@gmane.org; Tue, 11 Jul 2006 15:29:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750758AbWGKN3z (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 11 Jul 2006 09:29:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750761AbWGKN3z
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Jul 2006 09:29:55 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:51179 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1750758AbWGKN3y (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Jul 2006 09:29:54 -0400
Received: from cpe-72-226-60-173.nycap.res.rr.com ([72.226.60.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1G0IJA-0003kc-1b; Tue, 11 Jul 2006 09:29:48 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id AECB720E43C; Tue, 11 Jul 2006 09:29:50 -0400 (EDT)
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v8xn06310.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/23710>

Junio C Hamano <junkio@cox.net> wrote:
> Not merging the index after rerere re-applies a previous
> resolution to the working tree file is a deliberate design
> decision.  During conflict resolution, "git diff" against
> unmerged index file is the second most useful command to check
> your hand-merge result, and running update-index on these path
> automatically robs this useful tool from the user.  So, in order
> to help more disciplined workflow, a bit of convenience for
> lazier people is sacrficed here.

OK, I agree with all of the above.  Except in the following case:

	git update-ref BACKUP HEAD
	git pull . sp/topicA
	git pull . sp/topicB
	..fix conflicts..
	git commit -F .git/MERGE_MSG
	git reset --hard BACKUP

	git pull . sp/topicA
	git pull . sp/topicB
	..ah, come on!..

By pulling the exact same two heads together in the exact same
order I would expect the exact same merge result.  And since I
have git-rerere enabled I would expect it to autocommit the result
of the merge as I have already checked it before and verified its
correct when I first fixed the conflicts.

After reading your message I agree with you however that pulling in
the reverse direction (e.g. topicB then topicA) shouldn't autocommit
the merge result as I haven't hand verified it to be correct - yet.
However if I do and I merge it again later with the same two commits
then it should still be correct.

Further if I alter sp/topicA by changing a file path which wasn't
conflicted in the merge with sp/topicB I would expect it to
carry out the merge assuming the conflicts were remembered as-is.
Because that's what a trivial in-index merge would do and that will
commit despite conflicts possibly existing between files.


I guess what I'm saying is maybe git-rerere (or git-merge in general)
could benefit from a slightly higher level cache.  Store 4 sets
of (mode, sha1) tuples: stage1 stage2 stage3 result in a cache
somewhere.  If you get a conflicted merge which has been previously
fixed by hand wherein all 3 stages in the index are found in the
cache then update the index and working directory with the result
(mode, sha1) tuple.

If any of the 3 stages differs then fall back to git-rerere and
attempt a file level merge, stopping before commit to allow the
user to verify (and possibly correct) the resulting merge.

One advantage of this higher level cache is it can be used for
binary files which `merge` can't normally process, as well as for
structual conflicts.

Thoughts?  I can prototype this higher level cache into git-rerere
later tonight after I get home from work.

-- 
Shawn.
