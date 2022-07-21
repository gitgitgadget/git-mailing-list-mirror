Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B0ECC433EF
	for <git@archiver.kernel.org>; Thu, 21 Jul 2022 16:06:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230367AbiGUQGU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jul 2022 12:06:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230008AbiGUQGR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jul 2022 12:06:17 -0400
Received: from smtp.hosts.co.uk (smtp.hosts.co.uk [85.233.160.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90D922ACB
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 09:06:13 -0700 (PDT)
Received: from host-78-147-187-217.as13285.net ([78.147.187.217] helo=[192.168.1.57])
        by smtp.hosts.co.uk with esmtpa (Exim)
        (envelope-from <philipoakley@iee.email>)
        id 1oEYgk-000AOY-9N;
        Thu, 21 Jul 2022 17:06:11 +0100
Message-ID: <d58f468d-3826-1aa7-9203-5e1f473159e1@iee.email>
Date:   Thu, 21 Jul 2022 17:06:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: On-branch topic description support?
Content-Language: en-GB
To:     Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Git Mailing List <git@vger.kernel.org>
References: <xmqqilnr1hff.fsf@gitster.g>
 <CABPp-BFm2c2Mpdj6pTR2-WPEsnQWTJpH70xrZoqUrwOed9o9=w@mail.gmail.com>
From:   Philip Oakley <philipoakley@iee.email>
In-Reply-To: <CABPp-BFm2c2Mpdj6pTR2-WPEsnQWTJpH70xrZoqUrwOed9o9=w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 21/07/2022 06:25, Elijah Newren wrote:
> On Wed, Jul 20, 2022 at 5:08 PM Junio C Hamano <gitster@pobox.com> wrote:
>> I've been playing with this idea from time to time, but recently I
>> started seeing a related discussion on the b4 front, so I thought I
>> would throw it out and how people would think.
>>
>> We made "git merge" not to silently commit the result, but open the
>> editor to encourage the integrator to describe what the topic is
>> about.  We also made "git format-patch" prepare [PATCH 0/n] aka
>> "cover letter" so that the author of the patch series can express
>> what the overall topic is about.  What the author should say in the
>> cover letter very much overlaps what the integrator wants to have in
>> the log message of the commit that merges the topic to the
>> integration branch.
>>
>> But there are two (and half) links from format-patch to that merge
>> commit that are missing.
>>
>>  - You cannot prepare the cover letter material while working on the
>>    topic---instead, you have to write one by editing the output from
>>    "format-patch --cover-letter";
>>
>>  - "git am" at the receiving end discards the cover letter when
>>    queuing the e-mailed patches to a topic.
>>
>>  - "git merge" cannot take advantage of the cover letter that was
>>    discarded when the topic was queued.
>>
>> So, here is how I would imagine a slightly better world may work.
>>
>>  * When you are almost finished with the initial draft of your
>>    topic, you'd write a cover letter, and record it as the log
>>    message of an empty commit at the tip of the topic.  

If one has a plan in place for a series in preparation, I'd want to
prepare the outline of the cover letter first, and then later let it
float to the tip of the series after a rebase, and incorporate (meld)
additional notelets recorded as additional empty commits.

On thought is to marry this with the `rebase --autosquash` mechanism
that will rearrange commits (when enabled) so that we could have a
"branchtip! " subject line, similar to the `fixup! / squash!` subject
lines to assist in that rearrangement  of the series for transmission.

I'm not yet sure how the "branchtip" method would work with Pull
Requests and the idea of actually having a push/pull exchangeable branch
description - there's been a very recent discussion on the Git-user list
[1] which started from a slightly different premise, but maybe has some
of the same issues as persistent Change-ID's [2].
>> As you go on
>>    polishing the topic with "rebase -i", the empty commit would be
>>    kept (if we currently lose an empty commit by default, we may
>>    need to teach "rebase -i" to special case an empty commit at the
>>    tip of the range to make this convenient to use), and you would
>>    keep it up to date as you update the topic.
> No need for rebase changes here.  By default, it preserves commits
> which start empty, and only drops commits which *become* empty.
>
> (If one wants to drop commits that start empty, you can pass
> `--no-keep-empty`.  If you want to keep commits that become empty, you
> can use either `--empty=keep` or `--empty=ask`.)
>
>>  * "git format-patch" would notice that the topic has such an empty
>>    commit at the tip, and use the log message from it to
>>    pre-populate the cover letter.
>>
>>  * "git am" would learn an option to save the cover letter [0/n] and
>>    create such an empty commit at the tip of the branch.
>>
>>  * "git merge" would learn an option to recognize that the branch
>>    being merged has such an empty commit at the tip, and instead
>>    merge the parent of the tip of the branch into the integration
>>    branch, while using the log message of the discarded tip commit
>>    in the log message of the merge itself.
>>
>> Yes, there is "git config branch.mytopic.description" that helps
>> when pre-populating the cover letter, but that only helps at the
>> origin, and it is not shared between your personal repositories.
>> If you have the draft of the cover letter as part of the branch,
>> you can push/fetch them around just like all the "real" commits
>> you are working on.
>>
>> Regardless of where the cover letter comes from, the changes to "am"
>> and "merge" dreamed above in this message would be useful, and that
>> is the primary reason why I am envisioning that right at the origin
>> having the topic description as an empty commit at the tip would be
>> the most convenient.  It would match the shape of the history at the
>> author side and at the side who runs "git am".
> Seems mostly reasonable, but I'm curious about one thing:
>
> The cover letter material often includes stuff that would not make
> sense for the merge message (e.g. "Rebased this version on master
> because of conflicts with ...", "Changes since v3", "I'm a little
> unsure of the logic in Patch 5", "Patch 3 might be controversial; take
> a look", etc.)  Would there be some kind of syntax for specifying the
> part of the cover letter meant to be used in the merge commit message,
> or would we just start out with it pre-populating the commit message
> and expect the integrator to cull out the irrelevant parts?
--
Philip

[1] https://groups.google.com/g/git-users/c/5RftRV1c5Zw/m/cpem3KL1AAAJ
Dan Rosen 18/07/2022
[2]
https://lore.kernel.org/git/bdbe9b7c1123f70c0b4325d778af1df8fea2bb1b.camel@that.guru/
