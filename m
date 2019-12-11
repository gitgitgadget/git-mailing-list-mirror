Return-Path: <SRS0=ratM=2B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3EC7C43603
	for <git@archiver.kernel.org>; Wed, 11 Dec 2019 11:43:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 938062073D
	for <git@archiver.kernel.org>; Wed, 11 Dec 2019 11:43:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728401AbfLKLnz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Dec 2019 06:43:55 -0500
Received: from smtprelay03.ispgateway.de ([80.67.18.15]:11105 "EHLO
        smtprelay03.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727365AbfLKLnz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Dec 2019 06:43:55 -0500
Received: from [24.134.116.61] (helo=[192.168.92.208])
        by smtprelay03.ispgateway.de with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
        (Exim 4.92.3)
        (envelope-from <alexandr.miloslavskiy@syntevo.com>)
        id 1if0PG-00075S-FF; Wed, 11 Dec 2019 12:43:50 +0100
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
From:   Alexandr Miloslavskiy <alexandr.miloslavskiy@syntevo.com>
Message-ID: <2b573436-0ed2-9d24-f375-dfea0825a39e@syntevo.com>
Date:   Wed, 11 Dec 2019 12:43:49 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <4401823b-8039-99b4-2436-ed2f1a571d78@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Df-Sender: YWxleGFuZHIubWlsb3NsYXZza2l5QHN5bnRldm8uY29t
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10.12.2019 11:42, Phillip Wood wrote:
> I don't think it's so bad if the pathspec is cleaned up just after it is used,
> the diff below applies on top of your patch - see what you think. The diff
> also adds dies if --all is given with --pathspec-from-file which (together
> with a test) would be worth adding to you series I think.

Unfortunately, your reply came too late, topic was cooking in pu/next 
for a while and merged into master yesterday: c58ae96f.

I understand that your patch consists of two parts:

1) Adding test for --all
------------------------
I must admit that I overlooked that there was a similar test for 
args-based pathspec. I will add this part in my next topic for 
--pathspec-from-file. I expect it to appear in the next day or two. I 
will try to remember to CC you to it.

2) Moving parsing/validation into `parse_and_validate_options()`
------------------------
Again, I agree that having parsing/validation outside is suboptimal.
However, with current code, I find it to be a choice between two evils, 
and my choice was "outside but clear" to "inside but obscure".

What I find obscure in your suggestion/patch is that innocently looking 
`prepare_index()` suddenly clears pathspec as well. It's even harder to 
see when called through `dry_run_commit()`.

Now, let me illustrate. There's a similar case in my TODO list, this 
time involving a real bug in git. In `init_db()`, the bug occurs in 
`set_git_dir(real_path(git_dir))`, also due to unexpected clearing.

Now that I pointed my finger at it, please try to find what's wrong. I 
imagine that it won't be easy at all. And it's way harder when there's 
no reason to dig deep into a very specific line of code.

I really try to avoid such type of pitfalls. That's why my choice 
between two evils is what I did.

