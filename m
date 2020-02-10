Return-Path: <SRS0=dWK1=36=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A787C352A3
	for <git@archiver.kernel.org>; Mon, 10 Feb 2020 15:06:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3C75D20714
	for <git@archiver.kernel.org>; Mon, 10 Feb 2020 15:06:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729412AbgBJPGs (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Feb 2020 10:06:48 -0500
Received: from smtprelay01.ispgateway.de ([80.67.31.39]:25639 "EHLO
        smtprelay01.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726809AbgBJPGr (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Feb 2020 10:06:47 -0500
X-Greylist: delayed 1183 seconds by postgrey-1.27 at vger.kernel.org; Mon, 10 Feb 2020 10:06:46 EST
Received: from [84.175.181.115] (helo=[192.168.2.6])
        by smtprelay01.ispgateway.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92.3)
        (envelope-from <alexandr.miloslavskiy@syntevo.com>)
        id 1j1AKw-0007hq-7l; Mon, 10 Feb 2020 15:46:58 +0100
Subject: Re: [PATCH 2/8] rm: support the --pathspec-from-file option
To:     Junio C Hamano <gitster@pobox.com>,
        Alexandr Miloslavskiy via GitGitGadget 
        <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Paul-Sebastian Ungureanu <ungureanupaulsebastian@gmail.com>
References: <pull.530.git.1579190965.gitgitgadget@gmail.com>
 <5611e3ae326bb7f61abf870e3b2851226b6af1d8.1579190965.git.gitgitgadget@gmail.com>
 <xmqqftg8a9fp.fsf@gitster-ct.c.googlers.com>
From:   Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Message-ID: <19ab18db-3149-02b1-41d8-7ddb42c3757d@syntevo.com>
Date:   Mon, 10 Feb 2020 15:46:58 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <xmqqftg8a9fp.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Df-Sender: YWxleGFuZHIubWlsb3NsYXZza2l5QHN5bnRldm8uY29t
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sorry for late reply, I was on vacation. Now I'm back and ready to 
continue :)

Thanks for your review!

On 21.01.2020 20:36, Junio C Hamano wrote:
>> Decisions taken for simplicity:
>> 1) It is not allowed to pass pathspec in both args and file.
>>
>> `if (!argc)` block was adapted to work with --pathspec-from-file. For
>> that, I also had to parse pathspec earlier. Now it happens before
>> `read_cache()` / `hold_locked_index()` / `setup_work_tree()`, which
>> sounds fine to me.
> 
> That is not an explanation nor justification.

I'm not exactly sure what are you suggesting. My best guess is that you 
want to remove "`if (!argc)` block was adapted" paragraph from commit 
message? I thought about it and it feels wrong to leave this change 
unexplained. Or are you suggesting to reword it? If so, please give a hint.

>> In case of empty pathspec, there is now a clear error message instead
>> of showing usage.
> 
> Hmph, "git rm --pathspec-from-file=/dev/null" would say "nothing
> specified, nothing removed" and it makes perfect sense, but I am not
> sure "git rm" that gives the same message is better than the output
> by usage_with_options(builtin_rm_usage, builtin_rm_options).

What feels wrong to me is when I make a mistake and git just slams me 
with usage, and then it's up to me to figure what could be wrong. I 
myself struggled to find a mistake a couple times (in similar cases, not 
in this specific one) and didn't like the experience.

This could be a lot worse when there's no mistake, just the file was 
empty - but you already agreed that showing a new error message is 
reasonable with '--pathspec-from-file'.

Still, without '--pathspec-from-file', it should still be better to 
point to a specific error rather then "here's usage and try to find a 
difference". I have reworded the error message in V2 in hopes that it 
will be less controversial.

If you still don't like it, I will change it to only show the new error 
with '--pathspec-from-file'.

>> +static int ignore_unmatch = 0, pathspec_file_nul = 0;
>> +static char *pathspec_from_file = NULL;
> 
> We may want to clean these "explicitly initialize to 0/NULL" up at
> some point.  The clean-up itself would not be in the scope of this
> patch, of course, but not making it worse is something this patch
> can do to help.

Changed in V2.
