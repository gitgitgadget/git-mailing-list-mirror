Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21378C43461
	for <git@archiver.kernel.org>; Fri, 30 Apr 2021 16:17:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02F2D6109E
	for <git@archiver.kernel.org>; Fri, 30 Apr 2021 16:17:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbhD3QSH (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Apr 2021 12:18:07 -0400
Received: from siwi.pair.com ([209.68.5.199]:28938 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229579AbhD3QSH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Apr 2021 12:18:07 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 2815F3F4128;
        Fri, 30 Apr 2021 12:17:18 -0400 (EDT)
Received: from HCIPROD2.AZHCI.com (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id AC3E03F4119;
        Fri, 30 Apr 2021 12:17:17 -0400 (EDT)
Subject: Re: [PATCH 11/23] fsmonitor--daemon: define token-ids
To:     Derrick Stolee <stolee@gmail.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Jeff Hostetler <jeffhost@microsoft.com>
References: <pull.923.git.1617291666.gitgitgadget@gmail.com>
 <304fe03034f8622aa8728d8872cc9bc539bab861.1617291666.git.gitgitgadget@gmail.com>
 <3f0c5c7d-8448-15ec-9e12-b2745d7bbf2b@gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <6f531ece-f95f-5825-4c2e-0fd7373de6b7@jeffhostetler.com>
Date:   Fri, 30 Apr 2021 12:17:16 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <3f0c5c7d-8448-15ec-9e12-b2745d7bbf2b@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 4/26/21 3:49 PM, Derrick Stolee wrote:
> On 4/1/2021 11:40 AM, Jeff Hostetler via GitGitGadget wrote:
>> From: Jeff Hostetler <jeffhost@microsoft.com>
>>
>> Teach fsmonitor--daemon to create token-ids and define the
>> overall token naming scheme.
> ...
>> +/*
>> + * Requests to and from a FSMonitor Protocol V2 provider use an opaque
>> + * "token" as a virtual timestamp.  Clients can request a summary of all
>> + * created/deleted/modified files relative to a token.  In the response,
>> + * clients receive a new token for the next (relative) request.
>> + *
>> + *
>> + * Token Format
>> + * ============
>> + *
>> + * The contents of the token are private and provider-specific.
>> + *
>> + * For the built-in fsmonitor--daemon, we define a token as follows:
>> + *
>> + *     "builtin" ":" <token_id> ":" <sequence_nr>
>> + *
>> + * The <token_id> is an arbitrary OPAQUE string, such as a GUID,
>> + * UUID, or {timestamp,pid}.  It is used to group all filesystem
>> + * events that happened while the daemon was monitoring (and in-sync
>> + * with the filesystem).
>> + *
>> + *     Unlike FSMonitor Protocol V1, it is not defined as a timestamp
>> + *     and does not define less-than/greater-than relationships.
>> + *     (There are too many race conditions to rely on file system
>> + *     event timestamps.)
>> + *
>> + * The <sequence_nr> is a simple integer incremented for each event
>> + * received.  When a new <token_id> is created, the <sequence_nr> is
>> + * reset to zero.
>> + *
>> + *
>> + * About Token Ids
>> + * ===============
>> + *
>> + * A new token_id is created:
>> + *
>> + * [1] each time the daemon is started.
>> + *
>> + * [2] any time that the daemon must re-sync with the filesystem
>> + *     (such as when the kernel drops or we miss events on a very
>> + *     active volume).
>> + *
>> + * [3] in response to a client "flush" command (for dropped event
>> + *     testing).
>> + *
>> + * [4] MAYBE We might want to change the token_id after very complex
>> + *     filesystem operations are performed, such as a directory move
>> + *     sequence that affects many files within.  It might be simpler
>> + *     to just give up and fake a re-sync (and let the client do a
>> + *     full scan) than try to enumerate the effects of such a change.
>> + *
>> + * When a new token_id is created, the daemon is free to discard all
>> + * cached filesystem events associated with any previous token_ids.
>> + * Events associated with a non-current token_id will never be sent
>> + * to a client.  A token_id change implicitly means that the daemon
>> + * has gap in its event history.
>> + *
>> + * Therefore, clients that present a token with a stale (non-current)
>> + * token_id will always be given a trivial response.
> 
>  From this comment, it seems to be the case that concurrent Git
> commands will race to advance the FS Monitor token and one of them
> will lose, causing a full working directory scan. There is no list
> of "recent" tokens.
> 
> I could see this changing in the future, but for now it is a
> reasonable simplification.

The daemon only creates a new token-id when it needs to because of
a loss of sync with the FS.  And the sequence-nr is advanced based
upon the quantity of FS activity.  Clients don't cause either to
change or advance (except for the flush, which is a testing hack).

Ideally, the token-id is created when the daemon starts up and is
never changed.

Concurrent clients all receive normalized event data from the
in-memory cache/queue from threads reading the queue in parallel.


I included [4] as a possible future enhancement, but so far haven't
actually needed it.  The event stream (at least on Windows and MacOS)
from the OS is sufficient that I didn't need to implement that.

I'll remove [4] from the comments.

Thanks,
Jeff
