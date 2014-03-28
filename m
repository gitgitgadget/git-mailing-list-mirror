From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] t4212: handle systems with post-apocalyptic gmtime
Date: Fri, 28 Mar 2014 15:05:48 -0400
Message-ID: <20140328190548.GB30739@sigill.intra.peff.net>
References: <xmqqr45oixa6.fsf@gitster.dls.corp.google.com>
 <20140326192536.GA13989@sigill.intra.peff.net>
 <20140326193359.GA14105@sigill.intra.peff.net>
 <20140326212227.GC6991@hashpling.org>
 <20140326215741.GA17716@sigill.intra.peff.net>
 <20140326224616.GA9454@hashpling.org>
 <20140327224837.GB32434@sigill.intra.peff.net>
 <xmqqd2h6cm26.fsf@gitster.dls.corp.google.com>
 <20140328184710.GA29987@sigill.intra.peff.net>
 <xmqqppl69meh.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Charles Bailey <cbailey32@bloomberg.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 28 20:05:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WTc6F-0006Wi-1t
	for gcvg-git-2@plane.gmane.org; Fri, 28 Mar 2014 20:05:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752153AbaC1TFu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Mar 2014 15:05:50 -0400
Received: from cloud.peff.net ([50.56.180.127]:49533 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751680AbaC1TFu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Mar 2014 15:05:50 -0400
Received: (qmail 850 invoked by uid 102); 28 Mar 2014 19:05:49 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 28 Mar 2014 14:05:49 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 28 Mar 2014 15:05:48 -0400
Content-Disposition: inline
In-Reply-To: <xmqqppl69meh.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245416>

On Fri, Mar 28, 2014 at 12:02:46PM -0700, Junio C Hamano wrote:

> >>  - teach the "is the result sane, even though we may have got a
> >>    non-NULL from gmtime?  otherwise let's signal a failure by
> >>    replacing it with a known sentinel value" codepath the new
> >>    failure mode Charles's report suggests---if we feed a positive
> >>    timestamp and gmtime gave us back a tm_year+1900 < 0, that is
> >>    certainly an overflow; and
> >
> > I don't think we can analyze the output from gmtime. If it wraps the
> > year at N, then won't N+2014 look like a valid value?
> 
> Yes, but I was hoping that there are small number of possible N's
> ;-)

I'm not sure I understand. Even if we know N, we've lost information
during the truncation done by time_t (we cannot distingiuish true M from
N+M).

> > diff --git a/date.c b/date.c
> > index e1a2cee..e0c43c4 100644
> > --- a/date.c
> > +++ b/date.c
> > @@ -57,6 +57,8 @@ static time_t gm_time_t(unsigned long time, int tz)
> >  static struct tm *time_to_tm(unsigned long time, int tz)
> >  {
> >  	time_t t = gm_time_t(time, tz);
> > +	if (t > 9999999999999999)
> > +		return NULL;
> >  	return gmtime(&t);
> >  }
> >
> > I suspect that would handle the FreeBSD case, as well.
> >
> > By the way, I have a suspicion that the gm_time_t above can overflow if
> > you specially craft a value at the edge of what time_t can handle (we
> > check that our value will not overflow time_t earlier, but now we might
> > be adding up to 86400 seconds to it). <sigh>
> 
> Yuck.  Let's not go there.

Do you mean "let's not worry about the absurdly specific overflow case",
or "let's not do this gross time_to_tm hack?"

This (non-)issue has consumed a lot more brain power than it is probably
worth. I'd like to figure out which patch to go with and be done. :)

-Peff
