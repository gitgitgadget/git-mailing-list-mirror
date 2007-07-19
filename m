From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [REVISED PATCH 2/6] Introduce commit notes
Date: Wed, 18 Jul 2007 20:28:27 -0700 (PDT)
Message-ID: <alpine.LFD.0.999.0707181949490.27353@woody.linux-foundation.org>
References: <Pine.LNX.4.64.0707152326080.14781@racer.site>
 <Pine.LNX.4.64.0707160022560.14781@racer.site> <7vejj96igx.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0707190258550.14781@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	Alberto Bertogli <albertito@gmail.com>, git@vger.kernel.org,
	Johan Herland <johan@herland.net>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Jul 19 05:29:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBMhX-0007ar-K1
	for gcvg-git@gmane.org; Thu, 19 Jul 2007 05:29:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757004AbXGSD3L (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Jul 2007 23:29:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757918AbXGSD3L
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jul 2007 23:29:11 -0400
Received: from smtp2.linux-foundation.org ([207.189.120.14]:53818 "EHLO
	smtp2.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757767AbXGSD3K (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Jul 2007 23:29:10 -0400
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [207.189.120.55])
	by smtp2.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l6J3SW2Q024872
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Wed, 18 Jul 2007 20:28:33 -0700
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id l6J3SR6J011537;
	Wed, 18 Jul 2007 20:28:27 -0700
In-Reply-To: <Pine.LNX.4.64.0707190258550.14781@racer.site>
X-Spam-Status: No, hits=-3.176 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.1.0-osdl_revision__1.12__
X-MIMEDefang-Filter: osdl$Revision: 1.181 $
X-Scanned-By: MIMEDefang 2.53 on 207.189.120.14
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52929>



On Thu, 19 Jul 2007, Johannes Schindelin wrote:
>
> There is one severe shortcoming, though.  Since tree objects can
> contain file names of a variable length, it is not possible to
> do a binary search for the correct base name in the tree object's
> contents.

Well, I've been thinking about this, and that's not really entirely 
correct.

It *is* possible to do a binary search, it's just a bit complicated, 
because you have to take the "halfway" thing, and find the beginning of 
an entry.

But the good news is that the tree entries have a very fixed format, and 
one that is actually amenable to finding where they start. It gets a bit 
complicated, but:

 - SHA1's contain random bytes, so we cannot really depend on their 
   content. Fair enough. But on the other hand, they are fixed length, 
   which means..

 - Each SHA1 is always preceded by a zero byte (it is what separates the 
   filename from the SHA1), and while filenames too can have arbitrary 
   content (and arbitrary length), we know that the *filename* doesn't 
   have a zero byte in it.

 - so finding the beginning of a tree entry should be as easy as finding 
   two zero bytes that are have at least 20 bytes in between them, and 
   then you *know* that the second zero byte is the one that starts a new 
   SHA1 (it cannot be _inside_ a SHA1: if it was, there would be less 
   than twenty bytes to the previous '\0', and it cannot be inside the
   filename either).

 - And you know that 20 bytes after that '\0' is the next tree entry!

Now, what does this mean? It means that if we actually know the filename 
we're looking for, and we're looking at a large range, we really *could* 
start out with binary searching. We would do something like this:

	unsigned char *start;
	unsigned long size;

	while (size > 200) {
		/*
		 * Look halfway, and then back up a bit, because we 
		 * expect it to take us about 20 characters to find
		 * the zero we look for, and an additional 20
		 * characters is the subsequent SHA1.
		 */
		unsigned long guess = size / 2 - 40;

		/*
		 * This is the offset past which a zero means that 
		 * we're good. If we don't find a zero in the first
		 * twenty bytes, that means that the first zero we
		 * find must be the beginning of a SHA1!
		 */
		unsigned long goal_zero = guess + 20;

		for (;;) {
			unsigned char c;

			/*
			 * We need at least 22 characters more: the
			 * '\0' and the SHA1, and then the next entry.
			 * We know the ASCII mode is 4 characters, so
			 * we migth as well make the rule "within 26 of
			 * end end".
			 */
			if (guess >= size-26)
				goto fall_back_to_linear_search;
			c = start[guess++];
			if (c)
				continue;
			/* Found it? */
			if (guess > goal_zero)
				break;
			/*
			 * We found a zero that wasn't 20 bytes away, 
			 * that means we have to reset out goal..
			 */
			last_zero = guess + 20;
		}
		/*
		 * "guess" now points to one past the '\0': the SHA1 of
		 * the previous entry. Add 20, and it points at the start
		 * of a valid tree entry.
		 */
		guess = guess + 20;

		/* Length of the entry: ascii string + '\0' + SHA1 */
		thisentrylen = strlen(start + guess) + 1 + 20;

		.. compare the entry we found with
		.. the entry we are looking for!
		if (found < lookedfor) {
			size = guess;
			continue;
		} else if (found == lookedfor) {
			Yay! FOUND!
		} else {
			guess += thisentry;
			size -= guess;
			start += guess;
			continue;
		}
	}
  fall_back_to_linear_search:

	.. linear search in [ start, size ] ..


Anyway, as you can tell, the above is totally untested, but I really think 
it should work. Whether it really helps, I dunno. But if somebody is 
interested in trying, it might be cool to see.

And yes, the "search for zero bytes" is not *guaranteed* to find any 
beginning at all, if you have lots of short names, *and* lots of zero 
bytes in the SHA1's. But while short names may be common, zero bytes in 
SHA1's are not so much (since you should expect to see a very even 
distribution of bytes, and as such most SHA1's by far should have no zero 
bytes at all!)

So if you're really really *really* unlucky, you might end up having to 
fall back on the linear search. But it still works!

Can anybody see anything wrong in my thinking above?

(And the real question is whether it really helps. I suspect it does 
actually help for big directories, and that it is worth doing, but maybe 
the magic number in "while (size > 200)" could be tweaked.

The logic of that was that binary searching doesn't work very well for 
just a few entries (and "size < 200" implies ~5-6 directory entries), but 
also that linear search is actually perfectly good when it's just a couple 
of cache-lines, and binary searching - especially with the complication of 
having to find the beginning - isn't worth it unless it really means that 
we can avoid a cache miss.

Of course, it may well be that the *real* cost of the directories is just 
the uncompression thing, and that the search is not the problem. Who 
knows? 

			Linus
