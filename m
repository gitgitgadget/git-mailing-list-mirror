From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Avoid sorting if references are added to ref_cache in
 order
Date: Thu, 24 May 2012 17:10:48 -0400
Message-ID: <20120524211047.GC21329@sigill.intra.peff.net>
References: <1337861810-9366-1-git-send-email-mhagger@alum.mit.edu>
 <20120524174906.GC3161@sigill.intra.peff.net>
 <4FBEA16D.4040204@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Martin Fick <mfick@codeaurora.org>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu May 24 23:11:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXfJ8-0002cc-RT
	for gcvg-git-2@plane.gmane.org; Thu, 24 May 2012 23:10:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933595Ab2EXVKu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 May 2012 17:10:50 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:54294
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933414Ab2EXVKu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 May 2012 17:10:50 -0400
Received: (qmail 597 invoked by uid 107); 24 May 2012 21:11:16 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 24 May 2012 17:11:16 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 May 2012 17:10:48 -0400
Content-Disposition: inline
In-Reply-To: <4FBEA16D.4040204@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198432>

On Thu, May 24, 2012 at 11:00:29PM +0200, Michael Haggerty wrote:

> >Technically we would still be sorted if strcmp(...) == 0. But I guess it
> >probably doesn't matter, as we shouldn't ever be adding duplicates here.
> 
> Yes, duplicate refs should be an exceptional case and needn't be
> handled efficiently.  sort_ref_dir() explicitly accepts the
> possibility of duplicate references, de-dups them if they are
> consistent with each other, or dies if they are inconsistent.  We
> shouldn't add a way to bypass that logic.  We could implement the
> duplicate-detection-and-checking code again in add_entry_to_dir(),
> but my choice was to leave it to sort_ref_dir() to deal with
> duplicates.

Ah, I didn't realize that there was duplicate-detection magic was in
sort_ref_dir. So comparing to 0 is not even "this doesn't matter, but we
could..." but "doing it that way will actively break other code". I
withdraw my suggestion. :)

> More general approaches:
> [...]
> Something that would help read_packed_refs() would be to keep track
> of the directory that it is currently working in.  This would
> effectively remove the need to access a directory while working in
> one of its subdirectories, thereby avoiding any need to repeatedly
> sort intermediate directories.  It would also avoid having to
> traverse the directories starting at the root for each new entry,
> which itself would save time independent of the time for sorting.  I
> have some patches that implement this change but they are stale.  I
> want to do some benchmarking first though to see whether the extra
> complication brings measurable benefits.

This is specifically what I was thinking of when I wrote my previous
message. But I rejected it as too complicated to be worth the trouble,
if the only code path helped would be mass-inserting unsorted refs,
which we don't even currently do.

However, I didn't think about the fact that we could avoid traversing
the refs tree entirely for each ref. That might actually yield a
measurable speedup. I'd be curious to see your results.

> Finally, I did some work on the idea of keeping the refs within a
> directory *mostly* sorted.  (Probably this technique is already
> known, but I have never run into it.)  One would keep the first part
> of the array sorted, and append new references to the tail of the
> array unsorted.  Searching would be via a binary search over the
> sorted part of the array, and a linear search over the unsorted tail.
> The trick is that every so often the tail should be sorted and merged
> into the head.  How often?  It is a tradeoff between the work of
> sorting and merging versus the work saved by avoiding linear searches
> through the tail.  I worked out the theory, and I think the optimum
> was to re-sort the array when the size of the unsorted tail reached
> the squareroot of the total size or something like that.  This method
> could reduce the cost of (lookup, add, lookup, add, ...) sequences,
> albeit not to the extent of a more optimal data structure.

That's very clever. In fact, way more clever than this problem deserves.
It is not like we are journaling a database; we basically have one
mass-insertion when we read packed-refs, and I think the simpler
solutions will perform just fine.

-Peff
