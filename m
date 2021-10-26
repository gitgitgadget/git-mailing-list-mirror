Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00021C433EF
	for <git@archiver.kernel.org>; Tue, 26 Oct 2021 00:45:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D62D660C4B
	for <git@archiver.kernel.org>; Tue, 26 Oct 2021 00:45:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233736AbhJZAsW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Oct 2021 20:48:22 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51720 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232476AbhJZAsV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Oct 2021 20:48:21 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1516CFA6A6;
        Mon, 25 Oct 2021 20:45:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=4fpmRGBWDeZGMfSf+tTwpBqfwFHIljbCX79mCO
        AiJZA=; b=ZPvbGrsJss2WNnq67nC9l7XSwQQbFWa4P2LIJzgvTUPcRA93BQm/ZZ
        T6U6ZFfdjcgXI4Ur5JcA0kTfdCMs4KOMZu18PJO/B1YGejkDmcM8J9Sov24zQeRd
        sv36+fzLGzb/87ALthI2qWsia9ZjX+bZPrWwLvXQPVMd/rrx7PfDs=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0C9C5FA6A5;
        Mon, 25 Oct 2021 20:45:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 6D865FA6A4;
        Mon, 25 Oct 2021 20:45:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 2/4] remote: use remote_state parameter internally
References: <kl6lbl3c7lsa.fsf@chooglen-macbookpro.roam.corp.google.com>
Date:   Mon, 25 Oct 2021 17:45:56 -0700
In-Reply-To: <kl6lbl3c7lsa.fsf@chooglen-macbookpro.roam.corp.google.com> (Glen
        Choo's message of "Mon, 25 Oct 2021 16:00:05 -0700")
Message-ID: <xmqqfssozk8r.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1525EA84-35F6-11EC-8620-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Glen Choo <chooglen@google.com> writes:

>> If the answer is yes, then the function need to take both branch and
>> remote_state as two separate parameters.  If the answer is no (i.e.
>> we never ask hypothetical questions, we just ask what we should do
>> in the current, real, state), then the function can just take the
>> remote_state and remote_state->branch being NULL would be used as a
>> signal that the HEAD is detached.  I suspect it is the former, as
>> this information is used in string-name-to-object translation for
>> "topic@{push}" in object-name.c::interpret_branch_mark() function.
>
> I agree that the need for hypothetical "what happens if HEAD were
> detached?" questions may arise, though I'm not sure if there are any
> right now. When we call branch_get(NULL), the expected return value is
> the "current_branch". If there is no "current_branch" i.e. the return
> value of branch_get() is the NULL branch. A NULL branch is not usable -
> branch_get_push() and branch_get_upstream() return error messages
> indicating "HEAD does not point to a branch". (these are the functions
> used by object-name.c::interpret_branch_mark()).
>
> Given the convention of "NULL branch == detached HEAD", how do we
> proceed? Some options:
>
> a) Represent detached HEAD with a non-NULL "struct branch". This will
>    let us continue using the remote_state backpointer, which makes many
>    interfaces clean, but is somewhat invasive, error-prone and it uses
>    "struct branch" for something that is not a branch, which is itself
>    an error-prone interface.

I'd rather not to go there.

> b) Keep the backpointer, but add remote_state as a parameter to
>    pushremote_for_branch(). The least possible effort to fix the problem
>    and might be 'easy' but is inconsistent with the other functions and
>    is prone to misuse because the backpointer and parameter can be
>    different.

Make the function take a remote_state as a parameter (instead of,
not in addition to, the branch parameter), and use the remote_state
structure to find which branch's branch specific configuration we
want to use by checking its current_branch member.

I think that would be the best approach for "no, we won't ask
hypothetical question" case.

On the other hand,...

> c) Replace the backpointer with a remote_state parameter. Expressive and
>    fits the paradigm of "defaulting to the repo when needed", but
>    interfaces are repetitive and shifts the responsibility of
>    correctness to the caller (see v2).

... if we want to support the what-if callers, I
think the best approach would be a slight variant of c) above.

That is, pass branch and remote_state as two parameters, and when
branch is not NULL, barf if it is not among remote_state.branches[],
to protect against nonsense combinations.

Thanks.
