Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5105AC7EE2E
	for <git@archiver.kernel.org>; Tue, 28 Feb 2023 00:52:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbjB1AwO convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Mon, 27 Feb 2023 19:52:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229627AbjB1AwM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Feb 2023 19:52:12 -0500
Received: from secure.elehost.com (secure.elehost.com [185.209.179.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 247A628849
        for <git@vger.kernel.org>; Mon, 27 Feb 2023 16:52:10 -0800 (PST)
X-Virus-Scanned: Debian amavisd-new at secure.elehost.com
Received: from Mazikeen (cpebc4dfb928313-cmbc4dfb928310.cpe.net.cable.rogers.com [99.228.251.108] (may be forged))
        (authenticated bits=0)
        by secure.elehost.com (8.15.2/8.15.2/Debian-22ubuntu3) with ESMTPSA id 31S0pZ1o1102105
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Feb 2023 00:51:36 GMT
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'brian m. carlson'" <sandals@crustytoothpaste.net>
Cc:     "'Junio C Hamano'" <gitster@pobox.com>,
        "'Git List'" <git@vger.kernel.org>
References: <003d01d94b00$16abc7a0$440356e0$@nexbridge.com> <xmqqv8jmr98f.fsf@gitster.g> <003e01d94b02$877c2c20$96748460$@nexbridge.com> <Y/1GpjnMHLAqFV5x@tapette.crustytoothpaste.net>
In-Reply-To: <Y/1GpjnMHLAqFV5x@tapette.crustytoothpaste.net>
Subject: RE: Problems with CSPRNG in wrapper.c
Date:   Mon, 27 Feb 2023 19:51:56 -0500
Organization: Nexbridge Inc.
Message-ID: <004d01d94b0e$ded4e5a0$9c7eb0e0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQGBLd+J4rsGAdm8C27f2wNf7SMANAMTgfZsAtbHIHwB4bTK6K9VWEvA
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Monday, February 27, 2023 7:12 PM, brian m. carlson wrote:
>On 2023-02-27 at 23:23:36, rsbecker@nexbridge.com wrote:
>> I have already been down that path, but not successfully. /dev/urandom
>> is not available on the platform - never has, never will to my
>> knowledge. This does appear to work if PRNGD is correctly running, but
>> I can't seem to get that to work on this site. The config.mak.uname for NonStop
>does specify:
>>
>> CSPRNG_METHOD = openssl
>>
>> which should use OPENSSL_random(), shouldn't it? OpenSSL 3.0 uses the
>> _rdrand() builtin so should ever go to PRNGD, but it seems like this
>> is anyway. Debugging isn't possible as this is not on my own systems -
>> and things work here. Is there any kind of tracing I can do?
>
>It actually uses RAND_bytes.  I've confirmed on my Debian sid/amd64 system that
>compiling with "make -j8 CSPRNG_METHOD=openssl" results in the binary having a
>dependency on RAND_bytes.  (I used "nm -D".)
>
>Does your system have an nm binary that you could use to verify the linkage?
>(OpenBSD says it has existed since Version 1 Unix, but that doesn't mean it exists
>everywhere.)  Once you can verify the linkage, you'll know whether the problem is
>OpenSSL not producing CSPRNG data or whether the CSPRNG_METHOD is incorrect.

I can confirm:
Called Procedures
    Calling Procedures
----------------------------------------------------------------------
 RAND_bytes
    csprng_bytes

So that's something good. I'm wondering why this problem is showing up because my x86 OpenSSL build passes FIPS which would not if it depended on PRNGD. Both platforms call git_mkstemps_mode from csprng_bytes, but that is expected. I have opened a separate case with OpenSSL, but all tests are passing there. It seems like git is ending up in the hardware randomizer code works if PRNGD is running but fails if PRNGD is not running. I am perplexed.

