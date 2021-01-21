Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CAC7C433DB
	for <git@archiver.kernel.org>; Thu, 21 Jan 2021 23:00:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2203B23A3A
	for <git@archiver.kernel.org>; Thu, 21 Jan 2021 23:00:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726013AbhAUXAh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jan 2021 18:00:37 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61376 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726149AbhAUXAZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jan 2021 18:00:25 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1B50FB4178;
        Thu, 21 Jan 2021 17:59:37 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=3KZCEtWKqX5hYkIBauMP8mQu2dQ=; b=UATJwk
        VgNZBXRbA0vIbA5GexonTYsT8HayoFdP6e7t1PkRXE4M1Uk/l4tKSrkDdx8dN8g9
        bsHUZl+J66AqnFfkVb36M1mQiZcZfecrehUPvV4Y0uB+Pr2sB0+U73RDqKpCZmeC
        zxSJ1x8frl8ytBqzOc+/g7pUCL1pSFsP2YRJ8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=N1QLDF5p8D8OeotkTiVoZue4aAqoWYLQ
        jNLW79cSQNq+qOfr+hkIULEAT5wqXbhMjozPeRSl1pTRkF+yfnQ+Gd0xRyb1N1tN
        wjzHNi/z8HbVdBRn9+1ju5xc/WfaxnxaOAOmIP0bFJR/Es9h/5jcm+Y4yccu/nZY
        LQGgw4DUTiE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 12AACB4177;
        Thu, 21 Jan 2021 17:59:37 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.196.36.241])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 86AA0B4176;
        Thu, 21 Jan 2021 17:59:36 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] SKIP_DASHED_BUILT_INS: respect `config.mak`
References: <pull.840.git.1611234585889.gitgitgadget@gmail.com>
Date:   Thu, 21 Jan 2021 14:59:36 -0800
In-Reply-To: <pull.840.git.1611234585889.gitgitgadget@gmail.com> (Johannes
        Schindelin via GitGitGadget's message of "Thu, 21 Jan 2021 13:09:45
        +0000")
Message-ID: <xmqqft2tc2w7.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1.90 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 556918B2-5C3C-11EB-9D11-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> When `SKIP_DASHED_BUILT_INS` is specified in `config.mak`, the dashed
> form of the built-ins was still generated.
>
> By moving the `SKIP_DASHED_BUILT_INS` handling after `config.mak` was
> read, this can be avoided.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---

OK.  So the problem is that the moved block that sets ALL_PROGRAMS,
ALL_COMMANDS_TO_INSTALL, etc. depends on $(SKIP_DASHED_BUILT_INS),
and that happens before we "include config.mak".

That makes sense.  Will apply (I do not know if you want this also
on the maint tracks and if so which ones---I think it would matter
if you want to cut a maint release from 2.29.x or 2.30.x tracks).

By the way, I wonder if we can (semi-)automate looking for such a
mistake in the future.  Does a simple rule like:

    No variable that has "Define X if you want to distim the doshes"
    at the beginning of the Makefile must be referenced before we
    include config.mak

work?

Thanks.
