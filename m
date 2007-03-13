From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [ANNOUNCE] chronoversion: chronological archiving script with temporary commits
Date: Tue, 13 Mar 2007 11:45:11 -0400
Message-ID: <20070313154511.GA18890@spearce.org>
References: <e1dab3980703130526t4b573f18h793a065d54c9369@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, jonsmirl@gmail.com
To: David Tweed <david.tweed@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 13 16:45:23 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HR9Bi-0006Bj-0S
	for gcvg-git@gmane.org; Tue, 13 Mar 2007 16:45:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030753AbXCMPpR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Mar 2007 11:45:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030754AbXCMPpR
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Mar 2007 11:45:17 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:54871 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030751AbXCMPpP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Mar 2007 11:45:15 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HR9BS-0007ex-OB; Tue, 13 Mar 2007 11:45:06 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 3B6D620FBAE; Tue, 13 Mar 2007 11:45:11 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <e1dab3980703130526t4b573f18h793a065d54c9369@mail.gmail.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42123>

David Tweed <david.tweed@gmail.com> wrote:
> A question for those who understand things: I stash the last written
> _tree_'s hash in a tag and then when a new "commit's" directory tree
> is written starts look to see if it's the same SHA value. If it is I
> know I can avoid the commit. At the moment I'm using
> 
>    if os.path.exists(lastTreeFile) and
> tree==open(lastTreeFile,"r").read()[:40]:
> 
> to be safe just in case a user, eg, goes mad and manually deletes that
> record. Clearly this is going to hit trouble if git ever decides to
> put this tag into a packed refs file.
> Is there any neat way of using builtin stuff like git-rev-parse to ask
> if a ref has a given SHA1 value and return an easily parsed yes/no
> answer?

The common idiom if you want to compare trees to see if you
need to make a commit is:

	oldc=`git rev-parse $tagname^{commit}`
	oldt=`git rev-parse $oldc^{tree}`
	newt`git write-tree`
	if [ X$oldt = X$newt ]; then
		: nothing to save
	else
		newc=`git commit-tree $newt -p $oldc`
		git update-ref $tagname $newc $oldc
	fi

Yes, a little ugly.  But its safe; if another program were to
alter the value of $tagname (e.g. "git branch -f", "git tag -f")
while your script is running the update-ref in the else will fail,
letting you know that $tagname changed in the process.

-- 
Shawn.
