Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5322DC433DB
	for <git@archiver.kernel.org>; Thu,  4 Feb 2021 18:59:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 183CF64F5E
	for <git@archiver.kernel.org>; Thu,  4 Feb 2021 18:59:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239279AbhBDS5o (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Feb 2021 13:57:44 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:61214 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239222AbhBDS4x (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Feb 2021 13:56:53 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 661591228AE;
        Thu,  4 Feb 2021 13:56:11 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=XT6kYgDXlbadcH7I9DzZMcjMEDs=; b=Mq6FQp
        UxLy6+GalBZLZl8uWuYUs5Z777+ETEoYPKoGuYBPinkExlfp0gBC7oK0bJlJAKYd
        WEdPxFCdhcm5GXgQiKYmzN+GlUZzkYB4JJP/rMszJs/wKQenbAkEqzGnFh/2XWwC
        pIPFFgr4NfP3C673LnlShOFECwMK3a23PALWw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=q5aoXVMucA+XXwh/BvNrPNBORrtwWQX8
        Bm3FFSQahLqmAUeOVdPyqMVCx7v/QI4wzhiRVSNt2aUO5Gu8E+v4xvc8lT3EdYKn
        IcKNDdnQ3KldHH3bDLIZeSDL+S7G4z0QViQ6f94bW5J3+sJsE0tHAm/wF0RxxMly
        OkgQOdQv89s=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 5F63E1228AD;
        Thu,  4 Feb 2021 13:56:11 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id A90281228AB;
        Thu,  4 Feb 2021 13:56:08 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v4 1/3] range-diff/format-patch: refactor check for
 commit range
References: <pull.841.v3.git.1611765444.gitgitgadget@gmail.com>
        <pull.841.v4.git.1612431093.gitgitgadget@gmail.com>
        <b98fa94b87037b811ea973c1aeb7cfe08d7c1bd6.1612431093.git.gitgitgadget@gmail.com>
Date:   Thu, 04 Feb 2021 10:56:06 -0800
In-Reply-To: <b98fa94b87037b811ea973c1aeb7cfe08d7c1bd6.1612431093.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Thu, 04 Feb 2021
        09:31:30 +0000")
Message-ID: <xmqqy2g364s9.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A43B1EF2-671A-11EB-A4BB-D609E328BF65-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> diff --git a/range-diff.h b/range-diff.h
> index 583ced2e8e74..c17dbc2e75a8 100644
> --- a/range-diff.h
> +++ b/range-diff.h
> @@ -16,4 +16,12 @@ int show_range_diff(const char *range1, const char *range2,
>  		    const struct diff_options *diffopt,
>  		    const struct strvec *other_arg);
>  
> +/*
> + * Determine whether the given argument is usable as a range argument of `git
> + * range-diff`, e.g. A..B. Note that this only validates the format but does
> + * _not_ parse it, i.e. it does _not_ look up the specified commits in the
> + * local repository.
> + */
> +int is_range_diff_range(const char *arg);

If we were to use [v4 2/3], then we do parse it, even though we do
use the parse result to reject some valid ranges (like "a history
all the way down to root" in the implementation).  I think just
dropping everything after "Note that" is a sufficient fix.

