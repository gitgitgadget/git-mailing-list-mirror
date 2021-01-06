Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56CF6C433E0
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 16:05:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 270B72312E
	for <git@archiver.kernel.org>; Wed,  6 Jan 2021 16:05:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727289AbhAFQFH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 6 Jan 2021 11:05:07 -0500
Received: from mail.netline.ch ([148.251.143.178]:58752 "EHLO
        netline-mail3.netline.ch" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727049AbhAFQFH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 6 Jan 2021 11:05:07 -0500
Received: from localhost (localhost [127.0.0.1])
        by netline-mail3.netline.ch (Postfix) with ESMTP id E983C2A6045;
        Wed,  6 Jan 2021 17:04:23 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at netline-mail3.netline.ch
Received: from netline-mail3.netline.ch ([127.0.0.1])
        by localhost (netline-mail3.netline.ch [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id WI9tSX3wWVJz; Wed,  6 Jan 2021 17:04:22 +0100 (CET)
Received: from thor (24.99.2.85.dynamic.wline.res.cust.swisscom.ch [85.2.99.24])
        by netline-mail3.netline.ch (Postfix) with ESMTPSA id BF0552A6042;
        Wed,  6 Jan 2021 17:04:21 +0100 (CET)
Received: from [::1]
        by thor with esmtp (Exim 4.94)
        (envelope-from <michel@daenzer.net>)
        id 1kxBIK-002nrr-Q2; Wed, 06 Jan 2021 17:04:20 +0100
To:     phillip.wood@dunelm.org.uk, git@vger.kernel.org
Cc:     Daniel Stone <daniel@fooishbar.org>
References: <c22ba034-6d7d-866a-c6fb-d769d117eec4@daenzer.net>
 <502b710e-6347-5fa7-0461-21a84ae2250d@gmail.com>
From:   =?UTF-8?Q?Michel_D=c3=a4nzer?= <michel@daenzer.net>
Subject: Re: Bug report: git rebase ignores different context, resulting in
 subtle breakage
Message-ID: <8b4da09f-cc0f-8ea4-1b65-95a7fa9858d0@daenzer.net>
Date:   Wed, 6 Jan 2021 17:04:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.6.0
MIME-Version: 1.0
In-Reply-To: <502b710e-6347-5fa7-0461-21a84ae2250d@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-CA
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2021-01-06 4:40 p.m., Phillip Wood wrote:
> Hi Michel
> 
> Sorry for the slow response, this fell through the Christmas cracks.
> 
> On 14/12/2020 14:37, Michel Dänzer wrote:
>>
>> (Originally reported as a GitLab issue: 
>> https://gitlab.com/gitlab-org/gitlab/-/issues/292754)
>>
>>
>> All output below is from Debian git 2.29.2-1.
>>
>>
>> The following branches of 
>> https://gitlab.freedesktop.org/daenzer/mesa.git can be used to reproduce:
>>
>> gitlab-issue-292754/pre-rebase (pre-rebase state)
>> gitlab-issue-292754/base (new base)
>> gitlab-issue-292754/bad-rebase (bad post-rebase state)
>>
>>
>> The pre-rebase commit b9f18d0ddb6b075819bc2c6b9fa36dee483ef443 
>> contains this (truncated) hunk:
>>
>> @@ -480,13 +491,9 @@ sanity:
>>
>>     rules:
>>
>>       - if: *is-pre-merge
>>
>>         when: on_success
>>
>> -    - if: *is-forked-branch
>>
>> -      when: manual
>>
>>       # Other cases default to never
>>
>>     script:
>>
>>       # ci-fairy check-commits --junit-xml=check-commits.xml
>>
>>
>>
>> The new base commit f20153536087079f39f1ab9995ac3d36dd3c467f contains 
>> this hunk:
>>
>> @@ -484,10 +484,8 @@ sanity:
>>
>>       - .fdo.ci-fairy
>>
>>     stage: sanity
>>
>>     rules:
>>
>> -    - if: *is-pre-merge
>>
>> +    - if: *is-forked-branch-or-pre-merge
>>
>>         when: on_success
>>
>> -    - if: *is-forked-branch
>>
>> -      when: manual
>>
>>       # Other cases default to never
>>
>>     variables:
>>
>>       GIT_STRATEGY: none
>>
>>
>>
>> Both remove the same 2 lines, but the context is different both before 
>> and after those lines.
>>
>> My expectation for this case would be that
>>
>>   git rebase gitlab-issue-292754/base gitlab-issue-292754/pre-rebase
>>
>> fails with a conflict. However, it succeeds without any indication of 
>> trouble, resulting in these contents in commit 
>> 4e549e1ac3354f465d8afe0174902e62143a6ff4:
>>
>>     rules:
>>
>>
>>      - if: *is-forked-branch-or-pre-merge
>>
>>
>>         when: on_success
>>
>>
>>       # Other cases default to never
>>
>>
>>     variables:
>>
>>
>>       GIT_STRATEGY: none
>>
>>     script:
>>
>>
>>       # ci-fairy check-commits --junit-xml=check-commits.xml
>>
>>
>> I.e. identical to the new base.
> 
> This looks like the correct merge to me as the changes in the original 
> commit are already in the new base.

Are you referring to the same two lines which have been removed already? 
Since the context is different, removing those two lines has a different 
effect than intended.


> Rebase has detected that the context lines do not match and used a
> 3-way merge instead of a simple patch application. This matches the
> behavior of the merge based rebase backend which is the default in
> recent versions of git. Git tracks content not changes and so rebasing
> a branch means cherry-picking each commit onto the rebased version of
> it's parent, not applying each patch on top of the new base.

There is a single commit that needs rebasing, and the context in the new 
base commit is different from what it's based on. To me this seems like 
an obvious conflict.


-- 
Earthling Michel Dänzer               |               https://redhat.com
Libre software enthusiast             |             Mesa and X developer
