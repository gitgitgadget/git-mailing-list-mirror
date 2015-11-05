From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/2] http: use credential API to handle proxy
 authentication
Date: Thu, 5 Nov 2015 03:24:21 -0500
Message-ID: <20151105082421.GB6819@sigill.intra.peff.net>
References: <1445882109-18184-1-git-send-email-k.franke@science-computing.de>
 <1446628405-8070-1-git-send-email-k.franke@science-computing.de>
 <1446628405-8070-3-git-send-email-k.franke@science-computing.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Knut Franke <k.franke@science-computing.de>
X-From: git-owner@vger.kernel.org Thu Nov 05 09:24:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZuFqQ-0007k5-29
	for gcvg-git-2@plane.gmane.org; Thu, 05 Nov 2015 09:24:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1033304AbbKEIYZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Nov 2015 03:24:25 -0500
Received: from cloud.peff.net ([50.56.180.127]:53236 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1030562AbbKEIYY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Nov 2015 03:24:24 -0500
Received: (qmail 24159 invoked by uid 102); 5 Nov 2015 08:24:24 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 05 Nov 2015 02:24:24 -0600
Received: (qmail 11381 invoked by uid 107); 5 Nov 2015 08:24:50 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 05 Nov 2015 03:24:50 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 05 Nov 2015 03:24:21 -0500
Content-Disposition: inline
In-Reply-To: <1446628405-8070-3-git-send-email-k.franke@science-computing.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280916>

On Wed, Nov 04, 2015 at 10:13:25AM +0100, Knut Franke wrote:

> For consistency reasons, add parsing of http_proxy/https_proxy/all_proxy
> environment variables, which would otherwise be evaluated as a fallback by curl.
> Without this, we would have different semantics for git configuration and
> environment variables.

I can't say I'm excited about this, but I don't think there's a better
way.

There was a series similar to yours in 2012, and it ran into the same
problems. There's sadly no good way to ask curl "what is the proxy you
ended up using?".

There was also some discussion with curl upstream of providing a new
authentication interface, where we would provide curl with
authentication callbacks, and it would trigger them if and when
credentials were needed. Somebody upstream was working on a patch, but I
don't think it ever got merged. :(

Here's a relevant bit from that old series (which doesn't seem threaded,
but you can search for the author if you want to see more):

  http://thread.gmane.org/gmane.comp.version-control.git/192246

I have a few comments/questions below.

> +
> +		curl_easy_getinfo(slot->curl, CURLINFO_HTTP_CONNECTCODE,
> +			&slot->results->http_connectcode);

It looks like you use this to see the remote side's HTTP 407 code.  In
the 2012 series, I think we simply looked for a 407 in the HTTP return
code (I assume that if we fail in the CONNECT, we can't get any other
HTTP code and so curl just returns the proxy code).

I don't have a proxy to test against, but would that work (it's entirely
possible the other series was simply wrong)?

If we do need CONNECTCODE, do we need to protect it with an #ifdef on
the curl version? The manpage says it came in 7.10.7, which was released
in 2003. That's probably old enough not to worry about.

> +	if (proxy_auth.password) {
> +		memset(proxy_auth.password, 0, strlen(proxy_auth.password));
> +		free(proxy_auth.password);

My understanding is that memset() like this is not sufficient for
zero-ing sensitive data, as they can be optimized out by the compiler. I
don't think there's a portable alternative, though, so it may be the
best we can do. OTOH, the rest of git does not worry about such zero-ing
anyway, so we could also simply omit it here.

> +	free((void *)curl_proxyuserpwd);

This cast is necessary because curl_proxyuserpwd is declared const. But
I do not see anywhere that it needs to be const (we detach a strbuf into
it). Can we simply change the declaration?

For that matter, it is not clear to me why this needs to be a global at
all. Once we hand the value to curl_easy_setopt, curl keeps its own
copy.

>  	free((void *) http_proxy_authmethod);

This one unfortunately does need to remain const, as it is used with
git_config_string (though given the number of void casts necessary in
patch 1, it may be less painful to simply cast it in the call to
git_config_string()).

> @@ -994,6 +1060,8 @@ static int handle_curl_result(struct slot_results *results)
>  
>  	if (results->curl_result == CURLE_OK) {
>  		credential_approve(&http_auth);
> +		if (proxy_auth.password)
> +			credential_approve(&proxy_auth);
>  		return HTTP_OK;

Approving on success. Makes sense. You can drop the conditional here;
credential_approve() is a noop if the password isn't set.

> @@ -1008,6 +1076,8 @@ static int handle_curl_result(struct slot_results *results)
>  			return HTTP_REAUTH;
>  		}
>  	} else {
> +		if (results->http_connectcode == 407)
> +			credential_reject(&proxy_auth);

Rejecting on a 407 makes sense (though again, can we check
results->http_code?). But if we get a 407 and we _don't_ have a
password, shouldn't we then prompt for one, similar to what we do with a
401?

That will require some refactoring around http_request_reauth, though
(because now we might potentially retry twice: once to get past the
proxy auth, and once to get past the real site's auth).

You prompt unconditionally for the password earlier, but only if the
proxy URL contains a username. We used to do the same thing for regular
http, but people got annoyed that they had to specify half the
credential in the URL. Perhaps it would be less so with proxies (which
are changed a lot less), so I don't think making this work is an
absolute requirement.

-Peff
