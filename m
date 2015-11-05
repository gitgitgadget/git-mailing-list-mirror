From: Knut Franke <k.franke@science-computing.de>
Subject: Re: [PATCH 2/2] http: use credential API to handle proxy
 authentication
Date: Thu, 5 Nov 2015 12:56:54 +0100
Message-ID: <20151105115654.GA6786@science-computing.de>
References: <1445882109-18184-1-git-send-email-k.franke@science-computing.de>
 <1446628405-8070-1-git-send-email-k.franke@science-computing.de>
 <1446628405-8070-3-git-send-email-k.franke@science-computing.de>
 <20151105082421.GB6819@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Nov 05 12:57:25 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZuJAT-0003YC-1N
	for gcvg-git-2@plane.gmane.org; Thu, 05 Nov 2015 12:57:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965529AbbKEL5S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Nov 2015 06:57:18 -0500
Received: from mx3.science-computing.de ([193.197.16.20]:39731 "EHLO
	mx3.science-computing.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965446AbbKEL46 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Nov 2015 06:56:58 -0500
Received: from localhost (localhost [127.0.0.1])
	by scmail.science-computing.de (Postfix) with ESMTP id B205EA79;
	Thu,  5 Nov 2015 12:56:55 +0100 (CET)
X-Virus-Scanned: amavisd-new
Received: from scmail.science-computing.de ([127.0.0.1])
	by localhost (guiness.science-computing.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id f5hLQlD5rsgS; Thu,  5 Nov 2015 12:56:55 +0100 (CET)
Received: from hallasan.science-computing.de (hallasan.science-computing.de [10.10.24.76])
	by scmail.science-computing.de (Postfix) with ESMTP id 1062B498F;
	Thu,  5 Nov 2015 12:56:55 +0100 (CET)
Received: by hallasan.science-computing.de (Postfix, from userid 1633)
	id EC8DFA7966; Thu,  5 Nov 2015 12:56:54 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <20151105082421.GB6819@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280920>

On 2015-11-05 03:24, Jeff King wrote:
> There was also some discussion with curl upstream of providing a new
> authentication interface, where we would provide curl with
> authentication callbacks, and it would trigger them if and when
> credentials were needed. Somebody upstream was working on a patch, but I
> don't think it ever got merged. :(

That would certainly be nice, also with respect to other credentials, such as
SSL key passphrase (presuming that'd be possible without modifying the SSL lib
as well).

> Here's a relevant bit from that old series (which doesn't seem threaded,
> but you can search for the author if you want to see more):
> 
>   http://thread.gmane.org/gmane.comp.version-control.git/192246

My main takeaway from this, apart from the points you mention below, is that
it'd be good to have a test case, similar to t/lib-httpd.sh. Since none of the
existent proxy-related code has an automated test, I think this would be an
improvement on top of the other patches. I'd need to look into how easy/hard
this would be to implement.

> > +
> > +		curl_easy_getinfo(slot->curl, CURLINFO_HTTP_CONNECTCODE,
> > +			&slot->results->http_connectcode);
> 
> It looks like you use this to see the remote side's HTTP 407 code.  In
> the 2012 series, I think we simply looked for a 407 in the HTTP return
> code

I'm not sure why that worked for the author of the old series - possibly curl
semantics changed at some point. In my setup at least (with curl 7.15.5), after
a failed proxy authentication, CURLINFO_HTTP_CODE returns 0 while
CURLINFO_HTTP_CONNECTCODE returns the 407. This is also consistent with the curl
documentation for CURLINFO_RESPONSE_CODE (which has replaced CURLINFO_HTTP_CODE
in 7.10.7, though the compatibility #define is still there): "Note that a
proxy's CONNECT response should be read with CURLINFO_HTTP_CONNECTCODE and not
this."

> If we do need CONNECTCODE, do we need to protect it with an #ifdef on
> the curl version? The manpage says it came in 7.10.7, which was released
> in 2003. That's probably old enough not to worry about.

As Junio pointed out earlier, since some people still care about ancient curl
versions, we don't want to knowingly break compatibility. So yes, an #ifdef
would be in oder here.

> 
> > +	if (proxy_auth.password) {
> > +		memset(proxy_auth.password, 0, strlen(proxy_auth.password));
> > +		free(proxy_auth.password);
> 
> My understanding is that memset() like this is not sufficient for
> zero-ing sensitive data, as they can be optimized out by the compiler. I
> don't think there's a portable alternative, though, so it may be the
> best we can do. OTOH, the rest of git does not worry about such zero-ing
> anyway, so we could also simply omit it here.

For what it's worth, that's the same as we do for cert_auth (while, as far as I
can see, no attempt is made for http_auth). I tend to think it's better than
nothing. Maybe an in-code comment stating it's not reliable would be in order,
to prevent the passing reader from putting too much trust in it.

> > +	free((void *)curl_proxyuserpwd);
> 
> This cast is necessary because curl_proxyuserpwd is declared const. But
> I do not see anywhere that it needs to be const (we detach a strbuf into
> it). Can we simply change the declaration?

Right.

> For that matter, it is not clear to me why this needs to be a global at
> all. Once we hand the value to curl_easy_setopt, curl keeps its own
> copy.

That's true only for relatively recent curl versions; before 7.17.0, strings
were not copied.

> > @@ -1008,6 +1076,8 @@ static int handle_curl_result(struct slot_results *results)
> >  			return HTTP_REAUTH;
> >  		}
> >  	} else {
> > +		if (results->http_connectcode == 407)
> > +			credential_reject(&proxy_auth);
> 
> Rejecting on a 407 makes sense (though again, can we check
> results->http_code?). But if we get a 407 and we _don't_ have a
> password, shouldn't we then prompt for one, similar to what we do with a
> 401?
> 
> That will require some refactoring around http_request_reauth, though
> (because now we might potentially retry twice: once to get past the
> proxy auth, and once to get past the real site's auth).

I think this would also require changes to post_rpc in remote-curl.c, which
apparently does something similar to http_request_reauth. Probably something
along the lines of adding a HTTP_PROXY_REAUTH return code, plus some refactoring
in order to prevent code duplication between the different code parts handling
(proxy) reauth. :-/

> You prompt unconditionally for the password earlier, but only if the
> proxy URL contains a username. We used to do the same thing for regular
> http, but people got annoyed that they had to specify half the
> credential in the URL. Perhaps it would be less so with proxies (which
> are changed a lot less), so I don't think making this work is an
> absolute requirement.

As far as I understand, the issue was around unconditionally prompting for the
password even if it was listed in ~/.netrc. As far as I can see, curl doesn't
read ~/.netrc for proxy credentials, so I don't think it would make a difference
here.


Thanks,
Knut
-- 
Vorstandsvorsitzender/Chairman of the board of management:
Gerd-Lothar Leonhart
Vorstand/Board of Management:
Dr. Bernd Finkbeiner, Dr. Arno Steitz
Vorsitzender des Aufsichtsrats/
Chairman of the Supervisory Board:
Philippe Miltin
Sitz/Registered Office: Tuebingen
Registergericht/Registration Court: Stuttgart
Registernummer/Commercial Register No.: HRB 382196
