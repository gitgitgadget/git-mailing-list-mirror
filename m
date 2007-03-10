From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-log --full-history renamed-file
Date: Fri, 09 Mar 2007 17:59:42 -0800
Message-ID: <7vejnxzwmp.fsf@assigned-by-dhcp.cox.net>
References: <87lki6umts.fsf@rho.meyering.net>
	<Pine.LNX.4.64.0703091339190.10832@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jim Meyering <jim@meyering.net>,
	Git Mailing List <git@vger.kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat Mar 10 02:59:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HPqsB-0001Y2-2E
	for gcvg-git@gmane.org; Sat, 10 Mar 2007 02:59:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1767713AbXCJB7o (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 9 Mar 2007 20:59:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1767721AbXCJB7o
	(ORCPT <rfc822;git-outgoing>); Fri, 9 Mar 2007 20:59:44 -0500
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:64853 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1767713AbXCJB7n (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Mar 2007 20:59:43 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070310015943.JPSA748.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Fri, 9 Mar 2007 20:59:43 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id Ypzi1W0011kojtg0000000; Fri, 09 Mar 2007 20:59:42 -0500
In-Reply-To: <Pine.LNX.4.64.0703091339190.10832@woody.linux-foundation.org>
	(Linus Torvalds's message of "Fri, 9 Mar 2007 14:20:55 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41836>

Linus Torvalds <torvalds@linux-foundation.org> writes:

>  - it's almost silly, but "git blame" internally really already has all 
>    the logic for this, it's just not exposed any sane way to a user.
>
> I'm appending a REALLY UGLY patch that makes
>
> 	git blame --log filename.c
>
> work kind of like you'd want. IT IS NOT MEANT TO BE REALLY USED, because 
> in particular, it doesn't take the nice log options (so you cannot make it 
> show diffs etc, even though we have all the machinery in place for that). 
> But it's an example of the fact that yes, git can do this, but we're so 
> stupid that we don't really accept it.
>
> (NOTE! It's also almost totally untested. It might not work. I'm sending 
> it out as a very rough example, not as a serious contender)
>
> 		Linus

At this point that you call log_tree_commit(), 

> @@ -1376,6 +1379,16 @@ static void found_guilty_entry(struct blame_entry *ent)
>  	if (ent->guilty)
>  		return;
>  	ent->guilty = 1;
> +	if (log) {
> +		struct origin *suspect = ent->suspect;
> +		struct commit *commit = suspect->commit;
> +
> +		if (commit->object.flags & SHOWN)
> +			return;
> +		commit->object.flags |= SHOWN;
> +		log_tree_commit(&log_rev, commit);
> +		return;
> +	}

you have not just the path information _but_ also the line range
in the postimage, so we could use an enhanced version of
log_tree_commit() that also lets us limit its output only to
hunks that touch the affected range.

Also, found_guilty_entry() is called number of times for the
same suspect <commit, path> pair for discontiguous line ranges.
I think a saner thing to do is to collect and coalesce the blame
entry for the same <commit, path> in the above part of the code,
and then do a single log_tree_commit() for the <commit, path>,
perhaps limiting to the hunks that touch the line ranges the
commit is assigned blame for, before continuing to a different
commit (i.e. after the for() loop, which is the only caller of
this found_guilty_entry() function, exits).
