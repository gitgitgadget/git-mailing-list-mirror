Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBDB5C47082
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 23:42:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2B7E60FF2
	for <git@archiver.kernel.org>; Tue,  8 Jun 2021 23:42:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231690AbhFHXoa (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Jun 2021 19:44:30 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53440 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231425AbhFHXoZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Jun 2021 19:44:25 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 76037D0836;
        Tue,  8 Jun 2021 19:42:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=hh0lDZp+j054Uan8MQu8Nl4VrmQa7b+eMSeCE3
        Sd5cc=; b=Hr2htVFk2yh/QD6/F688RiyWgls1VhcZm0wupDOTsfP1thGjUj45sW
        XCxiFRHR0IVedvx8bqgtgBHwd4K5CroRsoAfUrz2s7w/axsJ1YHx4GD94bvNkpsU
        yuUA+h+MDhtMLcN5pacVqPXxT4NvxQyCvNCr7M6uNztZ9Vmgbk3iQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 6D3E9D0835;
        Tue,  8 Jun 2021 19:42:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.172.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E3CF5D0834;
        Tue,  8 Jun 2021 19:42:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Git Mailing List <git@vger.kernel.org>,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>
Subject: Re: [PATCH v2 0/4] First steps towards partial clone submodules
References: <cover.1622580781.git.jonathantanmy@google.com>
        <cover.1623111879.git.jonathantanmy@google.com>
        <CABPp-BGL3L5uReVHtSUsNJ7fYgBV_Us5ZYv7e9FPHT2DuY-dyg@mail.gmail.com>
Date:   Wed, 09 Jun 2021 08:42:30 +0900
In-Reply-To: <CABPp-BGL3L5uReVHtSUsNJ7fYgBV_Us5ZYv7e9FPHT2DuY-dyg@mail.gmail.com>
        (Elijah Newren's message of "Tue, 8 Jun 2021 10:50:05 -0700")
Message-ID: <xmqq4ke7ordl.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 30DE7C38-C8B3-11EB-A1E2-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> On Mon, Jun 7, 2021 at 5:26 PM Jonathan Tan <jonathantanmy@google.com> wrote:
>>
>> Thanks everyone for your reviews. I believe I've addressed all review
>> comments, including the one from Elijah about the test failing with
>> sha256 (which turns out to be because I didn't add a call to
>> setup_git_directory(), which the other test helpers do).
>
> Thanks for fixing those up.  I spotted some minor nits/questions, but
> nothing big.
>
> Looks like Junio did spot some bigger items...which raises a question
> for me.  I have a series ...

Do you mean, by "bigger items", that we may want to turn it around
to have repo extension data to the in-core repository structure?

> (https://lore.kernel.org/git/pull.969.git.1622856485.gitgitgadget@gmail.com/)
> that also touches partial clones.  Our series are semantically
> independent, but we both add a repository parameter to
> fetch_objects().  So we both make the same change, but you also make
> additional nearby changes, resulting in two trivial conflicts.  ...

I can sort of see how the above plan would work if we are not going
to fix the "keep only the partialclone related extension thing,
instead of solving the larger structural problem that the current
arrangement ignores that repository extensions are per repository".
But wouldn't that leave us with two series with technical debt?
Also, if Jonathan's series fixes the "bigger item", would the above
"proceed more or less independently or rebase one on top of the
other" plan work well without making the same fix in yours?

I guess a better first step would be to stop, think and decide what
to do with the "bigger" thing---if only to dismiss it with a firm
declaration that we would never do such a fix and move extension
data piecemeal to relevant subsystems, so that we'd reduce conflicts
in the future, as I am reasonably sure that the "bigger item" will
be tempting to fix even after the two series lands, and doing so at
that time would be twice larger surgery.
