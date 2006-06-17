From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Porcelain specific metadata under .git?
Date: Fri, 16 Jun 2006 20:43:18 -0400
Message-ID: <20060617004318.GB25292@spearce.org>
References: <20060614062240.GA13886@spearce.org> <448FEED7.30701@op5.se> <e6os3v$r5g$1@sea.gmane.org> <44900A2F.7050704@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 17 02:43:37 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FrOuR-00072x-NV
	for gcvg-git@gmane.org; Sat, 17 Jun 2006 02:43:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751577AbWFQAn2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Jun 2006 20:43:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751578AbWFQAn2
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Jun 2006 20:43:28 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:27777 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1751576AbWFQAn2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Jun 2006 20:43:28 -0400
Received: from cpe-72-226-60-173.nycap.res.rr.com ([72.226.60.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1FrOu6-0007TB-57; Fri, 16 Jun 2006 20:43:10 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 06817212660; Fri, 16 Jun 2006 20:43:18 -0400 (EDT)
To: Andreas Ericsson <ae@op5.se>
Content-Disposition: inline
In-Reply-To: <44900A2F.7050704@op5.se>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21990>

Andreas Ericsson <ae@op5.se> wrote:
> Jakub Narebski wrote:
> >Andreas Ericsson wrote:
> >
> >
> >>Shawn Pearce wrote:
> >>
> >>>I already assume/know that refs/heads and refs/tags are completely
> >>>off-limits as they are for user refs only.
> >>>
> >>>I also think the core GIT tools already assume that anything
> >>>directly under .git which is strictly a file and which is named
> >>>entirely with uppercase letters (aside from "HEAD") is strictly a
> >>>temporary/short-lived state type item (e.g. COMMIT_MSG) used by a
> >>>Porcelain.
> >>>
> >>>But is saying ".git/refs/eclipse-workspaces" is probably able to
> >>>be used for this purpose safe?  :-)
> >>>
> >>
> >>.git/eclipse/whatever-you-like
> >>
> >>would probably be better. Heads can be stored directly under .git/refs 
> >>too. Most likely, nothing will ever be stored under ./git/eclipse by 
> >>either core git or the current (other) porcelains though.
> >
> >
> >I think if it is a ref, which one wants to be visible to git-fsck (and
> >git-prune), it should be under .git/refs.
> >
> 
> Yes, but I understood him to mean "it's a tree-sha" instead of a 
> branch/head thing, which would mean it doesn't fit the .git/refs 
> definition of ref.

Sorry for the late response to this but I've been busy with real
work for the past few days and have not been able to get around to
fun work. :-)


Yes, its a tree-sha.  There's no point in generating a commit for
this tree as it is serving a purpose similar to the index in core
GIT.  It is a tree which represents the current directory state,
or something recently near to it anyway.  Not enough information
exists to warrant building a commit however, nor is there really
any suitable parent for such a commit.  Ditto with a tag.

I'm planning on periodically performing a write-tree of the current
working directory whenever Eclipse has notified the team provider of
tracked resources being modified, with the write-tree occuring no
more frequently then a user set threshold, or whenever the project
is closed or the workbench is shutdown.

I figure that if the user hasn't re-modified an already "known to
be changed" (due to different stat data) file in the last 5 minutes
and we haven't written a tree out (for any reason) in the last 15
minutes then maybe we should generate a tree right now as the user
is likely to commit one soon.  Generating a tree in the background
on a low priority thread while the user is busy thinking will make
commits "go faster", especially if all I need to do is generate the
commit object itself as the tree is already made.  :-)

It also just makes things easier, as I need the diff-tree code
anyway so making use of that to also track the working directory
just seems to make sense.

I want it under .git/refs as I don't really want my in progress
tree to go away due to a prune issued by the user.  At least not
until I have a different tree stored there anyway.


So I'm going to store them under .git/refs/eclipse/some-path.

-- 
Shawn.
