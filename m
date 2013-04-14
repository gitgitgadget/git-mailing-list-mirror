From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 1/3] commit: allow associating auxiliary info on-demand
Date: Sun, 14 Apr 2013 11:12:29 -0400
Message-ID: <20130414151229.GA1544@sigill.intra.peff.net>
References: <1365919489-17553-1-git-send-email-gitster@pobox.com>
 <1365919489-17553-2-git-send-email-gitster@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Apr 14 17:12:52 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URObo-0004xL-SX
	for gcvg-git-2@plane.gmane.org; Sun, 14 Apr 2013 17:12:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751877Ab3DNPMf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Apr 2013 11:12:35 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:45323 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751879Ab3DNPMe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Apr 2013 11:12:34 -0400
Received: (qmail 13979 invoked by uid 107); 14 Apr 2013 15:14:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 14 Apr 2013 11:14:28 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 14 Apr 2013 11:12:29 -0400
Content-Disposition: inline
In-Reply-To: <1365919489-17553-2-git-send-email-gitster@pobox.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221141>

On Sat, Apr 13, 2013 at 11:04:47PM -0700, Junio C Hamano wrote:

> From: Jeff King <peff@peff.net>
> 
> The "indegree" field in the commit object is only used while sorting
> a list of commits in topological order, and wasting memory otherwise.
> 
> We would prefer to shrink the size of individual commit objects,
> which we may have to hold thousands of in-core. We could eject
> "indegree" field out from the commit object and represent it as a
> dynamic table based on the decoration infrastructure, but the
> decoration is meant for sparse annotation and is not a good match.
> 
> Instead, let's try a different approach.
> 
>  - Assign an integer (commit->index) to each commit we keep in-core
>    (reuse the space of "indegree" field for it);
> 
>  - When running the topological sort, allocate an array of integers
>    in bulk (called "slab"), use the commit->index as an index into
>    this array, and store the "indegree" information there.
> 
> This does _not_ reduce the memory footprint of a commit object, but
> the commit->index can be used as the index to dynamically associate
> commits with other kinds of information as needed.
> 
> Signed-off-by: Junio C Hamano <gitster@pobox.com>

Thanks, this writeup makes sense to me. Obviously,

  Signed-off-by: Jeff King <peff@peff.net>

I had planned to clean it up into a more general form, as you did in
patch 3, before submitting it, but doing it like this with the cleanup
on top is fine with me (and it makes the attribution of the work much
clearer).

The rest of this email ended up long and rambly, and is kind of a dump
of the pending thoughts I had on the slab approach. Don't take it as "do
not do this patch", but rather "here are some areas to explore on top".

One thing you did gloss over a bit is "the decoration is meant for
sparse annotation". I do wonder what the performance would look like for
implementing --topo-order fully via "struct decoration". Given that our
hash function is a direct memory access of object->sha1, and that with a
reasonable load factor in the table, most lookups should not hit any
collision, it is not too expensive to do a lookup. I think the biggest
cost would be that we have to do a full hashcmp() for each access to
actually _check_ the collision. So it probably is noticeably slower due
to that, but I didn't actually measure it.

Assuming the slab technique is faster, I suspect there are some "struct
decoration" cases that should be switched. Unfortunately the most
obvious one to me would be the mark storage in fast-export, but that is
used for object types other than commit. And I don't think we want to
move the slab index into "struct object", for two reasons:

  1. It bloats the size of blob and tree objects, which we have more of
     than commits (especially in something like "rev-list --objects
     --all").

  2. Your commit indices become less dense, so you have to use a bigger
     slab, which is wasteful and will have worse memory cache performance.
     We could maybe mitigate that by keeping a per-type index counter,
     but that complicates the slab lookup (it would have to dereference
     based on type).

I also note that we still have commit->util, which serves a similar
purpose to the slab index, and is often used when we are attaching data
to a lot of commits (and in fact, --topo-sort could probably just be
implemented via commit->util).

Comparing a slab index versus a util pointer, I think the differences
should be:

  1. with slab, you have an extra level of indirection ("x + c->index"
     rather than "c->util"), which might be measurably slower.

  2. with slab, you do not have to worry about conflicting with other
     users of "struct commit" in the same program

  3. with util, you can squeeze values smaller than a pointer into
     "struct commit"; technically you can do this with the slab index,
     too, but that would negate (2) above. However, I don't think we
     even use "util" that way anywhere currently.

  4. util pointers can point multiple commits to the same chunk of
     memory. A slab index can do that, too, but you have an extra level
     of indirection (you store a slab of pointers to items, some of
     which are shared).

  5. with a util pointer, we typically point to an malloc'd chunk of
     memory. With a slab, you avoid per-commit allocation in favor of
     allocating a big chunk of slab at once. However, you should be able
     to do the same thing with a util pointer (i.e., allocate from a
     pool and just point into it).

So I think the util pointer is strictly better, except for point (2). And
the main cost is point (1), the extra indirection. So if we can measure
(1) and decide it isn't a big cost, the maintainability improvement for
(2) is probably worth it, and we can rip out the util pointer entirely,
saving us some extra space in "struct commit".

-Peff
