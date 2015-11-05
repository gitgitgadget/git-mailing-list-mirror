From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] http: use credential API to handle proxy
 authentication
Date: Thu, 5 Nov 2015 12:30:22 -0500
Message-ID: <20151105173021.GA2168@sigill.intra.peff.net>
References: <1445882109-18184-1-git-send-email-k.franke@science-computing.de>
 <1446628405-8070-1-git-send-email-k.franke@science-computing.de>
 <1446628405-8070-3-git-send-email-k.franke@science-computing.de>
 <20151105082421.GB6819@sigill.intra.peff.net>
 <20151105115654.GA6786@science-computing.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Knut Franke <k.franke@science-computing.de>
X-From: git-owner@vger.kernel.org Thu Nov 05 18:30:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZuOMo-0004SP-3r
	for gcvg-git-2@plane.gmane.org; Thu, 05 Nov 2015 18:30:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162041AbbKERa0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Nov 2015 12:30:26 -0500
Received: from cloud.peff.net ([50.56.180.127]:53467 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752928AbbKERaZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Nov 2015 12:30:25 -0500
Received: (qmail 22143 invoked by uid 102); 5 Nov 2015 17:30:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 05 Nov 2015 11:30:24 -0600
Received: (qmail 15867 invoked by uid 107); 5 Nov 2015 17:30:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 05 Nov 2015 12:30:51 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 05 Nov 2015 12:30:22 -0500
Content-Disposition: inline
In-Reply-To: <20151105115654.GA6786@science-computing.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280925>

On Thu, Nov 05, 2015 at 12:56:54PM +0100, Knut Franke wrote:

> My main takeaway from this, apart from the points you mention below, is that
> it'd be good to have a test case, similar to t/lib-httpd.sh. Since none of the
> existent proxy-related code has an automated test, I think this would be an
> improvement on top of the other patches. I'd need to look into how easy/hard
> this would be to implement.

Yeah, tests would be wonderful. I think the main challenge will be
configuring Apache as a proxy (and failing gracefully when mod_proxy is
not available).

If there's another proxy that is easy to configure for a one-shot test,
that would be fine, too. It's nice if it's something that's commonly
available, though, so more people can actually run the test.

> > It looks like you use this to see the remote side's HTTP 407 code.  In
> > the 2012 series, I think we simply looked for a 407 in the HTTP return
> > code
> 
> I'm not sure why that worked for the author of the old series - possibly curl
> semantics changed at some point.

It's not clear to me that the original _did_ work in all cases. So I'll
trust your experiments now much more than that old thread. :)

> > My understanding is that memset() like this is not sufficient for
> > zero-ing sensitive data, as they can be optimized out by the compiler. I
> > don't think there's a portable alternative, though, so it may be the
> > best we can do. OTOH, the rest of git does not worry about such zero-ing
> > anyway, so we could also simply omit it here.
> 
> For what it's worth, that's the same as we do for cert_auth (while, as far as I
> can see, no attempt is made for http_auth). I tend to think it's better than
> nothing. Maybe an in-code comment stating it's not reliable would be in order,
> to prevent the passing reader from putting too much trust in it.

Rather than just a comment, can we do something like:

  void clear_password(void *buf, size_t len)
  {
	/*
	 * TODO: This is known to be insufficient, but perhaps better
	 * than nothing, and at least portable. We should use a more
	 * secure variant on systems that provide it.
	 */
	memset(buf, 0, len);
  }

That will make it easier to find such sites and improve them later
(adding this function in a separate translation unit might actually be
enough to make it work, as the compiler cannot omit a call to the opaque
clear_password, and clear_password itself does not know the results will
not be used).

> > For that matter, it is not clear to me why this needs to be a global at
> > all. Once we hand the value to curl_easy_setopt, curl keeps its own
> > copy.
> 
> That's true only for relatively recent curl versions; before 7.17.0, strings
> were not copied.

Yeah, I remembered that, but I thought for some reason it was old enough
that we didn't need to worry about it. I have a feeling that there may
be other places where we do not handle it that well.

7.17.0 is from 2007. I wonder if it is time we bumped our minimum
required curl version. Supporting older installations is nice, but at
some point it is not really helping anybody, and that has to be
balanced by the increase in code complexity (and especially we are not
helping those people if there are subtle bugs that nobody else is
exercising).

That's a separate topic from your patch, though (though I would not mind
at all if you wanted to work on it :) ).

> > That will require some refactoring around http_request_reauth, though
> > (because now we might potentially retry twice: once to get past the
> > proxy auth, and once to get past the real site's auth).
> 
> I think this would also require changes to post_rpc in remote-curl.c, which
> apparently does something similar to http_request_reauth. Probably something
> along the lines of adding a HTTP_PROXY_REAUTH return code, plus some refactoring
> in order to prevent code duplication between the different code parts handling
> (proxy) reauth. :-/

Yeah, that would work. I think we could also just loop on HTTP_REAUTH.
The code in handle_curl_result that returns HTTP_REAUTH will only do so
if it looks like we could make progress by trying again.

> > You prompt unconditionally for the password earlier, but only if the
> > proxy URL contains a username. We used to do the same thing for regular
> > http, but people got annoyed that they had to specify half the
> > credential in the URL. Perhaps it would be less so with proxies (which
> > are changed a lot less), so I don't think making this work is an
> > absolute requirement.
> 
> As far as I understand, the issue was around unconditionally prompting for the
> password even if it was listed in ~/.netrc. As far as I can see, curl doesn't
> read ~/.netrc for proxy credentials, so I don't think it would make a difference
> here.

The .netrc thing came up recently-ish, but the HTTP prompting issues are
much older than that. Basically, does:

  git config http.proxy http://example.com:8080

work out of the box if example.com requires a username and password? I
think with your patch it doesn't. You need to use
"http://user@example.com:8080" to convince git to prompt at all.

-Peff
