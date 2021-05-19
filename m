Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A956BC433ED
	for <git@archiver.kernel.org>; Wed, 19 May 2021 01:25:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79B7761001
	for <git@archiver.kernel.org>; Wed, 19 May 2021 01:25:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232462AbhESB0x (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 May 2021 21:26:53 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58052 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231689AbhESB0u (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 May 2021 21:26:50 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9E5F5D0C45;
        Tue, 18 May 2021 21:25:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Znw7caBh25TmSMApOPzQ40cHDE0sfpfJ6AtioG
        qk9Y4=; b=DPapLvqE9IrLt+OQhhK8L/tQi0C2YP0L4FbIaL1pzOM2Te0l76iX8B
        gazsbl9ZIhl8mKdODAlM1iKQjmY1GQYWaW2p+0eH8MP1WpYkyMDmW8PbI7luBJKL
        4m6blUKqXEH6BXKpmKqyJpV8PsyUGffoOtVfwqBXPR5+R3cQ/RfKo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 946EFD0C43;
        Tue, 18 May 2021 21:25:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 12A45D0C42;
        Tue, 18 May 2021 21:25:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Denton Liu <liu.denton@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH] stash show: don't setup default diff output format if
 --{include,only}-untracked given
References: <76dfa90a32ae926f7477d5966109f81441eb2783.1621325684.git.liu.denton@gmail.com>
Date:   Wed, 19 May 2021 10:25:30 +0900
In-Reply-To: <76dfa90a32ae926f7477d5966109f81441eb2783.1621325684.git.liu.denton@gmail.com>
        (Denton Liu's message of "Tue, 18 May 2021 01:15:38 -0700")
Message-ID: <xmqq35uj1pmd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 19D8C9E4-B841-11EB-93E6-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Denton Liu <liu.denton@gmail.com> writes:

> When `git stash show` is given no arguments, it will pass `--stat` to
> `git diff` by default. When any argument is given, `--stat` is no longer
> passed by default.
>
> When `git stash show` learned the `--include-untracked` and
> `--only-untracked` options, it failed to retain the same behaviour of
> not passing `--stat` by default.
>
> This isn't necessarily incorrect since with other arguments, they're
> passed through directly to `git diff` which means it wouldn't make sense
> to pass `--stat` as well. With `--include-untracked` and
> `--only-untracked`, they are handled by `git stash show` directly
> meaning we don't necessarily have this conflict. However, this would be
> unintuitive for users since the existing behaviour seems to be that if
> any arguments are given, `--stat` will not be given by default.

But even for users who do not care about the implementation, the
options that affect "What to show" and "How to show them" are easily
distinguishable at the conceptual level, no?  When showing stash
without telling the command what or how to show, we omit untracked
part by default, and we show only diffstat by default.  When we tell
it to show also/only untracked, it is unclear if it is confusing or
natural to average users if that affects how the chosen part of the
stash gets shown.

Showing untracked will be a new feature in the upcoming release, so
we may want to either (1) revert the whole thing before we can agree
on the desired behaviour or (2) clarify in the document that what to
show and how to show them are two orthogonal axes with their own
default that are orthogonal to avoid the "confusion" you are trying
to address with this patch.

