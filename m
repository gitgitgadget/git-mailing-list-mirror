Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 15EDC1F4BD
	for <e@80x24.org>; Fri,  4 Oct 2019 17:09:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729670AbfJDRJs (ORCPT <rfc822;e@80x24.org>);
        Fri, 4 Oct 2019 13:09:48 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:56990 "EHLO bsmtp.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728671AbfJDRJs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Oct 2019 13:09:48 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp.bon.at (Postfix) with ESMTPSA id 46lGZd4C61z5tlD;
        Fri,  4 Oct 2019 19:09:45 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 8A6451CAA;
        Fri,  4 Oct 2019 19:09:44 +0200 (CEST)
Subject: Re: [PATCH v2 02/13] msvc: avoid using minus operator on unsigned
 types
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Denton Liu <liu.denton@gmail.com>
References: <pull.288.git.gitgitgadget@gmail.com>
 <pull.288.v2.git.gitgitgadget@gmail.com>
 <8800320590e4d7218a80f80abca23a7f44b8747d.1569837329.git.gitgitgadget@gmail.com>
 <xmqqy2y1a1qk.fsf@gitster-ct.c.googlers.com>
 <nycvar.QRO.7.76.6.1910041154120.46@tvgsbejvaqbjf.bet>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <ae6a64f4-8f46-cbaf-5004-defc316c5157@kdbg.org>
Date:   Fri, 4 Oct 2019 19:09:43 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.1910041154120.46@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 04.10.19 um 11:55 schrieb Johannes Schindelin:
> On Fri, 4 Oct 2019, Junio C Hamano wrote:
>> These three look good and too similar to each other, which makes me
>> wonder if we want to allow them simply write
>>
>> 	return insert_pos_as_negative_offset(nr);
>>
>> with something like
>>
>> 	static int insert_pos_as_negative_offset(uintmax_t nr)
>> 	{
>> 		if (INT_MAX < nr)
>> 			die("overflow: -1 - %"PRIuMAX, nr);
>> 		return -1 - (int)nr;
>> 	}
>>
>> to avoid repetition.
> 
> I tried not to do that because there are two different data types in
> play: `unsigned int` and `size_t`. But I guess by making this an
> `inline` function, compilers can optimize for the common case and avoid
> casting _twice_.
> 
> Will be fixed in v2,

IMHO, if you don't accompany insert_pos_as_negative_offset() with a
corresponding extract_pos_and_found_condition() and use it everywhere,
it is more obfuscating than necessary.

The *real* problem to solve is to ensure that the index/cache does not
grow so large that 32-bit indexes would be needed. Then the calculation
that you want to hide here cannot overflow.

-- Hannes
