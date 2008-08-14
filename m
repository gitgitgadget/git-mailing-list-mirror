From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: pack operation is thrashing my server
Date: Thu, 14 Aug 2008 12:44:29 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0808141215520.3324@nehalem.linux-foundation.org>
References: <a6b6acf60808101247r4fea978ft6d2cdc53e1f99c0e@mail.gmail.com> <20080811030444.GC27195@spearce.org> <a6b6acf60808110043t76dc0ae6l428c5da473d79c71@mail.gmail.com> <87vdy71i6w.fsf@basil.nowhere.org> <1EE44425-6910-4C37-9242-54D0078FC377@adacore.com>
 <alpine.LFD.1.10.0808131024460.4352@xanadu.home> <20080813145944.GB3782@spearce.org> <alpine.LFD.1.10.0808131123221.4352@xanadu.home> <20080813155016.GD3782@spearce.org> <alpine.LFD.1.10.0808131228270.4352@xanadu.home> <alpine.LFD.1.10.0808141014410.3324@nehalem.linux-foundation.org>
 <alpine.LFD.1.10.0808141022500.3324@nehalem.linux-foundation.org> <alpine.LFD.1.10.0808141442150.4352@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Geert Bosch <bosch@adacore.com>,
	Andi Kleen <andi@firstfloor.org>, Ken Pratt <ken@kenpratt.net>,
	git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Thu Aug 14 21:46:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTimE-0005Ha-IW
	for gcvg-git-2@gmane.org; Thu, 14 Aug 2008 21:46:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753299AbYHNTpT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Aug 2008 15:45:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753374AbYHNTpS
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Aug 2008 15:45:18 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:33904 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752947AbYHNTpQ (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Aug 2008 15:45:16 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m7EJiUPa009812
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 14 Aug 2008 12:44:31 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m7EJiTeZ026144;
	Thu, 14 Aug 2008 12:44:29 -0700
In-Reply-To: <alpine.LFD.1.10.0808141442150.4352@xanadu.home>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.413 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92391>



On Thu, 14 Aug 2008, Nicolas Pitre wrote:
> 
> > so most of it is in inflate,
> 
> Which, again, would be eliminated entirely by pack v4.

I seriously doubt that.

Nico, it's really easy to say "I wave my magic wand and nothing remains".

It's hard to actually _do_.

> One optimization with pack v4 was to have delta chunks aligned on tree 
> records, and because tree objects are no longer compressed, parsing a 
> tree object could be done by simply walking the delta chain directly.  

Even if you do that, please take a look at the performance characteristics 
of modern CPU's.

Here's a hint: the cost of a cache miss is generally about a hundred times 
the cost of just about anything else. 

So to make a convincing argument, you'd have to show that the actual 
memory access patterns are also much better.

No, zlib isn't perfect, and nope, inflate_fast() is no "memcpy()". And 
yes, I'm sure a pure memcpy would be much faster. But I seriously suspect 
that a lot of the cost is literally in bringing in the source data to the 
CPU. Because we just mmap() the whole pack-file, the first access to the 
data is going to see the cost of the cache misses.

			Linus
