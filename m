Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCFB7C07E96
	for <git@archiver.kernel.org>; Tue,  6 Jul 2021 19:42:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9EF361A14
	for <git@archiver.kernel.org>; Tue,  6 Jul 2021 19:42:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229811AbhGFTpE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Jul 2021 15:45:04 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:52562 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229730AbhGFTpE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jul 2021 15:45:04 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A57EB148F0E;
        Tue,  6 Jul 2021 15:42:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ib7SXokBeWZA5CB1GGwYnJnH1FMflMVTbXNT6d
        uWQLE=; b=O8RUrgHHq7zJYXFUdMLOAUqXQemd7R6sGTFmoe97klsPujRftvy0qH
        a1UEaWN+rEv8KBRAcd/c28o2ahoHvoP4Ztyg0jkzyNAsvytnDl3tRkuvBFRRyHXD
        Iu9NVikRQXnW7sah5b5QyAstAfi9jyeHWRpjjqW7zPqkixbySh42M=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 9D464148F0D;
        Tue,  6 Jul 2021 15:42:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 0C3A1148F0C;
        Tue,  6 Jul 2021 15:42:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Stephen Manz via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Stephen Manz <smanz@alum.mit.edu>
Subject: Re: [PATCH] worktree: teach `add` to accept --reason <string> with
 --lock
References: <pull.992.git.1625550451038.gitgitgadget@gmail.com>
        <CAPig+cSsPrQrP9xk8M8H339_NpYqKh1okeo1V-fAJ2zk3QeOjQ@mail.gmail.com>
Date:   Tue, 06 Jul 2021 12:42:21 -0700
In-Reply-To: <CAPig+cSsPrQrP9xk8M8H339_NpYqKh1okeo1V-fAJ2zk3QeOjQ@mail.gmail.com>
        (Eric Sunshine's message of "Tue, 6 Jul 2021 02:19:43 -0400")
Message-ID: <xmqq7di3jkki.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 48AA8010-DE92-11EB-A110-FA9E2DDBB1FC-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Sunshine <sunshine@sunshineco.com> writes:

>>  --reason <string>::
>> +       With `lock` or with `add --lock`, an explanation why the working tree is locked.
>
> I realize that you're mimicking the interface of `git worktree lock`
> which accepts an optional `--reason`, but I'm wondering if the
> user-experience might be improved by instead allowing `--lock` to
> accept the reason as an optional argument. For instance:
>
>     git worktree add --lock='just because' ...

Thanks for thinking aloud, but I'd prefer the interface as posted,
simply because there is one less thing for users to remember.  The
justification to lock is given with the --reason=<why> argument no
matter how you acquire the lock on a worktree.


>> diff --git a/builtin/worktree.c b/builtin/worktree.c
>> @@ -31,6 +31,7 @@ struct add_opts {
>>         int checkout;
>>         int keep_locked;
>> +       const char *lock_reason;
>>  };
>
> Whether or not we do go with the approach of allowing `--lock` to take
> the reason as an optional argument, we don't really need two structure
> members here. Instead, we can repurpose `keep_locked` as a `const char
> *` which is NULL if `--lock` was not specified, otherwise non-NULL.

Makes sense.

> However, in this case, it should probably just be a simple `else if`:
>
>     if (!opts->keep_locked)
>         write_file(sb.buf, "initializing");
>     else if (opts->lock_reason)
>         write_file(sb.buf, "%s", opts->lock_reason);
>     else
>         write_file(sb.buf, _("added with --lock"));

Excellent.

Thanks.
