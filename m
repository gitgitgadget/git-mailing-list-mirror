From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] checkout: allow full refnames for local branches
Date: Wed, 9 May 2007 14:54:40 -0400
Message-ID: <20070509185440.GB3141@spearce.org>
References: <11787000032830-git-send-email-hjemli@gmail.com> <7v7iriwfeu.fsf@assigned-by-dhcp.cox.net> <8c5c35580705090207y2979aaa5u7ce9de5fa1dfe658@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Lars Hjemli <hjemli@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 09 20:54:56 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HlrJL-0002PO-6L
	for gcvg-git@gmane.org; Wed, 09 May 2007 20:54:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756273AbXEISyq (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 9 May 2007 14:54:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756873AbXEISyq
	(ORCPT <rfc822;git-outgoing>); Wed, 9 May 2007 14:54:46 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:59037 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756273AbXEISyp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 May 2007 14:54:45 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HlrJ4-0004Y2-O0; Wed, 09 May 2007 14:54:34 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id E305920FBAE; Wed,  9 May 2007 14:54:40 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <8c5c35580705090207y2979aaa5u7ce9de5fa1dfe658@mail.gmail.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/46767>

Lars Hjemli <hjemli@gmail.com> wrote:
> I'm playing around with a gui frontend, and there I use
> git-for-each-ref to obtain possible arguments for git-checkout. That's
> how I discovered the 'problem', and solved it by stripping
> 'refs/heads/' in my frontend. But then I thought it would be nice if
> 'git-checkout' did the stripping on my behalf, since this might bite
> others too :)

If you are building "porcelain" to sit over Git and offer up a pretty
view of things, I would encourage you to avoid the stock porcelain.
Don't use git-checkout, its stock porcelain.  Instead go right to
the plumbing.  The plumbing doesn't really change behavior as often
(if ever).

You can see in git-checkout.sh what actions you need to perform,
but its really quite simple if there's no file-level merge involved.
Here's the relevent bits from git-gui:

    set cmd [list git read-tree]
    lappend cmd -m
    lappend cmd -u
    lappend cmd --exclude-per-directory=.gitignore
    lappend cmd $HEAD
    lappend cmd $new_branch
    set fd_rt [open "| $cmd" r]
    fconfigure $fd_rt -blocking 0 -translation binary
    fileevent $fd_rt readable \
        [list switch_branch_readtree_wait $fd_rt $new_branch]

    ...
    git symbolic-ref HEAD "refs/heads/$new_branch"

Really all I'm doing is building up an argument list for git
read-tree, passing it the commit that is currently in HEAD and the
commit I want to switch to ($new_branch), and then I wait for it
to finish its job.  When its done, I run git symbolic-ref to update
the current branch name.

-- 
Shawn.
