Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E7C5C433F5
	for <git@archiver.kernel.org>; Mon, 25 Apr 2022 09:36:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238634AbiDYJja (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Apr 2022 05:39:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241698AbiDYJiz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Apr 2022 05:38:55 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CCCE13F75
        for <git@vger.kernel.org>; Mon, 25 Apr 2022 02:34:10 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7F26312DAA6;
        Mon, 25 Apr 2022 05:34:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=1CqhpLdgKqm14bGF2/ctA9zmhq0/jS2N6e9G76pYXsw=; b=BCYn
        i8VyTpdLY5yDT3/biM6ukyYe5t4/Ot0R1/BVhf5xY5P9Dnzl8wjDraxQGbCoZCwQ
        wt58PWqh7XrmZwSNu0ziWWHmXCiNAFUAVEYn3R4H3XZ0/BCpoxErhu7wthXH5fUa
        AN2tHQedLR+/BY7jL4PLhrID8DmnBD7EEynBhyc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2568612DAA5;
        Mon, 25 Apr 2022 05:34:07 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.105.84.173])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 05A5912DAA3;
        Mon, 25 Apr 2022 05:34:05 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Orgad Shaneh via GitGitGadget" <gitgitgadget@gmail.com>,
        Glen Choo <chooglen@google.com>
Cc:     git@vger.kernel.org, Orgad Shaneh <orgads@gmail.com>
Subject: Re: [PATCH] submodule--helper: fix initialization of
 warn_if_uninitialized
References: <pull.1258.git.git.1650781575173.gitgitgadget@gmail.com>
Date:   Mon, 25 Apr 2022 02:34:04 -0700
Message-ID: <xmqqee1ly0ab.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D9CC1F08-C47A-11EC-99C6-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Orgad Shaneh via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Orgad Shaneh <orgads@gmail.com>
>
> This field is supposed to be off by default, and it is only enabled when
> running `git submodule update <path>`, and path is not initialized.

"is supposed to be": can you substantiate it with evidence and
logic?

One easy way to explain the above is to examine what the default
value was before the problematic commit, and go back from that
commit to see how the default was decided, and examine how the
member is used.

> Commit c9911c9358 changed it to enabled by default. This affects
> for example git checkout, which displays the following warning for
> each uninitialized submodule:
>
> Submodule path 'sub' not initialized
> Maybe you want to use 'update --init'?

We refer to an existing commit like this:

    c9911c93 (submodule--helper: teach update_data more options,
    2022-03-15) changed it to be enabled by default.

So, taking the above together:

    The .warn_if_uninitialized member was introduced by 48308681
    (git submodule update: have a dedicated helper for cloning,
    2016-02-29) to submodule_update_clone struct and initialized to
    false.  When c9911c93 (submodule--helper: teach update_data more
    options, 2022-03-15) moved it to update_data struct, it started
    to initialize it to true but this change was not explained in
    its log message.

    The member is set to true only when pathspec was given, and is
    used when a submodule that matched the pathspec is found
    uninitialized to give diagnostic message.  "submodule update"
    without pathspec is supposed to iterate over all submodules
    (i.e. without pathspec limitation) and update only the
    initialized submodules, and finding uninitialized submodules
    during the iteration is a totally expected and normal thing that
    should not be warned.

    Fix this regression by initializing the member to 0.

> Amends c9911c9358e611390e2444f718c73900d17d3d60.

In the context of "git", the verb "amend" has a specific meaning
(i.e. "commit --amend"), and we should refrain from using it when we
are doing something else to avoid confusing readers.

We could say

    Fix this problem that was introduced by c9911c93
    (submodule--helper: teach update_data more options, 2022-03-15)

but it is not necessary, as long as we explained how that commit
broke the code to justify this change (which we should do anyway).

>
> Signed-off-by: Orgad Shaneh <orgads@gmail.com>
> ---
>     submodule--helper: fix initialization of warn_if_uninitialized
> ...
>     Signed-off-by: Orgad Shaneh orgads@gmail.com

Here under three-dash line is where you would write comment meant
for those who read the message on the list that are not necessarily
meant to be part of resulting commit.  Repeating the same message as
the log message is not desired here.

> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1258%2Forgads%2Fsub-no-warn-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1258/orgads/sub-no-warn-v1
> Pull-Request: https://github.com/git/git/pull/1258
>
>  builtin/submodule--helper.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
> index 2c87ef9364f..b28112e3040 100644
> --- a/builtin/submodule--helper.c
> +++ b/builtin/submodule--helper.c
> @@ -2026,7 +2026,7 @@ struct update_data {
>  	.references = STRING_LIST_INIT_DUP, \
>  	.single_branch = -1, \
>  	.max_jobs = 1, \
> -	.warn_if_uninitialized = 1, \
> +	.warn_if_uninitialized = 0, \
>  }

This is not wrong per-se, but omitting the mention of the member
altogether and letting the compiler initialize it to 0 would
probably be a better fix.

Thanks.
