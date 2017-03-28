Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 809FE1FCA0
	for <e@80x24.org>; Tue, 28 Mar 2017 15:29:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753056AbdC1P1s (ORCPT <rfc822;e@80x24.org>);
        Tue, 28 Mar 2017 11:27:48 -0400
Received: from siwi.pair.com ([209.68.5.199]:26930 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751523AbdC1P1q (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Mar 2017 11:27:46 -0400
Received: from [10.160.98.126] (unknown [167.220.148.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id C440F84673;
        Tue, 28 Mar 2017 11:27:19 -0400 (EDT)
Subject: Re: [PATCH v2 1/2] read-cache: skip index SHA verification
To:     Jeff King <peff@peff.net>
References: <1490648979-49580-1-git-send-email-git@jeffhostetler.com>
 <1490648979-49580-2-git-send-email-git@jeffhostetler.com>
 <20170327224408.2bzh5vfa6deni6fm@sigill.intra.peff.net>
Cc:     git@vger.kernel.org, gitster@pobox.com,
        Jeff Hostetler <jeffhost@microsoft.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <7b40fea5-8843-b95b-5ea5-c8035ea8a36e@jeffhostetler.com>
Date:   Tue, 28 Mar 2017 11:27:19 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <20170327224408.2bzh5vfa6deni6fm@sigill.intra.peff.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 3/27/2017 6:44 PM, Jeff King wrote:
> On Mon, Mar 27, 2017 at 09:09:38PM +0000, git@jeffhostetler.com wrote:
>
>> From: Jeff Hostetler <jeffhost@microsoft.com>
>>
>> Teach git to skip verification of the index SHA in read_index().
>>
>> This is a performance optimization.  The index file SHA verification
>> can be considered an ancient relic from the early days of git and only
>> useful for detecting disk corruption.  For small repositories, this
>> SHA calculation is not that significant, but for gigantic repositories
>> this calculation adds significant time to every command.
>>
>> I added a global "skip_verify_index" variable to control this and
>> allow it to be tested.
>>
>> I did not create a config setting for this because of chicken-n-egg
>> problems with the loading the config and the index.
>
> Hrm, there shouldn't be any dependency of the config on the index (and
> there are a handful of options which impact the index already). Did you
> try it and run into problems?

Yeah, I tried adding a new "core.verifyindex" property and the
corresponding global variable.  But read_index() and verify_hdr()
was being called BEFORE the config was loaded.  And it wasn't clear
how best to solve that.

The issue was in "git status" where cmd_status() called
status_init_config() which called gitmodules_config() before
git_config().  but gitmodules_config() called read_index(),
so my settings weren't loaded yet in verify_hdr().

I tried switching the order in status_init_config(), but
that caused errors in t7508 with submodules not being handled
properly.

https://github.com/jeffhostetler/git/commits/upstream/core_verify_index

At this point I decided that it wasn't that important to have
this config setting, since we'll probably default it to be faster
and be done with it.

>
> In general, I'd much rather see us either:
>
>   1. Rip the code out entirely if it is not meant to be configurable,
>      and cannot be triggered by the actual git binary.
>
> or
>
>   2. Make it configurable, even if most people wouldn't use it. And then
>      have a test to exercise it using a git command (unlike the one-off
>      test helper, which isn't run at all).
>
> -Peff
>

I'm OK with (1) if everyone else is.

Jeff

