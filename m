Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 271ACC6FA8E
	for <git@archiver.kernel.org>; Sun,  5 Mar 2023 16:59:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229718AbjCEQ7D (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 5 Mar 2023 11:59:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbjCEQ67 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Mar 2023 11:58:59 -0500
Received: from dd36226.kasserver.com (dd36226.kasserver.com [85.13.153.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE4F5EB5B
        for <git@vger.kernel.org>; Sun,  5 Mar 2023 08:58:56 -0800 (PST)
Received: from [192.168.42.163] (127-98-142-46.pool.kielnet.net [46.142.98.127])
        by dd36226.kasserver.com (Postfix) with ESMTPSA id 9658F3C0FAA;
        Sun,  5 Mar 2023 17:58:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=haller-berlin.de;
        s=kas202302241129; t=1678035534;
        bh=rD/r1493iEl8nrx+xutxtUB7teGHPMjSN44Pd1yTOtQ=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=MTBtfYDZwv/ucARov3hOPqFX5AClfKyuyKrSu5DFe8JEGkDE3+6QfdajdHzxjKQHN
         Hn2bYoQPyFXmcZAw+l59KB4kMdPRWvioYYo3b3CNZqy0fN+Ipm9lD4Ki99e6xzivDp
         eveJYGHv7mC5QQrZzXgbhEcTdvb1r1HCBY4n+/BzX4BsUrJ2I0CZ6ELydgVXZICyev
         rGavbPIPDx8OE0cf0ESezwVbmts1aldApcyAjuMm8WLcOi8KWubmFjfrMk7kb4DkiA
         PNNqf1gpohX5TvNVa9pCKgqRiInO2z2pXql4bVqYkkPJwl0L9QUYzh0B+iC/2FuVvl
         7YNZee1kMT2bw==
Message-ID: <675876fa-cafb-b418-da88-93f3459fe270@haller-berlin.de>
Date:   Sun, 5 Mar 2023 17:58:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: When exactly should REBASE_HEAD exist?
Content-Language: de-DE, en-US
To:     phillip.wood@dunelm.org.uk, git@vger.kernel.org
References: <961e68d7-5f43-c385-10fa-455b8e2f32d0@haller-berlin.de>
 <374f83c2-7bf0-38be-26ae-de28340c37d2@dunelm.org.uk>
 <f28bb5a7-ec68-dce2-9b63-7bfb5330c33e@haller-berlin.de>
 <c237c1e3-5cd0-503d-ff4b-96f645a659f3@haller-berlin.de>
 <65f9d6c3-d7eb-5059-74d1-b9c150ddcccf@dunelm.org.uk>
From:   Stefan Haller <lists@haller-berlin.de>
In-Reply-To: <65f9d6c3-d7eb-5059-74d1-b9c150ddcccf@dunelm.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: -
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 05.03.23 15:33, Phillip Wood wrote:
> Hi Stefan
> 
> On 03/03/2023 10:57, Stefan Haller wrote:
>> On 02.03.23 21:27, Stefan Haller wrote:
>>> On 02.03.23 11:19, Phillip Wood wrote:
>>>> On 28/02/2023 12:55, Stefan Haller wrote:
>>>>> The reason why I am asking this is: I'm using lazygit, which, during
>>>>> interactive rebases, shows a combined view of the real commits that
>>>>> were
>>>>> already applied, and the remaining commits that are yet to be applied
>>>>> (it gets these by parsing rebase-merge/git-rebase-todo); something
>>>>> like
>>>>> this, when I set the 2nd commit to "edit":
>>>>>
>>>>>     pick   4th commit
>>>>>     pick   3rd commit
>>>>>            2nd commit  <-- YOU ARE HERE
>>>>>            1st commit
>>>>>
>>>>> This is great, but assuming that the 2nd commit conflicted, currently
>>>>> the display looks like this:
>>>>>
>>>>>     pick   4th commit
>>>>>     pick   3rd commit
>>>>>            1st commit  <-- YOU ARE HERE
>>>>>
>>>>> I would like to extend this to also show a "fake entry" for the commit
>>>>> that conflicted, if there is one. REBASE_HEAD is perfect for this,
>>>>> except that I need a way to distinguish whether it was applied already
>>>>> or not.
>>>>
>>>> Can you check the index for conflicts when the rebase stops?
>>>
>>> I could do that, but then the fake entry would go away as soon as I have
>>> staged all conflict resolutions. I would find it useful for it to stay
>>> visible in that case, until I continue the rebase.
>>
>> It seems that I can get close by checking whether the file
>> .git/rebase-merge/amend exists. If it does, the current patch was
>> applied already, and I don't show the fake entry. If it doesn't, we
>> still need to commit the changes from REBASE-HEAD, so it makes sense to
>> show it in the list.
> 
> When a fixup or squash stops for a confict resolution that file also
> exists as the result needs to be squashed into HEAD.

Ah damn, yes. And that's even a pretty common situation, so I can't just
ignore it as a rare edge case.

-Stefan
