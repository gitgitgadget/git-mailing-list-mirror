From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: diff'ing files ...
Date: Thu, 09 Jun 2011 22:19:54 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1106092145390.2142@xanadu.home>
References: <BANLkTi=1vaoLVmhyahDttmUmqw7RTp=8-A@mail.gmail.com>
 <20110606224356.GC13697@sigill.intra.peff.net>
 <BANLkTinwSembzVk4gSYSvsRdHhDfqizkyg@mail.gmail.com>
 <20110607221948.GA10104@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Albretch Mueller <lbrtchx@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jun 10 04:20:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUrKP-0008Jz-QH
	for gcvg-git-2@lo.gmane.org; Fri, 10 Jun 2011 04:20:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756754Ab1FJCT4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Jun 2011 22:19:56 -0400
Received: from relais.videotron.ca ([24.201.245.36]:24333 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755655Ab1FJCTz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Jun 2011 22:19:55 -0400
Received: from xanadu.home ([66.130.28.92]) by vl-mo-mrz23.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-8.01 (built Dec 16 2008; 32bit))
 with ESMTP id <0LMJ00EMZYFXSX10@vl-mo-mrz23.ip.videotron.ca> for
 git@vger.kernel.org; Thu, 09 Jun 2011 22:19:09 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <20110607221948.GA10104@sigill.intra.peff.net>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175594>

On Tue, 7 Jun 2011, Jeff King wrote:

> On Tue, Jun 07, 2011 at 10:12:35PM +0000, Albretch Mueller wrote:
> 
> > > ... binary diffs, though I don't know offhand the details of the algorithm.
> > ~
> >  this is the part that I need ;-)
> > ~
> >  Reading the source code without knowing the basic underlying
> > ideas/algorithm (just an outline if possible) won't help much
> 
> You could read the comments in the source:
> 
>   $ head -n 7 diff-delta.c
>   /*
>    * diff-delta.c: generate a delta between two buffers
>    *
>    * This code was greatly inspired by parts of LibXDiff from Davide Libenzi
>    * http://www.xmailserver.org/xdiff-lib.html
>    *
>    * Rewritten for GIT by Nicolas Pitre <nico@fluxnic.net>, (C) 2005-2007
> 
> According to the xdiff page linked:
> 
>   For binary files, LibXDiff implements both (with some modification)
>   the algorithm described in File System Support for Delta Compression
>   by Joshua P.  MacDonald, and the algorithm described in Fingerprinting
>   By Random Polynomials by Michael O. Rabin.
> 
> Nicolas (cc'd) might be able to say what, if any, substantive changes
> were made from those works.

The libxdiff code was pretty generic so to be highly portable and usable 
for many application types.  What I did is to get rid of everything that 
git strictly didn't need in order to make the code as simple as 
possible, and most importantly as fast as possible.  And then the code 
was optimized even further, sacrificing on clarity a bit, to make it 
even faster.  Since this code is the very inner loop of every delta 
search for best delta matches, every bit of optimization counts.

And then further modifications were made to avoid pathological corner 
cases which were taking too much time for little gain in the Git 
context.

I also changed the output encoding to make it tighter.

So, strictly speaking, the current code in Git doesn't bear any 
resemblance with the libxdiff code at all.  However the basic algorithm 
behind both implementations is the same.  Studying the libxdiff version 
is probably easier in order to gain an understanding of how this works.


Nicolas
