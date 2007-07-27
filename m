From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: incremental fast-import
Date: Thu, 26 Jul 2007 20:51:03 -0400
Message-ID: <20070727005103.GC20052@spearce.org>
References: <Pine.LNX.4.64.0707262242460.14017@beast.quantumfyre.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Julian Phillips <julian@quantumfyre.co.uk>
X-From: git-owner@vger.kernel.org Fri Jul 27 02:51:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IEE2z-0007GY-Pf
	for gcvg-git@gmane.org; Fri, 27 Jul 2007 02:51:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757734AbXG0AvK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 26 Jul 2007 20:51:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756658AbXG0AvI
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jul 2007 20:51:08 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:46289 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756534AbXG0AvH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jul 2007 20:51:07 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1IEE2h-0005ur-3E; Thu, 26 Jul 2007 20:50:55 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id C2EF520FBAE; Thu, 26 Jul 2007 20:51:03 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0707262242460.14017@beast.quantumfyre.co.uk>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53876>

Julian Phillips <julian@quantumfyre.co.uk> wrote:
> I seem to be missing something though.  I can't seem to get it to work 
> when run in an incremental manner.
> 
> I have a saved stream of fast-import commands.  Every time I run this 
> through fast import I get the exact same marks file out.  This is good.
> 
> However if I feed it in in two chunks, then nearly all of the SHA1s 
> generated in the second run are different to those produced in a single 
> pass.  In addition I get a pair of "warning: Not updating 
> refs/heads/BUG_101_BRANCH (new tip <some sha1> does not contain <other 
> sha1>)" messages.  This is not so good.
> 
> I'm using the --import-marks and --export-marks options.  Is there 
> something else I need to do to be able to run fast-import in an 
> incremental manner?

I'm guessing you didn't restart the branches at the start of the
second import.  You need to do something like this to get the import
going again:

  commit refs/heads/BUG_101_BRANCH
  from refs/heads/BUG_101_BRANCH^0
  ...

or because you imported the marks you can use a mark:

  commit refs/heads/BUG_101_BRANCH
  from :18981
  ...

where 18981 was the last revision on BUG_101_BRANCH that the frontend
had imported during the last run.


fast-import doesn't assume the local branches already exist.
It actually assumes its importing from scratch every time.  The
frontend tool needs to restart the branch if that is what it wants.

In other words, by splitting the file in half you actually also
split the history in half, and got two root commits, one of which
was in the middle of your history.  :-(

-- 
Shawn.
