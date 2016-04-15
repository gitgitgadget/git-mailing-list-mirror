From: Jeff King <peff@peff.net>
Subject: Re: Default authentication over https?
Date: Fri, 15 Apr 2016 18:21:20 -0400
Message-ID: <20160415222120.GA24777@sigill.intra.peff.net>
References: <CAPf1peAW11hZpN6_ztA62tcu6mgCfV3VwwjjtXT5yySUPD9Qpw@mail.gmail.com>
 <20160413223613.GB10011@sigill.intra.peff.net>
 <alpine.DEB.2.20.1604141142190.23813@tvnag.unkk.fr>
 <CAPf1peDf_YbDsaz1ykvzKLkdUWtSqrHT7yrgfUgjE4R1eS4r6g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Daniel Stenberg <daniel@haxx.se>, git <git@vger.kernel.org>
To: Isaac Levy <isaac.r.levy@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 16 00:21:31 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1arC7E-0001JN-59
	for gcvg-git-2@plane.gmane.org; Sat, 16 Apr 2016 00:21:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752171AbcDOWVY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Apr 2016 18:21:24 -0400
Received: from cloud.peff.net ([50.56.180.127]:50509 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751878AbcDOWVX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Apr 2016 18:21:23 -0400
Received: (qmail 13790 invoked by uid 102); 15 Apr 2016 22:21:22 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 15 Apr 2016 18:21:22 -0400
Received: (qmail 16206 invoked by uid 107); 15 Apr 2016 22:21:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 15 Apr 2016 18:21:28 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 15 Apr 2016 18:21:20 -0400
Content-Disposition: inline
In-Reply-To: <CAPf1peDf_YbDsaz1ykvzKLkdUWtSqrHT7yrgfUgjE4R1eS4r6g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291683>

On Thu, Apr 14, 2016 at 05:32:16PM -0400, Isaac Levy wrote:

> After the authenticated request, curl says it's keeping the connection
> open, but the next fetch seems to do two handshakes again.  The
> unauthenticated request closes the connection, so the 2nd handshake is
> forced, but I'm not sure why subsequent git fetches still do
> handshakes.  I did a bit of sleuthing w/ source, GIT_CURL_VERBOSE and
> wireshark.
> 
> We're using GitHub enterprise -- it'd just be nice if there was a
> better way to configure for super fast fetches.  ssh with cached
> connections does avoid the SSL this overhead -- though as I recall git
> protocols over ssh are less performant.

It's the opposite; generally git is more efficient over ssh, because we
have a true full-duplex connection, and we can do everything over a
single session (though setup for the ssh session may or may not be
faster than SSL).

Here's what I observed just for the initial contact. If I instrument git
like this:

diff --git a/http.c b/http.c
index 4304b80..9bedad7 100644
--- a/http.c
+++ b/http.c
@@ -1422,6 +1422,7 @@ static int http_request(const char *url,
 	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, headers);
 	curl_easy_setopt(slot->curl, CURLOPT_ENCODING, "gzip");
 
+	warning("running one curl slot...");
 	ret = run_one_slot(slot, &results);
 
 	if (options && options->content_type) {

and run:

  GIT_CURL_VERBOSE=1 git ls-remote 2>&1 | egrep '< HTTP|> |^Auth|^warn'

I get three requests:

  warning: running one curl slot...
  > GET /my/repo/info/refs?service=git-upload-pack HTTP/1.1
  < HTTP/1.1 401 Authorization Required
  warning: running one curl slot...
  > GET /my/repo/info/refs?service=git-upload-pack HTTP/1.1
  < HTTP/1.1 401 Authorization Required
  > GET /my/repo/info/refs?service=git-upload-pack HTTP/1.1
  Authorization: Basic ...
  < HTTP/1.1 200 OK

The first request is us (git) asking curl to hit the URL, and curl
returns the 401 from the server to us. At that point we'll prompt the
user (or the credential helper) for the password, and then we'll give
that to curl and ask it to make the request again. Curl will do the
probe with the 401, because we haven't set an auth type, and then follow
up (without returning the 401 to git) with the right credentials.

I think we can take that down to _two_ requests pretty easily. We know
in the very first request that the server told us something like:

  < WWW-Authenticate: Basic realm="GitHub"

but curl doesn't remember that. However, we should be able to pull it
out of the old request and feed it into the new one. That would save the
second request, which is just a probe.

But ideally we'd have this down to one request. I think we could do
something like this:

diff --git a/http.c b/http.c
index 9bedad7..7e5009d 100644
--- a/http.c
+++ b/http.c
@@ -870,6 +870,11 @@ struct active_request_slot *get_active_slot(void)
 #ifdef LIBCURL_CAN_HANDLE_AUTH_ANY
 	curl_easy_setopt(slot->curl, CURLOPT_HTTPAUTH, http_auth_methods);
 #endif
+
+	/* XXX should be configurable via http.* or whatever */
+	curl_easy_setopt(slot->curl, CURLOPT_HTTPAUTH, CURLAUTH_BASIC);
+	credential_fill(&http_auth);
+
 	if (http_auth.password || curl_empty_auth)
 		init_curl_http_auth(slot->curl);
 

My request then looks like:

  warning: running one curl slot...
  > GET /my/repo/info/refs?service=git-upload-pack HTTP/1.1
  Authorization: Basic ...
  < HTTP/1.1 200 OK

with just a single round-trip.

Obviously the hard-coding there is wrong, but the mental model here is
that the user would do something like:

  git config http.https://github.com.auth basic

to say "I know I want to do Basic auth for this host", and that would
trigger git to tell that to curl, and to prompt for the password
preemptively.  The obvious downside is that it requires manual
configuration, and some clue about "Basic" versus other auth types.

I didn't trace the protocol further, but I suspect that curl ends up
doing that probe for _each_ request, because each time we hand it only
the credential without telling it that we know the server wants "Basic"
auth.

So that tries to keep the number of requests down in the first place. As
far as reusing connections for the connections we _do_ make, I'm not
sure. I do see curl claiming to leave the connection up:

  * Connection #0 to host github.com left intact

but then we seem to make a separate one for the next request:

  * Hostname github.com was found in DNS cache
  *   Trying 192.30.252.120...
  * Connected to github.com (192.30.252.120) port 443 (#1)

I'm not sure why that is. We do get SSL reuse:

  * SSL re-using session ID
  * SSL connection using TLSv1.2 / ECDHE-RSA-AES128-GCM-SHA256

which is good. And then of the two requests curl makes later, the second
one has:

  * Re-using existing connection! (#1) with host github.com

which is good. So I'm not sure why we don't reuse connection #0 from the
very first request. Perhaps it's something in the way we are setting up
the curl handle.

> Finally I also checked out the persistent-https contrib section as a
> workaround but couldn't get it to work. Is that project dead?

I don't know. It certainly hasn't seen a lot of activity lately, but
Google folks might still be using it (I think the original impetus was
for fetching of many repos from the same server for the Android
project). I don't know that we've seen any mention of wide use on the
list.

-Peff
