Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E16011F45A
	for <e@80x24.org>; Fri, 16 Aug 2019 22:14:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727763AbfHPWOg (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Aug 2019 18:14:36 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:63165 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727709AbfHPWOf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Aug 2019 18:14:35 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8FF78169741;
        Fri, 16 Aug 2019 18:14:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=z246XFVFBygJJoQwJy/7TM9UhMA=; b=Fi1Rp7
        P4vndwmfyHTvSCgNvyj4eJAsY+A+/QCaNuY/doUqoivCTukDNT9tdPj10Tx5pJK2
        Q0roWwRlPJIPn5NpBl30VJIhENF43od9E0qxFu+ZoIRjqnbR8UI2YUrBArKdMjSl
        4exUfFWhkjDoZbR7adkPfZlYUNuEgo4t0zTuo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=FbdiKQI5vVzFI1uv3rsiA6LcorTwtQlz
        6xJYbfpkBpGr9LMOve3rDa+AWd3S4IYZCQOimX5iwyxvbqjLPCEC6f5CfjPXmjSy
        vHE4gtoj7pr3A/uiBmm83O7qQ70PLy2tb+ZP6X5gYqVq/mciOHucOA+0vm+nrLEq
        mm2Z8LXvvsg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 886A2169740;
        Fri, 16 Aug 2019 18:14:33 -0400 (EDT)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E25F816973E;
        Fri, 16 Aug 2019 18:14:32 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v3 18/24] merge-recursive: consolidate unnecessary fields in merge_options
References: <20190726155258.28561-1-newren@gmail.com>
        <20190815214053.16594-1-newren@gmail.com>
        <20190815214053.16594-19-newren@gmail.com>
Date:   Fri, 16 Aug 2019 15:14:31 -0700
In-Reply-To: <20190815214053.16594-19-newren@gmail.com> (Elijah Newren's
        message of "Thu, 15 Aug 2019 14:40:47 -0700")
Message-ID: <xmqqftm0zrjs.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3977D258-C073-11E9-A7E9-72EEE64BB12D-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

>  static inline int merge_detect_rename(struct merge_options *opt)
>  {
> -	return opt->merge_detect_rename >= 0 ? opt->merge_detect_rename :
> -		opt->diff_detect_rename >= 0 ? opt->diff_detect_rename : 1;
> +	return (opt->detect_renames != -1) ? opt->detect_renames : 1;
>  }

Every time I see "is it not negative?" (or more generally "is it in
this range?") converted to "is it not this exact value?", it makes
me feel uneasy.

> -	opts.rename_limit = opt->merge_rename_limit >= 0 ? opt->merge_rename_limit :
> -			    opt->diff_rename_limit >= 0 ? opt->diff_rename_limit :
> -			    1000;
> +	opts.rename_limit = (opt->rename_limit != -1) ? opt->rename_limit : 1000;

Likewise.  I have no objection to merging two rename-limit to a
single field (and two detect-renames to a single field).

> @@ -3732,14 +3729,14 @@ static void merge_recursive_config(struct merge_options *opt)
>  {
>  	char *value = NULL;
>  	git_config_get_int("merge.verbosity", &opt->verbosity);
> -	git_config_get_int("diff.renamelimit", &opt->diff_rename_limit);
> -	git_config_get_int("merge.renamelimit", &opt->merge_rename_limit);
> +	git_config_get_int("diff.renamelimit", &opt->rename_limit);
> +	git_config_get_int("merge.renamelimit", &opt->rename_limit);

Hmph.  If merge.renameLimit is there, that would overwrite whatever
we get by reading from diff.renameLimit, so the two fields with
runtime precedence order can easily be replaced by these two calls.

Nice.

If you have "[diff] renamelimit = -2" in your $GIT_DIR/config, would
we change behaviour due to the earlier conversion that has nothing
to do with the theme of this step (i.e. consolidate two variables
into one)?

> @@ -3765,11 +3762,9 @@ void init_merge_options(struct merge_options *opt,
>  	opt->repo = repo;
>  	opt->verbosity = 2;
>  	opt->buffer_output = 1;
> -	opt->diff_rename_limit = -1;
> -	opt->merge_rename_limit = -1;
> +	opt->rename_limit = -1;
>  	opt->renormalize = 0;
> -	opt->diff_detect_rename = -1;
> -	opt->merge_detect_rename = -1;
> +	opt->detect_renames = -1;
>  	opt->detect_directory_renames = MERGE_DIRECTORY_RENAMES_CONFLICT;
>  	merge_recursive_config(opt);
>  	merge_verbosity = getenv("GIT_MERGE_VERBOSITY");
> @@ -3821,16 +3816,16 @@ int parse_merge_opt(struct merge_options *opt, const char *s)
>  	else if (!strcmp(s, "no-renormalize"))
>  		opt->renormalize = 0;
>  	else if (!strcmp(s, "no-renames"))
> -		opt->merge_detect_rename = 0;
> +		opt->detect_renames = 0;
>  	else if (!strcmp(s, "find-renames")) {
> -		opt->merge_detect_rename = 1;
> +		opt->detect_renames = 1;
>  		opt->rename_score = 0;
>  	}
>  	else if (skip_prefix(s, "find-renames=", &arg) ||
>  		 skip_prefix(s, "rename-threshold=", &arg)) {
>  		if ((opt->rename_score = parse_rename_score(&arg)) == -1 || *arg != 0)
>  			return -1;
> -		opt->merge_detect_rename = 1;
> +		opt->detect_renames = 1;
>  	}
>  	/*
>  	 * Please update $__git_merge_strategy_options in
> diff --git a/merge-recursive.h b/merge-recursive.h
> index 0fdae904dd..f4bdfbc897 100644
> --- a/merge-recursive.h
> +++ b/merge-recursive.h
> @@ -27,10 +27,8 @@ struct merge_options {
>  		MERGE_DIRECTORY_RENAMES_CONFLICT = 1,
>  		MERGE_DIRECTORY_RENAMES_TRUE = 2
>  	} detect_directory_renames;
> -	int diff_detect_rename;
> -	int merge_detect_rename;
> -	int diff_rename_limit;
> -	int merge_rename_limit;
> +	int detect_renames;
> +	int rename_limit;
>  	int rename_score;
>  	int needed_rename_limit;
>  	int show_rename_progress;
