Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBABAC678D4
	for <git@archiver.kernel.org>; Fri,  3 Mar 2023 10:57:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbjCCK5W (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Mar 2023 05:57:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230254AbjCCK5K (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Mar 2023 05:57:10 -0500
Received: from dd36226.kasserver.com (dd36226.kasserver.com [85.13.153.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDFC54ECDE
        for <git@vger.kernel.org>; Fri,  3 Mar 2023 02:57:07 -0800 (PST)
Received: from [192.168.42.163] (127-98-142-46.pool.kielnet.net [46.142.98.127])
        by dd36226.kasserver.com (Postfix) with ESMTPSA id B51063C0FAA;
        Fri,  3 Mar 2023 11:57:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=haller-berlin.de;
        s=kas202302241129; t=1677841025;
        bh=SA/rdPswUq9OugJtO/SscRJISX29E9aM9glz5mziYaw=;
        h=Date:Subject:From:To:References:In-Reply-To:From;
        b=LABf1u8VMpatlI541fypBa6BGiKiyiKypY52pm3xc0L7s0bVdSc6mm+BFjmPWuUep
         HmsEZ0GH69luw6c3faLCqenme8sGwlX2fe5/wF2FdEQYFfpIvC0c14A6WLU7hyFtMG
         Is+aqEmyvP32UJVux/h/1dKJpNo6IbadwEWbgNHAuKub5aMe6kDlAhmJOdhC9tNt00
         oHH2VRyK6UFMcbS1/sxbMMPUu5quXE0+8jxSmdu7aYlO4e/J/UcCHijRBVLFBe5FMo
         OHyxjjBVcYrMhks6UWDHS054WXu1KF/1Cg2tkWjcrQ8Xz4UmbJzj26IZNxqZvVh7yV
         vqxErzSjgw8XA==
Message-ID: <c237c1e3-5cd0-503d-ff4b-96f645a659f3@haller-berlin.de>
Date:   Fri, 3 Mar 2023 11:57:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: When exactly should REBASE_HEAD exist?
Content-Language: de-DE, en-US
From:   Stefan Haller <lists@haller-berlin.de>
To:     phillip.wood@dunelm.org.uk, git@vger.kernel.org
References: <961e68d7-5f43-c385-10fa-455b8e2f32d0@haller-berlin.de>
 <374f83c2-7bf0-38be-26ae-de28340c37d2@dunelm.org.uk>
 <f28bb5a7-ec68-dce2-9b63-7bfb5330c33e@haller-berlin.de>
In-Reply-To: <f28bb5a7-ec68-dce2-9b63-7bfb5330c33e@haller-berlin.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Bar: -
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 02.03.23 21:27, Stefan Haller wrote:
> On 02.03.23 11:19, Phillip Wood wrote:
>> On 28/02/2023 12:55, Stefan Haller wrote:
>>> The reason why I am asking this is: I'm using lazygit, which, during
>>> interactive rebases, shows a combined view of the real commits that were
>>> already applied, and the remaining commits that are yet to be applied
>>> (it gets these by parsing rebase-merge/git-rebase-todo); something like
>>> this, when I set the 2nd commit to "edit":
>>>
>>>    pick   4th commit
>>>    pick   3rd commit
>>>           2nd commit  <-- YOU ARE HERE
>>>           1st commit
>>>
>>> This is great, but assuming that the 2nd commit conflicted, currently
>>> the display looks like this:
>>>
>>>    pick   4th commit
>>>    pick   3rd commit
>>>           1st commit  <-- YOU ARE HERE
>>>
>>> I would like to extend this to also show a "fake entry" for the commit
>>> that conflicted, if there is one. REBASE_HEAD is perfect for this,
>>> except that I need a way to distinguish whether it was applied already
>>> or not.
>>
>> Can you check the index for conflicts when the rebase stops?
> 
> I could do that, but then the fake entry would go away as soon as I have
> staged all conflict resolutions. I would find it useful for it to stay
> visible in that case, until I continue the rebase.

It seems that I can get close by checking whether the file
.git/rebase-merge/amend exists. If it does, the current patch was
applied already, and I don't show the fake entry. If it doesn't, we
still need to commit the changes from REBASE-HEAD, so it makes sense to
show it in the list.

Does this sound like a reasonable approach? I must admit that the code
in sequencer.c is too complex for me to tell at a glance whether there
are situations where this heuristic would do the wrong thing.

-Stefan
