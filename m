From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 4/5] log: handle integer overflow in timestamps
Date: Mon, 24 Feb 2014 14:58:29 -0500
Message-ID: <20140224195829.GA11940@sigill.intra.peff.net>
References: <20140224073348.GA20221@sigill.intra.peff.net>
 <20140224074637.GD9969@sigill.intra.peff.net>
 <xmqqsir88f4n.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 24 20:58:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WI1fh-0003zT-RF
	for gcvg-git-2@plane.gmane.org; Mon, 24 Feb 2014 20:58:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753198AbaBXT6d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Feb 2014 14:58:33 -0500
Received: from cloud.peff.net ([50.56.180.127]:56230 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752184AbaBXT6b (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Feb 2014 14:58:31 -0500
Received: (qmail 19113 invoked by uid 102); 24 Feb 2014 19:58:31 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 24 Feb 2014 13:58:31 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 24 Feb 2014 14:58:29 -0500
Content-Disposition: inline
In-Reply-To: <xmqqsir88f4n.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242635>

On Mon, Feb 24, 2014 at 11:50:00AM -0800, Junio C Hamano wrote:

> > We also recognize overflow in the timezone field, which
> > could produce nonsensical results. In this case we show the
> > parsed date, but in UTC.
> 
> Both are good measures to fallback to sanity, but why is that
> if/else?  In other words...
> 
> > +	if (date_overflows(date))
> > +		date = 0;
> > +	else {
> > +		if (ident->tz_begin && ident->tz_end)
> > +			tz = strtol(ident->tz_begin, NULL, 10);
> > +		if (tz == LONG_MAX || tz == LONG_MIN)
> > +			tz = 0;
> > +	}
> 
> ... don't we want to fix an input having a bogus timestamp and also
> a bogus tz recorded in it?

If there is a bogus timestamp, then we do not want to look at tz at all.
We leave it at "0", so that we get a true sentinel:

  Thu Jan 1 00:00:00 1970 +0000

and not:

  Wed Dec 31 19:00:00 1969 -0500

If the timestamp is valid, then we bother to parse the zone, and handle
overflow there.

-Peff
