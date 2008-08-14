From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: pack operation is thrashing my server
Date: Thu, 14 Aug 2008 16:14:26 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0808141544150.3324@nehalem.linux-foundation.org>
References: <a6b6acf60808101247r4fea978ft6d2cdc53e1f99c0e@mail.gmail.com> <20080811030444.GC27195@spearce.org> <a6b6acf60808110043t76dc0ae6l428c5da473d79c71@mail.gmail.com> <87vdy71i6w.fsf@basil.nowhere.org> <1EE44425-6910-4C37-9242-54D0078FC377@adacore.com>
 <alpine.LFD.1.10.0808131024460.4352@xanadu.home> <20080813145944.GB3782@spearce.org> <alpine.LFD.1.10.0808131123221.4352@xanadu.home> <20080813155016.GD3782@spearce.org> <alpine.LFD.1.10.0808131228270.4352@xanadu.home> <alpine.LFD.1.10.0808141014410.3324@nehalem.linux-foundation.org>
 <alpine.LFD.1.10.0808141022500.3324@nehalem.linux-foundation.org> <alpine.LFD.1.10.0808141442150.4352@xanadu.home> <alpine.LFD.1.10.0808141215520.3324@nehalem.linux-foundation.org> <alpine.LFD.1.10.0808141633080.4352@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Geert Bosch <bosch@adacore.com>,
	Andi Kleen <andi@firstfloor.org>, Ken Pratt <ken@kenpratt.net>,
	git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Fri Aug 15 01:16:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTm36-0000EX-Tw
	for gcvg-git-2@gmane.org; Fri, 15 Aug 2008 01:16:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751950AbYHNXPD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Aug 2008 19:15:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751424AbYHNXPD
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Aug 2008 19:15:03 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:43743 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751272AbYHNXPA (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Aug 2008 19:15:00 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m7ENERYW028309
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 14 Aug 2008 16:14:28 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m7ENEQVP002294;
	Thu, 14 Aug 2008 16:14:26 -0700
In-Reply-To: <alpine.LFD.1.10.0808141633080.4352@xanadu.home>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.413 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92436>


On Thu, 14 Aug 2008, Nicolas Pitre wrote:
> 
> Possible.  However, the fact that both the "Compressing objects" and the 
> "Writing objects" phases during a repack (without -f) together are 
> _faster_ than the "Counting objects" phase is a sign that something is 
> more significant than cache misses here, especially when tree 
> information is a small portion of the total pack data size.

Hmm. I think I may have clue.

The size of the delta cache seems to be a sensitive parameter for this 
thing. Not so much for the git archive, but working on the kernel tree, 
raising it to 1024 seems to give a 20% performance improvement. That, in 
turn, implies that we may be unpacking things over and over again because 
of bad locality wrt delta generation. 

I'm not sure how easy something like that is to fix, though. We generate 
the object list in "recency" order for a reason, but that also happens to 
be the worst possible order for re-using the delta cache - by the time we 
get back to the next version of some tree entry, we'll have cycled through 
all the other trees, and blown all the caches, so we'll end up likely 
re-doing the whole delta chain.

So it's quite possible that what ends up happening is that some directory 
with a deep delta chain will basically end up unpacking the whole chain - 
which obviously includes inflating each delta - over and over again.

That's what the delta cache was supposed to avoid..

Looking at some call graphs, for the kernel I get:

 - process_tree() called 10 million times

 - causing parse_tree() called 479,466 times (whew, so 19 out of 20 trees 
   have already been seen and can be discarded)

 - which in turn calls read_sha1_file() (total: 588,110 times, but there's 
   a hundred thousand+ commits)

but that actually causes 

 - 588,110 cals to cache_or_unpack_entry

out of which 5,850 calls hit in the cache, and 582,260 do *not*.

IOW, the delta cache effectively never triggers because the working set is 
_way_ bigger than the cache, and the patterns aren't good. So since most 
trees are deltas, and the max delta depth is 10, the average depth is 
soemthing like 5, and we actually get an ugly

 - 1,637,999 calls to unpack_compressed_entry

which all results in a zlib inflate call.

So we actually have three times as many calls to inflate as we even have 
objects parsed, due to the delta chains on the trees (the commits almost 
never delta-chain at all, much less any deeper than a couple of entries).

So yeah, trees are the problem here, and yes, avoiding inflating them 
would help - but mainly because we do it something like four times per 
object on average!

Ouch. But we really can't just make the cache bigger, and the bad access 
patterns really are on purpose here. The delta cache was not meant for 
this, it was really meant for the "dig deeper into the history of a single 
file" kind of situation that gets very different patterns indeed.

I'll see if I can think of anything simple to avoid all this unnecessary 
work. But it doesn't look too good.

		Linus
