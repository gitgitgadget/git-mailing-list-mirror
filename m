Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BE32C433EF
	for <git@archiver.kernel.org>; Thu, 24 Mar 2022 12:59:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242963AbiCXNA6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Mar 2022 09:00:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242173AbiCXNA6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Mar 2022 09:00:58 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 389FCDF8A
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 05:59:26 -0700 (PDT)
Received: from fraeml742-chm.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4KPQHR5TVFz687PR
        for <git@vger.kernel.org>; Thu, 24 Mar 2022 20:57:39 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml742-chm.china.huawei.com (10.206.15.223) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 24 Mar 2022 13:59:23 +0100
Received: from [10.202.227.197] (10.202.227.197) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 24 Mar 2022 12:59:23 +0000
Message-ID: <5ceff005-bbe4-37f5-c453-17008c2167bc@huawei.com>
Date:   Thu, 24 Mar 2022 12:59:45 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [Question] .git folder file updates for changing head commit
To:     Glen Choo <chooglen@google.com>, <git@vger.kernel.org>
References: <6fa76f28-063b-8964-c0a2-642dae88f1b3@huawei.com>
 <kl6la6dgtmv8.fsf@chooglen-macbookpro.roam.corp.google.com>
From:   John Garry <john.garry@huawei.com>
In-Reply-To: <kl6la6dgtmv8.fsf@chooglen-macbookpro.roam.corp.google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.197]
X-ClientProxiedBy: lhreml744-chm.china.huawei.com (10.201.108.194) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 23/03/2022 20:50, Glen Choo wrote:
> Hi John, I'm not a big expert on Make (or even Git :p) but think I can
> answer some of your questions.
> 
> John Garry <john.garry@huawei.com> writes:
> 
>> Hi guys,
>>
>> I have a question about which files in the .git folder are updated as we
>> change the head commit. I could check the codebase myself but prob will
>> make a mistake and maybe some expert would be so kind as to just kindly
>> tell me.
>>
>> For building the linux perf tool we use the git head commit id as part
>> of the tool version sting. To save time in re-building, the Makefile
>> rule has a dependency on .git/HEAD for rebuilding. An alternative
>> approach would be to compare git log output to check current versus
>> previous build head commit, but that is seen as inefficient time-wise.
> 
> You're on the right track because if .git/HEAD doesn't change, the HEAD
> is still pointing to either the same commit (if in detached HEAD) or
> branch (if not in detached HEAD).
> 
> The problem is that when HEAD points to a branch, the branch's 'head
> commit' can change, implicitly changing the commit that .git/HEAD
> actually points to.
> 

ok

>> The problem is that actions like git cherry-pick and git reset --hard
>> HEAD^ may not update .git/HEAD (so don't trigger a rebuild).
> 
> That's what's happening here. If your HEAD is pointing to
> "refs/heads/main", "cherry-pick" and "reset --hard" will change where
> "refs/heads/main" points, but HEAD still points to "refs/heads/main".
> 
> Branches are often located in "loose form" under .git/refs/heads/*,
> *but* refs can also be stored in a "packed form" under .git/packed-refs
> (https://git-scm.com/docs/git-pack-refs). There is also a relatively
> new ref storage format called reftable that I'm not familiar with, but
> presumably stores its refs in other locations too.
> 
> All of this is to say that depending on specific files under .git/
> exposes you to a lot of Git internals that really aren't meant for
> external consumption. I suggest finding a different approach than
> watching Git-internal files for changes.

Thanks for the detailed explanation.

I agree with your suggestion to find a new method (which may be 
reverting to the old method to just run proper git commands).

> 
>> Is there some more suitable file(s) which we could use as a dependency?
>>   From my limited experimentation, .git/index seems to always update when
>> the changing head commit.
> 
> I think users typically expect the index (and therefore .git/index) to
> change when the head commit changes, but this isn't always true e.g.
> "reset --soft" will move the branch without changing the index.

ok, good to know. I was going to try that...

> 
> P.S. Even if you knew the value of .git/index or .git/HEAD, that
> wouldn't tell you whether or not the files in your working directory
> have changed, so I'm not sure if you want to use either as Makefile
> dependency.
> 

ok, thanks again for all this info,
John

