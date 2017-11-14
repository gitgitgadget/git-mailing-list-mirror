Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4CAC5201C2
	for <e@80x24.org>; Tue, 14 Nov 2017 04:56:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753062AbdKNE4e (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Nov 2017 23:56:34 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64976 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751245AbdKNE4c (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Nov 2017 23:56:32 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 6492BAE4FE;
        Mon, 13 Nov 2017 23:56:32 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=mEn09wmIbexpBJdO2F52YS6TraY=; b=Q9y/T6
        xXQ98PyEUY6kPYyPrVuXUJwnVXaJiLhbd6W4F3m9lkwZqI4jY/IQwJb70H3lEkkw
        MGDb07pS3BURs+jpPnMs2hnSO+mSTeBYHV6vIQlf+QSuWpeDLNtX+ZWNyFkBFfY+
        eCZu6AyfklXpC+TN6eHcg2NYOg/XhvrLcz5xM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=jEktNdMUR0qYfvSQiTS/aa3gyp+o9ZwR
        CQHgn7Pk/9EIKEeBX8Ym1ZpJVw8iyp7LOyZ8aI3Ns6W/Q0U1z3X7/Hcoze4ly06p
        PZKlSVfPtb1YsTJAd0AgR/HA8hFi4zK7sLacTWhgGPsaVkG2VEObm6DbVbGY4IBZ
        nI8daDPGGQk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 5A5EDAE4FD;
        Mon, 13 Nov 2017 23:56:32 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id CA374AE4FA;
        Mon, 13 Nov 2017 23:56:31 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 16/30] merge-recursive: Introduce new functions to handle rename logic
References: <20171110190550.27059-1-newren@gmail.com>
        <20171110190550.27059-17-newren@gmail.com>
Date:   Tue, 14 Nov 2017 13:56:30 +0900
In-Reply-To: <20171110190550.27059-17-newren@gmail.com> (Elijah Newren's
        message of "Fri, 10 Nov 2017 11:05:36 -0800")
Message-ID: <xmqqd14l5ugx.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 2EAA2368-C8F8-11E7-8FD4-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

> +struct rename_info {
> +	struct string_list *head_renames;
> +	struct string_list *merge_renames;
> +};

This type is added in order to allow the caller and the helper to
communicate the findings in a single logical structure, instead of
having to pass them as separate parameters, etc.  If we anticipate
that the information that needs to be passed will grow richer in
later steps (or a follow-up series), such encapsulation makes a lot
of sence.

> +static struct rename_info *handle_renames(struct merge_options *o,
> +					  struct tree *common,
> +					  struct tree *head,
> +					  struct tree *merge,
> +					  struct string_list *entries,
> +					  int *clean)
> +{
> +	struct rename_info *rei = xcalloc(1, sizeof(struct rename_info));

I however notice that there is only one caller of this helper at
this step, and also at the end of this series.  I suspect that it
would probably be a better design to make "clean" the return value
of this helper, and instead have the caller pass an uninitialised
rename_info structure on its stack by address to be filled by the
helper.

> +	rei->head_renames  = get_renames(o, head, common, head, merge, entries);
> +	rei->merge_renames = get_renames(o, merge, common, head, merge, entries);
> +	*clean = process_renames(o, rei->head_renames, rei->merge_renames);
> +
> +	return rei;
> +}
> +
> +static void cleanup_renames(struct rename_info *re_info)
> +{
> +	string_list_clear(re_info->head_renames, 0);
> +	string_list_clear(re_info->merge_renames, 0);
> +
> +	free(re_info->head_renames);
> +	free(re_info->merge_renames);
> +
> +	free(re_info);
> +}
>  static struct object_id *stage_oid(const struct object_id *oid, unsigned mode)
>  {
>  	return (is_null_oid(oid) || mode == 0) ? NULL: (struct object_id *)oid;
> @@ -1989,7 +2021,8 @@ int merge_trees(struct merge_options *o,
>  	}
>  
>  	if (unmerged_cache()) {
> -		struct string_list *entries, *re_head, *re_merge;
> +		struct string_list *entries;
> +		struct rename_info *re_info;
>  		int i;
>  		/*
>  		 * Only need the hashmap while processing entries, so
> @@ -2003,9 +2036,7 @@ int merge_trees(struct merge_options *o,
>  		get_files_dirs(o, merge);
>  
>  		entries = get_unmerged();
> -		re_head  = get_renames(o, head, common, head, merge, entries);
> -		re_merge = get_renames(o, merge, common, head, merge, entries);
> -		clean = process_renames(o, re_head, re_merge);
> +		re_info = handle_renames(o, common, head, merge, entries, &clean);
>  		record_df_conflict_files(o, entries);
>  		if (clean < 0)
>  			goto cleanup;
> @@ -2030,16 +2061,13 @@ int merge_trees(struct merge_options *o,
>  		}
>  
>  cleanup:
> -		string_list_clear(re_merge, 0);
> -		string_list_clear(re_head, 0);
> +		cleanup_renames(re_info);
> +
>  		string_list_clear(entries, 1);
> +		free(entries);
>  
>  		hashmap_free(&o->current_file_dir_set, 1);
>  
> -		free(re_merge);
> -		free(re_head);
> -		free(entries);
> -
>  		if (clean < 0)
>  			return clean;
>  	}
