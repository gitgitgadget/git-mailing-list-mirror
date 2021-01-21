Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83773C433E6
	for <git@archiver.kernel.org>; Thu, 21 Jan 2021 23:28:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3307222CAE
	for <git@archiver.kernel.org>; Thu, 21 Jan 2021 23:28:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726030AbhAUX2U (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jan 2021 18:28:20 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:59728 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726597AbhAUX2I (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jan 2021 18:28:08 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 8CB54A00CE;
        Thu, 21 Jan 2021 18:27:23 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=raQEqTnX/hiUyGBygH6lG1q9jD0=; b=UdrFyT
        0lwC5qL7QWpinrHfbnYJb5sbOUfyYLCz+2K4bWLvMBBtozOo1/M8GrZy1Sn0zxNe
        nC8BIehmfpUyZESksZGA+We44+skKjyKLEPBviM/obJAi62c7hbEjkXCyHzQesJ0
        mlU8qwSWIT8LNMrjxkXQJBIVZIh1z72P3rL2w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=ISWn5vhvS6a7YPjUJJ86kaPF+SpEPBsp
        X+feayGu91Bm2479CqF/9ZLrI3/YIEjUx53uWYLazuOAPcqFykwjLAurpHIRrT4t
        mBdQiH8tpyD8mQfHLpjI7cPgubXT6ryaYAPzrTxgwC0B5vMpEGsI6OUVo/1/Fazg
        Pd6laKEu+Qg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 83B64A00CD;
        Thu, 21 Jan 2021 18:27:23 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.36.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 08B6BA00CC;
        Thu, 21 Jan 2021 18:27:23 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 1/3] range-diff: refactor check for commit range
References: <pull.841.git.1611267638.gitgitgadget@gmail.com>
        <5839ba4f7615819ed6f9a0fcb6de1855cd2e89e1.1611267638.git.gitgitgadget@gmail.com>
Date:   Thu, 21 Jan 2021 15:27:22 -0800
In-Reply-To: <5839ba4f7615819ed6f9a0fcb6de1855cd2e89e1.1611267638.git.gitgitgadget@gmail.com>
        (Johannes Schindelin via GitGitGadget's message of "Thu, 21 Jan 2021
        22:20:36 +0000")
Message-ID: <xmqq7do5c1lx.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 36B63EAA-5C40-11EB-B391-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> Currently, when called with exactly two arguments, we test for a literal
> `..` in each of the two.
>
> However, `<commit>^!` is a perfectly valid commit range, equivalent to
> `<commit>^..<commit>` according to the `SPECIFYING RANGES` section of
> gitrevisions[7].
>
> In preparation for allowing more sophisticated ways to specify commit
> ranges, let's refactor the conditional into its own function.

Makes sense.
