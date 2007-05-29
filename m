From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 00/15] git-note: A mechanisim for providing free-form after-the-fact annotations on commits
Date: Tue, 29 May 2007 04:22:46 -0400
Message-ID: <20070529082245.GA15788@coredump.intra.peff.net>
References: <Pine.LNX.4.64.0705091406350.18541@iabervon.org> <200705281948.27329.johan@herland.net> <7vwsysbrtg.fsf@assigned-by-dhcp.cox.net> <200705290906.29328.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Tue May 29 10:23:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hswyp-0007WK-4P
	for gcvg-git@gmane.org; Tue, 29 May 2007 10:22:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750926AbXE2IWv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 29 May 2007 04:22:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751175AbXE2IWv
	(ORCPT <rfc822;git-outgoing>); Tue, 29 May 2007 04:22:51 -0400
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:2172 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750926AbXE2IWu (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 May 2007 04:22:50 -0400
Received: (qmail 23763 invoked from network); 29 May 2007 08:22:55 -0000
Received: from unknown (HELO coredump.intra.peff.net) (10.0.0.2)
  by peff.net with (DHE-RSA-AES128-SHA encrypted) SMTP; 29 May 2007 08:22:55 -0000
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 29 May 2007 04:22:46 -0400
Content-Disposition: inline
In-Reply-To: <200705290906.29328.johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48673>

On Tue, May 29, 2007 at 09:06:29AM +0200, Johan Herland wrote:

> 1. Keep a file, ".git/reverse_tagmap_sorted" with one entry of the form
> "pointee pointer" per line. The file is sorted on "pointee", so we can
> easily do the radix-256-fan-out-followed-by-binary-search trick that
> Linus mentioned in another thread. This should hopefully make lookup
> fairly cheap. BTW, if there is a similar "pointee pointer"-type format
> already being used in git, I'd be happy to use that instead. I looked

I did a similar thing (though rather than having "lines" at all, they
were fixed-length pairs of binary sha1 hashes) to implement a negative
delta cache (which turned out to be a stupid idea, but the
implementation worked):

http://www.gelato.unsw.edu.au/archives/git/0606/23229.html

> 2. Keep another file, ".git/reverse_tagmap_unsorted" in front of (1).
> This file has exactly the same format, minus the sorting. It exists just
> to make insertion cheap. Once this file reaches a certain size (i.e.
> when trawling it on lookup becomes slightly painful), we shuffle the
> entries into the sorted file (this would happen automatically on
> insertion of an entry, and should _not_ have to be triggered by 'git-gc'
> etc.).

The implementation I mentioned above collects several "to be inserted"
entries (in memory) and then merge sorts the two lists into a new file.
So it was fast in terms of comparisons, but it involved writing O(n)
entries, which is probably bad for creating a single note.

> Of course, if we think insertion directly into (1) will never be too
> expensive, we can drop (2) altogether.

You can always find the right spot, memmove everything down one slot,
and insert. But that means:
  - the cost of insertion will be proportional to the number of items,
    whereas using an unsorted journal you get to amortize that cost over
    many insertions
  - if you update in place, you have to lock the db for reading while
    you are moving around. If you are always either appending to the
    journal or merging into a new file, you can avoid this.

-Peff
