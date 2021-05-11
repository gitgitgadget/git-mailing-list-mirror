Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B040C433ED
	for <git@archiver.kernel.org>; Tue, 11 May 2021 23:12:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4ABDE610F8
	for <git@archiver.kernel.org>; Tue, 11 May 2021 23:12:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbhEKXN7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 May 2021 19:13:59 -0400
Received: from siwi.pair.com ([209.68.5.199]:42155 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230369AbhEKXN4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 May 2021 19:13:56 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id C4EAF3F4095;
        Tue, 11 May 2021 19:12:48 -0400 (EDT)
Received: from MININT-RVM6V2G.redmond.corp.microsoft.com (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 64EBD3F4047;
        Tue, 11 May 2021 19:12:48 -0400 (EDT)
Subject: Re: [PATCH v4 1/8] dir: convert trace calls to trace2 equivalents
To:     Elijah Newren <newren@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <stolee@gmail.com>, Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Josh Steadmon <steadmon@google.com>
References: <pull.1020.v3.git.git.1620503945.gitgitgadget@gmail.com>
 <pull.1020.v4.git.git.1620758049.gitgitgadget@gmail.com>
 <9204e36b7e9035c4cdda018d7ced8e8ca7acc8bc.1620758049.git.gitgitgadget@gmail.com>
 <df3695ad-5ba7-df22-2a2a-ca799c5d16d8@jeffhostetler.com>
 <CABPp-BGeOUOvYRD+gX4jVR0kN8O5_icKtT18F9BdeR424DjUmg@mail.gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <a01ffeaf-31de-fdf5-3992-bea40feb1213@jeffhostetler.com>
Date:   Tue, 11 May 2021 19:12:47 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <CABPp-BGeOUOvYRD+gX4jVR0kN8O5_icKtT18F9BdeR424DjUmg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 5/11/21 4:12 PM, Elijah Newren wrote:
> On Tue, May 11, 2021 at 12:06 PM Jeff Hostetler <git@jeffhostetler.com> wrote:
>>
>> On 5/11/21 2:34 PM, Elijah Newren via GitGitGadget wrote:
>>> From: Elijah Newren <newren@gmail.com>
>>>
>>> Signed-off-by: Elijah Newren <newren@gmail.com>
>>> ---
>>>    dir.c                             |  43 +++++--
>>>    t/t7063-status-untracked-cache.sh | 205 ++++++++++++++++++------------
>>>    t/t7519-status-fsmonitor.sh       |   8 +-
>>>    3 files changed, 155 insertions(+), 101 deletions(-)
>>>
>>> diff --git a/dir.c b/dir.c
>>> index 3474e67e8f3c..122fcbffdf89 100644
>>> --- a/dir.c
>>> +++ b/dir.c
>>> @@ -2760,15 +2760,34 @@ static struct untracked_cache_dir *validate_untracked_cache(struct dir_struct *d
>>>        return root;
>>>    }
>>>
>>> +static void trace2_read_directory_statistics(struct dir_struct *dir,
>>> +                                          struct repository *repo,
>>> +                                          const char *path)
>>> +{
>>> +     if (!dir->untracked)
>>> +             return;
>>> +     trace2_data_string("read_directory", repo, "path", path);
>>
>> I'm probably just nit-picking here, but should this look more like:
> 
> nit-picking and questions are totally fine.  :-)  Thanks for reviewing.
> 
>>
>>          if (path && *path)
>>                  trace2_data_string(...)
> 
> path is always non-NULL (it'd be an error to call read_directory()
> with a NULL path).  So the first part of the check isn't meaningful
> for this particular code.  The second half is interesting.  Do we want
> to omit the path when it happens to be the toplevel directory (the
> case where !*path)?  The original trace_performance_leave() calls
> certainly didn't, and I was just trying to provide the same info they
> do, as you suggested.  I guess people could determine the path by
> knowing that the code doesn't print it when it's empty, but do we want
> trace2 users to need to read the code to figure out statistics and
> info?

that's fine.  it might be easier to just always print it (even if
blank) so that post-processors know that rather than have to assume
it.

> 
>>          if (!dir->untracked)
>>                  return;
>>
>> Then when you add the visitied fields in the next commit,
>> you'll have the path with them (when present).
> 
> There is always a path with them, it's just that the empty string
> denotes the toplevel directory.
> 
>> (and it would let you optionally avoid the tmp strbuf in
>> the caller.)
> 
> The path in read_directory() is not necessarily NUL-delimited, so
> attempting to use it as-is, or even with your checks, would cause us
> to possibly print garbage and do out-of-bounds reads.  We need the tmp
> strbuf.
> 

I just meant, "if (!len) pass NULL, else build and pass tmp.buf".

but i'm nit-picking again.

Jeff

