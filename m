From: Junio C Hamano <junkio@cox.net>
Subject: Re: Proposal for new git Merge Strategy
Date: Wed, 23 Aug 2006 13:00:31 -0700
Message-ID: <7vsljngr34.fsf@assigned-by-dhcp.cox.net>
References: <E1GFxeZ-0000Nw-ED@jdl.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 23 22:01:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GFytw-0001Fh-86
	for gcvg-git@gmane.org; Wed, 23 Aug 2006 22:00:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965176AbWHWUAc (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 23 Aug 2006 16:00:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965178AbWHWUAc
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Aug 2006 16:00:32 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:12936 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S965176AbWHWUAc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Aug 2006 16:00:32 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060823200031.DVDA12909.fed1rmmtao05.cox.net@fed1rmimpo01.cox.net>;
          Wed, 23 Aug 2006 16:00:31 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
	by fed1rmimpo01.cox.net with bizsmtp
	id DY0W1V00d4Noztg0000000
	Wed, 23 Aug 2006 16:00:31 -0400
To: Jon Loeliger <jdl@jdl.com>
In-Reply-To: <E1GFxeZ-0000Nw-ED@jdl.com> (Jon Loeliger's message of "Wed, 23
	Aug 2006 13:40:39 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25926>

Jon Loeliger <jdl@jdl.com> writes:

> But for complex or critical merges, a "guided merge"
> strategy seems like it might be a useful tool.  Basically,
> it would offer options to select Stage 1 or Stage 2
> revisions, or step in and offer hunks from Stage 1 and 2,
> revert to "ours" or "theirs", or "revert to 'ours' or 'theirs'
> for all remaining files".  Things like that maybe.
>
> Any thoughts down this line?  Good idea?  Bad idea?

We had some discussion on this with Catalin in "Unresolved
issues #3" thread, regarding git-xxdiff (did I ever take it?  I
liked it for what it does, but I was not sure about its
odd-man-out-ness) which was proposed by Martin Langhoff.

A merge that results in manual fixups conceptually take these
steps:

 - revs involved in 3-way merge identified with git-merge-base;

 - read-tree is given these three bases;

 - git-merge-index gives three stages as individual temporary
   files to git-merge-one-file for each path that cannot be
   resolved at tree-level.

   - git-merge-one-file calls "merge" (reminds me that I should
     replace this with "diff3").

We should be able to make the part that call "merge/diff3" to
alternatively call xxdiff or its friends (kompare, emerge, pick
your favorites).  Catalin even showed us a code snippet used in
StGIT for this in the thread.

Martin's proposed tool git-xxdiff is meant to be invoked after
all of the above still left conflict markers.  As Catalin
pointed out, using "xxdiff -U" to work on a file with conflict
markers is less powerful than working on three stages directly,
but on the other hand it can be used as the last stage fixup,
independent from what git-merge does internally.  In other
words, it is meant to help solving the same problem but in a
different part of the workflow.
