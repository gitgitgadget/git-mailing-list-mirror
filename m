Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 236A4C433FE
	for <git@archiver.kernel.org>; Thu,  9 Dec 2021 18:53:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbhLIS46 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Dec 2021 13:56:58 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64138 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229838AbhLIS45 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Dec 2021 13:56:57 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6A8DCFAEB9;
        Thu,  9 Dec 2021 13:53:23 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=QkMwFsNrFoduoXseomuu1/Vn125hKCUwiTAZpZ
        /offI=; b=COOsTxJLHcihGPIBDMwuPdfFin2Y78uhlNYEihRNI318pihs8bx2Vl
        VenLaRPpqMFjUX6NHz5xhfprZ8Po1JsqrA99E/+aanDVKxRHud3onXdM2Ff+K9Jc
        l2kxcmp/95tBeg55l1q7fKuw+hPqPZJZI8yIVvJIiCCmZhYte1gU0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5E1C5FAEB8;
        Thu,  9 Dec 2021 13:53:23 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 87014FAEB7;
        Thu,  9 Dec 2021 13:53:22 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v2 03/14] rebase: pass correct arguments to
 post-checkout hook
References: <pull.1049.git.1633082702.gitgitgadget@gmail.com>
        <pull.1049.v2.git.1638975481.gitgitgadget@gmail.com>
        <07867760e68a6b28f718bdcb33094461592affaa.1638975482.git.gitgitgadget@gmail.com>
Date:   Thu, 09 Dec 2021 10:53:21 -0800
In-Reply-To: <07867760e68a6b28f718bdcb33094461592affaa.1638975482.git.gitgitgadget@gmail.com>
        (Phillip Wood via GitGitGadget's message of "Wed, 08 Dec 2021 14:57:50
        +0000")
Message-ID: <xmqqa6h9sj8e.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 48701C22-5921-11EC-AEA3-E10CCAD8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> If a rebase started with "rebase [--apply|--merge] <upstream> <branch>"
> detects that <upstream> is an ancestor of <branch> then it fast-forwards
> and checks out <branch>. Unfortunately in that case it passed the null
> oid as the first argument to the post-checkout hook rather than the oid
> of HEAD.
>
> A side effect of this change is that the call to update_ref() which
> updates HEAD now always receives the old value of HEAD. This provides
> protection against another process updating HEAD during the checkout.

Nicely described.

> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
>  reset.c                       | 18 +++++++++---------
>  t/t5403-post-checkout-hook.sh | 13 +++++++++++++
>  2 files changed, 22 insertions(+), 9 deletions(-)
>
> diff --git a/reset.c b/reset.c
> index f214df3d96c..315fef91d33 100644
> --- a/reset.c
> +++ b/reset.c
> @@ -18,7 +18,7 @@ int reset_head(struct repository *r, struct object_id *oid, const char *action,
>  	unsigned run_hook = flags & RESET_HEAD_RUN_POST_CHECKOUT_HOOK;
>  	unsigned refs_only = flags & RESET_HEAD_REFS_ONLY;
>  	unsigned update_orig_head = flags & RESET_ORIG_HEAD;
> -	struct object_id head_oid;
> +	struct object_id *head = NULL, head_oid;
>  	struct tree_desc desc[2] = { { NULL }, { NULL } };
>  	struct lock_file lock = LOCK_INIT;
>  	struct unpack_trees_options unpack_tree_opts = { 0 };
> @@ -26,8 +26,7 @@ int reset_head(struct repository *r, struct object_id *oid, const char *action,
>  	const char *reflog_action;
>  	struct strbuf msg = STRBUF_INIT;
>  	size_t prefix_len;
> -	struct object_id *orig = NULL, oid_orig,
> -		*old_orig = NULL, oid_old_orig;
> +	struct object_id *old_orig = NULL, oid_old_orig;
>  	int ret = 0, nr = 0;
>  
>  	if (switch_to_branch && !starts_with(switch_to_branch, "refs/"))
> @@ -38,7 +37,9 @@ int reset_head(struct repository *r, struct object_id *oid, const char *action,
>  		goto leave_reset_head;
>  	}
>  
> -	if ((!oid || !reset_hard) && get_oid("HEAD", &head_oid)) {
> +	if (!get_oid("HEAD", &head_oid)) {
> +		head = &head_oid;
> +	} else if (!oid || !reset_hard) {
>  		ret = error(_("could not determine HEAD revision"));
>  		goto leave_reset_head;
>  	}

Here, the original grabbed head_oid only when oid is not known or we
are not doing a hard reset.  Now we grab head_oid when available,
regardless of the other conditions.  But the logic to error out is
the same.  If oid is not given or not doing hard reset, it is an
error if we cannot figure out what object HEAD points at (is that
"unborn branch"?).

OK.


> @@ -98,13 +99,12 @@ reset_head_refs:
>  	if (update_orig_head) {
>  		if (!get_oid("ORIG_HEAD", &oid_old_orig))
>  			old_orig = &oid_old_orig;
> -		if (!get_oid("HEAD", &oid_orig)) {
> -			orig = &oid_orig;
> +		if (head) {
>  			if (!reflog_orig_head) {
>  				strbuf_addstr(&msg, "updating ORIG_HEAD");
>  				reflog_orig_head = msg.buf;
>  			}
> -			update_ref(reflog_orig_head, "ORIG_HEAD", orig,
> +			update_ref(reflog_orig_head, "ORIG_HEAD", head,
>  				   old_orig, 0, UPDATE_REFS_MSG_ON_ERR);
>  		} else if (old_orig)
>  			delete_ref(NULL, "ORIG_HEAD", old_orig, 0);

The variable 'orig' was initialized to NULL and then got assigned
the value of HEAD here, which is used in update_ref().  The new code
does the same thing with the 'head' variable that we have already
prepared earlier.  So there is no change here locally, but this
affects correctness later ...

> @@ -116,7 +116,7 @@ reset_head_refs:
>  		reflog_head = msg.buf;
>  	}
>  	if (!switch_to_branch)
> -		ret = update_ref(reflog_head, "HEAD", oid, orig,
> +		ret = update_ref(reflog_head, "HEAD", oid, head,
>  				 detach_head ? REF_NO_DEREF : 0,
>  				 UPDATE_REFS_MSG_ON_ERR);

... here.  In the original code, there is nothing that populates the
'orig' variable, if "update_orig_head" is not true, so we used to
pass NULL here.  Now as long as we know what HEAD is, we pass use it.



> @@ -128,7 +128,7 @@ reset_head_refs:
>  	}
>  	if (run_hook)
>  		run_hook_le(NULL, "post-checkout",
> -			    oid_to_hex(orig ? orig : null_oid()),
> +			    oid_to_hex(head ? head : null_oid()),

And the same fix is in effect here.

Nice.


> diff --git a/t/t5403-post-checkout-hook.sh b/t/t5403-post-checkout-hook.sh
> index 272b02687ba..17ab518f268 100755
> --- a/t/t5403-post-checkout-hook.sh
> +++ b/t/t5403-post-checkout-hook.sh
> @@ -72,6 +72,19 @@ test_rebase () {
>  		test_cmp_rev rebase-on-me $new &&
>  		test $flag = 1
>  	'
> +
> +	test_expect_success "rebase $args fast-forward branch checkout runs post-checkout hook" '
> +		test_when_finished "test_might_fail git rebase --abort" &&
> +		test_when_finished "rm -f .git/post-checkout.args" &&
> +		git update-ref refs/heads/rebase-fast-forward three &&
> +		git checkout two  &&
> +		rm -f .git/post-checkout.args &&
> +		git rebase $args HEAD rebase-fast-forward  &&
> +		read old new flag <.git/post-checkout.args &&
> +		test_cmp_rev two $old &&
> +		test_cmp_rev three $new &&
> +		test $flag = 1
> +	'
>  }
>  
>  test_rebase --apply &&
