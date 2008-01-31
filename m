From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: simple cvs-like git wrapper
Date: Thu, 31 Jan 2008 01:01:37 -0500
Message-ID: <20080131060136.GZ24004@spearce.org>
References: <20080129204048.GA9612@venus> <m3hcgw8dz7.fsf@localhost.localdomain> <20080130021050.GB9612@venus> <20080130040002.GM24004@spearce.org> <20080130225254.GC9612@venus> <20080131040839.GW24004@spearce.org> <20080131054124.GG9612@venus>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: "Ed S. Peschko" <esp5@pge.com>
X-From: git-owner@vger.kernel.org Thu Jan 31 07:02:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JKSV4-0007lz-9I
	for gcvg-git-2@gmane.org; Thu, 31 Jan 2008 07:02:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751648AbYAaGBn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Jan 2008 01:01:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751448AbYAaGBn
	(ORCPT <rfc822;git-outgoing>); Thu, 31 Jan 2008 01:01:43 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:53785 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751506AbYAaGBm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Jan 2008 01:01:42 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1JKSUU-0004pF-QZ; Thu, 31 Jan 2008 01:01:38 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id AAF5120FBAE; Thu, 31 Jan 2008 01:01:37 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <20080131054124.GG9612@venus>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72103>

"Ed S. Peschko" <esp5@pge.com> wrote:
> > This is going to be slow as you are running git-merge for each
> > and every branch available to you.  You can do a lot better by
> > loading the branch DAG into memory in Perl/C/Python and doing a
> > graph coloring algorithm to see if a merge is necessary or not,
> > as if you are merging everything all of the time almost everything
> > is going to be always merged to everything else.  Which as I said
> > earlier is nuts.
> 
> hmm. Is there a simple method to get this graph? I'm assuming that you
> would have to get all the local commits and compare them to the remote
> commits, and only merge the branches that have commits not yet 
> merged..

Something along these lines:

	%remotes = \
		git for-each-ref \
		--format='%(objname) %(refname)' \
		refs/remotes/origin;

	@lines = \
		git rev-list \
		keys %remotes \
		--not HEAD

	foreach $line in @lines {
		if $remotes contains $line
			git merge $remotes{$line}
	}

That gets you the graph.  The %(objname) string coming back from
for-each-ref is in $line in the loop.  If you see $line inside that
map you built from for-each-ref then that commit isn't yet in the
current branch.  So you'd then want to merge that commit.

-- 
Shawn.
