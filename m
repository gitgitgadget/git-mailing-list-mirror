Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5B9EA1F461
	for <e@80x24.org>; Sun, 14 Jul 2019 08:15:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728106AbfGNIPa (ORCPT <rfc822;e@80x24.org>);
        Sun, 14 Jul 2019 04:15:30 -0400
Received: from bsmtp7.bon.at ([213.33.87.19]:12743 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726799AbfGNIPa (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Jul 2019 04:15:30 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 45mfbz4f55z5tl9;
        Sun, 14 Jul 2019 10:15:27 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 957401D1E;
        Sun, 14 Jul 2019 10:15:26 +0200 (CEST)
Subject: Re: [PATCH] range-diff: fix some 'hdr-check' and sparse warnings
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Thomas Gummerer <t.gummerer@gmail.com>,
        GIT Mailing-list <git@vger.kernel.org>,
        Jeff King <peff@peff.net>
References: <e6796c60-a870-e761-3b07-b680f934c537@ramsayjones.plus.com>
 <41a60e60-d2c0-7d54-5456-e44d106548a4@kdbg.org>
 <xmqqy313p5hn.fsf@gitster-ct.c.googlers.com>
 <ec635d0d-00ca-2419-3c1a-9b0343b46daa@kdbg.org>
 <xmqq1rytpqse.fsf@gitster-ct.c.googlers.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <9d6c7595-e320-7fa2-1f02-2f078b3831fa@kdbg.org>
Date:   Sun, 14 Jul 2019 10:15:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <xmqq1rytpqse.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 13.07.19 um 23:29 schrieb Junio C Hamano:
> I do not think this position is maintainable, especially if you
> agree with me (and everybody else, including sparse) that this is a
> bad idea:
> 
>>   struct string_list dup_it = { 0, 0, 0, 1, 0 };
> 
> The way I read "6.7.8 Initialization" (sorry, I only have committee
> draft wg14/n1124 of 2005 handy) is that
> 
> 	struct patch patch = { 0 };
> 
> has an initializer for a structure with an automatic storage
> duration, and for each of the subsequent fields of the structure
> (i.e. we ran out the initializer after dealing with that single zero
> that talks about the first field), due to "all subobjects that are
> not initialized explicitly shall be initialized implicitly the same
> as objects that have static storage duration." rule, "if it has a
> pointer type, it is initialized to a null pointer", which is exactly
> in line with your (and our) position that the first example I left
> in the above (new_name gets assigned NULL).  So we are fine with the
> fields that are not speled out.
> 
> But then what about the explicitly spelled out 0 for the first
> field?

You are putting too much meaning in the token '0' when it appears in the
token sequence '= { 0 }'. I understand this sequence as a signal to the
reader of the code that "the whole struct is to be zero-initialized".
NOT "the first member is set to zero and everything else the default
zero value".

It just so happens that the compiler does the right thing with that '0'
regardless of what type the first member has. (It even works when it is
a struct, Peff!) That zero is a null pointer constant if the first
member happens to be a pointer, i.e., the same value that is used for
all other implicitly zero-initialized pointers.

>  It is like an assignment, so by arguing that we should have
> 0 over there and not NULL, you are essentially arguing for
> 
> 	patch.new_name = 0; /* not NULL */
> 
> aren't you?

No,no. You are stretching my argument too far. I really only mean the
sequence = { 0 } as a signal. When this form of zero-initialization
becomes established, it takes away mental burden from the reader. It
need not be decomposed into its parts; there is no question of what is
it that is initialized by '0', and what happens to the rest of the
struct. It means "zero, all of it" without thinking.

> I wish if we could say
> 
> 	struct patch patch = {};
> 
> so that we an leave all fields to have their natural zero value

YES!

-- Hannes
