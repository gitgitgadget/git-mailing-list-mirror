From: Jeff King <peff@peff.net>
Subject: Re: [PATCH V2 3/3] strbuf: allow to use preallocated memory
Date: Wed, 8 Jun 2016 15:19:18 -0400
Message-ID: <20160608191918.GB19572@sigill.intra.peff.net>
References: <20160606151340.22424-1-william.duclot@ensimag.grenoble-inp.fr>
 <20160606151340.22424-4-william.duclot@ensimag.grenoble-inp.fr>
 <xmqqvb1mxmk4.fsf@gitster.mtv.corp.google.com>
 <20160606203901.GA7667@Messiaen>
 <xmqqfusquedk.fsf@gitster.mtv.corp.google.com>
 <20160606225847.GA22756@sigill.intra.peff.net>
 <xmqqbn3dvr22.fsf@gitster.mtv.corp.google.com>
 <20160607090653.GA4665@Messiaen>
 <575845D9.2010604@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: William Duclot <william.duclot@ensimag.grenoble-inp.fr>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	antoine.queru@ensimag.grenoble-inp.fr,
	francois.beutin@ensimag.grenoble-inp.fr,
	Johannes.Schindelin@gmx.de, mh@glandium.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Jun 08 21:19:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bAj0q-0002ph-4W
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jun 2016 21:19:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423833AbcFHTTc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2016 15:19:32 -0400
Received: from cloud.peff.net ([50.56.180.127]:51458 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1161014AbcFHTTb (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2016 15:19:31 -0400
Received: (qmail 32348 invoked by uid 102); 8 Jun 2016 19:19:20 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 08 Jun 2016 15:19:20 -0400
Received: (qmail 11769 invoked by uid 107); 8 Jun 2016 19:19:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 08 Jun 2016 15:19:30 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 08 Jun 2016 15:19:18 -0400
Content-Disposition: inline
In-Reply-To: <575845D9.2010604@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296835>

On Wed, Jun 08, 2016 at 06:20:41PM +0200, Michael Haggerty wrote:

> Instead, one could write
> 
> > static int feed_object(const unsigned char *sha1, int fd, int negative)
> > {
> > 	char buf[GIT_SHA1_HEXSZ + 2];
> > 	struct strbuf line = WRAPPED_FIXED_STRBUF(buf);
> > 
> > 	if (negative && !has_sha1_file(sha1))
> > 		return 1;
> > 
> > 	if (negative)
> > 		strbuf_addch(&line, '^');
> > 	strbuf_add(&line, sha1_to_hex(sha1), GIT_SHA1_HEXSZ);
> > 	strbuf_addch(&line, '\n');
> > 	return write_or_whine(fd, line.buf, line.len, "send-pack: send refs");
> > }

Hmm. I'm not sure that just replacing that with a regular heap-allocated
strbuf is so bad. It additionally gets rid of the SHA1_HEXSZ math in the
allocation.

So from your list of advantages:

> * It's a little less manual bookkeeping, and thus less error-prone,
>   than the current code.

We have this, but better.

> * If somebody decides to add another character to the line but
>   forgets to increase the allocation size, the code dies in testing
>   rather than (a) overflowing the buffer, like the current
>   code, or (b) silently becoming less performant, as if it used a
>   preallocated but non-fixed strbuf.

Instead of overflowing, it just silently works.

> * There's no need to strbuf_release() (which can be convenient in
>   a function with multiple exit paths).

Same.

The downside, obviously, is the cost of malloc/free. It may even be
noticeable here here because this really is a tight loop of strbuf
allocation (OTOH, we immediately make a syscall; how expensive is
write() compared to malloc()?).

We can hack around that by reusing the same strbuf.

Unfortunately the usual trick of:

  struct strbuf buf = STRBUF_INIT;
  for (...) {
	strbuf_reset(&buf);
	...
  }
  strbuf_release(&buf);

does not work, because we are in a sub-function. We can pass in the
buffer as scratch space, but that makes the function interface a little
uglier than it needs to be.

Likewise, we could make the strbuf static inside feed_object().  It's
not so bad here, where we know there aren't re-entrancy issues, but it's
not a very safe pattern in general (and it leaks the memory when we're
done with the function).

That made me wonder if we could repeatedly reuse a buffer attached to
the file descriptor. And indeed, isn't that what stdio is? The whole
reason this buffer exists is because we are using a direct descriptor
write. If we switched this function to use fprintf(), we'd avoid the
whole buffer question, have a fixed cap on our memory use (since we just
flush anytime the buffer is full) _and_ we'd reduce the number of
write syscalls we're making by almost a factor of 100.

> I don't know whether this particular function should be rewritten; I'm
> just giving an example of the type of scenario where I think it could be
> useful.
>
> In a world without fixed strbufs, what would one use in this situation?

I know I've done the exact opposite of what you wanted here and talked
about this specific function. But I _do_ think this is a pattern I've
seen several times, where we format into a buffer only to write() it
out. I think they may comprise a reasonable number of our buffer-using
loops.

-Peff
