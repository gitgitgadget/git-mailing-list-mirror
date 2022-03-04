Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFB20C433EF
	for <git@archiver.kernel.org>; Fri,  4 Mar 2022 22:30:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbiCDWbA (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Mar 2022 17:31:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiCDWbA (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Mar 2022 17:31:00 -0500
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 846DC50467
        for <git@vger.kernel.org>; Fri,  4 Mar 2022 14:30:11 -0800 (PST)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id A20591126FE;
        Fri,  4 Mar 2022 17:30:10 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:in-reply-to:references:date:message-id:mime-version
        :content-type; s=sasl; bh=YPMlwosItUADcd4Zr+WBYKHCTTtbxXcP7EduZL
        6PJiE=; b=HOK3CxcVFsH7pvhSDOYFCsZuplKqsMqTyYCg1AYTh6RgDzDjNjatj7
        QGEdFHeKv0zNnVo5CXuvteAz4T4lMyx1h/YAYZQo8FYoC7EOmsqqwM9bsGsdpeL0
        Ejs3pyKfapgwRq1kdjY53RDIbHBiQ8w5lKC2VG3w/w+lfyraqUi6M=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 825CD1126FC;
        Fri,  4 Mar 2022 17:30:10 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.230.65.123])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id A83171126D9;
        Fri,  4 Mar 2022 17:30:08 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, stolee@gmail.com, avarab@gmail.com,
        zhiyou.jx@alibaba-inc.com, jonathantanmy@google.com,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 05/11] list-objects: consolidate
 traverse_commit_list[_filtered]
In-Reply-To: <ec57ed5c37fdcb9fe31a16a09178642a5c219115.1645638911.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Wed, 23 Feb 2022
        17:55:05 +0000")
References: <pull.1159.git.1645638911.gitgitgadget@gmail.com>
        <ec57ed5c37fdcb9fe31a16a09178642a5c219115.1645638911.git.gitgitgadget@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
Date:   Fri, 04 Mar 2022 14:30:06 -0800
Message-ID: <xmqqzgm5xsep.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A5D0F482-9C0A-11EC-ACB1-CB998F0A682E-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Derrick Stolee <derrickstolee@github.com>
>
> Now that all consumers of traverse_commit_list_filtered() populate the
> 'filter' member of 'struct rev_info', we can drop that parameter from
> the method prototype to simplify things. In addition, the only thing
> different now between traverse_commit_list_filtered() and
> traverse_commit_list() is the presence of the 'omitted' parameter, which
> is only non-NULL for one caller. We can consolidate these two methods by
> having one call the other and use the simpler form everywhere the
> 'omitted' paramter would be NULL.

Nice.  Modulo "paramter" -> "parameter".

>
> Signed-off-by: Derrick Stolee <derrickstolee@github.com>
> ---
>  builtin/pack-objects.c |  6 +++---
>  builtin/rev-list.c     |  2 +-
>  list-objects.c         | 25 ++++++++-----------------
>  list-objects.h         | 12 ++++++++++--
>  pack-bitmap.c          |  6 +++---
>  5 files changed, 25 insertions(+), 26 deletions(-)
>
> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> index 57f2cf49696..0432ae1e499 100644
> --- a/builtin/pack-objects.c
> +++ b/builtin/pack-objects.c
> @@ -3778,9 +3778,9 @@ static void get_object_list(int ac, const char **av)
>  
>  	if (!fn_show_object)
>  		fn_show_object = show_object;
> -	traverse_commit_list_filtered(revs.filter, &revs,
> -				      show_commit, fn_show_object, NULL,
> -				      NULL);
> +	traverse_commit_list(&revs,
> +			     show_commit, fn_show_object,
> +			     NULL);
>  
>  	if (unpack_unreachable_expiration) {
>  		revs.ignore_missing_links = 1;
> diff --git a/builtin/rev-list.c b/builtin/rev-list.c
> index 556e78aebb9..3ab727817fd 100644
> --- a/builtin/rev-list.c
> +++ b/builtin/rev-list.c
> @@ -733,7 +733,7 @@ int cmd_rev_list(int argc, const char **argv, const char *prefix)
>  		oidset_init(&missing_objects, DEFAULT_OIDSET_SIZE);
>  
>  	traverse_commit_list_filtered(
> -		revs.filter, &revs, show_commit, show_object, &info,
> +		&revs, show_commit, show_object, &info,
>  		(arg_print_omitted ? &omitted_objects : NULL));
>  
>  	if (arg_print_omitted) {
> diff --git a/list-objects.c b/list-objects.c
> index 2f623f82115..9422625b39e 100644
> --- a/list-objects.c
> +++ b/list-objects.c
> @@ -416,22 +416,7 @@ static void do_traverse(struct traversal_context *ctx)
>  	strbuf_release(&csp);
>  }
>  
> -void traverse_commit_list(struct rev_info *revs,
> -			  show_commit_fn show_commit,
> -			  show_object_fn show_object,
> -			  void *show_data)
> -{
> -	struct traversal_context ctx;
> -	ctx.revs = revs;
> -	ctx.show_commit = show_commit;
> -	ctx.show_object = show_object;
> -	ctx.show_data = show_data;
> -	ctx.filter = NULL;
> -	do_traverse(&ctx);
> -}
> -
>  void traverse_commit_list_filtered(
> -	struct list_objects_filter_options *filter_options,
>  	struct rev_info *revs,
>  	show_commit_fn show_commit,
>  	show_object_fn show_object,
> @@ -444,7 +429,13 @@ void traverse_commit_list_filtered(
>  	ctx.show_object = show_object;
>  	ctx.show_commit = show_commit;
>  	ctx.show_data = show_data;
> -	ctx.filter = list_objects_filter__init(omitted, filter_options);
> +	if (revs->filter)
> +		ctx.filter = list_objects_filter__init(omitted, revs->filter);
> +	else
> +		ctx.filter = NULL;
> +
>  	do_traverse(&ctx);
> -	list_objects_filter__free(ctx.filter);
> +
> +	if (ctx.filter)
> +		list_objects_filter__free(ctx.filter);
>  }
> diff --git a/list-objects.h b/list-objects.h
> index a952680e466..9eaf4de8449 100644
> --- a/list-objects.h
> +++ b/list-objects.h
> @@ -7,7 +7,6 @@ struct rev_info;
>  
>  typedef void (*show_commit_fn)(struct commit *, void *);
>  typedef void (*show_object_fn)(struct object *, const char *, void *);
> -void traverse_commit_list(struct rev_info *, show_commit_fn, show_object_fn, void *);
>  
>  typedef void (*show_edge_fn)(struct commit *);
>  void mark_edges_uninteresting(struct rev_info *revs,
> @@ -18,11 +17,20 @@ struct oidset;
>  struct list_objects_filter_options;
>  
>  void traverse_commit_list_filtered(
> -	struct list_objects_filter_options *filter_options,
>  	struct rev_info *revs,
>  	show_commit_fn show_commit,
>  	show_object_fn show_object,
>  	void *show_data,
>  	struct oidset *omitted);
>  
> +static inline void traverse_commit_list(
> +	struct rev_info *revs,
> +	show_commit_fn show_commit,
> +	show_object_fn show_object,
> +	void *show_data)
> +{
> +	traverse_commit_list_filtered(revs, show_commit,
> +				      show_object, show_data, NULL);
> +}
> +
>  #endif /* LIST_OBJECTS_H */
> diff --git a/pack-bitmap.c b/pack-bitmap.c
> index 613f2797cdf..cbefaedbf43 100644
> --- a/pack-bitmap.c
> +++ b/pack-bitmap.c
> @@ -822,9 +822,9 @@ static struct bitmap *find_objects(struct bitmap_index *bitmap_git,
>  		show_data.bitmap_git = bitmap_git;
>  		show_data.base = base;
>  
> -		traverse_commit_list_filtered(revs->filter, revs,
> -					      show_commit, show_object,
> -					      &show_data, NULL);
> +		traverse_commit_list(revs,
> +				     show_commit, show_object,
> +				     &show_data);
>  
>  		revs->include_check = NULL;
>  		revs->include_check_obj = NULL;
