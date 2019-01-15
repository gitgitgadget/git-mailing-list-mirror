Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5CE571F62E
	for <e@80x24.org>; Tue, 15 Jan 2019 15:11:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730635AbfAOPLo (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Jan 2019 10:11:44 -0500
Received: from smtp98.ord1c.emailsrvr.com ([108.166.43.98]:38189 "EHLO
        smtp98.ord1c.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730631AbfAOPLo (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 15 Jan 2019 10:11:44 -0500
Received: from smtp21.relay.ord1c.emailsrvr.com (localhost [127.0.0.1])
        by smtp21.relay.ord1c.emailsrvr.com (SMTP Server) with ESMTP id CE0FEC040C;
        Tue, 15 Jan 2019 10:01:59 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xiplink.com;
        s=20181102-2c3qeqyt; t=1547564519;
        bh=7iXUAk9a4rpSTnhaIdd7Atmu717cbtIRUl4Nyh+vkWE=;
        h=Subject:To:From:Date:From;
        b=GyDzetsdtlZazfOz9ZWMEnq7moPey6jz4TXGqHE2S0vmEv1GfdOwBvfinOE1ocPBU
         bxpkljM/vNE4L+kK3biSpvkg9Aumn0sAuWi5qVQ3oLpgl+v2TGdRpqYrZfiiR2u6GK
         +KzEMiF1yeKXPvB6uVHnz40ROKbWy3cwDO3S1cN8=
X-Auth-ID: mbranchaud@xiplink.com
Received: by smtp21.relay.ord1c.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id 697FDC04AB;
        Tue, 15 Jan 2019 10:01:59 -0500 (EST)
X-Sender-Id: mbranchaud@xiplink.com
Received: from [10.10.1.32] ([UNAVAILABLE]. [192.252.130.194])
        (using TLSv1.2 with cipher AES128-SHA)
        by 0.0.0.0:465 (trex/5.7.12);
        Tue, 15 Jan 2019 10:01:59 -0500
Subject: Re: [PATCH] new-workdir: Never try to recurse into submodules on the
 initial checkout.
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org, Duy Nguyen <pclouds@gmail.com>,
        Stefan Beller <sbeller@google.com>
References: <20190114172702.19959-1-marcnarc@xiplink.com>
 <20190114213430.GC162110@google.com>
From:   Marc Branchaud <marcnarc@xiplink.com>
Message-ID: <d1e1ceb3-a1b8-ff5b-8ebc-79d2ee9267dc@xiplink.com>
Date:   Tue, 15 Jan 2019 10:01:59 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190114213430.GC162110@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2019-01-14 4:34 p.m., Jonathan Nieder wrote:
> Hi,
> 
> Marc Branchaud wrote:
> 
>> The new workdir is empty before the checkout, so attempts to recurse into
>> a non-existent submodule directory fail.
>>
>> Signed-off-by: Marc Branchaud <marcnarc@xiplink.com>
>> ---
> 
> Thanks for reporting.  Can you describe the error message when it fails
> here?

The error is:

fatal: exec '--super-prefix=external/submodule/': cd to 
'external/submodule' failed: No such file or directory

The created workdir has only the .git directory.  The .git/HEAD file 
contains the expected ref, so the workdir repo's status simply shows 
that everything has been deleted.


Note that git-worktree also fails when submodule.recurse=true, with the 
same error:

# git worktree add ~/Code/foo/test-worktree
Preparing worktree (new branch 'test-worktree')
fatal: exec '--super-prefix=external/submodule/': cd to 
'external/submodule' failed: No such file or directory
error: Submodule 'external/submodule' could not be updated.
error: Submodule 'external/submodule' cannot checkout new HEAD.
fatal: Could not reset index file to revision 'HEAD'.

I had assumed that this was simply an aspect of submodules not working, 
so I was holding off reporting it until more of the submodule support 
was complete.

>> Until the worktree command supports submodules I've gone back to using the
>> git-new-workdir script, but it fails if my config has
>> submdodule.recurse=true.
> 
> Oh, dear.  In general, the project does a better job at supporting "git
> worktree" than "git new-workdir", but I don't blame you about this.
> 
> Noting locally as another vote for getting submodules to play well with
> worktrees soon.
> 
> [...]
>>   contrib/workdir/git-new-workdir | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/contrib/workdir/git-new-workdir b/contrib/workdir/git-new-workdir
>> index 888c34a521..5de1dc3c58 100755
>> --- a/contrib/workdir/git-new-workdir
>> +++ b/contrib/workdir/git-new-workdir
>> @@ -102,4 +102,4 @@ trap - $siglist
>>
>>   # checkout the branch (either the same as HEAD from the original repository,
>>   # or the one that was asked for)
>> -git checkout -f $branch
>> +git -c submodule.recurse=false checkout -f $branch
> 
> nit: can this use "git checkout --no-recurse-submodules" instead
> of -c?
> 
> In general, we tend to recommend that kind of option instead of
> --config in scripts.

--no-recurse-submodules does work.  I'll send a v2.

		M.

> Thanks,
> Jonathan
> 
