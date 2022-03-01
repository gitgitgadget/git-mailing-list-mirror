Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 791C5C433F5
	for <git@archiver.kernel.org>; Tue,  1 Mar 2022 18:03:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236352AbiCASEZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Mar 2022 13:04:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230148AbiCASEY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Mar 2022 13:04:24 -0500
Received: from siwi.pair.com (siwi.pair.com [209.68.5.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05AFD205C4
        for <git@vger.kernel.org>; Tue,  1 Mar 2022 10:03:42 -0800 (PST)
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id 5430C3F4148;
        Tue,  1 Mar 2022 13:03:42 -0500 (EST)
Received: from jeffhost-mbp.local (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id D80BE3F412C;
        Tue,  1 Mar 2022 13:03:41 -0500 (EST)
Subject: Re: [PATCH 00/11] Partial bundles
To:     Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     stolee@gmail.com, avarab@gmail.com, gitster@pobox.com,
        zhiyou.jx@alibaba-inc.com, jonathantanmy@google.com
References: <pull.1159.git.1645638911.gitgitgadget@gmail.com>
 <6af04989-835b-7fae-6862-002ecd411037@jeffhostetler.com>
 <be99d6c1-7137-9661-6f2b-bc80732003b4@github.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <0b0e3c76-d0a0-71ce-913e-dcffc8bf2746@jeffhostetler.com>
Date:   Tue, 1 Mar 2022 13:03:41 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <be99d6c1-7137-9661-6f2b-bc80732003b4@github.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 2/28/22 12:54 PM, Derrick Stolee wrote:
> On 2/28/2022 12:00 PM, Jeff Hostetler wrote:
>> On 2/23/22 12:55 PM, Derrick Stolee via GitGitGadget wrote:
>>> While discussing bundle-URIs [1], it came to my attention that bundles have
>>> no way to specify an object filter, so bundles cannot be used with partial
>>> clones.
>>>
>>> [1]
>>> https://lore.kernel.org/git/7fab28bf-54e7-d0e9-110a-53fad6244cc9@gmail.com/
>>>
>>> This series provides a way to fix that by adding a 'filter' capability to
>>> the bundle file format and allowing one to create a partial bundle with 'git
>>> bundle create --filter=blob:none '.
>>
>> Nicely done.  There's a lot of refactoring here to move the
>> filtering code into a more usable place and get rid of some
>> of the awkward limitations of my original code.  Sorry that
>> you had to slog thru all of that.
>>
>>>
>>> There are a couple things that I want to point out about this implementation
>>> that could use some high-level feedback:
>>>
>>>    1. I moved the '--filter' parsing into setup_revisions() instead of adding
>>>       another place to parse it. This works for 'git bundle' but it also
>>>       allows it to be parsed successfully in commands such as 'git diff' which
>>>       doesn't make sense. Options such as '--objects' are already being parsed
>>>       there, and they don't make sense either, so I want some thoughts on
>>>       this.
>>
>> This feels like something that can wait for another task.
>> Let's keep this series focused on adding partial bundles.
> 
> What do you mean "can wait"? Do you recommend that I _don't_ do this
> refactor and instead implement filter parsing directly in bundles?
> 
> Or, are you saying that we should not worry about these potential
> side-effects of allowing (then ignoring) certain options in other
> commands, at least until a later series?

Sorry to be confusing here.  I just meant that the refactoring looks
good and we should continue with it.  And for now let's not worry
about those odd non-sense combinations that may now be possible.

That at some point later we can address the non-sense combinations
with some control flags on the call to the common parser or something.
I started thinking about that while looking at the code and just thought
that it would be a bit of a mess.  And that we didn't need to do any
thing about it now.  Such tweaking would be better done in a later
series.

>   
>>>    2. If someone uses 'git clone partial.bdl partial' where 'partial.bdl' is a
>>>       filtered bundle, then the clone will fail with a message such as
>>>
>>> fatal: missing blob object '9444604d515c0b162e37e59accd54a0bac50ed2e' fatal:
>>> remote did not send all necessary objects
>>>
>>> This might be fine. We don't expect users to clone partial bundles or fetch
>>> partial bundles into an unfiltered repo and these failures are expected. It
>>> is possible that we could put in custom logic to fail faster by reading the
>>> bundle header for a filter.
>>>
>>> Generally, the idea is to open this up as a potential way to bootstrap a
>>> clone of a partial clone using a set of precomputed partial bundles.
>>
>> I think this is to be expected.
>>
>> Would it help to have Git do a no-checkout clone when cloning
>> from a partial bundle?  Maybe that would give the user a chance to set
>> a real remote (and maybe set the partial clone/fetch config settings)
>> and then backfill their local clone??   (That might be functional, but
>> not very user-friendly....)
>>
>> Or should we just consider this limitation as a placeholder while we
>> wait for the Bundle URI effort?
> 
> It would be interesting to have another application of partial
> bundles, such as cloning directly from a bundle, then allowing
> a remote to be configured. It provides a "build-it-yourself"
> approach to bundle URIs for partial clones.
> 
> I'm not sure if such an application is required for this series,
> or if it could be delayed until after. I'm open to suggestions.

I think what you have here is nice and self-contained.  That is,
supporting partial bundles is a nice stop point.  Then have 1 or 2
series that consumes them.

Jeff
