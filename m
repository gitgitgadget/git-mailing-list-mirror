From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] commit: use a priority queue in merge base functions
Date: Thu, 30 Aug 2012 17:31:05 -0400
Message-ID: <20120830213105.GA18636@sigill.intra.peff.net>
References: <20120829110812.GA14069@sigill.intra.peff.net>
 <20120829111147.GB14734@sigill.intra.peff.net>
 <7vtxvlwt7o.fsf@alter.siamese.dyndns.org>
 <20120829205332.GA16064@sigill.intra.peff.net>
 <20120829205525.GA28696@sigill.intra.peff.net>
 <20120829210032.GA29179@sigill.intra.peff.net>
 <20120829210540.GA31756@sigill.intra.peff.net>
 <20120830125421.GA5687@sigill.intra.peff.net>
 <7v3934tkle.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Thomas Rast <trast@student.ethz.ch>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 30 23:31:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T7CKa-0006yj-HB
	for gcvg-git-2@plane.gmane.org; Thu, 30 Aug 2012 23:31:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752350Ab2H3VbJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Aug 2012 17:31:09 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:48377 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751628Ab2H3VbH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Aug 2012 17:31:07 -0400
Received: (qmail 13085 invoked by uid 107); 30 Aug 2012 21:31:24 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 30 Aug 2012 17:31:24 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 30 Aug 2012 17:31:05 -0400
Content-Disposition: inline
In-Reply-To: <7v3934tkle.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204566>

On Thu, Aug 30, 2012 at 09:23:25AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > Anyway, since this isn't yielding any performance benefit, I'm not going
> > to go down that route. But stability of the queue is something that we
> > need to consider if we ever do replace commit_list with a different data
> > structure.
> >
> > Here's the patch to make the existing priority queue stable (by wasting
> > space) in case we ever want to use it.
> 
> Thanks for being thorough and showing a good analysis.
> 
> If we want stability, the space to hold insertion counter is not
> "wasted", by the way.

It is if there is another data structure that will do the same job with
the same performance characteristics and without using that space.

But I'm not even sure it is an issue in practice. There are ~320K
objects in linux-2.6. Even if we inserted _all_ of them at once into a
queue (which we don't; it's usually more like a couple dozen, with a few
pathological cases being equal to the number of refs we have, which is
usually in the hundreds), then we are talking about an extra 2.5M on a
64-bit system. Compared to dropping an O(n^2) operation to O(lg n),
that's probably not even going to be noticeable.

> I actually think the generic "queue" implementation may want to
> handle elements that are not just single pointers.  Just like
> qsort() is not about sorting an array of pointers but it is about
> sorting an array of elements of caller specified size, perhaps
> "queue" can hold elements of size the caller specified (set in stone
> when the queue is initialized).
> 
> Then, a caller that wants a stable priority queue of commits can
> tell the queue to manage "struct { struct commit *c; int gen; }",
> use the "gen" field for stability in its comparison callback, etc.,
> while a caller that does not need stability can tell the queue to
> manage "struct commit *".  That way, the generic queue layer does
> not have to worry about wasting the insertion counter space, no?

Yeah, that would be more generic. One wonky thing I didn't point out in
my implementation is this:

> +static inline int queue_cmp(struct queue *pq, unsigned i, unsigned j)
> +{
> +       int cmp = pq->cmp(pq->items[i].item, pq->items[j].item);
> +       if (cmp)
> +               return cmp;
> +       if (pq->items[i].counter < pq->items[j].counter)
> +               return 1;
> +       return -1;
> +}

Notice how the counter comparison is "backwards" to the regular
comparison. That's because the queue is actually a max-queue (I did it
that way since we are indexing on timestamp, and want to go in reverse
chronological order). But the counter part wants to prioritize minimums,
so you have to reverse it. You could also implement a min-queue and ask
the caller to reverse their comparison function.

But really, a caller could theoretically want to prioritize in either
direction (e.g., giving a LIFO behavior to elements with the same
priority). Pulling the counter out of the queue would allow that.

The reason I didn't, though, is that it would make the interface a huge
pain if the caller had to do this:

  struct stable_commit_queue_element qe;
  qe.commit = commit;
  qe.counter = counter++; /* who is holding the global counter? */
  queue_push(&q, &qe);

instead of:

  queue_push(&q, commit);

I suspect you could build a "queue" object, and then implement a
"stable queue" on top of it with some clever use of function pointers
for the comparison function.

-Peff
