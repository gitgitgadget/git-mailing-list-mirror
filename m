From: Elia Pinto <gitter.spiros@gmail.com>
Subject: Re: [PATCHv5] http: add support for specifying the SSL version
Date: Sat, 15 Aug 2015 10:06:52 +0200
Message-ID: <CA+EOSBn0-9rGyQL4+OD4keZ+PSe06S0coQVuu2jdGE3qnZbp7g@mail.gmail.com>
References: <1439581063-29771-1-git-send-email-gitter.spiros@gmail.com>
	<xmqqfv3lh7za.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 15 10:07:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZQWUd-0002gy-7l
	for gcvg-git-2@plane.gmane.org; Sat, 15 Aug 2015 10:07:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751238AbbHOIG7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 15 Aug 2015 04:06:59 -0400
Received: from mail-vk0-f52.google.com ([209.85.213.52]:36739 "EHLO
	mail-vk0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751085AbbHOIGx (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Aug 2015 04:06:53 -0400
Received: by vkbf67 with SMTP id f67so37624355vkb.3
        for <git@vger.kernel.org>; Sat, 15 Aug 2015 01:06:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=eOSefcVE9mJqdDsWGbaPcc3c68ISElgRVwm39Mf/qKw=;
        b=aXHnTVmy3hGaHFt3WUUP2MRBch+JwoMt2sotpJop6lNk41wCtS+5gZnO814VE3lAFJ
         w/fdhjKylnI16Dw5ME3xKDlKpi9tMoVHHVl+Fb28gupxsJFp6ykjpN3ljhzvuYVbN9kI
         kQmKGpUwDlwWzFndxM/Nx1xTYJTiqevwq7ADhXvzhZEUfXKEyjnK1vc72Ox76CjM4WKr
         xhYiV9E81zFMGIv0ffY2WZtQ3mYHsF9HJsGosBWcYffMtGJIGruc15W2bLXn7Iq2NpvE
         ECempltHfMmyxmdQo2t2BvSx1ky9SYqsHTr5xppHlyxWT748Eky0hQUB9n1zBXF3K1Kr
         osBA==
X-Received: by 10.52.226.161 with SMTP id rt1mr6604433vdc.53.1439626012562;
 Sat, 15 Aug 2015 01:06:52 -0700 (PDT)
Received: by 10.31.16.146 with HTTP; Sat, 15 Aug 2015 01:06:52 -0700 (PDT)
In-Reply-To: <xmqqfv3lh7za.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275982>

2015-08-14 23:32 GMT+02:00 Junio C Hamano <gitster@pobox.com>:
> Elia Pinto <gitter.spiros@gmail.com> writes:
>
>> Teach git about a new option, "http.sslVersion", which permits one to
>> specify the SSL version  to use when negotiating SSL connections.  The
>> setting can be overridden by the GIT_SSL_VERSION environment
>> variable.
>>
>> Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
>> ---
>> This is the fifth version of the patch. Changes from the previous version:
>>
>> - Minor style changes (Eric)
>
> Thanks.
>
> I'd probably credit Eric with Helped-by: there if I were you ;-)
>
>> diff --git a/http.c b/http.c
>> index e9c6fdd..4c5a2e0 100644
>> --- a/http.c
>> +++ b/http.c
>> @@ -37,6 +37,20 @@ static int curl_ssl_verify = -1;
>>  static int curl_ssl_try;
>>  static const char *ssl_cert;
>>  static const char *ssl_cipherlist;
>> +static const char *ssl_version;
>> +static struct {
>> +     const char *name;
>> +     long ssl_version;
>> +     } sslversions[] = {
>> +             { "sslv2", CURL_SSLVERSION_SSLv2 },
>> +             { "sslv3", CURL_SSLVERSION_TLSv1 },
>> +             { "tlsv1", CURL_SSLVERSION_TLSv1 },
>> +#if LIBCURL_VERSION_NUM >= 0x072200
>> +             { "tlsv1.0", CURL_SSLVERSION_TLSv1_0 },
>> +             { "tlsv1.1", CURL_SSLVERSION_TLSv1_1 },
>> +             { "tlsv1.2", CURL_SSLVERSION_TLSv1_2 }
>> +#endif
>> +};
>
> The indentation of the above is somewhat screwed up.  Also even
> though it is clear that you accept a comma after the last item in an
> array initialization (i.e. when compiled for an older libCurl, the
> last entry in the array is for tlsv1 which ends with a comma), for
> newer libCurl, the last entry does not end with a comma, which is
> (1) inconsistent, and (2) makes it harder to add more entries at the
> end of the array in the future.diff --git a/http.c b/http.c

My bad.Can you squash this fix also ? Thanks


diff --git a/http.c b/http.c
index 4c5a2e0..2bf4d4c 100644
--- a/http.c
+++ b/http.c
@@ -43,7 +43,7 @@ static struct {
        long ssl_version;
        } sslversions[] = {
                { "sslv2", CURL_SSLVERSION_SSLv2 },
-               { "sslv3", CURL_SSLVERSION_TLSv1 },
+               { "sslv3", CURL_SSLVERSION_SSLv3 },
                { "tlsv1", CURL_SSLVERSION_TLSv1 },
 #if LIBCURL_VERSION_NUM >= 0x072200
                { "tlsv1.0", CURL_SSLVERSION_TLSv1_0 },



>
> Here is with a slight edit that I'll queue for now.
>
> Thanks.

My bad. Can you squash also this fix


>
> -- >8 --
> From: Elia Pinto <gitter.spiros@gmail.com>
> Date: Fri, 14 Aug 2015 21:37:43 +0200
> Subject: [PATCH] http: add support for specifying the SSL version
>
> Teach git about a new option, "http.sslVersion", which permits one
> to specify the SSL version to use when negotiating SSL connections.
> The setting can be overridden by the GIT_SSL_VERSION environment
> variable.
>
> Signed-off-by: Elia Pinto <gitter.spiros@gmail.com>
> Helped-by: Eric Sunshine <sunshine@sunshineco.com>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> ---
>  Documentation/config.txt               | 23 +++++++++++++++++++++++
>  contrib/completion/git-completion.bash |  1 +
>  http.c                                 | 33 ++++++++++++++++++++++++++++++++-
>  3 files changed, 56 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/config.txt b/Documentation/config.txt
> index 43bb53c..8d334c5 100644
> --- a/Documentation/config.txt
> +++ b/Documentation/config.txt
> @@ -1576,6 +1576,29 @@ http.saveCookies::
>         If set, store cookies received during requests to the file specified by
>         http.cookieFile. Has no effect if http.cookieFile is unset.
>
> +http.sslVersion::
> +       The SSL version to use when negotiating an SSL connection, if you
> +       want to force the default.  The available and default version
> +       depend on whether libcurl was built against NSS or OpenSSL and the
> +       particular configuration of the crypto library in use. Internally
> +       this sets the 'CURLOPT_SSL_VERSION' option; see the libcurl
> +       documentation for more details on the format of this option and
> +       for the ssl version supported. Actually the possible values of
> +       this option are:
> +
> +       - sslv2
> +       - sslv3
> +       - tlsv1
> +       - tlsv1.0
> +       - tlsv1.1
> +       - tlsv1.2
> +
> ++
> +Can be overridden by the 'GIT_SSL_VERSION' environment variable.
> +To force git to use libcurl's default ssl version and ignore any
> +explicit http.sslversion option, set 'GIT_SSL_VERSION' to the
> +empty string.
> +
>  http.sslCipherList::
>    A list of SSL ciphers to use when negotiating an SSL connection.
>    The available ciphers depend on whether libcurl was built against
> diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
> index c97c648..6e9359c 100644
> --- a/contrib/completion/git-completion.bash
> +++ b/contrib/completion/git-completion.bash
> @@ -2118,6 +2118,7 @@ _git_config ()
>                 http.postBuffer
>                 http.proxy
>                 http.sslCipherList
> +               http.sslVersion
>                 http.sslCAInfo
>                 http.sslCAPath
>                 http.sslCert
> diff --git a/http.c b/http.c
> index e9c6fdd..ba3cc0e 100644
> --- a/http.c
> +++ b/http.c
> @@ -37,6 +37,20 @@ static int curl_ssl_verify = -1;
>  static int curl_ssl_try;
>  static const char *ssl_cert;
>  static const char *ssl_cipherlist;
> +static const char *ssl_version;
> +static struct {
> +       const char *name;
> +       long ssl_version;
> +} sslversions[] = {
> +       { "sslv2", CURL_SSLVERSION_SSLv2 },
> +       { "sslv3", CURL_SSLVERSION_TLSv1 },
> +       { "tlsv1", CURL_SSLVERSION_TLSv1 },
> +#if LIBCURL_VERSION_NUM >= 0x072200
> +       { "tlsv1.0", CURL_SSLVERSION_TLSv1_0 },
> +       { "tlsv1.1", CURL_SSLVERSION_TLSv1_1 },
> +       { "tlsv1.2", CURL_SSLVERSION_TLSv1_2 },
> +#endif
> +};
>  #if LIBCURL_VERSION_NUM >= 0x070903
>  static const char *ssl_key;
>  #endif
> @@ -190,6 +204,8 @@ static int http_options(const char *var, const char *value, void *cb)
>         }
>         if (!strcmp("http.sslcipherlist", var))
>                 return git_config_string(&ssl_cipherlist, var, value);
> +       if (!strcmp("http.sslversion", var))
> +               return git_config_string(&ssl_version, var, value);
>         if (!strcmp("http.sslcert", var))
>                 return git_config_string(&ssl_cert, var, value);
>  #if LIBCURL_VERSION_NUM >= 0x070903
> @@ -364,9 +380,24 @@ static CURL *get_curl_handle(void)
>         if (http_proactive_auth)
>                 init_curl_http_auth(result);
>
> +       if (getenv("GIT_SSL_VERSION"))
> +               ssl_version = getenv("GIT_SSL_VERSION");
> +       if (ssl_version && *ssl_version) {
> +               int i;
> +               for (i = 0; i < ARRAY_SIZE(sslversions); i++) {
> +                       if (!strcmp(ssl_version, sslversions[i].name)) {
> +                               curl_easy_setopt(result, CURLOPT_SSLVERSION,
> +                                                sslversions[i].ssl_version);
> +                               break;
> +                       }
> +               }
> +               if (i == ARRAY_SIZE(sslversions))
> +                       warning("unsupported ssl version %s: using default",
> +                               ssl_version);
> +       }
> +
>         if (getenv("GIT_SSL_CIPHER_LIST"))
>                 ssl_cipherlist = getenv("GIT_SSL_CIPHER_LIST");
> -
>         if (ssl_cipherlist != NULL && *ssl_cipherlist)
>                 curl_easy_setopt(result, CURLOPT_SSL_CIPHER_LIST,
>                                 ssl_cipherlist);
> --
> 2.5.0-487-g2edca40
>
