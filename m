Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0541C433F5
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 17:07:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B818F611B0
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 17:07:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbhIJRIi convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Fri, 10 Sep 2021 13:08:38 -0400
Received: from elephants.elehost.com ([216.66.27.132]:28142 "EHLO
        elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbhIJRIi (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Sep 2021 13:08:38 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from gnash (cpe00fc8d49d843-cm00fc8d49d840.cpe.net.cable.rogers.com [173.33.197.34])
        (authenticated bits=0)
        by elephants.elehost.com (8.15.2/8.15.2) with ESMTPSA id 18AH6vPU048628
        (version=TLSv1.2 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 10 Sep 2021 13:06:57 -0400 (EDT)
        (envelope-from rsbecker@nexbridge.com)
From:   "Randall S. Becker" <rsbecker@nexbridge.com>
To:     "'Junio C Hamano'" <gitster@pobox.com>,
        "=?utf-8?Q?'=C3=86var_Arnfj=C3=B6r=C3=B0_Bjarmason'?=" 
        <avarab@gmail.com>
Cc:     <git@vger.kernel.org>, "'Jeff King'" <peff@peff.net>,
        "'brian m . carlson'" <sandals@crustytoothpaste.net>,
        "'Bagas Sanjaya'" <bagasdotme@gmail.com>
References: <cover-0.5-00000000000-20210908T152807Z-avarab@gmail.com>        <cover-v2-0.8-00000000000-20210910T105523Z-avarab@gmail.com> <xmqqr1dwtlt1.fsf@gitster.g>
In-Reply-To: <xmqqr1dwtlt1.fsf@gitster.g>
Subject: RE: [PATCH v2 0/8] post-v2.33 "drop support for ancient curl" follow-up
Date:   Fri, 10 Sep 2021 13:06:52 -0400
Message-ID: <024f01d7a666$4338a620$c9a9f260$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIKiDYEGGDgat8hC4mgK2jv2Uo19wJ6mpY6AgZJDOirE7RUAA==
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On September 10, 2021 12:53 PM, Junio C Hamano wrote:
>To: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
>Cc: git@vger.kernel.org; Jeff King <peff@peff.net>; brian m . carlson <sandals@crustytoothpaste.net>; Bagas Sanjaya
><bagasdotme@gmail.com>
>Subject: Re: [PATCH v2 0/8] post-v2.33 "drop support for ancient curl" follow-up
>
>Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:
>
>> Version 1 of this had a really bad bug where we'd effectively make all
>> supported curl versions act like 7.19.4, i.e. the oldest supported
>> version except for a couple of our supported features. This is because
>> most of the things checked with the "ifdef" checks are enum fields,
>> not macros. So basically the "devil's advocate" Jeff King pointed out
>> in [2] was already the case. Oops!
>
>Wow.  Thanks for bothering to actually test ;-)
>
>Because we learned that "#ifdef CURL_SOME_FEATURE_WE_WANT" is not a generally applicable way to conditionally build for various
>features and we'd need to switch on the version numbers, it is now clear (at least to me) that the central registry approach would be a
>direction to go.
>
>> In this v2 we're instead checking LIBCURL_VERSION_NUM consistently,
>> even in those cases where we are checking things that are defined via
>> macros.
>
>Nice.
>
>>     ++ * For each X symbol we need from curl we define our own
>>     ++ * GIT_CURL_HAVE_X. If multiple similar symbols with the same prefix
>>     ++ * were defined in the same version we pick one and check for that name.
>>      + *
>>      + * Keep any symbols in date order of when their support was
>>      + * introduced, oldest first, in the official version of cURL library.
>>     @@ git-curl-compat.h (new)
>>      +/**
>>      + * CURLOPT_TCP_KEEPALIVE was added in 7.25.0, released in March 2012.
>>      + */
>>     -+#ifdef CURLOPT_TCP_KEEPALIVE
>>     ++#if LIBCURL_VERSION_NUM >= 0x071900
>>      +#define GITCURL_HAVE_CURLOPT_TCP_KEEPALIVE 1
>>      +#endif
>
>What we have in the posted patch is perfectly OK and serviceable, but this organization somewhat surprised me.
>
>Instead of one #if...#endif block per a feature macro, I expected to see a sequence of
>
>	/* 7.34.0 (0x072200) - Dec 2013 */
>	#if 0x072200 < VERSION
>	#define HAVE_FOO 1
>	#define HAVE_BAR 1
>	...
>	#endif
>
>	/* 7.25.0 (0x071900) - March 2012 */
>	#if 0x071900 < VERSION
>	#define HAVE_BAZ 1
>	#define HAVE_QUX 1
>	...
>        #endif
>
>
>because it would make it more clear which features can now be unconditionally used when we raise the cut-off point for the oldest
>supported version if we group these entries along the versions.
>
>Thanks.

Not that it might matter much, but both NonStop platforms are now on curl 7.78.0 and we are deploying git under OpenSSL 3 this week or next. So any objections I might previously have had are now fortunately really moot.
Cheers,
-Randall

