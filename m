Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 031A41F4BD
	for <e@80x24.org>; Sun,  6 Oct 2019 10:53:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726492AbfJFKxb (ORCPT <rfc822;e@80x24.org>);
        Sun, 6 Oct 2019 06:53:31 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:45408 "EHLO bsmtp.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726224AbfJFKxb (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 6 Oct 2019 06:53:31 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp.bon.at (Postfix) with ESMTPSA id 46mL7X0xhcz5tl9;
        Sun,  6 Oct 2019 12:53:28 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 5B5304AAF;
        Sun,  6 Oct 2019 12:53:27 +0200 (CEST)
Subject: Re: [PATCH v2 02/13] msvc: avoid using minus operator on unsigned
 types
To:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Denton Liu <liu.denton@gmail.com>
References: <pull.288.git.gitgitgadget@gmail.com>
 <pull.288.v2.git.gitgitgadget@gmail.com>
 <8800320590e4d7218a80f80abca23a7f44b8747d.1569837329.git.gitgitgadget@gmail.com>
 <xmqqy2y1a1qk.fsf@gitster-ct.c.googlers.com>
 <nycvar.QRO.7.76.6.1910041154120.46@tvgsbejvaqbjf.bet>
 <ae6a64f4-8f46-cbaf-5004-defc316c5157@kdbg.org>
 <nycvar.QRO.7.76.6.1910042319190.46@tvgsbejvaqbjf.bet>
 <xmqqr23q68rg.fsf@gitster-ct.c.googlers.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <ff6896de-ba12-6669-d6e0-980ed0fcd1e4@kdbg.org>
Date:   Sun, 6 Oct 2019 12:53:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <xmqqr23q68rg.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 06.10.19 um 02:02 schrieb Junio C Hamano:
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
>>> IMHO, if you don't accompany insert_pos_as_negative_offset() with a
>>> corresponding extract_pos_and_found_condition() and use it everywhere,
>>> it is more obfuscating than necessary.
>>
>> I do disagree here. No overflow checking needs to be performed for `-1 -
>> <int-value>`. And that's what the opposite of this function really boils
>> down to.
> 
> I do not think j6t is referring to the over/underflow issues at all.
> 
> The suggestion is that, because insert-pos-as-negative-offset
> abstracts away [...] the fact that
> "does not exist but here is the location it would be inserted" is
> encoded in a certain way [...], the side that
> consumes the encoded "pos" [...] should be abstracted away [...].

Thank you, that summarizes my thoughts very well.

> I think that is a reasonable thing to consider; it is not necessary
> for correctness, but contributes to the conceptual clarity (iow, it
> can be left as a separate clean-up step done after the series is
> done).

Thanks, but I disagree with the course of action: I think we should do
both sides at the same time. (And if we aren't ready to do the decoding
side now, then we should delay the encoding side).

Consider someone is looking at the call site without knowing the
detailed meaning of the return value ("What the heck is this -1
business?"), it is a matter to look at the function being called to know
what it is. With another function that does the encoding, it is one
additional hop. That is my reason for saying "more obfuscating than
necessary".

That the helper function would reduce some small code duplication does
not outweigh the obfuscation in my book. That's just MHO, of course.

-- Hannes
