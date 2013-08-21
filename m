From: Jeff King <peff@peff.net>
Subject: [RFC/PATCH 0/4] duplicate objects in packfiles
Date: Wed, 21 Aug 2013 16:49:55 -0400
Message-ID: <20130821204955.GA28025@sigill.intra.peff.net>
References: <20130814181718.GA7911@sigill.intra.peff.net>
 <7v4nast9bv.fsf@alter.siamese.dyndns.org>
 <7vvc38ruah.fsf@alter.siamese.dyndns.org>
 <20130816150138.GA4823@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Nicolas Pitre <nico@fluxnic.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 21 22:50:10 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VCFM1-0006Me-2I
	for gcvg-git-2@plane.gmane.org; Wed, 21 Aug 2013 22:50:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753005Ab3HUUt7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Aug 2013 16:49:59 -0400
Received: from cloud.peff.net ([50.56.180.127]:49697 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752998Ab3HUUt6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Aug 2013 16:49:58 -0400
Received: (qmail 11428 invoked by uid 102); 21 Aug 2013 20:49:58 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 21 Aug 2013 15:49:58 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 21 Aug 2013 16:49:55 -0400
Content-Disposition: inline
In-Reply-To: <20130816150138.GA4823@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232731>

On Fri, Aug 16, 2013 at 11:01:38AM -0400, Jeff King wrote:

> That makes me inclined to teach index-pack to reject duplicate objects
> in a single pack in order to prevent denial-of-service attacks. We can
> potentially make them work in all code paths, but given that nobody
> should be doing this legitimately, rejecting the duplicates outright
> keeps our attack surface small, and nobody but attackers or users of
> broken implementations should care.

Here's a patch series in that direction:

  [1/4]: sha1-lookup: handle duplicate keys with GIT_USE_LOOKUP

This reproduces and fixes the sha1-lookup bug. We should do this no
matter what else we do.

  [2/4]: index-pack: optionally reject packs with duplicate objects

This adds a pack.indexDuplicates option so that sites receiving
packfiles from random folks on the internet can protect themselves from
the potential denial-of-service mentioned above. The default remains to
allow it.

  [3/4]: reject duplicates when indexing a packfile we created

This is a safety check for packs we generate. Optional, but I think it's
probably a good idea (and doesn't cost very much).

  [4/4]: index-pack: optionally skip duplicate packfile entries

I really wanted to have a "fix" mode where we could take in packs with
duplicate entries and just use them as-is. It's not correct to throw
away the duplicates (they may be bases in a delta cycle), but we could
maybe get by with simply not referencing them in the pack index.
Unfortunately, the pack reader does not like the index we generate; see
the patch for details and possible solutions (all of which are ugly).
And it only helps in a delta cycle when delta base offsets are used.

I had hoped to have a 5/4 flipping the default to "skip", since it would
potentially fix the infinite loop problem and wouldn't have a downside.
But since it doesn't work (and cannot fix the REF_DELTA case), it seems
like a bad idea.

Which leaves the open question: should the default for index-pack flip
to reject duplicates rather than allow? It seems like it would be worth
it to identify buggy packfiles before they move between repos. And in an
emergency, we have the config flag to be more permissive in case
somebody really needs to move the data via git.

Thoughts?

-Peff
