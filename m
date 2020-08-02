Return-Path: <SRS0=XjWc=BM=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01FA4C433E0
	for <git@archiver.kernel.org>; Sun,  2 Aug 2020 19:23:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DFAC120738
	for <git@archiver.kernel.org>; Sun,  2 Aug 2020 19:23:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="GvCnw1Vu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726778AbgHBTXK (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 2 Aug 2020 15:23:10 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:53221 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726347AbgHBTXJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Aug 2020 15:23:09 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id ADB226F87C;
        Sun,  2 Aug 2020 15:23:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=8V1W102yMcQP2l7ix+vxHkxm3lM=; b=GvCnw1
        VusH/hT0mBKp1RRNCi/abx7JR9LbrQAU3WsvCbeGXXhhCToUpGdeEIFAF6j7qNMW
        mz/jktfVezyVG/f86gVv1/42kFv7g7W9+X3HDNikeQnfvHcU6db1kwjHCbT/D8uL
        2u9zSocUUcW6ApF4p2Dxhh5k5wxdsJ2V3pBXg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=HyYVXS5vh3krpKfk9jGwhOhPh/0EdPtE
        jiZexwO48i10Q96vOZbLqz1ka4wENkt+pkPGdj9XQ/J5xXOiOfmUQZkVtaLLD2IA
        8IfMTdi8je0api3v9DlGG08Le0kirshxf5xB1DInTE4PnNyZCuOXK2L0l4c+86zW
        YOLmEq21f0g=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 9A0236F87B;
        Sun,  2 Aug 2020 15:23:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 090CA6F87A;
        Sun,  2 Aug 2020 15:23:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 3/4] merge: make merge.renormalize work for all uses of merge machinery
References: <pull.825.git.git.1596349986.gitgitgadget@gmail.com>
        <08c8080b3196a1bd09bbf20ce705ec5ed5180c34.1596349986.git.gitgitgadget@gmail.com>
Date:   Sun, 02 Aug 2020 12:23:03 -0700
In-Reply-To: <08c8080b3196a1bd09bbf20ce705ec5ed5180c34.1596349986.git.gitgitgadget@gmail.com>
        (Elijah Newren via GitGitGadget's message of "Sun, 02 Aug 2020
        06:33:05 +0000")
Message-ID: <xmqqd048svhk.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 96390A88-D4F5-11EA-A316-2F5D23BA3BAF-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Elijah Newren <newren@gmail.com>
>
> The 'merge' command is not the only one that does merges; other commands
> like checkout -m or rebase do as well.  Unfortunately, the only area of
> the code that checked for the "merge.renormalize" config setting was in
> builtin/merge.c, meaning it could only affect merges performed by the
> "merge" command.  Move the handling of this config setting to
> merge_recursive_config() so that other commands can benefit from it as
> well.  Fixes a few tests in t6038.

Makes sense, but.

> @@ -771,13 +771,6 @@ static int merge_working_tree(const struct checkout_opts *opts,
>  			 */
>  
>  			add_files_to_cache(NULL, NULL, 0);
> -			/*
> -			 * NEEDSWORK: carrying over local changes
> -			 * when branches have different end-of-line
> -			 * normalization (or clean+smudge rules) is
> -			 * a pain; plumb in an option to set
> -			 * o.renormalize?
> -			 */
>  			init_merge_options(&o, the_repository);

Now init_merge_options() takes care of setting o.renormalize, which
does exactly what the comment wanted to see happen.

> diff --git a/builtin/merge.c b/builtin/merge.c
> index 7da707bf55..52f03ea715 100644
> --- a/builtin/merge.c
> +++ b/builtin/merge.c
> @@ -72,7 +72,7 @@ static const char **xopts;
>  static size_t xopts_nr, xopts_alloc;
>  static const char *branch;
>  static char *branch_mergeoptions;
> -static int option_renormalize;
> +static int option_renormalize = -1;

Do we still need this file-scope static variable at all?

> @@ -621,8 +621,6 @@ static int git_merge_config(const char *k, const char *v, void *cb)
>  		return git_config_string(&pull_octopus, k, v);
>  	else if (!strcmp(k, "commit.cleanup"))
>  		return git_config_string(&cleanup_arg, k, v);
> -	else if (!strcmp(k, "merge.renormalize"))
> -		option_renormalize = git_config_bool(k, v);

We no longer set value to option_renormalize in git_merge_config()
that is used only from cmd_merge().

> @@ -721,7 +719,8 @@ static int try_merge_strategy(const char *stra
>  		if (!strcmp(strategy, "subtree"))
>  			o.subtree_shift = "";
>  
> -		o.renormalize = option_renormalize;
> +		if (option_renormalize != -1)
> +			o.renormalize = option_renormalize;

And if somebody sets option_renormalize, then (and only then) we
override o.renormalize.  One line before the precontext of this hunk
is a call to init_merge_options() that would have set o.renormalize
by reading merge.renormalize configuration.  So there must be another
place where option_renormalize comes from other than that configuration
variable.

But I do not see the variable mentioned anywhere else in the
original   The assignment to it in git_merge_config() you just got
rid of was the only one that used to assign to it.

> diff --git a/merge-recursive.c b/merge-recursive.c
> index 36948eafb7..a1c8b36ddb 100644
> --- a/merge-recursive.c
> +++ b/merge-recursive.c
> @@ -3791,9 +3791,12 @@ int merge_recursive_generic(struct merge_options *opt,
>  static void merge_recursive_config(struct merge_options *opt)
>  {
>  	char *value = NULL;
> +	int renormalize = 0;
>  	git_config_get_int("merge.verbosity", &opt->verbosity);
>  	git_config_get_int("diff.renamelimit", &opt->rename_limit);
>  	git_config_get_int("merge.renamelimit", &opt->rename_limit);
> +	git_config_get_bool("merge.renormalize", &renormalize);
> +	opt->renormalize = renormalize;
>  	if (!git_config_get_string("diff.renames", &value)) {
>  		opt->detect_renames = git_config_rename("diff.renames", value);
>  		free(value);

OK.

IOW, wouldn't the attached be a no-op code clean-up on top?

 builtin/merge.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index 52f03ea715..74829a838e 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -72,7 +72,6 @@ static const char **xopts;
 static size_t xopts_nr, xopts_alloc;
 static const char *branch;
 static char *branch_mergeoptions;
-static int option_renormalize = -1;
 static int verbosity;
 static int allow_rerere_auto;
 static int abort_current_merge;
@@ -719,8 +718,6 @@ static int try_merge_strategy(const char *strategy, struct commit_list *common,
 		if (!strcmp(strategy, "subtree"))
 			o.subtree_shift = "";
 
-		if (option_renormalize != -1)
-			o.renormalize = option_renormalize;
 		o.show_rename_progress =
 			show_progress == -1 ? isatty(2) : show_progress;
 
