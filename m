Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 750CAC43334
	for <git@archiver.kernel.org>; Fri,  3 Jun 2022 19:59:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244956AbiFCT7E (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Jun 2022 15:59:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235275AbiFCT7D (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Jun 2022 15:59:03 -0400
Received: from siwi.pair.com (siwi.pair.com [209.68.5.199])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAAE32B246
        for <git@vger.kernel.org>; Fri,  3 Jun 2022 12:59:02 -0700 (PDT)
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id B3D0B3F40F3;
        Fri,  3 Jun 2022 15:59:01 -0400 (EDT)
Received: from jeffhost-mbp.local (162-238-212-202.lightspeed.rlghnc.sbcglobal.net [162.238.212.202])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 566B83F4090;
        Fri,  3 Jun 2022 15:59:01 -0400 (EDT)
Subject: Re: [PATCH 0/4] rebase: update branches in multi-part topic
To:     Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, johannes.schindelin@gmx.de,
        Derrick Stolee <derrickstolee@github.com>
References: <pull.1247.git.1654263472.gitgitgadget@gmail.com>
 <YppSl4rOvVciLuXE@nand.local>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <9d2752dd-6029-e71a-4149-0641fea879fe@jeffhostetler.com>
Date:   Fri, 3 Jun 2022 15:59:00 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:68.0)
 Gecko/20100101 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <YppSl4rOvVciLuXE@nand.local>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 6/3/22 2:27 PM, Taylor Blau wrote:
> On Fri, Jun 03, 2022 at 01:37:48PM +0000, Derrick Stolee via GitGitGadget wrote:
>> This is a feature I've wanted for quite a while. When working on the sparse
>> index topic, I created a long RFC that actually broke into three topics for
>> full review upstream. These topics were sequential, so any feedback on an
>> earlier one required updates to the later ones. I would work on the full
>> feature and use interactive rebase to update the full list of commits.
>> However, I would need to update the branches pointing to those sub-topics.
> 
> This is really exciting. I'm glad that you're working on it, because I
> have also wanted this feature a handful of times over the years.
> 
> This definitely would have come in handy when writing MIDX bitmaps,
> where I was often editing a local branch pointing at the final topic,
> and then trying to reconstruct all of the intermediate branches after
> each rebase. Not ever having to do that again sounds like a delight ;-).
> 
>> pick 2d966282ff3 docs: document bundle URI standard
>> pick 31396e9171a remote-curl: add 'get' capability
>> pick 54c6ab70f67 bundle-uri: create basic file-copy logic
>> pick 96cb2e35af1 bundle-uri: add support for http(s):// and file://
>> pick 6adaf842684 fetch: add --bundle-uri option
>> pick 6c5840ed77e fetch: add 'refs/bundle/' to log.excludeDecoration
>> exec git update-ref refs/heads/bundle-redo/fetch HEAD 6c5840ed77e1bc41c1fe6fb7c894ceede1b8d730
> 
> But I wonder if we can or should delay these update-refs as long as
> possible. In particular: what happens if I get past this "exec" line (so
> that I've already updated my bundle-redo/fetch branch to point at the
> new thing), but decide at some later point to abort the rebase?
> 
> I think users will expect us to restore bundle-redo/fetch to where it
> was before if we end up in that case. Recovering from it manually sounds
> like kind of a headache.
> 
> What if instead we created labels here, and then delayed all ref updates
> to the end by replacing this with:
> 
>      label bundle-redo/fetch
> 
> and then at the end of the todo list we'd add:
> 
>      exec git update-ref refs/heads/bundle-redo/fetch refs/rewritten/bundle-redo/fetch
> 
> If we do all of those ref updates in a single transaction at the end, it
> should be much easier to roll back from if desired, and we'd avoid the
> aborted-rebase problem entirely.
> 
> Thanks,
> Taylor
> 

I agree. I could have really used this while juggling all of the
parts of FSMonitor recently.  And yes, it should write the updates
at the bottom in case of an abort.

Should this take a branch pattern/regex to limit the set of branches
that are updated (or offered to be updated)?  For example, if I have
an intermediate commit in the series that has 2 branch names pointing
at it, do we want to offer to update both of them or only the one
that matches some pattern related to the tip?  Or is it sufficient to
just enumerate them at the bottom of the todo list and let the user
delete the lines they don't want?

Should we actually do the update-ref's or should we write a script
that lets the user do it later?  The latter would let us also write
out the commands to force update the remote refs if that would be
helpful.

Thanks,
Jeff
