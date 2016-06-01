From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/2] strbuf: improve API
Date: Wed, 1 Jun 2016 03:42:18 -0400
Message-ID: <20160601074218.GB14096@sigill.intra.peff.net>
References: <20160530103642.7213-1-william.duclot@ensimag.grenoble-inp.fr>
 <1069084553.156626.1464607928755.JavaMail.zimbra@ensimag.grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: William Duclot <william.duclot@ensimag.grenoble-inp.fr>,
	git@vger.kernel.org,
	simon rabourg <simon.rabourg@ensimag.grenoble-inp.fr>,
	francois beutin <francois.beutin@ensimag.grenoble-inp.fr>,
	antoine queru <antoine.queru@ensimag.grenoble-inp.fr>,
	matthieu moy <matthieu.moy@grenoble-inp.fr>,
	mhagger@alum.mit.edu
To: Remi Galan Alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Wed Jun 01 09:42:30 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b80nL-0004z5-Td
	for gcvg-git-2@plane.gmane.org; Wed, 01 Jun 2016 09:42:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752209AbcFAHmW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jun 2016 03:42:22 -0400
Received: from cloud.peff.net ([50.56.180.127]:47033 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751037AbcFAHmW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jun 2016 03:42:22 -0400
Received: (qmail 24605 invoked by uid 102); 1 Jun 2016 07:42:21 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 01 Jun 2016 03:42:21 -0400
Received: (qmail 30980 invoked by uid 107); 1 Jun 2016 07:42:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 01 Jun 2016 03:42:28 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 01 Jun 2016 03:42:18 -0400
Content-Disposition: inline
In-Reply-To: <1069084553.156626.1464607928755.JavaMail.zimbra@ensimag.grenoble-inp.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296063>

On Mon, May 30, 2016 at 01:32:08PM +0200, Remi Galan Alfonso wrote:

> William Duclot <william.duclot@ensimag.grenoble-inp.fr> writes:
> > This patch series implements an improvment of the strbuf API, allowing
> > strbuf to use preallocated memory. This makes strbuf fit to be used
> > in performance-critical operations.
> > 
> > The first patch is simply a preparatory work, adding tests for
> > existing strbuf implementation.
> > Most of the work is made in the second patch: handle pre-allocated
> > memory, extend the API, document it and test it.
> 
> Seems interesting, however do you have any test/example that would
> show the difference of performance between using these optimizations
> and not using them?
> 
> Such values would make a nice addition to help convince people that
> your series is interesting to have and use.

I'll second the request for actual numbers. I'm a little dubious that
malloc overhead is actually a significant place we are spending time, or
if there is simply a superstitious avoidance of using strbufs. A huge
number of strbufs are used for filenames, where we're about to make a
syscall anyway. If your allocator for a 4K page is not competitive with
a context switch, I suspect the best solution is to get a new allocator.

So I wonder if we have some less-invasive alternatives:

  1. Ship a faster allocator library with git, and use its malloc by
     default.

  2. Do caching tricks for strbufs used in tight loops. For example,
     have strbuf_release() throw its buffer into a last-used cache, and
     let the next strbuf_grow() use that cache entry. This cuts malloc()
     out of the loop.

     You'd probably want to protect the cache with a mutex, though. Most
     of git isn't thread-safe, but a few parts are, and strbufs are
     low-level enough that they might get called.

I have no idea if those ideas would work. But I wouldn't want to start
looking into either of them without some idea of how much time we're
actually spending on strbuf mallocs (or how much time we would spend if
strbufs were used in some proposed sites).

-Peff
