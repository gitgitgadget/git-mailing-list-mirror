From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 15/67] convert trivial sprintf / strcpy calls to xsnprintf
Date: Wed, 16 Sep 2015 16:32:23 -0400
Message-ID: <20150916203223.GC3915@sigill.intra.peff.net>
References: <20150915152125.GA27504@sigill.intra.peff.net>
 <20150915153637.GO29753@sigill.intra.peff.net>
 <CAPig+cR9n=hT3F-0uDbJT_Z9REe83-kFKR5XB6pVrHRe0Z14eA@mail.gmail.com>
 <20150916094814.GB13966@sigill.intra.peff.net>
 <xmqqh9muql2c.fsf@gitster.mtv.corp.google.com>
 <20150916185256.GA2654@sigill.intra.peff.net>
 <xmqq1tdyqj2l.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	Git List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Sep 16 22:32:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZcJNd-000748-IZ
	for gcvg-git-2@plane.gmane.org; Wed, 16 Sep 2015 22:32:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752311AbbIPUcd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Sep 2015 16:32:33 -0400
Received: from cloud.peff.net ([50.56.180.127]:60325 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751965AbbIPUcc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Sep 2015 16:32:32 -0400
Received: (qmail 24792 invoked by uid 102); 16 Sep 2015 20:32:32 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 16 Sep 2015 15:32:32 -0500
Received: (qmail 23028 invoked by uid 107); 16 Sep 2015 20:32:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 16 Sep 2015 16:32:35 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 16 Sep 2015 16:32:23 -0400
Content-Disposition: inline
In-Reply-To: <xmqq1tdyqj2l.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278062>

On Wed, Sep 16, 2015 at 12:07:30PM -0700, Junio C Hamano wrote:

> > Correct. The original is sane and gcc does the right thing. The question
> > is whether some compiler would complain that "stage" is not a constant
> > in the sizeof() expression. I don't know if any compiler would do so,
> > but it is easy enough to be conservative.
> 
> Wouldn't such a compiler also complain if you did this, though?
> 
> 	int *pointer_to_int;
>         size_t sz = sizeof(*pointer_to_int);
>
> You (as a complier) do not know exactly where ownbuf[stage] is,
> because "stage" is unknown to you.  In the same way, you do not know
> exactly where *pointer_to_int is.  But of course, what the sizeof()
> operator is being asked is the size of the thing, which does not
> depend on where the thing is.  If you (as a compiler) does not know
> that and complain to ownbuf[stage], wouldn't you complain to the
> pointer dereference, too?

I think it depends on how crappily the compiler is implemented. I agree
that sizeof(ownbuf[stage]) is a reasonable thing to ask for without
knowing the exact value of stage. But I could also see it being a
mistake an old or badly written compiler might make.

But we are theorizing without data. I'm happy to leave it as in my
original and wait to see if anybody ever complains.

> A more important reason I am reluctant to see this:
> 
> 	xsnprintf(ownbuf[stage], sizeof(ownbuf[0]), "%o", ...);
> 
> is that it looks strange in the same way as this
> 
> 	memcpy(ownbuf[stage], src, sizeof(ownbuf[0]));
> 
> looks strange.  "We use the size of one thing to stuff into another".
> 
> That will make future readers wonder "Is this a typo, and if it is,
> which index is a mistake I can fix?" and may lead to an unnecessary
> confusion.  I do not want to see a correctly written
> 
> 	xsnprintf(ownbuf[stage], sizeof(ownbuf[0]), "%o", ...);
> 
> turned into
> 
> 	xsnprintf(ownbuf[0], sizeof(ownbuf[0]), "%o", ...);
> 
> out of such a confusion.

I think that's a reasonable concern.

-Peff
