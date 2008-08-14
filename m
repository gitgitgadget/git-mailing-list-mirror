From: Nicolas Pitre <nico@cam.org>
Subject: Re: pack operation is thrashing my server
Date: Thu, 14 Aug 2008 15:04:13 -0400 (EDT)
Message-ID: <alpine.LFD.1.10.0808141442150.4352@xanadu.home>
References: <a6b6acf60808101247r4fea978ft6d2cdc53e1f99c0e@mail.gmail.com>
 <20080811030444.GC27195@spearce.org>
 <a6b6acf60808110043t76dc0ae6l428c5da473d79c71@mail.gmail.com>
 <87vdy71i6w.fsf@basil.nowhere.org>
 <1EE44425-6910-4C37-9242-54D0078FC377@adacore.com>
 <alpine.LFD.1.10.0808131024460.4352@xanadu.home>
 <20080813145944.GB3782@spearce.org>
 <alpine.LFD.1.10.0808131123221.4352@xanadu.home>
 <20080813155016.GD3782@spearce.org>
 <alpine.LFD.1.10.0808131228270.4352@xanadu.home>
 <alpine.LFD.1.10.0808141014410.3324@nehalem.linux-foundation.org>
 <alpine.LFD.1.10.0808141022500.3324@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Geert Bosch <bosch@adacore.com>,
	Andi Kleen <andi@firstfloor.org>, Ken Pratt <ken@kenpratt.net>,
	git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Aug 14 21:08:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTi8S-0005KK-Md
	for gcvg-git-2@gmane.org; Thu, 14 Aug 2008 21:05:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752001AbYHNTEU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Aug 2008 15:04:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752178AbYHNTEU
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Aug 2008 15:04:20 -0400
Received: from relais.videotron.ca ([24.201.245.36]:55807 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751379AbYHNTET (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Aug 2008 15:04:19 -0400
Received: from xanadu.home ([66.131.194.97]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0K5L00D5VUB1NICF@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 14 Aug 2008 15:04:14 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <alpine.LFD.1.10.0808141022500.3324@nehalem.linux-foundation.org>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92388>

On Thu, 14 Aug 2008, Linus Torvalds wrote:

> Btw, it's not that hard to run oprofile (link git statically to get better 
> numbers). For me, the answer to what is going on for a kernel rev-list is 
> pretty straightforward:
> 
> 	263742   26.6009  lookup_object
> 	135945   13.7113  inflate
> 	110525   11.1475  inflate_fast
> 	75124     7.5770  inflate_table
> 	64676     6.5232  strlen
> 	48635     4.9053  memcpy
> 	47744     4.8154  find_pack_entry_one
> 	35265     3.5568  _int_malloc
> 	31579     3.1850  decode_tree_entry
> 	28388     2.8632  adler32
> 	19441     1.9608  process_tree
> 	10398     1.0487  patch_delta
> 	8925      0.9002  _int_free
> 	..

OK, inflate went down since last time I profiled this, but that's 
probably because lookup_object went up.

> so most of it is in inflate,

Which, again, would be eliminated entirely by pack v4.

> but I suspect the cost of "lookup_object()" 
> is so high becuase when we parse the trees we also have to look up every 
> blob - even if they didn't change - just to see whether we already saw it 
> or not.

One optimization with pack v4 was to have delta chunks aligned on tree 
records, and because tree objects are no longer compressed, parsing a 
tree object could be done by simply walking the delta chain directly.  
Then, another optimization would consist of simply skipping any part of 
a tree object making a delta reference to a base object which has 
already been parsed which would avoid a large bunch of lookup_object() 
calls too.

And because 
delta base objects are normally seen first in recency order then this 
would reduce the combinatorial complexity significantly.


Nicolas
