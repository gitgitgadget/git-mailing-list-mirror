From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] Allow HTTP user agent string to be modified.
Date: Wed, 11 Aug 2010 13:08:41 -0700
Message-ID: <7v62zgyks6.fsf@alter.siamese.dyndns.org>
References: <AANLkTi=G=GvxXEh1hGuYQK42cdkMUaFhqxsQ39K=2180@mail.gmail.com>
 <1281504288-31836-1-git-send-email-olsonse@umich.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Tay Ray Chuan <rctay89@gmail.com>,
	Nick Hengeveld <nickh@reactrix.com>,
	Mark Lodato <lodatom@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: "Spencer E. Olson" <olsonse@umich.edu>
X-From: git-owner@vger.kernel.org Wed Aug 11 22:09:11 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OjHbr-0004ho-1M
	for gcvg-git-2@lo.gmane.org; Wed, 11 Aug 2010 22:09:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756837Ab0HKUI6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Aug 2010 16:08:58 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:43673 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756710Ab0HKUI6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Aug 2010 16:08:58 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D3DD2CC30B;
	Wed, 11 Aug 2010 16:08:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=TGolt4SJ2MNFenVFmp9rVnJmLMY=; b=EiJLw5
	NJ/6PNMw0S6AyGA7ynLrdTRQGQ/uwKWd/vdazxa8OIdAdCDP9Zo87oHvkm4F2DWA
	sSxJ5+Th8i4DsZjmLluaaRRmD85aORbf924ixxzVPS/5YmF7/uqtQLEqbA4dfiKj
	sHARZF619r+g6oPPSJ0z2EFg2FUJNgpp9o3Kk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=w8wSp99d0uLimot1pE6hU3NnYk7B1OUj
	FRRpfOII7UnPS9ZFIkOrz/FUeJqB7DWYgTrp1qetXFU1YBkGw91p+81jIkdcHqI+
	/PPqpyIyxHLeEeXIynA/4qLFevtZXMXNOKwz0UTrpX06kA8JaAGagnGTgeCyw5WJ
	AygOwSW3mew=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 57155CC30A;
	Wed, 11 Aug 2010 16:08:50 -0400 (EDT)
Received: from pobox.com (unknown [76.102.252.155]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 07CC3CC305; Wed, 11 Aug
 2010 16:08:42 -0400 (EDT)
In-Reply-To: <1281504288-31836-1-git-send-email-olsonse@umich.edu> (Spencer
 E. Olson's message of "Tue\, 10 Aug 2010 23\:24\:48 -0600")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 41D7410E-A584-11DF-A49A-9056EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/153298>

"Spencer E. Olson" <olsonse@umich.edu> writes:

> diff --git a/http.c b/http.c
> index 1320c50..b0b6925 100644
> --- a/http.c
> +++ b/http.c
> @@ -41,6 +41,7 @@ static long curl_low_speed_time = -1;
>  static int curl_ftp_no_epsv;
>  static const char *curl_http_proxy;
>  static char *user_name, *user_pass;
> +static const char *user_agent;
>  
>  #if LIBCURL_VERSION_NUM >= 0x071700
>  /* Use CURLOPT_KEYPASSWD as is */
> @@ -196,6 +197,9 @@ static int http_options(const char *var, const char *value, void *cb)
>  		return 0;
>  	}
>  
> +	if (!strcmp("http.useragent", var))
> +		return git_config_string(&user_agent, var, value);
> +
>  	/* Fall back on the default ones */
>  	return git_default_config(var, value, cb);
>  }
> @@ -279,7 +283,8 @@ static CURL *get_curl_handle(void)
>  	if (getenv("GIT_CURL_VERBOSE"))
>  		curl_easy_setopt(result, CURLOPT_VERBOSE, 1);
>  
> -	curl_easy_setopt(result, CURLOPT_USERAGENT, GIT_USER_AGENT);
> +	curl_easy_setopt(result, CURLOPT_USERAGENT,
> +		user_agent ? user_agent : GIT_USER_AGENT );

Excess space before ")".

>  
>  	if (curl_ftp_no_epsv)
>  		curl_easy_setopt(result, CURLOPT_FTP_USE_EPSV, 0);
> @@ -380,6 +385,8 @@ void http_init(struct remote *remote)
>  #endif
>  	set_from_env(&ssl_cainfo, "GIT_SSL_CAINFO");
>  
> +	set_from_env(&user_agent, "GIT_USER_AGENT");

The name GIT_USER_AGENT may be Ok as an internal token used in our http
implementation, but the environment variable is an end-user facing entity.

Don't we want to say HTTP somewhere, e.g. "GIT_HTTP_USER_AGENT"?

If "User Agent" means the "browser claims to be..." thing to everybody
without much context then I won't worry too much, but MUA is a mail user
agent, and we do use the term in our docs when describing send-email,
so...
