From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 2/4] commit-queue: LIFO or priority queue of commits
Date: Mon, 10 Jun 2013 01:25:00 -0400
Message-ID: <20130610052500.GD3621@sigill.intra.peff.net>
References: <1370581872-31580-1-git-send-email-gitster@pobox.com>
 <1370820277-30158-1-git-send-email-gitster@pobox.com>
 <1370820277-30158-3-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Elliott Cable <me@ell.io>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 10 07:25:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UlubP-00021H-9i
	for gcvg-git-2@plane.gmane.org; Mon, 10 Jun 2013 07:25:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750922Ab3FJFZF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Jun 2013 01:25:05 -0400
Received: from cloud.peff.net ([50.56.180.127]:41811 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750769Ab3FJFZE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Jun 2013 01:25:04 -0400
Received: (qmail 19634 invoked by uid 102); 10 Jun 2013 05:25:54 -0000
Received: from c-71-62-74-146.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.62.74.146)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 10 Jun 2013 00:25:54 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 10 Jun 2013 01:25:00 -0400
Content-Disposition: inline
In-Reply-To: <1370820277-30158-3-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/227238>

On Sun, Jun 09, 2013 at 04:24:35PM -0700, Junio C Hamano wrote:

> Traditionally we used a singly linked list of commits to hold a set
> of in-flight commits while traversing history.  The most typical use
> of the list is to add commits that are newly discovered to it, keep
> the list sorted by commit timestamp, pick up the newest one from the
> list, and keep digging.  The cost of keeping the singly linked list
> sorted is nontrivial, and this typical use pattern better matches a
> priority queue.
> 
> Introduce a commit-queue structure, that can be used either as a
> LIFO stack, or a priority queue.  This will be used in the next
> patch to hold in-flight commits during sort-in-topological-order.

Great. You may recall I had a similar patch or year or two back, in an
attempt to fix some of the O(n^2) places (e.g., in fetch-pack's
mark_complete). We ended up dropping it because duplicate removal kept
"n" small enough for common cases, and most of the commit_list users
depend on doing cheap splicing and other linked-list operations.

It may be worth looking again for other places to use this over
commit_list, but even the caller you are introducing here justifies its
presence.

Also, I wrote some basic tests to cover the priority queue as a unit. I
can rebase them on your commit if you are interested.

A few comments on the code itself:

> +void commit_queue_put(struct commit_queue *queue, struct commit *commit)

Is it worth making this "struct commit *" a void pointer, and handling
arbitrary items in our priority queue? The compare function should be
the only thing that dereferences them.

I do not have any non-commit priority queue use in mind, but I do not
think it adds any complexity in this case.

> +	/* Bubble up the new one */
> +	for (ix = queue->nr - 1; ix; ix = parent) {
> +		parent = (ix - 1) / 2;
> +		if (compare(queue->array[parent], queue->array[ix],
> +			    queue->cb_data) < 0)
> +			break;

In my implementation, I stopped on "compare() <= 0". It is late and my
mind is fuzzy, but I recall that heaps are never stable with respect to
insertion order, so I don't think it would matter.

-Peff
