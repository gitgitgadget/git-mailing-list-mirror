Return-Path: <SRS0=rdad=ID=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21161C433DB
	for <git@archiver.kernel.org>; Fri,  5 Mar 2021 21:31:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDE72650A3
	for <git@archiver.kernel.org>; Fri,  5 Mar 2021 21:31:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbhCEVbX (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Mar 2021 16:31:23 -0500
Received: from siwi.pair.com ([209.68.5.199]:18625 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229562AbhCEVa7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Mar 2021 16:30:59 -0500
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 7B74F3F40D9;
        Fri,  5 Mar 2021 16:30:58 -0500 (EST)
Received: from MININT-RVM6V2G.redmond.corp.microsoft.com (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 3DFFA3F4096;
        Fri,  5 Mar 2021 16:30:58 -0500 (EST)
Subject: Re: [PATCH v4 09/12] unix-socket: disallow chdir() when creating unix
 domain sockets
To:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
Cc:     Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.766.v3.git.1613174954.gitgitgadget@gmail.com>
 <pull.766.v4.git.1613598529.gitgitgadget@gmail.com>
 <1bfa36409d0706d5e22703f80bf95dfa1a313a83.1613598529.git.gitgitgadget@gmail.com>
 <xmqqblbzj1cs.fsf@gitster.c.googlers.com>
 <YED1DmLWd+ciySNa@coredump.intra.peff.net>
 <xmqqa6riejyp.fsf@gitster.c.googlers.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <ed933c34-85d2-c238-122f-13751a11ca7f@jeffhostetler.com>
Date:   Fri, 5 Mar 2021 16:30:57 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <xmqqa6riejyp.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 3/4/21 3:34 PM, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
> 
>> The feature is definitely useful; I think I did 1eb10f4091 (unix-socket:
>> handle long socket pathnames, 2012-01-09) in response to a real problem.
>>
>> Certainly callers could handle the error themselves. The reason I pushed
>> it down into the socket code was to avoid having to implement in
>> multiple callers. There are only two, but we'd have needed it in both
>> sides (credential-cache--daemon as the listener, and credential-cache as
>> the client).
>>
>> Ironically, the listening side now does a permanent chdir() to the
>> socket directory anyway, since 6e61449051 (credential-cache--daemon:
>> change to the socket dir on startup, 2016-02-23). So we could just do
>> that first, and then feed the basename to the socket code.
>>
>> The client side would still need to handle it, though. It could probably
>> also chdir to the socket directory without any real downside (once
>> started, I don't think the helper program needs to access the filesystem
>> at all outside of the socket).
>>
>> So I dunno. I'd be OK to just rip the feature out in favor of doing
>> those chdir()s. But that seems like a non-zero amount of work versus
>> leaving, and the existing code has the benefit that if another caller
>> shows up, it could benefit from the feature.
> 
> I am OK to keep the series as-is, and leave it to a possible future
> work to remove the need for chdir even for long paths and not having
> to return an error with ENAMETOOLONG; when such an update happens,
> the "fail if need to chdir" feature this patch is adding will become
> a no-op.
> 

I think I'd like to keep things as I have them now with the "disallow
chdir()" option bit and save the "fork() / bind()" solution for a
later patch series.  Simple IPC is large enough as it is and the new
ENAMETOOLONG error will only affect callers who set the bit.  A later
patch series can easily test and confirm the "fork() / bind() solution
in isolation and test it on the other Unix hosts and then remove the
bit from those callers (if we want).

Jeff
