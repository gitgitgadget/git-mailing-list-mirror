From: Jeff King <peff@peff.net>
Subject: Re: feature suggestion: optimize common parts for checkout
 --conflict=diff3
Date: Thu, 7 Mar 2013 13:01:57 -0500
Message-ID: <20130307180157.GA6604@sigill.intra.peff.net>
References: <20130306150548.GC15375@pengutronix.de>
 <CALWbr2xDYuCN4nd-UNxkAY8-EguYjHBYgfu1fLtOGhYZyRQg_A@mail.gmail.com>
 <20130306200347.GA20312@sigill.intra.peff.net>
 <7vvc94p8hb.fsf@alter.siamese.dyndns.org>
 <20130306205400.GA29604@sigill.intra.peff.net>
 <7vr4jsp756.fsf@alter.siamese.dyndns.org>
 <7vmwugp637.fsf@alter.siamese.dyndns.org>
 <20130307080411.GA25506@sigill.intra.peff.net>
 <7v1ubrnmtu.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Antoine Pelisse <apelisse@gmail.com>,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
	<u.kleine-koenig@pengutronix.de>, git <git@vger.kernel.org>,
	kernel@pengutronix.de
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 07 19:02:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UDf9D-00005F-SK
	for gcvg-git-2@plane.gmane.org; Thu, 07 Mar 2013 19:02:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932366Ab3CGSCE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Mar 2013 13:02:04 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:40196 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932237Ab3CGSCD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Mar 2013 13:02:03 -0500
Received: (qmail 8138 invoked by uid 107); 7 Mar 2013 18:03:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 07 Mar 2013 13:03:40 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 07 Mar 2013 13:01:57 -0500
Content-Disposition: inline
In-Reply-To: <7v1ubrnmtu.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217604>

On Thu, Mar 07, 2013 at 09:26:05AM -0800, Junio C Hamano wrote:

> Without thinking about it too deeply,...
> 
> I think the "RCS merge" _could_ show it as "1234A<B=X>C<D=Y>E789"
> without losing any information (as it is already discarding what was
> in the original in the part that is affected by the conflict,
> i.e. "56 was there").

Right, I think that is sane, though we do not do that at this point.

> Let's think aloud how "diff3 -m" _should_ split this. The most
> straight-forward representation would be "1234<ABCDE|56=AXCYE>789",
> that is, where "56" was originally there, one side made it to
> "ABCDE" and the other "AXCYE".

Yes, that is what diff3 would do now (because it does not do any hunk
refinement at all), and should continue doing.

> You could make it "1234<AB|5=AX><C|=C><DE|6=YE>789", and that is
> technically correct (what there were in the shared original for the
> conflicted part is 5 and then 6), but the representation pretends
> that it knows more than there actually is information, which may be
> somewhat misleading.  All these three are equally plausible split of
> the original "56":
> 
> 	1234<AB|=AX><C|=C><DE|56=YE>789
> 	1234<AB|5=AX><C|=C><DE|6=YE>789
> 	1234<AB|56=AX><C|=C><DE|=YE>789
> 
> and picking one over others would be a mere heuristic.  All three
> are technically correct representations and it is just the matter of
> which one is the easiest to understand.  So, this is the kind of
> "misleading but not incorrect".

Yes, I agree it is a heuristic about which part of a split hunk to place
deleted preimage lines in. Conceptually, I'm OK with that; the point of
zdiff3 is to try to make the conflict easier to read by eliminating
possibly uninteresting parts. It doesn't have to be right all the time;
it just has to be useful most of the time. But it's not clear how true
that would be in real life.

I think this is somewhat a moot point, though. We do not do this
splitting now. If we later learn to do it, there is nothing to say that
zdiff3 would have to adopt it also; it could stop at a lower
zealous-level than the regular merge markers. I think I'd want to
experiment with it and see some real-world examples before making a
decision on that.

> In all these cases, the middle part would look like this:
> 
> 	<<<<<<< ours
>         C
>         ||||||| base
>         =======
> 	C
>         >>>>>>> theirs
> 
> in order to honor the explicit "I want to view all three versions to
> examine the situation" aka "--conflict=diff3" option.  We cannot
> reduce it to just "C".  That will make it "not just misleading but
> is actively wrong".

I'm not sure I agree. In this output (which does the zealous
simplification, the splitting, and arbitrarily assigns deleted preimage
to the first of the split hunks):

  1234A<B|56=X>C<D|Y>E789

I do not see the promotion of C to "already resolved, you cannot tell if
it was really in the preimage or not" as any more or less misleading or
wrong than that of A or E.  It is no more misleading than what the
merge-marker case would do, which would be:

  1234A<B=X>C<D=Y>E789

The wrong thing to me is the arbitrary choice about how to distribute
the preimage lines. In this example, it is not a big deal for the
heuristic to be wrong; you can see both of the hunks. But if C is long,
and you do not even see D=Y while resolving B=X, seeing the preimage
there may become nonsensical.

But again, we don't do this splitting now. So I don't think it's
something that should make or break a decision to have zdiff3. Without
the splitting, I can see it being quite useful. I'm going to carry the
patch in my tree for a while and try using it in practice for a while.

-Peff
