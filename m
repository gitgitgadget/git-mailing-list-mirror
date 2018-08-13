Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 849A91F404
	for <e@80x24.org>; Mon, 13 Aug 2018 15:32:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728894AbeHMSPi (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Aug 2018 14:15:38 -0400
Received: from siwi.pair.com ([209.68.5.199]:32852 "EHLO siwi.pair.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728293AbeHMSPi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Aug 2018 14:15:38 -0400
Received: from siwi.pair.com (localhost [127.0.0.1])
        by siwi.pair.com (Postfix) with ESMTP id EAA773F40BC;
        Mon, 13 Aug 2018 11:32:52 -0400 (EDT)
Received: from [10.160.98.162] (unknown [167.220.148.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by siwi.pair.com (Postfix) with ESMTPSA id 852043F4091;
        Mon, 13 Aug 2018 11:32:52 -0400 (EDT)
Subject: Re: [PATCH v4] clone: report duplicate entries on case-insensitive
 filesystems
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, newren@gmail.com,
        pawelparuzel95@gmail.com, peff@peff.net,
        sandals@crustytoothpaste.net, tboegi@web.de,
        =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
References: <20180810153608.30051-1-pclouds@gmail.com>
 <20180812090714.19060-1-pclouds@gmail.com>
From:   Jeff Hostetler <git@jeffhostetler.com>
Message-ID: <1c0c0ff0-0005-a5a8-5aed-d39ce94373ba@jeffhostetler.com>
Date:   Mon, 13 Aug 2018 11:32:51 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.0
MIME-Version: 1.0
In-Reply-To: <20180812090714.19060-1-pclouds@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 8/12/2018 5:07 AM, Nguyễn Thái Ngọc Duy wrote:
> Paths that only differ in case work fine in a case-sensitive
> filesystems, but if those repos are cloned in a case-insensitive one,
> you'll get problems. The first thing to notice is "git status" will
> never be clean with no indication what exactly is "dirty".
> 
> This patch helps the situation a bit by pointing out the problem at
> clone time. Even though this patch talks about case sensitivity, the
> patch makes no assumption about folding rules by the filesystem. It
> simply observes that if an entry has been already checked out at clone
> time when we're about to write a new path, some folding rules are
> behind this.
> 
> This patch is tested with vim-colorschemes repository on a JFS partition
> with case insensitive support on Linux. This repository has two files
> darkBlue.vim and darkblue.vim.
> 
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>   v4 removes nr_duplicates (and fixes that false warning Szeder
>   reported). It also hints about case insensitivity as a cause of
>   problem because it's most likely the case when this warning shows up.
> 
>   builtin/clone.c  |  1 +
>   cache.h          |  1 +
>   entry.c          | 28 ++++++++++++++++++++++++++++
>   t/t5601-clone.sh |  8 +++++++-
>   unpack-trees.c   | 28 ++++++++++++++++++++++++++++
>   unpack-trees.h   |  1 +
>   6 files changed, 66 insertions(+), 1 deletion(-)
> 
> diff --git a/builtin/clone.c b/builtin/clone.c
> index 5c439f1394..0702b0e9d0 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -747,6 +747,7 @@ static int checkout(int submodule_progress)
>   	memset(&opts, 0, sizeof opts);
>   	opts.update = 1;
>   	opts.merge = 1;
> +	opts.clone = 1;
>   	opts.fn = oneway_merge;
>   	opts.verbose_update = (option_verbosity >= 0);
>   	opts.src_index = &the_index;
> diff --git a/cache.h b/cache.h
> index 8b447652a7..6d6138f4f1 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -1455,6 +1455,7 @@ struct checkout {
>   	unsigned force:1,
>   		 quiet:1,
>   		 not_new:1,
> +		 clone:1,
>   		 refresh_cache:1;
>   };
>   #define CHECKOUT_INIT { NULL, "" }
> diff --git a/entry.c b/entry.c
> index b5d1d3cf23..c70340df8e 100644
> --- a/entry.c
> +++ b/entry.c
> @@ -399,6 +399,31 @@ static int check_path(const char *path, int len, struct stat *st, int skiplen)
>   	return lstat(path, st);
>   }
>   
> +static void mark_colliding_entries(const struct checkout *state,
> +				   struct cache_entry *ce, struct stat *st)
> +{
> +	int i;
> +
> +	ce->ce_flags |= CE_MATCHED;
> +
> +#if !defined(GIT_WINDOWS_NATIVE) /* inode is always zero on Windows */
> +	for (i = 0; i < state->istate->cache_nr; i++) {
> +		struct cache_entry *dup = state->istate->cache[i];
> +
> +		if (dup == ce)
> +			break;
> +
> +		if (dup->ce_flags & (CE_MATCHED | CE_VALID | CE_SKIP_WORKTREE))
> +			continue;
> +
> +		if (dup->ce_stat_data.sd_ino == st->st_ino) {
> +			dup->ce_flags |= CE_MATCHED;
> +			break;
> +		}
> +	}
> +#endif
> +}
> +
>   /*
>    * Write the contents from ce out to the working tree.
>    *
> @@ -455,6 +480,9 @@ int checkout_entry(struct cache_entry *ce,
>   			return -1;
>   		}
>   
> +		if (state->clone)
> +			mark_colliding_entries(state, ce, &st);
> +
>   		/*
>   		 * We unlink the old file, to get the new one with the
>   		 * right permissions (including umask, which is nasty
> diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
> index 0b62037744..f2eb73bc74 100755
> --- a/t/t5601-clone.sh
> +++ b/t/t5601-clone.sh
> @@ -624,10 +624,16 @@ test_expect_success 'clone on case-insensitive fs' '
>   			git hash-object -w -t tree --stdin) &&
>   		c=$(git commit-tree -m bogus $t) &&
>   		git update-ref refs/heads/bogus $c &&
> -		git clone -b bogus . bogus
> +		git clone -b bogus . bogus 2>warning
>   	)
>   '
>   
> +test_expect_success !MINGW,!CYGWIN,CASE_INSENSITIVE_FS 'colliding file detection' '
> +	grep X icasefs/warning &&
> +	grep x icasefs/warning &&
> +	test_i18ngrep "the following paths have collided" icasefs/warning
> +'
> +
>   partial_clone () {
>   	       SERVER="$1" &&
>   	       URL="$2" &&
> diff --git a/unpack-trees.c b/unpack-trees.c
> index cd0680f11e..443df048ef 100644
> --- a/unpack-trees.c
> +++ b/unpack-trees.c
> @@ -359,6 +359,12 @@ static int check_updates(struct unpack_trees_options *o)
>   	state.refresh_cache = 1;
>   	state.istate = index;
>   
> +	if (o->clone) {
> +		state.clone = 1;
> +		for (i = 0; i < index->cache_nr; i++)
> +			index->cache[i]->ce_flags &= ~CE_MATCHED;
> +	}
> +
>   	progress = get_progress(o);
>   
>   	if (o->update)
> @@ -423,6 +429,28 @@ static int check_updates(struct unpack_trees_options *o)
>   	errs |= finish_delayed_checkout(&state);
>   	if (o->update)
>   		git_attr_set_direction(GIT_ATTR_CHECKIN, NULL);
> +
> +	if (o->clone) {
> +		int printed_warning = 0;
> +
> +		for (i = 0; i < index->cache_nr; i++) {
> +			struct cache_entry *ce = index->cache[i];
> +
> +			if (!(ce->ce_flags & CE_MATCHED))
> +				continue;
> +
> +			if (!printed_warning) {
> +				warning(_("the following paths have collided (e.g. case-sensitive paths\n"
> +					  "on a case-insensitive filesystem) and only one from the same\n"
> +					  "colliding group is in the working tree:\n"));
> +				printed_warning = 1;
> +			}
> +
> +			fprintf(stderr, "  '%s'\n", ce->name);
> +			ce->ce_flags &= ~CE_MATCHED;
> +		}
> +	}
> +

If I'm reading this correctly, on Linux and friends, you'll print the
names of the files where the collision was detected and the paths of
any peers found from the inum matching.  And because of the #ifdef'ing
on Windows, we'll just get the former (at least for now).

That sounds fine.
Thanks
Jeff


>   	return errs != 0;
>   }
>   
> diff --git a/unpack-trees.h b/unpack-trees.h
> index c2b434c606..d940f1c5c2 100644
> --- a/unpack-trees.h
> +++ b/unpack-trees.h
> @@ -42,6 +42,7 @@ struct unpack_trees_options {
>   	unsigned int reset,
>   		     merge,
>   		     update,
> +		     clone,
>   		     index_only,
>   		     nontrivial_merge,
>   		     trivial_merges_only,
> 
