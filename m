From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] http: add support for specifying the SSL version
Date: Wed, 12 Aug 2015 08:16:11 -0700
Message-ID: <xmqqoaicmtac.fsf@gitster.dls.corp.google.com>
References: <1439389491-21669-1-git-send-email-gitter.spiros@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, remi.galan-alfonso@ensimag.grenoble-inp.fr
To: Elia Pinto <gitter.spiros@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 12 17:16:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZPXlL-0006Yn-HP
	for gcvg-git-2@plane.gmane.org; Wed, 12 Aug 2015 17:16:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754698AbbHLPQP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Aug 2015 11:16:15 -0400
Received: from mail-pa0-f42.google.com ([209.85.220.42]:35107 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754131AbbHLPQO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Aug 2015 11:16:14 -0400
Received: by pacgr6 with SMTP id gr6so16513353pac.2
        for <git@vger.kernel.org>; Wed, 12 Aug 2015 08:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=w7bNZ8Zeo/e9e79G+IhMp2jJRyxWRPwekRAigFt2kRY=;
        b=cI/yJda4e8eMEJkzHXcIZQDM7wsI8MrTcfkeXUk7ezR/VqrP+EmXZxQIXnm+LbkE99
         YT3J5wYM0J9WX4Yu0bOxl/oiqGl5kJGp27fzBXsbBxTrMRVINgF7HARzI+MYDfnzYPLO
         9tDfBp50tfYDM0Q8yqG4k2hU81ux6kJg3dhvG1wyf4SYENMxY6hv0LqK5i/DmzTHGq4k
         3Tqp0iu6gS2Br1mkDe4eobjUFnRmw7m8EYyTAYn5BHiDtRUCLd8TNHoV5L2E3uJrLmM/
         ap/v4ttOxNBiAhk5Jg9B5WBbpQF6rRtY1gitdKSWtpvcqoeTs2DRKDid3YR55nTWh29x
         Vg6w==
X-Received: by 10.68.190.38 with SMTP id gn6mr68589705pbc.125.1439392573317;
        Wed, 12 Aug 2015 08:16:13 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:755f:3d29:a826:eda6])
        by smtp.gmail.com with ESMTPSA id sp1sm6841749pab.4.2015.08.12.08.16.12
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 12 Aug 2015 08:16:12 -0700 (PDT)
In-Reply-To: <1439389491-21669-1-git-send-email-gitter.spiros@gmail.com> (Elia
	Pinto's message of "Wed, 12 Aug 2015 16:24:51 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275773>

Elia Pinto <gitter.spiros@gmail.com> writes:

> diff --git a/http.c b/http.c
> index e9c6fdd..1504005 100644
> --- a/http.c
> +++ b/http.c
> @@ -37,6 +37,8 @@ static int curl_ssl_verify = -1;
>  static int curl_ssl_try;
>  static const char *ssl_cert;
>  static const char *ssl_cipherlist;
> +static const char *ssl_version;
> +static long sslversion = CURL_SSLVERSION_DEFAULT;

I think you shouldn't have to initialize this variable.
See below.

>  		init_curl_http_auth(result);
>  
> +

An unnecessary double blank?

> +	if (getenv("GIT_SSL_VERSION"))
> +		ssl_version = getenv("GIT_SSL_VERSION");
> +	if (ssl_version != NULL && *ssl_version) {
> +		if (!strcmp(ssl_version,"tlsv1")) {
> +			sslversion = CURL_SSLVERSION_TLSv1;
> +		} else if (!strcmp(ssl_version,"sslv2")) {
> +			sslversion = CURL_SSLVERSION_SSLv2;
> +		} else if (!strcmp(ssl_version,"sslv3")) {
> +			sslversion = CURL_SSLVERSION_SSLv3;
> +#if LIBCURL_VERSION_NUM >= 0x072200
> +		} else if (!strcmp(ssl_version,"tlsv1.0")) {
> +			sslversion = CURL_SSLVERSION_TLSv1_0;
> +		} else if (!strcmp(ssl_version,"tlsv1.1")) {
> +			sslversion = CURL_SSLVERSION_TLSv1_1;
> +		} else if (!strcmp(ssl_version,"tlsv1.2")) {
> +			sslversion = CURL_SSLVERSION_TLSv1_2;
> +#endif
> +		} else {
> +			warning("unsupported ssl version %s : using default",
> +			ssl_version);
> +		}
> +        }
> +	curl_easy_setopt(result, CURLOPT_SSLVERSION,
> +				sslversion);

A few problems:

 - Why do we even have to call this when sslversion is not given by
   the end user, either from the environment or from the config?
   Wouldn't we use the default version if we do not make this call?

 - It is true that 0x072200 is described as introducing these three
   in [*1*] but the structure is maintenance burden waiting to
   happen.  If you #if/#endif based on defined(CURL_SSLVERSION_$v),
   it will be obvious to other people how to add their future
   favourite versions in their patches.  Also it may be read better
   if you separated the logic and the code by using a table like
   this:

   static struct {
   	const char *name;
        long ssl_version;
   } sslversions[] = {
	{ "tlsv1", CURL_SSLVERSION_TLSv1 },
	{ "sslv2", CURL_SSLVERSION_SSLv2 },
        ...
   #ifdef CURL_SSLVERSION_TLSv1_0
	{ "tlsv1.0", CURL_SSLVERSION_TLSv1_0 },
   #endif
   	...,
        { NULL }
   };



>  	if (getenv("GIT_SSL_CIPHER_LIST"))
>  		ssl_cipherlist = getenv("GIT_SSL_CIPHER_LIST");
> -

This blank removal is understandable (i.e. group related things
together).

>  	if (ssl_cipherlist != NULL && *ssl_cipherlist)
>  		curl_easy_setopt(result, CURLOPT_SSL_CIPHER_LIST,
>  				ssl_cipherlist);
> -

This is not.

>  	if (ssl_cert != NULL)
>  		curl_easy_setopt(result, CURLOPT_SSLCERT, ssl_cert);
>  	if (has_cert_password())

[References]

*1* https://github.com/bagder/curl/blob/master/docs/libcurl/symbols-in-versions
