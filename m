Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 791FFC433EF
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 13:36:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D20D610E8
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 13:36:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233092AbhIUNhe (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Sep 2021 09:37:34 -0400
Received: from smtp.hosts.co.uk ([85.233.160.19]:40689 "EHLO smtp.hosts.co.uk"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233038AbhIUNhe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Sep 2021 09:37:34 -0400
Received: from host-84-13-154-214.opaltelecom.net ([84.13.154.214] helo=[192.168.1.37])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1mSfwK-0003R8-4Z; Tue, 21 Sep 2021 14:36:04 +0100
Subject: Re: Trimming 'deadheads' (TREESAME 2nd parent) from revision walks?
To:     Jeff King <peff@peff.net>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Git List <git@vger.kernel.org>
References: <01fe28d8-2887-bc42-c91b-c3237b5186a7@iee.email>
 <YUeImAqA0SZAdA2R@coredump.intra.peff.net>
 <87k0jcb01k.fsf@evledraar.gmail.com>
 <88dfc31a-187c-6609-0df6-d6b970b1a136@iee.email>
 <YUj0J+jY0jURkipM@coredump.intra.peff.net>
From:   Philip Oakley <philipoakley@iee.email>
Message-ID: <9b85811f-de5d-24b3-36f6-7e2f9be6cae0@iee.email>
Date:   Tue, 21 Sep 2021 14:36:04 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <YUj0J+jY0jURkipM@coredump.intra.peff.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Peff,
On 20/09/2021 21:50, Jeff King wrote:
> On Mon, Sep 20, 2021 at 12:40:21PM +0100, Philip Oakley wrote:
>
>> One thing that catches me, and I think others, is how the 'strategies'
>> work. IIUC a merge will look at each line in the diff, and accept any
>> change on either side that has no conflicts within the context zone.
>> It's only when there are changes from both sides that the selection
>> strategy kicks in. But it is difficult to describe, so it's easy to be
>> confused.
> I think you might be confusing the "ours" strategy (which takes the
> tree state of the first parent entirely) with the "ours" (and "theirs")
> options of the merge-recursive (or ort) strategy.
>
> You can see the difference with:
>
>   git init repo
>   cd repo
>   
>   echo base >file
>   git add file
>   git commit -m base
>   
>   echo main >file
>   git add file
>   git commit -m main
>   
>   git checkout -b side HEAD^
>   echo side >file
>   echo unrelated >another
>   git add file another
>   git commit -m side
>   
>   git checkout -b strategy-ours main
>   git merge -s ours side
>   
>   git checkout -b option-ours main
>   git merge -X ours side
>
> The strategy-ours merge will drop "another", because it was not in the
> first parent. Whereas option-ours will keep it, preferring the
> first parent only for the conflict in "file".
>
> You could construct a similar example where instead of a second file,
> there's enough content in "file" that some of it does not conflict.
>
> -Peff
Thanks for the clarification.
I was probably over thinking the problem, by starting at the default and
adding conditions that are extras to that, rather than  reducing the
conditions!

The `theirs` strategy is really only suitable for maintainers, rather
than solo coders, as it need to be 'old releases` that are kept, rather
'old cruft` (I've generated too much of that in my time).

Dscho's scripts (for anyone interested) for GfW are in
https://github.com/git-for-windows/build-extra/blob/main/shears.sh#L16-L18
and 
https://github.com/git-for-windows/build-extra/blob/main/ever-green.sh,
though from the script perspective it's an 'ours' strategy.

Dscho has to locate the start commit via it's subject line, rather than
it's topology.

--
Philip
