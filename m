From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v5 2/5] http: handle proxy proactive authentication
Date: Fri, 13 Apr 2012 16:23:59 -0400
Message-ID: <20120413202359.GA5962@sigill.intra.peff.net>
References: <4F5F53CA.7090003@seap.minhap.es>
 <7v398cvb30.fsf@alter.siamese.dyndns.org>
 <7vsjgcs8pq.fsf@alter.siamese.dyndns.org>
 <7vwr5leyj5.fsf@alter.siamese.dyndns.org>
 <20120412205836.GB21018@sigill.intra.peff.net>
 <7vpqbc4p8n.fsf@alter.siamese.dyndns.org>
 <20120412220516.GG21018@sigill.intra.peff.net>
 <7vd37c4msm.fsf@alter.siamese.dyndns.org>
 <20120412224230.GA22988@sigill.intra.peff.net>
 <7viph32znu.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Nelson Benitez Leon <nelsonjesus.benitez@seap.minhap.es>,
	git@vger.kernel.org, sam@vilain.net, spearce@spearce.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 13 22:24:42 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SIn2n-0003rT-NX
	for gcvg-git-2@plane.gmane.org; Fri, 13 Apr 2012 22:24:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755971Ab2DMUYF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Apr 2012 16:24:05 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:33475
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753013Ab2DMUYD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Apr 2012 16:24:03 -0400
Received: (qmail 12476 invoked by uid 107); 13 Apr 2012 20:24:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 13 Apr 2012 16:24:08 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 13 Apr 2012 16:23:59 -0400
Content-Disposition: inline
In-Reply-To: <7viph32znu.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195442>

On Fri, Apr 13, 2012 at 12:35:17PM -0700, Junio C Hamano wrote:

> > It looks like OS X defines a SOCKS type and an HTTPProxy type for its
> > keychain API. So in either case, it should probably be updated to handle
> > these new types. And I guess that argues for making the distinction,
> > since at least one helper does want to care about it.
> 
> OK.  Sounds like we are in agreement.
> 
> Nelson, care to re-roll the series, with fixes discussed in this thread
> rolled into the second patch?

I think there is a bug in the patch you posted, though:

> diff --git a/http.c b/http.c
> index 1c71edb..752b6ea 100644
> --- a/http.c
> +++ b/http.c
> @@ -336,14 +336,18 @@ static CURL *get_curl_handle(const char *url)
>  	if (curl_http_proxy) {
>  		struct strbuf proxyhost = STRBUF_INIT;
>  
> -		if (!proxy_auth.host) /* check to parse only once */
> -			credential_from_url(&proxy_auth, curl_http_proxy);
> +		if (!proxy_auth.host) {
> +			const char *cp;
> +			cp = strstr(curl_http_proxy, "://");
> +			cp = cp ? (cp + 3) : curl_http_proxy;
> +			credential_for_destination(&proxy_auth, cp, "http-proxy");
> +		}

What happens if the URL starts with "socks://"? We would want to
preserve that, and have our protocol end as "socks://".

>  		if (http_proactive_auth && proxy_auth.username && !proxy_auth.password)
>  			/* proxy string has username but no password, ask for password */
>  			credential_fill(&proxy_auth);
>  
> -		strbuf_addf(&proxyhost, "%s://%s", proxy_auth.protocol, proxy_auth.host);
> +		strbuf_addstr(&proxyhost, proxy_auth.host);
>  		curl_easy_setopt(result, CURLOPT_PROXY, strbuf_detach(&proxyhost, NULL));

Same here. If we get "socks://127.0.0.1", we will feed "127.0.0.1" to
curl, which will then assume that it's http.

BTW, do we actually need to strip the username out of the URL? We do not
do so with regular URLs, and curl takes the auth we give it over what is
in the URL. Can this be simplified to just:

  curl_easy_setopt(result, CURLOPT_PROXY, curl_http_proxy);

?

At any rate, I think the rule we want for parsing the url is to actually
parse the protocol from the url, and if it's not there, assume it's
http. And then convert all "http" to "http-proxy", because this is a
weird alternate use of "http". So we can just take your old patch to
relax the credential_from_url parsing, and then fix it up on the calling
side.  Like this:

diff --git a/credential.c b/credential.c
index 62d1c56..813e3cf 100644
--- a/credential.c
+++ b/credential.c
@@ -324,11 +324,15 @@ void credential_from_url(struct credential *c, const char *url)
 	 *   (1) proto://<host>/...
 	 *   (2) proto://<user>@<host>/...
 	 *   (3) proto://<user>:<pass>@<host>/...
+	 * or "proto://"-less variants of the above. They are not technically
+	 * URLs, but the caller may have some context-specific knowledge about
+	 * what protocol is in use.
 	 */
 	proto_end = strstr(url, "://");
-	if (!proto_end)
-		return;
-	cp = proto_end + 3;
+	if (proto_end)
+		cp = proto_end + 3;
+	else
+		cp = url;
 	at = strchr(cp, '@');
 	colon = strchr(cp, ':');
 	slash = strchrnul(cp, '/');
@@ -348,7 +352,7 @@ void credential_from_url(struct credential *c, const char *url)
 		host = at + 1;
 	}
 
-	if (proto_end - url > 0)
+	if (proto_end && proto_end != url)
 		c->protocol = xmemdupz(url, proto_end - url);
 	if (slash - host > 0)
 		c->host = url_decode_mem(host, slash - host);
diff --git a/http.c b/http.c
index 1c71edb..a164f79 100644
--- a/http.c
+++ b/http.c
@@ -334,17 +334,20 @@ static CURL *get_curl_handle(const char *url)
 		free(env_proxy_var);
 	}
 	if (curl_http_proxy) {
-		struct strbuf proxyhost = STRBUF_INIT;
-
-		if (!proxy_auth.host) /* check to parse only once */
+		if (!proxy_auth.host) {
 			credential_from_url(&proxy_auth, curl_http_proxy);
+			if (!proxy_auth.protocol ||
+			    !strcmp(proxy_auth.protocol, "http")) {
+				free(proxy_auth.protocol);
+				proxy_auth.protocol = xstrdup("http-proxy");
+			}
+		}
 
 		if (http_proactive_auth && proxy_auth.username && !proxy_auth.password)
 			/* proxy string has username but no password, ask for password */
 			credential_fill(&proxy_auth);
 
-		strbuf_addf(&proxyhost, "%s://%s", proxy_auth.protocol, proxy_auth.host);
-		curl_easy_setopt(result, CURLOPT_PROXY, strbuf_detach(&proxyhost, NULL));
+		curl_easy_setopt(result, CURLOPT_PROXY, curl_http_proxy);
 		curl_easy_setopt(result, CURLOPT_PROXYAUTH, CURLAUTH_ANY);
 		set_proxy_auth(result);
 	}

Note that curl will treat "foobar://" (or any protocol it does not
understand) as an http proxy. I didn't want to get into white-listing
"socks:// is ok, but foobar:// is really just http in disguise" based on
curl's internal rules. So you can use "foobar://" if you want, but it's
not going to share credentials with "http://" (even though curl will use
them in exactly the same way).

-Peff
