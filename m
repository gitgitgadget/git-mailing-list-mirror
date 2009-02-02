From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Support various HTTP authentication methods
Date: Sun,  1 Feb 2009 22:31:12 -0800
Message-ID: <1233556274-1354-2-git-send-email-gitster@pobox.com>
References: <1233556274-1354-1-git-send-email-gitster@pobox.com>
Cc: Moriyoshi Koizumi <mozo@mozo.jp>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 02 07:33:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LTsMj-0005wS-N2
	for gcvg-git-2@gmane.org; Mon, 02 Feb 2009 07:33:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751393AbZBBGb0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Feb 2009 01:31:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751268AbZBBGbZ
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Feb 2009 01:31:25 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:37706 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751005AbZBBGbZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Feb 2009 01:31:25 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 74DDA2A452;
	Mon,  2 Feb 2009 01:31:22 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 8B5112A450; Mon, 
 2 Feb 2009 01:31:20 -0500 (EST)
X-Mailer: git-send-email 1.6.1.2.333.ged98f
In-Reply-To: <1233556274-1354-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 1BC5E188-F0F3-11DD-A540-F63E8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108053>

Moriyoshi Koizumi <mozo@mozo.jp> writes:

> diff --git a/http.c b/http.c
> index ee58799..41e8e8c 100644
> --- a/http.c
> +++ b/http.c
> @@ -13,18 +13,24 @@ static CURL *curl_default;
>  char curl_errorstr[CURL_ERROR_SIZE];
>  
>  static int curl_ssl_verify = -1;
> -static const char *ssl_cert = NULL;
> +static const char *ssl_cert;
>  #if LIBCURL_VERSION_NUM >= 0x070902
> -static const char *ssl_key = NULL;
> +static const char *ssl_key;
>  #endif
>  #if LIBCURL_VERSION_NUM >= 0x070908
> -static const char *ssl_capath = NULL;
> +static const char *ssl_capath;
>  #endif
> -static const char *ssl_cainfo = NULL;
> +static const char *ssl_cainfo;
>  static long curl_low_speed_limit = -1;
>  static long curl_low_speed_time = -1;
>  static int curl_ftp_no_epsv = 0;
> -static const char *curl_http_proxy = NULL;
> +static const char *curl_http_proxy;

Applying style fixes to the existing code is very much appreciated, *but*
please make such a clean-up patch a separate one.  A two-patch series
whose [1/2] is such a pure clean-up without any feature change, with [2/2]
that adds code to the cleaned-up state would be much less distracting for
people who nitpick your changes.

> @@ -153,11 +159,69 @@ static int http_options(const char *var, const char *value, void *cb)
>  			return git_config_string(&curl_http_proxy, var, value);
>  		return 0;
>  	}
> +#if LIBCURL_VERSION_NUM >= 0x070a06
> +	if (!strcmp("http.auth", var)) {
> +		if (curl_http_auth == NULL)
> +			return git_config_string(&curl_http_auth, var, value);
> +		return 0;
> +	}
> +#endif
> +#if LIBCURL_VERSION_NUM >= 0x070a07
> +	if (!strcmp("http.proxy_auth", var)) {
> +		if (curl_http_proxy_auth == NULL)
> +			return git_config_string(&curl_http_proxy_auth, var, value);
> +		return 0;
> +	}
> +#endif

If you follow config.c::git_config() you will notice that we read from
/etc/gitconfig, $HOME/.gitconfig and then finally $GIT_DIR/config.  By
implementing "if we already have read curl_http_auth already, we will
ignore the later setting" like above code does, you break the general
expectation that system-wide defaults is overridable by $HOME/.gitconfig
and that is in turn overridable by per-repository $GIT_DIR/config.

The preferred order would be:

  - Use the value obtained from command line parameters, if any;

  - Otherwise, if an environment variable is there, use it;

  - Otherwise, the value obtained from git_config(), with "later one wins"
    rule.
  
I think you are not adding any command line option, so favoring
environment and then using configuration is fine, but the configuration
parser must follow the usual "later one wins" rule to avoid dissapointing
the users.

> +#if LIBCURL_VERSION_NUM >= 0x070a06
> +static long get_curl_auth_bitmask(const char* auth_method)

In git codebase, asterisk that means "a pointer" sticks to the variable
name not to type name; "const char *auth_method" (I see this file is
already infested with such style violations, but if you are doing a
separate clean-up patch it would be appreciated to clean them up).

> +{
> +	char buf[4096];

Do you need that much space?

> +	const unsigned char *p = (const unsigned char *)auth_method;
> +	long mask = CURLAUTH_NONE;
> +
> +    strlcpy(buf, auth_method, sizeof(buf));

A tab is 8-char wide.

What happens when auth_method is longer than 4kB?

> +
> +	for (;;) {
> +		char *q = buf;
> +		while (*p && isspace(*p))
> +			++p;

If there is no particular reason to choose one over the other, please use
postincrement, p++, as other existing parts of the codebase.

I'll try to demonstrate what (I think) this patch should look like as a
pair of follow-up messages to this one, but I am not sure about my rewrite
of get_curl_auth_bitmask().  Please consider it as an easter-egg bughunt
;-)
