Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE,URIBL_SBL,URIBL_SBL_A shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 728101F4BD
	for <e@80x24.org>; Wed,  9 Oct 2019 05:51:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726353AbfJIFvs (ORCPT <rfc822;e@80x24.org>);
        Wed, 9 Oct 2019 01:51:48 -0400
Received: from bsmtp.bon.at ([213.33.87.14]:44818 "EHLO bsmtp.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725446AbfJIFvs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Oct 2019 01:51:48 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp.bon.at (Postfix) with ESMTPSA id 46p3J21QdHz5tlD;
        Wed,  9 Oct 2019 07:51:46 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id BFF5F1C94;
        Wed,  9 Oct 2019 07:51:44 +0200 (CEST)
Subject: Re: [PATCH 1/1] Add a helper to reverse index_pos_to_insert_pos()
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.378.git.gitgitgadget@gmail.com>
 <81648344bbab4219c0bfc60d1e5f02473ea7d495.1570517329.git.gitgitgadget@gmail.com>
 <75a9c7ce-893c-6341-ba8d-eed3ccba7ee3@kdbg.org>
 <xmqq5zkyn2a7.fsf@gitster-ct.c.googlers.com>
From:   Johannes Sixt <j6t@kdbg.org>
Message-ID: <623fcd51-5f0d-bc5b-f70d-0224a054ec5c@kdbg.org>
Date:   Wed, 9 Oct 2019 07:51:44 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <xmqq5zkyn2a7.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 09.10.19 um 03:19 schrieb Junio C Hamano:
> Johannes Sixt <j6t@kdbg.org> writes:
> 
>> We do not want to have it for *all* cases, where we return -1 - pos, but
>> only for those cases, where the result was actually encoded by
>> index_pos_to_insert_pos().
> 
> Yup, I agree with you that decoder should be fed only the data
> emitted by the encoder.
> 
> But shouldn't the code that yielded 'pos' that later gets decoded by
> computing "-1 -pos" without using the encoding helper be corrected
> to use the encoder instead?

That is the obvious conclusion, of course.

>  After all, the primary purpose of
> inventing the encoder was to catch the arith overflow, wasn't it?

That was *your* motivation for the helper function. But IMO it is a
wrong design decision. Whether or not the index calculation overflows is
a matter of the type that is used for the index, and that in turn is
dicated by the possible sizes of the collections that are indexed. IOW,
the index overflow check is (*if* it is necessary) a policy decision
that must be made at a higher level and must not be hidden away in a
helper function whose purpose (as suggested by its name) is something
entirely different.

Unless, of course, we declare "all our indexes are of type int". But
that ship has sailed long ago, because there are too many cases where we
are forced to use size_t as index (strlen, sizeof...).

Meta note: We know that we are painting a tiny shed here (Replacing a
one-liner by a one-liner, huh?) If anyone of you has better things to
do, please move on. My interest in this discussion are just the design
decisions that are made, not the actual outcome of this particular case.

-- Hannes
