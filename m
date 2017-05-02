Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DCF031F790
	for <e@80x24.org>; Tue,  2 May 2017 14:05:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751306AbdEBOFD (ORCPT <rfc822;e@80x24.org>);
        Tue, 2 May 2017 10:05:03 -0400
Received: from siwi.pair.com ([209.68.5.199]:24992 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751120AbdEBOFD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2017 10:05:03 -0400
Received: from [10.160.98.126] (unknown [167.220.148.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 91FD1844CA;
        Tue,  2 May 2017 10:05:01 -0400 (EDT)
Subject: Re: [PATCH 0/5] Start of a journey: drop
 NO_THE_INDEX_COMPATIBILITY_MACROS
To:     Stefan Beller <sbeller@google.com>,
        Junio C Hamano <gitster@pobox.com>
References: <20170501190719.10669-1-sbeller@google.com>
 <xmqq7f20f3a8.fsf@gitster.mtv.corp.google.com>
 <CAGZ79kZkssTEdNyzYh1YYv89szvig=rn2j3DJcHxsbzdADRw-w@mail.gmail.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <b2d1d2fe-1b9b-4afa-192f-267bbb5df487@jeffhostetler.com>
Date:   Tue, 2 May 2017 10:05:00 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
In-Reply-To: <CAGZ79kZkssTEdNyzYh1YYv89szvig=rn2j3DJcHxsbzdADRw-w@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 5/2/2017 12:17 AM, Stefan Beller wrote:
> On Mon, May 1, 2017 at 6:36 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Stefan Beller <sbeller@google.com> writes:
>>
>>> This applies to origin/master.
>>>
>>> For better readability and understandability for newcomers it is a good idea
>>> to not offer 2 APIs doing the same thing with on being the #define of the other.
>>>
>>> In the long run we may want to drop the macros guarded by
>>> NO_THE_INDEX_COMPATIBILITY_MACROS. This converts a couple of them.

Thank you for bringing this up and making this proposal.
I started a similar effort internally last fall, but
stopped because of the footprint size.

>>
>> Why?  Why should we keep typing &the_index, when most of the time we
>> are given _the_ index and working on it?
>
> As someone knowledgeable with the code base you know that the cache_*
> and index_* functions only differ by an index argument. A newcomer may not
> know this, so they wonder why we have (A) so many functions [and which is the
> right function to use]; it is an issue of ease of use of the code base.
>
> Anything you do In submodule land today needs to spawn new processes in
> the submodule. This is cumbersome and not performant. So in the far future
> we may want to have an abstraction of a repo (B), i.e. all repository state in
> one struct/class. That way we can open a submodule in-process and perform
> the required actions without spawning a process.
>
> The road to (B) is a long road, but we have to art somewhere. And this seemed
> like a good place by introducing a dedicated argument for the
> repository. In a follow
> up in the future we may want to replace &the_index by "the_main_repo.its_index"
> and then could also run the commands on other (submodule) indexes. But more
> importantly, all these commands would operate on a repository object.
>
> In such a far future we would have functions like the cmd_* functions
> that would take a repository object instead of doing its setup discovery
> on their own.
>
> Another reason may be its current velocity (or absence of it) w.r.t. to these
> functions, such that fewer merge conflicts may arise.

In addition to (eventually) allowing multiple repos be open at
the same time for submodules, it would also help with various
multi-threading efforts.  For example, we have loops that do a
"for (k = 0, k < active_nr; k++) {...}"  There is no visual clue
in that code that it references "the_index" and therefore should
be subject to the same locking.  Granted, this is a trivial example,
but goes to the argument that the code has lots of subtle global
variables and macros that make it difficult to reason about the
code.

This step would help un-hide this.

In a much longer future, we could also consider building an
improved API around the in-memory index data.  For example,
currently we have a simple array of cache_entry pointers and
the entire code base uses "for" loops like the above to iterate.
If we could hide that fact, then we could consider alternative
representations for various reasons.
() bulk alloc the cache_entries from a pool, rather than individually.
() cluster cache_entries linearly by parent directory, rather
    than linearly over the whole tree.
() efficient alternative iterator methods on the index, such as
    non-recursive breadth-first

Things like this would be difficult with the current set of
globals and macros.

Thanks,
Jeff


>
> ---
> This discussion is similar to the "free memory at the end of cmd_*" discussion,
> as it aims to make code reusable, and accepting a minor drawback for it.
> Typing "the_index" re-enforces the object thinking model and may have people
> start on thinking if they would like to declare yet another global variable.
>
> Thanks,
> Stefan
>
