From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] http.c: die if curl_*_init fails
Date: Sun, 17 Aug 2014 03:35:53 -0400
Message-ID: <20140817073553.GG23808@peff.net>
References: <53EBA0EC.9000007@raz.or.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Bernhard Reiter <ockham@raz.or.at>
X-From: git-owner@vger.kernel.org Sun Aug 17 09:36:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XIv0W-00078c-C6
	for gcvg-git-2@plane.gmane.org; Sun, 17 Aug 2014 09:36:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750936AbaHQHfz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Aug 2014 03:35:55 -0400
Received: from cloud.peff.net ([50.56.180.127]:53545 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750818AbaHQHfz (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Aug 2014 03:35:55 -0400
Received: (qmail 6453 invoked by uid 102); 17 Aug 2014 07:35:55 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sun, 17 Aug 2014 02:35:55 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 17 Aug 2014 03:35:53 -0400
Content-Disposition: inline
In-Reply-To: <53EBA0EC.9000007@raz.or.at>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255355>

On Wed, Aug 13, 2014 at 07:31:24PM +0200, Bernhard Reiter wrote:

> diff --git a/http.c b/http.c
> index c8cd50d..afe4fc5 100644
> --- a/http.c
> +++ b/http.c
> @@ -300,6 +300,9 @@ static CURL *get_curl_handle(void)
>  {
>  	CURL *result = curl_easy_init();
>  
> +	if (!result)
> +		die("curl_easy_init failed");
> +
>  	if (!curl_ssl_verify) {
>  		curl_easy_setopt(result, CURLOPT_SSL_VERIFYPEER, 0);
>  		curl_easy_setopt(result, CURLOPT_SSL_VERIFYHOST, 0);
> @@ -399,7 +402,8 @@ void http_init(struct remote *remote, const char *url, int proactive_auth)
>  	git_config(urlmatch_config_entry, &config);
>  	free(normalized_url);
>  
> -	curl_global_init(CURL_GLOBAL_ALL);
> +	if (curl_global_init(CURL_GLOBAL_ALL) != CURLE_OK)
> +		die("curl_global_init failed");
>  
>  	http_proactive_auth = proactive_auth;

Looks good. I wondered if curl_multi_init needed the same, but it seems
we already check its return. Its style does not match the rest of the
code, though. Maybe we should squash in (or apply on top):

-- >8 --
Subject: http: style fixes for curl_multi_init error check

Unless there is a good reason, we should use die() rather than
fprintf/exit. We can also shorten the message to match other curl init
failures (and match our usual lowercase no-full-stop style).

---
diff --git a/http.c b/http.c
index c8cd50d..4e651a2 100644
--- a/http.c
+++ b/http.c
@@ -417,10 +417,8 @@ void http_init(struct remote *remote, const char *url, int proactive_auth)
 	}
 
 	curlm = curl_multi_init();
-	if (curlm == NULL) {
-		fprintf(stderr, "Error creating curl multi handle.\n");
-		exit(1);
-	}
+	if (!curlm)
+		die("curl_multi_init failed");
 #endif
 
 	if (getenv("GIT_SSL_NO_VERIFY"))
