From: Jeff King <peff@peff.net>
Subject: Re: [PATCH V2 3/3] strbuf: allow to use preallocated memory
Date: Mon, 6 Jun 2016 18:58:48 -0400
Message-ID: <20160606225847.GA22756@sigill.intra.peff.net>
References: <20160606151340.22424-1-william.duclot@ensimag.grenoble-inp.fr>
 <20160606151340.22424-4-william.duclot@ensimag.grenoble-inp.fr>
 <xmqqvb1mxmk4.fsf@gitster.mtv.corp.google.com>
 <20160606203901.GA7667@Messiaen>
 <xmqqfusquedk.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: William Duclot <william.duclot@ensimag.grenoble-inp.fr>,
	git@vger.kernel.org, antoine.queru@ensimag.grenoble-inp.fr,
	francois.beutin@ensimag.grenoble-inp.fr, mhagger@alum.mit.edu,
	Johannes.Schindelin@gmx.de, mh@glandium.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 07 00:59:12 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bA3UE-0005z0-AC
	for gcvg-git-2@plane.gmane.org; Tue, 07 Jun 2016 00:59:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753651AbcFFW66 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jun 2016 18:58:58 -0400
Received: from cloud.peff.net ([50.56.180.127]:50004 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753635AbcFFW64 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jun 2016 18:58:56 -0400
Received: (qmail 32264 invoked by uid 102); 6 Jun 2016 22:58:50 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 06 Jun 2016 18:58:50 -0400
Received: (qmail 23468 invoked by uid 107); 6 Jun 2016 22:58:59 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 06 Jun 2016 18:58:59 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 06 Jun 2016 18:58:48 -0400
Content-Disposition: inline
In-Reply-To: <xmqqfusquedk.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296570>

On Mon, Jun 06, 2016 at 03:44:07PM -0700, Junio C Hamano wrote:

> William Duclot <william.duclot@ensimag.grenoble-inp.fr> writes:
> 
> > I'm not sure to follow you. I agree that the "fixed strbuf" feature is
> > flawed by the presence of this `die()`. But (unless misunderstanding)
> > the "owns_memory" bit you talk about does exist in this patch, and allow
> > the exact behavior you describe.
> 
> Imagine that I know most of my input lines are shorter than 80 bytes
> and definitely shorter than 128 bytes.  I may want to say:
> 
> 	/* allocate initial buffer ch[128] and attach it to line */
> 	struct strbuf line = STRBUF_INIT_ON_STACK(128);
> 
> 	while (!strbuf_getline(&line, stdin)) {
> 		... use contents of &line ...
> 	}
>         strbuf_release(&line);
> 
> knowing that I won't waste too much cycles and memory from heap most
> of the time.  Further imagine that one line in the input happened to
> be 200 bytes long.  After processing that line, the next call to
> strbuf_getline() will call strbuf_reset(&line).
> 
> I think that call should reset line.buf to the original buffer on
> the stack, instead of saying "Ok, I'll ignore the original memory
> not owned by us and instead keep pointing at the allocated memory",
> as the allocation was done as a fallback measure.

I am not sure I agree. Do we think accessing the stack buffer is somehow
cheaper than the heap buffer (perhaps because of cache effects)? If so,
how much cheaper?

I think you can model reusing an already-allocated heap buffer as a
hit/miss type of scenario. A "hit" means we see a larger-than-128 line
and can avoid the allocation cost by reusing the heap buffer. A "miss"
means the line is less than 128, and we pay the cost to use the heap
instead of the stack, whatever that is.

My suspicion is that the cost of a miss is essentially zero, so the best
strategy is to optimize for as many hits as possible (once the cost of
the initial allocation has been paid, though I am still not even
convinced that is a meaningful amount, especially in a loop like this
where we can so easily reuse a heap buffer).

-Peff
