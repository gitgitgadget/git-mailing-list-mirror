Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5B80D1F62E
	for <e@80x24.org>; Tue, 15 Jan 2019 15:11:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730637AbfAOPLo (ORCPT <rfc822;e@80x24.org>);
        Tue, 15 Jan 2019 10:11:44 -0500
Received: from smtp122.ord1c.emailsrvr.com ([108.166.43.122]:43566 "EHLO
        smtp122.ord1c.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727307AbfAOPLo (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 15 Jan 2019 10:11:44 -0500
X-Greylist: delayed 583 seconds by postgrey-1.27 at vger.kernel.org; Tue, 15 Jan 2019 10:11:43 EST
Received: from smtp24.relay.ord1c.emailsrvr.com (localhost [127.0.0.1])
        by smtp24.relay.ord1c.emailsrvr.com (SMTP Server) with ESMTP id F2ABA6053B;
        Tue, 15 Jan 2019 10:02:02 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xiplink.com;
        s=20181102-2c3qeqyt; t=1547564522;
        bh=g4M4PkghrUjHGcDsazk00uorj/5a2srcAY2cORCv2IA=;
        h=Subject:To:From:Date:From;
        b=GW310ZtutuNOviouIIydwbQvWuDyCfhKF+gYCFTfSw+xeTasuyL5j7Zb2oSFqssg9
         G7akwR6spNiiQiOlATxD7hHGKfvQk0AGJQSGOYs47j9EorcGX/LHsqReMi87TsDh1F
         kwa/tjkzgDOA+8NxOU5o1+2Rzd7R+WRfZMgFrASM=
X-Auth-ID: mbranchaud@xiplink.com
Received: by smtp24.relay.ord1c.emailsrvr.com (Authenticated sender: mbranchaud-AT-xiplink.com) with ESMTPSA id A006060279;
        Tue, 15 Jan 2019 10:02:02 -0500 (EST)
X-Sender-Id: mbranchaud@xiplink.com
Received: from [10.10.1.32] ([UNAVAILABLE]. [192.252.130.194])
        (using TLSv1.2 with cipher AES128-SHA)
        by 0.0.0.0:465 (trex/5.7.12);
        Tue, 15 Jan 2019 10:02:02 -0500
Subject: Re: [PATCH] new-workdir: Never try to recurse into submodules on the
 initial checkout.
To:     Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Duy Nguyen <pclouds@gmail.com>,
        Stefan Beller <sbeller@google.com>
References: <20190114172702.19959-1-marcnarc@xiplink.com>
 <20190114213430.GC162110@google.com>
 <xmqqwon6ud7e.fsf@gitster-ct.c.googlers.com>
 <20190114215804.GE162110@google.com>
From:   Marc Branchaud <marcnarc@xiplink.com>
Message-ID: <0f4aadfc-6fc5-155a-3232-277298df1b54@xiplink.com>
Date:   Tue, 15 Jan 2019 10:02:02 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <20190114215804.GE162110@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2019-01-14 4:58 p.m., Jonathan Nieder wrote:
> Hi,
> 
> Junio C Hamano wrote:
>> Jonathan Nieder <jrnieder@gmail.com> writes:
>>> Marc Branchaud wrote:
> 
>>>> The new workdir is empty before the checkout, so attempts to recurse into
>>>> a non-existent submodule directory fail.
>>>>
>>>> Signed-off-by: Marc Branchaud <marcnarc@xiplink.com>
>>>> ---
>>>
>>> Thanks for reporting.  Can you describe the error message when it fails
>>> here?
> [...]
>> IOW, at the point in that script where we call "git checkout -f", if
>> we changed it to "git checkout --recurse-submodules -f", what breaks
>> and why?  Shouldn't it succeed instead?
> 
> I think that's a similar question to the one I asked.
> 
> But I have a good guess about what goes wrong.  It's related to the same
> issue as the "git worktree" problem Marc described.
> 
> Inside the superproject's $GIT_DIR, we see
> 
> 	config
> 	modules/
> 		a/
> 			config
> 		b/
> 			config
> 	...
> 
> The question is what to do with the modules/ directory when you have
> multiple working directories making use of the refs and objects from
> this $GIT_DIR.
> 
> In general, the most useful answer is that the additional working
> directories should make use for modules/ from this $GIT_DIR as well.
> After all, each submodule has its own refs and objects, and the same
> motivation that pushes us to share the refs and objects from the
> superproject would drive us to share them in the submodules as well.
> 
> However, if you do this in the most naive way, it will not work.  In
> the config file, there is a core.worktree setting that ensures that
> commands run from a submodule affect the correct working directory.
> Which worktree should it point to?  All of them.
> 
> There's still an obvious "most useful" answer: each submodule should
> contain its own worktrees/ directory with metadata specific to each
> worktree.  This should work fine and is the future work that Marc and
> I alluded to.  Let me call it (*), for later reference.
> 
> Anything done today is papering over the sad truth that that future
> work (*) has not been done yet.
> 
> contrib/workdir is currently naive about all this: it does *not*
> symlink across the modules/ directory, so each workdir gets its own
> independent copy of all the submodules.  Which kind of defeats the
> point of this kind of setup.
> 
> That said, it's better than nothing at all, which is why Marc proposes
> making it not attempt to check out the submodules right away, instead
> permitting the user to make the best of things.  I suppose another
> thing that is missing is a warning message to ensure the user knows
> that once (*) arrives, they need to be ready for it.  (Or not: this is
> contrib/workdir, and there would be no need to make use of it in place
> of "git worktree" once that moment arrives.)
> 
> To reiterate, this is all about papering over (*) not having been
> done.
> 
> Marc, did I understand correctly?

Yup!

I just hope to keep git-new-workdir hobbling along until worktree can 
fully replace it.

I agree with Junio about what should happen when submodule.recurse=true. 
  But that work should be done in worktree instead of git-new-workdir.

		M.

> Thanks,
> Jonathan
> 
