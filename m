From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/3] commit-slab: avoid large realloc
Date: Sun, 14 Apr 2013 15:19:47 -0400
Message-ID: <20130414191947.GB4599@sigill.intra.peff.net>
References: <1365919489-17553-1-git-send-email-gitster@pobox.com>
 <1365919489-17553-3-git-send-email-gitster@pobox.com>
 <20130414152842.GB1544@sigill.intra.peff.net>
 <7vk3o554jn.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Apr 14 21:20:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URSSz-0004e3-Cq
	for gcvg-git-2@plane.gmane.org; Sun, 14 Apr 2013 21:19:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753461Ab3DNTTx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Apr 2013 15:19:53 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:45533 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753383Ab3DNTTw (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Apr 2013 15:19:52 -0400
Received: (qmail 16214 invoked by uid 107); 14 Apr 2013 19:21:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 14 Apr 2013 15:21:46 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 14 Apr 2013 15:19:47 -0400
Content-Disposition: inline
In-Reply-To: <7vk3o554jn.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221155>

On Sun, Apr 14, 2013 at 11:51:40AM -0700, Junio C Hamano wrote:

> > I don't know if shrinking the size of the realloc is all that big a
> > deal. We are doubling, so the allocation cost is already amortized
> > constant time.
> 
> I was more disturbed about copying the actual bytes. One of the
> envisioned use of the mechanism is to give us unbound number of flag
> bits to paint the history, and also this could be later used to
> store larger structures per commit.

Right; your solution does lower the constant factor. I just don't know
that it matters all that much, since the allocations are so few (i.e.,
log2(N) to get to N items). And you are hurting the "hot path" of every
access of the flags to do it (by introducing the extra division and
indirection). Probably the extra work on lookup doesn't matter on modern
processors due to pipelining. I'd like to measure a few cases to be
sure, but I probably won't get to it today.

> Also "you can now take a pointer" you illustrated (but I snipped
> from here) is a good point.

Yeah, assuming the timings are equal, I'd take your solution on that
principle alone.

> >>  struct commit_slab {
> >> -	int *buf;
> >> -	int alloc;
> >> +	int piece_size;
> >> +	int piece_count;
> >> +	struct commit_slab_piece **piece;
> >>  };
> >
> > Is there a reason to make piece_size a struct member? It must be
> > constant after any pieces are allocated. Is the intent that callers
> > could do:
> >
> >   slab_init(&s);
> >   /* I know ahead of time we are going to need N of these. */
> >   s.piece_size = n;
> 
> The piece_size (later slab_size) is to hold the number of commits
> each slice (i.e. the piece of memory s->slab[nth_slab] points at)
> handles.

Yes, but isn't that a constant:

  (512*1024-32) / sizeof(struct commit_slab_piece)

Leaving it as such lets the compiler optimize better, and is safe from
anybody changing it at runtime. But I think the answer to my question is
"yes, that would be the best thing for patch 2, but patch 3 will allow a
run-time stride parameter anyway". Correct?

-Peff
