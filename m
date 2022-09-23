Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB7BDC04A95
	for <git@archiver.kernel.org>; Fri, 23 Sep 2022 21:45:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232317AbiIWVpE (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Sep 2022 17:45:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbiIWVpD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Sep 2022 17:45:03 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE872857E3
        for <git@vger.kernel.org>; Fri, 23 Sep 2022 14:45:00 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 57448153789;
        Fri, 23 Sep 2022 17:44:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=jl0Fcozpeg/6YBaH02KsIhvHDaJs3vezKXnNyo
        2hOEg=; b=SfXz1wA8JAS1gdIQFOri2wUhc/oYqaLJPS+bA44ejZVhN4aIont5jc
        +CbK30ZF/i8IepsBjBcAkob4sVrG+B0rXA8q0u6/tPmxr6VnB5dfOomoyx/Yp8bI
        +xb6od6ZQF145miWmEloMiuv966HkePpfvnuReYAaXJyoB77qfNHc=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 4E5FE153788;
        Fri, 23 Sep 2022 17:44:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A9E78153787;
        Fri, 23 Sep 2022 17:44:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Calvin Wan <calvinwan@google.com>
Cc:     git@vger.kernel.org, emilyshaffer@google.com
Subject: Re: [PATCH 4/4] diff-lib: parallelize run_diff_files for submodules
References: <20220922232947.631309-1-calvinwan@google.com>
        <20220922232947.631309-5-calvinwan@google.com>
Date:   Fri, 23 Sep 2022 14:44:57 -0700
In-Reply-To: <20220922232947.631309-5-calvinwan@google.com> (Calvin Wan's
        message of "Thu, 22 Sep 2022 23:29:47 +0000")
Message-ID: <xmqqy1u9sr3a.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: F86230BC-3B88-11ED-8101-2AEEC5D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Calvin Wan <calvinwan@google.com> writes:

> During the iteration of the index entries in run_diff_files, whenever
> a submodule is found and needs its status checked, a subprocess is
> spawned for it. Instead of spawning the subprocess immediately and
> waiting for its completion to continue, hold onto all submodules and
> relevant information in a list. Then use that list to create tasks for
> run_processes_parallel. Finished subprocesses pipe their output to
> status_finish which parses it and sets the relevant variables.

Excellent---I like the idea very much.

You make it sound as if this is only for "git status", but shouldn't
it benefit the usual "git diff" the same way when you have
submodules that can be dirty?

> Add config option status.parallelSubmodules to set the maximum number
> of parallel jobs. 

Configuration is fine, but I am having a hard time justifying the
addition of an extra parameter to run_diff_files().  It might be
more palatable to give a new bit (default off) in the rev structure
that tells it that it is OK to go into the "defer_submodule_status"
mode, if we absolutely want to change the behaviour of
run_diff_files() only for a single caller or something, but I doubt
it should even be needed.

I cannot think of a sane user interface that says "when
run_diff_files() is invoked as an implementation detail of 'status',
use this value, and when it is running for another command 'foo',
use this other value".  How would a user decide to pick a different
value for different commands?

Letting a single configuration variable to decide the degree of
parallelism inside run_diff_files() would be sufficient, and we
shouldn't have to touch all the existing calling sites of
run_diff_files() all over the place.  If you absolutely want to do
this, I'd rather see the new member for the configuration variable
not in wt_status but in rev_info.

> +status.parallelSubmodules::
> +	When linkgit:git-status[1] is run in a superproject with
> +	submodules, a status subprocess is spawned for every submodule.
> +	This option specifies the number of submodule status subprocesses
> +	to run in parallel. If unset, it defaults to 1.

As I said, I am not sure <cmd>.parallelSubmodules per command makes
much sense.  "If unset, it defaults to" sounds a bit redundant (if
it is explicitly set, the default value should not matter).

> @@ -83,11 +88,20 @@ static int match_stat_with_submodule(struct diff_options *diffopt,
>  		goto cleanup;
>  	}
>  	if (!diffopt->flags.ignore_dirty_submodules &&
> -		(!changed || diffopt->flags.dirty_submodules))
> +		(!changed || diffopt->flags.dirty_submodules)) {
> +		if (defer_submodule_status && *defer_submodule_status) {
> +			defer = 1;
> +			*ignore_untracked_in_submodules =
> +							diffopt->flags.ignore_untracked_in_submodules;
> +		} else {
>  			*dirty_submodule = is_submodule_modified(ce->name,
>  							diffopt->flags.ignore_untracked_in_submodules);
> +		}
> +	}

OK, so the caller can look at *defer

>  cleanup:
>  	diffopt->flags = orig_flags;
> +	if (defer_submodule_status)
> +		*defer_submodule_status = defer;
>  	return changed;
>  }
>  
> @@ -117,7 +131,7 @@ static void finish_run_diff_files(struct rev_info *revs,
>  			    ce->name, 0, dirty_submodule);
>  }
>  
> -int run_diff_files(struct rev_info *revs, unsigned int option)
> +int run_diff_files(struct rev_info *revs, unsigned int option, int parallel_jobs)
>  {
>  	int entries, i;
>  	int diff_unmerged_stage = revs->max_count;
> @@ -125,6 +139,7 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
>  			      ? CE_MATCH_RACY_IS_DIRTY : 0);
>  	uint64_t start = getnanotime();
>  	struct index_state *istate = revs->diffopt.repo->index;
> +	struct string_list submodules = STRING_LIST_INIT_NODUP;
>  
>  	diff_set_mnemonic_prefix(&revs->diffopt, "i/", "w/");
>  
> @@ -138,6 +153,9 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
>  		struct cache_entry *ce = istate->cache[i];
>  		int changed;
>  		unsigned dirty_submodule = 0;
> +		int defer_submodule_status = revs && revs->repo &&
> +							!strcmp(revs->repo->gitdir, ".git");

What is this overly deeply indented comparison with ".git" doing?
What are we checking and why?  Is that something we need to do for
each and every active_cache[] entry, or isn't it constant over the
loop?

> +		int ignore_untracked_in_submodules;
>  
>  		if (diff_can_quit_early(&revs->diffopt))
>  			break;
> @@ -269,11 +287,36 @@ int run_diff_files(struct rev_info *revs, unsigned int option)
>  			}
>  
>  			changed = match_stat_with_submodule(&revs->diffopt, ce, &st,
> +							ce_option, &dirty_submodule,
> +							&defer_submodule_status,
> +							&ignore_untracked_in_submodules);
>  			newmode = ce_mode_from_stat(ce, st.st_mode);
> +			if (defer_submodule_status) {
> +				struct string_list_item *item =
> +								string_list_append(&submodules, ce->name);
> +				struct submodule_status_util *util = xmalloc(sizeof(*util));
> +				util->changed = changed;
> +				util->dirty_submodule = 0;
> +				util->ignore_untracked = ignore_untracked_in_submodules;
> +				util->newmode = newmode;
> +				util->ce = ce;
> +				item->util = util;
> +				continue;

This makes me wonder if defer_submodule_status should be a string
list that receives the punted submodules---iow, don't these details
belong to match_stat_with_submodule() rather than its caller here?

Even better may be to start a new child task for the submodule here,
letting it work while the parent process moves on to the next entry
in the active_cache[].  I do not know if you thought about doing it
that way.

I dunno.

> +			}
>  		}
>  		finish_run_diff_files(revs, ce, istate, changed, dirty_submodule, newmode);
>  	}
> +	if (submodules.nr > 0) {
> +		if (get_submodules_status(revs->repo, &submodules,
> +						parallel_jobs > 0 ? parallel_jobs : 1))
> +			BUG("Submodule status failed");
> +		for (int i = 0; i < submodules.nr; i++) {

We still do not allow "for (type var = init; ...)" if I am not
mistaken.  Check the coding guidelines.
