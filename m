From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [RFC] Packing large repositories
Date: Tue, 3 Apr 2007 01:39:59 -0400
Message-ID: <20070403053959.GH15922@spearce.org>
References: <56b7f5510703280005o7998d65pcbcd4636b46d8d23@mail.gmail.com> <Pine.LNX.4.64.0703280943450.6730@woody.linux-foundation.org> <20070330062324.GU13247@spearce.org> <alpine.LFD.0.83.0703300851270.3041@xanadu.home> <78639417-ACDB-484F-85BB-EC0AF694949A@adacore.com> <Pine.LNX.4.64.0703311033290.6730@woody.linux-foundation.org> <64E16DEF-E572-4384-9E68-42EBBCE678B1@adacore.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Nicolas Pitre <nico@cam.org>, Dana How <danahow@gmail.com>,
	git@vger.kernel.org
To: Geert Bosch <bosch@adacore.com>
X-From: git-owner@vger.kernel.org Tue Apr 03 07:40:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HYbkr-0001R5-GD
	for gcvg-git@gmane.org; Tue, 03 Apr 2007 07:40:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752962AbXDCFkT (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 3 Apr 2007 01:40:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752991AbXDCFkT
	(ORCPT <rfc822;git-outgoing>); Tue, 3 Apr 2007 01:40:19 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:51840 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752962AbXDCFkS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Apr 2007 01:40:18 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HYbkP-0006uW-0h; Tue, 03 Apr 2007 01:40:01 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 9673E20FBAE; Tue,  3 Apr 2007 01:39:59 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <64E16DEF-E572-4384-9E68-42EBBCE678B1@adacore.com>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43615>

Geert Bosch <bosch@adacore.com> wrote:
> Actually, I had implemented this first, using two newton-raphson
> iterations and then binary search. With just one iteration is
> too little, and one iteration+binary search often is no win.
> Two iterations followed by binary search cuts the nr of steps in
> half for the Linux kernel. Two iterations followed by linear search
> is often worse, because of "unlucky" cases that end up doing many
> probes. Still, during the 5-8 probes in moderately large repositories
> (1M objects), each probe pretty much requires its own cache line:
> very cache unfriendly.

If Nico and I can ever find the time to get our ideas for pack v4
coded into something executable, I think you will find this is less
of an issue than you think.

We're hoping to change enough of the commit and tree traversal
code that the "tight" loops around chasing tree, parent, and blob
pointers can be done using strictly pack offsets and completely
avoid these SHA-1 lookups.  Thus the only time we'd fall into the
above-mentioned SHA-1 lookup path is on initial entry to a revision
walk, or when spanning to another packfile.  This would mean most
workloads should only hit that code once per command line argument.

-- 
Shawn.
