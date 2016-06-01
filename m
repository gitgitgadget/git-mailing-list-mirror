From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/2] strbuf: improve API
Date: Wed, 1 Jun 2016 16:09:59 -0400
Message-ID: <20160601200959.GA13061@sigill.intra.peff.net>
References: <20160530103642.7213-1-william.duclot@ensimag.grenoble-inp.fr>
 <1069084553.156626.1464607928755.JavaMail.zimbra@ensimag.grenoble-inp.fr>
 <20160601074218.GB14096@sigill.intra.peff.net>
 <1464810629.3988.11.camel@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Remi Galan Alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>,
	William Duclot <william.duclot@ensimag.grenoble-inp.fr>,
	git@vger.kernel.org,
	simon rabourg <simon.rabourg@ensimag.grenoble-inp.fr>,
	francois beutin <francois.beutin@ensimag.grenoble-inp.fr>,
	antoine queru <antoine.queru@ensimag.grenoble-inp.fr>,
	matthieu moy <matthieu.moy@grenoble-inp.fr>,
	mhagger@alum.mit.edu
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Wed Jun 01 22:10:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b8CSx-0007VS-Vk
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jun 2016 22:10:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751316AbcFAUKE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jun 2016 16:10:04 -0400
Received: from cloud.peff.net ([50.56.180.127]:47481 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751250AbcFAUKD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jun 2016 16:10:03 -0400
Received: (qmail 26199 invoked by uid 102); 1 Jun 2016 20:10:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 01 Jun 2016 16:10:02 -0400
Received: (qmail 4544 invoked by uid 107); 1 Jun 2016 20:10:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 01 Jun 2016 16:10:09 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 01 Jun 2016 16:09:59 -0400
Content-Disposition: inline
In-Reply-To: <1464810629.3988.11.camel@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296155>

On Wed, Jun 01, 2016 at 03:50:29PM -0400, David Turner wrote:

> On Wed, 2016-06-01 at 03:42 -0400, Jeff King wrote:
> >   2. Do caching tricks for strbufs used in tight loops. For example,
> >      have strbuf_release() throw its buffer into a last-used cache,
> > and
> >      let the next strbuf_grow() use that cache entry. This cuts
> > malloc()
> >      out of the loop.
> > 
> >      You'd probably want to protect the cache with a mutex, though.
> 
> 
> ... or make the last-used cache be thread-local.

Good idea.

I almost didn't mention threading at all, because I'd be surprised if
malloc lock contention is a serious bottleneck for us anywhere.

It's hard to really say much concrete because it's not clear to me where
people think strbuf allocation _is_ a bottleneck (or again, _would be_
if we were to use it more).

If we imagine a loop like this:

  for (i = 0; i < n; i++) {
	struct strbuf buf = STRBUF_INIT;
	do_something_with(&buf);
	strbuf_release(&buf);
  }

then yes, we'll call malloc() and free() a lot of times. But unless your
libc malloc is terrible, those calls are all probably just taking a
mutex and reusing the same block from a free list. The strbuf case is
actually really friendly to allocators because our blocks tend to be
predictable sizes (they're sized by ALLOC_GROW, which has a
deterministic set of block sizes).

In practice, I'd imagine loops get more complicated than that. They call
sub-functions which allocate a strbuf, and sometimes don't release it
until other strbufs have been allocated, etc. The proposal in this
thread is basically using the call stack to mirror the allocation
patterns. So when the pattern of allocations matches an actual stack,
that's good, but I'd expect a reasonably smart allocator to perform
similarly. And when it's not a true stack, the stack-based strbufs are
going to end up with wasted stack space hanging around even after we've
free()'d the memory and could reuse it. And I'd still expect an
allocator based off a linked list or something to handle such cases
pretty well.

There are also other non-big-O factors at play in modern systems, like
CPU cache footprints. Is heap memory cheaper or more expensive to access
than stack? I can imagine stack is kept in the cache better, but if
you're reusing the same heap block over and over, it probably stays in
cache, too. But if you have unused stack buffers that _could_ be reused
(but won't be because you'd have to manually feed them to a new strbuf),
that hurts your footprint. And on top of that, the stack proposals I've
seen generally involve over-sizing the stack buffers out of a fear of
actually calling malloc.

And then on top of that, there is the question of whether anything
involving a strbuf allocation is actually a tight enough loop to even
_care_ about cache dynamics.

So again, I'm slightly negative on anything that makes the code even
slightly more complex, especially the call sites, if we can't show
actual measurable improvement numbers.

Sorry, this turned into a mini-rant, and it's not really directed at
you, David. Your email was just what spurred me to put some of these
thoughts into words. :)

-Peff
