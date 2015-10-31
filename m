From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] http.c: use CURLOPT_RANGE for range requests
Date: Sat, 31 Oct 2015 13:43:12 -0400
Message-ID: <20151031174312.GA2962@sigill.intra.peff.net>
References: <1446245682-18087-1-git-send-email-dturner@twopensource.com>
 <20151031000837.GA25849@sigill.intra.peff.net>
 <xmqqfv0rhr7m.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: David Turner <dturner@twopensource.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Oct 31 18:43:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZsaBT-0001Hm-PI
	for gcvg-git-2@plane.gmane.org; Sat, 31 Oct 2015 18:43:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752208AbbJaRnP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Oct 2015 13:43:15 -0400
Received: from cloud.peff.net ([50.56.180.127]:50956 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751478AbbJaRnP (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Oct 2015 13:43:15 -0400
Received: (qmail 13581 invoked by uid 102); 31 Oct 2015 17:43:15 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 31 Oct 2015 12:43:15 -0500
Received: (qmail 32207 invoked by uid 107); 31 Oct 2015 17:43:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 31 Oct 2015 13:43:40 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 31 Oct 2015 13:43:12 -0400
Content-Disposition: inline
In-Reply-To: <xmqqfv0rhr7m.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280595>

On Sat, Oct 31, 2015 at 10:40:13AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > We could even hide the whole thing away with something like:
> >
> >   void http_set_range(CURL *curl, long lo, long hi)
> >   {
> > 	char buf[128];
> > 	int len = 0;
> >
> > 	if (lo >= 0)
> > 		len += xsnprintf(buf + len, "%ld", lo);
> > 	len += xsnprintf(buf + len, "-");
> > 	if (hi >= 0)
> > 		len += xsnprintf(buf + len, "%ld", hi);
> >
> > 	curl_easy_setopt(curl, CURLOPT_RANGE, buf);
> >   }
> >
> > That would also make it easier to replace if we do need to keep an
> > #ifdef for older versions of curl. But maybe it is just
> > over-engineering.
> 
> I personally do not think this is an over-engineered version.  This
> is exactly what I had in mind when I alluded to a small helper ;-)

Yeah, I somehow missed your suggestion before writing that. I think the
important thing your example noted is that we would always pass -1 for
"hi" in all the current callers, so we can simplify this quite a bit,
and use only one snprintf.

-Peff
