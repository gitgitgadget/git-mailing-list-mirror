From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Disable dumb HTTP fallback with GIT_CURL_FALLBACK=0
Date: Wed, 19 Sep 2012 23:48:05 -0400
Message-ID: <20120920034804.GA32313@sigill.intra.peff.net>
References: <1348109753-32388-1-git-send-email-spearce@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Sep 20 05:49:01 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TEXl5-0002QH-Qq
	for gcvg-git-2@plane.gmane.org; Thu, 20 Sep 2012 05:49:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754134Ab2ITDsI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Sep 2012 23:48:08 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:50437 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752555Ab2ITDsH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Sep 2012 23:48:07 -0400
Received: (qmail 11327 invoked by uid 107); 20 Sep 2012 03:48:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 19 Sep 2012 23:48:32 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 19 Sep 2012 23:48:05 -0400
Content-Disposition: inline
In-Reply-To: <1348109753-32388-1-git-send-email-spearce@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206029>

On Wed, Sep 19, 2012 at 07:55:53PM -0700, Shawn O. Pearce wrote:

> From: "Shawn O. Pearce" <spearce@spearce.org>
> 
> If the user doesn't want to use the dumb HTTP protocol, she may
> set GIT_CURL_FALLBACK=0 in the environment before invoking a Git
> protocol operation. This is mostly useful when testing against
> servers that are known to not support the dumb protocol. If the
> smart service detection fails the client should not continue with
> dumb behavior, but instead provide accurate HTTP failure data.

I have been looking into this recently, as well. GitHub does not allow
dumb http at all these days, so transient errors on the initial smart
contact can cause us to fall back to dumb, and end up reporting a
totally useless 403 Forbidden error.  I guess Google Code has a similar
issue.

Note that it is not really do not "fall back to dumb"; we detect the
dumb nature from the response. It is really "fall back to trying the URL
without the query string, because there are some servers that cannot
handle it". With your patch, we might still end up performing a dumb
transfer.

I think what you're doing here is sane, because you have to turn it on
manually, and thus there are no possible backwards compatibility issues.
But it might be nice to make things work better out of the box. Here are
two client-side changes I've been toying with:

  1. If both smart and dumb requests fail, report the error for the
     smart request. Now that smart-http clients are common, I'd expect
     most http servers to be smart these days. Of course I don't have
     any sort of numbers to back this up (nor am I sure how to get them;
     obviously big sites like GitHub and Google Code do a lot of
     traffic, but who knows how many one-off repo-on-a-generic-web-host
     sites still exist?).

     An alternative would be to simply be more verbose, and mention that
     we tried to fallback and list both failures (or we could do this
     with just "fetch -v").

  2. Be more discerning about which errors will cause a fallback.
     Something like "504 Gateway Timeout" should not give a fallback.
     The problem is that you are really guessing at what kinds of http
     errors you are going to get from a dumb server when you try the
     smart URL. I dug back into the list thread that spawned the "retry
     without query string" patch (703e6e7).

     The thread is here:

       http://thread.gmane.org/gmane.comp.version-control.git/137609

     If you read the thread, it turns out that the problem in this case
     (which is the only reported case I could find in the archive) is
     that the server was misconfigured to treat _anything_ with a query
     string as a gitweb URL. And then it got fixed pretty much
     immediately.

     So as far as we know, there may be zero servers for which this
     fallback is actually doing anything useful.

I'm tempted to just reverse the logic. Try the request with the query
string and immediately fail if it doesn't work. For the few (if any)
people who are hitting a server that will not serve the dumb file in
that case, add a "remote.*.dumbhttp" setting that will turn off smart
completely as a workaround.

That would serve the (presumed) majority who are using smart http,
everyone using dumb http on a reasonably-configured server, and still
allow an easy workaround for people with badly configured servers.

What do you think?

> ---
>  remote-curl.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)

If we do go this route, the patch itself looks fairly obvious, although:

> @@ -868,6 +870,12 @@ int main(int argc, const char **argv)
>  	options.verbosity = 1;
>  	options.progress = !!isatty(2);
>  	options.thin = 1;
> +	options.fallback = 1;
> +
> +	if (getenv("GIT_CURL_FALLBACK")) {
> +		char *fb = getenv("GIT_CURL_FALLBACK");
> +		options.fallback = *fb != '0';
> +	}

This can just be:

  options.fallback = git_env_bool("GIT_CURL_FALLBACK", 1);

Fewer lines, and you get all of the true/false parsing for free.

-Peff
