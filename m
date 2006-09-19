From: Shawn Pearce <spearce@spearce.org>
Subject: Re: Subversion-style incrementing revision numbers
Date: Tue, 19 Sep 2006 18:39:05 -0400
Message-ID: <20060919223905.GE11601@spearce.org>
References: <Pine.LNX.4.62.0609191309140.9752@joeldicepc.ecovate.com> <20060919211844.GB8259@pasky.or.cz> <Pine.LNX.4.62.0609191525490.9752@joeldicepc.ecovate.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@suse.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Sep 20 00:39:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GPoFJ-0000Px-U1
	for gcvg-git@gmane.org; Wed, 20 Sep 2006 00:39:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751367AbWISWjP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 19 Sep 2006 18:39:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751967AbWISWjP
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Sep 2006 18:39:15 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:60104 "EHLO
	corvette.plexpod.net") by vger.kernel.org with ESMTP
	id S1751367AbWISWjO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Sep 2006 18:39:14 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.52)
	id 1GPoF0-0000Jg-LD; Tue, 19 Sep 2006 18:38:58 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 9A7DC20E48E; Tue, 19 Sep 2006 18:39:05 -0400 (EDT)
To: Joel Dice <dicej@mailsnare.net>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0609191525490.9752@joeldicepc.ecovate.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/27306>

Joel Dice <dicej@mailsnare.net> wrote:
> I'm not too worried about cg-admin-uncommit or git-reset, since the IRN 
> feature is intended mainly for shared repositories.  I would suggest that 
> such commands simply be disallowed for such repositories.
> 
> The problem of temporary commits certainly needs to be addressed.  In this 
> case, may I assume nothing under $GIT_DIR/refs is ever modified?  If so, 
> perhaps I could somehow hook into the git-update-ref step.  Is that what 
> the revlog code does?

$GIT_DIR/refs is always modified.  Its probably the most heavily
modified part of a GIT_DIR, aside from the index.  Simply because
the ref files must be modified every time a commit, fetch or merge
completes.  Its also a directory you don't want to delete; I once
did an `rm -rf .git/refs` in a repository with a many branches.
That was no fun to recover.

git-update-ref is used by pretty much all non-C code to update a
ref file.  The APIs it calls invoke the reflog code to record the
update being made to the ref if the user has enabled logging on
that ref (not all users want all refs logged apparently).  I don't
think its a great idea to plug more complex logic into that part
of the system.  The reflog code already made it more complex then
it needed to be; Linus apparently just found out how heavily we
use static buffers down there...

-- 
Shawn.
