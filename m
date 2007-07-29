From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Teach git-gui about merging around modified files?
Date: Sun, 29 Jul 2007 03:36:52 -0400
Message-ID: <20070729073652.GN20052@spearce.org>
References: <20070727170347.GX21692@lavos.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Brian Downing <bdowning@lavos.net>
X-From: git-owner@vger.kernel.org Sun Jul 29 09:37:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IF3Km-0004ov-Ol
	for gcvg-git@gmane.org; Sun, 29 Jul 2007 09:37:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759912AbXG2Hg5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 29 Jul 2007 03:36:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759824AbXG2Hg5
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jul 2007 03:36:57 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:33834 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759887AbXG2Hg4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jul 2007 03:36:56 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1IF3Kf-0003sY-0n; Sun, 29 Jul 2007 03:36:53 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id E988820FBAE; Sun, 29 Jul 2007 03:36:52 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20070727170347.GX21692@lavos.net>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54088>

Brian Downing <bdowning@lavos.net> wrote:
> "git merge" will happily merge a change with modified files in the tree
> as long as the merge doesn't touch any of them.  However, it appears
> "git gui" won't even try if there are modified files at all.

Yes.  That is actually intentional...
 
> How hard would it be to fix this, or is this an intentional choice?

Its not hard to fix.  I just did it in a patch that would be:

 lib/merge.tcl |   12 +-----------
 1 files changed, 1 insertions(+), 11 deletions(-)

and we all know deleting more lines is good, but after I made the
patch and started testing it I remembered exactly why I don't allow
you to merge with modified files.

If you merge and get conflicts you cannot abort to your pre-merge
state safely by just doing a `git reset --hard` (or git-gui's own
builtin action that does the same) as you will toss your own not
yet committed changes too.  You really need to save those changes
off first.

> I realize that commiting even untouched files before a merge is safer,
> but I'm tasked with migrating some CVS users to Git, and I'd prefer
> to be able to introduce the new Git workflow slowly.
> 
> (I'm happy enough with disallowing merges that actually touch modified
> files, so I'm not looking for any kind of in-working-directory merge
> like some others were.  I'd just like the "git merge" behavior to work
> in git-gui.)

What do you do when the merge goes badly on the command line
(lots of conflicts, but none to the files you have modified),
and you want to get back to your pre-merge state?  You can't,
there's no state saved for git to reset back to.

Really what you want to do here is stash your local changes away,
then do the merge, and after the merge is successfully completed
apply the stash back onto your working tree.  Because then if the
merge goes badly you can `git reset --hard && git stash apply`
to bring back your prior state.

So until git-gui plays along nicely with git-stash (can save
and apply to it) I'm going to continue to disallow merging with
uncommitted changes.  Its just not a smart thing to be doing.

-- 
Shawn.
