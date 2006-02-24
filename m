From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] diff-delta: produce optimal pack data
Date: Fri, 24 Feb 2006 16:39:42 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0602241613030.31162@localhost.localdomain>
References: <Pine.LNX.4.64.0602212043260.5606@localhost.localdomain>
 <7v4q2pf8fq.fsf@assigned-by-dhcp.cox.net>
 <20060224174422.GA13367@hpsvcnb.fc.hp.com>
 <Pine.LNX.4.64.0602241252300.31162@localhost.localdomain>
 <20060224183554.GA31247@hpsvcnb.fc.hp.com>
 <Pine.LNX.4.64.0602241350190.31162@localhost.localdomain>
 <20060224192354.GC387@hpsvcnb.fc.hp.com>
 <Pine.LNX.4.64.0602241152290.22647@g5.osdl.org>
 <7vpslc8oni.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>,
	Carl Baldwin <cnb@fc.hp.com>
X-From: git-owner@vger.kernel.org Fri Feb 24 22:41:23 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FCkgi-0006gX-Kb
	for gcvg-git@gmane.org; Fri, 24 Feb 2006 22:41:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932582AbWBXVkO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 24 Feb 2006 16:40:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932588AbWBXVkN
	(ORCPT <rfc822;git-outgoing>); Fri, 24 Feb 2006 16:40:13 -0500
Received: from relais.videotron.ca ([24.201.245.36]:15978 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP id S932582AbWBXVkL
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Feb 2006 16:40:11 -0500
Received: from xanadu.home ([24.202.136.67]) by VL-MH-MR001.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0IV700BMIO66TA70@VL-MH-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 24 Feb 2006 16:39:43 -0500 (EST)
In-reply-to: <7vpslc8oni.fsf@assigned-by-dhcp.cox.net>
X-X-Sender: nico@localhost.localdomain
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/16740>

On Fri, 24 Feb 2006, Junio C Hamano wrote:

> I haven't looked at Nico's original or updated code closely at
> all, but two things come to mind.
> 
> (1) if we could tell the particular data is intrinsically
>     diff_delta unfriendly and diff_delta would waste too much
>     time when tried to delta against almost _any_ other blob,
>     then it might help to give an interface in diff-delta.c for
>     the caller to check for such a blob without even trying
>     diff_delta.
> 
> (2) otherwise, if diff_delta could detect it would spend too
>     many cycles to finish its work for a particular input early
>     on, we might want it to bail out instead of trying a
>     complete job.

I have a patch that implements an hybrid approach.

Currently, diff-delta takes blocks of data in the reference file and 
hash them.  When the target file is scanned, it uses the hash to match 
blocks from the target file with the reference file.

If blocks are hashed evenly the cost of  producing a delta is at most 
O(n+m) where n and m are the size of the reference and target files 
respectively.  In other words, with good data set the cost is linear.

But if many blocks from the reference buffer do hash to the same bucket 
then for each block in the target file many blocks from the reference 
buffer have to be tested against, making it tend towards O(n^m) which is 
pretty highly exponential.

The solution I'm investigating is to put a limit on the number of 
entries in the same hash bucket so to bring the cost back to something 
more linear.  That means the delta might miss on better matches that 
have not been hashed but still benefit from a limited set. Experience 
seems to show that the time to deltify the first two blobs you found to 
be problematic can be reduced by 2 orders of magnitude with about only 
10% increase in the resulting delta size, and still nearly 40% smaller 
than what the current delta code produces.

The question is how to determine the best limit on the number of entries 
in the same hash bucket.


Nicolas
