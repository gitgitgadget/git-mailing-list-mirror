From: Nicolas Pitre <nico@fluxnic.net>
Subject: Re: gc --aggressive
Date: Tue, 01 May 2012 15:22:27 -0400 (EDT)
Message-ID: <alpine.LFD.2.02.1205011504160.21030@xanadu.home>
References: <CAG+J_DzO=UZ56PjnSCRaTdj8pBSYc5PFofw1QHy42c5pHMK_HQ@mail.gmail.com>
 <CAG+J_DyqvCxwd6+gzixQEk6SxMZF0qsXKcJPaU6imsJdFQ-64g@mail.gmail.com>
 <vpqbomqqdxo.fsf@bauges.imag.fr>
 <20120428122533.GA12098@sigill.intra.peff.net>
 <alpine.LFD.2.02.1204281258050.21030@xanadu.home>
 <20120429113431.GA24254@sigill.intra.peff.net>
 <alpine.LFD.2.02.1204290917051.21030@xanadu.home>
 <20120501162806.GA15614@sigill.intra.peff.net>
 <20120501171640.GA16623@sigill.intra.peff.net>
 <alpine.LFD.2.02.1205011348090.21030@xanadu.home>
 <7vr4v391s1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jay Soffian <jaysoffian@gmail.com>,
	Shawn Pearce <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 01 21:22:34 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPIeg-00077z-FE
	for gcvg-git-2@plane.gmane.org; Tue, 01 May 2012 21:22:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757774Ab2EATW3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 May 2012 15:22:29 -0400
Received: from relais.videotron.ca ([24.201.245.36]:38664 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756623Ab2EATW3 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 May 2012 15:22:29 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-VM-MR003.ip.videotron.ca
 (Oracle Communications Messaging Exchange Server 7u4-22.01 64bit (built Apr 21
 2011)) with ESMTP id <0M3C006HEZ5G4820@VL-VM-MR003.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 01 May 2012 15:22:28 -0400 (EDT)
In-reply-to: <7vr4v391s1.fsf@alter.siamese.dyndns.org>
User-Agent: Alpine 2.02 (LFD 1266 2009-07-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196729>

On Tue, 1 May 2012, Junio C Hamano wrote:

> Nicolas Pitre <nico@fluxnic.net> writes:
> 
> > One final quick test if you feel like it: I've never been sure that 
> > the last comparison in type_size_sort() is correct.  Maybe it should be 
> > the other way around.  Currently it reads:
> >
> > 	return a < b ? -1 : (a > b);
> >
> > While keeping the size comparison commented out, you could try to 
> > replace this line with:
> >
> > 	return b < a ? -1 : (b > a);
> >
> > If this doesn't improve things then it would be clear that this avenue 
> > should be abandoned.
> 
> Very interesting.  The difference between the two should only matter if
> there are many blobs with exactly the same size, and most of them delta
> horribly with each other.  Does the problematic repository exhibit such
> a characteristic?

Not precisely.  This is just to verify some hypothesis that could 
explain the difference in behavior with the phpmyadmin repo.

My hypothesis was that recency order could be skewed by the object size 
when many small changes are made to the same files without varying their 
size much.  So I suggested that a repack run be performed with the 
object size removed from the sort criteria.  However it is important 
that the last comparison be done in the right direction.  Hence my 
suggestion above.

> The original tie-breaks based on the address (the earlier object we read
> in the original input comes earlier in the output) and yours make the
> objects later we read (which in turn are from older parts of the history)
> come early, but adjacency between two objects of the same type and the
> same size would not change (if A and B were next to each other in this
> order, your updated sorter will give B and then A still next to each
> other), so I suspect not much would change in the candidate selection.

Note that the size comparison is commented out in those tests.  The idea 
was to get pure recency order.

Even for objects of the same size, the delta orientation would change 
which might or might not provide a clue.

But this is really just a wild guess without much thinking at this 
point, before giving up on this approach.


Nicolas
