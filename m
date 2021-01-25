Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2B7CC433E0
	for <git@archiver.kernel.org>; Tue, 26 Jan 2021 01:53:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9485E22DD6
	for <git@archiver.kernel.org>; Tue, 26 Jan 2021 01:53:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731683AbhAYTfl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Jan 2021 14:35:41 -0500
Received: from siwi.pair.com ([209.68.5.199]:19199 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731793AbhAYTfR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jan 2021 14:35:17 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 008963F4114;
        Mon, 25 Jan 2021 14:34:28 -0500 (EST)
Received: from jeffhost-mbp.local (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id C926F3F4113;
        Mon, 25 Jan 2021 14:34:27 -0500 (EST)
Subject: Re: [PATCH 01/10] pkt-line: use stack rather than static buffer in
 packet_write_gently()
To:     Jeff King <peff@peff.net>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.766.git.1610465492.gitgitgadget@gmail.com>
 <1155a45cf64afb237204429cd4ff2e74f5f7602a.1610465492.git.gitgitgadget@gmail.com>
 <X/71qByO5jSceIFn@coredump.intra.peff.net>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <04f62d1a-42bb-cc45-0e05-a00bfd5eceba@jeffhostetler.com>
Date:   Mon, 25 Jan 2021 14:34:27 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <X/71qByO5jSceIFn@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 1/13/21 8:29 AM, Jeff King wrote:
> On Tue, Jan 12, 2021 at 03:31:23PM +0000, Jeff Hostetler via GitGitGadget wrote:
> 
>> Teach packet_write_gently() to use a stack buffer rather than a static
>> buffer when composing the packet line message.  This helps get us ready
>> for threaded operations.
> 
> Sounds like a good goal, but...
> 
>>   static int packet_write_gently(const int fd_out, const char *buf, size_t size)
>>   {
>> -	static char packet_write_buffer[LARGE_PACKET_MAX];
>> +	char packet_write_buffer[LARGE_PACKET_MAX];
>>   	size_t packet_size;
> 
> 64k is awfully big for the stack, especially if you are thinking about
> having threads. I know we've run into issues around that size before
> (though I don't offhand recall whether there was any recursion
> involved).
> 
> We might need to use thread-local storage here. Heap would also
> obviously work, but I don't think we'd want a new allocation per write
> (or maybe it wouldn't matter; we're making a syscall, so a malloc() may
> not be that big a deal in terms of performance).
> 
> -Peff
> 

Good point.

I'll look at the callers and see if I can do something safer.

Jeeff
