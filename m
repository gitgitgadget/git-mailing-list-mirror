Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00960C433FE
	for <git@archiver.kernel.org>; Thu, 13 Oct 2022 18:36:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229493AbiJMSgv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Oct 2022 14:36:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231924AbiJMSgD (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Oct 2022 14:36:03 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CD60192DB4
        for <git@vger.kernel.org>; Thu, 13 Oct 2022 11:32:28 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 475391BD2E2;
        Thu, 13 Oct 2022 14:13:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=BQ3PVB4tgG59nSUkzlCW4AuUYjWEQCiB8alz+J
        WMxm4=; b=A8fCd7f7Q+ZWTwyvETCm6l/E0FF4bUuHEc+GpbS3tS3wlx2151yu8R
        kbEKKroxWwBLYN/RcucEQOIrZ5xR/qjnkSH1AnJEZcxfvuIiq+0csw5mE1EEfFEK
        dapWWV9m6AWqWBiSl/eKhbLCyznFW3ooS33fcXziYRDk6OT/zXH5M=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 40C4D1BD2E1;
        Thu, 13 Oct 2022 14:13:45 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 6B2D31BD2DE;
        Thu, 13 Oct 2022 14:13:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Calvin Wan <calvinwan@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Glen Choo <chooglen@google.com>,
        Victoria Dye <vdye@github.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v3 1/8] rebase --apply: remove duplicated code
References: <pull.1150.v2.git.1650448612.gitgitgadget@gmail.com>
        <pull.1150.v3.git.1665567312.gitgitgadget@gmail.com>
        <a84cf971a753e294555ca8f2b7eaa4c75a8fa491.1665567312.git.gitgitgadget@gmail.com>
        <xmqqedvclqxm.fsf@gitster.g>
Date:   Thu, 13 Oct 2022 11:13:41 -0700
In-Reply-To: <xmqqedvclqxm.fsf@gitster.g> (Junio C. Hamano's message of "Wed,
        12 Oct 2022 13:36:53 -0700")
Message-ID: <xmqq35brh9re.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C50206B2-4B22-11ED-8BE2-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
>> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>>
>> Use move_to_original_branch() when reattaching HEAD after a fast-forward
>> rather than open coding a copy of that code. move_to_original_branch()
>> does not call reset_head() if head_name is NULL but there should be no
>> user visible changes even though we currently call reset_head() in that
>> case.
>
> move_to_original_branch() uses both .head_msg and .branch_msg and
> uses different messages for them, but the original code below only
> feeds .head_msg while .branch_msg leaves NULL, which leads
> reset.c::update_refs() to use the same message as .head_msg when it
> wants to use .branch_msg (i.e. the message recorded in the reflog of
> the branch).  
>
> Doesn't this difference result in a different behaviour?

I think "git rebase --apply A B" when B is already an descendant of
A with a single strand of pearls would trigger the new logic, and
instead of the old "rebase finished: %s onto %s" message used for
both reflogs, calling move_to_original_branch() will give us "rebase
finished: %s onto %s" in the branch reflog, while "rebase finished:
returning to %s" in the HEAD reflog.

Note that I am not saying we should not change the behaviour.
Saying "returning to X" in the reflog of HEAD may arguably be better
than using the same "rebased X onto Y" for reflogs for both HEAD and
the underlying branch.

But if that is what is going on, we should record it as improving
the reflog message, not removing duplicated code.

Also, it would be good to have a test that demonstrates how the
contents of the reflog changes with this change.  It took me some
time to figure out how to reach that codepath, even though it was
relatively easy to see how the reflog message(s) used before and
after the patch are different.

>> The reason for this is that the reset_head() call does not add a
>> message to the reflog because we're not changing the commit that HEAD
>> points to and so lock_ref_for_update() elides the update. When head_name
>> is not NULL then reset_head() behaves like "git symbolic-ref" and so the
>> reflog is updated.
>
>> Note that the removal of "strbuf_release(&msg)" is safe as there is an
>
> The patch is removing strbuf_reset(), not _release(), here, though.
>
> We have released already so there is no point to reset it again, so
> the removal is still safe.

Thanks.
