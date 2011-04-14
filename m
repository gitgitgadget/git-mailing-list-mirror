From: Jeff King <peff@peff.net>
Subject: Re: [BUG] format-patch does not wrap From-field after author name
Date: Thu, 14 Apr 2011 18:29:40 -0400
Message-ID: <20110414222940.GA19389@sigill.intra.peff.net>
References: <BANLkTimruwojkq_HNMZeCDBV6K8_aFc_XQ@mail.gmail.com>
 <7v39lkiwoj.fsf@alter.siamese.dyndns.org>
 <20110414175034.GA23342@sigill.intra.peff.net>
 <BANLkTin+K46_RSDsYWHso3v7Gpe_k+0m8Q@mail.gmail.com>
 <20110414214230.GB7709@sigill.intra.peff.net>
 <BANLkTikgZH8135=o5ODcA=780-1D7YFngw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Fri Apr 15 00:29:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QAV2q-0007qN-QT
	for gcvg-git-2@lo.gmane.org; Fri, 15 Apr 2011 00:29:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754055Ab1DNW3n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Apr 2011 18:29:43 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:52665
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753925Ab1DNW3m (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Apr 2011 18:29:42 -0400
Received: (qmail 4647 invoked by uid 107); 14 Apr 2011 22:30:33 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 14 Apr 2011 18:30:33 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 14 Apr 2011 18:29:40 -0400
Content-Disposition: inline
In-Reply-To: <BANLkTikgZH8135=o5ODcA=780-1D7YFngw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171569>

On Fri, Apr 15, 2011 at 12:21:24AM +0200, Erik Faye-Lund wrote:

> >> True. But since the fix is as simple as it is, perhaps it's worth it
> >> just for the clean conscience?
> >
> > Fair enough. Patch to follow.
> >
> 
> Thinking about it a bit more, I'm getting a bit more unsure:
> - The 78-limit is about user-interfaces, not protocol robustness.

True. In theory we should also be limiting to avoid the 998-character
hard protocol limit, but that is getting ridiculously unlikely.

> - Since send-email unwraps the line and does not re-wrap it, even if
> we have a name like this it's likely that the work gets undone right
> away.

Not everybody uses send-email. So you are also helping MUAs which
consume the output of format-patch.

That being said, I doubt that this will make a difference to anybody.
The real reason that we put wrapping into add_rfc2047 was for subjects,
which _do_ get long.

> - So that means that send-email should probably also be fixed. But now
> I'm wondering if we've crossed the point where this will just lead to
> less obvious code for very little gain.

It is ugly code.

I'm just as happy if we drop it.

> > Because it means we have to _parse_ those
> > headers and understand which part is a name and which is an address.
> 
> That part is surprisingly easy: If it contains a '<', then it's on the form
> "Foo Bar Baz <foo@bar.baz>". If not, it's "foo@bar.baz" (assuming it's
> UTF-8 encoded rfc5322 mailbox'es we assume, which would make the most
> sense to me)

What about:

  "Foo \"The Bar\" Baz" <foo@example.com>

or

  Foo "The Bar" Baz <foo@example.com>

or

  Foo (The Bar) Baz <foo@example.com>

I.e., are we taking rfc822-style addresses, or are we taking something
that looks vaguely like an email address, and just treating everything
left of "<" as literal?

-Peff
