Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84146C433EF
	for <git@archiver.kernel.org>; Sun, 27 Feb 2022 19:54:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231542AbiB0Ty4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 27 Feb 2022 14:54:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230315AbiB0Tyy (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Feb 2022 14:54:54 -0500
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BBDE17054
        for <git@vger.kernel.org>; Sun, 27 Feb 2022 11:54:17 -0800 (PST)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 97EA2115E17;
        Sun, 27 Feb 2022 14:54:16 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=tb8spXMawcBneaIfvfv3ahjXqf6swg+53wkSPY
        4IGKI=; b=J3HLdL2HYkqQz9VSQwFm2Zn8PqtDQ7kxbhW5qtRXwvMxn9MLumdL4z
        6GPHnuTxgQqRM5EPi9BEvENNychvAy16KOU8u4qsRyUegzXY9SiM40ieSzsYeMSy
        opdGyQMyJW0Rxryj1D7bNSM5A4NBLK3CvIxVTz0ot/C5AnGEoYNoE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8ED37115E15;
        Sun, 27 Feb 2022 14:54:16 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id ECEAD115E14;
        Sun, 27 Feb 2022 14:54:15 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Tao Klerks <tao@klerks.biz>
Cc:     Tao Klerks via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v2] untracked-cache: support '--untracked-files=all' if
 configured
References: <pull.985.git.1624430668741.gitgitgadget@gmail.com>
        <pull.985.v2.git.1645811564461.gitgitgadget@gmail.com>
        <xmqqtucmag00.fsf@gitster.g>
        <CAPMMpoixi3x1PHrSHJPV1GRBzMpuOQ4meMr-fipXuDvz-96MEA@mail.gmail.com>
Date:   Sun, 27 Feb 2022 11:54:14 -0800
In-Reply-To: <CAPMMpoixi3x1PHrSHJPV1GRBzMpuOQ4meMr-fipXuDvz-96MEA@mail.gmail.com>
        (Tao Klerks's message of "Sun, 27 Feb 2022 12:21:30 +0100")
Message-ID: <xmqqbkys3x21.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0B1672A2-9807-11EC-93E4-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Tao Klerks <tao@klerks.biz> writes:

>> > +     configured_dir_flags = configured_default_dir_flags(istate);
>> > +     if (dir->flags != configured_dir_flags)
>> > +             return NULL;
>>
>> Hmph.  If this weren't necessary, this function does not need to
>> call configured_default_dir_flags(), and it can lose the
>> configured_dir_flags variable, too.  Which means that
>> new_untracked_cache() function does not need to take the flags word
>> as a caller-supplied parameter.  Instead, it can make a call to
>> configured_dir_flags() and assign the result to uc->dir_flags
>> itself, which would have been much nicer.
>
> I've tightened this up a little with an inline call to
> configured_default_dir_flags(), getting rid of the variable, let's see
> if that makes more sense / is cleaner.

The extra variable does not bother me at all.  Leaving the room for
the caller to screw up and pass an incorrect configred_dir_flags is
what disturbs me.

If this caller needs to call configred_default_dir_flags(istate),
then we cannot avoid it.  And the extra variable needed to call the
function only once, store its result, and use that result twice, is
perfectly a good thing to have.  We don't want to see inline or
anything tricky.

Thanks.
