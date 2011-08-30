From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] git-for-each-ref: move GPG sigs off %(body) to
 %(signature).
Date: Tue, 30 Aug 2011 12:27:43 -0400
Message-ID: <20110830162743.GB15790@sigill.intra.peff.net>
References: <20110829213757.GB14299@sigill.intra.peff.net>
 <1314694641-24148-1-git-send-email-mgorny@gentoo.org>
 <4E5CB0D0.7000905@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?TWljaGHFgiBHw7Nybnk=?= <mgorny@gentoo.org>,
	git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Tue Aug 30 18:27:52 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QyRAG-0004wW-1r
	for gcvg-git-2@lo.gmane.org; Tue, 30 Aug 2011 18:27:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755593Ab1H3Q1q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 30 Aug 2011 12:27:46 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:41939
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753315Ab1H3Q1q (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 30 Aug 2011 12:27:46 -0400
Received: (qmail 27786 invoked by uid 107); 30 Aug 2011 16:28:30 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 30 Aug 2011 12:28:30 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 30 Aug 2011 12:27:43 -0400
Content-Disposition: inline
In-Reply-To: <4E5CB0D0.7000905@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180416>

On Tue, Aug 30, 2011 at 11:43:44AM +0200, Michael J Gruber wrote:

> > When grabbing a %(body) or %(contents) off a tag, one doesn't really
> > expect to get the GPG signature as well (as it's basically useless
> > without the complete signed text). Thus, strip it off those two tags,
> > and make available via %(signature) if anyone needs it.
> 
> No, please do not change %(contents). It is the complete content which
> (together with the header) enters into the sha1 calculation.
> 
> You will probably also face opposition as regards to %(body), changing
> existing behaviour.

Yeah. If it were 2005, I think it might make sense to have
non-overlapping individual keys to get each part of the tag. But it's
not worth breaking backwards compatibility of "%(body)" today. So it has
to remain as-is, and we have to introduce a new key for "the body
without the signature".

> In fact, I wish we didn't have %(body) but %(contents:body) just like
> other modifiers such as :short.
> 
> I think I'd go for
> 
> %(contents:signature)

That makes some sense to me, though it is a little weird that the
":signature" modifier works only for tags, and not commits. In other
cases, whole keys either work or don't work (e.g., "taggerdate"). But I
guess it is not that big a deal.

> %(contents:subject) the same as %(subject)
> %(contents:body) as contents minus subject minus signature
> 
> and slowly deprecate %(subject) and %(body) (simply un-document for now).

That leaves no way to get what "%(body)" provides now, right? I wonder
if anyone cares. You can always ask for:

  %(contents:body)%(contents:signature)

I guess.

> > +	/* look for GPG signature */
> 
> Again I have to say no. Please look at
> 
> 3d5854e (tag: recognize rfc1991 signatures, 2010-11-10)
> 
> which uses the factored out signature detection as introduced in the
> previous commits. Thanks!

Yeah. More correct, and it's less code, too. :)

-Peff
