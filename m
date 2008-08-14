From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: pack operation is thrashing my server
Date: Thu, 14 Aug 2008 10:58:01 -0700 (PDT)
Message-ID: <alpine.LFD.1.10.0808141022500.3324@nehalem.linux-foundation.org>
References: <a6b6acf60808101247r4fea978ft6d2cdc53e1f99c0e@mail.gmail.com> <20080811030444.GC27195@spearce.org> <a6b6acf60808110043t76dc0ae6l428c5da473d79c71@mail.gmail.com> <87vdy71i6w.fsf@basil.nowhere.org> <1EE44425-6910-4C37-9242-54D0078FC377@adacore.com>
 <alpine.LFD.1.10.0808131024460.4352@xanadu.home> <20080813145944.GB3782@spearce.org> <alpine.LFD.1.10.0808131123221.4352@xanadu.home> <20080813155016.GD3782@spearce.org> <alpine.LFD.1.10.0808131228270.4352@xanadu.home>
 <alpine.LFD.1.10.0808141014410.3324@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Geert Bosch <bosch@adacore.com>,
	Andi Kleen <andi@firstfloor.org>, Ken Pratt <ken@kenpratt.net>,
	git@vger.kernel.org
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Thu Aug 14 19:59:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTh6s-0003Wx-Ql
	for gcvg-git-2@gmane.org; Thu, 14 Aug 2008 19:59:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753374AbYHNR6i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Aug 2008 13:58:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752672AbYHNR6i
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Aug 2008 13:58:38 -0400
Received: from smtp1.linux-foundation.org ([140.211.169.13]:34346 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751852AbYHNR6h (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 14 Aug 2008 13:58:37 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.13.5/Debian-3ubuntu1.1) with ESMTP id m7EHw1o3032057
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 14 Aug 2008 10:58:03 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m7EHw1GT021546;
	Thu, 14 Aug 2008 10:58:01 -0700
In-Reply-To: <alpine.LFD.1.10.0808141014410.3324@nehalem.linux-foundation.org>
User-Agent: Alpine 1.10 (LFD 962 2008-03-14)
X-Spam-Status: No, hits=-3.414 required=5 tests=AWL,BAYES_00
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92379>



On Thu, 14 Aug 2008, Linus Torvalds wrote:
> 
> Doing a rev-list of all objects is a fairly rare operation, but even if 
> you want to clone/repack all of your archives the whole time, please 
> realize that listing objects is _not_ a simple operation. It opens up and 
> parses every single tree in the whole history. That's a _lot_ of data to 
> unpack.

Btw, it's not that hard to run oprofile (link git statically to get better 
numbers). For me, the answer to what is going on for a kernel rev-list is 
pretty straightforward:

	263742   26.6009  lookup_object
	135945   13.7113  inflate
	110525   11.1475  inflate_fast
	75124     7.5770  inflate_table
	64676     6.5232  strlen
	48635     4.9053  memcpy
	47744     4.8154  find_pack_entry_one
	35265     3.5568  _int_malloc
	31579     3.1850  decode_tree_entry
	28388     2.8632  adler32
	19441     1.9608  process_tree
	10398     1.0487  patch_delta
	8925      0.9002  _int_free
	..

so most of it is in inflate, but I suspect the cost of "lookup_object()" 
is so high becuase when we parse the trees we also have to look up every 
blob - even if they didn't change - just to see whether we already saw it 
or not.

For me, an instruction-level profile of lookup_object() shows that the 
cost is all in the hashcmp (53% of the profile is on that "repz cmpsb") 
and in the loading of the object pointer (26% of the profile is on the 
test instruction after the "obj_hash[i]" load). I don't think we can 
really improve that code much - the hash table is very efficient, and the 
cost is just in the fact that we have a lot of meory accesses.

We could try to use the (more memory-hungry) "hash.c" implementation for 
object hashing, which actually includes a 32-bit key inside the hash 
table, but while that will avoid the cost of fetching the object pointer 
for the cases where we have collisions, most of the time the cost is not 
in the collision, but in the fact that we _hit_.

I bet the hit percentage is 90+%, and the cost really is just that we 
encounter the same object hundreds or thousands of times.

Please realize that even if there may be "only" a million objects in the 
kernel, there are *MANY* more ways to _reach_ those objects, and that is 
what git-rev-list --objects does! It's not O(number-of-objects), it's 
O(number-of-object-linkages).

For my current kernel archive, for example, the number of objects is 
roughly 900k. However, think about how many times we'll actually reach a 
blob: that's roughly (blobs per commit)*(number of commits), which can be 
approximated with

	echo $(( $(git ls-files | wc -l) * $(git rev-list --all | wc -l) ))

which is 24324*108518=2639591832 ie about 2.5 _billion_ times.

Now, we don't actually do anything close to that many lookups, because 
when a subdirectory doesn't change at all, we'll skip the whole tree after 
having seen it just once, so that will cut down on the number of objects 
we have to look up by probably a couple of orders of magnitude.

But this is why the "one large directory" load performs worse: in the 
worst case, if you really have a totally flat directory tree, you'd 
literally see that 2.5 billion object lookup case.

So it's not that git scales badly. It's that "git rev-list --objects" is 
really a very expensive operation, and while some good practices (deep 
directory structures) makes it able to optimize the load away a lot, it's 
still potentially very tough.

			Linus
