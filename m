From: Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3] http: add support for specifying an SSL cipher list
Date: Thu, 7 May 2015 14:41:07 -0400
Message-ID: <CAPig+cSPGguo1mEqfCTpLbHuCMaKkH8YQhoDCOPM82Fjt0C+eg@mail.gmail.com>
References: <1431008210-673-1-git-send-email-lars@redhat.com>
	<1431022630-7005-1-git-send-email-lars@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
To: Lars Kellogg-Stedman <lars@redhat.com>
X-From: git-owner@vger.kernel.org Thu May 07 20:41:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YqQjS-0003z6-U7
	for gcvg-git-2@plane.gmane.org; Thu, 07 May 2015 20:41:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751493AbbEGSlI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 7 May 2015 14:41:08 -0400
Received: from mail-ig0-f171.google.com ([209.85.213.171]:36110 "EHLO
	mail-ig0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751470AbbEGSlH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 7 May 2015 14:41:07 -0400
Received: by igbpi8 with SMTP id pi8so1759611igb.1
        for <git@vger.kernel.org>; Thu, 07 May 2015 11:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type;
        bh=7m6/IMxwOljcvDFLvb0bnPyv6U2lywSwCRc9Tai0QGQ=;
        b=QTK6GwkF6M9m9Bf/OqZZWmX7lNCfo1D6Lb+nm8qEaKg5Vj/T4jbwyNzXHj3sM6Qxzp
         /vBl9jPAYJcwHVzwWws0D/VhLSNhiT8d4RUd6pCUX6iChL6VbjM7KbF90rEpLoe/3PK7
         Cf+CmjHFnjFtU4sPJdTGp7WnBaVJpCbhI2/SkE6zghqWJV2E0yqEN/wnrtvs6oSeffMu
         qTVioOYUfO7qSKiCM+SEssjkExWhvShAQa5nvRetAKs6OV8h4TF0DEIZtNtsVvm4EVTE
         wEiIz/KnSz4Vh7+JhZoRss+RAmDflTR5W8/diJ8VoFWGMx7jHR0CcFQf1dwuso7okyYA
         Udrg==
X-Received: by 10.50.43.169 with SMTP id x9mr6279524igl.7.1431024067129; Thu,
 07 May 2015 11:41:07 -0700 (PDT)
Received: by 10.107.28.132 with HTTP; Thu, 7 May 2015 11:41:07 -0700 (PDT)
In-Reply-To: <1431022630-7005-1-git-send-email-lars@redhat.com>
X-Google-Sender-Auth: mR_8J_K-FWiYSsoA5MCz5aJGzlA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268575>

On Thu, May 7, 2015 at 2:17 PM, Lars Kellogg-Stedman <lars@redhat.com> wrote:
> Teach git about a new option, "http.sslCipherList", which permits one to
> specify a list of ciphers to use when negotiating SSL connections.  The
> setting can be overwridden by the GIT_SSL_CIPHER_LIST environment
> variable.
>
> Signed-off-by: Lars Kellogg-Stedman <lars@redhat.com>
> ---
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 2e5ceaf..b982d66 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -1560,6 +1560,19 @@ http.saveCookies::
>         If set, store cookies received during requests to the file specified by
>         http.cookieFile. Has no effect if http.cookieFile is unset.
>
> +http.sslCipherList::
> +       A list of SSL ciphers to use when negotiating an SSL connection.
> +       The available ciphers depend on whether libcurl was built against
> +       NSS or OpenSSL and the particular configuration of the crypto
> +       library in use.  Internally this sets the CURLOPT_SSL_CIPHER_LIST
> +       option; see the libcurl documentation for that option for more
> +       details on the format of this list.
> +
> +       Can be overridden by the 'GIT_SSL_CIPHER_LIST' environment variable.
> +       To force git to use libcurl's default cipher list and ignore any
> +       explicit http.sslCipherList option, set GIT_SSL_CIPHER_LIST to the
> +       empty string.

Much nicer description than previous rounds.

A couple style nits below.

>  http.sslVerify::
>         Whether to verify the SSL certificate when fetching or pushing
>         over HTTPS. Can be overridden by the 'GIT_SSL_NO_VERIFY' environment
> diff --git a/http.c b/http.c
> index 4b179f6..b617546 100644
> --- a/http.c
> +++ b/http.c
> @@ -36,6 +36,7 @@ char curl_errorstr[CURL_ERROR_SIZE];
>  static int curl_ssl_verify = -1;
>  static int curl_ssl_try;
>  static const char *ssl_cert;
> +static const char *ssl_cipherlist;
>  #if LIBCURL_VERSION_NUM >= 0x070903
>  static const char *ssl_key;
>  #endif
> @@ -187,6 +188,9 @@ static int http_options(const char *var, const char *value, void *cb)
>                 curl_ssl_verify = git_config_bool(var, value);
>                 return 0;
>         }
> +       if (!strcmp("http.sslcipherlist", var)) {
> +               return git_config_string(&ssl_cipherlist, var, value);
> +       }
>         if (!strcmp("http.sslcert", var))
>                 return git_config_string(&ssl_cert, var, value);
>  #if LIBCURL_VERSION_NUM >= 0x070903
> @@ -361,6 +365,16 @@ static CURL *get_curl_handle(void)
>         if (http_proactive_auth)
>                 init_curl_http_auth(result);
>
> +       if (getenv("GIT_SSL_CIPHER_LIST"))
> +               ssl_cipherlist = getenv("GIT_SSL_CIPHER_LIST");
> +
> +       /* See http://curl.haxx.se/libcurl/c/CURLOPT_SSL_CIPHER_LIST.html
> +        * for details on the format of and available values for
> +        * CURLOPT_SSL_CIPHER_LIST. */

Format multi-line comments like this:

    /*
     * This is a multi-line
     * comment.
     */

> +       if (ssl_cipherlist != NULL && ssl_cipherlist[0] != '\0')

In git code, this is usually spelled:

    if (ssl_cipherlist && *ssl_cipherlist)

> +               curl_easy_setopt(result, CURLOPT_SSL_CIPHER_LIST,
> +                               ssl_cipherlist);
>+
>         if (ssl_cert != NULL)
>                 curl_easy_setopt(result, CURLOPT_SSLCERT, ssl_cert);
>         if (has_cert_password())
> --
> 2.4.0
