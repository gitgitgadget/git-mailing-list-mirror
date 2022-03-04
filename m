Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E51DC433EF
	for <git@archiver.kernel.org>; Fri,  4 Mar 2022 22:25:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbiCDW0I (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Mar 2022 17:26:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiCDW0H (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Mar 2022 17:26:07 -0500
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D06DF1C8D82
        for <git@vger.kernel.org>; Fri,  4 Mar 2022 14:25:18 -0800 (PST)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7A64D112C46;
        Fri,  4 Mar 2022 17:25:16 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=hOxAiBjG6TtGL+CKlaxCFQy2JvAN/bLazid5+f
        OxRck=; b=oCLWcXUe27Yh9x9MzUlgfKCWkutLpLtffdR4UAtY2I+rbBUhnvxCkr
        vEi+1jjT7wCvu3PRPD2LC0NkGULENIcxr2jpnb5o5rk8g8w0Ws+qlv5QKba2ekqJ
        LMaZcHzBQYR33iyLLcsedIgKGW5wB1va9c5/+kqAYx5c1/tPpTs1Y=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 70BA4112C43;
        Fri,  4 Mar 2022 17:25:16 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.230.65.123])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id BFE32112C42;
        Fri,  4 Mar 2022 17:25:15 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, stolee@gmail.com, avarab@gmail.com,
        zhiyou.jx@alibaba-inc.com, jonathantanmy@google.com,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 03/11] pack-objects: use rev.filter when possible
References: <pull.1159.git.1645638911.gitgitgadget@gmail.com>
        <d5edb193229731edbac9f861ad569885ec2b4405.1645638911.git.gitgitgadget@gmail.com>
Date:   Fri, 04 Mar 2022 14:25:13 -0800
In-Reply-To: <d5edb193229731edbac9f861ad569885ec2b4405.1645638911.git.gitgitgadget@gmail.com>
        (Derrick Stolee via GitGitGadget's message of "Wed, 23 Feb 2022
        17:55:03 +0000")
Message-ID: <xmqqbkylz77a.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F739A630-9C09-11EC-A518-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Derrick Stolee <derrickstolee@github.com>
>
> In builtin/pack-objects.c, we use a 'filter_options' global to populate
> the --filter=<X> argument. The previous change created a pointer to a
> filter option in 'struct rev_info', so we can use that pointer here as a
> start to simplifying some usage of object filters.

Hmph, it is very unfortunate that we cannot really get rid of the
file-scope static filter_options easily and replace it with an
instance of "struct list_objects_filter_options" embedded in
rev_info, because cmd_pack_objects(), where the place filter-options
are parsed, does not have an instance of "struct rev_info" to use
yet, and it takes some code restructuring to get there.

And that is why ...

> Signed-off-by: Derrick Stolee <derrickstolee@github.com>
> ---
>  builtin/pack-objects.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> index ba2006f2212..256d9b1798f 100644
> --- a/builtin/pack-objects.c
> +++ b/builtin/pack-objects.c
> @@ -3651,7 +3651,7 @@ static int pack_options_allow_reuse(void)
>  
>  static int get_object_list_from_bitmap(struct rev_info *revs)
>  {
> -	if (!(bitmap_git = prepare_bitmap_walk(revs, &filter_options, 0)))
> +	if (!(bitmap_git = prepare_bitmap_walk(revs, revs->filter, 0)))
>  		return -1;
>  
>  	if (pack_options_allow_reuse() &&
> @@ -3727,6 +3727,7 @@ static void get_object_list(int ac, const char **av)
>  	repo_init_revisions(the_repository, &revs, NULL);
>  	save_commit_buffer = 0;
>  	setup_revisions(ac, av, &revs, &s_r_opt);
> +	revs.filter = &filter_options;

... we need something like this.

Nothing wrong per-se, feels somewhat unsatisfactory, but it would
work OK, which counts ;-)

>  	/* make sure shallows are read */
>  	is_repository_shallow(the_repository);
> @@ -3777,7 +3778,7 @@ static void get_object_list(int ac, const char **av)
>  
>  	if (!fn_show_object)
>  		fn_show_object = show_object;
> -	traverse_commit_list_filtered(&filter_options, &revs,
> +	traverse_commit_list_filtered(revs.filter, &revs,
>  				      show_commit, fn_show_object, NULL,
>  				      NULL);
