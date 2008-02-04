From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Add platform-independent .git "symlink"
Date: Sun, 3 Feb 2008 20:57:08 -0500
Message-ID: <20080204015707.GH24004@spearce.org>
References: <8c5c35580802020959v613b9e32v321e97f93f2af761@mail.gmail.com> <1201975757-13771-1-git-send-email-hjemli@gmail.com> <alpine.LSU.1.00.0802021815510.7372@racer.site> <alpine.LSU.1.00.0802021825220.7372@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Lars Hjemli <hjemli@gmail.com>, Junio C Hamano <gitster@pobox.com>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Mon Feb 04 02:58:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JLqas-0005oX-N8
	for gcvg-git-2@gmane.org; Mon, 04 Feb 2008 02:57:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754951AbYBDB5O (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 3 Feb 2008 20:57:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754931AbYBDB5O
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Feb 2008 20:57:14 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:32970 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754738AbYBDB5N (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Feb 2008 20:57:13 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JLqZx-0002oW-SL; Sun, 03 Feb 2008 20:57:01 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id C488720FBAE; Sun,  3 Feb 2008 20:57:08 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <alpine.LSU.1.00.0802021825220.7372@racer.site>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72449>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> Howver, having .git a file pointing to another git directory allows you to 
> have locks there.  And they can be actually pretty sensible locks, like
> 
> 	.git/HEAD.<mangled-path>
> 
> actually containing the symbolic ref describing which branch we're on in 
> that working directory.  Likewise, .git/index.<mangled-path> needs to hold 
> the current index.
> 
> Of course, for this to work, you need to use different HEADs and indexes 
> only if .git was a file originally.
> 
> BTW <mangled-path> could be a hash of the path, and for convenience, we 
> could store the path in .git/workdir.<mangled-path>.

This I like.  Because my day-job coworkers and I make very heavy use of
git-new-workdir to manage our compile areas/working directories.  :)

The biggest problem with new-workdir is the master repository
cannot see the HEAD, index or logs/HEAD of the working directories.
Consequently it is possible for prune (or repack -a -d) to remove
objects that some workdir is still referring to.  Its not uncommon
for my HEAD reflogs to have stale commits in them.  Every once in
a while a user looses their HEAD entirely when it gets pruned away,
as they had a workdir checked out on a detached HEAD.

The second biggest problem is checking out the same branch in two
different directories at once.  This becomes a problem only if you
modify the branch, but still, its a problem.


I was thinking that we could add a WORKDIR_HASH to the .git file
Lars was proposing.  This hash would be the <mangled-path> suffix
you are talking about above, and would avoid the need to compute
the absolute path for the working directory every time we run a
Git command.

The hash could be something simple, like the SHA-1 hash of the
absolute path at the time of workdir creation.  But it would be nice
if we could recommend a specific value during workdir creation,
so that the WORKDIR_HASH could start with a value that matches
something the user would readily recognize.

-- 
Shawn.
