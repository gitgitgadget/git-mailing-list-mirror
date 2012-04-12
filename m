From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 2/5] http: handle proxy proactive authentication
Date: Thu, 12 Apr 2012 15:18:01 -0700
Message-ID: <7vd37c4msm.fsf@alter.siamese.dyndns.org>
References: <4F5F53CA.7090003@seap.minhap.es>
 <7v398cvb30.fsf@alter.siamese.dyndns.org>
 <7vsjgcs8pq.fsf@alter.siamese.dyndns.org>
 <7vwr5leyj5.fsf@alter.siamese.dyndns.org>
 <20120412205836.GB21018@sigill.intra.peff.net>
 <7vpqbc4p8n.fsf@alter.siamese.dyndns.org>
 <20120412220516.GG21018@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nelson Benitez Leon <nelsonjesus.benitez@seap.minhap.es>,
	git@vger.kernel.org, sam@vilain.net, spearce@spearce.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Apr 13 00:18:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SISLF-0007GE-2V
	for gcvg-git-2@plane.gmane.org; Fri, 13 Apr 2012 00:18:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934843Ab2DLWSH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Apr 2012 18:18:07 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:62393 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934784Ab2DLWSE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Apr 2012 18:18:04 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C120F6DD8;
	Thu, 12 Apr 2012 18:18:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1/PSUuMGZ72KHQ5pyzGWlxloQcU=; b=Wd76p6
	RyXOhe/Z3BXwAFItVlVGBbJMM1HyKoIjhgdfbLXKvtXrYXK95lhOARev40+pqqi8
	5V7MQOmvgHSnMpG654fihE/ZtZZiCJkglPLPwTREosmcQiEOUjvX69zIa+GvURn/
	edx12WHvQ92AiGCTq/JFWca20jxapb8p6iR1g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=EmdRJISwyfSzonoGW1SbKYYSo4VnU7g1
	+ZwzDnqWJM5CY8RjMnyH4KCKJKANDP00UxYVAeYzusAG2h6RinxrdTxQizWg0Xg3
	LEXqc7YmXsADh16PIbTEs3devyzxGw2NgBUHdLfF9/CKSR2yhE5b4NpYN9PPEb0H
	oEzhULbN6DI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B27646DD7;
	Thu, 12 Apr 2012 18:18:03 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B444C6DD6; Thu, 12 Apr 2012
 18:18:02 -0400 (EDT)
In-Reply-To: <20120412220516.GG21018@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 12 Apr 2012 18:05:16 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5EA04912-84ED-11E1-B1D8-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195379>

Jeff King <peff@peff.net> writes:

> On Thu, Apr 12, 2012 at 02:25:12PM -0700, Junio C Hamano wrote:
>
>> Outside git, these actually come from things like these:
>> 
>> 	http_proxy=127.0.0.1:1080
>> 	HTTPS_PROXY=127.0.0.1:1080
>> 
>> And http.proxy configuration variable we have is a substitute for
>> http_proxy.  So if we want to keep the credentials for destination servers
>> and the credentials for proxies, "http.proxy" codepath should be asking
>> you with "http".  If we are looking at HTTPS_PROXY, you should get "https".
>> The patch that broke the unauthenticated proxy access does neither.
>
> Hmm. Does the distinction between http and https actually matter to
> curl? My reading of the code and documentation is that only "http" is
> meaningful (actually, anything besides socks*:// gets converted to
> http).
>
> So as far as I can tell, these are equivalent:
>
>   http_proxy=http://127.0.0.1:1080
>   http_proxy=https://127.0.0.1:1080
>   http_proxy=foobar://127.0.0.1:1080

Yes, that is exactly what I was trying to say.  The foobar:// part does
not matter; "http" in "http_proxy" is what matters, as it is how you can
specify two separate proxies depending on what destination you are going
via what protocol.

> Not splitting "http" and "http-proxy" does have a slight confusion, as
> the default proxy port is "1080". So a proxy of "http://127.0.0.1" would
> mean "http://127.0.0.1:1080", whereas a regular request would mean
> "http://127.0.0.1:80". The credential code includes the port as part of
> the unique hostname, but since the default-port magic happens inside
> curl, we have no access to it (short of re-implementing it ourselves).

Ok, so how about this as a replacement patch for what I have had for the
past few days?

 credential.c |   44 +++++++++++++++++++++++++++++++-------------
 credential.h |    1 +
 http.c       |   10 +++++++---
 3 files changed, 39 insertions(+), 16 deletions(-)

diff --git a/credential.c b/credential.c
index 62d1c56..5803645 100644
--- a/credential.c
+++ b/credential.c
@@ -313,22 +313,17 @@ void credential_reject(struct credential *c)
 	c->approved = 0;
 }
 
-void credential_from_url(struct credential *c, const char *url)
+static void credential_for_dest(struct credential *c, const char *dest)
 {
-	const char *at, *colon, *cp, *slash, *host, *proto_end;
-
-	credential_clear(c);
+	const char *at, *colon, *cp, *slash, *host;
 
 	/*
 	 * Match one of:
-	 *   (1) proto://<host>/...
-	 *   (2) proto://<user>@<host>/...
-	 *   (3) proto://<user>:<pass>@<host>/...
+	 *   (1) <host>/...
+	 *   (2) <user>@<host>/...
+	 *   (3) <user>:<pass>@<host>/...
 	 */
-	proto_end = strstr(url, "://");
-	if (!proto_end)
-		return;
-	cp = proto_end + 3;
+	cp = dest;
 	at = strchr(cp, '@');
 	colon = strchr(cp, ':');
 	slash = strchrnul(cp, '/');
@@ -348,10 +343,9 @@ void credential_from_url(struct credential *c, const char *url)
 		host = at + 1;
 	}
 
-	if (proto_end - url > 0)
-		c->protocol = xmemdupz(url, proto_end - url);
 	if (slash - host > 0)
 		c->host = url_decode_mem(host, slash - host);
+
 	/* Trim leading and trailing slashes from path */
 	while (*slash == '/')
 		slash++;
@@ -363,3 +357,27 @@ void credential_from_url(struct credential *c, const char *url)
 			*p-- = '\0';
 	}
 }
+
+void credential_for_destination(struct credential *c, const char *dest, const char *proto)
+{
+	credential_clear(c);
+	c->protocol = xstrdup(proto);
+	credential_for_dest(c, dest);
+}
+
+void credential_from_url(struct credential *c, const char *url)
+{
+	const char *proto_end;
+
+	credential_clear(c);
+
+	/*
+	 * Strip "proto://" part and let credential_for_dest()
+	 * parse the remainder.
+	 */
+	proto_end = strstr(url, "://");
+	if (!proto_end)
+		return;
+	c->protocol = xmemdupz(url, proto_end - url);
+	credential_for_dest(c, proto_end + 3);
+}
diff --git a/credential.h b/credential.h
index 96ea41b..4b1c320 100644
--- a/credential.h
+++ b/credential.h
@@ -27,6 +27,7 @@ void credential_reject(struct credential *);
 
 int credential_read(struct credential *, FILE *);
 void credential_from_url(struct credential *, const char *url);
+void credential_for_destination(struct credential *, const char *dest, const char *proto);
 int credential_match(const struct credential *have,
 		     const struct credential *want);
 
diff --git a/http.c b/http.c
index 1c71edb..752b6ea 100644
--- a/http.c
+++ b/http.c
@@ -336,14 +336,18 @@ static CURL *get_curl_handle(const char *url)
 	if (curl_http_proxy) {
 		struct strbuf proxyhost = STRBUF_INIT;
 
-		if (!proxy_auth.host) /* check to parse only once */
-			credential_from_url(&proxy_auth, curl_http_proxy);
+		if (!proxy_auth.host) {
+			const char *cp;
+			cp = strstr(curl_http_proxy, "://");
+			cp = cp ? (cp + 3) : curl_http_proxy;
+			credential_for_destination(&proxy_auth, cp, "http-proxy");
+		}
 
 		if (http_proactive_auth && proxy_auth.username && !proxy_auth.password)
 			/* proxy string has username but no password, ask for password */
 			credential_fill(&proxy_auth);
 
-		strbuf_addf(&proxyhost, "%s://%s", proxy_auth.protocol, proxy_auth.host);
+		strbuf_addstr(&proxyhost, proxy_auth.host);
 		curl_easy_setopt(result, CURLOPT_PROXY, strbuf_detach(&proxyhost, NULL));
 		curl_easy_setopt(result, CURLOPT_PROXYAUTH, CURLAUTH_ANY);
 		set_proxy_auth(result);
