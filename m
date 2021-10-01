Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B78FC433F5
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 21:00:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77C1661A10
	for <git@archiver.kernel.org>; Fri,  1 Oct 2021 21:00:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbhJAVCO (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Oct 2021 17:02:14 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61500 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbhJAVCN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Oct 2021 17:02:13 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A8398F43DF;
        Fri,  1 Oct 2021 17:00:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=xns9rlwDtQLsGJeaPTI0denaaTa3XJCMazQSTT
        /iLFE=; b=P1SDAJ7yo5eiGa47uYvr9lE7iJnz/WABSkNduQyG+EhkrutO5rRQfG
        hFYREhSv4cqnnxB65dbw4hCoVdoR0QFZba5kRLqWGx60/D8ISaCxVweicVBLtxZB
        vGUn+7uWwIDXb9sl3CX3Fcz3yOsSHJqt0zw/C6mEquYJ9O63rLLBU=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 964ABF43DE;
        Fri,  1 Oct 2021 17:00:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E6F8CF43DD;
        Fri,  1 Oct 2021 17:00:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Elijah Newren <newren@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 05/11] reset_head(): factor out ref updates
References: <pull.1049.git.1633082702.gitgitgadget@gmail.com>
        <0744c3d143b5c2020267c5f9ad7da9303d7a7835.1633082702.git.gitgitgadget@gmail.com>
Date:   Fri, 01 Oct 2021 14:00:26 -0700
In-Reply-To: <0744c3d143b5c2020267c5f9ad7da9303d7a7835.1633082702.git.gitgitgadget@gmail.com>
        (Phillip Wood via GitGitGadget's message of "Fri, 01 Oct 2021 10:04:56
        +0000")
Message-ID: <xmqqlf3c5ul1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 9B05FB62-22FA-11EC-A711-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> In the next commit we will stop trying to update HEAD when we are just
> clearing changes from the working tree. Move the code that updates the

"clearing changes" meaning...?  Like "rebase --abort"?

> refs to its own function in preparation for that.
>
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
>  reset.c | 112 +++++++++++++++++++++++++++++++-------------------------
>  1 file changed, 62 insertions(+), 50 deletions(-)
>
> diff --git a/reset.c b/reset.c
> index 9ab007c0c34..668c7639127 100644
> --- a/reset.c
> +++ b/reset.c
> @@ -8,26 +8,75 @@
>  #include "tree.h"
>  #include "unpack-trees.h"
>  
> +static int update_refs(const struct object_id *oid, const char *switch_to_branch,
> +		       const char *reflog_head, const char *reflog_orig_head,
> +		       const char *default_reflog_action, unsigned flags)
> +{
> +	unsigned detach_head = flags & RESET_HEAD_DETACH;
> +	unsigned run_hook = flags & RESET_HEAD_RUN_POST_CHECKOUT_HOOK;
> +	unsigned update_orig_head = flags & RESET_ORIG_HEAD;
> +	struct object_id *orig = NULL, oid_orig, *old_orig = NULL, oid_old_orig;
> +	struct strbuf msg = STRBUF_INIT;
> +	const char *reflog_action;
> +	size_t prefix_len;
> +	int ret;
> +
> +	reflog_action = getenv(GIT_REFLOG_ACTION_ENVIRONMENT);
> +	strbuf_addf(&msg, "%s: ", reflog_action ? reflog_action : default_reflog_action);
> +	prefix_len = msg.len;
> +
> +	if (update_orig_head) {
> +		if (!get_oid("ORIG_HEAD", &oid_old_orig))
> +			old_orig = &oid_old_orig;
> +		if (!get_oid("HEAD", &oid_orig)) {
> +			orig = &oid_orig;
> +			if (!reflog_orig_head) {
> +				strbuf_addstr(&msg, "updating ORIG_HEAD");
> +				reflog_orig_head = msg.buf;
> +			}
> +			update_ref(reflog_orig_head, "ORIG_HEAD", orig,
> +				   old_orig, 0, UPDATE_REFS_MSG_ON_ERR);
> +		} else if (old_orig)
> +			delete_ref(NULL, "ORIG_HEAD", old_orig, 0);
> +	}
> +
> +	if (!reflog_head) {
> +		strbuf_setlen(&msg, prefix_len);
> +		strbuf_addstr(&msg, "updating HEAD");
> +		reflog_head = msg.buf;
> +	}
> +	if (!switch_to_branch)
> +		ret = update_ref(reflog_head, "HEAD", oid, orig,
> +				 detach_head ? REF_NO_DEREF : 0,
> +				 UPDATE_REFS_MSG_ON_ERR);
> +	else {
> +		ret = update_ref(reflog_head, switch_to_branch, oid,
> +				 NULL, 0, UPDATE_REFS_MSG_ON_ERR);
> +		if (!ret)
> +			ret = create_symref("HEAD", switch_to_branch,
> +					    reflog_head);
> +	}
> +	if (!ret && run_hook)
> +		run_hook_le(NULL, "post-checkout",
> +			    oid_to_hex(orig ? orig : null_oid()),
> +			    oid_to_hex(oid), "1", NULL);
> +	strbuf_release(&msg);
> +	return ret;
> +}
> +
>  int reset_head(struct repository *r, struct object_id *oid,
>  	       const char *switch_to_branch, unsigned flags,
>  	       const char *reflog_orig_head, const char *reflog_head,
>  	       const char *default_reflog_action)
>  {
> -	unsigned detach_head = flags & RESET_HEAD_DETACH;
>  	unsigned reset_hard = flags & RESET_HEAD_HARD;
> -	unsigned run_hook = flags & RESET_HEAD_RUN_POST_CHECKOUT_HOOK;
>  	unsigned refs_only = flags & RESET_HEAD_REFS_ONLY;
> -	unsigned update_orig_head = flags & RESET_ORIG_HEAD;
>  	struct object_id head_oid;
>  	struct tree_desc desc[2] = { { NULL }, { NULL } };
>  	struct lock_file lock = LOCK_INIT;
>  	struct unpack_trees_options unpack_tree_opts = { 0 };
>  	struct tree *tree;
> -	const char *action, *reflog_action;
> -	struct strbuf msg = STRBUF_INIT;
> -	size_t prefix_len;
> -	struct object_id *orig = NULL, oid_orig,
> -		*old_orig = NULL, oid_old_orig;
> +	const char *action;
>  	int ret = 0, nr = 0;
>  
>  	if (switch_to_branch && !starts_with(switch_to_branch, "refs/"))
> @@ -47,7 +96,9 @@ int reset_head(struct repository *r, struct object_id *oid,
>  		oid = &head_oid;
>  
>  	if (refs_only)
> -		goto reset_head_refs;
> +		return update_refs(oid, switch_to_branch, reflog_head,
> +				   reflog_orig_head, default_reflog_action,
> +				   flags);
>  
>  	action = reset_hard ? "reset" : "checkout";
>  	setup_unpack_trees_porcelain(&unpack_tree_opts, action);
> @@ -90,49 +141,10 @@ int reset_head(struct repository *r, struct object_id *oid,
>  		goto leave_reset_head;
>  	}
>  
> -reset_head_refs:
> -	reflog_action = getenv(GIT_REFLOG_ACTION_ENVIRONMENT);
> -	strbuf_addf(&msg, "%s: ", reflog_action ? reflog_action : default_reflog_action);
> -	prefix_len = msg.len;
> -
> -	if (update_orig_head) {
> -		if (!get_oid("ORIG_HEAD", &oid_old_orig))
> -			old_orig = &oid_old_orig;
> -		if (!get_oid("HEAD", &oid_orig)) {
> -			orig = &oid_orig;
> -			if (!reflog_orig_head) {
> -				strbuf_addstr(&msg, "updating ORIG_HEAD");
> -				reflog_orig_head = msg.buf;
> -			}
> -			update_ref(reflog_orig_head, "ORIG_HEAD", orig,
> -				   old_orig, 0, UPDATE_REFS_MSG_ON_ERR);
> -		} else if (old_orig)
> -			delete_ref(NULL, "ORIG_HEAD", old_orig, 0);
> -	}
> -
> -	if (!reflog_head) {
> -		strbuf_setlen(&msg, prefix_len);
> -		strbuf_addstr(&msg, "updating HEAD");
> -		reflog_head = msg.buf;
> -	}
> -	if (!switch_to_branch)
> -		ret = update_ref(reflog_head, "HEAD", oid, orig,
> -				 detach_head ? REF_NO_DEREF : 0,
> -				 UPDATE_REFS_MSG_ON_ERR);
> -	else {
> -		ret = update_ref(reflog_head, switch_to_branch, oid,
> -				 NULL, 0, UPDATE_REFS_MSG_ON_ERR);
> -		if (!ret)
> -			ret = create_symref("HEAD", switch_to_branch,
> -					    reflog_head);
> -	}
> -	if (!ret && run_hook)
> -		run_hook_le(NULL, "post-checkout",
> -			    oid_to_hex(orig ? orig : null_oid()),
> -			    oid_to_hex(oid), "1", NULL);
> +	ret = update_refs(oid, switch_to_branch, reflog_head, reflog_orig_head,
> +			  default_reflog_action, flags);
>  
>  leave_reset_head:
> -	strbuf_release(&msg);
>  	rollback_lock_file(&lock);
>  	clear_unpack_trees_porcelain(&unpack_tree_opts);
>  	while (nr)
