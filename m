From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/3] commit-slab: avoid large realloc
Date: Sun, 14 Apr 2013 11:28:43 -0400
Message-ID: <20130414152842.GB1544@sigill.intra.peff.net>
References: <1365919489-17553-1-git-send-email-gitster@pobox.com>
 <1365919489-17553-3-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Apr 14 17:29:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UROrN-0007f3-Ch
	for gcvg-git-2@plane.gmane.org; Sun, 14 Apr 2013 17:28:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752061Ab3DNP2s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Apr 2013 11:28:48 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:45342 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752007Ab3DNP2s (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Apr 2013 11:28:48 -0400
Received: (qmail 14048 invoked by uid 107); 14 Apr 2013 15:30:42 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 14 Apr 2013 11:30:42 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 14 Apr 2013 11:28:43 -0400
Content-Disposition: inline
In-Reply-To: <1365919489-17553-3-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221142>

On Sat, Apr 13, 2013 at 11:04:48PM -0700, Junio C Hamano wrote:

> Instead of using a single "slab" and keep reallocating it as we find
> that we need to deal with commits with larger values of commit->index,
> make a "slab" an array of many "slab_piece"s. Each access may need
> two levels of indirections, but we only need to reallocate the first
> level array of pointers when we have to grow the table this way.

I don't know if shrinking the size of the realloc is all that big a
deal. We are doubling, so the allocation cost is already amortized
constant time.

Whereas the cost of the extra level of indirection is paid for every
lookup. So for some workloads, I can imagine this actually being slower
(I haven't yet measured it for --topo-order, though).

An interesting side effect of this patch is that the pointers returned
by slab_at() are stable until slab_clear(). It doesn't matter for
--topo-order, but if, for example, you had a recursive function, you
would not have to worry about invalidation in sub-functions. I.e.,
before this patch, this would be wrong:

  static struct commit_slab generation_cache;

  int commit_generation(struct commit *c)
  {
          int *gp = slab_at(&generation_cache, c);

          if (!*gp) {
                  int max = 0;
                  struct commit_list *p;

                  parse_commit(c);
                  for (p = c->parents; p; p = p->next) {
                          int g = commit_generation(p->item);
                          if (max < g)
                                  max = g;
                  }

                  *gp = max + 1;
          }

          return *gp;
  }

because the recursive calls might invalidate the "gp" pointer (you would
have to call slab_at repeatedly instead). Whereas with your patch, it's
fine.

>  struct commit_slab {
> -	int *buf;
> -	int alloc;
> +	int piece_size;
> +	int piece_count;
> +	struct commit_slab_piece **piece;
>  };

Is there a reason to make piece_size a struct member? It must be
constant after any pieces are allocated. Is the intent that callers
could do:

  slab_init(&s);
  /* I know ahead of time we are going to need N of these. */
  s.piece_size = n;

? I think that is OK (though they do not need slab_* in that case at
all), but we should probably have a warning in the struct that
piece_size should never be touched except in that circumstance.

-Peff
