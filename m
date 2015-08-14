From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3] http: add support for specifying the SSL version
Date: Fri, 14 Aug 2015 10:21:37 -0700
Message-ID: <xmqqlhddiy5a.fsf@gitster.dls.corp.google.com>
References: <1439479731-16018-1-git-send-email-gitter.spiros@gmail.com>
	<55CCBF6F.3070808@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Elia Pinto <gitter.spiros@gmail.com>, git@vger.kernel.org,
	remi.galan-alfonso@ensimag.grenoble-inp.fr
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Fri Aug 14 19:21:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZQIfo-00015y-HY
	for gcvg-git-2@plane.gmane.org; Fri, 14 Aug 2015 19:21:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755482AbbHNRVk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 14 Aug 2015 13:21:40 -0400
Received: from mail-pa0-f47.google.com ([209.85.220.47]:36099 "EHLO
	mail-pa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755352AbbHNRVj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 14 Aug 2015 13:21:39 -0400
Received: by pacrr5 with SMTP id rr5so64309392pac.3
        for <git@vger.kernel.org>; Fri, 14 Aug 2015 10:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:content-transfer-encoding;
        bh=VWP5Q0GYMhH2uzvZ5QUzAbv/bP3kdqcjqOoh0s+92jY=;
        b=junjZTt00kJ7ywcbr5ob/SRO6uE2YijTalaBnlQ1R8w8BSgPA1OCQ+KeJ4nC4GPQO1
         sLeswyhjRJHUBzcO/FAH4i8EJhMxDOcUkGI8QZ0ADe2sYiiqfaCcM4FvgTnvvnzQJyzH
         OiWBRX1amSrkZAI5OQwIGf9NKGUdXn9YHgVPv6ALnWiHMdEeOlPn1p8RKI7ZqDuaFfTi
         tfjg3eVLj1r7qJZEwfoW+QP83A0la10K2wNUs6wOWuMdxQYOlZ8qSM3uonCMe8x114pB
         ML+Yyz0yzYkYbxmMjkz/KSicZEY4JvruExv8ib4z6GLOyNf2VnphQb2fd4zKx3+N7Lis
         Fmlw==
X-Received: by 10.69.11.196 with SMTP id ek4mr90969458pbd.148.1439572899065;
        Fri, 14 Aug 2015 10:21:39 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:a820:aa0d:2b52:954f])
        by smtp.gmail.com with ESMTPSA id bw15sm6686051pac.41.2015.08.14.10.21.38
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 14 Aug 2015 10:21:38 -0700 (PDT)
In-Reply-To: <55CCBF6F.3070808@web.de> ("Torsten =?utf-8?Q?B=C3=B6gershaus?=
 =?utf-8?Q?en=22's?= message of
	"Thu, 13 Aug 2015 18:01:51 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275913>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

>> diff --git a/Documentation/config.txt b/Documentation/config.txt
>> index 315f271..b23b01a 100644
>> --- a/Documentation/config.txt
>> +++ b/Documentation/config.txt
>> @@ -1595,6 +1595,28 @@ http.saveCookies::
>>  	If set, store cookies received during requests to the file specifi=
ed by
>>  	http.cookieFile. Has no effect if http.cookieFile is unset.
>> =20
>> +http.sslVersion::
> should this be https.sslVersion ?
> (http doesn't use ssl)

But there are sslCipherList, etc., already present, and more
importantly, I think you want http.proxy to apply even if you happen
to be talking http over SSL.

More importantly, given that we have the "limited to this URL"
mechanism "http.<url>.<variable>" that overrides "http.<variable>",
introducing "https.sslWhatEver" would force people to have two
configuration sections for no real benefit, other than silencing
pedants that want to say "these things should be defined only for
https".

>> + if (sslversions[i].name !=3D NULL && *sslversions[i].name &&
>> !strcmp(ssl_version,sslversions[i].name)) {
>> +				curl_easy_setopt(result, CURLOPT_SSLVERSION,
>> +					sslversions[i].ssl_version);
> This is what my man page says:
>  CURLcode curl_easy_setopt(CURL *handle, CURLoption option, parameter=
);
> []
>
> RETURN VALUE
>        CURLE_OK (zero) means that the option was set properly...
> Should the return value checked (and we die() if we fail ?

Probably.  Do we check status from other calls to setopt?
