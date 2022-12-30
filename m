Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46EBEC4332F
	for <git@archiver.kernel.org>; Fri, 30 Dec 2022 23:16:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235164AbiL3XQX convert rfc822-to-8bit (ORCPT
        <rfc822;git@archiver.kernel.org>); Fri, 30 Dec 2022 18:16:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235524AbiL3XQV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Dec 2022 18:16:21 -0500
Received: from elephants.elehost.com (elephants.elehost.com [216.66.27.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0F46FAD3
        for <git@vger.kernel.org>; Fri, 30 Dec 2022 15:16:19 -0800 (PST)
Received: from Mazikeen (cpebc4dfb928313-cmbc4dfb928310.cpe.net.cable.rogers.com [99.228.251.108] (may be forged))
        (authenticated bits=0)
        by elephants.elehost.com (8.16.1/8.16.1) with ESMTPSA id 2BUNGGCE015770
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
        Fri, 30 Dec 2022 18:16:17 -0500 (EST)
        (envelope-from rsbecker@nexbridge.com)
Reply-To: <rsbecker@nexbridge.com>
From:   <rsbecker@nexbridge.com>
To:     "'Taylor Blau'" <me@ttaylorr.com>
Cc:     "'Junio C Hamano'" <gitster@pobox.com>, <git@vger.kernel.org>
References: <00f901d91a47$09400110$1bc00330$@nexbridge.com> <xmqqilhwp5g4.fsf@gitster.g> <011201d91aca$a5db7800$f1926800$@nexbridge.com> <Y69SRs9ifDPagOUo@nand.local>
In-Reply-To: <Y69SRs9ifDPagOUo@nand.local>
Subject: RE: [BUG] fatal: transport 'file' not allowed during submodule add
Date:   Fri, 30 Dec 2022 18:16:11 -0500
Organization: Nexbridge Inc.
Message-ID: <000201d91ca4$b868caf0$293a60d0$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: Microsoft Outlook 16.0
Content-Language: en-ca
Thread-Index: AQIU6GJDc0yG7ZReRHFxQVmMhwXR0AFwOXgbAkFw3nkBypDvw63jka5Q
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On December 30, 2022 4:04 PM, Taylor Blau wrote:
>On Wed, Dec 28, 2022 at 09:42:39AM -0500, rsbecker@nexbridge.com wrote:
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

Ok, operator error. This does work as expected if you run the test slightly different. If the repositories are all cloned, the upstream remotes are set up properly and the submodule add works. In my test case, I used git remote add with a relative path. This seems to be an edge condition that triggers the situation. When avoiding the upstream remote command (implied by clone), the submodule add works if the protocol.file.allow = always, no matter how it is set.

--Randall

