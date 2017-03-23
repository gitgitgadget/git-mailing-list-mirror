Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A8CC820958
	for <e@80x24.org>; Thu, 23 Mar 2017 15:29:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755927AbdCWP3a (ORCPT <rfc822;e@80x24.org>);
        Thu, 23 Mar 2017 11:29:30 -0400
Received: from avasout01.plus.net ([84.93.230.227]:35743 "EHLO
        avasout01.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755871AbdCWP33 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Mar 2017 11:29:29 -0400
Received: from [10.0.2.15] ([146.90.175.94])
        by avasout01 with smtp
        id zTVR1u00722aPyA01TVS8l; Thu, 23 Mar 2017 15:29:27 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=BZKo6vl2 c=1 sm=1 tr=0
 a=c4JbszTospdBBUsinAk+iw==:117 a=c4JbszTospdBBUsinAk+iw==:17
 a=IkcTkHD0fZMA:10 a=bt3WUTiwAAAA:8 a=yMhMjlubAAAA:8 a=wTBKwB-8vz_qiJ9dmVUA:9
 a=Jysns2zNtAdmec99:21 a=NiJZnmsy9QDs8w5I:21 a=QEXdDO2ut3YA:10
 a=OXx4ngWzwLx9h_IvVXMu:22 a=BKKCjISod1eDJeS0ORpz:22
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH v2 6/7] name-hash: add test-lazy-init-name-hash
To:     git@jeffhostetler.com, git@vger.kernel.org
References: <1490276825-41544-1-git-send-email-git@jeffhostetler.com>
 <1490276825-41544-7-git-send-email-git@jeffhostetler.com>
Cc:     gitster@pobox.com, peff@peff.net,
        Jeff Hostetler <jeffhost@microsoft.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <a823a9e1-2355-e348-3408-2021cee78001@ramsayjones.plus.com>
Date:   Thu, 23 Mar 2017 15:29:25 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <1490276825-41544-7-git-send-email-git@jeffhostetler.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 23/03/17 13:47, git@jeffhostetler.com wrote:
> From: Jeff Hostetler <jeffhost@microsoft.com>
> 
> Add t/helper/test-lazy-init-name-hash.c test code
> to demonstrate performance times for lazy_init_name_hash()
> using the original single-threaded and the new multi-threaded
> code paths.
> 
> Includes a --dump option to dump the created hashmaps to
> stdout.  You can use this to run both code paths and
> confirm that they generate the same hashmaps.
> 
> Includes a --analyze option to analyze performance of both
> code paths over a range of index sizes to help you find a
> lower bound for the LAZY_THREAD_COST in name-hash.c.
> For example, passing "-a 4000" will set "istate.cache_nr"
> to 4000 and then try the multi-threaded code -- probably
> giving 2 threads with 2000 entries each.  It will then
> run both the single-threaded (1x4000) and the multi-threaded
> (2x2000) and compare the times.  It will then repeat the
> test with 8000, 12000, and etc. so that you can see the
> cross over.
> 
> Signed-off-by: Jeff Hostetler <jeffhost@microsoft.com>
> ---
>  Makefile                            |   1 +
>  cache.h                             |   1 +
>  t/helper/test-lazy-init-name-hash.c | 264 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 266 insertions(+)
>  create mode 100644 t/helper/test-lazy-init-name-hash.c
> 
> diff --git a/Makefile b/Makefile
> index 9ec6065..5fb46c8 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -616,6 +616,7 @@ TEST_PROGRAMS_NEED_X += test-fake-ssh
>  TEST_PROGRAMS_NEED_X += test-genrandom
>  TEST_PROGRAMS_NEED_X += test-hashmap
>  TEST_PROGRAMS_NEED_X += test-index-version
> +TEST_PROGRAMS_NEED_X += test-lazy-init-name-hash
>  TEST_PROGRAMS_NEED_X += test-line-buffer
>  TEST_PROGRAMS_NEED_X += test-match-trees
>  TEST_PROGRAMS_NEED_X += test-mergesort
> diff --git a/cache.h b/cache.h
> index 80b6372..6a72f6a 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -343,6 +343,7 @@ struct index_state {
>  extern struct index_state the_index;
>  
>  /* Name hashing */
> +extern int test_lazy_init_name_hash(struct index_state *istate, int try_threaded);
>  extern void add_name_hash(struct index_state *istate, struct cache_entry *ce);
>  extern void remove_name_hash(struct index_state *istate, struct cache_entry *ce);
>  extern void free_name_hash(struct index_state *istate);
> diff --git a/t/helper/test-lazy-init-name-hash.c b/t/helper/test-lazy-init-name-hash.c
> new file mode 100644
> index 0000000..0769e17
> --- /dev/null
> +++ b/t/helper/test-lazy-init-name-hash.c
> @@ -0,0 +1,264 @@
> +#include "cache.h"
> +#include "parse-options.h"
> +
> +static int single;
> +static int multi;
> +static int count = 1;
> +static int dump;
> +static int perf;
> +static int analyze;
> +static int analyze_step;
> +
> +/*
> + * Dump the contents of the "dir" and "name" hash tables to stdout.
> + * If you sort the result, you can compare it with the other type
> + * mode and verify that both single and multi produce the same set.
> + */
> +void dump_run(void)

static void dump_run(void)

[again, sparse complains ...]

> +{
> +	struct hashmap_iter iter_dir;
> +	struct hashmap_iter iter_cache;
> +
> +	/* Stolen from name-hash.c */
> +	struct dir_entry {
> +		struct hashmap_entry ent;
> +		struct dir_entry *parent;
> +		int nr;
> +		unsigned int namelen;
> +		char name[FLEX_ARRAY];
> +	};
> +
> +	struct dir_entry *dir;
> +	struct cache_entry *ce;
> +
> +	read_cache();
> +	if (single) {
> +		test_lazy_init_name_hash(&the_index, 0);
> +	} else {
> +		int nr_threads_used = test_lazy_init_name_hash(&the_index, 1);
> +		if (!nr_threads_used)
> +			die("non-threaded code path used");
> +	}
> +
> +	dir = hashmap_iter_first(&the_index.dir_hash, &iter_dir);
> +	while (dir) {
> +		printf("dir %08x %7d %s\n", dir->ent.hash, dir->nr, dir->name);
> +		dir = hashmap_iter_next(&iter_dir);
> +	}
> +
> +	ce = hashmap_iter_first(&the_index.name_hash, &iter_cache);
> +	while (ce) {
> +		printf("name %08x %s\n", ce->ent.hash, ce->name);
> +		ce = hashmap_iter_next(&iter_cache);
> +	}
> +
> +	discard_cache();
> +}
> +
> +/*
> + * Run the single or multi threaded version "count" times and
> + * report on the time taken.
> + */
> +uint64_t time_runs(int try_threaded)

static uint64_t time_runs(int try_threaded)

> +{
> +	uint64_t t0, t1, t2;
> +	uint64_t sum = 0;
> +	uint64_t avg;
> +	int nr_threads_used;
> +	int i;
> +
> +	for (i = 0; i < count; i++) {
> +		t0 = getnanotime();
> +		read_cache();
> +		t1 = getnanotime();
> +		nr_threads_used = test_lazy_init_name_hash(&the_index, try_threaded);
> +		t2 = getnanotime();
> +
> +		sum += (t2 - t1);
> +
> +		if (try_threaded && !nr_threads_used)
> +			die("non-threaded code path used");
> +
> +		if (nr_threads_used)
> +			printf("%f %f %d multi %d\n",
> +				   ((double)(t1 - t0))/1000000000,
> +				   ((double)(t2 - t1))/1000000000,
> +				   the_index.cache_nr,
> +				   nr_threads_used);
> +		else
> +			printf("%f %f %d single\n",
> +				   ((double)(t1 - t0))/1000000000,
> +				   ((double)(t2 - t1))/1000000000,
> +				   the_index.cache_nr);
> +		fflush(stdout);
> +
> +		discard_cache();
> +	}
> +
> +	avg = sum / count;
> +	if (count > 1)
> +		printf("avg %f %s\n",
> +			   (double)avg/1000000000,
> +			   (try_threaded) ? "multi" : "single");
> +
> +	return avg;
> +}
> +
> +/*
> + * Try a series of runs varying the "istate->cache_nr" and
> + * try to find a good value for the multi-threaded criteria.
> + */
> +void analyze_run(void)

static void analyze_run(void)

> +{
> +	uint64_t t1s, t1m, t2s, t2m;
> +	int cache_nr_limit;
> +	int nr_threads_used;
> +	int i;
> +	int nr;
> +
> +	read_cache();
> +	cache_nr_limit = the_index.cache_nr;
> +	discard_cache();
> +
> +	nr = analyze;
> +	while (1) {
> +		uint64_t sum_single = 0;
> +		uint64_t sum_multi = 0;
> +		uint64_t avg_single;
> +		uint64_t avg_multi;
> +
> +		if (nr > cache_nr_limit)
> +			nr = cache_nr_limit;
> +
> +		for (i = 0; i < count; i++) {
> +			read_cache();
> +			the_index.cache_nr = nr; /* cheap truncate of index */
> +			t1s = getnanotime();
> +			test_lazy_init_name_hash(&the_index, 0);
> +			t2s = getnanotime();
> +			sum_single += (t2s - t1s);
> +			the_index.cache_nr = cache_nr_limit;
> +			discard_cache();
> +
> +			read_cache();
> +			the_index.cache_nr = nr; /* cheap truncate of index */
> +			t1m = getnanotime();
> +			nr_threads_used = test_lazy_init_name_hash(&the_index, 1);
> +			t2m = getnanotime();
> +			sum_multi += (t2m - t1m);
> +			the_index.cache_nr = cache_nr_limit;
> +			discard_cache();
> +
> +			if (!nr_threads_used)
> +				printf("    [size %8d] [single %f]   non-threaded code path used\n",
> +					   nr, ((double)(t2s - t1s))/1000000000);
> +			else
> +				printf("    [size %8d] [single %f] %c [multi %f %d]\n",
> +					   nr,
> +					   ((double)(t2s - t1s))/1000000000,
> +					   (((t2s - t1s) < (t2m - t1m)) ? '<' : '>'),
> +					   ((double)(t2m - t1m))/1000000000,
> +					   nr_threads_used);
> +			fflush(stdout);
> +		}
> +		if (count > 1) {
> +			avg_single = sum_single / count;
> +			avg_multi = sum_multi / count;
> +			if (!nr_threads_used)
> +				printf("avg [size %8d] [single %f]\n",
> +					   nr,
> +					   (double)avg_single/1000000000);
> +			else
> +				printf("avg [size %8d] [single %f] %c [multi %f %d]\n",
> +					   nr,
> +					   (double)avg_single/1000000000,
> +					   (avg_single < avg_multi ? '<' : '>'),
> +					   (double)avg_multi/1000000000,
> +					   nr_threads_used);
> +			fflush(stdout);
> +		}
> +
> +		if (nr >= cache_nr_limit)
> +			return;
> +		nr += analyze_step;
> +	}
> +}

ATB,
Ramsay Jones

