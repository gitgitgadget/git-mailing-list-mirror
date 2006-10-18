From: Nicolas Pitre <nico@cam.org>
Subject: Re: heads-up: git-index-pack in "next" is broken
Date: Tue, 17 Oct 2006 20:20:09 -0400 (EDT)
Message-ID: <Pine.LNX.4.64.0610171959070.1971@xanadu.home>
References: <7vy7rfsfqa.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0610171134130.1971@xanadu.home>
 <7vslhnj58e.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0610171251210.1971@xanadu.home>
 <7vbqoake1v.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0610171437250.1971@xanadu.home>
 <20061017233630.72a0aae5.vsu@altlinux.ru>
 <Pine.LNX.4.64.0610171615340.1971@xanadu.home>
 <Pine.LNX.4.64.0610171339030.3962@g5.osdl.org>
 <Pine.LNX.4.64.0610171706260.1971@xanadu.home>
 <Pine.LNX.4.64.0610171440080.3962@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Sergey Vlasov <vsu@altlinux.ru>, Junio C Hamano <junkio@cox.net>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 18 02:20:18 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GZzAO-0004Fu-4p
	for gcvg-git@gmane.org; Wed, 18 Oct 2006 02:20:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751285AbWJRAUM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Oct 2006 20:20:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751290AbWJRAUM
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Oct 2006 20:20:12 -0400
Received: from relais.videotron.ca ([24.201.245.36]:9643 "EHLO
	relais.videotron.ca") by vger.kernel.org with ESMTP
	id S1751285AbWJRAUK (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Oct 2006 20:20:10 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0J7B00BXG29L0CO0@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 17 Oct 2006 20:20:10 -0400 (EDT)
In-reply-to: <Pine.LNX.4.64.0610171440080.3962@g5.osdl.org>
X-X-Sender: nico@xanadu.home
To: Linus Torvalds <torvalds@osdl.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/29146>

On Tue, 17 Oct 2006, Linus Torvalds wrote:

> 
> 
> On Tue, 17 Oct 2006, Nicolas Pitre wrote:
> > 
> > Because offsets into packs are expressed as unsigned long everywhere 
> > else (except in the current pack index on-disk format).
> 
> Until your work, that "unsigned long" was totally just an internal thing 
> that didn't actually bleed into anything else.

And would you please explain how my work changes that state of affairs?
Sorry but I don't follow you here.  Still _I_ wrote that code.

> > > For some structure like this, it sounds positively wrong. Pack-files 
> > > should be architecture-neutral, which means that they shouldn't depend on 
> > > word-size, and they should be in some neutral byte-order.
> > 
> > But they do.  Please consider this code:
> 
> Right. The pack-file itself. But the code that actually _generates_ it 
> mixes things in alarming ways.

???

> > > In contrast, the new union introduced in "next" is just horrid. There's 
> > > not even any way to know which member to use, except apparently that it 
> > > expects that a SHA1 is never zero in the last 12 bytes. Which is probably 
> > > true, but still - that's some ugly stuff.
> > 
> > This union should be looked at just like a sortable hash pointing to a 
> > base object so that deltas with the same base object can be sorted 
> > together.
> 
> .. and it sorts _differently_ on a big-endian vs little-endian thing, 
> doesn't it?

Sure.  But who cares?  The sorting is just there to 1) perform binary 
searches on the list of deltas based from a given object, and 2) find a 
list of all deltas with the same base object.

> So now the sort order depends on endianness and/or wordsize. That just 
> sounds really really wrong.

Again, who cares?  That ordering doesn't influence any data produced by 
the tool.  It is an internal and private strategy to speed up the 
_local_ _searching_ process.  It could be replaced by a dumb linear 
list walk if you wish and the end result i.e. 
the produced pack index would be exactly the same (with a significant 
slowdown notwitstanding).

So let me summarize:

 - the union is a hash.

 - the hash is either an offset value or a sha1 digest.

 - this hash is used for fast object lookup _only_.

 - it does sort differently on big vs little endian machines.

 - but we don't care at all because

 - it is a private algorithmic thing that doesn't "bleed" into any 
   _real_ data structure, and

 - it doesn't have any influence on the format of the end result.

 - it is only a runtime abstraction and nothing else.

 - It never gets into the pack nor the pack index themselves.

Do you still have issues with that?


Nicolas
