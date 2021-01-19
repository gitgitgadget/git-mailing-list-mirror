Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31B4FC433E6
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 15:16:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E966923119
	for <git@archiver.kernel.org>; Tue, 19 Jan 2021 15:16:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389994AbhASPQd (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jan 2021 10:16:33 -0500
Received: from mail.aerusso.net ([104.225.219.13]:58038 "EHLO mail.aerusso.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387620AbhASPOz (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jan 2021 10:14:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=aerusso.net; s=default;
        t=1611069248;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0mRiSYJGhq5HJp/8LuUMYigc/KgOUGBv1wdglNyFag0=;
        b=fD/oBy/q96OHHfNiqdCuWov6qaXWE/fylhkjbYFf/W6jXIZu7iiesEKYvFya3wUbotuJG/
        kd9pURxyuhA1dPqoW7sIACJxBykUx7fYRKTYCbCA9HLZDf7Jj8FZ1iHhmQ9Ewh8JfONWEB
        fEKfTPEtM8e/WNb3ct12MV5nCYWwwUl+yU4TZAa1q9cHOkBxfUrV71IMCQieg514JLI3+w
        XoKERE4ojK2RjaDjcwyLwb/Bo+fP6aVqZE+JSGr1RFgSzGI0ULH5YvQQaF8HwrmCFt3pVx
        EeVKnbC9LWN3Qm2LIBPdZhafsyLl0tXyxS0/hBd9dEqZmlTGFcSrF2sWMomoMQ==
To:     Derrick Stolee <stolee@gmail.com>,
        Aiyee Bee <shane.880088.supw@gmail.com>, git@vger.kernel.org
References: <C8MJ83LNOZ1Q.OCQKHOTGHKWF@localhost>
 <38ed4389-ba9f-743a-3fa3-5ffab12ef0a9@gmail.com>
 <992cd021-d6f6-dfe4-1918-45643aa85a61@aerusso.net>
 <5e5ece7c-3f34-caa1-db87-084b42c1cb62@gmail.com>
From:   Antonio Russo <aerusso@aerusso.net>
Subject: Re: DEVEL: Help with feature implementation
Message-ID: <0a83391e-3cf3-49a7-e558-ef726b9432fb@aerusso.net>
Date:   Tue, 19 Jan 2021 08:13:46 -0700
MIME-Version: 1.0
In-Reply-To: <5e5ece7c-3f34-caa1-db87-084b42c1cb62@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 1/18/21 7:39 PM, Derrick Stolee wrote:
> On 1/18/2021 7:54 PM, Antonio Russo wrote:
>> On 1/18/21 1:58 PM, Derrick Stolee wrote:
>>> On 1/18/2021 2:31 PM, Aiyee Bee wrote:
>>>> Hi Antonio and Derrick!
>>>>
>>>>> I think what you really want is --full-history --simplify-merges [1]. This
>>>>> will show the merges that "fork" the history into parallel tracks where
>>>>> at least two of them contain interesting commits.
>>>>
>>>> It doesn't look like the implementation of --simplify-merges helps much
>>>> here. That makes its decision on basis of the parents of the commit, which is
>>>> simple to do as it's information attached freely to each commit. I think the
>>>> problem here would be figuring out, given any commit, how many of its children
>>>> are "relevant" commits.
>>>
>>> You should definitely give this a try instead of assuming things about the
>>> implementation. The algorithm uses a lot of "simplifying" that makes it look
>>> like the decision is a local one. However, I assure you that is not the case.
>>
>> As a side note, would this list be willing to look at patches that remove
>> the need to use revs->limited?  Adding new features would be much easier if
>> we could restrict git to use streaming algorithms for these simplifications.
> 
> I would _love_ to see patches that remove that bit (without modifying
> the behavior).
> 
> Fair warning: I definitely spent a few weeks attempting to do any amount
> of reducing the depth one needs to walk in order to compute the
> --simplify-merges history, but a sufficiently-complicated branch history
> makes it nearly impossible to gain a benefit.

The goal I had in mind was just to remove the alternate code path, making
new features easier to write (i.e., you don't have to do them twice).

>>> Please assemble a test case that demonstrates the behavior you want and how
>>> that is different from what is present in --simplify-merges.
>>
>> I can't figure out how to get the behavior from --simplify-merges, which is
>> described as
>>
>> 	Additional option to --full-history to remove some needless
>> 	merges from  the resulting history, as there are no selected
>> 	commits contributing to this merge.
>>
>> It seems that the desired behavior is to include commits which are parents to
>> multiple branches.  Here is an example:
> 
> Thank you for these examples. They clearly show that I misread your
> ask, because you're not looking for "merge commits" but instead you
> are looking to show the "merge bases" as history is walking.
> 
> Sorry for misinterpreting your request, then doubling down on it.

No problem! (Just to be clear, the is a request of shane.880088.supw,
not me.)

> 
>> test_commit() {
>>  echo >> file
>>  git add file
>>  git commit "$@"
>> }
>>
>> git init
>> test_commit -m a
>> test_commit -m b
>> test_commit -m c
>> git checkout -b fork
>> test_commit -m y
>> test_commit -m z
>> git switch master
>> test_commit -m d
>> test_commit -m e
>> test_commit -m f
>>
>> git log --graph --oneline master fork
>>
>> * 08029fd f
>> * 55b09fe e
>> * 83b7801 d
>> | * efc204e z
>> | * 316219e y
>> |/  
>> * 3594039 c
>> * 4321987 b
>> * bd44220 a
>>
>> git log --graph --oneline --full-history --simplify-merges master fork
>>
>> * 08029fd f
>> * 55b09fe e
>> * 83b7801 d
>> | * efc204e z
>> | * 316219e y
>> |/  
>> * 3594039 c
>> * 4321987 b
>> * bd44220 a
>>
>> git log --graph --oneline --simplify-by-decoration --full-history --simplify-merges master fork
>>
>> * 08029fd f
>> | * efc204e z
>> |/  
>> * bd44220 a
>>
>> git log --graph --oneline --full-history --simplify-merges master fork
>>
>> * 08029fd f
>> * 55b09fe e
>> * 83b7801 d
>> | * efc204e z
>> | * 316219e y
>> |/  
>> * 3594039 c
>> * 4321987 b
>> * bd44220 a
>>
>> git --version
>> git version 2.30.0
>>
>> I can't seem to get commit c, the crucial fork, to show up with simplifications with this mechanism.
>> Am I missing something here?
> 
> In your example, you are not specifying a path. In this case, you are
> really looking for "git merge-base master fork". You could also use
> "git log --boundary master...fork" to show everything up to and
> including 'c'.
> 
> Now, if you specify a pathspec, then 'git merge-base' isn't going to
> help. That becomes a technically interesting problem.
> 
> The biggest reason that "git log" doesn't show this commit 'c' easily
> is because...it's not really that important. When that commit was
> created, it didn't "know" that it would be a common base of two
> diverging branches. By surfacing the commit, we are very unlikely to
> present the user with information that is helpful.

I think shane.880088.supw's point was that it's importance is, exactly as
you point out, not locally computable, only arising because it is a merge
base.

[snip (but an interesting read)]

> 
> Thanks,
> -Stolee
>
Antonio
