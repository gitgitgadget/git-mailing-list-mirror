From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 3/3] http: when proxy url has username but no
 password, ask for password
Date: Thu, 1 Mar 2012 16:58:12 -0500
Message-ID: <20120301215812.GG17631@sigill.intra.peff.net>
References: <4F4FBE6C.5050507@seap.minhap.es>
 <4F4FB69C.7000708@vilain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Nelson Benitez Leon <nelsonjesus.benitez@seap.minhap.es>,
	git@vger.kernel.org
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Thu Mar 01 22:58:26 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S3E11-00012t-Iy
	for gcvg-git-2@plane.gmane.org; Thu, 01 Mar 2012 22:58:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965338Ab2CAV6S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Mar 2012 16:58:18 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:34618
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S965262Ab2CAV6P (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Mar 2012 16:58:15 -0500
Received: (qmail 9563 invoked by uid 107); 1 Mar 2012 21:58:19 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 01 Mar 2012 16:58:19 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 01 Mar 2012 16:58:12 -0500
Content-Disposition: inline
In-Reply-To: <4F4FB69C.7000708@vilain.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191980>

On Thu, Mar 01, 2012 at 09:49:16AM -0800, Sam Vilain wrote:

> >  	if (curl_http_proxy) {
> >-		curl_easy_setopt(result, CURLOPT_PROXY, curl_http_proxy);
> >+		credential_from_url(&proxy_auth, curl_http_proxy);
> >+		if (proxy_auth.username != NULL&&  proxy_auth.password == NULL) {
> >+			/* proxy string has username but no password, ask for password */
> >+			struct strbuf pbuf = STRBUF_INIT;
> >+			credential_fill(&proxy_auth);
> 
> Wouldn't it be better to wait until the proxy returns a 403 before
> assuming that the proxy setting is incorrect/missing a password?
> What if the administrator expects the user to fill in both the
> username and password?  That is the behaviour of a web browser.
> 
> Also, I think you should wait until that 403 to detect whether the
> proxy setting came from the environment, and only load it explicitly
> then.

It's worth looking at what the http auth code does here.

In the beginning (2005), git saw that there was a username in the URL
and prompted for a password unconditionally before making a request. If
you didn't have a username, you didn't do auth, period.

Later, 42653c0 (Prompt for a username when an HTTP request 401s,
2010-04-01) taught git to handle 401s, for when the URL does not contain
a username. We kept the unconditional pre-prompt, though; it has the
nice side effect of avoiding a round-trip to the server.

Then, in 986bbc0 (http: don't always prompt for password, 2011-11-04),
the unconditional pre-prompt was taken away. While avoiding the
round-trip is nice, it circumvented curl's reading of the .netrc file,
which means git would prompt unnecessarily, even when curl could
eventually read out of the netrc.

However, the code for dumb http push-over-dav doesn't handle the 401
properly. As a work-around, a4ddbc3 (http-push: enable "proactive auth",
2011-12-13) re-enabled the pre-prompt, but only for the code paths that
need it (and those code paths are now broken for .netrc, as everything
was before 986bbc0). This is a hack, and in the long run it would be
nice to have everything handle 401s properly, but the dav code is
somewhat obsolete these days, and I suspect nobody really wants to
overhaul it.

Complicating all of this is the fact that I think Nelson's original
patch was based on an older, pre-986bbc0 version of git, which is why he
followed the pre-prompt route, copying the style of regular http auth.

So there's the history lesson. What should proxy auth do?

  1. Definitely respond to HTTP 407 by prompting on the fly; this code
     should go along-side the HTTP 401 code in http.c.

  2. Definitely do the pre-prompt thing when http_proactive_auth is set
     (which is used only by http-push). Unless somebody really feels
     like re-writing http-push to handle retries for authentication.

  3. Consider doing the pre-prompt thing when http_proactive_auth is not
     set. This can save a round-trip, but we should not do it if there
     is a good reason not to. The two possible reasons I can think of
     are:

       a. Like http auth, if curl will read the proxy credentials from
          .netrc, then we should not do it for the same reasons
          mentioned in 986bbc0.

       b. If people realistically have proxy URLs with usernames but do
          _not_ want to ask for a password, then the prompt will be
          annoying. I'm not sure that anybody expects that.

I consider (3) to be a "meh, if you are really interested in looking
into this" step, as it is really just a possible optimization (and I
suspect curl _does_ use netrc for proxy credentials, but I haven't
checked). But we definitely want to get (1) and (2) right.

-Peff
