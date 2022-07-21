Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97DDCC433EF
	for <git@archiver.kernel.org>; Thu, 21 Jul 2022 20:06:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231853AbiGUUG3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jul 2022 16:06:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233582AbiGUUGK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jul 2022 16:06:10 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0694D8EEE0
        for <git@vger.kernel.org>; Thu, 21 Jul 2022 13:05:55 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D6A501ADE6F;
        Thu, 21 Jul 2022 16:05:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=BmHwipAST9JoPIMOc/cSZNeF2D0bI/jGMQCjio
        cbeHM=; b=QLQkREUOyd4vyA4DF/l2sbIwip73ycXN846g15eq6tJzFvEGcCFJB6
        Hs7kaCwWOdweHNG3UdMiQ8ZpZ/x+kMwD5+XCxEqnNavZ2U/nUSeB8HMaBX80edD4
        4BeQAJ9CDna7VuV/RUJhVEU994myQ7TSrerw4X85fy+Si8RS1G8MA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id CF70E1ADE6E;
        Thu, 21 Jul 2022 16:05:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.40.190])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 7C6A91ADE6C;
        Thu, 21 Jul 2022 16:05:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        ZheNing Hu <adlternative@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v3 1/7] merge-ort-wrappers: make printed message match
 the one from recursive
References: <pull.1231.v2.git.1655621424.gitgitgadget@gmail.com>
        <pull.1231.v3.git.1658391391.gitgitgadget@gmail.com>
        <e39b2e15ece14ba2b1118ae95e0d90ed60589b41.1658391391.git.gitgitgadget@gmail.com>
        <xmqqsfmulb6w.fsf@gitster.g>
        <CABPp-BEddgN5QmFkfejC6jZXMAGTivQBtV8YQ8Jq0EZzPhAM8Q@mail.gmail.com>
Date:   Thu, 21 Jul 2022 13:05:50 -0700
In-Reply-To: <CABPp-BEddgN5QmFkfejC6jZXMAGTivQBtV8YQ8Jq0EZzPhAM8Q@mail.gmail.com>
        (Elijah Newren's message of "Thu, 21 Jul 2022 12:51:50 -0700")
Message-ID: <xmqq1quegrj5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 8525B3A6-0930-11ED-86C6-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> On Thu, Jul 21, 2022 at 8:47 AM Junio C Hamano <gitster@pobox.com> wrote:
>>
>> "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
>>
>> >       if (head && repo_index_has_changes(opt->repo, head, &sb)) {
>> > -             fprintf(stderr, _("Your local changes to the following files would be overwritten by merge:\n  %s"),
>> > +             struct strbuf err = STRBUF_INIT;
>> > +             strbuf_addstr(&err, "error: ");
>> > +             strbuf_addf(&err, _("Your local changes to the following files would be overwritten by merge:\n  %s"),
>> >                   sb.buf);
>> > +             strbuf_addch(&err, '\n');
>> > +             fputs(err.buf, stderr);
>> > +             strbuf_release(&err);
>>
>> Makes me wonder why this is not a mere
>>
>>         error(_("Your local chagnes ... by merge:\n  %s"), sb.buf);
>>
>> that reuses the exact string.  The err() function in merge-recursive.c
>> is strangely complex (and probably buggy---if it is not buffering
>> output, it adds "error: " prefix to opt->obuf before calling vaddf
>> to add the message, and then sends that to error() to give it
>> another "error: " prefix), but all the above does is to send a
>> message to standard error stream.
>
> Ah, that would be nicer; thanks for the pointer.  I would still need
> to prefix it with an
>     strbuf_addch(&sb, '\n');
> but two lines certainly beats six.

Your "strbuf" version uses the same format string as my error()
thing and then manually add one LF at the end, before sending it to
fputs(), which, unlike puts() does not add any extra LF at the end.

error() gives a terminating newline at the end.

Do you still need to add one more?
