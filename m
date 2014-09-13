From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v4 00/32] Lockfile correctness and refactoring
Date: Sat, 13 Sep 2014 14:51:01 -0400
Message-ID: <20140913185101.GA24773@peff.net>
References: <1409989846-22401-1-git-send-email-mhagger@alum.mit.edu>
 <20140910081358.GB16413@peff.net>
 <54130155.90707@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Sat Sep 13 20:51:18 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XSsPm-0007fS-7Z
	for gcvg-git-2@plane.gmane.org; Sat, 13 Sep 2014 20:51:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752078AbaIMSvI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Sep 2014 14:51:08 -0400
Received: from cloud.peff.net ([50.56.180.127]:47776 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752064AbaIMSvF (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Sep 2014 14:51:05 -0400
Received: (qmail 5199 invoked by uid 102); 13 Sep 2014 18:51:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 13 Sep 2014 13:51:04 -0500
Received: (qmail 10011 invoked by uid 107); 13 Sep 2014 18:51:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 13 Sep 2014 14:51:25 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 13 Sep 2014 14:51:01 -0400
Content-Disposition: inline
In-Reply-To: <54130155.90707@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256970>

On Fri, Sep 12, 2014 at 04:21:09PM +0200, Michael Haggerty wrote:

> > But I still wonder how hard it would be to just remove lock_file structs
> > from the global list when they are committed or rolled back.
> [...]
>
> To make that change, we would have to remove entries from the list of
> lock_file objects in a way that the code can be interrupted at any time
> by a signal while leaving it in a state that is traversable by the
> signal handler.
> 
> I think that can be done pretty easily with a singly-linked list. But
> with a singly-linked list, we would have to iterate through the list to
> find the node that needs to be removed. This could get expensive if
> there are a lot of nodes in the list (see below).

Yes, I considered that, but noticed that if we actually cleaned up
closed files, the list would not grow to more than a handful of entries.
But...

> The ref-transaction code is, I think, moving in the direction of
> updating all references in a single transaction. This means that we
> would need to hold locks for all of the references at once anyway. So it
> might be all for naught.

That nullifies the whole discussion. Besides the list-traversal thing
above, it would mean that we literally _do_ have all of the lockfiles
open at once. So cleaning up after ourselves would be nice, but it would
not impact the peak memory usage, which would necessarily have one
allocated struct per ref.

The use of a strbuf is probably a big enough change to save us there.
This case was pathological for a few reasons:

  1. A ridiculous number of refs in the repository.

  2. Touching a large number of them in sequence (via pack-refs).

  3. Allocating a 4K buffer per object.

For (3), if the average allocation is dropped even to 400 bytes (which
would accommodate quite a long pathname), that would reduce the memory
usage to ~700MB. Not amazing, but enough not to tip over most modern
machines.

-Peff
