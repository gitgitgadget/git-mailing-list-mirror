From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Teach git-gui about merging around modified files?
Date: Sun, 29 Jul 2007 05:04:31 -0400
Message-ID: <20070729090431.GO20052@spearce.org>
References: <20070727170347.GX21692@lavos.net> <20070729073652.GN20052@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Brian Downing <bdowning@lavos.net>
X-From: git-owner@vger.kernel.org Sun Jul 29 11:04:53 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IF4hm-0005C8-9z
	for gcvg-git@gmane.org; Sun, 29 Jul 2007 11:04:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760665AbXG2JEg (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 Jul 2007 05:04:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760619AbXG2JEg
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jul 2007 05:04:36 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:35311 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755582AbXG2JEf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jul 2007 05:04:35 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1IF4hT-0002s8-43; Sun, 29 Jul 2007 05:04:31 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id CC01D20FBAE; Sun, 29 Jul 2007 05:04:31 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20070729073652.GN20052@spearce.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54096>

"Shawn O. Pearce" <spearce@spearce.org> wrote:
> Brian Downing <bdowning@lavos.net> wrote:
> > "git merge" will happily merge a change with modified files in the tree
> > as long as the merge doesn't touch any of them.  However, it appears
> > "git gui" won't even try if there are modified files at all.
> 
> Yes.  That is actually intentional...
> 
> If you merge and get conflicts you cannot abort to your pre-merge
> state safely by just doing a `git reset --hard` (or git-gui's own
> builtin action that does the same) as you will toss your own not
> yet committed changes too.  You really need to save those changes
> off first.

I felt bad about my original response to this thread.  Telling a
user that their workflow is broken and should be changed is not
very nice, and not user friendly.

So I just spent a couple of hours trying to teach git-gui to first
save off your index and working directory, then run the merge, and
during abort let you restore things even if they weren't committed.

During testing I learned that you can't merge if you have any
staged but uncommitted changes.  If you try git-merge-recursive
just aborts and refuses to execute the merge, even if the file
paths aren't in conflict and won't require a file level merge.
The issue is the files are staged in the index and would commit
as part of the merge commit, rather than staying out until after,
so the merge driver is really doing the right thing here.

I'm still convinced that merging while you have uncommitted changes
in the working directory is really bad.  Its nearly impossible
to recover from a conflict and get back to pre-merge state, and
its also confusing to resolve conflicts because your unstaged but
modified files are still showing in the status.

I'm going to shelve this work until post 0.8.0 and try to rework
it using git-stash as part of git-gui 0.9.0.  Ideally you should
be able to stash your work before merging, and unstash after the
merge is complete.

-- 
Shawn.
