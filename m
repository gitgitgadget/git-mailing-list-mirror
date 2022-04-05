Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 164F4C433F5
	for <git@archiver.kernel.org>; Tue,  5 Apr 2022 03:08:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231247AbiDEDKq convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Mon, 4 Apr 2022 23:10:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231531AbiDEDKi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Apr 2022 23:10:38 -0400
Received: from elephants.elehost.com (elephants.elehost.com [216.66.27.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BDAFA76E6
        for <git@vger.kernel.org>; Mon,  4 Apr 2022 20:00:03 -0700 (PDT)
Received: from Mazikeen (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [174.119.251.39] (may be forged))
        (authenticated bits=0)
        by elephants.elehost.com (8.16.1/8.16.1) with ESMTPSA id 2352xxh4010486
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Mon, 4 Apr 2022 22:59:59 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "=?UTF-8?Q?'Carlo_Marcelo_Arenas_Bel=C3=B3n'?=" <carenas@gmail.com>
Cc:     "'Junio C Hamano'" <gitster@pobox.com>,
        "'Git Mailing List'" <git@vger.kernel.org>,
        <git-packagers@googlegroups.com>
References: <034101d84873$993f96f0$cbbec4d0$@nexbridge.com> <CAPc5daWSDYSexkSeUUpfYDyT-M_F8d-rSMko5pqw140iLwBc_w@mail.gmail.com> <034701d84875$030bfb40$0923f1c0$@nexbridge.com> <20220405002610.27sgjva5wfryrcio@carlos-mbp.lan> <20220405005418.3s2zayr3dmpxg45q@carlos-mbp.lan>
In-Reply-To: <20220405005418.3s2zayr3dmpxg45q@carlos-mbp.lan>
Subject: RE: [ANNOUNCE] Git v2.36.0-rc0 - Build failure on NonStops
Date:   Mon, 4 Apr 2022 22:59:54 -0400
Organization: Nexbridge Inc.
Message-ID: <035b01d84899$3cdc5b20$b6951160$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQE87yXqDmaysdJkpyH6/spM26GbOgJ005kMAt5RIzwA5EjRSgHvWmbNrdYUsJA=
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On April 4, 2022 8:54 PM, Carlo Marcelo Arenas Belón wrote:
>On Mon, Apr 04, 2022 at 05:26:10PM -0700, Carlo Marcelo Arenas Belón wrote:
>> On Mon, Apr 04, 2022 at 06:40:35PM -0400, rsbecker@nexbridge.com wrote:
>> > On April 4, 2022 6:33 PM, Junio C Hamano wrote:
>> > >To: Randall S. Becker <rsbecker@nexbridge.com>
>> > >Cc: Git Mailing List <git@vger.kernel.org>;
>> > >git-packagers@googlegroups.com
>> > >Subject: Re: [ANNOUNCE] Git v2.36.0-rc0 - Build failure on NonStops
>> > >
>> > >CSPRNG_METHOD?
>> >
>> > We already have
>> >
>> >         CSPRNG_METHOD = openssl
>> >
>> > In the config for NonStop. Should that not have worked?
>>
>> only if you are not telling your openssl to hide that function[1]
>>
>> Carlo
>>
>> [1] https://www.openssl.org/docs/manmaster/man3/RAND_bytes.html
>
>neverming, it seems we forgot to track this header somehow, so will need
>something like (untested and likely to need changes to support NO_OPENSSL)
>
>Carlo
>--- >8 ---
>diff --git a/git-compat-util.h b/git-compat-util.h index 4d444dca274..68a9b9cd975
>100644
>--- a/git-compat-util.h
>+++ b/git-compat-util.h
>@@ -525,6 +525,10 @@ void warning_errno(const char *err, ...)
>__attribute__((format (printf, 1, 2)));  #include <openssl/x509v3.h>  #endif /*
>NO_OPENSSL */
>
>+#ifdef HAVE_OPENSSL_CSPRNG
>+#include <openssl/rand.h>
>+#endif
>+
> /*
>  * Let callers be aware of the constant return value; this can help
>  * gcc with -Wuninitialized analysis. We restrict this trick to gcc, though,

I was able to make the build work, adding the above patch and libcrypto.so and libssl.so to our LDFLAGS. This patch is probably required. What confuses me somewhat is why RAND_bytes is required for anything in the fsync series, but it is what it is.

If there is a knob for force -lcrypto and -lssl in config.mak.uname, it would help. The CSPRNG_METHOD=openssl should be forcing these two libraries into the link, I would think. The DLLs do show up in other links, so I am suspecting there is an omission somewhere that includes the git-daemon link.

The test cycle has begun, but that will take at least 40 hours on an ia64 to get complete results.

--Randall

