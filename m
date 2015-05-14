From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] log: do not shorten decoration names too early
Date: Thu, 14 May 2015 14:10:08 -0400
Message-ID: <20150514181008.GA8486@peff.net>
References: <55534D95.60609@alum.mit.edu>
 <xmqqwq0c9zc1.fsf@gitster.dls.corp.google.com>
 <xmqqsib09z8y.fsf@gitster.dls.corp.google.com>
 <xmqqoalo9sgc.fsf_-_@gitster.dls.corp.google.com>
 <20150514063317.GA22509@peff.net>
 <xmqq8ucr83h8.fsf@gitster.dls.corp.google.com>
 <20150514174945.GB7966@peff.net>
 <xmqqzj576nts.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	git discussion list <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 14 20:10:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YsxaK-0003RR-1s
	for gcvg-git-2@plane.gmane.org; Thu, 14 May 2015 20:10:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964796AbbENSKL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 May 2015 14:10:11 -0400
Received: from cloud.peff.net ([50.56.180.127]:58684 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753312AbbENSKL (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 May 2015 14:10:11 -0400
Received: (qmail 16777 invoked by uid 102); 14 May 2015 18:10:10 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 14 May 2015 13:10:10 -0500
Received: (qmail 25789 invoked by uid 107); 14 May 2015 18:10:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 14 May 2015 14:10:10 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 14 May 2015 14:10:08 -0400
Content-Disposition: inline
In-Reply-To: <xmqqzj576nts.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269060>

On Thu, May 14, 2015 at 11:01:03AM -0700, Junio C Hamano wrote:

> > So with your slab_peek() below, I'd guess that the slab would actually
> > be faster. But I'd also be unsurprised if it makes no appreciable
> > difference to the overall runtime of "git log --decorate". I think we'd
> > have to build it and profile (and please feel free to say "eh, not worth
> > the time to think about further").
> 
> While I think *slabname##_peek() would be worth doing regardless of
> this caller, I suspect that the major overhead of decorate code
> would come from the for_each_ref() that jumps deep into the history
> to parse old commits; it would trigger a lot of unpacking of objects
> deep in the delta chain, which would be expensive than table look-up
> in either scheme.

That would depend on the particular repository and traversal. The
expensive "load an old commit" work is done once per ref in the repo.
The lookup work is done once per commit traversed. So even if the latter
is much less work, we are typically doing it many more times, and there
is probably a balance point.

But I suspect all of it compares to the actual work of a "git log" which
has to read all of the commits we are looking at anyway. IOW, we are
probably talking about optimizing 1%, while the other 99% is spent on
inflate(), etc.

-Peff
