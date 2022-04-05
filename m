Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04BD2C433F5
	for <git@archiver.kernel.org>; Tue,  5 Apr 2022 15:00:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235269AbiDEPBq convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Tue, 5 Apr 2022 11:01:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1388634AbiDENcr (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Apr 2022 09:32:47 -0400
Received: from elephants.elehost.com (elephants.elehost.com [216.66.27.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C1275FDE
        for <git@vger.kernel.org>; Tue,  5 Apr 2022 05:33:40 -0700 (PDT)
Received: from Mazikeen (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [174.119.251.39] (may be forged))
        (authenticated bits=0)
        by elephants.elehost.com (8.16.1/8.16.1) with ESMTPSA id 235CXSok052941
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Tue, 5 Apr 2022 08:33:28 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "=?UTF-8?Q?'Carlo_Marcelo_Arenas_Bel=C3=B3n'?=" <carenas@gmail.com>
Cc:     "'Junio C Hamano'" <gitster@pobox.com>,
        "'Git Mailing List'" <git@vger.kernel.org>,
        <git-packagers@googlegroups.com>,
        "'brian m. carlson'" <sandals@crustytoothpaste.net>,
        "'Neeraj Singh'" <nksingh85@gmail.com>
References: <034101d84873$993f96f0$cbbec4d0$@nexbridge.com> <CAPc5daWSDYSexkSeUUpfYDyT-M_F8d-rSMko5pqw140iLwBc_w@mail.gmail.com> <034701d84875$030bfb40$0923f1c0$@nexbridge.com> <20220405002610.27sgjva5wfryrcio@carlos-mbp.lan> <20220405005418.3s2zayr3dmpxg45q@carlos-mbp.lan> <035b01d84899$3cdc5b20$b6951160$@nexbridge.com> <20220405042826.56vyilttx3lo4scv@carlos-mbp.lan>
In-Reply-To: <20220405042826.56vyilttx3lo4scv@carlos-mbp.lan>
Subject: RE: [ANNOUNCE] Git v2.36.0-rc0 - Build failure on NonStops
Date:   Tue, 5 Apr 2022 08:33:23 -0400
Organization: Nexbridge Inc.
Message-ID: <038001d848e9$5a9c4440$0fd4ccc0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQE87yXqDmaysdJkpyH6/spM26GbOgJ005kMAt5RIzwA5EjRSgHvWmbNAtNurRQBhZlANq2z9YeA
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On April 5, 2022 12:28 AM, Carlo Marcelo Arenas Belón wrote:
>On Mon, Apr 04, 2022 at 10:59:54PM -0400, rsbecker@nexbridge.com wrote:
>> On April 4, 2022 8:54 PM, Carlo Marcelo Arenas Belón wrote:
>> >On Mon, Apr 04, 2022 at 05:26:10PM -0700, Carlo Marcelo Arenas Belón wrote:
>> >> On Mon, Apr 04, 2022 at 06:40:35PM -0400, rsbecker@nexbridge.com wrote:
>> >> > On April 4, 2022 6:33 PM, Junio C Hamano wrote:
>> >> > >To: Randall S. Becker <rsbecker@nexbridge.com>
>> >> > >Cc: Git Mailing List <git@vger.kernel.org>;
>> >> > >git-packagers@googlegroups.com
>> >> > >Subject: Re: [ANNOUNCE] Git v2.36.0-rc0 - Build failure on
>> >> > >NonStops
>> >> > >
>> >> > >CSPRNG_METHOD?
>> >> >
>> >> > We already have
>> >> >
>> >> >         CSPRNG_METHOD = openssl
>> >> >
>> >> > In the config for NonStop. Should that not have worked?
>> >>
>> >> only if you are not telling your openssl to hide that function[1]
>> >>
>> >> Carlo
>> >>
>> >> [1] https://www.openssl.org/docs/manmaster/man3/RAND_bytes.html
>> >
>> >nevermind, it seems we forgot to track this header somehow, so will
>> >need something like (untested and likely to need changes to support
>> >NO_OPENSSL)
>> >
>> >Carlo
>> >--- >8 ---
>> >diff --git a/git-compat-util.h b/git-compat-util.h index
>> >4d444dca274..68a9b9cd975
>> >100644
>> >--- a/git-compat-util.h
>> >+++ b/git-compat-util.h
>> >@@ -525,6 +525,10 @@ void warning_errno(const char *err, ...)
>> >__attribute__((format (printf, 1, 2)));  #include <openssl/x509v3.h>
>> >#endif /* NO_OPENSSL */
>> >
>> >+#ifdef HAVE_OPENSSL_CSPRNG
>> >+#include <openssl/rand.h>
>> >+#endif
>> >+
>> > /*
>> >  * Let callers be aware of the constant return value; this can help
>> >  * gcc with -Wuninitialized analysis. We restrict this trick to gcc,
>> > though,
>>
>> I was able to make the build work, adding the above patch and libcrypto.so and
>libssl.so to our LDFLAGS.
>
>Adding libcrypto wasn't enough?; of course it will depend on your linker but when
>tested in Linux and macOS the only "U" symbol that got pulled was RAND_bytes
>and -lcrypto was all that was needed.
>
>Official patch including both libraries below, but it would be ideal to only pull one if
>possible.
>
>Carlo
>-- >8 --
>Subject: [PATCH] git-compat-util: really support openssl as a source of entropy
>
>05cd988dce5 (wrapper: add a helper to generate numbers from a CSPRNG, 2022-
>01-17), configure openssl as the source for entropy in NON-STOP but doesn't add
>the needed header or link options.
>
>Since the only system that is configured to use openssl as a source of entropy is
>NON-STOP, add the header unconditionally, and -lcrypto to the list of external
>libraries.
>
>An additional change is required to make sure a NO_OPENSSL=1 build will be able
>to work as well (tested on Linux with a modified value of CSPRNG_METHOD =
>openssl), and the more complex logic that allows for compatibility with
>APPLE_COMMON_CRYPTO or allowing for simpler ways to link (without libssl) has
>been punted for now.
>
>Reported-by: Randall Becker <rsbecker@nexbridge.com>
>Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
>---
> Makefile          | 1 +
> git-compat-util.h | 4 ++++
> imap-send.c       | 2 +-
> 3 files changed, 6 insertions(+), 1 deletion(-)
>
>diff --git a/Makefile b/Makefile
>index 91738485626..f8bccfab5e9 100644
>--- a/Makefile
>+++ b/Makefile
>@@ -1972,6 +1972,7 @@ endif
>
> ifneq ($(findstring openssl,$(CSPRNG_METHOD)),)
> 	BASIC_CFLAGS += -DHAVE_OPENSSL_CSPRNG
>+	EXTLIBS += -lcrypto -lssl
> endif
>
> ifneq ($(PROCFS_EXECUTABLE_PATH),)
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
>  * gcc with -Wuninitialized analysis. We restrict this trick to gcc, though, diff --git
>a/imap-send.c b/imap-send.c index 5ac6fa9c664..a50af56b827 100644
>--- a/imap-send.c
>+++ b/imap-send.c
>@@ -27,7 +27,7 @@
> #include "exec-cmd.h"
> #include "run-command.h"
> #include "parse-options.h"
>-#ifdef NO_OPENSSL
>+#if defined(NO_OPENSSL) && !defined(HAVE_OPENSSL_CSPRNG)
> typedef void *SSL;
> #endif
> #ifdef USE_CURL_FOR_IMAP_SEND
>--
>2.35.1.505.g27486cd1b2d

Will retest when this has been rolled into rc1. Thanks
Randall

