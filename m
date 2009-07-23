From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Performance issue of 'git branch'
Date: Wed, 22 Jul 2009 20:21:01 -0700 (PDT)
Message-ID: <alpine.LFD.2.01.0907222009340.21520@localhost.localdomain>
References: <20090722235914.GA13150@Pilar.aei.mpg.de> <alpine.LFD.2.01.0907221714300.3352@localhost.localdomain> <20090723012207.GA9368@Pilar.aei.mpg.de> <alpine.LFD.2.01.0907221850000.3352@localhost.localdomain> <alpine.LFD.2.01.0907221921570.3352@localhost.localdomain>
 <alpine.LFD.2.01.0907221959330.21520@localhost.localdomain>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: "Carlos R. Mafra" <crmafra2@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 23 05:21:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MTorq-0004Zo-HW
	for gcvg-git-2@gmane.org; Thu, 23 Jul 2009 05:21:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752966AbZGWDVH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Jul 2009 23:21:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751695AbZGWDVH
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Jul 2009 23:21:07 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:37088 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752746AbZGWDVG (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Jul 2009 23:21:06 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id n6N3L1jf002920
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 22 Jul 2009 20:21:02 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id n6N3L1ts002659;
	Wed, 22 Jul 2009 20:21:01 -0700
X-X-Sender: torvalds@localhost.localdomain
In-Reply-To: <alpine.LFD.2.01.0907221959330.21520@localhost.localdomain>
User-Agent: Alpine 2.01 (LFD 1184 2008-12-16)
X-Spam-Status: No, hits=-3.461 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123828>



On Wed, 22 Jul 2009, Linus Torvalds wrote:
> 
> The GIT_DEBUG_LOOKUP debug output probably does match the number of 
> cold-cache IO's fairly well for something like this (at least to a first 
> approximation), so I really hope my patch will fix your problem.

Side note: the object lookup binary search we do is simple and reasonably 
efficient, but it is _not_ very cache-friendly (where "cache-friendly" 
also in this case means IO caches).

There are more cache-friendly ways of searching, although the really 
clever ones would require us to switch the format of the pack-file index 
around. Which would be a fairly big pain (in addition to making the lookup 
a lot more complex).

The _simpler_ cache-friendly alternative is likely to try the "guess 
location by assuming the SHA1's are evenly spread out" thing doesn't jump 
back-and-forth like a binary search does.

We tried it a few years ago, but didn't do cold-cache numbers. And 
repositories were smaller too.

With something like the kernel repo, with 1.2+ million objects, a binary 
search needs about 21 comparisons for each object we look up. The index 
has a first-level fan-out of 256, so that takes away 8 of them, but we're 
still talking about 13 comparisons. With bad locality except for the very 
last ones.

Assuming a 4kB page-size, and about 170 index entries per page (~7 binary 
search levels), that's 6 pages we have to page-fault in for each search. 
And we probably won't start seeing lots of cache reuse until we hit 
hundreds or thousands of objects searched for.

With soemthing like "three iterations of newton-raphson + linear search", 
we might end up with more index entries looked at, but we'd quite possibly 
get much better locality.

I suspect the old newton-raphson patches we had (Discussions and patches 
back in April 2007 on this list) could be resurrected pretty easily.

		Linus
