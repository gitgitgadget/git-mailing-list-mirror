Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEE81C433F5
	for <git@archiver.kernel.org>; Wed, 24 Nov 2021 18:53:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244434AbhKXS4x (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Nov 2021 13:56:53 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55491 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236702AbhKXS4w (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Nov 2021 13:56:52 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 15DB8FA191;
        Wed, 24 Nov 2021 13:53:42 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=6VI8frcgB59nrRQzpESgdylCf6WRKAboSTyELQ
        M3xFg=; b=J8Zwv4yhrYyrneG2yZ8PS9EQ4ahdUwoelhQ4tCLyfTVYv8uDxQDe6M
        CW1cvNudwr157QUWrH4FLDwNXvuxS3oqKM5bvLrvppf/8e6KHD5hjgvWC/rG2OB+
        Xkh1GctqIGWnS24Q6QCCy6wX2ZwIF4rLoOHyjq5jcGlym+cRkMED0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 0B959FA190;
        Wed, 24 Nov 2021 13:53:42 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 70411FA18F;
        Wed, 24 Nov 2021 13:53:41 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH 2/4] refs: trim newline from reflog message
References: <pull.1145.git.git.1637590855.gitgitgadget@gmail.com>
        <dfb639373234a6b8d5f9110380a66ffccbe0b1d6.1637590855.git.gitgitgadget@gmail.com>
        <xmqq35nnddw7.fsf@gitster.g>
        <CAFQ2z_PE7TMj=qfQVroK_gRfZk-xF9PKhk2yxqF-bB+2aA7eoQ@mail.gmail.com>
        <xmqqczmqajdk.fsf@gitster.g>
        <CAFQ2z_Mct+KBZ3vO6udwqeiHYA8od8CGH_w5BO5LaidP-AYDsg@mail.gmail.com>
        <xmqqzgpu7grv.fsf@gitster.g>
        <CAFQ2z_Mb+NzQfXfMhdQoPs09p2j1AWRAdXcX3JSznn+H9+T0Bw@mail.gmail.com>
Date:   Wed, 24 Nov 2021 10:53:40 -0800
In-Reply-To: <CAFQ2z_Mb+NzQfXfMhdQoPs09p2j1AWRAdXcX3JSznn+H9+T0Bw@mail.gmail.com>
        (Han-Wen Nienhuys's message of "Wed, 24 Nov 2021 12:17:04 +0100")
Message-ID: <xmqqpmqp2xmz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D7829442-4D57-11EC-93C8-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Han-Wen Nienhuys <hanwen@google.com> writes:

>> ...  Doesn't the ref backend already ensure that
>> the message is not an incomplete line?  If you feed a single
>> complete line when updating, I do not think the backend should add
>> any extra LF relative to the given message:
>
> But it does, currently. As of
>
>   commit 523fa69c36744ae6779e38614cb9bfb2be552923
>   Author: Junio C Hamano <gitster@pobox.com>
>   ..
>   - We expect that a reflog message consists of a single line.  The
>        file format used by the files backend may add a LF after the
>
> it is the job of the files ref backend to add a LF, and the input to
> the ref backend is a string without trailing LF. But the files backend
> then produces that message with a LF, when reading back the data, eg.

Ah, perhaps our confusion comes from the fact that I view the ref
API as a whole and do not draw a fine line of distinction between
the "ref API implementation common across backends" vs "what ref
files backend does".  But as the implementor of one backend, you
obviously have to care.

In any case, when I did that commit, I clearly meant that the
normalization implemented by the patch belong to the common part to
be used by all backends for uniform handling of refs.  If a call to
refs API in a repository that is configured to use reftable backend
bypasses the normalization function introduced in that commit, that
is a bug.

So, yes "ref API ensures that the message is not an incomplete line
to turn 0, 1, or multiple lines input into a single line", which is
why the experiments you omitted from your quote (reproduced here)

    $ git update-ref -m 'creating a new branch manually
    ' refs/heads/newtest master
    $ git update-ref -m 'updating a new branch manually
    ' refs/heads/newtest master~1
    $ git reflog refs/heads/newtest
    4150a1677b refs/heads/newtest@{0}: updating a new branch manually
    5f439a0ecf refs/heads/newtest@{1}: updating the reference

to give a complete line when recording the reflog entries does not
result in an extra LF shown on the output.

>> I think the rule for "msg" is that:
>>
>>    a multi-line message, or a message on a single incomplete-line,
>>    are normalized into a single complete line, and callback gets a
>>    single complete line.
>
> That is not how it works today. The files backend verbatimly dumps the
> message supplied to it. (Maybe it should crash if there is a '\n' in
> the message).

As I said, if parts of refs API implementation forgets to call
normalization, it is a bug.  Is there different codepath other than
the one that is exercised with the "git update -m ''" experiment
above and you found such a bug there?  It needs to be fixed.

Thanks.
