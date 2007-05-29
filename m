From: Johan Herland <johan@herland.net>
Subject: Re: [PATCH 00/15] git-note: A mechanisim for providing free-form after-the-fact annotations on commits
Date: Tue, 29 May 2007 11:23:54 +0200
Message-ID: <200705291123.54607.johan@herland.net>
References: <Pine.LNX.4.64.0705091406350.18541@iabervon.org> <200705290906.29328.johan@herland.net> <20070529082245.GA15788@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue May 29 11:24:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HsxwP-0002os-Sb
	for gcvg-git@gmane.org; Tue, 29 May 2007 11:24:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751125AbXE2JY0 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 29 May 2007 05:24:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751373AbXE2JY0
	(ORCPT <rfc822;git-outgoing>); Tue, 29 May 2007 05:24:26 -0400
Received: from sam.opera.com ([213.236.208.81]:58790 "EHLO sam.opera.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751125AbXE2JYZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 May 2007 05:24:25 -0400
Received: from pc052.lan019.oslo.opera.com (pat-tdc.opera.com [213.236.208.22])
	by sam.opera.com (8.13.4/8.13.4/Debian-3sarge3) with ESMTP id l4T9Ns89013949
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 29 May 2007 09:24:03 GMT
User-Agent: KMail/1.9.6
In-Reply-To: <20070529082245.GA15788@coredump.intra.peff.net>
Content-Disposition: inline
X-Virus-Scanned: ClamAV 0.90.1/3321/Tue May 29 06:15:48 2007 on sam.opera.com
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48675>

On Tuesday 29 May 2007, Jeff King wrote:
> On Tue, May 29, 2007 at 09:06:29AM +0200, Johan Herland wrote:
> 
> > 1. Keep a file, ".git/reverse_tagmap_sorted" with one entry of the form
> > "pointee pointer" per line. The file is sorted on "pointee", so we can
> > easily do the radix-256-fan-out-followed-by-binary-search trick that
> > Linus mentioned in another thread. This should hopefully make lookup
> > fairly cheap. BTW, if there is a similar "pointee pointer"-type format
> > already being used in git, I'd be happy to use that instead. I looked
> 
> I did a similar thing (though rather than having "lines" at all, they
> were fixed-length pairs of binary sha1 hashes) to implement a negative
> delta cache (which turned out to be a stupid idea, but the
> implementation worked):
> 
> http://www.gelato.unsw.edu.au/archives/git/0606/23229.html

Cool. It won't give a big-Oh improvement, but it might give a worthwile
boost anyway. I guess it's the usual tradeoff between speed and
maintainability/transparency/readability.

> > 2. Keep another file, ".git/reverse_tagmap_unsorted" in front of (1).
> > This file has exactly the same format, minus the sorting. It exists just
> > to make insertion cheap. Once this file reaches a certain size (i.e.
> > when trawling it on lookup becomes slightly painful), we shuffle the
> > entries into the sorted file (this would happen automatically on
> > insertion of an entry, and should _not_ have to be triggered by 'git-gc'
> > etc.).
> 
> The implementation I mentioned above collects several "to be inserted"
> entries (in memory) and then merge sorts the two lists into a new file.
> So it was fast in terms of comparisons, but it involved writing O(n)
> entries, which is probably bad for creating a single note.
> 
> > Of course, if we think insertion directly into (1) will never be too
> > expensive, we can drop (2) altogether.
> 
> You can always find the right spot, memmove everything down one slot,
> and insert. But that means:
>   - the cost of insertion will be proportional to the number of items,
>     whereas using an unsorted journal you get to amortize that cost over
>     many insertions
>   - if you update in place, you have to lock the db for reading while
>     you are moving around. If you are always either appending to the
>     journal or merging into a new file, you can avoid this.

Yep, I'm thinking (2) will be worth it in the end. O(#notes) per note
insertion doesn't sound appealing at all, especially not if we're
expecting a handful of notes per commit.


Have fun!

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
