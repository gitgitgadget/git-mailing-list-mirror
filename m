From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: When to repack?
Date: Wed, 31 Jan 2007 10:36:47 -0500
Message-ID: <20070131153647.GA21888@spearce.org>
References: <17856.37016.341839.397309@lisa.zopyra.com> <45C09335.6010601@op5.se> <Pine.LNX.4.63.0701311617360.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andreas Ericsson <ae@op5.se>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Bill Lear <rael@zopyra.com>
X-From: git-owner@vger.kernel.org Wed Jan 31 16:40:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HCHW8-0003ia-NJ
	for gcvg-git@gmane.org; Wed, 31 Jan 2007 16:37:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932852AbXAaPgz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 31 Jan 2007 10:36:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932857AbXAaPgz
	(ORCPT <rfc822;git-outgoing>); Wed, 31 Jan 2007 10:36:55 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:52057 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932852AbXAaPgy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Jan 2007 10:36:54 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HCHVr-0002hQ-Lu; Wed, 31 Jan 2007 10:36:43 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 5517120FBAE; Wed, 31 Jan 2007 10:36:47 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.63.0701311617360.22628@wbgn013.biozentrum.uni-wuerzburg.de>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38260>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> On Wed, 31 Jan 2007, Andreas Ericsson wrote:
> > Bill Lear wrote:
> > > We have a company repo used by many people throughout the day.  When/how
> > > can I repack this?  I have come to adopt this approach:
> 
> AFAIR this case is handled gracefully by git. If the object it is still 
> accessing moves to a(nother) pack, git will still find it.

No AFAIR, its definately true.  `git gc` is completely safe on a
live repository.  Run it at will.  Toss it in a cronjob.  Whatever.

What is *not* safe is `git gc --prune`.  Don't run that on an
active repository.
 
> > On a side-note, this is a grade A example of something that should 
> > typically be done sunday night at 4am.

Possibly.  Almost doesn't matter when you run it, except on very huge
repositories where the repack would take more than a few minutes.

Really, just toss something like the following in a cronjob that
runs once a week:

	#!/bin/sh
	for g in /path/to/gits/*.git
	do
	  git --git-dir="$g" gc
	done

If you want to get fancy, use the output of `git count-objects -v`:

	count: 325
	size: 2332
	in-pack: 40894
	packs: 1
	prune-packable: 0
	garbage: 0

I look for a count over 2000 or packs over 5.  If either is true,
I run gc, otherwise I skip that repository and leave it alone
that week.  And that's actually packing more frequently than I
really need to.  On any UNIX system you can probably let those go
to >5,000 or 20 and still not really see a performance problem.

In general, repacks and network transfers (or basically any
operation) takes longer as the number of loose objects increases
(that's the count field in `git count-objects -v`).  Keep below
~2000 and `git gc` times tend to be measured in just a minute or
two for even 200 MiB repositories.

-- 
Shawn.
