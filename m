From: Jeff King <peff@peff.net>
Subject: Re: [PATCH/RFH 0/3] stable priority-queue
Date: Mon, 21 Jul 2014 05:07:35 -0400
Message-ID: <20140721090735.GA14548@peff.net>
References: <20140714054021.GA4422@sigill.intra.peff.net>
 <87tx6k5hjz.fsf@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Mon Jul 21 11:07:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X99ZR-0007Sb-0R
	for gcvg-git-2@plane.gmane.org; Mon, 21 Jul 2014 11:07:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754033AbaGUJHj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Jul 2014 05:07:39 -0400
Received: from cloud.peff.net ([50.56.180.127]:37421 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753302AbaGUJHh (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Jul 2014 05:07:37 -0400
Received: (qmail 10960 invoked by uid 102); 21 Jul 2014 09:07:38 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 21 Jul 2014 04:07:38 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 21 Jul 2014 05:07:35 -0400
Content-Disposition: inline
In-Reply-To: <87tx6k5hjz.fsf@fencepost.gnu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253945>

On Mon, Jul 14, 2014 at 01:02:56PM +0200, David Kastrup wrote:

> Jeff King <peff@peff.net> writes:
> 
> > As Junio and I discussed earlier in [1], this series makes the
> > prio_queue struct stable with respect to object insertion (which in turn
> > means we can use it to replace commit_list in more places).
> 
> I don't think that this makes sense in general since it assumes the
> appropriate fallback behavior to be FIFO.  Depending on the use case, it
> might be the other way round, or something else (like topology-based)
> entirely.

Remember that this is just a tie-breaker for the regular comparison
function. If you want to represent some other ordering, you are free to
do the tie-breaking yourself in your comparison function. The one thing
we can easily provide but do not is LIFO ordering for the tie-breaker.
That would be trivial to add as a flag on the prio_queue, but I'd wait
until there is actually a caller who wants it.

Yes, it's a bit hacky to provide it for cases which _don't_ care about
order (or implement their own separate tie-breaker). But the worst case
there is that we are wasting some memory, and I wasn't able to measure a
real slow-down. I think it's a reasonable compromise given the lack of
generics in C.

But if you have a case that is measurably affected, please let me know,
and I can look into implementing it in a type-agnostic way (so that the
embedded insertion counter becomes just another type).

> I see that struct commit already contains an integer field called
> "index", assigned sequentially, which might conceivably be used for
> tie-breaking independent from the actual prio_queue use at no extra
> cost.

I don't think it's a good idea to rely on that index, as it is anything
but stable. It represents whatever order commits happened to be first
touched in the current program run. So:

  1. Performing the same operation in-process versus in a sub-process
     may produce different results.

  2. Arguments to a command may have unexpected effects. E.g.,
     specifying "--tags" to "rev-list" will look up the commit at
     each tag ref, giving them much lower index numbers than they would
     if we reached only through the normal traversal.

-Peff
