From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: Why is "git tag --contains" so slow?
Date: Thu, 08 Jul 2010 15:06:34 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1007081443040.6020@xanadu.home>
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
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Jeff King <peff@peff.net>, Will Palmer <wmpalmer@gmail.com>,
	Avery Pennarun <apenwarr@gmail.com>, git@vger.kernel.org
To: Theodore Tso <tytso@MIT.EDU>
X-From: git-owner@vger.kernel.org Thu Jul 08 21:06:42 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OWwQj-0003eG-L4
	for gcvg-git-2@lo.gmane.org; Thu, 08 Jul 2010 21:06:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757348Ab0GHTGg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Jul 2010 15:06:36 -0400
Received: from relais.videotron.ca ([24.201.245.36]:17404 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756682Ab0GHTGf (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Jul 2010 15:06:35 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0L590012H6EY7D60@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 08 Jul 2010 15:06:35 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <11D5771D-EB47-42E9-BCC3-69C8FE1999EC@MIT.EDU>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/150598>

On Thu, 8 Jul 2010, Theodore Tso wrote:

> 
> On Jul 7, 2010, at 1:45 PM, Jeff King wrote:
> 
> >     And of course it's just complex, and I tend to shy away from
> >     complexity when I can. The question to me comes back to (1) above.
> >     Is massive clock skew a breakage that should produce a few
> >     incorrect results, or is it something we should always handle?
> 
> Going back to the question that kicked off this thread, I wonder if there
> is some way that cacheing could be used to speed up the all cases,
> or at lest the edge cases, without imposing as much latency as tracking
> the max skew?   i.e., some thing like gitk's gitk.cache file.  For bonus
> points, it could be a cache file that is used by both gitk and git tag
> --contains, git branch --contains, and git name-rev.
> 
> Does that sound like reasonable idea?

I don't think any caching would be as good as fixing the fundamental 
issue.

Git is fast, sure.  But it could be way faster yet in its graph 
traversal.  And my pack v4 format is meant to overcome all those 
obstacles that Git currently has to work through in order to walk its 
commit graph.  Once one realize that most of the commit object headers 
are SHA1 reference which need no be compressed with zlib as it is done 
now, and that the author and committer info can be factored out in a 
dictionary table, and that even those SHA1 references can be substituted 
with an index value into the pack index file (a bit like the OFS variant 
of the delta object), meaning that even the object lookup could be 
bypassed, then it would be possible to make graph traversal a magnitude 
cheaper in terms of computing cycles and memory touched.

The pack format v4 has been brewing in my head for... well... years now.  
And that is good because I've improved on the original v4 design even 
more since then. And I even found some time to write more code lately.  
I have the new object encoding code almost working for trees and 
commits.  My Git hacking time is still limited so this is progressing 
slowly though.

Just to say that I don't think any kind of caching might be necessary in 
the end, as it is possible to encode object data in a pack in a way that 
ought to be about as fast to access as a separate cache would.  So if 
someone is pondering about working on a cache layer, then I'd have one 
alternate suggestion or two for that person.  ;-)


Nicolas
