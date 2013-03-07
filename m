From: Jeff King <peff@peff.net>
Subject: Re: feature suggestion: optimize common parts for checkout
 --conflict=diff3
Date: Thu, 7 Mar 2013 03:04:11 -0500
Message-ID: <20130307080411.GA25506@sigill.intra.peff.net>
References: <20130306150548.GC15375@pengutronix.de>
 <CALWbr2xDYuCN4nd-UNxkAY8-EguYjHBYgfu1fLtOGhYZyRQg_A@mail.gmail.com>
 <20130306200347.GA20312@sigill.intra.peff.net>
 <7vvc94p8hb.fsf@alter.siamese.dyndns.org>
 <20130306205400.GA29604@sigill.intra.peff.net>
 <7vr4jsp756.fsf@alter.siamese.dyndns.org>
 <7vmwugp637.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Antoine Pelisse <apelisse@gmail.com>,
	Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
	<u.kleine-koenig@pengutronix.de>, git <git@vger.kernel.org>,
	kernel@pengutronix.de
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 07 09:04:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UDVoq-0003G7-Sy
	for gcvg-git-2@plane.gmane.org; Thu, 07 Mar 2013 09:04:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754487Ab3CGIEQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 Mar 2013 03:04:16 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:39020 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754346Ab3CGIEO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 Mar 2013 03:04:14 -0500
Received: (qmail 4685 invoked by uid 107); 7 Mar 2013 08:05:52 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 07 Mar 2013 03:05:52 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 07 Mar 2013 03:04:11 -0500
Content-Disposition: inline
In-Reply-To: <7vmwugp637.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217578>

On Wed, Mar 06, 2013 at 01:32:28PM -0800, Junio C Hamano wrote:

> > We show "both sides added, either identically or differently" as
> > noteworthy events, but the patched code pushes "both sides added
> > identically" case outside the conflicting hunk, as if what was added
> > relative to the common ancestor version (in Uwe's case, is it 1-14
> > that is common, or just 10-14?) is not worth looking at when
> > considering what the right resolution is.  If it is not worth
> > looking at what was in the original for the conflicting part, why
> > would we be even using diff3 mode in the first place?
> 
> I vaguely recall we did this "clip to eager" as an explicit bugfix
> at 83133740d9c8 (xmerge.c: "diff3 -m" style clips merge reduction
> level to EAGER or less, 2008-08-29).  The list archive around that
> time may give us more contexts.

Thanks for the pointer. The relevant threads are:

  http://article.gmane.org/gmane.comp.version-control.git/94228

and

  http://thread.gmane.org/gmane.comp.version-control.git/94339

There is not much discussion beyond what ended up in 8313374; both Linus
and Dscho question whether level and output format are orthogonal, but
seem to accept the explanation you give in the commit message.

Having read that commit and the surrounding thread, I think I stand by
my argument that "zdiff3" is a useful tool to have, as long as the user
understands what the hunks mean. It should never replace diff3, but I
think it makes sense as a separate format.

I was also curious whether it would the diff3/zealous combination would
trigger any weird corner cases. In particular, I wanted to know how the
example you gave in that commit of:

  postimage#1: 1234ABCDE789
                  |    /
                  |   /
  preimage:    123456789
                  |   \
                  |    \
  postimage#2: 1234AXCYE789

would react with diff3 (this is not the original example, but one with
an extra "C" in the middle of postimage#2, which could in theory be
presented as split hunks). However, it seems that we do not do such hunk
splitting at all, neither for diff3 nor for the "merge" representation.

-Peff
