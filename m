From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH] git-submodule: Instead of using only annotated tags, use any tag found in .git/refs/tags
Date: Thu, 28 Jun 2007 01:27:54 -0400
Message-ID: <20070628052754.GJ32223@spearce.org>
References: <11829012583562-git-send-email-Emilian.Medve@Freescale.com> <7vabulrki3.fsf@assigned-by-dhcp.pobox.com> <598D5675D34BE349929AF5EDE9B03E27011CFD8F@az33exm24.fsl.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Medve Emilian-EMMEDVE1 <Emilian.Medve@freescale.com>
X-From: git-owner@vger.kernel.org Thu Jun 28 07:28:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I3mY6-0002Sz-7d
	for gcvg-git@gmane.org; Thu, 28 Jun 2007 07:28:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755981AbXF1F17 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 28 Jun 2007 01:27:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755779AbXF1F17
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Jun 2007 01:27:59 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:55970 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755669AbXF1F16 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jun 2007 01:27:58 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1I3mXr-00012i-Qg; Thu, 28 Jun 2007 01:27:56 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id ACBEE20FBAE; Thu, 28 Jun 2007 01:27:54 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <598D5675D34BE349929AF5EDE9B03E27011CFD8F@az33exm24.fsl.freescale.net>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51082>

Medve Emilian-EMMEDVE1 <Emilian.Medve@freescale.com> wrote:
> While playing with git-describe I noticed that the --all option is maybe
> not trying first to find a tag as the man page suggests but it goes
> directly for .git/refs. Here is some output from my git repo clone with
> yesterday's head on the master branch:
> 
> $ git-describe aeb59328453cd4f438345ea79ff04c96bccbbbb8
> v1.5.2.2-549-gaeb5932
> 
> $ git-describe --all aeb59328453cd4f438345ea79ff04c96bccbbbb8
> heads/master

Yea.  Look at what's happening.  In the --all case we attach
heads/master into the ->util field of aeb5's struct commit*.
Since no annotated tag (a ref with prio 2) and no lightweight tag
(a ref with prio 1) was found pointing at aeb5 we kept that ->util
field pointing at the heads/master ref (which has prio 0).

The --all and --tags options are about selecting what refs can
appear in that ->util field.  That's _all_ they do.

Later in describe() at l.151 we immediately display a ref if there
is one in the ->util field:

    150     n = cmit->util;
    151     if (n) {
    152         printf("%s\n", n->path);
    153         return;
    154     }

So we're favoring a ref that points directly at a commit over any
other ref.  We only search if we don't have a ref pointing directly
at the input commit.  Searching is when ranking really gets involved.

> Do you think we want to fix that? If yes, I could look into it and
> submit a patch.

I'm not sure.  If we "fixed" this then --all would only ever turn
up a head if no annotated tag exists on the entire history of that
input commit.  Because the "fix" would be to actually not return
right away here at l.151, but instead to drop down further into the
slower loop where we traverse through commits, pick our candidates,
rank them, and then pick the highest priorty ref that is also
the closest.  The annotated tag would always win over the head.

At which point --all is only ever useful if the repository *never*
had an annotated tag along the input branch.  I'm not sure that's
useful as a description for a commit.  If no annotated tag exists
the raw commit SHA-1 is probably a better description.  Its at
least stable with time.  ;-)


In my opinion, git-describe is doing *exactly* what the manual page
says it does.  But both the current implementation and the manual
page were last majorly overhauld by me.  So take my comments about
the documentation with a grain of salt.  ;-)

-- 
Shawn.
