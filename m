From: Jeff King <peff@peff.net>
Subject: Re: [BUG] two-way read-tree can write null sha1s into index
Date: Thu, 3 Jan 2013 15:23:43 -0500
Message-ID: <20130103202343.GA4632@sigill.intra.peff.net>
References: <20120728150132.GA25042@sigill.intra.peff.net>
 <20120728150524.GB25269@sigill.intra.peff.net>
 <20121229100130.GA31497@elie.Belkin>
 <20121229102707.GA26730@sigill.intra.peff.net>
 <20121229103430.GG18903@elie.Belkin>
 <20121229110541.GA1408@sigill.intra.peff.net>
 <20121229205154.GA21058@sigill.intra.peff.net>
 <7vvcbg7d8x.fsf@alter.siamese.dyndns.org>
 <20130103083712.GC32377@sigill.intra.peff.net>
 <7vehi2xote.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 03 21:24:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TqrKg-0007Dw-1S
	for gcvg-git-2@plane.gmane.org; Thu, 03 Jan 2013 21:24:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753728Ab3ACUXr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jan 2013 15:23:47 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:42279 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753544Ab3ACUXq (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jan 2013 15:23:46 -0500
Received: (qmail 10124 invoked by uid 107); 3 Jan 2013 20:24:57 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 03 Jan 2013 15:24:57 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 03 Jan 2013 15:23:43 -0500
Content-Disposition: inline
In-Reply-To: <7vehi2xote.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212605>

On Thu, Jan 03, 2013 at 07:34:53AM -0800, Junio C Hamano wrote:

> > Good point; I was just thinking about the --reset case.
> >
> > With "-m", though, we could in theory carry over the unmerged entries
> > (again, assuming that "old" and "new" are the same; otherwise it is an
> > obvious reject). But those entries would be confused with any new
> > unmerged entries we create. It seems we already protect against this,
> > though: "read-tree -m" will not run at all if you have unmerged entries.
> >
> > Likewise, "checkout" seems to have similar protections.
> >
> > So I think it may be a non-issue.
> 
> Yeah.  Also earlier in the thread you mentioned three-way case, but
> I do not think we ever would want --reset with three trees, so I
> think that too is a non-issue for the same reason.

Yeah, agreed; we should always reject in the three-way case. I would
worry more that it has a bug where something is _not_ rejected, and we
end up putting a bogus null sha1 entry into the index (which is the
actual problem with twoway_merge). IOW, if we have the bogus sha1 in the
index (because we marked it with CE_CONFLICTED), and the two sides and
the common ancestor are all the same, would we blindly carry through the
bogus conflicted entry (which we would prefer, because it has the
up-to-date stat information)?

Or are you suggesting that the three-way case should always be protected
by checking that there are no unmerged entries before we start it? That
seems sane to me, but I haven't confirmed that that is the case.

> I would still feel safer if we expressed the expectation of
> the callee in the code, perhaps like this in the two-way case:
> 
> 	if (current->ce_flags & CE_CONFLICTED) {
>         	if (!o->reset) {
>                 	... either die or fail ...
> 		} else {
>                 	... your fix ...
> 		}
> 	}

Agreed. I looked at that, but it seemed like it was going to involve
repeating a lot of the "are the two trees the same" logic. Let me see if
I can refactor it to avoid that.

-Peff
