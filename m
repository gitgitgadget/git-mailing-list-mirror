From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: git gc & deleted branches
Date: Fri, 9 May 2008 20:20:14 -0400
Message-ID: <20080510002014.GH29038@spearce.org>
References: <20080508214454.GA1939@sigill.intra.peff.net> <48237650.5060008@nrlssc.navy.mil> <20080508224827.GA2938@sigill.intra.peff.net> <loom.20080509T011318-478@post.gmane.org> <20080509041921.GA14773@sigill.intra.peff.net> <E1B43061-69C7-43D7-9A57-34B7C55DF345@adacore.com> <48246A44.7020303@nrlssc.navy.mil> <alpine.LFD.1.10.0805091205580.23581@xanadu.home> <7vwsm39kft.fsf@gitster.siamese.dyndns.org> <877ie3yqb3.fsf@jeremyms.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, Nicolas Pitre <nico@cam.org>,
	Brandon Casey <casey@nrlssc.navy.mil>,
	Geert Bosch <bosch@adacore.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Jeremy Maitin-Shepard <jbms@cmu.edu>
X-From: git-owner@vger.kernel.org Sat May 10 02:21:45 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JucqO-0007Nd-OS
	for gcvg-git-2@gmane.org; Sat, 10 May 2008 02:21:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755900AbYEJAUx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 May 2008 20:20:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753782AbYEJAUx
	(ORCPT <rfc822;git-outgoing>); Fri, 9 May 2008 20:20:53 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:44842 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754021AbYEJAUv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 May 2008 20:20:51 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1Jucon-0003na-9l; Fri, 09 May 2008 20:20:05 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 3D5E320FBAE; Fri,  9 May 2008 20:20:14 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <877ie3yqb3.fsf@jeremyms.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/81638>

Jeremy Maitin-Shepard <jbms@cmu.edu> wrote:
> It is extremely cumbersome to have to worry about whether there are
> other concurrent accesses to the repository when running e.g. git gc.
> For servers, you may never be able to guarantee that nothing else is
> accessing the repository concurrently.  Here is a possible solution:
> 
> Each git process creates a log file of the references that it has
> created.  The log file should be named in some way with e.g. the process
> id and start time of the process, and simply consist of a list of
> 20-byte sha1 hashes to be considered additional in-use references for
> the purpose of garbage collection.

I believe we partially considered that in the past and discarded it
as far too complex implementation-wise for the benefit it gives us.

The current approach of leaving unreachable loose objects around
for 2 weeks is good enough.  Any Git process that has been running
for 2 weeks while still not linking everything it needs into the
reachable refs of that repository is already braindamaged and
shouldn't be running anymore.

If we are dealing with a pack file, those are protected by .keep
"lock files" between the time they are created on disk and the
time that the git-fetch or git-receive-pack process has finished
updating the refs to anchor the pack's contents as reachable.
Every once in a while a stale .keep file gets left behind when a
process gets killed by the OS, and its damn annoying to clean up.

I'd hate to clean up logs from every little git-add or git-commit
that aborted in the middle uncleanly.

-- 
Shawn.
