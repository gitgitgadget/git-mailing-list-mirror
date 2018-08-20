Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 03CA21F954
	for <e@80x24.org>; Mon, 20 Aug 2018 19:22:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726141AbeHTWjl (ORCPT <rfc822;e@80x24.org>);
        Mon, 20 Aug 2018 18:39:41 -0400
Received: from bsmtp7.bon.at ([213.33.87.19]:43124 "EHLO bsmtp7.bon.at"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726099AbeHTWjl (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Aug 2018 18:39:41 -0400
Received: from dx.site (unknown [93.83.142.38])
        by bsmtp7.bon.at (Postfix) with ESMTPSA id 41vNxM69VWz5tlP;
        Mon, 20 Aug 2018 21:22:47 +0200 (CEST)
Received: from [IPv6:::1] (localhost [IPv6:::1])
        by dx.site (Postfix) with ESMTP id 1515FD7;
        Mon, 20 Aug 2018 21:22:47 +0200 (CEST)
Subject: Re: Do not raise conflict when a code in a patch was already added
To:     phillip.wood@dunelm.org.uk,
        Konstantin Kharlamov <hi-angel@yandex.ru>
References: <fae8346d-398f-e984-5aa5-e3dc3ee71d70@yandex.ru>
 <ab5021a9-6980-b96c-9d51-cc301844f2af@talktalk.net>
From:   Johannes Sixt <j6t@kdbg.org>
Cc:     git@vger.kernel.org
Message-ID: <0d36d185-23d5-a656-67dd-5df86abed3e9@kdbg.org>
Date:   Mon, 20 Aug 2018 21:22:46 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <ab5021a9-6980-b96c-9d51-cc301844f2af@talktalk.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 20.08.2018 um 19:40 schrieb Phillip Wood:
> On 20/08/2018 11:22, Konstantin Kharlamov wrote:
>> It's spectacular, that content of one of inserted conflict markers is
>> empty, so all you have to do is to remove the markers, and use `git add`
>> on the file, and then `git rebase --continue`
>>
>> Its a lot of unncessary actions, git could just figure that the code it
>> sees in the patch is already there, being a part of another commit.
> 
> If there are conflict markers where one side is empty it means that some
> lines from the merge base (which for a rebase is the parent of the
> commit being picked) have been deleted on one side and modified on the
> other. Git cannot know if you want to use the deleted version or the
> modified version.

There's another possibility (and I think it is what happens actually in 
Konstantin's case): When one side added lines 1 2 and the other side 
added 1 2 3, then the actual conflict is << 1 2 == 1 2 3 >>, but our 
merge code is able to move the identical part out of the conflicted 
section: 1 2 << == 3 >>. But this is just a courtesy for the user; the 
real conflict is the original one. Without this optimization, the work 
to resolve the conflict would be slightly more arduous.

-- Hannes
