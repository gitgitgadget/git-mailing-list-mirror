From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] t4212: handle systems with post-apocalyptic gmtime
Date: Tue, 1 Apr 2014 15:46:06 -0400
Message-ID: <20140401194606.GA20676@sigill.intra.peff.net>
References: <20140326215741.GA17716@sigill.intra.peff.net>
 <20140326224616.GA9454@hashpling.org>
 <20140327224837.GB32434@sigill.intra.peff.net>
 <xmqqd2h6cm26.fsf@gitster.dls.corp.google.com>
 <20140328184710.GA29987@sigill.intra.peff.net>
 <xmqqppl69meh.fsf@gitster.dls.corp.google.com>
 <20140328190548.GB30739@sigill.intra.peff.net>
 <xmqq8uru9l51.fsf@gitster.dls.corp.google.com>
 <20140401073848.GA22023@sigill.intra.peff.net>
 <xmqqbnwk27it.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
	Charles Bailey <cbailey32@bloomberg.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 01 21:46:16 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WV4dT-0004eB-65
	for gcvg-git-2@plane.gmane.org; Tue, 01 Apr 2014 21:46:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751363AbaDATqK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 1 Apr 2014 15:46:10 -0400
Received: from cloud.peff.net ([50.56.180.127]:51991 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751233AbaDATqI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Apr 2014 15:46:08 -0400
Received: (qmail 19915 invoked by uid 102); 1 Apr 2014 19:46:08 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 01 Apr 2014 14:46:08 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 01 Apr 2014 15:46:06 -0400
Content-Disposition: inline
In-Reply-To: <xmqqbnwk27it.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245639>

On Tue, Apr 01, 2014 at 12:07:22PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > On Fri, Mar 28, 2014 at 12:30:02PM -0700, Junio C Hamano wrote:
> >
> >> Let's just deal with a simple known cases (like FreeBSD) in the real
> >> code that everybody exercises at runtime, and have the new test only
> >> check we do not segfault on a value we used to segfault upon seeing.
> >
> > OK. Here it is, with the other option as an "alt" patch for reference.
> >
> >   [1/2]: date: recognize bogus FreeBSD gmtime output
> >   [2/2]: t4212: loosen far-in-future test for AIX
> >   [2alt/2]: work around unreliable gmtime errors on AIX
> >
> > -Peff
> 
> Thanks.  2alt does not look too bad, but on the other hand, we are
> replacing a value that can produce the right result on correctly
> implemented gmtime with a completely bogus value only because we
> know there exists one broken implementation---which does not sound a
> very good trade-off, given that we would get a result that does not
> correspond to the input anyway with or without the change on the
> broken implementation.

One other option is to push _all_ callers through a git_gmtime()
wrapper, and then use Makefile knobs to turn on specific quirks, like:

    struct tm *git_gmtime_r(const time_t *timep, struct tm *result)
    {
    #ifdef GMTIME_OVERFLOWS_32BIT
              if (*timep > 999999999999999)
                        return NULL;
    #endif

              ret = gmtime_r(timep, result);

    #ifdef GMTIME_ERROR_BLANK
              if (ret && !ret->tm_mday)
                        return NULL;
    #endif

              return ret;
    }

and then each platform can turn the knobs as appropriate.

-Peff
