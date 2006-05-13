From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Tracking branch history
Date: Fri, 12 May 2006 23:40:51 -0400
Message-ID: <20060513034051.GA21586@spearce.org>
References: <Pine.LNX.4.64.0605121838490.6713@iabervon.org> <Pine.LNX.4.64.0605121640210.3866@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 13 05:41:06 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fel03-00042P-2f
	for gcvg-git@gmane.org; Sat, 13 May 2006 05:41:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751137AbWEMDk6 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 12 May 2006 23:40:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751141AbWEMDk6
	(ORCPT <rfc822;git-outgoing>); Fri, 12 May 2006 23:40:58 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:39325 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1751137AbWEMDk6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 May 2006 23:40:58 -0400
Received: from cpe-72-226-60-173.nycap.res.rr.com ([72.226.60.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1Fekzh-000400-LH; Fri, 12 May 2006 23:40:41 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id E196820FB12; Fri, 12 May 2006 23:40:51 -0400 (EDT)
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0605121640210.3866@g5.osdl.org>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19923>

Linus Torvalds <torvalds@osdl.org> wrote:
> 
> On Fri, 12 May 2006, Daniel Barkalow wrote:
> >
> > One feature that might make git more intuitive to people is if we were to 
> > additionally track the history of what commit was the head of each branch 
> > over time. This is only vaguely related to the history of the content, but 
> > it's well-defined and sometimes significant.
> > 
> > E.g., if you know that two weeks ago, what you had worked, but it doesn't 
> > work now, you can use git-bisect to figure out what happened, but first 
> > you have to figure out what commit it was that you were using two weeks 
> > ago. Two weeks ago, we had that information, but we didn't keep it.
> 
> Note that this is possible, but it must be done literally as a separate 
> history from the commit history. 
> 
> IOW, a good (?) way to do it is to literally have a commit hook that 
> basically just does
> 
> 	echo $new >> .git/$branch-commit-history
> 
> possibly together with a datestamp thing (ie it could be something like
> "echo $new "$USER" $(date)" rather than just the commit SHA1).

Why not intergrate this into git-update-ref.  Almost every tool which
deals with a GIT repository (aside from my pure-Java Eclipse plugin
which is still a major work-in-process) performs ref changes through
git-udpate-ref.  So just have it append the ref's history to a file:

	.git/log/refs/heads/$branch

where the history records are stored as:

	40 byte commit-ish SHA1
	<SP>
	<committer>
	<LF>

e.g.:

	cbb6d91d95e523c2b6a6b52577c4be28d18ace83 Shawn O. Pearce <spearce@spearce.org> 1137039378 -0500
	ae8c74e96a1e02bbfb7f1a9669b77d6f8ee6c3cf Shawn O. Pearce <spearce@spearce.org> 1136921470 -0500

Of course a major issue here is locking the log file during the ref
update, but it looks like it might just be safe to append the entry
to the log file right after the re_verify and before the rename.

I wouldn't have git-update-ref create the log file. I'd would only
have it append if the log already exists.

Hmm, this actually looks like it would be really easy.  Maybe I'll
hack up an RFC patch this evening after dinner.

-- 
Shawn.
