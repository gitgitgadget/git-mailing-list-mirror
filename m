From: Jeff King <peff@peff.net>
Subject: Re: duplicate objects in packfile
Date: Fri, 16 Aug 2013 11:01:38 -0400
Message-ID: <20130816150138.GA4823@sigill.intra.peff.net>
References: <20130814181718.GA7911@sigill.intra.peff.net>
 <7v4nast9bv.fsf@alter.siamese.dyndns.org>
 <7vvc38ruah.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, "Shawn O. Pearce" <spearce@spearce.org>,
	Nicolas Pitre <nico@fluxnic.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 16 17:01:48 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VALX9-0004jB-G0
	for gcvg-git-2@plane.gmane.org; Fri, 16 Aug 2013 17:01:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754712Ab3HPPBm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 16 Aug 2013 11:01:42 -0400
Received: from cloud.peff.net ([50.56.180.127]:57191 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754564Ab3HPPBl (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 16 Aug 2013 11:01:41 -0400
Received: (qmail 32722 invoked by uid 102); 16 Aug 2013 15:01:41 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 16 Aug 2013 10:01:41 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 16 Aug 2013 11:01:38 -0400
Content-Disposition: inline
In-Reply-To: <7vvc38ruah.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232432>

On Wed, Aug 14, 2013 at 11:39:34AM -0700, Junio C Hamano wrote:

> > Older versions of JGit used to put duplicate objects in a pack, and
> > IIRC Shawn declared that a bug in the packer and fixed it, so from
> > that point of view, I think rejecting is probably the right thing,
> > even though I think warning and continuing is also acceptable and
> > indeed may be better.
> 
> Also repacking may have a funny corner case. I do not recall the
> details as the above was a long time ago, but when I was tracking it
> down, a delta was made against one copy of the base object, and
> referred to it using delta-offset, while there was another copy of
> the base object which was found by the bisection search, and from
> there on, the inconsistencies between these two (they represent the
> same payload, but they are at different offsets in the same pack and
> with different in-pack sizes) led to some funky behaviour.

Thanks for the pointer. I found this commit:

  https://eclipse.googlesource.com/jgit/jgit/+/2fbf296fda205446eac11a13abd4fcdb182f28d9

which is presumably what you're thinking of.

I did not run into the problem described in my case, but presumably I
did not have a delta cycle between the multiple versions. In theory we
should find the same copy of the object each time we search, but there
are enough code paths to access the objects that I would not be
surprised if such funkiness is still triggerable, including infinite
loops.

That makes me inclined to teach index-pack to reject duplicate objects
in a single pack in order to prevent denial-of-service attacks. We can
potentially make them work in all code paths, but given that nobody
should be doing this legitimately, rejecting the duplicates outright
keeps our attack surface small, and nobody but attackers or users of
broken implementations should care.

-Peff
