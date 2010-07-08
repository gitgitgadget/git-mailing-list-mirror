From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: Why is "git tag --contains" so slow?
Date: Thu, 08 Jul 2010 15:29:49 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1007081515030.6020@xanadu.home>
References: <20100701121711.GF1333@thunk.org>
 <20100701150331.GA12851@sigill.intra.peff.net>
 <20100701153842.GA15466@sigill.intra.peff.net>
 <20100702192612.GM1333@thunk.org>
 <20100703080618.GA10483@sigill.intra.peff.net>
 <20100704005543.GB6384@thunk.org>
 <20100705122723.GB21146@sigill.intra.peff.net>
 <20100705141012.GA25518@thunk.org>
 <20100706115826.GA15413@sigill.intra.peff.net>
 <1278430303.32094.15.camel@wpalmer.simply-domain>
 <20100707174546.GA4979@coredump.intra.peff.net>
 <11D5771D-EB47-42E9-BCC3-69C8FE1999EC@MIT.EDU>
 <m37hl6mdnb.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Theodore Tso <tytso@MIT.EDU>, Jeff King <peff@peff.net>,
	Will Palmer <wmpalmer@gmail.com>,
	Avery Pennarun <apenwarr@gmail.com>, git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 08 21:30:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWwnQ-0005VH-Ts
	for gcvg-git-2@lo.gmane.org; Thu, 08 Jul 2010 21:30:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758470Ab0GHTaA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Jul 2010 15:30:00 -0400
Received: from relais.videotron.ca ([24.201.245.36]:13045 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757419Ab0GHT37 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jul 2010 15:29:59 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MR-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0L59004IH7HPZAC0@VL-MR-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 08 Jul 2010 15:29:50 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <m37hl6mdnb.fsf@localhost.localdomain>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150601>

On Thu, 8 Jul 2010, Jakub Narebski wrote:

> Theodore Tso <tytso@MIT.EDU> writes:
> > On Jul 7, 2010, at 1:45 PM, Jeff King wrote:
> > 
> > >     And of course it's just complex, and I tend to shy away from
> > >     complexity when I can. The question to me comes back to (1) above.
> > >     Is massive clock skew a breakage that should produce a few
> > >     incorrect results, or is it something we should always handle?
> > 
> > Going back to the question that kicked off this thread, I wonder if there
> > is some way that cacheing could be used to speed up the all cases,
> > or at lest the edge cases, without imposing as much latency as tracking
> > the max skew?   i.e., some thing like gitk's gitk.cache file.  For bonus
> > points, it could be a cache file that is used by both gitk and git tag
> > --contains, git branch --contains, and git name-rev.
> > 
> > Does that sound like reasonable idea?
> 
> By the way, what had happened to the rev-cache project from GSoC 2009?

I think the person who worked on it did so in good faith, and that the 
result is well done.

But I personally cannot convince myself this is fundamentally the right 
solution to the issue.  Maintaining another data structure to work 
around defficiencies in the primary data structure doesn't sound right 
to me.

I might be looking at this from my own perspective as one of the few 
people who hacked extensively on the Git pack format from the very 
beginning.  But I do see a way for the pack format to encode commit and 
tree objects so that walking them would be a simple lookup in the pack 
index file where both the SHA1 and offset in the pack for each parent 
can be immediately retrieved.  Same for tree references.  No deflating 
required, no binary search, just simple dereferences.  And the pack size 
would even shrink as a side effect.


Nicolas
