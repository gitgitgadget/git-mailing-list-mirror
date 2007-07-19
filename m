From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [REVISED PATCH 2/6] Introduce commit notes
Date: Wed, 18 Jul 2007 22:13:07 -0700
Message-ID: <7vfy3l3rj0.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0707152326080.14781@racer.site>
	<Pine.LNX.4.64.0707160022560.14781@racer.site>
	<7vejj96igx.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0707190258550.14781@racer.site>
	<alpine.LFD.0.999.0707181949490.27353@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Alberto Bertogli <albertito@gmail.com>, git@vger.kernel.org,
	Johan Herland <johan@herland.net>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Jul 19 07:13:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBOKB-0001Hu-6h
	for gcvg-git@gmane.org; Thu, 19 Jul 2007 07:13:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752445AbXGSFNK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 19 Jul 2007 01:13:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752965AbXGSFNK
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Jul 2007 01:13:10 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:33878 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752352AbXGSFNJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Jul 2007 01:13:09 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070719051307.JBDP1428.fed1rmmtao102.cox.net@fed1rmimpo01.cox.net>;
          Thu, 19 Jul 2007 01:13:07 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id RHD71X00H1kojtg0000000; Thu, 19 Jul 2007 01:13:08 -0400
In-Reply-To: <alpine.LFD.0.999.0707181949490.27353@woody.linux-foundation.org>
	(Linus Torvalds's message of "Wed, 18 Jul 2007 20:28:27 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52934>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> And yes, the "search for zero bytes" is not *guaranteed* to find any 
> beginning at all, if you have lots of short names, *and* lots of zero 
> bytes in the SHA1's. But while short names may be common, zero bytes in 
> SHA1's are not so much (since you should expect to see a very even 
> distribution of bytes, and as such most SHA1's by far should have no zero 
> bytes at all!)
>
> So if you're really really *really* unlucky, you might end up having to 
> fall back on the linear search. But it still works!
>
> Can anybody see anything wrong in my thinking above?

Another anchoring clue you seem not to be exploiting fully is
that the ASCII part must match "^[1-7][0-7]{4,5} " (mode bytes).
But the real problem of this approach of course is that this is
not reliable and can get a false match.  You can find your
beginning NUL in the SHA-1 part of one entry, and terminating
NUL later in the SHA-1 part of next entry, and you will never
notice.

However, in the case of Dscho's "notes" code, I do not think (1)
you do not have to guess like the above, and (2) the problem is
much simpler.

Dcsho's "note" looks like a tree full of two-byte [0-9a-f]{2}
names, each of them points at another tree, with the second
level tree being full of 32-byte [0-9a-f]{38} names, each of
them points at a blob.  So it is a much more regular, strict
shape.  And in order to look for a note for an object whose name
is ([0-9a-f]{2})([0-9a-f]{38}), you will find the blob that is
at "$1/$2" in a "note".

I was suggesting to have a specialized parser only to read such
tree objects that are "abused" to represent notes.  You can
cheaply validate that these trees are of expected shape.

 (1) Validate that size of the toplevel tree is multiple of 29 =
     (5 + 1 + 2 + 1 + 20); the second level should be multiple
     of 66 = (6 + 1 + 38 + 1 + 20).  These two levels of trees
     are of fixed-entry-length that allows easy binary search.

 (2) While binary searching trees of either level, you can
     validate that the entry looks like from a note (for the
     toplevel, "40000 [0-9a-f]{2}\0", for the second level,
     "100644 [0-9a-f]{38}\0").

For an added safety, a "notes" writer could even throw in
signature bytes (say, a symlink whose name is " !" in the
top-level tree, and another symlink " !{37}" in the second-level
tree) to protect the reader.
