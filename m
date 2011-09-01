From: Jeff King <peff@peff.net>
Subject: Re: Funnies with "git fetch"
Date: Thu, 1 Sep 2011 19:31:08 -0400
Message-ID: <20110901233108.GA9339@sigill.intra.peff.net>
References: <7vpqjkw3nb.fsf@alter.siamese.dyndns.org>
 <7vpqjjnau1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 02 01:31:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QzGj7-0007Uo-EK
	for gcvg-git-2@lo.gmane.org; Fri, 02 Sep 2011 01:31:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932623Ab1IAXbM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Sep 2011 19:31:12 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:47732
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932506Ab1IAXbK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Sep 2011 19:31:10 -0400
Received: (qmail 25499 invoked by uid 107); 1 Sep 2011 23:31:56 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 01 Sep 2011 19:31:56 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 01 Sep 2011 19:31:08 -0400
Content-Disposition: inline
In-Reply-To: <7vpqjjnau1.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180583>

On Thu, Sep 01, 2011 at 03:42:46PM -0700, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
> 
> > I think the breakages are:
> >
> >  - The sending side does not give any indication that it _wanted_ to send
> >    ce0136 but couldn't, and ended up sending another object;

This isn't fixable without the server re-hashing every outgoing object,
though, is it? It thinks it has ce0136, but the data is corrupted. The
only way to detect that is to rehash each object that we send. That's
pretty expensive when you consider decompression and delta
reconstruction.

Besides which, it doesn't help many malicious cases at all. It will
handle disk corruption or a malicious object-db tweak. But it does
nothing against an attacker who can trojan git, or who can spoof the
network session (which is probably hard to do if its straight ssh, but
keep in mind that traffic may be going through cleartext proxies).

So it seems that the receiving side is the only sensible place to put
such checks. It catches problems at more levels, and it can generally
afford the extra processing load (under the assumption that pushes to
servers are smaller and less frequent than fetches).

> >  - The pack data sent over the wire was self consistent (no breakage here)
> >    and sent three well-formed objects, but it was inconsistent with
> >    respect to what history was being transferred (breakage is here);

I don't think this matters. We have thin packs, after all. What goes on
the wire doesn't have to be sensible unto itself; it's about whether
the receiving end can do something useful with it.

> >  - The receiving end did not notice the inconsistency.
> >
> > The first one is of the lower priority, as the client side should be able
> > to notice an upstream with corruption in any case. Perhaps after asking
> > for objects between "have" and "want", "git fetch" should verify that it
> > can fully walk the subhistory that was supposed to be transferred down to
> > the blob level?

That seems like a sensible improvement to me.

> So I have a series to fix the latter "more important" half I'll be sending
> out in this thread.

If I understand correctly, your series is just about checking that we
have newly-referenced blobs. We were already checking commits and trees,
and we should already be hashing individual objects when we index the
pack. Right?

In that case, the performance change should be negligible.

-Peff
