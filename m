From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: git and peer review
Date: Sun, 18 May 2008 23:37:36 -0400
Message-ID: <20080519033736.GZ29038@spearce.org>
References: <46dff0320805021802i1a29becflcae901315035a77d@mail.gmail.com> <87k5i9u8f1.fsf@nav-akl-pcn-343.mitacad.com> <20080517213039.GR396@ziti.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Toby Allsopp <Toby.Allsopp@navman.co.nz>,
	Ping Yin <pkufranky@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Seth Falcon <seth@userprimary.net>
X-From: git-owner@vger.kernel.org Mon May 19 05:38:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JxwD9-0003ye-LZ
	for gcvg-git-2@gmane.org; Mon, 19 May 2008 05:38:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753950AbYESDhp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 May 2008 23:37:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754067AbYESDhp
	(ORCPT <rfc822;git-outgoing>); Sun, 18 May 2008 23:37:45 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:43840 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753751AbYESDho (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 May 2008 23:37:44 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JxwBh-0006qy-K2; Sun, 18 May 2008 23:37:25 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id C379B20FBAE; Sun, 18 May 2008 23:37:36 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20080517213039.GR396@ziti.local>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82407>

Seth Falcon <seth@userprimary.net> wrote:
> What I would like is a way for the script to determine the appropriate
> tracking branch.  So that the usage would look like:
> 
>    git mark-reviewed someone@userprimary.net
> 
> and it would figure out whether it should do trunk.. or release-1.3..,
> etc.  Can anyone point me in the right direction?

Something like this, but its uh, ugly due to the use of a network
connection:

	branch=$(git symbolic-ref HEAD)
	branch=${branch##refs/heads/}

	remote=$(git config branch.$branch.remote)
	merge=$(git config branch.$branch.merge)

	rb=$(git ls-remote $remote $merge | awk '{print $1}')

Then use a filter-branch on "$rb..$branch" as the range.

You may be able to just assume that the remote name is the
refs/remotes prefix and instead do:

	branch=$(git symbolic-ref HEAD)
	branch=${branch##refs/heads/}

	remote=$(git config branch.$branch.remote)
	merge=$(git config branch.$branch.merge)
	merge=${merge##refs/heads/}

	rb=refs/remotes/$remote/$merge

but that's an assumption, and we all know what happens when you
assume things.

Technically you need to look at remote.$remote.fetch lines
in .git/config to figure out the rewriting rules from what
branch.$branch.merge contains to what refs/remotes/* might be,
and doing that is not quite as trivial as either using ls-remote or
assuming your users have the standard layout created by git-clone
and git-remote.

-- 
Shawn.
