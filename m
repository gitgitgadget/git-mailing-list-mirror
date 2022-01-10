Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F04E2C433EF
	for <git@archiver.kernel.org>; Mon, 10 Jan 2022 19:14:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243478AbiAJTOn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Jan 2022 14:14:43 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60084 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232564AbiAJTOn (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jan 2022 14:14:43 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 47B3D1022E1;
        Mon, 10 Jan 2022 14:14:42 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=N+HbWx8AbbhEMtDB8zMnaO7gPQJ+91AuTJ8CNZ
        Lrrgo=; b=JdA8MXvPGiT2zyIsvS/EgZeT+3AKltJL0AlwEib2DRl6Wr38kNEhMO
        tW48s75UNCZd1gJ0P9yW7V1DcjjaGgtKr9AVpg9TkHsRwlGZ5shHw305iFlNAeIS
        EWz/4Aomw2T7XNVAapCgD0zipdE5r5aUApZbsa+bpbzESmr0JYk1M=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3ECEB1022E0;
        Mon, 10 Jan 2022 14:14:42 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 936421022DF;
        Mon, 10 Jan 2022 14:14:41 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Han-Wen Nienhuys <hanwen@google.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>
Subject: Re: [PATCH 3/3] reftable: support preset file mode for writing
References: <pull.1164.git.git.1640287790.gitgitgadget@gmail.com>
        <c01b1c335a33e5f44289c520a1634d071d882223.1640287790.git.gitgitgadget@gmail.com>
        <xmqqsfui4nkr.fsf@gitster.g>
        <CAFQ2z_MEN2j-sHmGK4SA6N8P9bHvjO2=+G0XxXp_9vzLRxwKuw@mail.gmail.com>
Date:   Mon, 10 Jan 2022 11:14:40 -0800
In-Reply-To: <CAFQ2z_MEN2j-sHmGK4SA6N8P9bHvjO2=+G0XxXp_9vzLRxwKuw@mail.gmail.com>
        (Han-Wen Nienhuys's message of "Mon, 10 Jan 2022 20:01:54 +0100")
Message-ID: <xmqqk0f7z9lr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9007125C-7249-11EC-8D46-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Han-Wen Nienhuys <hanwen@google.com> writes:

> On Fri, Dec 24, 2021 at 5:46 AM Junio C Hamano <gitster@pobox.com> wrote:
>> >       if (add->lock_file_fd < 0) {
>> >               if (errno == EEXIST) {
>> >                       err = REFTABLE_LOCK_ERROR;
>> > @@ -478,6 +478,13 @@ static int reftable_stack_init_addition(struct reftable_addition *add,
>> >               }
>> >               goto done;
>> >       }
>> > +     if (st->config.default_permissions) {
>> > +             if (chmod(add->lock_file_name.buf, st->config.default_permissions) < 0) {
>> > +                     err = REFTABLE_IO_ERROR;
>> > +                     goto done;
>>
>> This part does not exactly make sense, though.
>
> why?

Explained in the part that follows that statement in the message you
are responding to.

> I read over the adjust_shared_perm function for a bit, but I'm puzzled
> why its complexity is necessary. It seems to do something with X-bits,
> maybe for directories, but that doesn't apply here as we're only
> handling files?

We are propagating executable bit, which affects both directories
and files.

> We also only write new files, so we never have to look at the existing
> mode of a file.

It is mostly about defeating the umask of whoever is esecuting "git".
