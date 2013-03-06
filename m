From: Jeff King <peff@peff.net>
Subject: Re: feature suggestion: optimize common parts for checkout
 --conflict=diff3
Date: Wed, 6 Mar 2013 16:21:40 -0500
Message-ID: <20130306212140.GA30202@sigill.intra.peff.net>
References: <20130306150548.GC15375@pengutronix.de>
 <CALWbr2xDYuCN4nd-UNxkAY8-EguYjHBYgfu1fLtOGhYZyRQg_A@mail.gmail.com>
 <20130306200347.GA20312@sigill.intra.peff.net>
 <7vvc94p8hb.fsf@alter.siamese.dyndns.org>
 <20130306205400.GA29604@sigill.intra.peff.net>
 <7vr4jsp756.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Antoine Pelisse <apelisse@gmail.com>,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
	<u.kleine-koenig@pengutronix.de>, git <git@vger.kernel.org>,
	kernel@pengutronix.de
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 06 22:22:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UDLmr-0006og-5g
	for gcvg-git-2@plane.gmane.org; Wed, 06 Mar 2013 22:22:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755660Ab3CFVVn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Mar 2013 16:21:43 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:38399 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755642Ab3CFVVm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Mar 2013 16:21:42 -0500
Received: (qmail 29951 invoked by uid 107); 6 Mar 2013 21:23:20 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 06 Mar 2013 16:23:20 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 06 Mar 2013 16:21:40 -0500
Content-Disposition: inline
In-Reply-To: <7vr4jsp756.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217547>

On Wed, Mar 06, 2013 at 01:09:41PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > But it would apply to the content that is outside
> > of the hunk marker; we have changed the concept of what is in the base
> > and what is in the conflict by shrinking the conflict to its smallest
> > size.
> 
> Hmm, unless you mean by "base" something entirely different from
> "what was in the common ancestor version", I do not think I can
> agree.

I don't know. I didn't use the word "base" in the first place. I was
trying to figure out what you meant. :)

My point is that the hunk (everything from "<<<" to ">>>") is
self-consistent. It's just misleading in that the hunk has been shrunk
not to include identical bits from each side. IMHO, this is not much
different than a nearby change being auto-resolved. The conflict hunks
the user sees do not represent the original files, but rather the
remains after a first pass at resolving.

> The point of diff3 mode is to show how it looked line in the
> common ancestor and what the conflicting sides want to change that
> common version into; letting the user view three versions to help
> him decide what to do by only looking at the part inside conflict
> markers.

Right, I agree.

> We show "both sides added, either identically or differently" as
> noteworthy events, but the patched code pushes "both sides added
> identically" case outside the conflicting hunk, as if what was added
> relative to the common ancestor version (in Uwe's case, is it 1-14
> that is common, or just 10-14?) is not worth looking at when
> considering what the right resolution is.  If it is not worth
> looking at what was in the original for the conflicting part, why
> would we be even using diff3 mode in the first place?

I think Uwe's example shows that it _is_ useful. Yes, you no longer have
the information about what happened through 1-14 (whether it was really
there in the ancestor file, or whether it was simply added identically).
But that information might or might not be relevant. In Uwe's example,
it is just noise that detracts from the interesting part of the change
(or does it? I think the answer is in the eye of the reader).  I think
it can be helpful to have both types available, and they can pick which
one they want; it's just another tool.

Another argument is that some people (including me) set
merge.conflictstyle to diff3, because they like seeing the extra context
when resolving (I find it helps a lot with rebasing, when it is
sometimes hard to remember which side is which in the merge). I'd
consider setting it to zdiff3 to get the benefits of XDL_MERGE_ZEALOUS,
and using "git checkout --conflict-style=diff3" if I need to get more
information about a specific case.

-Peff
