From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/8] paint_down_to_common: use prio_queue
Date: Tue, 1 Jul 2014 13:10:51 -0400
Message-ID: <20140701171051.GA7282@sigill.intra.peff.net>
References: <20140625233429.GA20457@sigill.intra.peff.net>
 <20140625233952.GC23146@sigill.intra.peff.net>
 <xmqqionhxd3a.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 01 19:10:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X21a4-0005Lj-Pq
	for gcvg-git-2@plane.gmane.org; Tue, 01 Jul 2014 19:10:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758768AbaGARKx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Jul 2014 13:10:53 -0400
Received: from cloud.peff.net ([50.56.180.127]:54292 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1758307AbaGARKw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jul 2014 13:10:52 -0400
Received: (qmail 14945 invoked by uid 102); 1 Jul 2014 17:10:51 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 01 Jul 2014 12:10:51 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 01 Jul 2014 13:10:51 -0400
Content-Disposition: inline
In-Reply-To: <xmqqionhxd3a.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252727>

On Tue, Jul 01, 2014 at 09:23:21AM -0700, Junio C Hamano wrote:

> > but with this patch, the positions of B and A are swapped.
> > This is probably fine, as the order is an internal
> > implementation detail anyway (it would _not_ be fine if we
> > were using a priority queue for "git log" traversal, which
> > should show commits in parent order).
> 
> Interesting that the queue is not "stable", but the test can still
> rely on a fixed output.

I think it is deterministic for a particular sequence of inserts/pops,
but not stable with respect to insertion order.

> While I tend to agree that for the purpose
> of this code path, the order is an internal implementation detail,
> but I wonder if it would benefit us a lot if we taught prio-queue to
> be optionally more "stable", which would allow us to use it in other
> code paths that care.  If we really wanted to, I would imagine that
> we could keep the "insertion counter" in the elements of the queue
> to make the result stable (i.e. the "void **array" would become
> something like "struct { int insertion_ctr; void *thing; } *array").

Yeah, I think the reasons to be stable are:

  1. To be on the safe side for operations like this where it
    _shouldn't_ matter, but perhaps there are hidden dependencies we
    don't know of.

  2. To make it easier for later callers to use prio-queue for cases
     where it does matter (and I think "git log" is one of these).

If we can do it without a big performance loss (and I don't see any
reason it should be any worse than a slight bump to the constant-factor
of the logarithmic operations), it probably makes sense to.

I'll take a look at it (in fact, I already implemented something like it
once long ago in the thread I linked to earlier). My sense of taste says
it should be a stable_prio_queue implemented on top of prio_queue (i.e.,
storing pointers to the struct you mention above). That means you can
still use the unstable one if you want the (presumably minor)
performance benefit, and it keeps the logic nice and tidy.

But given that we have implemented prio_queue using void pointers, I
think it would introduce an extra pointer per item and an extra layer of
indirection on each access.  So maybe it is better to just build it in.

The low-cost alternative is to implement prio_queue to hold items of
arbitrary size. I'm not sure if that is the worth the complexity and
maintenance cost.

> Heh, I should have read the below-three-dashs commentary before
> commenting (I often start working from the commit messages in "git
> log" and then go back to the original thread).

I always wonder how people read those. I tend to write them as if people
have (just) read the commit message, but not yet read the patch.

-Peff

PS Thanks for your earlier comments on the actual commit-slab painting
   algorithm. Responding to those is taking more thinking, and I haven't
   gotten to it yet, but it's on my agenda.
