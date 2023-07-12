Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB6DEEB64DA
	for <git@archiver.kernel.org>; Wed, 12 Jul 2023 20:27:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232004AbjGLU1S (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Jul 2023 16:27:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbjGLU1R (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jul 2023 16:27:17 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F11AAC
        for <git@vger.kernel.org>; Wed, 12 Jul 2023 13:27:16 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 4132E1A2089;
        Wed, 12 Jul 2023 16:27:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=umaTTintLzfYa41ToKt6ivsrYAFJM+mZWUk8kKjbwE4=; b=kyex
        X2GqsozFveQ/8WyS+K2cBR5im5xnY0yPnkV4Ap/wRSq1tLYsgGtqGTbjhE79S6lZ
        v5Xo0BBSQZxBn5IxCirZsV1tYYLA486aa74pMVJp+5AzCMyxGp9W5JvCA0nFGadZ
        AFB/hzvOh8Dnrn0QI1CTgMF46m1hP0zw9BvlbBc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 384C51A2088;
        Wed, 12 Jul 2023 16:27:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.127.75.226])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 8D8681A2085;
        Wed, 12 Jul 2023 16:27:14 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Aleksander =?utf-8?Q?Korzy=C5=84ski?= <ak@akorzy.net>,
        git@vger.kernel.org
Subject: Re: Beyond Merge and Rebase: The Upstream Import Approach in Git
References: <CADWu+UnThMq2M+kCMADP9rZ5c6nL+Hz+z0-OqRnuG2oYVzbvWw@mail.gmail.com>
        <71f7d816-b139-03ab-88fc-7552d65e4498@gmx.de>
        <xmqq7cr5uonp.fsf@gitster.g>
Date:   Wed, 12 Jul 2023 13:27:13 -0700
Message-ID: <xmqqpm4wswny.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7CF9BD78-20F2-11EE-8EC7-307A8E0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

>> So I switched to a different scheme instead that I dub "merging rebase".
>> Instead of finishing the rebase with a merge, I start it with that merge.
>> In your example, it would look like this:
>>
>>    o---o---o---o---o  upstream/main
>>         \           \
>>          o---o---o---M---o'---o'---o' main
> ...
>> This strategy is not without problems, though, which becomes quite clear
>> when you accept PRs that are based on commits prior to the most recent
>> merging rebase (or rebasing merge, both strategies suffer from the same
>> problem): the _next_ merging rebase will not necessarily find the most
>> appropriate base commit, in particular when rebasing with
>> `--rebase-merges`, causing unnecessary merge conflicts.

In Git, any commit, be it a single parent commit or a merge, makes
this statement:

    I considered all the parents of this commit, and it is my belief
    that it suits the purpose of the branch I am growing better than
    all of them.

This is the foundation of the correctness of three-way merges.
Coming from a common ancestor, because M suits the purpose of the
branch better than M^1 or M^2, when merging anything forked from M^1
(or M^2) into a decendant of M (say, 'main'), as long as the
descendant of M still shares the same purpose of the branch, it does
not need to consider what the commits before M^1 (or M^2) did.

M in the "merging rebase", however, claims that M, i.e. the recent
upstream, fits the purpose of the branch better than the earlier
three commits did, which is not quite right.  In contrast, rebasing
merge does not have such a problem, i.e.

    o---o---o---o---o  upstream/main
         \           \
          \           a'---b'---c'
           \                     \
            a---b---c-------------M main

The commit c, a parent of M, implemented the features the topic
wanted to, and the commit c', another parent of M, implements the
same on top of a newer upstream.  The tree of M is the same as c'
and it matches the purpose, which presumably is to implement
whatever (a,b,c) or (a',b',c') wanted to on top of reasonably recent
upstream, of the branch.

Anyway, I do not think building on top of M would help from this
state, so let's stop seeing if there is a way to make rebasing merge
a bit more useful.

Thanks.


