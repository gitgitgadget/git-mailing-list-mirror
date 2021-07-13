Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AAEEC07E95
	for <git@archiver.kernel.org>; Tue, 13 Jul 2021 18:19:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F54E613AF
	for <git@archiver.kernel.org>; Tue, 13 Jul 2021 18:19:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234131AbhGMSWJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Jul 2021 14:22:09 -0400
Received: from siwi.pair.com ([209.68.5.199]:12381 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229478AbhGMSWI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jul 2021 14:22:08 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id F18D43F40DA;
        Tue, 13 Jul 2021 14:19:17 -0400 (EDT)
Received: from AZHCI-MGMT.azhci.com (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 97AD43F4047;
        Tue, 13 Jul 2021 14:19:17 -0400 (EDT)
Subject: Re: [PATCH v3 24/34] t/perf/p7519: speed up test using "test-tool
 touch"
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren <newren@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <stolee@gmail.com>,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.923.v2.git.1621691828.gitgitgadget@gmail.com>
 <pull.923.v3.git.1625150864.gitgitgadget@gmail.com>
 <f1ef9656fc3adf079c8e40a74baeb5356bcf1586.1625150864.git.gitgitgadget@gmail.com>
 <87h7hdbpgb.fsf@evledraar.gmail.com>
 <c6793033-9bd4-e108-4a53-56c1dbd24a60@jeffhostetler.com>
 <CABPp-BF+GiAZVxeC+MAr6pSssRpSi2pNwHLrxUp9HvrOhUBieg@mail.gmail.com>
 <797f4e85-33cc-df7e-31d8-3a4f95a9109a@jeffhostetler.com>
 <xmqqtuky141l.fsf@gitster.g>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <042e011c-1e13-0400-59d8-030481c5f329@jeffhostetler.com>
Date:   Tue, 13 Jul 2021 14:19:16 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <xmqqtuky141l.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 7/13/21 2:07 PM, Junio C Hamano wrote:
> Jeff Hostetler <git@jeffhostetler.com> writes:
> 
>> FWIW, the xargs is clustering the 10,000 files into ~4 command lines,
>> so there is a little bit of Windows process overhead, but not that
>> much.
>>
>> 	seq 1 10000 | xargs wc -l | grep total
>>
>>> I'd really like to modify test_seq to use seq when it's available and
>>> fall back to the looping-in-shell when we need to for various
>>> platforms.
>>> Maybe it'd even make sense to write a 'test-tool seq' and make
>>> test_seq use that just so we can rip out that super lame shell
>>> looping.
>>>
> 
> So what lame in this picture is not shell, or process overhead, but
> I/O performance.
> 
> I've seen some noises about Windows file creation performance raised
> as an issue when doing initial checkout followed by "git clone", and
> an idea floated to create a bunch of open file handles for writing
> in threads when checkout (really the caller that repeatedly calls
> entry.c:write_entry() by iterating the in-core index) starts, and
> write out the contents in parallel, as a workaround.  When I heard
> it, I somehow thought it was meant as a not-so-funny joke, but from
> the sounds of it, the I/O performance may be so horrible to require
> such a hack to be usable there.  Sigh...
> 

Yes, there are some things here (that I believe to be I/O related)
on Windows that I want to look at when I wrap up FSMonitor.  And
yes, some of them sound pretty stupid.

Jeff

