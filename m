From: Jeff King <peff@peff.net>
Subject: Re: approxidate parsing for bad time units
Date: Mon, 10 Sep 2012 17:19:11 -0400
Message-ID: <20120910211911.GA1537@sigill.intra.peff.net>
References: <CAFE6XRFgQa10vTWXfxRG53W6K4U=VGqpK5sQwH7xp9GfKd=2Uw@mail.gmail.com>
 <7vehme3n49.fsf@alter.siamese.dyndns.org>
 <CAFE6XREG5-gwjzvyP9r_hfyY3bWSV2=Bjv9ZbXkejXQRoqYERA@mail.gmail.com>
 <20120907135452.GA1290@sigill.intra.peff.net>
 <CAFE6XRHmX6TjGu7Jte_KW82nYX7ZUw6imO1ktbUcYpNbc6ZBsA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeffrey Middleton <jefromi@gmail.com>
X-From: git-owner@vger.kernel.org Mon Sep 10 23:19:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TBBOL-0000q5-1X
	for gcvg-git-2@plane.gmane.org; Mon, 10 Sep 2012 23:19:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753801Ab2IJVTS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Sep 2012 17:19:18 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:40097 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753725Ab2IJVTQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Sep 2012 17:19:16 -0400
Received: (qmail 1283 invoked by uid 107); 10 Sep 2012 21:19:36 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 10 Sep 2012 17:19:36 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 10 Sep 2012 17:19:11 -0400
Content-Disposition: inline
In-Reply-To: <CAFE6XRHmX6TjGu7Jte_KW82nYX7ZUw6imO1ktbUcYpNbc6ZBsA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205189>

On Mon, Sep 10, 2012 at 02:07:02PM -0700, Jeffrey Middleton wrote:

> As you mentioned, parsing "n ... [month]", and even "...n..." (e.g.
> "the 3rd") as the nth day of a month is great, but in this case, I
> think "n ... ago" is a pretty strong sign that that's not the intended
> behavior.

Yeah, agreed. We are really talking about two distinct cases:

  1. An absolute date ("the 3rd of June", "last tuesday") whose exact
     location may need to be inferred from the context of the current
     date.

  2. A relative unit difference from the current time ("7 days ago")

However, I'm not sure that the word "ago" is always present when
choosing the latter. For example, you can say "7 days" and approxidate
will treat it like "7 days ago". Nor is it simply using a unit like
"days". You can even say "7 tuesdays" to go backwards that many Tuesdays
(e.g., the 24th of July from today).

So you can use "ago" as a sign that you are definitely in case (2), but
cannot assume that its absence means you are in case (1).

That means we can catch "3 dasy ago" as nonsensical, but not "3 dasy",
as the latter simply looks like "the 3rd" from approxidate's
perspective. Still, something is better than nothing, and it means if
you are careful to always say "ago", you can catch some errors (of
course, you might typo "ago"... :) ).

> My first thought was just to make it an error if the string ends in
> "ago" but the date is parsed as a day of the month. You don't actually
> have to come up with any typos to blacklist, just keep the "ago" from
> being silently ignored. I suspect "n units ago" is by far the most
> common use of the approxidate parsing in the wild, since it's
> documented and has been popularized online. So throwing an error just
> in that case would save essentially everyone. I hadn't even realized
> it worked without "ago" until I looked at the code.

Yeah, I think that would work, and would provide some safety. And it
shouldn't be too hard to implement.

> If that doesn't sound like a good plan, then yes, I agree, it'd be
> tricky to catch it in the general case without breaking things.
> (Levenshtein distance to the target strings instead of exact matching,
> I guess, so that it could say "did you mean..." like for misspelled
> commands.)

Gross. :)

-Peff
