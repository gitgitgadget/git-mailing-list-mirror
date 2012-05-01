From: Jeff King <peff@peff.net>
Subject: Re: gc --aggressive
Date: Tue, 1 May 2012 16:01:23 -0400
Message-ID: <20120501200123.GB26245@sigill.intra.peff.net>
References: <CAG+J_DyqvCxwd6+gzixQEk6SxMZF0qsXKcJPaU6imsJdFQ-64g@mail.gmail.com>
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
Content-Type: text/plain; charset=utf-8
Cc: Nicolas Pitre <nico@fluxnic.net>, git@vger.kernel.org,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Jay Soffian <jaysoffian@gmail.com>,
	Shawn Pearce <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 01 22:01:38 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SPJGR-00015q-KK
	for gcvg-git-2@plane.gmane.org; Tue, 01 May 2012 22:01:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756160Ab2EAUB3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 May 2012 16:01:29 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:53685
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754161Ab2EAUB2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 May 2012 16:01:28 -0400
Received: (qmail 10188 invoked by uid 107); 1 May 2012 20:01:44 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 01 May 2012 16:01:44 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 01 May 2012 16:01:23 -0400
Content-Disposition: inline
In-Reply-To: <7vr4v391s1.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196736>

On Tue, May 01, 2012 at 11:47:26AM -0700, Junio C Hamano wrote:

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

No. Here are the objects with the same sizes:

  $ git rev-list --objects --all |
    cut -d' ' -f1 |
    git cat-file --batch-check |
    cut -d' ' -f2,3 |
    sort | uniq -c | sort -rn | head

  19722 tree 2222
  14068 tree 4393
  11418 tree 2156
   9994 tree 4676
   9479 tree 2189
   7944 tree 2255
   6454 commit 251
   6437 tree 4611
   5328 tree 4439
   4586 commit 254

So it's mostly trees and commits (the first repeated blob size is on
line 332 of the output). The commits aren't all that big even without
deltafication, but the trees are. They should be sorted by name_hash,
but within a single name, there are going to be a lot of repetitions (I
think each of those size clusters is just a repetition of the same "po"
directory getting lots of tiny modifications).

So we are triggering that part of the sort quite a bit. But by your
reasoning here:

> The original tie-breaks based on the address (the earlier object we read
> in the original input comes earlier in the output) and yours make the
> objects later we read (which in turn are from older parts of the history)
> come early, but adjacency between two objects of the same type and the
> same size would not change (if A and B were next to each other in this
> order, your updated sorter will give B and then A still next to each
> other), so I suspect not much would change in the candidate selection.

I don't think it makes a big difference (and indeed, switching it and
repacking the phpmyadmin repository yields the same-size pack, although
a lot more CPU time is spent).

-Peff
