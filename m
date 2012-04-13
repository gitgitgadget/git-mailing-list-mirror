From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v5 1/5] http: try http_proxy env var when http.proxy
 config option is not set
Date: Fri, 13 Apr 2012 16:48:58 -0400
Message-ID: <20120413204858.GA7919@sigill.intra.peff.net>
References: <4F5F5392.5010700@seap.minhap.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Nelson Benitez Leon <nelsonjesus.benitez@seap.minhap.es>
X-From: git-owner@vger.kernel.org Fri Apr 13 22:49:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SInQb-0002xt-9n
	for gcvg-git-2@plane.gmane.org; Fri, 13 Apr 2012 22:49:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756783Ab2DMUtD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Apr 2012 16:49:03 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:33485
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755981Ab2DMUtC (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Apr 2012 16:49:02 -0400
Received: (qmail 12608 invoked by uid 107); 13 Apr 2012 20:49:07 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 13 Apr 2012 16:49:07 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 13 Apr 2012 16:48:58 -0400
Content-Disposition: inline
In-Reply-To: <4F5F5392.5010700@seap.minhap.es>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195443>

On Tue, Mar 13, 2012 at 03:02:58PM +0100, Nelson Benitez Leon wrote:

> diff --git a/http.c b/http.c
> index 8ac8eb6..be88acb 100644
> --- a/http.c
> +++ b/http.c
> @@ -42,6 +42,7 @@ static long curl_low_speed_time = -1;
>  static int curl_ftp_no_epsv;
>  static const char *curl_http_proxy;
>  static const char *curl_cookie_file;
> +static struct credential cre_url = CREDENTIAL_INIT;
>  static struct credential http_auth = CREDENTIAL_INIT;
>  static int http_proactive_auth;
>  static const char *user_agent;

This is a minor issue, but if you are re-rolling anyway, would you mind
making this cre_url not global? It is used only in one small code block:

> +	if (!curl_http_proxy) {
> +		const char *env_proxy, *no_proxy;
> +		char *env_proxy_var;
> +		int read_http_proxy;
> +		struct strbuf buf = STRBUF_INIT;
> +		credential_from_url(&cre_url, url);
> +		strbuf_addf(&buf, "%s_proxy", cre_url.protocol);
> +		env_proxy_var = strbuf_detach(&buf, NULL);
> +		env_proxy = getenv(env_proxy_var);
> +		if (env_proxy) {
> +			read_http_proxy = 1;
> +			no_proxy = getenv("no_proxy");
> +			if (no_proxy && (!strcmp("*", no_proxy) || strstr(no_proxy, cre_url.host)))
> +				read_http_proxy = 0;
> +			
> +			if (read_http_proxy)
> +				curl_http_proxy = xstrdup(env_proxy);
> +		}
> +		free(env_proxy_var);
> +	}

so you could just make it local to this block (also, should you be
checking for the case that there is no protocol?).

I also found this code a little hard to follow because of the number of
variables. You can drop "env_proxy_var" and just access the strbuf's
buffer directly. And you can drop read_http_proxy, as it is used in the
conditional immediately after being set. Plus you can declare a few of
the variables closer to use, and move the variable cleanup closer to
when they are finished being used. So maybe this would be much simpler:

diff --git a/http.c b/http.c
index 8ac8eb6..ea32ecb 100644
--- a/http.c
+++ b/http.c
@@ -295,6 +295,31 @@ static CURL *get_curl_handle(void)
 	if (curl_ftp_no_epsv)
 		curl_easy_setopt(result, CURLOPT_FTP_USE_EPSV, 0);
 
+	if (!curl_http_proxy) {
+		static struct credential parsed_url = CREDENTIAL_INIT;
+		credential_from_url(&parsed_url, url);
+
+		if (parsed_url.protocol) {
+			const char *env_proxy;
+			struct strbuf var = STRBUF_INIT;
+
+			strbuf_addf(&var, "%s_proxy", parsed_url.protocol);
+			env_proxy = getenv(var.buf);
+			strbuf_release(&var);
+
+			if (env_proxy) {
+				const char *no_proxy = getenv("no_proxy");
+				if (!no_proxy)
+					no_proxy = getenv("NO_PROXY");
+				if (!no_proxy ||
+				    (strcmp("*", no_proxy) &&
+				     !strstr(no_proxy, parsed_url.host)))
+					curl_http_proxy = xstrdup(env_proxy);
+			}
+		}
+
+		credential_clear(&parsed_url);
+	}

I think it would be even easier to read if it were broken out into a few
functions.

-Peff
