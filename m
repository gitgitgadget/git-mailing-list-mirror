From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] pack-objects: don't use too many threads with few objects
Date: Tue, 16 Dec 2008 00:21:02 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0812160003050.30035@xanadu.home>
References: <alpine.LFD.2.00.0812111524370.14328@xanadu.home>
 <20081213133238.GA6718@sigill.intra.peff.net>
 <alpine.LFD.2.00.0812131456040.30035@xanadu.home>
 <e2b179460812151038y5a39b33cv1d7b41faf10563e@mail.gmail.com>
 <7vy6ygudhb.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Mike Ralphson <mike.ralphson@gmail.com>, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 16 06:22:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LCSOB-0006DC-A1
	for gcvg-git-2@gmane.org; Tue, 16 Dec 2008 06:22:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750853AbYLPFVL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Dec 2008 00:21:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750894AbYLPFVK
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Dec 2008 00:21:10 -0500
Received: from relais.videotron.ca ([24.201.245.36]:32579 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750853AbYLPFVJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Dec 2008 00:21:09 -0500
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR004.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KBY004WFEV28O30@VL-MO-MR004.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 16 Dec 2008 00:21:03 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <7vy6ygudhb.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103247>

On Mon, 15 Dec 2008, Junio C Hamano wrote:

> "Mike Ralphson" <mike.ralphson@gmail.com> writes:
> 
> > 2008/12/13 Nicolas Pitre <nico@cam.org>
> >>
> >> If there are few objects to deltify, they might be split amongst threads
> >> so that there is simply no other objects left to delta against within
> >> the same thread.  Let's use the same 2*window treshold as used for the
> >> final load balancing to allow extra threads to be created.
> >>
> >> This fixes the benign t5300 test failure.
> >
> > Even with this I'm seeing failures in t5302 which I think are probably
> > related to 43cc2b42
> > ...
> > *   ok 2: pack-objects with index version 1
> >
> > * expecting success: pack2=$(git pack-objects --index-version=2 test-2
> > <obj-list) &&
> >      git verify-pack -v "test-2-${pack2}.pack"
> > 0106e17481932f5c223fafadc1d26abc6adf40d6 blob   57 90 850531 1
> > 69e0b8ef8cda369575b6801c6ed47daf09aa3c62
> > ...
> > fff3a3a92d2268a464dbdcd00fc055885ee3cba9 blob   8196 8210 187404
> > chain length = 1: 109 objects
> > chain length = 2: 10 objects
> > chain length = 3: 10 objects
> > chain length = 4: 10 objects
> > chain length = 5: 10 objects
> > chain length = 6: 10 objects
> > chain length = 7: 10 objects
> > chain length = 8: 10 objects
> > chain length = 9: 9 objects
> > test-2-9108b6dfd43bf36ccbfc2839fe62d1503bf84292.pack: ok
> > *   ok 3: pack-objects with index version 2
> >
> > * expecting success: cmp "test-1-${pack1}.pack" "test-2-${pack2}.pack"
> > test-1-9108b6dfd43bf36ccbfc2839fe62d1503bf84292.pack
> > test-2-9108b6dfd43bf36ccbfc2839fe62d1503bf84292.pack differ: char
> > 10236, line 32
> > * FAIL 4: both packs should be identical
> > 	cmp "test-1-${pack1}.pack" "test-2-${pack2}.pack"
> 
> This is interesting.  The same set of objects are packed with the
> identical list of objects stored in obj-list and the only difference
> between test #2 and test #3 are the format of the .idx file they produce.
> Yet they are producing different .pack file?

Indeed, this is really strange.

> Even though depending on the timings of how worker threads complete
> assigned work and grab more work for them, two otherwise identical runs,
> even with the same set of parameters, could assign different set of
> objects to different threads.  But as far as I can see, the same set of
> objects should go to the same chunk, and the only difference should be
> which thread gets which chunk, and I do not see how that could affect the
> outcome.  Puzzled...

You probably have the explanation here: worker threads are not 
necessarily completing their own chunks alwais at the same time relative 
with each other.  Hence, a thread stealing more work from another thread 
might or might not interrupt that other thread always at the same point 
between runs, and therefore the final delta chain might get shifted a 
bit.

I think the best "fix" is actually to configure only one thread for this 
test.  The point here is to make sure different index versions don't 
introduce variations in pack generation, but multiple threads do defeat 
that because of the inner randomness in thread scheduling.

I'm therefore giving my ACK to Johannes' patch posted earlier.


Nicolas
