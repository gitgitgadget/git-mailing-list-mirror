Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5740C4332F
	for <git@archiver.kernel.org>; Wed, 12 Oct 2022 20:37:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229513AbiJLUhA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Oct 2022 16:37:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229659AbiJLUg6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Oct 2022 16:36:58 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 455E8FF243
        for <git@vger.kernel.org>; Wed, 12 Oct 2022 13:36:56 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id AC89A15081B;
        Wed, 12 Oct 2022 16:36:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=GuP83IyaPR2t/PJn+DCno2XJ/zGML6uWrX1jTp
        NTrOE=; b=fcUtLvumc5p74jA+9xZPwwuNe21c4hdW1Vph/+ElzS9MVscd7TNq4P
        RxOfbZ01DD3g6YQ/B7svYO4rdgPWRXKZe7hIl5uVnY8Hq3IroSErIto6OayqWAqE
        u41IFUn4QASykjO/dviFnTYxNIa6E0kRmn9wAY0cNDVB7LuTBrKcM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A298615081A;
        Wed, 12 Oct 2022 16:36:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 130F7150819;
        Wed, 12 Oct 2022 16:36:54 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Calvin Wan <calvinwan@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Glen Choo <chooglen@google.com>,
        Victoria Dye <vdye@github.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v3 1/8] rebase --apply: remove duplicated code
References: <pull.1150.v2.git.1650448612.gitgitgadget@gmail.com>
        <pull.1150.v3.git.1665567312.gitgitgadget@gmail.com>
        <a84cf971a753e294555ca8f2b7eaa4c75a8fa491.1665567312.git.gitgitgadget@gmail.com>
Date:   Wed, 12 Oct 2022 13:36:53 -0700
In-Reply-To: <a84cf971a753e294555ca8f2b7eaa4c75a8fa491.1665567312.git.gitgitgadget@gmail.com>
        (Phillip Wood via GitGitGadget's message of "Wed, 12 Oct 2022 09:35:05
        +0000")
Message-ID: <xmqqedvclqxm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9B9CBFC0-4A6D-11ED-8422-307A8E0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> Use move_to_original_branch() when reattaching HEAD after a fast-forward
> rather than open coding a copy of that code. move_to_original_branch()
> does not call reset_head() if head_name is NULL but there should be no
> user visible changes even though we currently call reset_head() in that
> case.

move_to_original_branch() uses both .head_msg and .branch_msg and
uses different messages for them, but the original code below only
feeds .head_msg while .branch_msg leaves NULL, which leads
reset.c::update_refs() to use the same message as .head_msg when it
wants to use .branch_msg (i.e. the message recorded in the reflog of
the branch).  

Doesn't this difference result in a different behaviour?

> The reason for this is that the reset_head() call does not add a
> message to the reflog because we're not changing the commit that HEAD
> points to and so lock_ref_for_update() elides the update. When head_name
> is not NULL then reset_head() behaves like "git symbolic-ref" and so the
> reflog is updated.

> Note that the removal of "strbuf_release(&msg)" is safe as there is an

The patch is removing strbuf_reset(), not _release(), here, though.

We have released already so there is no point to reset it again, so
the removal is still safe.

> identical call just above this hunk which can be seen by viewing the
> diff with -U6.
>
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
>  builtin/rebase.c | 11 +----------
>  1 file changed, 1 insertion(+), 10 deletions(-)
>
> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index a2ca66b54be..51accb4fd61 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -1808,19 +1808,10 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>  	 * If the onto is a proper descendant of the tip of the branch, then
>  	 * we just fast-forwarded.
>  	 */
> -	strbuf_reset(&msg);
>  	if (oideq(&branch_base, &options.orig_head->object.oid)) {
>  		printf(_("Fast-forwarded %s to %s.\n"),
>  			branch_name, options.onto_name);
> -		strbuf_addf(&msg, "rebase finished: %s onto %s",
> -			options.head_name ? options.head_name : "detached HEAD",
> -			oid_to_hex(&options.onto->object.oid));
> -		memset(&ropts, 0, sizeof(ropts));
> -		ropts.branch = options.head_name;
> -		ropts.flags = RESET_HEAD_REFS_ONLY;
> -		ropts.head_msg = msg.buf;
> -		reset_head(the_repository, &ropts);
> -		strbuf_release(&msg);
> +		move_to_original_branch(&options);
>  		ret = finish_rebase(&options);
>  		goto cleanup;
>  	}
