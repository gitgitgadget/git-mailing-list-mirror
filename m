From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 0/2] fix clone guess_dir_name regression in v2.4.8
Date: Wed, 5 Aug 2015 17:04:54 -0400
Message-ID: <20150805210454.GA21134@sigill.intra.peff.net>
References: <CAHGBnuNLoNsxPK4YQ+HnT_q8F-HrVC_y9pZwB4G88jCq0-wCPg@mail.gmail.com>
 <0000014e740f7a8a-2c988a36-633e-4b30-8024-cb4a1de1a8a2-000000@eu-west-1.amazonses.com>
 <20150804043401.4494.43725@typhoon>
 <CAHGBnuMXkqhFUhen9tPfEsfFAHhbqMeFUxvePS_6A-TtMfZpzg@mail.gmail.com>
 <20150804224246.GA29051@sigill.intra.peff.net>
 <20150805083526.GA22325@sigill.intra.peff.net>
 <xmqq8u9p4pqb.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Sebastian Schuberth <sschuberth@gmail.com>,
	Patrick Steinhardt <ps@pks.im>,
	Lukas Fleischer <lfleischer@lfos.de>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 05 23:05:07 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZN5s2-0005v1-VH
	for gcvg-git-2@plane.gmane.org; Wed, 05 Aug 2015 23:05:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753731AbbHEVFA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Aug 2015 17:05:00 -0400
Received: from cloud.peff.net ([50.56.180.127]:41279 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752682AbbHEVE7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Aug 2015 17:04:59 -0400
Received: (qmail 18306 invoked by uid 102); 5 Aug 2015 21:04:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 05 Aug 2015 16:04:59 -0500
Received: (qmail 32081 invoked by uid 107); 5 Aug 2015 21:05:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 05 Aug 2015 17:05:07 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 05 Aug 2015 17:04:54 -0400
Content-Disposition: inline
In-Reply-To: <xmqq8u9p4pqb.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275396>

On Wed, Aug 05, 2015 at 10:19:56AM -0700, Junio C Hamano wrote:

> >> I think this regression is in v2.4.8, as well. We should be able to use
> >> a running "len" instead of the "end" pointer in the earlier part, and
> >> then use strip_suffix_mem later (to strip from our already-reduced
> >> length, rather than the full NUL-terminated string). Like this:
> >
> > Looks like "git clone --bare host:foo/.git" is broken, too. I've added
> > some tests to cover the recently broken cases, as well as some obvious
> > normal cases (which the patch I sent earlier break!). And as a bonus, we
> > can easily cover Patrick's root-repo problems (so people will actually
> > run the tests, unlike the stuff in t1509. :) ).
> 
> Sorry, my fault; I should have been much less trusting while queuing
> a patch like that offending one that was meant to be a no-op.

I reviewed it, too. :-/

I actually did give some thought to that while working on the fix. Why
did we miss what in retrospect was a pretty obvious bug? I saw two
interesting bits:

  1. From the diff context, it looked like a perfectly reasonable
     change; the shrinking of the "end" pointer happened further up
     in the function.

     So I guess the lesson is not to trust reading just the diff, and
     to really read the whole of the modified function. But that's easy
     to say in retrospect; most of the time the bits outside the context
     aren't interesting, and we can't afford to read the whole code
     base for each patch. It's a judgement call where to stop looking at
     the surrounding context of a given change (e.g., the function, the
     callers, their callers, etc).

  2. We didn't have any test coverage in this area; when I wrote even
     basic tests, it caught the problem.

     I hate to set a rule like "if you are cleaning something up, make
     sure there is decent test coverage". Lots of trivial-looking
     patches really are trivial, and it doesn't make sense to insist the
     submitter add a new battery of tests.

So I dunno. This was definitely preventable, but that is all in
retrospect. Bugs will happen, and we usually catch them while cooking.
The biggest pain is that this slipped through to a release, and that may
just be a measure of how few people were impacted (the cases it affected
were relatively obscure).

-Peff
