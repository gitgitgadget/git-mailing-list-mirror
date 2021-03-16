Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B0AAC433DB
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 14:21:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 46BAB65075
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 14:21:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236184AbhCPOVC (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Mar 2021 10:21:02 -0400
Received: from siwi.pair.com ([209.68.5.199]:12822 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230325AbhCPOUd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Mar 2021 10:20:33 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id C54FE3F404F;
        Tue, 16 Mar 2021 10:20:30 -0400 (EDT)
Received: from HCIPROD2.AZHCI.com (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 8CB243F4047;
        Tue, 16 Mar 2021 10:20:30 -0400 (EDT)
Subject: Re: [PATCH] fsmonitor: avoid global-buffer-overflow READ when
 checking trivial response
To:     Andrzej Hunt via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Jeff Hostetler <jeffhost@microsoft.com>,
        Andrzej Hunt <andrzej@ahunt.org>,
        Andrzej Hunt <ajrhunt@google.com>
References: <pull.904.git.1615826363431.gitgitgadget@gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <c34badb9-a3bc-a5fe-c6fc-c1bdce867e0d@jeffhostetler.com>
Date:   Tue, 16 Mar 2021 10:20:29 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <pull.904.git.1615826363431.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 3/15/21 12:39 PM, Andrzej Hunt via GitGitGadget wrote:
> From: Andrzej Hunt <ajrhunt@google.com>
> 
> query_result can be be an empty strbuf (STRBUF_INIT) - in that case
> trying to read 3 bytes triggers a buffer overflow read (as
> query_result.buf = '\0').
> 
> Therefore we need to check query_result's length before trying to read 3
> bytes.
> 
> This overflow was introduced in:
>    940b94f35c (fsmonitor: log invocation of FSMonitor hook to trace2, 2021-02-03)
> It was found when running the test-suite against ASAN, and can be most
> easily reproduced with the following command:

[...]

>      fsmonitor: fix overflow read
>      
>      This patch fixes a buffer overflow read in
>      fsmonitor_is_trivial_response().
>      
>      I'm not super familiar with fsmonitor, so I'm not 100% sure what the
>      empty response actually means. Based on my reading of the docs below,
>      this can happen with fsmonitor-watchman v1 when no files have changed.
>      But it could also happen for v2 if the implementation is broken (in
>      which case we also shouldn't overflow)? Either way, I'm guessing the
>      empty response doesn't count as trivial:
>      https://git-scm.com/docs/githooks#_fsmonitor_watchman
>      
>      The other question I had is: can watchman V1 return "/\0" as the trivial
>      response (as it has no token header) - and should we be recognising that
>      too?
>      
>      ATB,
>      
>      Andrzej

[...]

Looks good to me.  And thanks for catching this.

WRT your questions:

An empty response means no files have changed since the last query.
The client can assume all cache-entries are valid and doesn't need
to scan.

A "trivial" response means that the monitor doesn't have enough
information to answer the question. The client should assume that
everything is invalid and do a full scan (as if no monitor were
present).

I added the `fsmonitor_is_trivial_response()` function with the
tracing that I added in [1] in preparation for adding a builtin
fsmonitor service (and currently only my tracing uses that function),
but the concept of a trivial "/" response line has been present since
the initial fsmonitor implementation [2].   See [3] and [4].

[1] 940b94f35c (fsmonitor: log invocation of FSMonitor hook to trace2, 
2021-02-03)
[2] 883e248b8a (fsmonitor: teach git to optionally utilize a file system 
monitor to speed up detecting new or changed files., 2017-09-22)
[3] 
https://github.com/git/git/blob/a5828ae6b52137b913b978e16cd2334482eb4c1f/fsmonitor.c#L304
[4] 
https://github.com/git/git/blob/a5828ae6b52137b913b978e16cd2334482eb4c1f/fsmonitor.c#L320

Thanks again for the review.
Jeff
