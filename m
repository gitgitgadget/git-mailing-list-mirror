Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD906C433EF
	for <git@archiver.kernel.org>; Mon, 25 Apr 2022 18:25:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243533AbiDYS2u (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Apr 2022 14:28:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239140AbiDYS2s (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Apr 2022 14:28:48 -0400
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F272D1C92D
        for <git@vger.kernel.org>; Mon, 25 Apr 2022 11:25:42 -0700 (PDT)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E45CA1A6B59;
        Mon, 25 Apr 2022 14:25:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=m8DP9odgDeUrig0psGh8u1wvPjPDZbkrKF1m1m
        6S3s8=; b=BLfLp/173eq48L0Rsz6mqbXg2o567CQoIONFK4TaGn4YGiiCrrIOpm
        jiPEcx97TXcpUMq0YzM8JSHaUXaYO0cPQyZF0QscuEp7vCQr+A7Ws6rEIuXsVoII
        eHBT5wKub1tZrPaLyQiAuDMia2pH7jwxshGXpkVuiy+TXD4ArZIKc=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id DC6771A6B58;
        Mon, 25 Apr 2022 14:25:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.84.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 5592F1A6B57;
        Mon, 25 Apr 2022 14:25:38 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Orgad Shaneh via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Orgad Shaneh <orgads@gmail.com>,
        Glen Choo <chooglen@google.com>
Subject: Re: [PATCH v2] submodule--helper: fix initialization of
 warn_if_uninitialized
References: <pull.1258.git.git.1650781575173.gitgitgadget@gmail.com>
        <pull.1258.v2.git.git.1650890741430.gitgitgadget@gmail.com>
Date:   Mon, 25 Apr 2022 11:25:37 -0700
In-Reply-To: <pull.1258.v2.git.git.1650890741430.gitgitgadget@gmail.com>
        (Orgad Shaneh via GitGitGadget's message of "Mon, 25 Apr 2022 12:45:41
        +0000")
Message-ID: <xmqq35i1vx3y.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1B15B0BA-C4C5-11EC-A20D-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Orgad Shaneh via GitGitGadget" <gitgitgadget@gmail.com> writes:

> The member is set to true only when pathspec was given, and is
> used when a submodule that matched the pathspec is found
> uninitialized to give diagnostic message.  "submodule update"
> without pathspec is supposed to iterate over all submodules
> (i.e. without pathspec limitation) and update only the
> initialized submodules, and finding uninitialized submodules
> during the iteration is a totally expected and normal thing that
> should not be warned.
> ...
>  builtin/submodule--helper.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index 2c87ef9364f..1a8e5d06214 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -2026,7 +2026,6 @@ struct update_data {
>  	.references = STRING_LIST_INIT_DUP, \
>  	.single_branch = -1, \
>  	.max_jobs = 1, \
> -	.warn_if_uninitialized = 1, \
>  }

Is this a fix we can protect from future breakge by adding a test or
tweaking an existing test?  It is kind of surprising if we did not
have any test that runs "git submodule update" in a superproject
with initialized and uninitialized submodule(s) and make sure only
the initialized ones are updated.  It may be the matter of examining
the warning output that is currently ignored in such a test, if
there is one.

Thanks.


