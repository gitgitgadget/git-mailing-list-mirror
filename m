Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A35EDC4338F
	for <git@archiver.kernel.org>; Mon, 26 Jul 2021 10:31:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85F2D60F22
	for <git@archiver.kernel.org>; Mon, 26 Jul 2021 10:31:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232202AbhGZJvL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Jul 2021 05:51:11 -0400
Received: from smtprelay08.ispgateway.de ([134.119.228.106]:13012 "EHLO
        smtprelay08.ispgateway.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231646AbhGZJvL (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jul 2021 05:51:11 -0400
Received: from [84.163.73.49] (helo=[192.168.2.202])
        by smtprelay08.ispgateway.de with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <git@mfriebe.de>)
        id 1m7xsY-0002WY-O8; Mon, 26 Jul 2021 12:30:34 +0200
Subject: Re: Files modified, even after: git reset --hard
To:     Chris Torek <chris.torek@gmail.com>
Cc:     Git List <git@vger.kernel.org>
References: <dd4aca2c-9ca2-e489-d78f-9d2a5580f1a5@mfriebe.de>
 <4e9b54b4-8e40-7fd3-ae65-d33390f3af43@mfriebe.de>
 <04f3b300-3ccf-c91b-6406-6a998b473a24@mfriebe.de>
 <bfc257c7-bf74-06be-ac62-9a6d27f565c9@mfriebe.de>
 <CAPx1GvcHiaGsuOybOijRYpmivO0dLvUFacAeOrM4DfY-uuXB2Q@mail.gmail.com>
 <070f7f5e-0e6c-2edc-1403-9265c810df17@mfriebe.de>
 <CAPx1GvdM7CzsbT1SWW9+OPcG9FL7WXQ7YD6aM7P0krujp_OrkQ@mail.gmail.com>
From:   Martin <git@mfriebe.de>
Message-ID: <f454bf5b-c5ff-4140-02a8-b02dcd35c6b9@mfriebe.de>
Date:   Mon, 26 Jul 2021 12:31:37 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <CAPx1GvdM7CzsbT1SWW9+OPcG9FL7WXQ7YD6aM7P0krujp_OrkQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Df-Sender: bWVAbWZyaWViZS5kZQ==
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 26/07/2021 04:59, Chris Torek wrote:
> On Sun, Jul 25, 2021 at 6:34 PM Martin <git@mfriebe.de> wrote:
>> Actually there is something else.
>>
>> If a file has line-endings that will change, then
>>      git add --renormalize .
>>      git commit -m foo
>> will commit those files.
>>
>> But I am now also getting files, that show modified, but that can not be
>> committed renormalized (0 lines changed).
> 
> I believe (but can't demonstrate) that this is a temporary condition.

I now found one, that does not seem temporary at all...

git remote -v
gh-me   https://github.com/User4martin/binutils-gdb.git (fetch)
gh-me   https://github.com/User4martin/binutils-gdb.git (push)
gh-redprig      https://github.com/red-prig/binutils-gdb.git (fetch)
gh-redprig      https://github.com/red-prig/binutils-gdb.git (push)
origin  git://sourceware.org/git/binutils-gdb.git (fetch)
origin  git://sourceware.org/git/binutils-gdb.git (push)

fsck had some dangling commits, I did a "git gc --aggressive".
Now
  git fsck
Checking object directories: 100% (256/256), done.
Checking objects: 100% (1062929/1062929), done.
Checking connectivity: 1062929, done.

Switching to a far away commit
git switch -f --detach master
git rev-list master | wc -l
93917

git status shows no modified files


Then switching to  (this is on master branch)
git switch -f --detach a362ee23634
git rev-list a362ee23634 | wc -l
4164

git status --porcelain=v2
1 .M N... 100644 100644 100644 9e677a52ae690808165993a0f3f17ac49e3969df 
9e677a52ae690808165993a0f3f17ac49e3969df bfd/Makefile.dos
1 .M N... 100644 100644 100644 ff24f19c0b6e0c7fb713c79e8f1765bc22fe7adc 
ff24f19c0b6e0c7fb713c79e8f1765bc22fe7adc binutils/Makefile.dos
1 .M N... 100644 100644 100644 1d9541c2f896842d1bafe68ccf0a51e291d66688 
1d9541c2f896842d1bafe68ccf0a51e291d66688 gas/Makefile.dos
1 .M N... 100644 100644 100644 57fab985680ea151379069abe414bcb590cdd743 
57fab985680ea151379069abe414bcb590cdd743 ld/Makefile.dos


git reset --hard
makes no difference.

Only
     git diff
shows actual textual differences
e.g.

  TARGETLIB = libbfd.a
-CFLAGS = -g -O $(HDEFINES) $(TDEFINES) $(CSEARCH) $(CSWITCHES) # 
-DINTEL960VERSION
+CFLAGS = $(MINUS_G) $(HDEFINES) $(TDEFINES) $(CSEARCH) $(CSWITCHES) # 
-DINTEL960VERSION












> 
> Git has a number of cheats to make `git status` and other ops fast.
> These cheats *assume* that the committed files, the index copies
> of files, and the working tree copies of files all agree in terms of
> line endings as coordinated through `core.autocrlf` and `.gitattributes`
> settings.
> 
> When they *don't* agree, you get phantom differences.  Running
> commands like `git diff` show no differences because of these
> phantom states.  Eventually this clears up on its own when the
> cheats really *do* agree with the settings.  Changing the settings
> is what disturbs the cheats.
> 
> Git can't do much with `core.autocrlf`, but if it noticed that a
> `.gitattributes` file was very recent, and turned off the shortcuts
> and did the slower full status checks, updates via `.gitattributes`
> would not show phantom changes.  The drawback is that updates
> to `.gitattributes` could make `git status` very slow.

Ok, one of the repros has had its .gitattributes committed on the root 
commit, and never changed.
Neither do/did I change the config since it was created.

My question is are there any plumbing commands, that could allow me to 
look further at it.

