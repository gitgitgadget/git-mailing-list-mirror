From: Jeff King <peff@peff.net>
Subject: Re: Zero padded file modes...
Date: Thu, 5 Sep 2013 12:33:18 -0400
Message-ID: <20130905163318.GA14338@sigill.intra.peff.net>
References: <CAEBDL5W3DL0v=TusuB7Vg-4bWdAJh5d2Psc1N0Qe+KK3bZH3=Q@mail.gmail.com>
 <20130905153646.GA12372@sigill.intra.peff.net>
 <CACsJy8C4PN4n1W71ajnoyFjaWCsxQjbXMbT-tcfgpXeoJKyXyA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: John Szakmeister <john@szakmeister.net>,
	Git Mailing List <git@vger.kernel.org>,
	Nicolas Pitre <nico@fluxnic.net>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Thu Sep 05 18:33:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VHcUo-0005Rm-N3
	for gcvg-git-2@plane.gmane.org; Thu, 05 Sep 2013 18:33:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753604Ab3IEQdW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Sep 2013 12:33:22 -0400
Received: from cloud.peff.net ([50.56.180.127]:47118 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753584Ab3IEQdV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Sep 2013 12:33:21 -0400
Received: (qmail 22365 invoked by uid 102); 5 Sep 2013 16:33:21 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 05 Sep 2013 11:33:21 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 05 Sep 2013 12:33:18 -0400
Content-Disposition: inline
In-Reply-To: <CACsJy8C4PN4n1W71ajnoyFjaWCsxQjbXMbT-tcfgpXeoJKyXyA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233967>

On Thu, Sep 05, 2013 at 11:18:24PM +0700, Nguyen Thai Ngoc Duy wrote:

> > There are basically two solutions:
> >
> >   1. Add a single-bit flag for "I am 0-padded in the real data". We
> >      could probably even squeeze it into the same integer.
> >
> >   2. Have a "classic" section of the pack that stores the raw object
> >      bytes. For objects which do not match our expectations, store them
> >      raw instead of in v4 format. They will not get the benefit of v4
> >      optimizations, but if they are the minority of objects, that will
> >      only end up with a slight slow-down.
> 
> 3. Detect this situation and fall back to v2.
> 
> 4. Update v4 to allow storing raw tree entries mixing with v4-encoded
> tree entries. This is something between (1) and (2)

I wouldn't want to do (3). At some point pack v4 may become the standard
format, but there will be some repositories which will never be allowed
to adopt it.

For (4), yes, that could work. But like (1), it only solves problems in
tree entries. What happens if we have a quirky commit object that needs
the same treatment (e.g., a timezone that does not fit into the commit
name dictionary properly)?

> I think (4) fits better in v4 design and probably not hard to do. Nico
> recently added a code to embed a tree entry inline, but the mode must
> be encoded (and can't contain leading zeros). We could have another
> code to store mode in ascii. This also makes me wonder if we might
> have similar problems with timezones, which are also specially encoded
> in v4..

Yeah, that might be more elegant.

> (3) is probably easiest. We need to scan through all tree entries
> first when creating v4 anyway. If we detect any anomalies, just switch
> back to v2 generation. The user will be force to rewrite history in
> order to take full advantage of v4 (they can have a pack of weird
> trees in v2 and the rest in v4 pack, but that's not optimal).

Splitting across two packs isn't great, though. What if v4 eventually
becomes the normal on-the-wire format? I'd rather have some method for
just embedding what are essentially v2 objects into the v4 pack, which
would give us future room for handling these sorts of things.

But like I said, I haven't looked closely yet, so maybe there are
complications with that. In the meantime, I'll defer to the judgement of
people who know what they are talking about. :)

-Peff
