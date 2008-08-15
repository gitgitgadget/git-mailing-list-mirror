From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: pack operation is thrashing my server
Date: Fri, 15 Aug 2008 09:15:52 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0808150907190.3324@nehalem.linux-foundation.org>
References: <1EE44425-6910-4C37-9242-54D0078FC377@adacore.com> <alpine.LFD.1.10.0808131024460.4352@xanadu.home> <20080813145944.GB3782@spearce.org> <alpine.LFD.1.10.0808131123221.4352@xanadu.home> <20080813155016.GD3782@spearce.org>
 <alpine.LFD.1.10.0808131228270.4352@xanadu.home> <alpine.LFD.1.10.0808141014410.3324@nehalem.linux-foundation.org> <alpine.LFD.1.10.0808141022500.3324@nehalem.linux-foundation.org> <alpine.LFD.1.10.0808141442150.4352@xanadu.home>
 <alpine.LFD.1.10.0808141215520.3324@nehalem.linux-foundation.org> <20080814213033.GE13814@one.firstfloor.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Nicolas Pitre <nico@cam.org>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Geert Bosch <bosch@adacore.com>, Ken Pratt <ken@kenpratt.net>,
	git@vger.kernel.org
To: Andi Kleen <andi@firstfloor.org>
X-From: git-owner@vger.kernel.org Fri Aug 15 18:17:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KU1zJ-0006ju-M0
	for gcvg-git-2@gmane.org; Fri, 15 Aug 2008 18:17:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756567AbYHOQQK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Aug 2008 12:16:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756194AbYHOQQJ
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Aug 2008 12:16:09 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:51696 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754490AbYHOQQI (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 15 Aug 2008 12:16:08 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m7FGFrsC032589
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 15 Aug 2008 09:15:54 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m7FGFqsp008174;
	Fri, 15 Aug 2008 09:15:52 -0700
In-Reply-To: <20080814213033.GE13814@one.firstfloor.org>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.414 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92491>



On Thu, 14 Aug 2008, Andi Kleen wrote:
> 
> I would have thought that zlib has a sequential access pattern that the
> CPU prefetchers have a easy time with hiding latency.

No, the lookup tables for the patterns are quite non-sequential. It does 
do a lot of indirect accesses, ie it loads data from the input stream and 
then looks things up through that. 

But it's quite possible that we should use different compression factors 
for different object types. Right now we have different (configurable) 
compression levels for loose objects and packs, but it might be 
interesting to see what happens for just "packed tree objects".

The trees really end up having rather different access patterns in 
pack-files. They also tend to be rather less compressible than other 
blobs, since the SHA1's in there are just random binary data. They also 
delta very well - obviously regular blobs do that _too_, but regular blobs 
are seldom as performance-critical in git (ie once you actually unpack a 
blob, there are other things going on like actually generating a diff - 
but trees get unpacked over and over for "internal git reasons")

		Linus
