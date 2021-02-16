Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF117C433E0
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 01:48:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A399664DAF
	for <git@archiver.kernel.org>; Tue, 16 Feb 2021 01:48:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbhBPBsX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Feb 2021 20:48:23 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:60501 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbhBPBrk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Feb 2021 20:47:40 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9B2BA113050;
        Mon, 15 Feb 2021 20:46:52 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=tmrEfKsKPkapEiPmOk3qn1xg56U=; b=b9XYKM
        qDBdnPfQbEp38uKBxdI93aULDiWFqnOEyn41hZUXoZZYsr75Op3M81sHCpjbc4bs
        eY31JAldHMqqvb+ga0eA9kgkVm0icbq0JnZhaXFQ4i8BGBoAgUmIEjnAFajJaAkQ
        boQ5Oqmm4/Me8DTBFRezS2NnOxXywoRf3SN8E=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=WPj4zRvqi99LarGHTn8xB/KKOwb5QpgF
        J4u9G7JHLqNqMomVgQ3nEw64jF/lWa/GyOLg8J4rHd7qgHmcLO2qtz0fpStol2/W
        JE3og2E+kliLUPqB2TlPGxEO1KTVCwd6pL7vixBCbN1HhJF3j4PXNf7HdjlLRbpZ
        opBWocPkTcs=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 9386F11304F;
        Mon, 15 Feb 2021 20:46:52 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.243.138.161])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id D370E11304E;
        Mon, 15 Feb 2021 20:46:49 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Denton Liu <liu.denton@gmail.com>,
        David Aguilar <davvid@gmail.com>,
        John Keeping <john@keeping.me.uk>,
        Ryan Zoeller <rtzoeller@rtzoeller.com>,
        ZheNing Hu <adlternative@gmail.com>
Subject: Re: [PATCH v4] difftool.c: learn a new way start at specified file
References: <pull.870.v3.git.1612884654078.gitgitgadget@gmail.com>
        <pull.870.v4.git.1613308167239.gitgitgadget@gmail.com>
Date:   Mon, 15 Feb 2021 17:46:48 -0800
In-Reply-To: <pull.870.v4.git.1613308167239.gitgitgadget@gmail.com> (ZheNing
        Hu via GitGitGadget's message of "Sun, 14 Feb 2021 13:09:26 +0000")
Message-ID: <xmqqy2foss1j.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D60F4D5E-6FF8-11EB-930B-E43E2BB96649-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: ZheNing Hu <adlternative@gmail.com>
>
> `git difftool` only allow us to select file to view in turn.
> If there is a commit with many files and we exit in the search,
> We will have to traverse list again to get the file diff which
> we want to see. Therefore, here is a new method: user can use
> `git difftool --start-from=<filename>` to start viewing from
> the specified file, This will improve the user experience.

It appears that you seem to have based this patch on my "if we were
to make 'git diff' help you by adding to diffcore pipeline, it would
look like this" illustration patch.

But I later sent a real version of "diff --rotate-to/--start-at"
patch (and Cc'ed you, IIRC).

  https://lore.kernel.org/git/xmqqo8gqwasu.fsf@gitster.c.googlers.com/

Please build on top of that patch instead.  E.g.

    $ git fetch
    $ git checkout -b zh/difftool-start-at fb4bfd0f8b

then work on that topic branch, perhaps.  You do not have to (and
you do not want to) include my changes to your patches.

Thanks.
