From: Jeff King <peff@peff.net>
Subject: Re: textconv not invoked when viewing merge commit
Date: Thu, 14 Apr 2011 17:30:06 -0400
Message-ID: <20110414213006.GA7709@sigill.intra.peff.net>
References: <201104111912.47547.kumbayo84@arcor.de>
 <4DA415AB.9020008@drmicha.warpmail.net>
 <20110414190901.GA1184@sigill.intra.peff.net>
 <7vipughbxh.fsf@alter.siamese.dyndns.org>
 <7vd3kohb5n.fsf@alter.siamese.dyndns.org>
 <7v8vvcha2s.fsf@alter.siamese.dyndns.org>
 <20110414202356.GB6525@sigill.intra.peff.net>
 <7vwriwfssc.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Peter Oberndorfer <kumbayo84@arcor.de>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 14 23:30:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QAU7E-00033X-1j
	for gcvg-git-2@lo.gmane.org; Thu, 14 Apr 2011 23:30:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752996Ab1DNVaL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Apr 2011 17:30:11 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:46905
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752722Ab1DNVaK (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Apr 2011 17:30:10 -0400
Received: (qmail 3983 invoked by uid 107); 14 Apr 2011 21:31:00 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 14 Apr 2011 17:31:00 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 14 Apr 2011 17:30:06 -0400
Content-Disposition: inline
In-Reply-To: <7vwriwfssc.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171560>

On Thu, Apr 14, 2011 at 02:05:07PM -0700, Junio C Hamano wrote:

> > Yeah, I think that is pretty readable. But it gives me a funny feeling
> > to encode magic strings inside actual diff output. That is, the output
> > is indistinguishable from a file which contained the "Binary blob..."
> > strings.
>[...]
> 
> Yeah, that may be a sensible concern.
> 
> If we really cared, I would say that plumbing should keep the current
> behaviour (line-by-line even for binaries, and not using textconv unless
> it is asked).

I disagree. Spewing binary contents in the middle of patch output is
wrong and a bug, and we should fix it. Not to mention that the results
are simply incomprehensible in many cases. Binary data isn't
line-oriented, and treating it that way is just going to produce
confusing and useless results. Not to mention that I wouldn't be
surprised if embedded NULs in the data are not being handled properly by
the diff code.

I would much rather have it say "Binary files differ". It's not that
informative, but at least you don't waste a lot of time trying to figure
out what in the world it means.

> Having said all that, I don't think we made -c/--cc available to plumbing
> on purpose; rather they happen to be available because we thought people
> with common sense wouldn't run things like "diff-tree --c" that are meant
> for human consumption and expect the result to be parsable by their
> scripts. In other words, making the parser barf only for plumbing was not
> worth doing.

Weren't they needed originally for "git rev-list | git diff-tree"? Maybe
they post-date the invention of actual C "git log"; I didn't look. At
any rate, they've been around for a while, and it is not unreasonable
for somebody to want to script around the generation of human-readable
output, so I think they are a good addition.

I think the real argument to be made is that "--cc" was never parseable,
because it can't be applied, and users of the format should know that. I
sort of buy that. Though you could also potentially do other kinds of
analysis on --cc output (e.g., something blame-ish but totally external
to git). And for that you wouldn't want to pretend content was there
that isn't. It's an edge case, certainly, but I don't see any reason not
to be conservative in what we generate. The "Binary files differ" type
of output is not that much harder to generate.

-Peff
