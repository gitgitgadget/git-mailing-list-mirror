Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4EC6C4338F
	for <git@archiver.kernel.org>; Tue, 10 Aug 2021 18:36:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B798C60EB2
	for <git@archiver.kernel.org>; Tue, 10 Aug 2021 18:36:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbhHJShA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Aug 2021 14:37:00 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:51773 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbhHJSg6 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Aug 2021 14:36:58 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 489DE150D5B;
        Tue, 10 Aug 2021 14:36:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=2R3p+4C4+oh0mtKI4mRo2kMj5WixwMhduUfB9N
        ZvxcI=; b=pqLMqM6bIVp7YqJFzeIEMKExvn+BbIdhapT3NahIJVzdvOU1rW108h
        IgdfzZKEutqTHxn7XMnWpZ9pCTk8WOxwJUyxJ0wnB8mg4Sa4ldl+3wFJ5WMWNODC
        YLgOpJZXj3nFi4GATNiI2DFMRgBwz2bBHUDbxDIY8KZrw0EHhVpQw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 4112C150D5A;
        Tue, 10 Aug 2021 14:36:33 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 8CD75150D59;
        Tue, 10 Aug 2021 14:36:30 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Mahi Kolla <mahikolla@google.com>
Cc:     Mahi Kolla via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Philippe Blain <levraiphilippeblain@gmail.com>
Subject: Re: [PATCH v4] clone: update submodule.recurse in config when using
 --recurse-submodule
References: <pull.1006.v3.git.1627946590.gitgitgadget@gmail.com>
        <pull.1006.v4.git.1628536305810.gitgitgadget@gmail.com>
        <xmqqzgtqe2w6.fsf@gitster.g>
        <CAN3QUFYPjsvBRGegO-kC7+gcFDczOqQSw-UYphnLHx=6-6kkwA@mail.gmail.com>
Date:   Tue, 10 Aug 2021 11:36:28 -0700
In-Reply-To: <CAN3QUFYPjsvBRGegO-kC7+gcFDczOqQSw-UYphnLHx=6-6kkwA@mail.gmail.com>
        (Mahi Kolla's message of "Tue, 10 Aug 2021 00:26:01 -0700")
Message-ID: <xmqqa6lpdu4z.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: E14441B6-FA09-11EB-92A1-D5C30F5B5667-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Mahi Kolla <mahikolla@google.com> writes:

>> Is it possible to avoid changing the behaviour unconditionally and
>> potentially breaking existing users by making it an opt-in feature,
>> e.g. "git clone --recurse-submodules" would work as the current
>> users would expect, while "git clone --recurse-submodules=sticky"
>> would set submodule.recurse to true, or something?
>
> As mentioned, the `submodule.recurse=true` will only apply to active
> submodules specified by the user. Setting this config value when the
> user runs their initial `git clone` minimizes the number of times a
> developer must use the `--recurse-submodule` option on other commands.
>
> However, this is a behavior change that may be surprising for
> developers. To ensure a smooth rollout and easy adoption, I think
> adding a message using an `advice.*` config setting would be useful.

It may be better than nothing, but that still is a unilateral
behaviour change.  Can't we come up with a way to make it an opt-in
feature?  I've already suggested to allow the "--recurse-submodules"
option of "git clone" to take an optional parameter (e.g. "sticky")
so that the user can request configuration variable to be set, but
you seem to be ignoring or skirting it.  Even though I am not
married to the "give optional parameter to --recurse-submodules"
design, unconditionally setting the variable, with or without advice
or warning, is a regression we'd want to avoid.

