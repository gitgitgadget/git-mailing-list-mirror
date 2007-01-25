From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Question about fsck-objects output
Date: Thu, 25 Jan 2007 14:31:12 -0500
Message-ID: <20070125193112.GE13089@spearce.org>
References: <45B8F575.5050106@lightspeed.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Larry Streepy <larry@lightspeed.com>
X-From: git-owner@vger.kernel.org Thu Jan 25 20:31:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HAAJe-0003KX-Cg
	for gcvg-git@gmane.org; Thu, 25 Jan 2007 20:31:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030520AbXAYTbR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 25 Jan 2007 14:31:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030522AbXAYTbR
	(ORCPT <rfc822;git-outgoing>); Thu, 25 Jan 2007 14:31:17 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:45754 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030520AbXAYTbQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Jan 2007 14:31:16 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HAAJS-0001ro-BJ; Thu, 25 Jan 2007 14:31:10 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id B21C020FBAE; Thu, 25 Jan 2007 14:31:12 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <45B8F575.5050106@lightspeed.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/37753>

Larry Streepy <larry@lightspeed.com> wrote:
> Sorry to ask such a basic question, but I can't quite decipher the output 
> of fsck-objects.  When I run it, I get this:
> 
>  git fsck-objects
> dangling commit 2213f6d4dd39ca8baebd0427723723e63208521b
> dangling commit f0d4e00196bd5ee54463e9ea7a0f0e8303da767f
> dangling blob 6a6d0b01b3e96d49a8f2c7addd4ef8c3bd1f5761
> 
> 
> Even after a "repack -a -d" they still exist.  The man page has a short 
> explanation, but, at least for me, it wasn't fully enlightening. :-)
> 
> The man page says that dangling commits could be "root" commits, but since 
> my repo started as a clone of another repo, I don't see how I could have 
> any root commits.  Also, the page doesn't really describe what a dangling 
> blob is.
> 
> So, can someone explain what these artifacts are and if they are a problem 
> that I should be worried about?

These were probably created by amending a commit (`git commit --amend`).

Dangling commits simply mean no existing branch points at them,
either directly by a ref/tag or indirectly by the commit being
merged into them.  They aren't part of any interesting history.
They could also be caused by deleting a branch before it was fully
merged into another branch.  The commits and history are still
there, they just lack a name.

Dangling blobs mean the same thing; no existing branch uses
them in their revisions.

What most likely happened here was you committed a change, realized
it was slightly wrong, modified one file, then used `git commit
--amend -a` to update the commit with the correction.  Later you
probably did the same thing, but only to correct the commit message.
The first instance caused the blob and commit to dangle, the
second caused another commit to dangle.

You can use `git show id` (where id is the commit id above) to see
what the commit actually is.

You can use `git prune` to have these objects deleted.  For safety
reasons `repack -a -d` won't touch them.  But they don't take up
a lot of disk space (usually) so pruning isn't something to be
too concerned about.

-- 
Shawn.
