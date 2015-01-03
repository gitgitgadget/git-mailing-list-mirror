From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] remote-curl: fall back to Basic auth if Negotiate
 fails
Date: Sat, 3 Jan 2015 06:19:23 -0500
Message-ID: <20150103111922.GB27793@peff.net>
References: <1419652893-477694-1-git-send-email-sandals@crustytoothpaste.net>
 <1420142187-1025433-1-git-send-email-sandals@crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org,
	"Dan Langille (dalangil)" <dalangil@cisco.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Sat Jan 03 12:19:32 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y7Mjy-000245-CT
	for gcvg-git-2@plane.gmane.org; Sat, 03 Jan 2015 12:19:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751998AbbACLT0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 3 Jan 2015 06:19:26 -0500
Received: from cloud.peff.net ([50.56.180.127]:58523 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751313AbbACLTZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 3 Jan 2015 06:19:25 -0500
Received: (qmail 25556 invoked by uid 102); 3 Jan 2015 11:19:25 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 03 Jan 2015 05:19:25 -0600
Received: (qmail 20718 invoked by uid 107); 3 Jan 2015 11:19:41 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 03 Jan 2015 06:19:41 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 03 Jan 2015 06:19:23 -0500
Content-Disposition: inline
In-Reply-To: <1420142187-1025433-1-git-send-email-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261995>

On Thu, Jan 01, 2015 at 07:56:27PM +0000, brian m. carlson wrote:

> +void disable_passwordless_auth(struct active_request_slot *slot)
> +{
> +#ifdef LIBCURL_CAN_HANDLE_AUTH_ANY
> +#define HTTP_AUTH_PASSWORDLESS (CURLAUTH_GSSNEGOTIATE)
> +	curl_easy_setopt(slot->curl, CURLOPT_HTTPAUTH,
> +			 CURLAUTH_ANY & ~HTTP_AUTH_PASSWORDLESS);
> +#endif
> +}

I like that you are trying to put a layer of abstraction around what
"passwordless" means here, but it seems like there are two layers. The
function itself abstracts the idea, and then there is an extra
HTTP_AUTH_PASSWORDLESS macro. Since the concept is already confined to
this function and used only once, it might be more readable to simply
get rid of HTTP_AUTH_PASSWORD.

> @@ -1035,6 +1047,9 @@ static int http_request(const char *url,
>  	curl_easy_setopt(slot->curl, CURLOPT_HTTPHEADER, headers);
>  	curl_easy_setopt(slot->curl, CURLOPT_ENCODING, "gzip");
>  
> +	if (!http_passwordless_auth)
> +		disable_passwordless_auth(slot);
> +
>  	ret = run_one_slot(slot, &results);
>  
>  	if (options && options->content_type) {
> @@ -1139,6 +1154,7 @@ static int http_request_reauth(const char *url,
>  	}
>  
>  	credential_fill(&http_auth);
> +	http_passwordless_auth = 0;
>  
>  	return http_request(url, result, target, options);
>  }

This pattern gets repeated in several places. Now that
http_passwordless_auth is a global, can we handle it automatically for
the callers, as below (which, aside from compiling, is completely
untested by me)?

Note that this is in a slightly different boat than credential_fill.
Ideally we would also handle picking up credentials on behalf of the
callers of get_curl_handle/handle_curl_result. But that may involve
significant work and/or prompting the user, which we _must_ avoid if we
do not know if we are going to retry the request (and only the caller
knows that for sure). However, in the case of http_passwordless_auth, we
are just setting a flag, so it's OK to do it preemptively.

diff --git a/http.c b/http.c
index 040f362..2bbcdf1 100644
--- a/http.c
+++ b/http.c
@@ -62,6 +62,8 @@ static const char *user_agent;
 
 static struct credential cert_auth = CREDENTIAL_INIT;
 static int ssl_cert_password_required;
+/* Should we allow non-password-based authentication (e.g. GSSAPI)? */
+static int http_passwordless_auth = 1;
 
 static struct curl_slist *pragma_header;
 static struct curl_slist *no_pragma_header;
@@ -318,7 +320,12 @@ static CURL *get_curl_handle(void)
 	curl_easy_setopt(result, CURLOPT_NETRC, CURL_NETRC_OPTIONAL);
 #endif
 #ifdef LIBCURL_CAN_HANDLE_AUTH_ANY
-	curl_easy_setopt(result, CURLOPT_HTTPAUTH, CURLAUTH_ANY);
+	{
+		int flags = CURLAUTH_ANY;
+		if (!http_passwordless_auth)
+			flags &= ~CURLAUTH_GSSNEGOTIATE;
+		curl_easy_setopt(result, CURLOPT_HTTPAUTH, flags);
+	}
 #endif
 
 	if (http_proactive_auth)
@@ -870,6 +877,7 @@ int handle_curl_result(struct slot_results *results)
 			credential_reject(&http_auth);
 			return HTTP_NOAUTH;
 		} else {
+			http_passwordless_auth = 0;
 			return HTTP_REAUTH;
 		}
 	} else {


Note that you could probably drop http_passwordless_auth completely, and
just keep a:

  static int http_auth_methods = CURLAUTH_ANY;

and then drop CURLAUTH_GSSNEGOTIATE from it instead of setting the
passwordless_auth flag to 0 (again, it happens in one place, so I don't
know that it needs an extra layer of abstraction).

-Peff
