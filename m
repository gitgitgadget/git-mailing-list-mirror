Return-Path: <SRS0=ratM=2B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F334C43603
	for <git@archiver.kernel.org>; Wed, 11 Dec 2019 15:07:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 794F0222C4
	for <git@archiver.kernel.org>; Wed, 11 Dec 2019 15:07:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729496AbfLKPHE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Dec 2019 10:07:04 -0500
Received: from smtprelay04.ispgateway.de ([80.67.31.38]:56761 "EHLO
        smtprelay04.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729144AbfLKPHE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Dec 2019 10:07:04 -0500
Received: from [24.134.116.61] (helo=[192.168.92.208])
        by smtprelay04.ispgateway.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92.3)
        (envelope-from <alexandr.miloslavskiy@syntevo.com>)
        id 1if3Zp-0001cY-No; Wed, 11 Dec 2019 16:06:57 +0100
Subject: Re: [PATCH 5/5] commit: support the --pathspec-from-file option
To:     phillip.wood@dunelm.org.uk,
        Alexandr Miloslavskiy via GitGitGadget 
        <gitgitgadget@gmail.com>, git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
References: <pull.445.git.1572895605.gitgitgadget@gmail.com>
 <f4847046896848d3f16bc5f3cb7a26271cefd97c.1572895605.git.gitgitgadget@gmail.com>
 <9ca7fa57-c438-7243-6ab1-956d8f132d37@gmail.com>
 <25aaaca1-1c88-d2c6-b502-cd35752ce745@syntevo.com>
 <4401823b-8039-99b4-2436-ed2f1a571d78@gmail.com>
 <2b573436-0ed2-9d24-f375-dfea0825a39e@syntevo.com>
 <b9454df6-7d31-e255-84bd-8a1c548cffd7@gmail.com>
From:   Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Message-ID: <9d77a425-da8d-d6e7-f51f-c4ce6ee988d5@syntevo.com>
Date:   Wed, 11 Dec 2019 16:06:57 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <b9454df6-7d31-e255-84bd-8a1c548cffd7@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Df-Sender: YWxleGFuZHIubWlsb3NsYXZza2l5QHN5bnRldm8uY29t
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11.12.2019 15:27, Phillip Wood wrote:

> Thanks, one other thing I forgot to mention yesterday is to ask what the 
> expected behavior is if the user passes an empty file to 
> --pathspec-from-file. With no pathspecs on the command line commit, 
> checkout, reset and restore-files all default to operating on all paths 
> but passing --pathspec-from-file implies the user wants to specify 
> specific paths so I think it would perhaps be better to error out if no 
> paths are given. There is a precedent for this in checkout-index which 
> does nothing if no paths are given (though I can't remember if it errors 
> out or not).

Back when I composed patch for `git commit`, I spent some time thinking 
about this question. I agree that empty `--pathspec-from-file` is weird. 
Eventually I decided that `--pathspec-from-file` shall be as close as 
possible to passing pathspec args. So empty file should behave the same 
way as passing zero pathspec args. It's more or less the question "if 
user does something unexpected, what is expected?". I decided that 
treating as zero args doesn't sound dangerous to me, and it's a very 
weird case anyway, so let's just treat as zero args.

>> What I find obscure in your suggestion/patch is that innocently 
>> looking `prepare_index()` suddenly clears pathspec as well. It's even 
>> harder to see when called through `dry_run_commit()`.
> 
> It would be easy enough to clear pathspec in cmd_commit() I just didn't 
> bother to do it.

Yes, this thought also came to me after I replied. I agree that this is 
viable and seems to solve most problems.

Now I'm in the situation where before me, code already wasn't perfect, 
and I can continue to extend it in the same direction, or try to 
refactor to make it better. I actually choose the second path: [1][2]. 
These were two "don't" lessons for me, as both topics now gather dust in 
mail graveyard. No good deed remains unpunished, I guess?

> I think that's a bit different to 
> the pathspec case as it's about the lifetime of the return value of a 
> function rather than a function freeing an argument passed to it.

Both cases are about lifetime that ends where it was not expected. You 
can probably agree that it never makes code easier to understand, and at 
best it will be properly accounted for and does not explode. Again, both 
choices were somewhat evil.

[1] 
https://public-inbox.org/git/pull.479.git.1574969538.gitgitgadget@gmail.com/
[2] 
https://public-inbox.org/git/pull.477.git.1574848137.gitgitgadget@gmail.com/T/#u
