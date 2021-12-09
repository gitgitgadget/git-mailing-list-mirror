Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01DE8C433EF
	for <git@archiver.kernel.org>; Thu,  9 Dec 2021 19:23:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbhLIT1S (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Dec 2021 14:27:18 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:55582 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbhLIT1R (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Dec 2021 14:27:17 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7150EF4336;
        Thu,  9 Dec 2021 14:23:43 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=A5VXuSiIl1mGERjUJlN4ho5J5qfNG/gT17g9/V
        9bbSE=; b=sE9SpOl+AYI6xaX9Oj/4pgXr1psa1N8e/pehfglaSJSJNqrVDu8AYn
        JEVbbtQ7EHcLvXOZD0/eNS3zKJVPUSxKUW+mi3FEQvfwO3GXiL8P9zjOQuRxOZuR
        8AiPZ/hwsCbYDaU9tJH0EkO9E2u3DJPqzXpBYUfGJtNA/Hc3uxVvo=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 66AB5F4335;
        Thu,  9 Dec 2021 14:23:43 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id CE9CFF4334;
        Thu,  9 Dec 2021 14:23:42 -0500 (EST)
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
Subject: Re: [PATCH v2 09/14] reset_head(): make default_reflog_action optional
References: <pull.1049.git.1633082702.gitgitgadget@gmail.com>
        <pull.1049.v2.git.1638975481.gitgitgadget@gmail.com>
        <9d00a218daf68a86e5dfba0c0cd66d6aaa6706b3.1638975482.git.gitgitgadget@gmail.com>
Date:   Thu, 09 Dec 2021 11:23:41 -0800
In-Reply-To: <9d00a218daf68a86e5dfba0c0cd66d6aaa6706b3.1638975482.git.gitgitgadget@gmail.com>
        (Phillip Wood via GitGitGadget's message of "Wed, 08 Dec 2021 14:57:56
        +0000")
Message-ID: <xmqqk0gdr39e.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 856A3474-5925-11EC-AF7A-C48D900A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> This parameter is only needed when a ref is going to be updated and
> the caller does not pass an explicit reflog message. Callers that are
> only discarding uncommitted changes in the working tree such as such
> as "rebase --skip" or create_autostash() do not update any refs so
> should not have to worry about passing this parameter.

This answers the question I had on 07/14.  I think the part with
create_autostash() in this step should be dropped, and 07/14 should
be done after this step.

Unlike "", NULL makes it very clear that it will be a bug if the
implementation used it as the message.

> This change is not intended to have any user visible changes. The
> pointer comparison between `oid` and `&head_oid` checks that the
> caller did not pass an oid to be checked out. As no callers pass
> RESET_HEAD_RUN_POST_CHECKOUT_HOOK without passing an oid there are
> no changes to when the post-checkout hook is run. As update_ref() only
> updates the ref if the oid passed to it differs from the current ref
> there are no changes to when HEAD is updated.
>
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
>  builtin/rebase.c | 10 ++++------
>  reset.c          | 16 ++++++++++++----
>  sequencer.c      |  2 +-
>  3 files changed, 17 insertions(+), 11 deletions(-)
>
> diff --git a/builtin/rebase.c b/builtin/rebase.c
> index 832e6954827..3d78b5c8bef 100644
> --- a/builtin/rebase.c
> +++ b/builtin/rebase.c
> @@ -585,8 +585,7 @@ static int move_to_original_branch(struct rebase_options *opts)
>  		    opts->head_name);
>  	ret = reset_head(the_repository, NULL, opts->head_name,
>  			 RESET_HEAD_REFS_ONLY,
> -			 orig_head_reflog.buf, head_reflog.buf,
> -			 DEFAULT_REFLOG_ACTION);
> +			 orig_head_reflog.buf, head_reflog.buf, NULL);
>  
>  	strbuf_release(&orig_head_reflog);
>  	strbuf_release(&head_reflog);
> @@ -822,7 +821,7 @@ static int checkout_up_to_date(struct rebase_options *options)
>  		    options->switch_to);
>  	if (reset_head(the_repository, &options->orig_head,
>  		       options->head_name, RESET_HEAD_RUN_POST_CHECKOUT_HOOK,
> -		       NULL, buf.buf, DEFAULT_REFLOG_ACTION) < 0)
> +		       NULL, buf.buf, NULL) < 0)
>  		ret = error(_("could not switch to %s"), options->switch_to);
>  	strbuf_release(&buf);
>  
> @@ -1273,7 +1272,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>  		string_list_clear(&merge_rr, 1);
>  
>  		if (reset_head(the_repository, NULL, NULL, RESET_HEAD_HARD,
> -			       NULL, NULL, DEFAULT_REFLOG_ACTION) < 0)
> +			       NULL, NULL, NULL) < 0)
>  			die(_("could not discard worktree changes"));
>  		remove_branch_state(the_repository, 0);
>  		if (read_basic_state(&options))
> @@ -1778,8 +1777,7 @@ int cmd_rebase(int argc, const char **argv, const char *prefix)
>  			options.head_name ? options.head_name : "detached HEAD",
>  			oid_to_hex(&options.onto->object.oid));
>  		reset_head(the_repository, NULL, options.head_name,
> -			   RESET_HEAD_REFS_ONLY, "HEAD", msg.buf,
> -			   DEFAULT_REFLOG_ACTION);
> +			   RESET_HEAD_REFS_ONLY, "HEAD", msg.buf, NULL);
>  		strbuf_release(&msg);
>  		ret = finish_rebase(&options);
>  		goto cleanup;
> diff --git a/reset.c b/reset.c
> index 56d6e2a06d9..4a92e4bc30b 100644
> --- a/reset.c
> +++ b/reset.c
> @@ -22,8 +22,13 @@ static int update_refs(const struct object_id *oid, const char *switch_to_branch
>  	size_t prefix_len;
>  	int ret;
>  
> -	reflog_action = getenv(GIT_REFLOG_ACTION_ENVIRONMENT);
> -	strbuf_addf(&msg, "%s: ", reflog_action ? reflog_action : default_reflog_action);
> +	if ((update_orig_head && !reflog_orig_head) || !reflog_head) {
> +		if (!default_reflog_action)
> +			BUG("default_reflog_action must be given when reflog messages are omitted");
> +		reflog_action = getenv(GIT_REFLOG_ACTION_ENVIRONMENT);
> +		strbuf_addf(&msg, "%s: ", reflog_action ? reflog_action :
> +							  default_reflog_action);
> +	}
>  	prefix_len = msg.len;
>  
>  	if (update_orig_head) {
> @@ -71,6 +76,7 @@ int reset_head(struct repository *r, struct object_id *oid,
>  {
>  	unsigned reset_hard = flags & RESET_HEAD_HARD;
>  	unsigned refs_only = flags & RESET_HEAD_REFS_ONLY;
> +	unsigned update_orig_head = flags & RESET_ORIG_HEAD;
>  	struct object_id *head = NULL, head_oid;
>  	struct tree_desc desc[2] = { { NULL }, { NULL } };
>  	struct lock_file lock = LOCK_INIT;
> @@ -144,8 +150,10 @@ int reset_head(struct repository *r, struct object_id *oid,
>  		goto leave_reset_head;
>  	}
>  
> -	ret = update_refs(oid, switch_to_branch, head, reflog_head,
> -			  reflog_orig_head, default_reflog_action, flags);
> +	if (oid != &head_oid || update_orig_head || switch_to_branch)
> +		ret = update_refs(oid, switch_to_branch, head, reflog_head,
> +				  reflog_orig_head, default_reflog_action,
> +				  flags);
>  
>  leave_reset_head:
>  	rollback_lock_file(&lock);
> diff --git a/sequencer.c b/sequencer.c
> index 5c65f5f1ac5..78d203dec47 100644
> --- a/sequencer.c
> +++ b/sequencer.c
> @@ -4131,7 +4131,7 @@ void create_autostash(struct repository *r, const char *path)
>  		write_file(path, "%s", oid_to_hex(&oid));
>  		printf(_("Created autostash: %s\n"), buf.buf);
>  		if (reset_head(r, NULL, NULL, RESET_HEAD_HARD, NULL, NULL,
> -			       "") < 0)
> +			       NULL) < 0)
>  			die(_("could not reset --hard"));
>  
>  		if (discard_index(r->index) < 0 ||
