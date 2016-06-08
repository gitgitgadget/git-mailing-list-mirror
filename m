From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] tree-diff: avoid alloca for large allocations
Date: Tue, 7 Jun 2016 21:36:56 -0400
Message-ID: <20160608013656.GA7277@sigill.intra.peff.net>
References: <20160607225300.GA2285@sigill.intra.peff.net>
 <xmqq8tygo6s4.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Kirill Smelkov <kirr@mns.spb.ru>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 08 03:37:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1bASQi-00037L-23
	for gcvg-git-2@plane.gmane.org; Wed, 08 Jun 2016 03:37:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754751AbcFHBhB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jun 2016 21:37:01 -0400
Received: from cloud.peff.net ([50.56.180.127]:50978 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754266AbcFHBg7 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jun 2016 21:36:59 -0400
Received: (qmail 19777 invoked by uid 102); 8 Jun 2016 01:36:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 07 Jun 2016 21:36:58 -0400
Received: (qmail 3754 invoked by uid 107); 8 Jun 2016 01:37:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 07 Jun 2016 21:37:08 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 07 Jun 2016 21:36:56 -0400
Content-Disposition: inline
In-Reply-To: <xmqq8tygo6s4.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/296754>

On Tue, Jun 07, 2016 at 05:36:59PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > An alternative to this would be implement something like:
> >
> >   struct tree *tp, tp_fallback[2];
> >   if (nparent <= ARRAY_SIZE(tp_fallback))
> >           tp = tp_fallback;
> >   else
> > 	  ALLOC_ARRAY(tp, nparent);
> >   ...
> >   if (tp != tp_fallback)
> > 	  free(tp);
> >
> > That would let us drop our xalloca() portability code
> > entirely. But in my measurements, this seemed to perform
> > slightly worse than the xalloca solution.
> 
> It indeed is curious why this "obvious" alternative performed
> worse.

Yeah. I'd be happy if somebody wanted to prove me wrong here. It's
entirely possible I just did something stupid. I had wrapped up the
above in the FAST_ARRAY_ALLOC macro. It would waste the stack space when
we _did_ have to call malloc, but that should almost never happen in my
benchmark. It also allocates an extra slot on the stack for non-merge
commits. So I guess the wasted 24 bytes or whatever could have in
impact. It's also possible that the extra variable simply tickles the
optimizer in some way; I didn't look at the generated asm.

FWIW, here are the timings I had come up with for running "git log --raw
--no-abbrev --no-renames" on linux.git (the same benchmark from the
commit that originally added the alloca). The "time" output at the end
is best-of-five, with the "attempt" lines showing the wall-clock time
for each:

  [original, with xalloca]
  Attempt 1: 30.669
  Attempt 2: 30.782
  Attempt 3: 31.807
  Attempt 4: 31.152
  Attempt 5: 30.243

  real    0m30.243s
  user    0m30.112s
  sys     0m0.128s


  [xmalloc/free instead of xalloca]
  Attempt 1: 31.306
  Attempt 2: 31.814
  Attempt 3: 31.138
  Attempt 4: 31.787
  Attempt 5: 32.23

  real    0m31.138s
  user    0m30.976s
  sys     0m0.160s


  [local var with fallback to xmalloc]
  Attempt 1: 30.926
  Attempt 2: 31.466
  Attempt 3: 31.865
  Attempt 4: 31.345
  Attempt 5: 33.159

  real    0m30.926s
  user    0m30.804s
  sys     0m0.120s


So the improvement here over even a naive malloc/free is _really_ small.
You'll note that the best-of-five for xmalloc is actually smaller than
the worst-case with xalloca. But the mean is still 2% better. The mean
for the "fallback" case aren't really any better (which makes me wonder
if I was somehow accidentally calling malloc each time).

So I dunno. For 2%, I was tempted to simply say "screw it, let's just
forget this micro-optimization and call xmalloc". This patch is the
conservative choice in that it has the same performance profile as the
original. Or so I thought. I didn't record the old timings, but they
looked similar to the original. I just recreated them while writing this
email and got:

  [xalloca with fallback to xmalloc]
  Attempt 1: 31.356
  Attempt 2: 31.725
  Attempt 3: 31.454
  Attempt 4: 30.898
  Attempt 5: 31.937

  real    0m30.898s
  user    0m30.752s
  sys     0m0.144s

which really isn't much better than the local-var case. I wonder if just
having the conditional stack/heap is what kills us (either itself, or
because it affects the optimizer).

I dunno.


> > +#define FAST_ARRAY_ALLOC(x, nr) do { \
> > +	if ((nr) <= 2) \
> > +		(x) = xalloca((nr) * sizeof(*(x))); \
> > +	else \
> > +		ALLOC_ARRAY((x), nr); \
> > +} while(0)
> > +#define FAST_ARRAY_FREE(x, nr) do { \
> > +	if ((nr) > 2) \
> > +		free((x)); \
> > +} while(0)
> 
> An obvious and clean implementation of the idea.
> 
> The only slight worry I have is that nr must stay constant until the
> time the caller calls FREE(), but for the only three callsite pairs
> it is clear nparent will stay constant and this is local to the
> file.

Yep, I had the same worry. I think it's OK because the damage is limited
to tree-diff.c. I'm not sure I would promote this macro for general use.

-Peff
