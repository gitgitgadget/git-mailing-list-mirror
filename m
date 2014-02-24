From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 4/5] log: handle integer overflow in timestamps
Date: Mon, 24 Feb 2014 15:37:09 -0500
Message-ID: <20140224203709.GA25506@sigill.intra.peff.net>
References: <20140224073348.GA20221@sigill.intra.peff.net>
 <20140224074637.GD9969@sigill.intra.peff.net>
 <xmqqsir88f4n.fsf@gitster.dls.corp.google.com>
 <20140224195829.GA11940@sigill.intra.peff.net>
 <xmqqeh2s8do2.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 24 21:37:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WI2H9-00062O-Qq
	for gcvg-git-2@plane.gmane.org; Mon, 24 Feb 2014 21:37:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752834AbaBXUhM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Feb 2014 15:37:12 -0500
Received: from cloud.peff.net ([50.56.180.127]:56257 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752649AbaBXUhL (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Feb 2014 15:37:11 -0500
Received: (qmail 21341 invoked by uid 102); 24 Feb 2014 20:37:11 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 24 Feb 2014 14:37:11 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 24 Feb 2014 15:37:09 -0500
Content-Disposition: inline
In-Reply-To: <xmqqeh2s8do2.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242643>

On Mon, Feb 24, 2014 at 12:21:33PM -0800, Junio C Hamano wrote:

> >> > +	if (date_overflows(date))
> >> > +		date = 0;
> >> > +	else {
> >> > +		if (ident->tz_begin && ident->tz_end)
> >> > +			tz = strtol(ident->tz_begin, NULL, 10);
> >> > +		if (tz == LONG_MAX || tz == LONG_MIN)
> >> > +			tz = 0;
> >> > +	}
> >> 
> >> ... don't we want to fix an input having a bogus timestamp and also
> >> a bogus tz recorded in it?
> >
> > If there is a bogus timestamp, then we do not want to look at tz at all.
> > We leave it at "0", so that we get a true sentinel:
> 
> Ah, OK, I missed the initialization to 0 at the beginning.
> 
> It might have been more clear if "int tz" declaration were left
> uninitialized, and the variable were explicitly cleared to 0 in the
> "date-overflows" error codepath, but it is not a big deal.

It might be, but I think it would end up cumbersome. The initialization
was already there from the previous version, which was hitting the else
for "ident->tz_begin". Without fallback initializations, you end up with:

  if (ident->date_begin && ident->date_end) {
          date = strtoul(ident->date_begin, NULL, 10);
          if (date_overflows(date)) {
                  date = 0;
                  tz = 0;
          } else {
                  if (ident->tz_begin && ident->tz_end) {
                          tz = strtol(ident->tz_begin, NULL, 10);
                          if (tz == LONG_MAX || tz == LONG_MIN)
                                  tz = 0;
                  } else
                          tz = 0;
          }
  } else {
          date = 0;
          tz = 0;
  }

which I think is much more confusing (and hard to verify that the
variables are always set). Checking !date as an error condition would
make it a little more readable:

  if (ident->date_begin && ident->date_end) {
          date = strtoul(ident->date_begin, NULL, 10);
          if (date_overflows(date))
                  date = 0;
  } else
          date = 0;

  if (date) {
          if (ident->tz_begin && ident->tz_end) {
                  tz = strtol(ident->tz_begin, NULL, 10);
                  if (tz == LONG_MAX || tz == LONG_MIN)
                          tz = 0;
          } else
                  tz = 0;
  } else
          tz = 0;

but then we treat date==0 as a sentinel, and can never correctly parse
dates on Jan 1, 1970.

So I'd be in favor of keeping it as-is, but feel free to mark it up if
you feel strongly.

-Peff
