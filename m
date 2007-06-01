From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] Introduce git version --list-features for porcelain use
Date: Thu, 31 May 2007 23:09:59 -0400
Message-ID: <20070601030959.GY7044@spearce.org>
References: <Pine.LNX.4.64.0705301333410.4011@racer.site> <20070531002030.GA15714@spearce.org> <7vk5uo1rpr.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Alex Riesen <raa.lkml@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Fri Jun 01 05:10:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HtxWn-0007KA-2I
	for gcvg-git@gmane.org; Fri, 01 Jun 2007 05:10:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752305AbXFADKH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 31 May 2007 23:10:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752552AbXFADKH
	(ORCPT <rfc822;git-outgoing>); Thu, 31 May 2007 23:10:07 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:56315 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752305AbXFADKF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 May 2007 23:10:05 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HtxWP-0001YJ-L1; Thu, 31 May 2007 23:09:49 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 1BF7920FBAE; Thu, 31 May 2007 23:09:59 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <7vk5uo1rpr.fsf@assigned-by-dhcp.cox.net>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48839>

Junio C Hamano <junkio@cox.net> wrote:
> "Shawn O. Pearce" <spearce@spearce.org> writes:
> 
> > As a porcelain author I'm finding it difficult to keep track of
> > what features I can use in git-gui.  Newer versions of Git have
> > newer capabilities but they don't always immediately get newer
> > version numbers that I can easily test for.
> >
> > This is a simple plumbing option that lets a porcelain ask the
> > plumbing for its capabilities, at which point the porcelain can
> > work around anything missing, or recommend to the user that they
> > upgrade their plumbing layer.
> >
> > Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
> > ---
> >
> > 	Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> > 	>
> > 	> On Wed, 30 May 2007, Alex Riesen wrote:
> > 	>
> > 	> > git-version --features?
> > 	>
> > 	> Melikes.
> >
> > 	Good?
> 
> Hmmm.  I am not sure if you want list-features in the features
> list -- how are you going to test for it?

Yes, its a recursive definition.  But its also a feature that won't
ever be removed; if list-features is here then the list-features
feature is also here.  Makes the test in t0000 a lot easier, and
its not a huge deal to say "yes, the feature that i implement is
here too".  ;-)
 
> Also I still do not understand why you want redirect-stderr.
> Are you writing for a shell-less environment?

The redirect-stderr thing grew out of the MinGW port camp.
Apparently they cannot use (or its hard to use) an important little
tool called `cat` over there.

Why cat?  Tcl is so horribly broken that to get data for both stdout
and stderr through a pipe I have to do something sick like:

	git fetch 2>&1 | cat

because in Tcl its actually:

	set rdr [open "| git fetch |& cat" r]

The |& means 2>&1| in normal shell.  But that means I have to have
a process after it to receive the data.  Normally that's cat.
But MinGW doesn't have cat.  (Nor do they have dog, but neither
does Linux...).  So I need a way to redirect output.

Dscho's patch to git.c to give me `git --redirect-stderr` is quite
simple, and makes my life in git-gui easier.  I can just require
that to use git-gui on MinGW you must have the 'redirect-stderr'
feature supported in your plumbing layer.  On non-MinGW systems I
can fallback to "&| cat" if its not supported.

-- 
Shawn.
