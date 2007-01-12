From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: What's cooking in git.git (topics)
Date: Thu, 11 Jan 2007 19:49:27 -0500
Message-ID: <20070112004927.GB23864@spearce.org>
References: <7vr6u3cmsi.fsf@assigned-by-dhcp.cox.net> <7v3b6i75i5.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0701102241230.4964@xanadu.home> <20070111080035.GA28222@spearce.org> <45A6016B.4030800@op5.se> <Pine.LNX.4.64.0701110955100.4964@xanadu.home> <45A65F15.6040606@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nicolas Pitre <nico@cam.org>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 12 01:49:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H5Ac0-0000rn-46
	for gcvg-git@gmane.org; Fri, 12 Jan 2007 01:49:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751549AbXALAth (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 11 Jan 2007 19:49:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751556AbXALAth
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Jan 2007 19:49:37 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:42336 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751549AbXALAtg (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jan 2007 19:49:36 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1H5Abn-0006td-Au; Thu, 11 Jan 2007 19:49:27 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id A9C7D20FBAE; Thu, 11 Jan 2007 19:49:27 -0500 (EST)
To: Andreas Ericsson <ae@op5.se>
Content-Disposition: inline
In-Reply-To: <45A65F15.6040606@op5.se>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36645>

Andreas Ericsson <ae@op5.se> wrote:
> Output latency will grow with number of tags though, won't it? I was 
> thinking of the repo which users had reported problems fetching tags 
> from, as there was more than 2k tags. If my memory serves me correctly, 
> this report led to the packed-refs stuff.

Only on tags which are considered possible matches.  What we do
now is we walk back along the commit history until we find a commit
which has a tag pointing at it.  As soon as we find that commit we
enqueue its corresponding tag into a list and completely ignore its
parents, aborting listing any further back.  So we really only pay
the bare minimum price here.

Unfortunately the tag matching is O(n*m*q) where:

  n == number of tags,
  m == number of commits we have to walk back before we find a tag,
  q == number of possible tags that will match for this lineage.

Storing the tags in a hash structure would accelerate this matching,
especially for high values of n.  m and q we cannot do anything
about, except to recommend to projects that they tag more than
often then never.

> Unless there's some bogosity going on that leads to it finding the 14 
> tags in the above case.

Yea, its a bogosity in the way the branches are merged together.
I haven't dug into what is causing this specifically in git.git
but I know the code is doing the best it can to select the smallest
set of possible matches.

There is however a better algorithm for the revision list generation;
I think I can fold it into the main walkback loop and still get the
right result.  I have to read a stack of papers tonight but I'll
see if I can try to code up the algorithm.  It would accelerate
git-describe right back to where it was before my change.

-- 
Shawn.
