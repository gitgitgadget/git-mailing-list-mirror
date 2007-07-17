From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Tips for debugging fast-import front-ends
Date: Mon, 16 Jul 2007 23:27:07 -0400
Message-ID: <20070717032707.GJ32566@spearce.org>
References: <Pine.LNX.4.64.0707161336570.24955@reaper.quantumfyre.co.uk> <469B736F.12FA24EA@eudaptics.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Julian Phillips <julian@quantumfyre.co.uk>
To: Johannes Sixt <J.Sixt@eudaptics.com>
X-From: git-owner@vger.kernel.org Tue Jul 17 05:27:24 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IAdiY-0002N5-Fe
	for gcvg-git@gmane.org; Tue, 17 Jul 2007 05:27:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756735AbXGQD1O (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 16 Jul 2007 23:27:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755204AbXGQD1O
	(ORCPT <rfc822;git-outgoing>); Mon, 16 Jul 2007 23:27:14 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:60331 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753444AbXGQD1N (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Jul 2007 23:27:13 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1IAdiD-0005mA-AG; Mon, 16 Jul 2007 23:26:57 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 8607220FBAE; Mon, 16 Jul 2007 23:27:07 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <469B736F.12FA24EA@eudaptics.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52736>

Johannes Sixt <J.Sixt@eudaptics.com> wrote:
> Julian Phillips wrote:
> > At some point in the "messy" phase I get an error from fast-import saying:
> > 
> > fatal: path foo not in branch
> > 
> > This seems to happen when I attempt to copy a file that is also changed in
> > the same commit.  What I would like to do is find out what things look
> > like just before that point - the problem is that fast-import seems to not
> > create anything on failure.  So, apart restarting the import and stopping
> > just before the broken commit, is there any way to find out what
> > fast-import thinks the branch looks like?
> 
> Redirect the input stream to a file instead of to fast-import, then feed
> fast-import from this file. This way you can reproduce the failure more
> quickly. Also, you can run fast-import from a debugger.

I tend to dump my test stream to a file, then process that through
fast-import.  Running fast-import in the debugger is uh, ugly, as
I make heavy use of FLEX_ARRAY whenever there is interesting data.
So simple printing of any useful data (like the name of a tree
entry) is not so simple without doing pointer addition and type
casting in gdb.  Sometimes I just break down and add a few targeted
printf()'s to the code.  That always tells me what's up.

One easy thing that you can do is add a 'checkpoint' command
right before the bad commit (assuming you know roughly where it is
breaking).  This will cause fast-import to flush all of its buffers
back to disk, and update the Git repository, before reading the
next command.  The result is that when you crash you have everything
that fast-import processed right up to that last checkpoint.

Clearly doing too many checkpoints is going to remove the fast part
of fast-import, but at least you have a -import.  ;-)


After reading this thread I have decided to add some frontend
debugging support into fast-import, like dumping out the most
recently received commands and the current branch and tree state
before it die()'s with a protocol error or bad path error, and maybe
also try to do a partial checkpoint (close out the packfile, don't
update refs or marks, but instead write them to the state dump file).
This way the frontend developer can inspect the overall state and
better understand what might have gone wrong.

Unfortunately I won't get it done in the next few days, but maybe
before the weekend.

-- 
Shawn.
