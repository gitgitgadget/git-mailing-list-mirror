Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F09E7C4332F
	for <git@archiver.kernel.org>; Fri, 30 Dec 2022 21:43:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230100AbiL3Vnv convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Fri, 30 Dec 2022 16:43:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiL3Vnu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Dec 2022 16:43:50 -0500
Received: from elephants.elehost.com (elephants.elehost.com [216.66.27.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92A5E1B1D4
        for <git@vger.kernel.org>; Fri, 30 Dec 2022 13:43:49 -0800 (PST)
Received: from Mazikeen (cpebc4dfb928313-cmbc4dfb928310.cpe.net.cable.rogers.com [99.228.251.108] (may be forged))
        (authenticated bits=0)
        by elephants.elehost.com (8.16.1/8.16.1) with ESMTPSA id 2BULhkoC012759
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 30 Dec 2022 16:43:47 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'Taylor Blau'" <me@ttaylorr.com>
Cc:     "'Junio C Hamano'" <gitster@pobox.com>, <git@vger.kernel.org>
References: <00f901d91a47$09400110$1bc00330$@nexbridge.com> <xmqqilhwp5g4.fsf@gitster.g> <011201d91aca$a5db7800$f1926800$@nexbridge.com> <Y69SRs9ifDPagOUo@nand.local>
In-Reply-To: <Y69SRs9ifDPagOUo@nand.local>
Subject: RE: [BUG] fatal: transport 'file' not allowed during submodule add
Date:   Fri, 30 Dec 2022 16:43:41 -0500
Organization: Nexbridge Inc.
Message-ID: <000701d91c97$cc35fd30$64a1f790$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQIU6GJDc0yG7ZReRHFxQVmMhwXR0AFwOXgbAkFw3nkBypDvw63jevbA
Content-Language: en-ca
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On December 30, 2022 4:04 PM, Taylor Blau wrote:
>On Wed, Dec 28, 2022 at 09:42:39AM -0500, rsbecker@nexbridge.com wrote:
>> >-----Original Message-----
>> >From: Junio C Hamano <jch2355@gmail.com> On Behalf Of Junio C Hamano
>> On December 27, 2022 10:34 PM, Junio C Hamano wrote:
>> ><rsbecker@nexbridge.com> writes:
>> >
>> >> As of 2.39.0, I am now getting fatal: transport 'file' not allowed
>> >> when performing a submodule add after a clone -l. The simple
>> >> reproduce of this
>> >> is:
>> >> ...
>> >> This happens for any submodule add on the same system. Some online
>> >> research indicates that there was a security patch to git causing
>> >> this, but I can't find it. This does not seem correct to me or how
>> >> this
>> improves
>> >security.
>> >> Help please - this is causing some of my workflows to break.
>> >
>> >Thanks for reporting, Randall.
>> >
>> >This suspiciously sounds like what a1d4f67c (transport: make
>> `protocol.file.allow`
>> >be "user" by default, 2022-07-29) is doing deliberately.  Taylor,
>> >does this
>> look like a
>> >corner case the 2.30.6 updates forgot to consider?
>>
>> I have tried using 'git config --local protocol.file.allow always'
>> and/or 'git config --local protocol.allow always' to get past this,
>> without success.
>
>I couldn't reproduce the symptom you described. Indeed, the behavior of not
>allowing local-submodules to be cloned without explicitly opting in via the
>`protocol.file.allow` configuration is intentional.
>
>The patch Junio mentioned, a1d4f67c12 (transport: make `protocol.file.allow` be
>"user" by default, 2022-07-29) has some examples of why this behavior was
>changed in the 2.30.6 update.
>
>If you run either `git config --global protocol.file.allow always`, or replace your last
>submodule add with:
>
>  $ git -c protocol.file.allow=always submodule add /path/to/subsrc.git
>
>it should work as expected.

I have reproduced this on multiple platforms including NonStop and Cygwin64 on Windows with the same results as earlier. The protocol.file.allowed=always does not appear to even get considered. With some fprintfs in the code, the code in is_transport_allowed falls through to the PROTOCOL_ALLOW_USER_ONLY case and only considers environment variable GIT_PROTOCOL_FROM_USER, which is not passed into the child doing the submodule add. The is_transport_allowed("file",-1) always returns 0 no matter what and 0 is what gets used upwards. There is no difference in the behaviour regardless of the protocol.file.allowed value either in -c, .gitconfig, or on the user environment variable.

