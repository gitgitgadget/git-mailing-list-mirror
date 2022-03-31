Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3095C433F5
	for <git@archiver.kernel.org>; Thu, 31 Mar 2022 18:05:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233417AbiCaSH2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Mar 2022 14:07:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232396AbiCaSHZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Mar 2022 14:07:25 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78C241F1276
        for <git@vger.kernel.org>; Thu, 31 Mar 2022 11:05:36 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4F21F112ACB;
        Thu, 31 Mar 2022 14:05:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=VZgqgkG3Aim55wRvMMjB+RDJ8yUFOgQIuEcf1e
        kFvNY=; b=yQXV8fB9aqIHhIlLIvKzSOpTmfLteTtfQqsMSw/Wu//NxJgkYPX9Cq
        p+qisnl0TNZVd4ZZuJ1V4CemG7A6Xn2LYNsTLE8jjanZylb0l6kIXCnc1wYJIs9e
        AOhTeSF3YNvhHBD7c/0FHpLZjnPPiveBZkqn/RIYs2KylvngskMo4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 455F3112ACA;
        Thu, 31 Mar 2022 14:05:36 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.227.145.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A6B23112AC9;
        Thu, 31 Mar 2022 14:05:35 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Neeraj Singh <nksingh85@gmail.com>
Cc:     Neeraj Singh via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Patrick Steinhardt <ps@pks.im>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Jiang Xin <worldhello.net@gmail.com>,
        "Neeraj K. Singh" <neerajsi@microsoft.com>
Subject: Re: [PATCH v5 04/14] core.fsyncmethod: batched disk flushes for
 loose-objects
References: <pull.1134.v4.git.1648514552.gitgitgadget@gmail.com>
        <pull.1134.v5.git.1648616734.gitgitgadget@gmail.com>
        <9e7ae22fa4a2693fe26659f875dd780080c4cfb2.1648616734.git.gitgitgadget@gmail.com>
        <xmqq4k3f9w9s.fsf@gitster.g>
        <CANQDOdd-G0VHOKWjWQL75jAJ7Az4izB33HKzayqnk-F-nkHj_A@mail.gmail.com>
Date:   Thu, 31 Mar 2022 11:05:34 -0700
In-Reply-To: <CANQDOdd-G0VHOKWjWQL75jAJ7Az4izB33HKzayqnk-F-nkHj_A@mail.gmail.com>
        (Neeraj Singh's message of "Wed, 30 Mar 2022 23:28:56 -0700")
Message-ID: <xmqqtube2e1d.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 29E9F40E-B11D-11EC-BC8F-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Neeraj Singh <nksingh85@gmail.com> writes:

> To describe the above if it doesn't render correctly, we have a
> bulleted list where the batch after the * is bolded.  Other instances
> of single backtick quoted text just appears as plaintext. The
> descriptive "Currently `batch` mode..." paragraph is under the bullet
> point and well-indented.
>
> In HTML the output looks good as well, except that the descriptive
> paragraph is in monospace for some reason.

The "except" part admits that it does not render well, no?

What happens if you modify the second and subsequent paragraph after
the "+" continuation in the way suggested?  Does it make it worse,
or does it make it worse?

> Keeping fsync separate from packfile should help the reader see that
> the two sets of functions access only their respective global state.
> If we add another optimization strategy (e.g. appendable pack files),
> it would get its own separate state and functions that are independent
> of the large-blob packfile and loose-object fsync optimizations.

OK.

>> > +void fsync_loose_object_bulk_checkin(int fd, const char *filename)
>> > +{
>> > +     /*
>> > +      * If we have an active ODB transaction, we issue a call that
>> > +      * cleans the filesystem page cache but avoids a hardware flush
>> > +      * command. Later on we will issue a single hardware flush
>> > +      * before as part of do_batch_fsync.
>> > +      */
>> > +     if (!bulk_fsync_objdir ||
>> > +         git_fsync(fd, FSYNC_WRITEOUT_ONLY) < 0) {
>> > +             fsync_or_die(fd, filename);
>> > +     }
>> > +}
>>
>> Ah, if we have successfully created the temporary directory, we
>> don't do full fsync but just writeout-only one, so there is no need
>> for the worry I mentioned in the previous paragraph.  OK.
>
> There is the possibility that we might create the objdir when calling
> prepare_loose_object_bulk_checkin but somehow fail to write the object
> and yet still make it to end_odb_transaction.  In that case, we'd
> issue an extra dummy fsync.  I don't think this case is worth extra
> code to track, since it's a single fsync in a weird failure case.

Yup.
