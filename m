Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A1071F731
	for <e@80x24.org>; Wed,  7 Aug 2019 20:25:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389288AbfHGUZ1 (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Aug 2019 16:25:27 -0400
Received: from siwi.pair.com ([209.68.5.199]:13243 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389251AbfHGUZ1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Aug 2019 16:25:27 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 0A4CA3F4135;
        Wed,  7 Aug 2019 16:25:26 -0400 (EDT)
Received: from [IPv6:2001:4898:6808:13e:9d4f:d974:4879:2e91] (unknown [IPv6:2001:4898:a800:1012:4e83:d974:4879:2e91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id B587F3F40CB;
        Wed,  7 Aug 2019 16:25:25 -0400 (EDT)
Subject: Re: [PATCH 2/3] trace2: trim whitespace in start message in perf
 target format
To:     Junio C Hamano <gitster@pobox.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.298.git.gitgitgadget@gmail.com>
 <834ee95cd2fe919c7a5a2d3cc3d647cfdeebe9e6.1564603467.git.gitgitgadget@gmail.com>
 <xmqqef24muxe.fsf@gitster-ct.c.googlers.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <827ed342-1079-8145-ed78-1b955264226e@jeffhostetler.com>
Date:   Wed, 7 Aug 2019 16:25:24 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <xmqqef24muxe.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 8/1/2019 5:34 PM, Junio C Hamano wrote:
> "Jeff Hostetler via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>> From: Jeff Hostetler <jeffhost@microsoft.com>
>>
>> Trim leading/trailing whitespace from the command line
>> printed in the "start" message in the perf target format.
>>
>> We use `sq_quote_argv_pretty()` to format the message
>> and it adds a leading space to the output.  Trim that.
> 
> strbuf_trim() not just drops a single leading space, but removes
> consecutive spaces from both ends.  But the first char after the SP
> comes from the first arg, and it can never be a whitespace (as a
> payload that begins with a whitespace will be quoted, so it will be
> a single quote), and the last char in the buffer would also be
> either a closing single quote (if the last argument ends with a
> whitespace) or a non whitespace "safe" character, so it is safe to
> use strbuf_trim() here.
> 
> I wonder if we want to lose the prepending of SP from
> sq_quote_argv_pretty(), though:

I was wondering about that too, but I didn't want to presume
to know what all of the callers wanted.  And didn't want to
slip in such a change last-minute.

I'll re-roll with a new sq_quote_ function that does not
include the leading whitespace and convert/normalize all
of my trace2/* uses to call it instead.  This eliminates
the Trace2 code from the larger conversation (and is a
little more efficient than the strbuf_trim()).

Jeff
