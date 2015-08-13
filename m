From: Elia Pinto <gitter.spiros@gmail.com>
Subject: Re: [PATCH v2] http: add support for specifying the SSL version
Date: Thu, 13 Aug 2015 16:30:21 +0200
Message-ID: <CA+EOSBmWqpT6zSZuCyBdW0cL0OLWbq1yvYmwqgTCUVF5T51K-w@mail.gmail.com>
References: <1439389491-21669-1-git-send-email-gitter.spiros@gmail.com>
	<xmqqoaicmtac.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Remi Galan Alfonso <remi.galan-alfonso@ensimag.grenoble-inp.fr>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 13 16:35:36 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZPtbT-000180-3Y
	for gcvg-git-2@plane.gmane.org; Thu, 13 Aug 2015 16:35:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752203AbbHMOf0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Aug 2015 10:35:26 -0400
Received: from mail-vk0-f45.google.com ([209.85.213.45]:35642 "EHLO
	mail-vk0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751906AbbHMOfZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Aug 2015 10:35:25 -0400
X-Greylist: delayed 303 seconds by postgrey-1.27 at vger.kernel.org; Thu, 13 Aug 2015 10:35:25 EDT
Received: by vkfi73 with SMTP id i73so18483690vkf.2
        for <git@vger.kernel.org>; Thu, 13 Aug 2015 07:35:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=Sx8n86Nh25volI73jLaxZd/rjjQCGxRK9Mi6ZWexWRY=;
        b=AjpE67PIj5wOxksvUafqX8SpzVbFeOVVlyf8VTGj5SKEGd128+QjyqvOWrMd9Rfu8q
         MjS/ktKdoAYnA78rxDp/IM9kaQ7qJSxy1g9o2ocETBanoORtCM+0rhGp6zF0PamokOqx
         5leaTob9WMIf82fz+wRUD6Ab/LFJs1/AWdIXs90V6Q++1ODM+j2f0BzkyKn0pBkdfgru
         eP8lC96EOM7KkCLr+zoaSp+NNY/vCOcDXUMQ+Xqb8nEuTpCD0spnAuO6UY0IE39E0LO3
         h+zRKa2068jBTuqBgz8sLd1Azd1aZvQsy5sbP0s058U7ct9PekIgsSKA2WnelbChfSg6
         6eIw==
X-Received: by 10.52.232.161 with SMTP id tp1mr48493589vdc.37.1439476221280;
 Thu, 13 Aug 2015 07:30:21 -0700 (PDT)
Received: by 10.31.16.146 with HTTP; Thu, 13 Aug 2015 07:30:21 -0700 (PDT)
In-Reply-To: <xmqqoaicmtac.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275844>

2015-08-12 17:16 GMT+02:00 Junio C Hamano <gitster@pobox.com>:
> Elia Pinto <gitter.spiros@gmail.com> writes:
>
>> diff --git a/http.c b/http.c
>> index e9c6fdd..1504005 100644
>> --- a/http.c
>> +++ b/http.c
>> @@ -37,6 +37,8 @@ static int curl_ssl_verify = -1;
>>  static int curl_ssl_try;
>>  static const char *ssl_cert;
>>  static const char *ssl_cipherlist;
>> +static const char *ssl_version;
>> +static long sslversion = CURL_SSLVERSION_DEFAULT;
>
> I think you shouldn't have to initialize this variable.
> See below.
>
>>               init_curl_http_auth(result);
>>
>> +
>
> An unnecessary double blank?
I will fix this and the typo in the next patch.
>
>> +     if (getenv("GIT_SSL_VERSION"))
>> +             ssl_version = getenv("GIT_SSL_VERSION");
>> +     if (ssl_version != NULL && *ssl_version) {
>> +             if (!strcmp(ssl_version,"tlsv1")) {
>> +                     sslversion = CURL_SSLVERSION_TLSv1;
>> +             } else if (!strcmp(ssl_version,"sslv2")) {
>> +                     sslversion = CURL_SSLVERSION_SSLv2;
>> +             } else if (!strcmp(ssl_version,"sslv3")) {
>> +                     sslversion = CURL_SSLVERSION_SSLv3;
>> +#if LIBCURL_VERSION_NUM >= 0x072200
>> +             } else if (!strcmp(ssl_version,"tlsv1.0")) {
>> +                     sslversion = CURL_SSLVERSION_TLSv1_0;
>> +             } else if (!strcmp(ssl_version,"tlsv1.1")) {
>> +                     sslversion = CURL_SSLVERSION_TLSv1_1;
>> +             } else if (!strcmp(ssl_version,"tlsv1.2")) {
>> +                     sslversion = CURL_SSLVERSION_TLSv1_2;
>> +#endif
>> +             } else {
>> +                     warning("unsupported ssl version %s : using default",
>> +                     ssl_version);
>> +             }
>> +        }
>> +     curl_easy_setopt(result, CURLOPT_SSLVERSION,
>> +                             sslversion);
>
> A few problems:
>
>  - Why do we even have to call this when sslversion is not given by
>    the end user, either from the environment or from the config?
>    Wouldn't we use the default version if we do not make this call?
Right. I will fix.
>
>  - It is true that 0x072200 is described as introducing these three
>    in [*1*] but the structure is maintenance burden waiting to
>    happen.  If you #if/#endif based on defined(CURL_SSLVERSION_$v),
>    it will be obvious to other people how to add their future
>    favourite versions in their patches.  Also it may be read better
>    if you separated the logic and the code by using a table like
>    this:
>
>    static struct {
>         const char *name;
>         long ssl_version;
>    } sslversions[] = {
>         { "tlsv1", CURL_SSLVERSION_TLSv1 },
>         { "sslv2", CURL_SSLVERSION_SSLv2 },
>         ...
>    #ifdef CURL_SSLVERSION_TLSv1_0
>         { "tlsv1.0", CURL_SSLVERSION_TLSv1_0 },
>    #endif
>         ...,
>         { NULL }
>    };
>
unfortunately they are enum constant (not #defined ) and I don't know
a smart way in C to make this change with the preprocessor. Would you
have any idea?
>
>
>>       if (getenv("GIT_SSL_CIPHER_LIST"))
>>               ssl_cipherlist = getenv("GIT_SSL_CIPHER_LIST");
>> -
>
> This blank removal is understandable (i.e. group related things
> together).
>
>>       if (ssl_cipherlist != NULL && *ssl_cipherlist)
>>               curl_easy_setopt(result, CURLOPT_SSL_CIPHER_LIST,
>>                               ssl_cipherlist);
>> -
>
> This is not.
I will fix.

Thank you very much
>
>>       if (ssl_cert != NULL)
>>               curl_easy_setopt(result, CURLOPT_SSLCERT, ssl_cert);
>>       if (has_cert_password())
>
> [References]
>
> *1* https://github.com/bagder/curl/blob/master/docs/libcurl/symbols-in-versions
