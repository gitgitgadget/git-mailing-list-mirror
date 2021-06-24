Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEB9BC49EA5
	for <git@archiver.kernel.org>; Thu, 24 Jun 2021 15:05:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5DE7613C1
	for <git@archiver.kernel.org>; Thu, 24 Jun 2021 15:05:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230267AbhFXPH4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Jun 2021 11:07:56 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:50762 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230008AbhFXPHz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Jun 2021 11:07:55 -0400
Received: from [78.147.180.220] (helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1lwQv8-00060C-8S; Thu, 24 Jun 2021 16:05:35 +0100
Subject: Re: [PATCH] progress.c tests: fix breakage with COLUMNS != 80
To:     Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFz?= =?UTF-8?Q?on?= 
        <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
References: <patch-1.1-cba5d88ca35-20210621T070114Z-avarab@gmail.com>
 <YNPISWEBxISC30DW@coredump.intra.peff.net>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <63a4aa3c-590d-f00f-2550-2564964f054a@iee.email>
Date:   Thu, 24 Jun 2021 16:05:33 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <YNPISWEBxISC30DW@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 24/06/2021 00:48, Jeff King wrote:
> On Mon, Jun 21, 2021 at 09:01:23AM +0200, Ævar Arnfjörð Bjarmason wrote:
>
>> The tests added in 2bb74b53a49 (Test the progress display, 2019-09-16)
>> broke under anything except COLUMNS=80, i.e. when running them under
>> the "-v" mode under a differently sized terminal.
>>
>> Let's set the expected number of COLUMNS at the start of the test to
>> fix that bug. It's handy not do do this in test-progress.c itself, in
>> case we'd like to test for a different number of COLUMNS, either
>> manually or in a future test.
> Hmm. So I can easily reproduce the problem here, and your patch fixes
> it. But my first thought was: shouldn't test-lib.sh be handling this to
> give all of the scripts a uniform environment?
>
> And indeed, we _do_ unset COLUMNS there. So I think the problem isn't
> a bad setting of $COLUMNS, but rather that in "-v" mode, the
> sub-command's stderr is hooked to our tty, and term_columns() is smart
> enough to use TIOCGWINSZ to get the value (at least on some platforms).
>
> Setting $COLUMNS again in the environment fixes it, because we prefer
> that value to trying the ioctl.
>
> So I don't think what you have here is wrong (though the commit message
> is a little misleading). But it seems like the original intent of our
> "unset COLUMNS" in test-lib.sh would best be fulfilled by setting it to
> a known value there (like 80), rather than unsetting it.
>
> I admit this a _bit_ of a nitpick (since as far as we know none of the
> other scripts care about the terminal width), so I'm OK with this as-is
> if you feel strongly the other way.
>
> -Peff
There has been a similar recent issue [1] on Git for Windows regarding
these settings where different terminals had different views  about the
size of the display window which resulted in incorrect out puts.

Philip

[1] https://github.com/git-for-windows/git/issues/3235
